unit BusObjClient;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 09/05/05  1.00.00 IJB  Initial version.
 03/10/05  1.00.01 IJB  Modified TClient.GetParentClient to return nil if
                        matches self.ID ParentID
 20/10/05  1.00.02 IJB  Added TTerms.
 24/10/05  1.00.03 IJB  Added DefaultClass to TClient.
 13/03/06  1.00.12 BJ   Properties added for tha shipping address
 25/05/06  1.00.13 BJ   new properties for client's address, shipto etc.
 19/06/06  1.00.14 AL   added Property InvoiceComment; Property InvoiceCommentPopUp
 19/07/06  1.00.15 BJ   XML importing exporting Implemented - field properties are
                        added for all the fields
                        All the field properties are added in TClients and the descendant's
                        SAveToXML and LoadFromXML is only taking the relevant fields for the
                        class
  ------------------------------------------------------------------------------
    Object Hierarchy

    TClient
       |
       |-- TSupplier
       |
       |-- TCustomer
       |
       |-- TJob
       |
       |-- TOtherContact

  ------------------------------------------------------------------------------
}

interface

uses classes, BusObjBase, BusObjTaxCodes, BusObjClass, db,  BusObjcommon,
  XMLDoc, XMLIntf, ERPdbComponents ,BusObjShippingAgent, MyAccess,
  BusObjSalesLinesPoints, BusObjContact, Busobjcustomfields,
  busobjclienttaxexceptionproducts, BusObjPicture, BusObjCoreEDIConfig,
  BusObjManufacture, BusObjModel, busobjShippingAddress, JSONObject, BusObjAttachment;

type

  TSource = class(TMSBusObj)
  private
    function GetMediaType       : string    ;
    function GetActive          : Boolean   ;
    function GetShowingoogle    : Boolean   ;
    function GetCreationDate    : TDateTime ;
    function GetInactiveDate    : TDateTime ;
    function GetEnquires        : Integer   ;
    function GetCost            : Double    ;
    function GetAccountID       : Integer   ;
    procedure SetMediaType       (const Value: string    );
    procedure SetActive          (const Value: Boolean   );
    procedure SetShowingoogle    (const Value: Boolean   );
    procedure SetCreationDate    (const Value: TDateTime );
    procedure SetInactiveDate    (const Value: TDateTime );
    procedure SetEnquires        (const Value: Integer   );
    procedure SetCost            (const Value: Double    );
    procedure SetAccountID       (const Value: Integer   );
    function GetAccountName: string;
    procedure SetAccountName(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    procedure InitializeNewObject; override;
  public
    procedure DoFieldOnChange(Sender: TField);                           override;
    constructor      Create(AOwner: TComponent);                         override;
    destructor       Destroy;                                            override;
    procedure        LoadFromXMLNode(const node: IXMLNode);              override;
    procedure        SaveToXMLNode(const node: IXMLNode);                override;
    function         ValidateData: Boolean;                              override;
    function         Save: Boolean;                                      override;
    procedure New; override;
    Class function   GetIDField              : string;                   override;
    Class function   GetKeyStringField       : string;                   override;
    Class function   GetBusObjectTablename   : string;                   override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    Class Function MakeSource(aOwner:TComponent ;aSource: String; aConnection :TERPConnection= nil; CreateifnotExists:Boolean =False): Integer;

  published
    property MediaType        :string      Read GetMediaType      write SetMediaType   ;
    property Active           :Boolean     Read GetActive         write SetActive      ;
    property Showingoogle     :Boolean     Read GetShowingoogle   write SetShowingoogle;
    property CreationDate     :TDateTime   Read GetCreationDate   write SetCreationDate;
    property InactiveDate     :TDateTime   Read GetInactiveDate   write SetInactiveDate;
    property Enquires         :Integer     Read GetEnquires       write SetEnquires    ;
    property Cost             :Double      Read GetCost           write SetCost        ;
    property AccountID        :Integer     Read GetAccountID      write SetAccountID   ;
    property AccountName: string Read GetAccountName write SetAccountName;
  end;

  TCustomerEquipment = class(TbusobjPicture)
  private
    fbIsTransferingtoAnotehrclient: boolean;
    function GetEquipmentid: Integer;
    function GetNotes: string;
    function GetClientid: Integer;
    function GetDescription: string;
    function GetEquipname: string;
    procedure SetEquipmentid(const Value: Integer);
    procedure SetNotes(const Value: string);
    procedure SetClientid(const Value: Integer);
    procedure SetDescription(const Value: string);
    procedure SetEquipname(const Value: string);
    function getmanufacture: String;
    function getModel: String;
    function getQuantity: double;
    function getRegistration: String;
    function getSerialno: String;
    function getWarantyFinishDate: TDatetime;
    function getWarantyPeriod: Double;
    procedure Setmanufacture(const Value: String);
    procedure SetModel(const Value: String);
    procedure SetQuantity(const Value: Double);
    procedure SetRegistration(const Value: String);
    procedure SetSerialno(const Value: String);
    procedure SetWarantyFinishDate(const Value: TDatetime);
    procedure SetWarantyPeriod(const Value: Double);
    function getUOM: String;
    function getUOMID: Integer;
    function GetUOMMultiplier: double;
    function GetUOMQty: Double;
    procedure setUOM(const Value: String);
    procedure setUOMID(const Value: Integer);
    procedure setUOMMultiplier(const Value: double);
    procedure setUOMQty(const Value: Double);
    function getWarantyStartDate: TDatetime;
    function getServiceDueDate: TDatetime;
    procedure setWarantyStartDate(const Value: TDatetime);
    procedure setServiceDueDate(const Value: TDatetime);
    function GetActive: boolean;
    function GetCustFld1: string;
    function GetCustFld10: string;
    function GetCustFld2: string;
    function GetCustFld3: string;
    function GetCustFld4: string;
    function GetCustFld5: string;
    function GetCustFld6: string;
    function GetCustFld7: string;
    function GetCustFld8: string;
    function GetCustFld9: string;
    procedure SetActive(const Value: boolean);
    procedure SetCustFld1(const Value: string);
    procedure SetCustFld10(const Value: string);
    procedure SetCustFld2(const Value: string);
    procedure SetCustFld3(const Value: string);
    procedure SetCustFld4(const Value: string);
    procedure SetCustFld5(const Value: string);
    procedure SetCustFld6(const Value: string);
    procedure SetCustFld7(const Value: string);
    procedure SetCustFld8(const Value: string);
    procedure SetCustFld9(const Value: string);
    function GetCustomerName: string;
    procedure SetCustomerName(const Value: string);
    function GetUOMNameProductKey: string;
    procedure SetUOMNameProductKey(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function ValidateXMLData(const node: IXMLNode): Boolean; override;
  public
    procedure DoFieldOnChange(Sender: TField); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    function LocateProduct(const ProductID:Integer; const ProductName:String; const fsUOM:String;const createnewifnotfound:Boolean; const SerialNumber :String = ''):Boolean;
    function CreateEquipment(const ProductID:Integer; const ProductName:String; fsSerialNumber:String):Integer;
    function getHeaderclientId:Integer;
    class function EquipmentNameForId(aId: integer; Conn: TCustomMyConnection = nil): string;
    class function _Schema: string; override;
    Property IsTransferingtoAnotehrclient:boolean Read fbIsTransferingtoAnotehrclient write fbIsTransferingtoAnotehrclient ;
    function Picturefieldname:String;Override;
    function Picturetypefieldname:String;Override;
  published
    property EquipmentID: Integer Read getEquipmentid write SetEquipmentid;
    property EquipName: string Read getEquipname write SetEquipname;
    property Notes: string Read getNotes write SetNotes;
    property ClientID: Integer Read getClientid write SetClientid;
    property ClientName: string Read GetCustomerName write SetCustomerName;
    property Description: string Read getDescription write SetDescription;
    property Manufacture :String Read getmanufacture Write Setmanufacture;
    property Model :String Read getModel Write SetModel;
    property SerialNo :String Read getSerialno Write SetSerialno;
    property Registration :String Read getRegistration Write SetRegistration;
    property WarantyPeriod :Double Read getWarantyPeriod Write SetWarantyPeriod;
    property WarantyFinishDate :TDatetime Read getWarantyFinishDate Write SetWarantyFinishDate;
    property Quantity :Double Read getQuantity Write SetQuantity;
    property UOMNameProductKey: string Read GetUOMNameProductKey write SetUOMNameProductKey;
    property UOM :String Read getUOM Write setUOM;
    property UOMID:Integer Read getUOMID Write setUOMID;
    property UOMMultiplier:double Read GetUOMMultiplier Write setUOMMultiplier;
    property UOMQty:Double Read GetUOMQty Write setUOMQty;
    Property WarantyStartDate : TDatetime Read getWarantyStartDate Write setWarantyStartDate;
    Property ServiceDueDate : TDatetime Read getServiceDueDate Write setServiceDueDate;
    property Active: boolean Read GetActive write SetActive;
    property CustFld1: string Read GetCustFld1 write SetCustFld1;
    property CustFld2: string Read GetCustFld2 write SetCustFld2;
    property CustFld3: string Read GetCustFld3 write SetCustFld3;
    property CustFld4: string Read GetCustFld4 write SetCustFld4;
    property CustFld5: string Read GetCustFld5 write SetCustFld5;
    property CustFld6: string Read GetCustFld6 write SetCustFld6;
    property CustFld7: string Read GetCustFld7 write SetCustFld7;
    property CustFld8: string Read GetCustFld8 write SetCustFld8;
    property CustFld9: string Read GetCustFld9 write SetCustFld9;
    property CustFld10: string Read GetCustFld10 write SetCustFld10;
  end;

  TCustomerShippingOptions = class(TMSBusObj)
  private
    function GetCustomerID                 : Integer   ;
    function GetShipperType                : string    ;
    function GetPackageProvider            : string    ;
    function GetPayorType                  : string    ;
    function GetAccountNumber              : string    ;
    function GetIsDefault                  : Boolean   ;
    function GetActive                     : Boolean   ;
    procedure SetCustomerID                 (const Value: Integer   );
    procedure SetShipperType                (const Value: string    );
    procedure SetPackageProvider            (const Value: string    );
    procedure SetPayorType                  (const Value: string    );
    procedure SetAccountNumber              (const Value: string    );
    procedure SetIsDefault                  (const Value: Boolean   );
    procedure SetActive                     (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
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
    property CustomerID                  :Integer     read GetCustomerID                write SetCustomerID             ;
    property ShipperType                 :string      read GetShipperType               write SetShipperType            ;
    property PackageProvider             :string      read GetPackageProvider           write SetPackageProvider        ;
    property PayorType                   :string      read GetPayorType                 write SetPayorType              ;
    property AccountNumber               :string      read GetAccountNumber             write SetAccountNumber          ;
    property IsDefault                   :Boolean     read GetIsDefault                 write SetIsDefault              ;
    property Active                      :Boolean     read GetActive                    write SetActive                 ;
  end;

  TClients_eParcel = class(TMSBusObj)
  private
    function GetClientID                  : Integer   ;
    function GetconsigneePhoneonLabel        : Boolean   ;
    function GetLeaveAtAddress               : Boolean   ;
    function GetSignatureReqd                : Boolean   ;
    function GetExtraDeliveryInstructions    : string    ;
    function GetChargeBackAcntID             : Integer   ;
    function GetChargeBackAcnt               : string    ;
    function GeteParcelreference1         : string    ;
    function GeteParcelreference2         : string    ;
    function GetPrinteParcelreference1    : Boolean   ;
    function GetPrinteParcelreference2    : Boolean   ;
    function GetReturn_Company            : string    ;
    function GetReturn_Name               : string    ;
    function GetReturn_Street1            : string    ;
    function GetReturn_Street2            : string    ;
    function GetReturn_Street3            : string    ;
    function GetReturn_Suburb             : string    ;
    function GetReturn_State              : string    ;
    function GetReturn_Country            : string    ;
    function GetReturn_Postcode           : string    ;
    function GetReDir_Company             : string    ;
    function GetReDir_Name                : string    ;
    function GetReDir_Street1             : string    ;
    function GetReDir_Street2             : string    ;
    function GetReDir_Street3             : string    ;
    function GetReDir_Suburb              : string    ;
    function GetReDir_State               : string    ;
    function GetReDir_Country             : string    ;
    function GetReDir_Postcode            : string    ;
    function GetEmailNotification         : string    ;
    procedure SetClientID                  (const Value: Integer   );
    procedure SetconsigneePhoneonLabel        (const Value: Boolean   );
    procedure SetLeaveAtAddress               (const Value: Boolean   );
    procedure SetSignatureReqd                (const Value: Boolean   );
    procedure SetExtraDeliveryInstructions    (const Value: string    );
    procedure SetChargeBackAcntID             (const Value: Integer   );
    procedure SetChargeBackAcnt               (const Value: string    );
    procedure SeteParcelreference1         (const Value: string    );
    procedure SeteParcelreference2         (const Value: string    );
    procedure SetPrinteParcelreference1    (const Value: Boolean   );
    procedure SetPrinteParcelreference2    (const Value: Boolean   );
    procedure SetReturn_Company            (const Value: string    );
    procedure SetReturn_Name               (const Value: string    );
    procedure SetReturn_Street1            (const Value: string    );
    procedure SetReturn_Street2            (const Value: string    );
    procedure SetReturn_Street3            (const Value: string    );
    procedure SetReturn_Suburb             (const Value: string    );
    procedure SetReturn_State              (const Value: string    );
    procedure SetReturn_Country            (const Value: string    );
    procedure SetReturn_Postcode           (const Value: string    );
    procedure SetReDir_Company             (const Value: string    );
    procedure SetReDir_Name                (const Value: string    );
    procedure SetReDir_Street1             (const Value: string    );
    procedure SetReDir_Street2             (const Value: string    );
    procedure SetReDir_Street3             (const Value: string    );
    procedure SetReDir_Suburb              (const Value: string    );
    procedure SetReDir_State               (const Value: string    );
    procedure SetReDir_Country             (const Value: string    );
    procedure SetReDir_Postcode            (const Value: string    );
    procedure SetEmailNotification         (const Value: string    );
    function getClients_eParcel: TClients_eParcel;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
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
    Property  Clients_eParcel : TClients_eParcel Read getClients_eParcel;
  published
    property ClientID                   :Integer     Read GetClientID                 write SetClientID              ;
    property consigneePhoneonLabel         :Boolean     Read GetconsigneePhoneonLabel       write SetconsigneePhoneonLabel    ;
    property LeaveAtAddress                :Boolean     Read GetLeaveAtAddress              write SetLeaveAtAddress           ;
    property SignatureReqd                 :Boolean     Read GetSignatureReqd               write SetSignatureReqd            ;
    property ExtraDeliveryInstructions     :string      Read GetExtraDeliveryInstructions   write SetExtraDeliveryInstructions;
    property ChargeBackAcntID              :Integer     Read GetChargeBackAcntID            write SetChargeBackAcntID         ;
    property ChargeBackAcnt                :string      Read GetChargeBackAcnt              write SetChargeBackAcnt           ;
    property eParcelreference1          :string      Read GeteParcelreference1        write SeteParcelreference1     ;
    property eParcelreference2          :string      Read GeteParcelreference2        write SeteParcelreference2     ;
    property PrinteParcelreference1     :Boolean     Read GetPrinteParcelreference1   write SetPrinteParcelreference1;
    property PrinteParcelreference2     :Boolean     Read GetPrinteParcelreference2   write SetPrinteParcelreference2;
    property Return_Company             :string      Read GetReturn_Company           write SetReturn_Company        ;
    property Return_Name                :string      Read GetReturn_Name              write SetReturn_Name           ;
    property Return_Street1             :string      Read GetReturn_Street1           write SetReturn_Street1        ;
    property Return_Street2             :string      Read GetReturn_Street2           write SetReturn_Street2        ;
    property Return_Street3             :string      Read GetReturn_Street3           write SetReturn_Street3        ;
    property Return_Suburb              :string      Read GetReturn_Suburb            write SetReturn_Suburb         ;
    property Return_State               :string      Read GetReturn_State             write SetReturn_State          ;
    property Return_Country             :string      Read GetReturn_Country           write SetReturn_Country        ;
    property Return_Postcode            :string      Read GetReturn_Postcode          write SetReturn_Postcode       ;
    property ReDir_Company              :string      Read GetReDir_Company            write SetReDir_Company         ;
    property ReDir_Name                 :string      Read GetReDir_Name               write SetReDir_Name            ;
    property ReDir_Street1              :string      Read GetReDir_Street1            write SetReDir_Street1         ;
    property ReDir_Street2              :string      Read GetReDir_Street2            write SetReDir_Street2         ;
    property ReDir_Street3              :string      Read GetReDir_Street3            write SetReDir_Street3         ;
    property ReDir_Suburb               :string      Read GetReDir_Suburb             write SetReDir_Suburb          ;
    property ReDir_State                :string      Read GetReDir_State              write SetReDir_State           ;
    property ReDir_Country              :string      Read GetReDir_Country            write SetReDir_Country         ;
    property ReDir_Postcode             :string      Read GetReDir_Postcode           write SetReDir_Postcode        ;
    property EmailNotification          :string      Read GetEmailNotification        write SetEmailNotification     ;
  end;

  TJob = class;

  TClient = class(TMSBusObj)
  private 
    fiMedTypeID: Integer;
    fiTermsID: Integer;
    fiRepNameID: Integer;
    fiParentClientID: Integer;
    fiParentRelatedClientID: Integer;
    fiCompanyTypeID: Integer;
    FIclientTypeID: Integer;
    fiPickingPriority: Integer;

    fsPrimaryContactName:String;
    fiPrimarycontactId:Integer;
    fiMainContactIDforCashSale  :Integer ;
    fiMainContactIDforVoucher   :Integer ;
    fiMainContactIDforPOS       :Integer ;
    fiMainContactIDforRefund    :Integer ;
    fiMainContactIDforInvoice   :Integer ;
    fiMainContactIDforSalesOrder:Integer ;
    fiMainContactIDforStatements:Integer ;
    fiMainContactIDforQuote     :Integer ;
    fiMainContactIDforCheque    :Integer ;
    fiMainContactIDforCredit    :Integer ;
    fiMainContactIDforBill      :Integer ;
    fiMainContactIDforPO        :Integer ;
    fiMainContactIDforRA        :Integer ;
    fiMainContactIDforRepair    :Integer ;
    fiMainContactIDforSupplierPayment    :Integer ;

    fiDisabledMainContactIDforCashSale  :Integer ;
    fiDisabledMainContactIDforVoucher   :Integer ;
    fiDisabledMainContactIDforPOS       :Integer ;
    fiDisabledMainContactIDforRefund    :Integer ;
    fiDisabledMainContactIDforInvoice   :Integer ;
    fiDisabledMainContactIDforSalesOrder:Integer ;
    fiDisabledMainContactIDforStatements:Integer ;
    fiDisabledMainContactIDforQuote     :Integer ;
    fiDisabledMainContactIDforCheque    :Integer ;
    fiDisabledMainContactIDforCredit    :Integer ;
    fiDisabledMainContactIDforBill      :Integer ;
    fiDisabledMainContactIDforPO        :Integer ;
    fiDisabledMainContactIDforRA        :Integer ;
    fiDisabledMainContactIDforRepair    :Integer ;
    fiDisabledMainContactIDforSupplierPayment    :Integer ;
    fsMakeMarketingcontact :String;

    function GetGroupDiscountOverridesAll: Boolean;
    function GetForcePOOnBooking: Boolean;
    function GetOtherContact: Boolean;
    function GetCustomer: Boolean;
    function GetSupplier: Boolean;
    function GetDontContact: Boolean;
    function GetRequired: Boolean;
    function GetSendXMLInvoices: Boolean;
    function GetSendXMLPOs: Boolean;
    function GetActive: Boolean;
    function GetInvComntPopUp: Boolean;
    function GetRepairCommentPopUpPopUp: Boolean;
    function GetPOCommentPopup: Boolean;
    function GetIsCustomer: Boolean;
    function GetIsJob: Boolean;
    function GetIsOtherContact: Boolean;
    function GetIsSupplier: Boolean;
    function GetStopCredit: Boolean;
    function GetForcePONumOnInvoice: Boolean;
    function GetUseCustomerInvoiceNo: Boolean;
    function GetWarrantyPeriod: Double;
    function GetHoursTakenForJob: Double;
    function GetAPBalance: Double;
    function GetSpecialDiscount: Double;
    function GetDefaultDelTemplateID: Integer;
    function GetDefaultInvTemplateID: Integer;
    function GetDefaultPOTemplateID: Integer;
    function GetParentRelatedClientID: Integer;
    function GetClientTypeId: Integer;
    function GetParentId: Integer;
    function GetRepId: Integer;
    function getShipTime: Integer;
    function GetCustomerNextInvoiceNo: Integer;
    function GetTaxID: Integer;
    function GetTermsId: Integer;
    function GetOtherContactType: Integer;
    function GetCompanyTypeId: Integer;
    function GetPickingPriority: Integer;
    function GetMedTypeID: Integer;
    function GetShippingID: Integer;
    function GetPayMethodID: Integer;
    function GetGracePeriod: Integer;
    function GetJobNumber: Integer;
    function GetArea: String;
    function Gethours: Double;
    function GetARBalance: Double;
    function GetBalance: Double;
    function GetCreditLimit: Double;
    function GetSalesOrderBalance: Double;
    function GetDiscount: Double;
    function GetURL: string;
    function GetTasks: string;
    function GetBankAccountBSB: string;
    function GetBankAccountName: string;
    function GetBankAccountNo: string;
    function GetCreditCardNotes: string;
    function GetCreditCardType: string;
    function GetDeliveryNotes: string;
    function GetJobRegistration: string;
    function GetSerialNumber: string;
    function GetFaxnumber: string;
    function GetAltcontact: string;
    function GetAltPhone: string;
    function GetClientNo: string;
    function GetCreditCardNumber: string;
    function GetCreditCardCVC: string;
    function GetCustomerJobNumber: string;
    function GetCombInvBOID: string;
    function GetPostCode: string;
    function GetRepName: string;
    function GetDefaultAPAccountID: Integer;
    function GetDefaultARAccountID: Integer;
    function GetDefaultARAccount: string;
    function GetDefaultAPAccount: string;
    function GetShippingMethodName: string;
    function getShiptoAddress: string;
    function GetState: string;
    function GetStreet: string;
    function GetStreet2: string;
    function GetStreet3: string;
    function GetSuburb: string;
    function GetStreetAddress: string;
    function GetStreetAddressWithName: string;
    Function  getClientDetails            : String;
    function getTermsName: string;
    function GetTitle: string;
    function GetABN: string;
    function GetCombSOBOID: string;
    function GetSpecialInstructions: string;
    function GetFECode: string;
    function GetBillCountry: string;
    function GetBillingAddress: string;
    function GetBillingAddressWithName: string;
    function GetBillPostCode: string;
    function GetCountry: string;
    function GetFirstName: string;
    function getInvComment: string;
    function getrepairComment: string;
    function getPOComment: string;
    function GetLastName: string;
    function GetMiddleName: string;
    function GetPhone: string;
    function GetBillState: string;
    function GetBillStreet: string;
    function GetBillStreet2: string;
    function GetBillStreet3: string;
    function GetBillSuburb: string;
    function GetClassName: string;
    function getClientAddress: string;
    function GetClientName: string;
    function GetPrintName: string;
    function GetCUSTFLD1: string;
    function GetCUSTFLD2: string;
    function GetCUSTFLD3: string;
    function GetCUSTFLD4: string;
    function GetCUSTFLD5: string;
    function GetCreditCardHolderName: string;
    function GetCreditCardExpiryDate: string;
    function GetDefaultContactMethod: string;
    function GetCUSTFLD6: string;
    function GetCUSTFLD7: string;
    function GetCUSTFLD8: string;
    function GetCUSTFLD9: string;
    function GetCUSTFLD10: string;
    function GetCUSTFLD11: string;
    function GetCUSTFLD12: string;
    function GetCUSTFLD13: string;
    function GetCUSTFLD14: string;
    function GetCUSTFLD15: string;
    function GetBankCode: string;
    function GetCardNumber: string;
    function GetJobTitle: string;
    function GetModelNumber: string;
    function GetManufactureName: string;
    function GetEmailXML: string;
    function GetEmailPOXML: string;
    function GetMobile: string;
    function GetEmail: string;
    function GetNotes: string;
    function GetJobName: string;
    function Getprintjobname: string;
    function GetWarrantyFinishDate: TDateTime;
    function GetApprovalFromDate: TDateTime;
    function GetPhonesupportTill: TDateTime;
    function GetReminderDateTime: TDateTime;
    function GetApprovalToDate: TDateTime;
    function GetCompletionDate: TDateTime;
    function GetCreationDate: TDateTime;
    function GetDateEntered: TDateTime;
    function GetDateInactive: TDateTime;
    function GetDischargeDate: TDateTime;
    function GetExpiryDate: TDateTime;
    function GetUpdateDate: TDateTime;
    function GetCUSTDATE1: TDateTime;
    function GetCUSTDATE2: TDateTime;
    function GetCUSTDATE3: TDateTime;
    function GetAction: TDateTime;
    function GetClientType: TClientType;
    function GetDefaultClass: TDeptClass;
    function GetParentClient: TClient;
    function GetTaxCode: TTaxCode;
    function GetTerms: TTerms;
    function GetShippingMethod: TShippingMethod;
    function GetOtherFollowUps: TOtherFollowUps;
    function GetGroupDiscounts: TProductGroupDiscount;
    function GetSpecialProducts: TSpecialProducts;
    Function GetApptcount(Countuntil :TDatetime):Integer;
    function GetStatus: string;

    procedure SetBalance(const Value: Double);
    procedure SetBillCountry(const Value: string);
    procedure SetBillPostcode(const Value: string);
    procedure SetPhone(const Value: string);
    procedure SetBillState(const Value: string);
    procedure SetBillStreet(const Value: string);
    procedure SetBillStreet2(const Value: string);
    procedure SetBillStreet3(const Value: string);
    procedure SetBillSuburb(const Value: string);
    procedure SetClassName(const Value: string);
    procedure SetClientName(const Value: string);
    procedure SetPrintName(const Value: string);
    procedure SetClientTypeId(const Value: Integer);
    procedure SetCountry(const Value: string);
    procedure SetPostcode(const Value: string);
    procedure SetFirstName(const Value: string);
    procedure SetFECode(const Value: string);
    procedure SetInvoiceComment(const Value: string);
    procedure SetrepairComment(const Value: string);
    procedure SetInvoiceCommentPopUp(const Value: Boolean);
    procedure SetRepairCommentPopUp(const Value: Boolean);
    procedure SetPOComment(const Value: string);
    procedure SetPOCommentPopup(const Value: Boolean);
    procedure SetIsCustomer(const Value: Boolean);
    procedure SetIsJob(const Value: Boolean);
    procedure SetIsOtherContact(const Value: Boolean);
    procedure SetIsSupplier(const Value: Boolean);
    procedure SetLastName(const Value: string);
    procedure SetMiddleName(const Value: string);
    procedure SetParentClientId(const Value: Integer);
    procedure SetRepId(const Value: Integer);
    procedure SetRepName(const Value: string);
    procedure SetDefaultAPAccountID(const Value: Integer);
    procedure SetDefaultARAccountID(const Value: Integer);
    procedure SetDefaultARAccount(const Value: string);
    procedure SetDefaultAPAccount(const Value: string);
    procedure SetShippingMethodName(const Value: string);
    procedure SetShipTime(const Value: Integer);
    procedure SetState(const Value: string);
    procedure SetStopCredit(const Value: Boolean);
    procedure SetStreet(const Value: string);
    procedure SetStreet2(const Value: string);
    procedure SetStreet3(const Value: string);
    procedure SetSuburb(const Value: string);
    procedure SetTaxID(const Value: Integer);
    procedure SetTermsID(const Value: Integer);
    procedure SetTermsName(const Value: string);
    procedure SetTitle(const Value: string);
    procedure SetABN(const Value: string);
    procedure SetCreditLimit(const Value: Double);
    procedure SetSalesOrderBalance(const Value: Double);
    procedure SetWarrantyFinishDate(const Value: TDateTime);
    procedure SetCombInvBOID(const Value: string);
    procedure SetCombSOBOID(const Value: string);
    procedure SetForcePONumOnInvoice(const Value: Boolean);
    procedure SetCustomerNextInvoiceNo(const Value: Integer);
    procedure SetUseCustomerInvoiceNo(const Value: Boolean);
    procedure SetWarrantyPeriod(const Value: Double);
    procedure SetDefaultDelTemplateID(const Value: Integer);
    procedure SetDefaultInvTemplateID(const Value: Integer);
    procedure SetDefaultPOTemplateID(const Value: Integer);
    procedure SetGroupDiscountOverridesAll(const Value: Boolean);
    procedure SetCreditCardHolderName(const Value: string);
    procedure SetCreditCardExpiryDate(const Value: string);
    procedure SetDefaultContactMethod(const Value: string);
    procedure SetParentRelatedClientID(const Value: Integer);
    procedure SetForcePOOnBooking(const Value: Boolean);
    procedure SetHoursTakenForJob(const Value: Double);
    procedure SetOtherContactType(const Value: Integer);
    procedure SetCreditCardNumber(const Value: string);
    procedure SetCreditCardCVC(const Value: string);
    procedure SetCustomerJobNumber(const Value: string);
    procedure SetSpecialInstructions(const Value: string);
    procedure SetApprovalFromDate(const Value: TDateTime);
    procedure SetPhonesupportTill(const Value: TDateTime);
    procedure SetReminderDateTime(const Value: TDateTime);
    procedure SetOtherContact(const Value: Boolean);
    procedure SetAPBalance(const Value: Double);
    procedure SetSpecialDiscount(const Value: Double);
    procedure SetCompanyTypeId(const Value: Integer);
    procedure SetPickingPriority(const Value: Integer);
    procedure SetBankAccountBSB(const Value: string);
    procedure SetBankAccountName(const Value: string);
    procedure SetBankAccountNo(const Value: string);
    procedure SetCreditCardNotes(const Value: string);
    procedure SetCreditCardType(const Value: string);
    procedure SetDeliveryNotes(const Value: string);
    procedure SetJobRegistration(const Value: string);
    procedure SetSerialNumber(const Value: string);
    procedure SetApprovalToDate(const Value: TDateTime);
    procedure SetCompletionDate(const Value: TDateTime);
    procedure SetCreationDate(const Value: TDateTime);
    procedure SetDateEntered(const Value: TDateTime);
    procedure SetDateInactive(const Value: TDateTime);
    procedure SetDischargeDate(const Value: TDateTime);
    procedure SetExpiryDate(const Value: TDateTime);
    procedure SetCustomer(const Value: Boolean);
    procedure SetSupplier(const Value: Boolean);
    procedure SetDontContact(const Value: Boolean);
    procedure SetRequired(const Value: Boolean);
    procedure SetSendXMLInvoices(const Value: Boolean);
    procedure SetSendXMLPOs(const Value: Boolean);
    procedure SetARBalance(const Value: Double);
    procedure SetDiscount(const Value: Double);
    procedure SetMedTypeID(const Value: Integer);
    procedure SetShippingID(const Value: Integer);
    procedure SetPayMethodID(const Value: Integer);
    procedure SetGracePeriod(const Value: Integer);
    procedure SetJobNumber(const Value: Integer);
    procedure SetFaxnumber(const Value: string);
    procedure SetAltcontact(const Value: string);
    procedure SetAltPhone(const Value: string);
    procedure SetClientNo(const Value: string);
    procedure SetCUSTFLD1(const Value: string);
    procedure SetCUSTFLD2(const Value: string);
    procedure SetCUSTFLD3(const Value: string);
    procedure SetCUSTFLD4(const Value: string);
    procedure SetCUSTFLD5(const Value: string);
    procedure SetCUSTFLD6(const Value: string);
    procedure SetCUSTFLD7(const Value: string);
    procedure SetCUSTFLD8(const Value: string);
    procedure SetCUSTFLD9(const Value: string);
    procedure SetCUSTFLD10(const Value: string);
    procedure SetCUSTFLD11(const Value: string);
    procedure SetCUSTFLD12(const Value: string);
    procedure SetCUSTFLD13(const Value: string);
    procedure SetCUSTFLD14(const Value: string);
    procedure SetCUSTFLD15(const Value: string);
    procedure SetBankCode(const Value: string);
    procedure SetCardNumber(const Value: string);
    procedure SetJobTitle(const Value: string);
    procedure SetModelNumber(const Value: string);
    procedure SetManufactureName(const Value: string);
    procedure SetEmailXML(const Value: string);
    procedure SetEmailPOXML(const Value: string);
    procedure SetUpdateDate(const Value: TDateTime);
    procedure SetCUSTDATE1(const Value: TDateTime);
    procedure SetCUSTDATE2(const Value: TDateTime);
    procedure SetCUSTDATE3(const Value: TDateTime);
    procedure SetMobile(const Value: string);
    procedure SetEmail(const Value: string);
    procedure SetNotes(const Value: string);
    procedure SetJobName(const Value: string);
    procedure Setprintjobname(const Value: string);
    procedure SetAction(const Value: TDateTime);
    procedure SetActive(const Value: Boolean);
    procedure SetURL(const Value: string);
    procedure SetArea(const Value: String);
    procedure SetTasks(const Value: string);
    procedure Sethours(const Value: Double);
    procedure SetStatus(const Value: string);

    function GetCreditBalance: Double;
    function getForcePOOnRepair: Boolean;
    procedure setForcePOOnRepair(const Value: Boolean);
    function GetBPAYBillerCode: string;
    function GetBPAYReference: string;
    procedure SetBPAYBillerCode(const Value: string);
    procedure SetBPAYReference(const Value: string);
    function GetManufactureID: Integer;
    procedure SetManufactureID(const Value: Integer);
    function getSpecialProductPriceOverridesAll: Boolean;
    procedure SetSpecialProductPriceOverridesAll(const Value: Boolean);
    function getFinalDestination: String;
    function getIncoPlace: String;
    function getTeamviewerID: String;
    function getClientCode: String;
    function getSkypeName   : String;
    function getPortOfDischarge: String;
    function getPortOfLanding: String;
    procedure setFinalDestination(const Value: String);
    procedure setIncoPlace(const Value: String);
    procedure setTeamviewerID(const Value: String);
    procedure setClientCode(const Value: String);
    procedure setSkypeName(const Value: String);
    procedure setPortOfDischarge(const Value: String);
    procedure setPortOfLanding(const Value: String);
    function getShippingAgentID: Integer;
    procedure setShippingAgentID(const Value: Integer);
    function GetClientTypeName: string;
    procedure SetClientTypeName(const Value: string);
    function GetCompanyTypeName: string;
    procedure SetCompanyTypeName(const Value: string);
    function GetSourceName: string;
    procedure SetSourceName(const Value: string);
    function GetParentRelatedClientName: string;
    procedure SetParentRelatedClientName(const Value: string);
    function GetPaymentMethodName: string;
    procedure SetPaymentMethodName(const Value: string);
    function GetShippingAgentCode: string;
    procedure SetShippingAgentCode(const Value: string);
    function GetTaxCodeName: string;
    procedure SetTaxCodeName(const Value: string);
    function getCallPriority: Integer;
    procedure setCallPriority(const Value: Integer);
    function GetAssessorsName: string;
    function GetBodyType: string;
    function GetColour: string;
    function GetExcessAmount: double;
    function GetStormDate: TDateTime;
    function GetStormLocation: string;
    function GetYear: TDateTime;
    procedure SetAssessorsName(const Value: string);
    procedure SetBodyType(const Value: string);
    procedure SetColour(const Value: string);
    procedure SetExcessAmount(const Value: double);
    procedure SetStormDate(const Value: TDateTime);
    procedure SetStormLocation(const Value: string);
    procedure SetYear(const Value: TDateTime);
    function GetManufacture: TManufacture;
    function GetModel: TModel;
    function GetBailmentAmountEx: double;
    function GetBailmentNumber: string;
    function GetNewOrUsed: string;
    function GetStockReceivedDate: TDate;
    procedure SetBailmentAmountEx(const Value: double);
    procedure SetBailmentNumber(const Value: string);
    procedure SetNewOrUsed(const Value: string);
    procedure SetStockReceivedDate(const Value: TDate);
    function GetClientrCustomFieldValues: TClientCustomFieldValues;
    function GetClaimNumber: string;
    procedure SetClaimNumber(const Value: string);
    function GetIsInternal: boolean;
    procedure SetIsInternal(const Value: boolean);
    function getTypeofclientRec: String;
    function getPrimarycontactNAme: String;
    function getPrimarycontactId: Integer;
    function GetMainContactIDforCashSale  :Integer ;
    function GetMainContactIDforVoucher   :Integer ;
    function GetMainContactIDforPOS       :Integer ;
    function GetMainContactIDforRefund    :Integer ;
    function GetMainContactIDforInvoice   :Integer ;
    function GetMainContactIDforSalesOrder:Integer ;
    function GetMainContactIDforStatements:Integer ;
    function GetMainContactIDforQuote     :Integer ;
    function GetMainContactIDforCheque    :Integer ;
    function GetMainContactIDforCredit    :Integer ;
    function GetMainContactIDforBill      :Integer ;
    function GetMainContactIDforPO        :Integer ;
    function GetMainContactIDforRA        :Integer ;
    function GetMainContactIDforRepair    :Integer ;

    procedure MainContactCallBack(const Sender: TBusObj; var Abort: Boolean);
    function GetContacts: TContact;
    function GetFTPAddress: string;
    function GetFTPPassword: string;
    function GetFTPUserName: string;
    function GetSendFTPXMLInvoices: boolean;
    function GetSendFTPXMLPOs: boolean;
    procedure SetFTPAddress(const Value: string);
    procedure SetFTPPassword(const Value: string);
    procedure SetFTPUserName(const Value: string);
    procedure SetSendFTPXMLInvoices(const Value: boolean);
    procedure SetSendFTPXMLPOs(const Value: boolean);
    function GetDocumentPath: string;
    procedure SetDocumentPath(const Value: string);
    function getMainContactIDforSupplierPayment: Integer;
    function GetForcePOOnSalesOrder: boolean;
    procedure SetForcePOOnSalesOrder(const Value: boolean);
    function GetDefaultSOTemplateID: Integer;
    procedure SetDefaultSOTemplateID(const Value: Integer);
    function GetExternalRef: string;
    procedure SetExternalRef(const Value: string);
    function GetContractor: boolean;
    procedure SetContractor(const Value: boolean);
    function GetClientPaysShippment: boolean;
    function GetClientShipperAccountNo: string;
    procedure SetClientPaysShippment(const Value: boolean);
    procedure SetClientShipperAccountNo(const Value: string);
    Procedure MakeMarketingcontactCallback(const Sender: TBusObj; var Abort: Boolean);Overload;
    function GetCoreEDIConfig: BusObjCoreEDIConfig.TCoreEDIConfig;
    function GetAttachments: TAttachment;
    function GetPublishOnVS1: boolean;
    procedure SetPublishOnVS1(const Value: boolean);
    procedure SetLicenseRenewDurationType(const Value: string);
    function GetLicenseRenewDurationType: string;
    function GetLicenseRenewDuration: Integer;
    procedure SetLicenseRenewDuration(const Value: Integer);
    function getCompanyname: String;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    function ForeignKeysValid(const Node: IXMLNode): Boolean; override;
    function ValidateXMLData(const Node: IXMLNode): Boolean; override;
    function ExportsubClasses(const Node: IXMLNode): Boolean; override;
    function ImportsubClasses(const Node: IXMLNode): Boolean; override;
    Function  DoBeforePost(Sender :TDatasetBusObj ):Boolean; override;
    Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean; override;
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean; override;
    function GetParentClientName: string;
    procedure SetParentClientName(const Value: string);
    function getCustomerEquipment: TCustomerEquipment;
    property Attachments: TAttachment read GetAttachments;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DoFieldOnChange(Sender: TField); override;
    function Save: boolean; override;
    procedure SaveToXMLNode(const Node: IXMLNode); override;
    procedure LoadFromXMLNode(const Node: IXMLNode); override;
    function ValidateData: Boolean; override;
    Property Apptcount[Countuntil  :TDatetime]       :Integer Read getApptcount;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class function GetKeyStringField: string; override;
    class function CompanyExists(const aCompanyName: string; Conn: TERPConnection = nil): boolean;
    Class function MakeCustomerContact(const ClientID:Integer;AOwner:TComponent; fConnection :TERPConnection=nil):Integer;
    Function ConverttoMarketingcontact(var msg: string): integer;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    property ParentClient          :TClient          Read GetParentClient;
    class function ClientIsOtherCotact(const aCompanyName: string; Conn: TCustomMyConnection = nil): boolean;
    property TaxCode               :TTaxCode         Read GetTaxCode;
    property Terms                 :TTerms           Read GetTerms;
    property ClientType            :TClientType      Read getClientType;
    property DefaultClass          :TDeptClass       Read GetDefaultClass;
    property ShippingMethod        :TShippingMethod  Read getshippingMethod;
    property Manufacture           :TManufacture Read GetManufacture;
    Property TypeofclientRec       : String Read getTypeofclientRec;
    class function ClientStreetAddress(aClientName: string; Conn: TERPConnection = nil): string;
    class function ClientPhone(aClientName: string; Conn: TERPConnection = nil): string;
    Class Function ClientEmailAddress(aClientID:Integer; Conn :TERPConnection = nil):String;
    class function ClientIdForJobName(const aJobName: string; aParentClientId: integer = 0; Conn: TCustomMyConnection = nil): integer;
    class function DefaultSOTemplateName(const aClientID: integer; Conn: TCustomMyConnection = nil): string;
    class function ClientDefaultPOTemplateID(const aClientID: integer; Conn: TCustomMyConnection = nil): integer;

    Procedure MakeClientFromCmpanyInfo(CompInfo :TMsBusobj; aIsCustomer, aIsSupplier, aIsOthercontact:Boolean);
    Property PrimarycontactNAme         : String  Read getPrimarycontactName;
    Property PrimarycontactId           : Integer Read getPrimarycontactId;
    Property MainContactIDforCashSale   : Integer Read getMainContactIDforCashSale;
    Property MainContactIDforVoucher    : Integer Read getMainContactIDforVoucher;
    Property MainContactIDforPOS        : Integer Read getMainContactIDforPOS;
    Property MainContactIDforRefund     : Integer Read getMainContactIDforRefund;
    Property MainContactIDforInvoice    : Integer Read getMainContactIDforInvoice;
    Property MainContactIDforSalesOrder : Integer Read getMainContactIDforSalesOrder;
    Property MainContactIDforStatements : Integer Read getMainContactIDforStatements;
    Property MainContactIDforQuote      : Integer Read getMainContactIDforQuote;
    Property MainContactIDforCheque     : Integer Read getMainContactIDforCheque;
    Property MainContactIDforCredit     : Integer Read getMainContactIDforCredit;
    Property MainContactIDforBill       : Integer Read getMainContactIDforBill;
    Property MainContactIDforPO         : Integer Read getMainContactIDforPO;
    Property MainContactIDforRA         : Integer Read getMainContactIDforRA;
    Property MainContactIDforRepair     : Integer Read getMainContactIDforRepair;
    Property MainContactIDforSupplierPayment : Integer Read getMainContactIDforSupplierPayment;

    Property DisabledMainContactIDforCashSale   : Integer Read fiDisabledMainContactIDforCashSale;
    Property DisabledMainContactIDforVoucher    : Integer Read fiDisabledMainContactIDforVoucher;
    Property DisabledMainContactIDforPOS        : Integer Read fiDisabledMainContactIDforPOS;
    Property DisabledMainContactIDforRefund     : Integer Read fiDisabledMainContactIDforRefund;
    Property DisabledMainContactIDforInvoice    : Integer Read fiDisabledMainContactIDforInvoice;
    Property DisabledMainContactIDforSalesOrder : Integer Read fiDisabledMainContactIDforSalesOrder;
    Property DisabledMainContactIDforStatements : Integer Read fiDisabledMainContactIDforStatements;
    Property DisabledMainContactIDforQuote      : Integer Read fiDisabledMainContactIDforQuote;
    Property DisabledMainContactIDforCheque     : Integer Read fiDisabledMainContactIDforCheque;
    Property DisabledMainContactIDforCredit     : Integer Read fiDisabledMainContactIDforCredit;
    Property DisabledMainContactIDforBill       : Integer Read fiDisabledMainContactIDforBill;
    Property DisabledMainContactIDforPO         : Integer Read fiDisabledMainContactIDforPO;
    Property DisabledMainContactIDforRA         : Integer Read fiDisabledMainContactIDforRA;
    Property DisabledMainContactIDforRepair     : Integer Read fiDisabledMainContactIDforRepair;
    Property DisabledMainContactIDforSupplierPayment: Integer Read fiDisabledMainContactIDforSupplierPayment;
    function ClientPrintName(NewLineBefore :Boolean =False; NewLineAfter:Boolean =False; HidewhensamecleintName:Boolean =True):String;
    Class function ClientPrintnameToggle(const aclientID: Integer; Connection: TCustomMyConnection=nil): string;
    Class function CmpanyInfoClientID(AOwner:TComponent; aIsCustomer, aIsSupplier, aIsOthercontact:Boolean):Integer;
    Function DoMakePrimaryContact:Integer;
    property Contractor: boolean Read GetContractor write SetContractor;
    Class Procedure MakeMarketingcontact(AOwner:Tcomponent;aConnection :TERPConnection; aBusObjEvent: TBusObjEvent ; aClientID:Integer);Overload;
    Procedure MakeMarketingcontact(DoInTransaction :Boolean);Overload;
    //Class Function MakeSuppleir(AOwner:TComponent; aSuppleirname:String):Integer;
    property CoreEDIConfig: BusObjCoreEDIConfig.TCoreEDIConfig read GetCoreEDIConfig;
    function DoMakeclient(AOwner:TComponent; aClientName: String;CreateifnotExists:Boolean =False; aSource:String = ''): Integer;Overload;
    function DoMakeclient(AOwner:TComponent; aClientName: String;aSource:String = ''): Boolean;Overload;
    function DoMakeMagentoclient(AOwner:TComponent; aFirstname, aLastname, aEmail: String;aSource:String = ''): Boolean;
    Class function DoMakeclientRec(AOwner:TComponent; conn :TMyDacDataConnection; aFirstname, aLastname, aEmailID: String;aisCustomer,aIsSupplier,aIsOthercontact:boolean ; CreateifnotExists:Boolean =False; aSource:String = ''): Integer;
  published
    property IsSupplier                       :Boolean         Read GetIsSupplier                       Write SetIsSupplier;
    property IsCustomer                       :Boolean         Read GetIsCustomer                       Write SetIsCustomer;
    property IsOtherContact                   :Boolean         Read GetIsOtherContact                   Write SetIsOtherContact;
    property Active                           :Boolean         Read GetActive                           Write SetActive;
    property IsJob                            :Boolean         Read GetIsJob                            Write SetIsJob;
    property IsInternal                       :boolean         Read GetIsInternal                       Write SetIsInternal;
    property StopCredit                       :Boolean         Read GetStopCredit                       Write SetStopCredit;
    property ForcePONumOnInvoice              :Boolean         Read GetForcePONumOnInvoice              Write SetForcePONumOnInvoice;
    property ForcePOOnSalesOrder              :boolean         Read GetForcePOOnSalesOrder              Write SetForcePOOnSalesOrder;
    Property ForcePOOnRepair                  :Boolean         Read getForcePOOnRepair                  Write setForcePOOnRepair;
    property UseCustomerInvoiceNo             :Boolean         Read GetUseCustomerInvoiceNo             Write SetUseCustomerInvoiceNo;
    property InvoiceCommentPopUp              :Boolean         Read GetInvComntPopUp                    Write SetInvoiceCommentPopUp;
    property RepairCommentPopUp               :Boolean         Read GetRepairCommentPopUpPopUp          Write SetRepairCommentPopUp;
    property POCommentPopup                   :Boolean         Read GetPOCommentPopup                   Write SetPOCommentPopup;
    property GroupDiscountOverridesAll        :Boolean         Read GetGroupDiscountOverridesAll        Write SetGroupDiscountOverridesAll;
    Property SpecialProductPriceOverridesAll  :Boolean         Read getSpecialProductPriceOverridesAll  Write SetSpecialProductPriceOverridesAll;
    property ForcePOOnBooking                 :Boolean         Read GetForcePOOnBooking                 Write SetForcePOOnBooking;
    property OtherContact                     :Boolean         Read GetOtherContact                     Write SetOtherContact;
    property Customer                         :Boolean         Read GetCustomer                         Write SetCustomer;
    property Supplier                         :Boolean         Read GetSupplier                         Write SetSupplier;
    property DontContact                      :Boolean         Read GetDontContact                      Write SetDontContact;
    property Required                         :Boolean         Read GetRequired                         Write SetRequired;
    property SendXMLInvoices                  :Boolean         Read GetSendXMLInvoices                  Write SetSendXMLInvoices;
    property SendXMLPOs                       :Boolean         Read GetSendXMLPOs                       Write SetSendXMLPOs;
    property SendFTPXMLInvoices               :boolean         Read GetSendFTPXMLInvoices               Write SetSendFTPXMLInvoices;
    property SendFTPXMLPOs                    :boolean         Read GetSendFTPXMLPOs                    Write SetSendFTPXMLPOs;
    property FTPAddress                       :string          Read GetFTPAddress                       Write SetFTPAddress;
    property FTPUserName                      :string          Read GetFTPUserName                      Write SetFTPUserName;
    property FTPPassword                      :string          Read GetFTPPassword                      Write SetFTPPassword;
    property CreditLimit                      :Double          Read GetCreditLimit                      Write SetCreditLimit;
    property Balance                          :Double          Read GetBalance                          Write SetBalance;
    property SalesOrderBalance                :Double          Read GetSalesOrderBalance                Write SetSalesOrderBalance;
    property CreditBalance                    :Double          Read GetCreditBalance;
    property WarrantyPeriod                   :Double          Read GetWarrantyPeriod                   Write SetWarrantyPeriod;
    property HoursTakenForJob                 :Double          Read GetHoursTakenForJob                 Write SetHoursTakenForJob;
    property APBalance                        :Double          Read GetAPBalance                        Write SetAPBalance;
    property SpecialDiscount                  :Double          Read GetSpecialDiscount                  Write SetSpecialDiscount;
    property ARBalance                        :Double          Read GetARBalance                        Write SetARBalance;
    property Discount                         :Double          Read GetDiscount                         Write SetDiscount;
    property Hours                            :Double          Read Gethours                            Write Sethours;
    property ClientTypeId                     :Integer         Read getClientTypeID                     Write SetclientTypeID;
    property ClientTypeName                   :string          Read GetClientTypeName                   Write SetClientTypeName;
    property TaxID                            :Integer         Read GetTaxID                            Write SetTaxID;
    property TaxCodeName                      :string          Read GetTaxCodeName                      Write SetTaxCodeName;
    property TermsId                          :Integer         Read GetTermsId                          Write SetTermsID;
    property TermsName                        :string          Read getTermsName                        Write SetTermsname;
    property RepId                            :Integer         Read GetRepId                            Write SetRepId;
    property DefaultAPAccountID               :Integer         Read GetDefaultAPAccountID               Write SetDefaultAPAccountID;
    property DefaultARAccountID               :Integer         Read GetDefaultARAccountID               Write SetDefaultARAccountID;
    property RepName                          :string          Read GetRepName                          Write    SetRepName;
    property DefaultARAccount                 :string          Read GetDefaultARAccount                 Write SetDefaultARAccount;
    property DefaultAPAccount                 :string          Read GetDefaultAPAccount                 Write SetDefaultAPAccount;
    property ParentClientId                   :Integer         Read GetParentId                         Write SetParentClientId;
    property ParentClientName                 :string          Read GetParentClientName                 Write SetParentClientName;
    property DefaultInvTemplateID             :Integer         Read GetDefaultInvTemplateID             Write SetDefaultInvTemplateID;
    property DefaultSOTemplateID              :Integer         Read GetDefaultSOTemplateID              Write SetDefaultSOTemplateID;
    property DefaultDelTemplateID             :Integer         Read GetDefaultDelTemplateID             Write SetDefaultDelTemplateID;
    property DefaultPOTemplateID              :Integer         Read GetDefaultPOTemplateID              Write SetDefaultPOTemplateID;
    property CompanyTypeId                    :Integer         Read GetCompanyTypeId                    Write SetCompanyTypeId;
    property CompanyTypeName                  :string          Read GetCompanyTypeName                  Write SetCompanyTypeName;
    property MedTypeID                        :Integer         Read GetMedTypeID                        Write SetMedTypeID;
    property SourceName                       :string          Read GetSourceName                       Write SetSourceName;
    property ShippingID                       :Integer         Read GetShippingID                       Write SetShippingID;
    property ShippingMethodName               :string          Read GetShippingMethodName               Write SetShippingMethodName;
    property PayMethodID                      :Integer         Read GetPayMethodID                      Write SetPayMethodID;
    property PaymentMethodName                :string          Read GetPaymentMethodName                Write SetPaymentMethodName;
    property PickingPriority                  :Integer         Read GetPickingPriority                  Write SetPickingPriority;
    property GracePeriod                      :Integer         Read GetGracePeriod                      Write SetGracePeriod;
    property JobNumber                        :Integer         Read GetJobNumber                        Write SetJobNumber;
    property Area                             :String          Read GetArea                             Write SetArea;
    property ShipTime                         :Integer         Read getShipTime                         Write SetShipTime;
    property OtherContactType                 :Integer         Read GetOtherContactType                 Write SetOtherContactType;
    property CustomerNextInvoiceNo            :Integer         Read GetCustomerNextInvoiceNo            Write SetCustomerNextInvoiceNo;
    property ParentRelatedClientID            :Integer         Read GetParentRelatedClientID            Write SetParentRelatedClientID;
    property ParentRelatedClientName          :string          Read GetParentRelatedClientName          Write SetParentRelatedClientName;
    property CombinedInvoiceBOID              :string          Read GetCombInvBOID                      Write SetCombInvBOID;
    property CombinedSalesOrderBOID           :string          Read GetCombSOBOID                       Write SetCombSOBOID;
    property ForeignExchangeCode              :string          Read GetFECode                           Write SetFECode;
    property DefaultClassName                 :string          Read GetClassName                        Write SetClassName;
    property InvoiceComment                   :string          Read getInvComment                       Write SetInvoiceComment;
    property RepairComment                    :string          Read getrepairComment                    Write SetrepairComment;
    property POComment                        :string          Read getPOComment                        Write SetPOComment;
    property BillingAddressWithName           :string          Read GetBillingAddressWithName;
    property BillingAddress                   :string          Read GetBillingAddress;
    property StreetAddressWithName            :string          Read GetStreetAddressWithName;
    property StreetAddress                    :string          Read GetStreetAddress;
    Property ClientDetails                    :String          Read getClientDetails;
    property ClientAddress                    :string          Read getClientAddress;
    property ShipToAddress                    :string          Read getShiptoAddress;
    property CreditCardHolderName             :string          Read GetCreditCardHolderName             Write SetCreditCardHolderName;
    property CreditCardExpiryDate             :string          Read GetCreditCardExpiryDate             Write SetCreditCardExpiryDate;
    property DefaultContactMethod             :string          Read GetDefaultContactMethod             Write SetDefaultContactMethod;
    property CreditCardNumber                 :string          Read GetCreditCardNumber                 Write SetCreditCardNumber;
    property CreditCardCVC                    :string          Read GetCreditCardCVC                    Write SetCreditCardCVC;
    property CustomerJobNumber                :string          Read GetCustomerJobNumber                Write SetCustomerJobNumber;
    property SpecialInstructions              :string          Read GetSpecialInstructions              Write SetSpecialInstructions;
    property BankAccountBSB                   :string          Read GetBankAccountBSB                   Write SetBankAccountBSB;
    property BankAccountName                  :string          Read GetBankAccountName                  Write SetBankAccountName;
    property BankAccountNo                    :string          Read GetBankAccountNo                    Write SetBankAccountNo;
    property CreditCardNotes                  :string          Read GetCreditCardNotes                  Write SetCreditCardNotes;
    property CreditCardType                   :string          Read GetCreditCardType                   Write SetCreditCardType;
    property DeliveryNotes                    :string          Read GetDeliveryNotes                    Write SetDeliveryNotes;
    property JobRegistration                  :string          Read GetJobRegistration                  Write SetJobRegistration;
    property SerialNumber                     :string          Read GetSerialNumber                     Write SetSerialNumber;
    property Faxnumber                        :string          Read GetFaxnumber                        Write SetFaxnumber;
    property Altcontact                       :string          Read GetAltcontact                       Write SetAltcontact;
    property AltPhone                         :string          Read GetAltPhone                         Write SetAltPhone;
    property ClientNo                         :string          Read GetClientNo                         Write SetClientNo;
    property CUSTFLD1                         :string          Read GetCUSTFLD1                         Write SetCUSTFLD1;
    property CUSTFLD2                         :string          Read GetCUSTFLD2                         Write SetCUSTFLD2;
    property CUSTFLD3                         :string          Read GetCUSTFLD3                         Write SetCUSTFLD3;
    property CUSTFLD4                         :string          Read GetCUSTFLD4                         Write SetCUSTFLD4;
    property CUSTFLD5                         :string          Read GetCUSTFLD5                         Write SetCUSTFLD5;
    property CUSTFLD6                         :string          Read GetCUSTFLD6                         Write SetCUSTFLD6;
    property CUSTFLD7                         :string          Read GetCUSTFLD7                         Write SetCUSTFLD7;
    property CUSTFLD8                         :string          Read GetCUSTFLD8                         Write SetCUSTFLD8;
    property CUSTFLD9                         :string          Read GetCUSTFLD9                         Write SetCUSTFLD9;
    property CUSTFLD10                        :string          Read GetCUSTFLD10                        Write SetCUSTFLD10;
    property CUSTFLD11                        :string          Read GetCUSTFLD11                        Write SetCUSTFLD11;
    property CUSTFLD12                        :string          Read GetCUSTFLD12                        Write SetCUSTFLD12;
    property CUSTFLD13                        :string          Read GetCUSTFLD13                        Write SetCUSTFLD13;
    property CUSTFLD14                        :string          Read GetCUSTFLD14                        Write SetCUSTFLD14;
    property CUSTFLD15                        :string          Read GetCUSTFLD15                        Write SetCUSTFLD15;
    property CUSTDATE1                        :TDateTime       Read GetCUSTDATE1                        Write SetCUSTDATE1;
    property CUSTDATE2                        :TDateTime       Read GetCUSTDATE2                        Write SetCUSTDATE2;
    property CUSTDATE3                        :TDateTime       Read GetCUSTDATE3                        Write SetCUSTDATE3;
    property BankCode                         :string          Read GetBankCode                         Write SetBankCode;
    property CardNumber                       :string          Read GetCardNumber                       Write SetCardNumber;
    property JobTitle                         :string          Read GetJobTitle                         Write SetJobTitle;
    property ModelNumber                      :string          Read GetModelNumber                      Write SetModelNumber;
    property Model                            :TModel          Read GetModel;
    property ManufactureName                  :string          Read GetManufactureName                  Write SetManufactureName;
    property ManufactureID                    :Integer         Read GetManufactureID                    Write SetManufactureID;
    property EmailXML                         :string          Read GetEmailXML                         Write SetEmailXML;
    property EmailPOXML                       :string          Read GetEmailPOXML                       Write SetEmailPOXML;
    property Mobile                           :string          Read GetMobile                           Write SetMobile;
    property Email                            :string          Read GetEmail                            Write SetEmail;
    property Notes                            :string          Read GetNotes                            Write SetNotes;
    property JobName                          :string          Read GetJobName                          Write SetJobName;
    property printjobname                     :string          Read Getprintjobname                     Write Setprintjobname;
    property URL                              :string          Read GetURL                              Write SetURL;
    property Tasks                            :string          Read GetTasks                            Write SetTasks;
    property BillStreet                       :string          Read getBillStreet                       Write SetBillStreet;
    property BillStreet2                      :string          Read getBillStreet2                      Write SetBillStreet2;
    property BillStreet3                      :string          Read getBillStreet3                      Write SetBillStreet3;
    property Billsuburb                       :string          Read getBillsuburb                       Write SetBillsuburb;
    property BillState                        :string          Read getBillState                        Write SetBillState;
    property Billcountry                      :string          Read getBillcountry                      Write SetBillcountry;
    property BillPostcode                     :string          Read getBillPostcode                     Write SetBillPostcode;
    property Phone                            :string          Read getPhone                            Write SetPhone;
    property Street                           :string          Read getStreet                           Write SetStreet;
    property Street2                          :string          Read getStreet2                          Write SetStreet2;
    property Street3                          :string          Read getStreet3                          Write SetStreet3;
    property Suburb                           :string          Read getSuburb                           Write SetSuburb;
    property State                            :string          Read getState                            Write SetState;
    property Country                          :string          Read getcountry                          Write Setcountry;
    property Postcode                         :string          Read getPostcode                         Write SetPostcode;
    property ClientName                       :string          Read getclientName                       Write SetclientName;
    Property Companyname                      :String          Read getCompanyname;
    property PrintName                        :string          Read getPrintName                        Write SetPrintName;
    property FirstName                        :string          Read getFirstName                        Write SetFirstName;
    property LastName                         :string          Read GetLastName                         Write SetLastName;
    property MiddleName                       :string          Read getMiddleName                       Write SetMiddleName;
    property Title                            :string          Read getTitle                            Write SetTitle;
    property ABN                              :string          Read getABN                              Write SetABN;
    property ApprovalFromDate                 :TDateTime       Read GetApprovalFromDate                 Write SetApprovalFromDate;
    property WarrantyFinishDate               :TDateTime       Read GetWarrantyFinishDate               Write SetWarrantyFinishDate;
    property PhonesupportTill                 :TDateTime       Read GetPhonesupportTill                 Write SetPhonesupportTill;
    property ReminderDateTime                 :TDateTime       Read GetReminderDateTime                 Write SetReminderDateTime;
    property ApprovalToDate                   :TDateTime       Read GetApprovalToDate                   Write SetApprovalToDate;
    property CompletionDate                   :TDateTime       Read GetCompletionDate                   Write SetCompletionDate;
    property CreationDate                     :TDateTime       Read GetCreationDate                     Write SetCreationDate;
    property DateEntered                      :TDateTime       Read GetDateEntered                      Write SetDateEntered;
    property DateInactive                     :TDateTime       Read GetDateInactive                     Write SetDateInactive;
    property DischargeDate                    :TDateTime       Read GetDischargeDate                    Write SetDischargeDate;
    property ExpiryDate                       :TDateTime       Read GetExpiryDate                       Write SetExpiryDate;
    property UpdateDate                       :TDateTime       Read GetUpdateDate                       Write SetUpdateDate;
    property Action                           :TDateTime       Read GetAction                           Write SetAction;
    property OtherFollowUps                   :TOtherFollowUps Read getOtherFollowUps;
    property ProductGroupDiscount             :TProductGroupDiscount  Read getGroupDiscounts;
    property Contacts                         :TContact               Read getContacts;
    property SpecialProducts                  :TSpecialProducts       Read getSpecialProducts;

    property BPAYBillerCode                   :string Read GetBPAYBillerCode                            Write SetBPAYBillerCode;
    property BPAYReference                    :string Read GetBPAYReference                             Write SetBPAYReference;
    property PortOfLanding                    :String Read getPortOfLanding                             Write setPortOfLanding;
    property PortOfDischarge                  :String Read getPortOfDischarge                           Write setPortOfDischarge;
    property FinalDestination                 :String Read getFinalDestination                          Write setFinalDestination;
    property IncoPlace                        :String Read getIncoPlace                                 Write setIncoPlace;
    property TeamviewerID                     :String Read getTeamviewerID                              Write setTeamviewerID;
    property ClientCode                       :String Read getClientCode                                Write setClientCode;
    property SkypeName                        :String Read getSkypeName                                 Write setSkypeName;
    property ShippingAgentID                  :Integer Read getShippingAgentID                          Write setShippingAgentID;
    property ShippingAgentCode                :string Read GetShippingAgentCode                         Write SetShippingAgentCode;
    Property CallPriority                     :Integer Read getCallPriority                             Write setCallPriority;

    { the following fields are really Job fields ... so maybe should be in TJob }
    property AssessorsName                    :string Read GetAssessorsName                             Write SetAssessorsName;
    property ExcessAmount                     :double Read GetExcessAmount                              Write SetExcessAmount;
    property StormLocation                    :string Read GetStormLocation                             Write SetStormLocation;
    property StormDate                        :TDateTime Read GetStormDate                              Write SetStormDate;
    property Year                             :TDateTime Read GetYear                                   Write SetYear;
    property Colour                           :string Read GetColour                                    Write SetColour;
    property BodyType                         :string Read GetBodyType                                  Write SetBodyType;
    property BailmentNumber                   :string Read GetBailmentNumber                            Write SetBailmentNumber;
    property BailmentAmountEx                 :double Read GetBailmentAmountEx                          Write SetBailmentAmountEx;
    property StockReceivedDate                :TDate Read GetStockReceivedDate                          Write SetStockReceivedDate;
    property NewOrUsed                        :string Read GetNewOrUsed                                 Write SetNewOrUsed;
    Property ClientCustomFieldValues          :TClientCustomFieldValues Read GetClientrCustomFieldValues;
    property ClaimNumber                      :string Read GetClaimNumber                               Write SetClaimNumber;
    property DocumentPath                     :string Read GetDocumentPath                              Write SetDocumentPath;
    property ExternalRef                      :string Read GetExternalRef                               Write SetExternalRef;
    property LicenseRenewDurationType         :string Read GetLicenseRenewDurationType                  Write SetLicenseRenewDurationType;
    property LicenseRenewDuration             :Integer Read GetLicenseRenewDuration                     Write SetLicenseRenewDuration;
    property ClientPaysShippment: boolean read GetClientPaysShippment write SetClientPaysShippment;
    property ClientShipperAccountNo: string read GetClientShipperAccountNo write SetClientShipperAccountNo;
    property PublishOnVS1: boolean read GetPublishOnVS1 write SetPublishOnVS1;
    property Status                           :string Read GetStatus                                    Write SetStatus;

  end;

  TSupplier = class(TClient)
  private
    fiShippingMethodID: Integer;
    fiPayMethodID: Integer;
    fiDefaultPOTemplateID: Integer;
    function GetSupplierId: Integer;
    function GetSupplierCustomfieldValues: TSupplierCustomfieldValues;
    function GetSupplierCreditLimit: double;
    function getTotalSupplierCredit: double;
    function getApBackOrderbalance: double;
    function getRunningAPBalance: double;
    function GetBankLodgementRef: string;
    function getIgnoreSupplierforProductLatestCost: Boolean;
    function GetBankName: string;
    function GetSwiftCode: string;
    function GetRoutingNumber: string;

    procedure SetSupplierCreditLimit(const Value: double);
    procedure SetBankLodgementRef(const Value: string);
    procedure SetIgnoreSupplierforProductLatestCost(const Value: Boolean);
    procedure SetBankName(const Value: string);
    procedure SetSwiftCode(const Value: string);
    procedure SetRoutingNumber(const Value: string);


  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function ForeignKeysValid(const node: IXMLNode):  Boolean; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function IDToggle(const ID: Integer; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): string; overload; override;
    class function IDToggle(const KeyString: string; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): Integer; overload; override;
    class function GetKeyStringProperty: string; override;
    property SupplierId: Integer Read GetSupplierId;
    procedure SaveToXMLNode(const Node: IXMLNode); override;
    procedure LoadFromXMLNode(const Node: IXMLNode); override;
    Function ValidEFTSupplier :Boolean;
    function ValidateData: Boolean; override;
    function Save: boolean; override;
    Property CustomfieldValues :TSupplierCustomfieldValues Read GetSupplierCustomfieldValues;
    Property TotalSupplierCredit :double  Read getTotalSupplierCredit;
    Property ApBackOrderbalance :double Read getApBackOrderbalance;
    Property RunningAPBalance :double Read getRunningAPBalance;
    Class Function MakeSupplier(AOwner:TComponent; aClientName:String;CreateifnotExists:Boolean =False; aSource:String = ''): Integer;

  Published
    property SupplierEquipment                  : TCustomerEquipment  Read getCustomerEquipment;
    property SupplierCreditLimit                : double              Read GetSupplierCreditLimit                 write SetSupplierCreditLimit;
    property BankLodgementRef                   : string              Read GetBankLodgementRef                    write SetBankLodgementRef;
    Property IgnoreSupplierforProductLatestCost :Boolean              Read getIgnoreSupplierforProductLatestCost  write SetIgnoreSupplierforProductLatestCost;
    property Contractor;
    property BankName       : string    Read GetBankName            write SetBankName;
    property SwiftCode      : string    Read GetSwiftCode           write SetSwiftcode;
    property RoutingNumber  : string    Read GetRoutingNumber       write SetRoutingNumber;

  end;

  TCustomer = class(TClient)
  private
    fiClientTypeID: Integer;
    fiTAXCODEID: Integer;
    fiDefaultInvTemplateID: Integer;
    fiDefaultDelTemplateID: Integer;
    fiShippingMethodID: Integer;
    fiPayMethodID: Integer;
    fRelatedCustomers: TRelatedCustomer;
    fiCustomerPhysicalAddressshipAddressID:Integer;
    function getTShippingAgent: TShippingAgent;
    function GetRelatedCustomers: TRelatedCustomer;
    function GetOpeningRewardPoints: TSalesLinesPoints;
    function GetRewardPointsExpireDate: TDateTime;
    function GetRewardPointsOpeningBalance: double;
    function GetRewardPointsOpeningDate: TDateTime;
    procedure SetRewardPointsExpireDate(const Value: TDateTime);
    procedure SetRewardPointsOpeningBalance(const Value: double);
    procedure SetRewardPointsOpeningDate(const Value: TDateTime);
    function getTCustomerCustomfieldValues: TCustomerCustomfieldValues;
    function getARBackOrderbalance: double;
    function getSOBackOrderBalance: double;
    function getShippingAddresses: TShippingAddress;
    function getShippingAddressLink: Tclienttoshipaddresslink;
    function getClientTaxExceptionProducts: TClientTaxExceptionProducts;
    function getCustomerPhysicalAddressshipAddressID: Integer;
    procedure CustomerPhysicalAddressshipAddressIDCallback(const Sender: TBusObj; var Abort: Boolean);
    function GetAddressValid: boolean;
    function GetBillAddressValid: boolean;
    procedure SetAddressValid(const Value: boolean);
    procedure SetBillAddressValid(const Value: boolean);
    function getCustomerGlobalRef: String;
    function getJobs: TJob;
    function getCustomerShippingOptions: TCustomerShippingOptions;
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function ForeignKeysValid(const node: IXMLNode): Boolean; override;
    Function  DoBeforePost(Sender :TDatasetBusObj ):Boolean;             Override;
  public
    constructor Create(AOwner: TComponent)          ; override;
    destructor Destroy                              ; override;
    procedure SaveToXMLNode(const Node: IXMLNode)   ; override;
    procedure LoadFromXMLNode(const Node: IXMLNode) ; override;
    function ValidateData: Boolean                  ; override;
    function Save: boolean                          ; override;
    class function GetKeyStringProperty: string     ; override;
    class function _Schema: string                  ; override;
    class function IDToggle(const ID: Integer; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): string; overload; override;
    class function IDToggle(const KeyString: string; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): Integer; overload; override;
    Class Function MakeCustomer(AOwner:TComponent; aClientName:String;CreateifnotExists:Boolean =False; aSource:String = ''):Integer;
    Class Function MakeMagentoCustomer(Data: TJsonObject; conn :TMyDacDataConnection; aSource:String): Integer;
    Class Function MakeMagentoGuestCustomer(Data: TJsonObject; conn :TMyDacDataConnection; aSource:String): Integer;

    Property ShippingAgent        : TShippingAgent              Read getTShippingAgent;
    property OpeningRewardPoints  : TSalesLinesPoints           Read GetOpeningRewardPoints;
    Property Jobs                 : TJob                        read getJobs;
    Property ARBackOrderbalance   : double                      Read getARBackOrderbalance;
    Property SOBackOrderBalance   : double                      Read getSOBackOrderBalance;
    Property CustomFieldValues    : TCustomerCustomfieldValues  Read getTCustomerCustomfieldValues;
    Property ShippingAddresses    : TShippingAddress            Read getShippingAddresses;
    Property ShippingAddressLink  : Tclienttoshipaddresslink    Read getShippingAddressLink;
    Property CustomerGlobalRef    : String                      Read getCustomerGlobalRef;
    Property CustomerPhysicalAddressshipAddressID:Integer       Read getCustomerPhysicalAddressshipAddressID;
  published
    property RelatedCustomers           : TRelatedCustomer            Read GetRelatedCustomers;
    property RewardPointsOpeningBalance : double                      Read GetRewardPointsOpeningBalance  write SetRewardPointsOpeningBalance;
    property RewardPointsOpeningDate    : TDateTime                   Read GetRewardPointsOpeningDate     write SetRewardPointsOpeningDate;
    property RewardPointsExpireDate     : TDateTime                   Read GetRewardPointsExpireDate      write SetRewardPointsExpireDate;
    property CustomerEquipment          : TCustomerEquipment          Read getCustomerEquipment;
    property CustomerShippingOptions    : TCustomerShippingOptions    Read geTCustomerShippingOptions;
    property ClientTaxExceptionProducts : TClientTaxExceptionProducts Read getClientTaxExceptionProducts;
    property AddressValid               : boolean                     Read GetAddressValid                write SetAddressValid;
    property BillAddressValid           : boolean                     Read GetBillAddressValid            write SetBillAddressValid;
  end;

  TCustomerExport = Class(TCustomer)
  public
    constructor Create(AOwner: TComponent); override;
  End;
  TJob = class(TClient)
  private
    procedure PopulateDataFromParentCust;
  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;
  public
    constructor Create(AOwner: TComponent); override;
    class function IDToggle(const ID: Integer; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): string; overload; override;
    class function IDToggle(const KeyString: string; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): Integer; overload; override;
    function ValidateData: Boolean; override;
    function Save: boolean; override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    Class Function MakeJob(AOwner:TComponent; aCustomerName,aJobName:String ; aJobNumber :Integer;CreateifnotExists:Boolean =False; aSource:String = ''): Integer;
    Class Function FindJob(AOwner:TComponent; ajobname:String;ajobnumber:Integer):Integer;
  published
    property ParentCustomerName: string Read GetParentClientName write SetParentClientName;
  end;

  TOtherContact = class(TClient)
  private
    fiOtherContactTypeID: Integer;
    function GetEmpID: Integer;
    function GetEmpName: String;
    procedure SetEmpID(const Value: Integer);
    procedure SetEmpName(const Value: String);

  protected
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function ForeignKeysValid(const node: IXMLNode): Boolean; override;

  public
    procedure SaveToXMLNode(const Node: IXMLNode); override;
    procedure LoadFromXMLNode(const Node: IXMLNode); override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function IDToggle(const ID: Integer; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): string; overload; override;
    class function IDToggle(const KeyString: string; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): Integer; overload; override;
    function Save: boolean; override;
    function ValidateData: Boolean; override;
    class function GetKeyStringProperty: string; override;
    Class Function XMLNodeName :String; Override;

  published
    property EmpID:   Integer   read GetEmpID   write SetEmpID;
    property EmpName: String    read GetEmpName write SetEmpName;

  end;

  TProspect = class(TOtherContact)
  end;


implementation

uses SysUtils, tcDataUtils,   BusObjUtils,
   AppEnvironment, CommonLib, BusObjSimpleTypes, variants,
   BusObjConst, CommonDbLib, BusobjPaymethods,
   BusObjEmployeeDetails, BusobjMarketingcontacts, BusObjectListObj,
   BusObjSchemaLib, BusObjGLAccount, BusObjEquipment, UserMessageConst,
   BusObjUOM, DbSharedObjectsObj, busobjcompinfo, tcConst, LogLib,types, StrUtils;

{ TClient }
Class Procedure TClient.MakeMarketingcontact(AOwner:Tcomponent; aConnection :TERPConnection; aBusObjEvent: TBusObjEvent; aClientID:Integer );
var
  Clients :TClient;
Procedure DoCommitTransaction; begin if aConnection = nil then Clients.Connection.CommitTransaction; end;
begin
  try
    if (aConnection = nil) or (aConnection.Connected=False) then
      Clients := TClient.CreateWithNewConn(AOwner)
    else begin
      Clients := TClient.Create(AOwner);
      Clients.connection :=TMyDacDataConnection.create(Clients);
      Clients.Connection.connection := aConnection;
    end;
    Clients.BusObjEvent := aBusObjEvent;
    Clients.SQL :=//'SELECT C.clientId, C.company, C.active  '+
                  'SELECT C.company as ClientName, '+
                  'C.FaxNumber,C.Phone,C.AltPhone,C.Mobile, '+
                  'C.Street,C.Street2,C.Street3,C.Suburb,C.State,C.Postcode,C.Country,C.URL, '+
                  'C.BillStreet,C.BillStreet2,C.BillStreet3,C.BillSuburb,C.BillState ,C.BillPostcode,C.BillCountry, '+
                  'C.Notes,C.Active,C.JobTitle, '+
                  'C.Title,C.Firstname ,C.Middlename,C.Lastname,C.Email,C.DateEntered '+
                  ' FROM tblclients C  '+
                  ' LEFT JOIN tblmarketingcontacts MC ON C.clientId = MC.ClientID  '+
                  ' WHERE MC.ID IS NULL'+
                  ' and not(C.company in (''Cash Customer'' , ''Workshop'' ,''Misc Supplier'' ,  ''Default Company'')) '+
                  iif(aClientID <> 0, ' and C.clientId = ' + inttostr(aClientID), '') ;
    Clients.Load;
    if Clients.count =0 then exit;
    Clients.MakeMarketingcontact((aConnection = nil) or (not(aConnection.intransaction))) ;
  finally
    freeandnil(Clients);
  end;
end;
procedure TClient.MakeMarketingcontact(DoinTransaction:Boolean );
begin
  fsMakeMarketingcontact := '';
  if dointransaction then connection.BeginTransaction;
  try
    showProgress(inttostr(count)+' Clients to Convert' , count);
    try
      IterateRecords(MakeMarketingcontactCallback);
    finally
      hideProgressbar;
    end;
  finally
   if dointransaction then connection.CommitTransaction
  end;

end;
procedure TClient.MakeMarketingcontactCallBack(const Sender: TBusObj;  var Abort: Boolean);
var
  Msg:String;
begin
  StepProgressbar(inttostr(Recno)+' of ' + inttostr(Count));
  ConverttoMarketingcontact(Msg);
  if Msg <> '' then begin
    if fsMakeMarketingcontact <> '' then fsMakeMarketingcontact := fsMakeMarketingcontact + NL;
    fsMakeMarketingcontact := fsMakeMarketingcontact + Msg;
  end;
end;

function TClient.ConvertToMarketingContact(var msg: string): integer;
var
  MC:TMarketingContact;
begin
  result := 0;

  MC:=TMarketingContact.create(Self);
  try
    MC.connection := self.connection;

    {search on clientId}
    MC.Loadselect('ClientID = ' +inttostr(ID));
    MC.SilentMode := True;
    if MC.count > 0 then begin
      msg := quotedstr(clientname)+' is Already a Marketing Contact';
      result := MC.Id;
      exit;
    end;

    {Search on company name }
    MC.Loadselect('COMPANY =' + quotedstr(clientname));
    if MC.count > 0 then begin
      msg := quotedstr(clientname)+' is Already a Marketing Contact';
      MC.ClientID := ID; // update the clientId
      MC.PostDB;
      result := MC.Id;
      exit;
    end;


    MC.New;
    MC.company         := ClientName;
    MC.FaxNumber       := FaxNumber;
    MC.Phone           := Phone;
    MC.AltPhone        := AltPhone;
    MC.Mobile          := Mobile;
    MC.Street          := Street;
    MC.Street2         := Street2;
    MC.Street3         := Street3;
    MC.Suburb          := Suburb;
    MC.State           := State;
    MC.Postcode        := Postcode;
    MC.Country         := Country;
    MC.URL             := URL;
    MC.billStreet	     := BillStreet;
    MC.billStreet2	   := BillStreet2;
    MC.billStreet3	   := BillStreet3;
    MC.billSuburb	     := BillSuburb;
    MC.billState	     := BillState ;
    MC.billPostcode	   := BillPostcode    	;
    MC.BillCountry	   := BillCountry;
    MC.Notes	         := Notes;
    MC.Active	         := Active;
    MC.JobTitle	       := JobTitle;
    MC.Title	         := Title;
    MC.Firstname	     := Firstname ;
    MC.Middlename	     := Middlename;
    MC.Lastname	       := Lastname;
    MC.Email	         := Email;
    MC.DateEntered	   := DateEntered;
    MC.ClientId        := Self.ID;
    MC.DateEntered     := Date;
    MC.PostDB;
    if self.Contacts.Count > 0 then begin
      Contacts.First;
      while not Contacts.EOF do begin
        MC.MarketingContactContacts.New;
        Mc.MarketingContactContacts.Company := Contacts.Company;
        Mc.MarketingContactContacts.ContactTitle := Contacts.ContactTitle;
        Mc.MarketingContactContacts.ContactFirstName := Contacts.ContactFirstName;
        Mc.MarketingContactContacts.ContactSurName := Contacts.ContactSurName;
        Mc.MarketingContactContacts.ContactAddress := Contacts.ContactAddress;
        Mc.MarketingContactContacts.ContactAddress2 := Contacts.ContactAddress2;
        Mc.MarketingContactContacts.ContactAddress3 := Contacts.ContactAddress3;
        Mc.MarketingContactContacts.ContactCity := Contacts.ContactCity;
        Mc.MarketingContactContacts.ContactState := Contacts.ContactState;
        Mc.MarketingContactContacts.ContactPcode := Contacts.ContactPcode;
        Mc.MarketingContactContacts.ContactCountry := Contacts.ContactCountry;
        Mc.MarketingContactContacts.ContactPH := Contacts.ContactPH;
        Mc.MarketingContactContacts.ContactAltPH := Contacts.ContactAltPH;
        Mc.MarketingContactContacts.ContactMOB := Contacts.ContactMOB;
        Mc.MarketingContactContacts.ContactFax := Contacts.ContactFax;
        Mc.MarketingContactContacts.ContactEmail := Contacts.ContactEmail;
        Mc.MarketingContactContacts.Active := Contacts.Active;
        Mc.MarketingContactContacts.JobTitle := COntacts.JobTitle;
        Mc.MarketingContactContacts.DoNotContact := Contacts.DoNotContact;
        Mc.MarketingContactContacts.AccountNo := Contacts.AccountNo;
        Mc.MarketingContactContacts.IsPrimaryContact := Contacts.IsPrimaryContact;
        Mc.MarketingContactContacts.PostDb;
        Contacts.Next;
      end;


    end;
    if MC.Save then
      Result := MC.ID
    else
      msg := MC.ResultStatus.Messages;
  finally
    Freeandnil(MC);
  end;
end;

constructor TClient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CustomFieldIdentifier := 'Othr';
  fSQL := 'SELECT * FROM tblClients';
  ExportExcludeList.Add('clienttypeid');
  ExportExcludeList.Add('combinedinvoiceboid');
  ExportExcludeList.Add('combinedsalesorderboid');
  ExportExcludeList.Add('companytypeid');
  ExportExcludeList.Add('defaultdeltemplateid');
  ExportExcludeList.Add('defaultinvtemplateid');
  ExportExcludeList.Add('defaultpotemplateid');
  ExportExcludeList.Add('manufactureid');
  ExportExcludeList.Add('medtypeid');
  ExportExcludeList.Add('parentclientid');
  ExportExcludeList.Add('parentrelatedclientid');
  ExportExcludeList.Add('paymethodid');
  ExportExcludeList.Add('repid');
  ExportExcludeList.Add('DefaultAPAccountID');
  ExportExcludeList.Add('DefaultARAccountID');
  ExportExcludeList.Add('required');
  ExportExcludeList.Add('SendXMLInvoices');
  ExportExcludeList.Add('SendXMLPOs');
  ExportExcludeList.Add('shippingagentid');
  ExportExcludeList.Add('shippingid');
  ExportExcludeList.Add('termsid');
  ExportExcludeList.Add('action');

  ExportExcludeList.Add('taxid');
  ExportExcludeList.Add('approvalfromdate');
  ExportExcludeList.Add('approvaltodate');
  ExportExcludeList.Add('completiondate');
  //ExportExcludeList.Add('isjob');
  ExportExcludeList.Add('othercontact');
  ExportExcludeList.Add('supplier');
  ExportExcludeList.Add('BillingAddressWithName');
  ExportExcludeList.Add('BillingAddress');
  ExportExcludeList.Add('StreetAddressWithName');
  ExportExcludeList.Add('StreetAddress');
  ExportExcludeList.Add('ClientDetails');
  ExportExcludeList.Add('ClientAddress');
  ExportExcludeList.Add('ShipToAddress');

end;

class function TClient.GetBusObjectTablename: string;
begin
  Result := 'tblClients';
end;

function TClient.getCallPriority: Integer;
begin
  Result := GetIntegerField('CallPriority');
end;

class function TClient.DefaultSOTemplateName(const aClientID: integer;
  Conn: TCustomMyConnection): string;
var
  qry: TERPQuery;
  x: integer;
begin
  result := '';
  if Assigned(Conn) then
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select DefaultSalesOrderTemplateID from tblClients');
    qry.SQL.Add('where ClientyID = ' + IntToStr(aClientID));
    qry.Open;
    x := qry.FieldByName('DefaultSalesOrderTemplateID').AsInteger;
    qry.Close;
    if x > 0 then begin
      qry.SQL.Clear;
      qry.SQL.Add('select TemplName from tbltemplates');
      qry.SQL.Add('where TemplID = ' + IntToStr(x));
      qry.Open;
      result := qry.FieldByName('TemplName').AsString;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

destructor TClient.Destroy;
begin
  inherited;
end;

function TClient.Save: boolean;
begin
  if Container.Exists(TCoreEDIConfig) then begin
    result := CoreEDIConfig.Save;
    if not result then begin
      AddResult(false, rssWarning, 0, CoreEDIConfig.ResultStatus.Messages);
      exit;
    end;
  end;
  result := inherited;
end;

procedure TClient.SaveToXMLNode(const Node: IXMLNode);
begin
  inherited;
  AddXMLNode(Node, 'Company', ClientName);
  AddXMLNode(Node, 'Printname', PrintName);
  AddXMLNode(Node, 'Title', Title);
  AddXMLNode(Node, 'FirstName', FirstName);
  AddXMLNode(Node, 'MiddleName', MiddleName);
  AddXMLNode(Node, 'LastName', LastName);
  AddXMLNode(Node, 'Street', Street);
  AddXMLNode(Node, 'Street2', Street2);
  AddXMLNode(Node, 'Street3', Street3);
  AddXMLNode(Node, 'Suburb', Suburb);
  AddXMLNode(Node, 'State', State);
  AddXMLNode(Node, 'Country', Country);
  AddXMLNode(Node, 'Postcode', Postcode);
  AddXMLNode(Node, 'BillStreet', BillStreet);
  AddXMLNode(Node, 'BillStreet2', BillStreet2);
  AddXMLNode(Node, 'BillStreet3', BillStreet3);
  AddXMLNode(Node, 'BillSuburb', BillSuburb);
  AddXMLNode(Node, 'BillState', BillState);
  AddXMLNode(Node, 'BillCountry', BillCountry);
  AddXMLNode(Node, 'BillPostcode', BillPostcode);
  AddXMLNode(Node, 'Phone', Phone);
  AddXMLNode(Node, 'FaxNumber', FaxNumber);
  AddXMLNode(Node, 'Mobile', Mobile);
  AddXMLNode(Node, 'Email', Email);
  AddXMLNode(Node, 'AltPhone', AltPhone);
  AddXMLNode(Node, 'CreationDate', CreationDate);
  AddXMLNode(Node, 'UpdateDate', UpdateDate);
  AddXMLNode(Node, 'DateInactive', DateInactive);
  AddXMLNode(Node, 'Notes', Notes);
  AddXMLNode(Node, 'APBalance', APBalance);
  AddXMLNode(Node, 'Balance', Balance);
  AddXMLNode(Node, 'SOBalance', SalesOrderBalance);
  AddXMLNode(Node, 'TERMS', TermsName);
  AddXMLNode(Node, 'Discount', Discount);
  AddXMLNode(Node, 'SpecialDiscount', SpecialDiscount);
  AddXMLNode(Node, 'IsJob', IsJob);
  AddXMLNode(Node, 'Customfield1', CUSTFLD1);
  AddXMLNode(Node, 'Customfield2', CUSTFLD2);
  AddXMLNode(Node, 'Customfield3', CUSTFLD3);
  AddXMLNode(Node, 'Customfield4', CUSTFLD4);
  AddXMLNode(Node, 'Customfield5', CUSTFLD5);
  AddXMLNode(Node, 'Customfield6', CUSTFLD6);
  AddXMLNode(Node, 'Customfield7', CUSTFLD7);
  AddXMLNode(Node, 'Customfield8', CUSTFLD8);
  AddXMLNode(Node, 'Customfield9', CUSTFLD9);
  AddXMLNode(Node, 'Customfield10', CUSTFLD10);
  AddXMLNode(Node, 'Customfield11', CUSTFLD11);
  AddXMLNode(Node, 'Customfield12', CUSTFLD12);
  AddXMLNode(Node, 'Customfield13', CUSTFLD13);
  AddXMLNode(Node, 'Customfield14', CUSTFLD14);
  AddXMLNode(Node, 'Customfield15', CUSTFLD15);
  AddXMLNode(Node, 'Customer', Customer);
  AddXMLNode(Node, 'Supplier', Supplier);
  AddXMLNode(Node, 'OtherContact', OtherContact);
  AddXMLNode(Node, 'RepName', RepName);
  AddXMLNode(Node, 'DefaultARAccount', DefaultARAccount);
  AddXMLNode(Node, 'DefaultAPAccount', DefaultAPAccount);
  AddXMLNode(Node, 'Action', Action);
  AddXMLNode(Node, 'Active', Active);
  AddXMLNode(Node, 'DontContact', DontContact);
  AddXMLNode(Node, 'CompletionDate', CompletionDate);
  AddXMLNode(Node, 'URL', URL);
  AddXMLNode(Node, 'StopCredit', StopCredit);
  AddXMLNode(Node, 'Required', Required);
  AddXMLNode(Node, 'SendXMLInvoices', SendXMLInvoices);
  AddXMLNode(Node, 'SendXMLPOs', SendXMLPOs);
  AddXMLNode(Node, 'ForcePOOnBooking', ForcePOOnBooking);
  AddXMLNode(Node, 'ForcePOOnInvoice', ForcePONumOnInvoice);
  AddXMLNode(Node, 'PickingPriority', PickingPriority);
  AddXMLNode(Node, 'CallPriority', CallPriority);
  AddXMLNode(Node, 'GroupDiscountOverridesAll', GroupDiscountOverridesAll);
  AddXMLNode(Node, 'SpecialProductPriceOverridesAll', SpecialProductPriceOverridesAll);
  AddXMLNode(Node, 'UseInvBase', UseCustomerInvoiceNo);
  AddXMLNode(Node, 'InvBaseNumber', CustomerNextInvoiceNo);
  AddXMLNode(Node, 'ApprovalFromDate', ApprovalFromDate);
  AddXMLNode(Node, 'ApprovalToDate', ApprovalToDate);
  AddXMLNode(Node, 'Tasks', Tasks);
  AddXMLNode(Node, 'ReminderDateTime', ReminderDateTime);
  AddXMLNode(Node, 'SpecialInstructions', SpecialInstructions);
  AddXMLNode(Node, 'CUSTDATE1', CUSTDATE1);
  AddXMLNode(Node, 'CUSTDATE2', CUSTDATE2);
  AddXMLNode(Node, 'CUSTDATE3', CUSTDATE3);
  AddXMLNode(Node, 'CustomerJobNumber', CustomerJobNumber);

  AddXMLNode(Node, 'PortOfLanding',PortOfLanding  );
  AddXMLNode(Node, 'PortOfDischarge', PortOfDischarge );
  AddXMLNode(Node, 'FinalDestination', FinalDestination );
  AddXMLNode(Node, 'IncoPlace', IncoPlace );
  AddXMLNode(Node, 'TeamviewerID', TeamviewerID );
  AddXMLNode(Node, 'ClientCode', ClientCode );
  AddXMLNode(Node, 'SkypeName', SkypeName );
  AddXMLNode(Node, 'ShippingAgentID', ShippingAgentID );
  AddXMLNode(Node, 'AssessorsName', AssessorsName);
  AddXMLNode(Node, 'ExcessAmount', ExcessAmount);
  AddXMLNode(Node, 'StormLocation', StormLocation);
  AddXMLNode(Node, 'StormDate', StormDate);
  AddXMLNode(Node, 'Year', Year);
  AddXMLNode(Node, 'Colour', Colour);
  AddXMLNode(Node, 'BodyType', BodyType);
  AddXMLNode(Node, 'BailmentNumber', BailmentNumber);
  AddXMLNode(Node, 'BailmentAmountEx', BailmentAmountEx);
  AddXMLNode(Node, 'StockReceivedDate', StockReceivedDate);
  AddXMLNode(Node, 'NewOrUsed', NewOrUsed);
  AddXMLNode(Node , 'JobNumber',JobNumber);
  AddXMLNode(Node, 'CombinedInvoiceBOID', CombinedInvoiceBOID);
  AddXMLNode(Node, 'CombinedSaleOrderBOID', CombinedSalesOrderBOID);
  AddXMLNode(Node, 'ClientPaysShippment', ClientPaysShippment);
  AddXMLNode(Node, 'ClientShipperAccountNo', ClientShipperAccountNo);
  AddXMLNode(Node, 'PublishOnVS1', PublishOnVS1);
  AddXMLNode(Node, 'Status', Status);


  if not SavingXMLTofile then begin
    AddXMLNode(Node, 'MedTypeID', MedTypeID);
    AddXMLNode(Node, 'TermsID', TermsID);
    AddXMLNode(Node, 'RepID', RepID);
    AddXMLNode(Node, 'DefaultAPAccountID', DefaultAPAccountID);
    AddXMLNode(Node, 'DefaultARAccountID', DefaultARAccountID);
    AddXMLNode(Node, 'ParentClientID', ParentClientID);
    AddXMLNode(Node, 'ParentRelatedClientID', ParentRelatedClientID);
    AddXMLNode(Node, 'CompanytypeID', companytypeId);
    AddXMLNode(Node, 'clientTypeID', clientTypeId);
  end  else  begin
    AddXMLNode(Node, 'MedType', tcDataUtils.getMediatype(MedTypeID));
    AddXMLNode(Node, 'ParentClient', tcdataUtils.getClientName(ParentClientID));
    AddXMLNode(Node, 'ParentRelatedClient', tcdataUtils.getClientName(ParentRelatedClientID));
    AddXMLNode(Node, 'Companytype', tcDataUtils.GetSimpleType(CompanyTypeId));
    AddXMLNode(Node, 'ClientType', tcDataUtils.getClientTypeName(clientTypeId));
  end;
end;

function TClient.ValidateData: Boolean;
var
  CleanClientName: string;
  CleanRequired: boolean;

  function DigitCount(s: string): integer;
  var x: integer;
  begin
    result:= 0;
    for x:= 1 to char_length(s) do
      if CharInSet(s[x],['0'..'9']) then Inc(result);
  end;

  function ValidateBSB: Boolean;
  begin
    Result := false;
    if AppEnv.CompanyPrefs.BankAccFormatting and (DigitCount(BankAccountBSB) <> AppEnv.RegionalOptions.BSBLength) then
    begin
      self.AddResult(false, rssWarning, 0, AppEnv.RegionalOptions.BSBName + ' ' +
        BankAccountBSB + ' length is invalid, should be ' +
        IntToStr(AppEnv.RegionalOptions.BSBLength));
      Exit;
    end;
    Result := true;
  end;

begin
  Result := false;
  if ClientName = '' then
  begin
    self.AddResult(false, rssWarning, 0, 'Client Name (Company) should not be blank');
    Exit;
  end;
  CleanClientName:= self.GetXMLNodeStringValue(self.CleanXMLNode, 'Company');
  if (CleanClientName <> '') and (ClientName <> CleanClientName) then begin
    self.AddResult(false, rssWarning, 0,
      'Can not change the Client Name (Company) "' + CleanClientName +
      '" to "' +  ClientName + '" for existing record');
    Exit;
  end;
  if (not self.IsSupplier) and (not self.IsCustomer) and (not self.IsOtherContact) then begin
    self.AddResult(false, rssWarning, 0, 'Company " ' + ClientName + '", Client type unknown - not Customer, Supplier or Other Contact');
    Exit;
  end;

  if BankAccountBSB <> '' then begin
    if (not RawMode) and (not ValidateBSB) then
      Exit
    else if (not RawMode) and AppEnv.CompanyPrefs.BankAccFormatting and (DigitCount(BankAccountNo) <> AppEnv.RegionalOptions.BankAccountLength) then begin
      self.AddResult(false, rssWarning, 0, 'Bank Account ' +
        BankAccountNo + ' length is invalid, should be ' +
        IntToStr(AppEnv.RegionalOptions.BankAccountLength));
      Exit;
    end;
  end;
  if not IsUnique(ID, 'Company = ' + QuotedStr(ClientName)) then
  begin
    self.AddResult(false, rssWarning, 0, 'Record already exists for "' + ClientName + '"');
    Exit;
  end;
  CleanRequired:= self.GetXMLNodeBooleanValue(self.CleanXMLNode,'Required');
  if CleanRequired and (not Required) then begin
    self.AddResult(false, rssWarning, 0, 'This ' + self.ObjectUserName +
      ' (' + self.ClientName + ') is required by ERP and can not be set to Required = False');
    Exit;
  end;
  if (TermsID > 0) and (TermsName = '') then begin
    AddResult(false, rssWarning, 0, 'Trading Terms not found for TermsID: ' + IntToStr(TermsID));
    exit;
  end;
  if (TermsID = 0) and (TermsName <> '') then begin
    AddResult(false, rssWarning, 0, 'Trading Terms not found for Terms Name: ' + TermsName);
    exit;
  end;

  if ModelNumber <> '' then begin
    if Model.Count = 0 then begin
      Model.New;
      Model.ModelName:= ModelNumber;
      if not Model.Save then
         exit;
    end;
  end;
  if ManufactureName <> '' then begin
    if Manufacture.ID = 0 then begin
      Manufacture.New;
      Manufacture.ManufactureName:= ManufactureName;
      if Manufacture.Save then
        ManufactureID:= Manufacture.ID
      else
        exit;
    end;
  end;
  if Container.Exists(TCoreEDIConfig) then begin
    if not CoreEDIConfig.ValidateData then begin
      AddResult(false, rssWarning, 0, CoreEDIConfig.ResultStatus.Messages);
      exit;
    end;

  end;

  Result := inherited ValidateData;
end;

procedure TClient.LoadFromXMLNode(const Node: IXMLNode);
begin
    SetPropertyFromNode(Node, 'ClientName','Company');
    SetPropertyFromNode(Node, 'PrintName','PrintName');
    SetPropertyFromNode(Node, 'Title');
    SetPropertyFromNode(Node, 'FirstName');
    SetPropertyFromNode(Node, 'MiddleName');
    SetPropertyFromNode(Node, 'LastName');
    SetPropertyFromNode(Node, 'Position');
    SetPropertyFromNode(Node, 'Street');
    SetPropertyFromNode(Node, 'Street2');
    SetPropertyFromNode(Node, 'Street3');
    SetPropertyFromNode(Node, 'Suburb');
    SetPropertyFromNode(Node, 'State');
    SetPropertyFromNode(Node, 'Country');
    SetPropertyFromNode(Node, 'Postcode');
    SetPropertyFromNode(Node, 'BillStreet');
    SetPropertyFromNode(Node, 'BillStreet2');
    SetPropertyFromNode(Node, 'BillStreet3');
    SetPropertyFromNode(Node, 'BillSuburb');
    SetPropertyFromNode(Node, 'BillState');
    SetPropertyFromNode(Node, 'BillCountry');
    SetPropertyFromNode(Node, 'BillPostcode');
    SetPropertyFromNode(Node, 'Phone');
    SetPropertyFromNode(Node, 'FaxNumber');
    SetPropertyFromNode(Node, 'Mobile');
    SetPropertyFromNode(Node, 'Email');
    SetPropertyFromNode(Node, 'AltPhone');
    SetDateTimePropertyFromNode(Node, 'CreationDate');
    SetDateTimePropertyFromNode(Node, 'UpdateDate');
    SetDateTimePropertyFromNode(Node, 'DateInactive');
    SetPropertyFromNode(Node, 'Notes');
    SetPropertyFromNode(Node, 'APBalance');
    SetPropertyFromNode(Node, 'Balance');
    SetPropertyFromNode(Node, 'SOBalance');
    SetPropertyFromNode(Node, 'TERMSName');
    SetPropertyFromNode(Node, 'Discount');
    SetPropertyFromNode(Node, 'SpecialDiscount');
    SetBooleanPropertyFromNode(Node, 'IsJob');
    SetPropertyFromNode(Node, 'Customfield1');
    SetPropertyFromNode(Node, 'Customfield2');
    SetPropertyFromNode(Node, 'Customfield3');
    SetPropertyFromNode(Node, 'Customfield4');
    SetPropertyFromNode(Node, 'Customfield5');
    SetPropertyFromNode(Node, 'Customfield6');
    SetPropertyFromNode(Node, 'Customfield7');
    SetPropertyFromNode(Node, 'Customfield8');
    SetPropertyFromNode(Node, 'Customfield9');
    SetPropertyFromNode(Node, 'Customfield10');
    SetPropertyFromNode(Node, 'Customfield11');
    SetPropertyFromNode(Node, 'Customfield12');
    SetPropertyFromNode(Node, 'Customfield13');
    SetPropertyFromNode(Node, 'Customfield14');
    SetPropertyFromNode(Node, 'Customfield15');
    SetBooleanPropertyFromNode(Node, 'Customer');
    SetBooleanPropertyFromNode(Node, 'Supplier');
    SetBooleanPropertyFromNode(Node, 'OtherContact');
    SetPropertyFromNode(Node, 'RepName');
    SetPropertyFromNode(Node, 'DefaultARAccount');
    SetPropertyFromNode(Node, 'DefaultAPAccount');
    SetDateTimePropertyFromNode(Node, 'Action');
    SetBooleanPropertyFromNode(Node, 'Active');
    SetBooleanPropertyFromNode(Node, 'DontContact');
    SetDateTimePropertyFromNode(Node, 'CompletionDate');
    SetPropertyFromNode(Node, 'URL');
    SetPropertyFromNode(Node, 'CombinedInvoiceBOID');
    SetPropertyFromNode(Node, 'CombinedSaleOrderBOID');
    SetBooleanPropertyFromNode(Node, 'StopCredit');
    SetBooleanPropertyFromNode(Node, 'Required');
    SetBooleanPropertyFromNode(Node, 'SendXMLInvoices');
    SetBooleanPropertyFromNode(Node, 'SendXMLPOs');
    SetBooleanPropertyFromNode(Node, 'ForcePOOnBooking');
    SetBooleanPropertyFromNode(Node, 'ForcePOOnInvoice');
    SetPropertyFromNode(Node, 'PickingPriority');
    SetPropertyFromNode(Node, 'CallPriority');

    SetBooleanPropertyFromNode(Node, 'GroupDiscountOverridesAll');
    SetBooleanPropertyFromNode(Node, 'SpecialProductPriceOverridesAll');
    SetBooleanPropertyFromNode(Node, 'UseInvBase');
    SetPropertyFromNode(Node, 'InvBaseNumber');
    SetDateTimePropertyFromNode(Node, 'ApprovalFromDate');
    SetDateTimePropertyFromNode(Node, 'ApprovalToDate');
    SetPropertyFromNode(Node, 'Tasks');
    SetDateTimePropertyFromNode(Node, 'ReminderDateTime');
    SetPropertyFromNode(Node, 'SpecialInstructions');
    SetDateTimePropertyFromNode(Node, 'CUSTDATE1');
    SetDateTimePropertyFromNode(Node, 'CUSTDATE2');
    SetDateTimePropertyFromNode(Node, 'CUSTDATE3');
    SetPropertyFromNode(Node, 'CustomerJobNumber');
    SetPropertyFromNode(Node, 'JobNumber');
    SetPropertyFromNode(Node, 'PortOfLanding');
    SetPropertyFromNode(Node, 'PortOfDischarge');
    SetPropertyFromNode(Node, 'FinalDestination');
    SetPropertyFromNode(Node, 'IncoPlace');
    SetPropertyFromNode(Node, 'TeamviewerID');
    SetPropertyFromNode(Node, 'ClientCode');
    SetPropertyFromNode(Node, 'SkypeName');
    SetPropertyFromNode(Node, 'ShippingAgentID');
    SetPropertyFromNode(Node, 'Status');

    SetPropertyFromNode(Node, 'AssessorsName');
    SetPropertyFromNode(Node, 'ExcessAmount');
    SetPropertyFromNode(Node, 'StormLocation');
    SetDateTimePropertyFromNode(Node, 'StormDate');
    SetDateTimePropertyFromNode(Node, 'Year');
    SetPropertyFromNode(Node, 'Colour');
    SetPropertyFromNode(Node, 'BodyType');
    SetPropertyFromNode(Node, 'BailmentNumber');
    SetPropertyFromNode(Node, 'BailmentAmountEx');
    SetDateTimePropertyFromNode(Node, 'StockReceivedDate');
    SetPropertyFromNode(Node, 'NewOrUsed');
    SetBooleanPropertyFromNode(Node, 'ClientPaysShippment');
    SetPropertyFromNode(Node, 'ClientShipperAccountNo');
    SetBooleanPropertyFromNode(Node, 'PublishOnVS1');


  if not ImportingFromXMLFile then
  begin
    SetPropertyFromNode(Node, 'MedTypeID');
    SetPropertyFromNode(Node, 'TermsID');
    SetPropertyFromNode(Node, 'RepID');
    SetPropertyFromNode(Node, 'DefaultAPAccountID');
    SetPropertyFromNode(Node, 'DefaultARAccountID');
    SetPropertyFromNode(Node, 'ParentClientID');
    SetPropertyFromNode(Node, 'ParentRelatedClientID');
    SetPropertyFromNode(Node, 'CompanyTypeId');
    SetPropertyFromNode(Node, 'clientTypeID');
  end
  else
  begin{foreignKeysValid is bein executed, so the fi variables has the value}
    MedTypeID := FIMedTypeID;
    TermsID        := fiTermsID;
    RepID          := fiRepNameID;
    ParentClientID := fiParentClientID;
    ParentRelatedClientID := fiParentRelatedClientID;
    CompanyTypeId  := FICompanyTypeId;
    clientTypeID   := FIclientTypeID;
  end;
end;
Class function TClient.CmpanyInfoClientID(AOwner:TComponent; aIsCustomer, aIsSupplier, aIsOthercontact:Boolean):Integer;
var
  Client : TClient;
begin
  Client := TClient.CreateWithNewConn(AOwner);
  try
    client.Load(0);
    client.connection.BeginTransaction;
    client.MakeClientFromCmpanyInfo(Appenv.CompanyInfo, aIsCustomer, aIsSupplier, aIsOthercontact);
    result := client.ID;
    client.connection.CommitTransaction;
  finally
    Freeandnil(Client);
  end;

end;

procedure TClient.MakeClientFromCmpanyInfo(CompInfo: TMsBusobj; aIsCustomer,  aIsSupplier, aIsOthercontact: Boolean);
begin
  if not (CompInfo   is TCompanyInfo ) then exit;
  Connection.BeginNestedTransaction;
  try
    LoadSelect('company =' +quotedstr(TCompanyInfo(CompInfo).CompanyName));
    if count =0 then begin
      New;
      Customer := True;
      ClientName := TCompanyInfo(CompInfo).CompanyName;
      Printname := ClientName;
      if TCompanyInfo(CompInfo).Firstname <> '' then FirstName := TCompanyInfo(CompInfo).Firstname else FirstName := TCompanyInfo(CompInfo).CompanyName;
      if TCompanyInfo(CompInfo).LastName  <> '' then LastName  := TCompanyInfo(CompInfo).LastName else if AppEnv.CompanyPrefs.EnforceCustomerFirstAndLastName then Lastname := '.';

      Phone         := TCompanyInfo(CompInfo).PhoneNumber;
      Faxnumber     := TCompanyInfo(CompInfo).FaxNumber;
      Mobile        := TCompanyInfo(CompInfo).MobileNumber;
      Email         := TCompanyInfo(CompInfo).Email;
      Street        := TCompanyInfo(CompInfo).Address;
      Street2       := TCompanyInfo(CompInfo).Address2;
      Street3       := TCompanyInfo(CompInfo).Address3;
      Suburb        := TCompanyInfo(CompInfo).City;
      State         := TCompanyInfo(CompInfo).State;
      Postcode      := TCompanyInfo(CompInfo).Postcode;
      Country       := TCompanyInfo(CompInfo).Country;
      BillStreet    := TCompanyInfo(CompInfo).POBox;
      BillStreet2   := TCompanyInfo(CompInfo).POBox2;
      BillStreet3   := TCompanyInfo(CompInfo).POBox3;
      BillSuburb    := TCompanyInfo(CompInfo).POCity;
      BillState     := TCompanyInfo(CompInfo).POState;
      BillPostcode  := TCompanyInfo(CompInfo).POPostcode;
      BillCountry   := TCompanyInfo(CompInfo).POCountry;
    end;
    if aIscustomer     then IsCustomer    := True;
    if aIsSupplier     then IsSupplier    := true;
    if aIsOthercontact then IsOthercontact:= True;
    PostDB;
    if Contacts.count =0 then begin
      Contacts.ClientID          := ID;
      Contacts.ContactTitle      := Title;
      Contacts.ContactFirstName  := FirstName;
      Contacts.ContactSurName    := LastName;
      Contacts.ContactMOB        := Mobile;
      Contacts.jobtitle          := JobTitle;
      Contacts.ContactEmail      := Email;
      Contacts.Company           := Trim(Contacts.ContactFirstName + ' ' + Contacts.ContactSurname);
      Contacts.ISPrimaryContact  := True;
      Contacts.ContactPH         := Phone;
      Contacts.ContactFax        := FaxNumber;
      Contacts.ContactAltPH      := AltPhone;
      Contacts.ContactAddress    := Street;
      Contacts.ContactAddress2   := Street2;
      Contacts.ContactAddress3   := Street3;
      Contacts.ContactCity       := Suburb;
      Contacts.ContactState      := State;
      Contacts.ContactPcode      := Postcode;
      Contacts.Contactcountry    := Country;
      Contacts.TeamviewerID      := TeamviewerID;
      Contacts.Active            := True;
      Contacts.PostDB;
    end;
    if Save then connection.CommitNestedTransaction else Connection.RollbackNestedTransaction;
  Except
    on E:Exception do begin
      Connection.RollbackNestedTransaction;
    end;
  end;
end;
function TClient.DoMakeclient(AOwner:TComponent; aClientName: String;CreateifnotExists:Boolean =False; aSource:String = ''): Integer;
begin
  REsult := 0;
    DoMakeclient(AOwner,aClientName,aSource);
    LoadSelect('company =' +quotedstr(aClientName));
    if (count =1 )  then begin
        if not isCustomer then begin
          Iscustomer := True;
          ClientTypeID := DefaultclientTypeId;
          PostDB;
        end;
        REsult := ID;
    end;
end;
function TClient.DoMakeMagentoclient(AOwner:TComponent; aFirstname, aLastname, aEmail: String;aSource:String = ''): Boolean;
begin
  if Appenv.Companyprefs.ISMagentoCustomerIDEmail  and (trim(aEmail)<> '') then begin
     Loadselect('Email =' + quotedstr(aEmail));
     if (count<>0)  then begin
      if devmode then begin
        // when same email used for differnet name,
        // loging in devmode to see the difference in the name
        if (Firstname <> trim(aFirstname)) or (Lastname  <> trim(aLastName)) then
          Notes := trim(Notes + NL + Firstname +' ' +Lastname);
      end;
      if Firstname <> trim(aFirstname) then firstname := trim(afirstName);
      if Lastname  <> trim(aLastName)  then Lastname  := Trim(Lastname);
      result := true;
      Exit;
     end;
  end;
  REsult := DoMakeclient(AOwner, TRim(afirstname)+' ' + trim(aLastname), aSource);
end;
function TClient.DoMakeclient(AOwner:TComponent; aClientName: String;aSource:String = ''): Boolean;
begin
      result := False;
      Loadselect('company =' + quotedstr(aClientName));
      if (count=0)  then begin
          connection.BeginTransaction;
          try
            New;
            ClientName := aClientName;
            Printname := ClientName;
            if AppEnv.CompanyPrefs.EnforceCustomerFirstAndLastName then begin
              Firstname :=aClientName;
              Lastname := '.';
            end;
            if AppEnv.CompanyPrefs.EnforcesupplierFirstName then begin
              Firstname :=aClientName;
            end;
            MedTypeID := TSource.MakeSource(AOwner, aSource, nil, true);
            PostDB;
            if not save then begin
              Connection.RollbackTransaction;
              Exit;
            end;
            Connection.CommitTransaction;
            Result := true;
          Except
            on E:Exception do begin
              Resultstatus.addItem(False ,rssWarning, 0 ,'Creation of customert Failed.' + NL+ E.message);
              Connection.RollbackTransaction;
              Exit;
            end;
          end;

        end;
end;
(*class function TClient.MakeSuppleir(AOwner:TComponent; aSuppleirname: String): Integer;
begin
  Result := 0;
  with TClient.CreateWithNewConn(AOwner) do try
    Loadselect('company =' + quotedstr(aSuppleirname));
    if (count =1 )  then begin
      if not isSupplier then begin
        isSupplier := True;
        PostDB;
      end;
      REsult := ID;
    end;
  finally
    Free;
  end;
end;*)

class function TClient.MakeCustomerContact(const ClientID: Integer;AOwner:TComponent; fConnection :TERPConnection=nil): Integer;
var
  Client :TClient;
  newconn:Boolean;
begin
  result :=0;
  Client :=TClient.CreateWithNewConn(Aowner);
  newconn :=fConnection=nil;
  if fConnection = nil then begin
    fConnection := GetNewMyDacConnection(Client);
    Client.Connection.BeginTransaction;
  end;
  Client.connection.connection := fConnection;
  Client.Load(ClientID);
  if Client.count =0 then exit;
  if Client.Contacts.count>0 then begin
    Client.Contacts.Locate('IsPrimaryContact', 'T' , []);
    Result := Client.Contacts.Id;
    Exit;
  end;

  if not Client.Lock then begin
    Client.Resultstatus.addItem(False ,rssWarning, 0 ,
    Replacestr(client.UserLock.LockMessage, 'Unable to update data.' , 'Unable to Make Primary Contact for ' + Client.clientname +'.' ),true );
    exit;
  end;
  try
               REsult := Client.DoMakePrimaryContact;
               if Result >0  then begin
                  if newconn then  Client.Connection.CommitTransaction;
      end else if newconn then  Client.Connection.RollbackTransaction;;
  finally
    Client.UnLock;
    FreeandNil(Client);
  end;
end;


procedure TClient.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin 
  inherited;
end;
function TClient.GetTerms: TTerms;
begin
 result := TTerms(GetContainerComponent(TTerms ,'TermsID = ' + IntToStr(TermsID) ));
end;
function TClient.GetTaxCode: TTaxCode;
begin
  result := TTaxCode(GetContainerComponent(TTaxCode ,'TaxCodeID = ' + IntToStr(TaxID) ));
end;
function TClient.GetDefaultClass: TDeptClass;
begin
  result := TDeptClass(GetContainerComponent(TDeptClass ,'ClassName = ' + QuotedStr(DefaultClassName) ));
end;
function TClient.GetClientType: TClientType;
begin
  result := TClientType(GetContainerComponent(TClientType ,'ClientTypeId = ' + IntToStr(ClientTypeId) ));
end;

Function TClient.GetParentClient: TClient;
begin
  result := nil;
  if ParentClientId < 1 then
    exit;
  result := TClient(GetContainerComponent(TClient ,'ClientId = ' + IntToStr(ParentClientId) ));
end;

function TClient.GetShippingMethod: TShippingMethod;
begin
  result := TShippingMethod(GetContainerComponent(TShippingMethod ,'ShippingMethodID = ' + IntToStr(ShippingID) ));
end;
function TClient.GetGroupDiscounts: TProductGroupDiscount;
begin
  result := TProductGroupDiscount(GetContainerComponent(TProductGroupDiscount ,'ClientID = ' + IntToStr(ID) ));
end;
function TClient.GetContacts: TContact;
begin
  result := TContact(GetContainerComponent(TContact ,'ClientID = ' + IntToStr(ID) ));
end;
function TClient.GetSpecialProducts: TSpecialProducts;
begin
  result := TSpecialProducts(GetContainerComponent(TSpecialProducts ,'CustomerId = ' + IntToStr(ID) ));
end;
function TClient.GetOtherFollowUps: TOtherFollowUps;
var
  strSQL: string;
begin
    strSQL := 'ClientID = ' + IntToStr(ID);
         if self is TCustomer     then strSQL := strSQL + ' and IsCustomer = "T" '
    else if self is TSupplier     then strSQL := strSQL + ' and ISSupplier = "T" '
    else if self is TOthercontact then strSQL := strSQL + ' and IsOtherContact = "T" ';
    result := TOtherFollowUps(GetContainerComponent(TOtherFollowUps ,strSQL ));
end;

class function TClient.GetIDField: string;
begin 
  Result := 'ClientId';
end;

function TClient.foreignKeysValid(const node: IXMLNode): Boolean;
var 
  fsXMLTag: string;
begin 
  Result := false;
  fiMedTypeID := 0;
  fiTermsID := 0;
  fiRepNameID := 0;
  fiParentClientID := 0;
  fiParentRelatedClientID := 0;
  fiPickingPriority := 0;
  fiCompanyTypeID := 0;
  fsXMLTag := 'MedType';
    if GetXMLNodeStringValue(Node, fsXMLTag) <>'' then begin
        fiMedTypeID := tcDataUtils.getMediatype(GetXMLNodeStringValue(Node, fsXMLTag));
        if  fiMedTypeID = 0 then begin
            ErrRecordNotfound(fsXMLTag , GetXMLNodeStringValue(Node, fsXMLTag));
            Exit;
        End;
    end;
    fsXMLTag :='Terms';
    if GetXMLNodeStringValue(Node, fsXMLTag) <>'' then begin
        fiTermsID := tcDataUtils.GetTerms(GetXMLNodeStringValue(Node, fsXMLTag));
        if  fiTermsID = 0 then begin
            ErrRecordNotfound(fsXMLTag , GetXMLNodeStringValue(Node, fsXMLTag));
            Exit;
        End;
    end;
    fsXMLTag :='RepName';
    if GetXMLNodeStringValue(Node, fsXMLTag) <>'' then begin
        fiRepNameID := tcDataUtils.getemployeeID(GetXMLNodeStringValue(Node, fsXMLTag));
        if  fiRepNameID = 0 then begin
            ErrRecordNotfound(fsXMLTag , GetXMLNodeStringValue(Node, fsXMLTag));
            Exit;
        End;
    end;
    fsXMLTag :='ParentClient';
    if GetXMLNodeStringValue(Node, fsXMLTag) <>'' then begin
        fiParentClientID := TClient.IDToggle(GetXMLNodeStringValue(Node, fsXMLTag), Connection.Connection);
        if  fiParentClientID = 0 then begin
            ErrRecordNotfound(fsXMLTag , GetXMLNodeStringValue(Node, fsXMLTag));
            Exit;
        End;
    end;

    fsXMLTag :='ParentRelatedClient';
    if GetXMLNodeStringValue(Node, fsXMLTag) <>'' then begin
        fiParentRelatedClientID := TClient.IDToggle(GetXMLNodeStringValue(Node, fsXMLTag), Connection.Connection);
        if  fiParentRelatedClientID = 0 then begin
            ErrRecordNotfound(fsXMLTag , GetXMLNodeStringValue(Node, fsXMLTag));
            Exit;
        End;
    end;
    fsXMLTag :='CompanyType';
    if GetXMLNodeStringValue(Node, fsXMLTag) <>'' then begin
        fiCompanyTypeID := TCompanyType.IDToggle(GetXMLNodeStringValue(Node, fsXMLTag),self.Connection.Connection);
        if  fiCompanyTypeID = 0 then begin
            ErrRecordNotfound(fsXMLTag , GetXMLNodeStringValue(Node, fsXMLTag));
            Exit;
        End;
    end;
    fsXMLTag :='PickingPriority';
    if GetXMLNodeStringValue(Node, fsXMLTag) <>'' then begin
        fiPickingPriority := tcdatautils.getPickingPriority(GetXMLNodeStringValue(Node, fsXMLTag));
    End;
    Result := true;
end;

Function TClient.ValidateXMLData(Const Node :IXMLNode) :Boolean;
begin
    Result := inherited ValidateXMLData(Node);

    if not Result then Exit;
    if not ImportingFromXMLFile then Exit;
    XMLSearchRecordDesc :='Company = '  + GetXMLNodeStringValue(Node,'company');
    Result := False;
    if not ForeignKeysValid(Node) then Exit;

    Result := true;
    XMLSearchRecord :='Company = '  + QuotedStr(GetXMLNodeStringValue(Node,'company'));
    LocateXMLRecord;
End;

class function TClient._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TDeptClass','DefaultClass','DefaultClassID','ID');
  TBOSchema.AddRefType(result,'TDeptClass','DefaultClass','DefaultClassName','DeptClassName');
  TBOSchema.AddRefType(result,'TClientType','ClientType','ClientTypeID','ID');
  TBOSchema.AddRefType(result,'TClientType','ClientType','ClientTypeName','TypeName');
  TBOSchema.AddRefType(result,'TTaxCode','TaxCode','TaxID','ID');
  TBOSchema.AddRefType(result,'TTaxCode','TaxCode','TaxCodeName','CodeName');
  TBOSchema.AddRefType(result,'TTerms','Terms','TermsID','ID');
  TBOSchema.AddRefType(result,'TTerms','Terms','TermsName','TermsName');
  TBOSchema.AddRefType(result,'TEmployee','RepObj','RepID','ID');
  TBOSchema.AddRefType(result,'TAccount','APAccObj','DefaultAPAccountID','ID');
  TBOSchema.AddRefType(result,'TAccount','ARAccObj','DefaultARAccountID','ID');
  TBOSchema.AddRefType(result,'TAccount','ARAccObj','DefaultARAccount','AccountName');
  TBOSchema.AddRefType(result,'TAccount','APAccObj','DefaultAPAccount','AccountName');
  TBOSchema.AddRefType(result,'TEmployee','RepObj','RepName','EmployeeName');
  TBOSchema.AddRefType(result,'TCompanyType','CompanyTypeObj','CompanyTypeID','ID');
  TBOSchema.AddRefType(result,'TCompanyType','CompanyTypeObj','CompanyTypeName','TypeName');
  TBOSchema.AddRefType(result,'TSource','SourceObj','MedTypeID','ID');
  TBOSchema.AddRefType(result,'TSource','SourceObj','SourceName','MediaType');
  TBOSchema.AddRefType(result,'TShippingMethod','ShippingMethodObj','ShippingID','ID');
  TBOSchema.AddRefType(result,'TShippingMethod','ShippingMethodObj','ShippingMethodName','ShippingMethod');
  TBOSchema.AddRefType(result,'TPaymentMethod','PaymentMethodObj','PayMethodID','ID');
  TBOSchema.AddRefType(result,'TPaymentMethod','PaymentMethodObj','PaymentMethodName','PaymentMethodName');
  TBOSchema.AddRefType(result,'TCurrency','ForeignExchangeCodeObj','ForeignExchangeCode','Code');
  TBOSchema.AddRefType(result,'TManufacture','Manufacture','TManufactureID','ID');
  TBOSchema.AddRefType(result,'TManufacture','Manufacture','ManufactureName','ManufactureName');
  TBOSchema.AddRefType(result,'TModel','Model','ModelNumber','ModelNameName');
end;

Function    TClient.ExportsubClasses(Const Node: IXMLNode):Boolean;
begin
    self.Contacts.XMLPropertyNode := node.AddChild('Contacts');
    self.Contacts.XMLPropertyName:= 'Contacts';
    self.Contacts.IterateRecords(GetPropertyXMLCallback);

    self.OtherFollowUps.XMLPropertyNode := node.AddChild('OtherFollowUps');
    self.OtherFollowUps.XMLPropertyName:= 'FollowUps';
    self.OtherFollowUps.IterateRecords(GetPropertyXMLCallback);

    if Self is TCustomer then  begin
        TCustomer(self).CustomerEquipment.XMLPropertyNode := node.AddChild('CustomerEquipments');
        TCustomer(self).CustomerEquipment.XMLPropertyName:= 'CustomerEquipment';
        TCustomer(self).CustomerEquipment.IterateRecords(GetPropertyXMLCallback);
    End;
    self.ProductGroupDiscount.XMLPropertyNode := node.AddChild('GroupDiscounts');
    self.ProductGroupDiscount.XMLPropertyName:= 'Discount';
    self.ProductGroupDiscount.IterateRecords(GetPropertyXMLCallback);

    self.SpecialProducts.XMLPropertyNode := node.AddChild('SpecialProduct');
    self.SpecialProducts.XMLPropertyName:= 'Product';
    self.SpecialProducts.IterateRecords(GetPropertyXMLCallback);

    Result := true;
end;

Function    TClient.ImportsubClasses(Const node: IXMLNode):Boolean;
var
    x:Integer;
    Singlerec :IXMLNode;
begin
    Result := False;
    XMLPropertyName :='Contacts';
    XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
    if Assigned(XMLPropertyNode) then begin
        for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
            Contacts.ImportingFromXMLFile := True;
            Singlerec:= XMLPropertyNode.ChildNodes[x];
            Contacts.ImportFromXML(SingleRec);
            ImportFailed :=Contacts.ImportFailed;
            if Error then Exit;
        end;
    end;
    ImportFailed := False;

    XMLPropertyName :='OtherFollowUps';
    XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
    if Assigned(XMLPropertyNode) then begin
        for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
            OtherFollowUps.ImportingFromXMLFile := True;
            Singlerec:= XMLPropertyNode.ChildNodes[x];
            OtherFollowUps.ImportFromXML(SingleRec);
            ImportFailed :=OtherFollowUps.ImportFailed;
            if Error then Exit;
        end;
    end;
    ImportFailed := False;

    XMLPropertyName :='GroupDiscounts';
    XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
    if Assigned(XMLPropertyNode) then begin
        for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
            ProductGroupDiscount.ImportingFromXMLFile := True;
            Singlerec:= XMLPropertyNode.ChildNodes[x];
            ProductGroupDiscount.ImportFromXML(SingleRec);
            ImportFailed :=ProductGroupDiscount.ImportFailed;
            if Error then Exit;
        end;
    end;
    ImportFailed := False;

    XMLPropertyName :='SpecialProduct';
    XMLPropertyNode := node.ChildNodes.FindNode(XMLPropertyName);
    if Assigned(XMLPropertyNode) then begin
        for x := 0 to XMLPropertyNode.ChildNodes.Count - 1 do begin
            SpecialProducts.ImportingFromXMLFile := True;
            Singlerec:= XMLPropertyNode.ChildNodes[x];
            SpecialProducts.ImportFromXML(SingleRec);
            ImportFailed :=SpecialProducts.ImportFailed;
            if Error then Exit;
        end;
    end;
    ImportFailed := False;

    Result := true;
end; 

function TClient.GetFECode: string;
begin 
  Result := GetStringField('ForeignExchangeSellCode');
  if result = '' then Result := AppEnv.RegionalOptions.ForeignExDefault;
end;


function TClient.getTypeofclientRec: String;
begin
  result := '';
  if iscustomer then result := 'Customer';
  if IsSupplier then begin
    if result <> '' then result := result +' / ';
    result := result + 'Supplier';
  end;
  if IsOtherContact then begin
    if result <> '' then result := result +' / ';
    result := result + 'Prospect';
  end;
end;

function TClient.GetCreditBalance: Double;
begin
  if AppEnv.CompanyPrefs.CreditCheckSO then
    Result := Balance + SalesOrderBalance
  else
    Result := Balance;
end;
function TSupplier.getTotalSupplierCredit: double;
begin
  REsult := RunningAPBalance; // don't use Supplier's APbalance as that includes the Invoiced transactions only
  if    appenv.CompanyPrefs.CreditcheckPOIncludeBO then
    REsult := Result +ApBackOrderbalance;
end;


function TSupplier.getApBackOrderbalance: double;
begin
  with getNEwDataset ('select  sum(PL.Linecostinc *PL.qtysold) Estimatedcost  ' +
                      ' from tblpurchaseorders PO   ' +
                      ' inner join tblPurchaselines PL on PO.PurchaseOrderID = PL.PurchaseOrderID   ' +
                      ' where ifnull(PO.BOID , "") = "" and ifnull(PL.shipped,0) = 0 and PO.IsPO = "T" and ClientID = ' +inttostr(ID), true) do try
    Result := fieldByname('Estimatedcost').AsFloat;
  finally
    if active then close;
    free;
  end;
end;

function TClient.GetClientrCustomFieldValues: TClientCustomFieldValues;
begin
  result := TClientCustomFieldValues(GetContainerComponent(TClientCustomFieldValues ,'MasterId = ' + IntToStr(Self.ID) ));
end;

function TClient.GetClientShipperAccountNo: string;
begin
  result := GetStringField('ClientShipperAccountNo');
end;

function TClient.GetModel: TModel;
begin
  result := TModel(GetContainerComponent(TModel ,'Name = ' + QuotedStr(Self.ModelNumber), false));
end;
class function TClient.ClientPhone(aClientName: string;
  Conn: TERPConnection): string;
var
  C: TClient;
begin
  result := '';
  c:= TClient.Create(nil);
  try
    C.Connection := TMyDacDataConnection.Create(C);
    if Assigned(Conn) then C.Connection.Connection := Conn
    else C.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
    C.LoadSelect('Company = ' + QuotedStr(aClientName));
    if C.Count = 1 then
      result := C.Phone;
  finally
    C.Free;
  end;
end;

function TClient.ClientPrintName(NewLineBefore, NewLineAfter,HidewhensamecleintName: Boolean): String;
begin
  REsult := '';
  if HidewhensamecleintName and Sametext(clientName, Printname) then exit;

  result := Printname;
  if NewLineBefore then result :=#13#10 +REsult;
  if NewLineAfter  then result :=REsult + #13#10;
end;

class function TClient.ClientPrintnameToggle(const aclientID: Integer; Connection: TCustomMyConnection=nil): string;
var
  qry: TERPQuery;
begin
  if connection = nil then connection :=GetSharedMyDacConnection;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(connection);
  try
      Qry.SQl.Text :='Select Printname from tblclients where clientId = ' + inttostr(aclientID);
      Qry.Open;
      REsult := Qry.fieldbyname('Printname').AsString;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TClient.ClientStreetAddress(aClientName: string;
  Conn: TERPConnection): string;
var
  C: TClient;
begin
  result := '';
  c:= TClient.Create(nil);
  try
    C.Connection := TMyDacDataConnection.Create(C);
    if Assigned(Conn) then C.Connection.Connection := Conn
    else C.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
    C.LoadSelect('Company = ' + QuotedStr(aClientName));
    if C.Count = 1 then
      result := C.StreetAddress;
  finally
    C.Free;
  end;
end;
procedure TClient.MainContactCallBack(const Sender: TBusObj; var Abort: Boolean);
begin
  if not(Sender is Tcontact) then exit;
  if TContact(Sender).Isprimarycontact          then begin fsPrimaryContactName        := TContact(Sender).contactfullname;end;
  if TContact(Sender).Isprimarycontact          then begin fiPrimarycontactId          := TContact(Sender).ID             ;end;
  if TContact(Sender).MainContactforCashSale    then begin fiDisabledMainContactIDforCashSale  := TContact(Sender).ID;if TContact(Sender).NotaMainContact = False then  fiMainContactIDforCashSale  := TContact(Sender).ID;end;
  if TContact(Sender).MainContactforVoucher     then begin fiDisabledMainContactIDforVoucher   := TContact(Sender).ID;if TContact(Sender).NotaMainContact = False then  fiMainContactIDforVoucher   := TContact(Sender).ID;end;
  if TContact(Sender).MainContactforPOS         then begin fiDisabledMainContactIDforPOS       := TContact(Sender).ID;if TContact(Sender).NotaMainContact = False then  fiMainContactIDforPOS       := TContact(Sender).ID;end;
  if TContact(Sender).MainContactforRefund      then begin fiDisabledMainContactIDforRefund    := TContact(Sender).ID;if TContact(Sender).NotaMainContact = False then  fiMainContactIDforRefund    := TContact(Sender).ID;end;
  if TContact(Sender).MainContactforInvoice     then begin fiDisabledMainContactIDforInvoice   := TContact(Sender).ID;if TContact(Sender).NotaMainContact = False then  fiMainContactIDforInvoice   := TContact(Sender).ID;end;
  if TContact(Sender).MainContactforSalesOrder  then begin fiDisabledMainContactIDforSalesOrder:= TContact(Sender).ID;if TContact(Sender).NotaMainContact = False then  fiMainContactIDforSalesOrder:= TContact(Sender).ID;end;
  if TContact(Sender).MainContactforStatements  then begin fiDisabledMainContactIDforStatements:= TContact(Sender).ID;if TContact(Sender).NotaMainContact = False then  fiMainContactIDforStatements:= TContact(Sender).ID;end;
  if TContact(Sender).MainContactforQuote       then begin fiDisabledMainContactIDforQuote     := TContact(Sender).ID;if TContact(Sender).NotaMainContact = False then  fiMainContactIDforQuote     := TContact(Sender).ID;end;
  if TContact(Sender).MainContactforCheque      then begin fiDisabledMainContactIDforCheque    := TContact(Sender).ID;if TContact(Sender).NotaMainContact = False then  fiMainContactIDforCheque    := TContact(Sender).ID;end;
  if TContact(Sender).MainContactforCredit      then begin fiDisabledMainContactIDforCredit    := TContact(Sender).ID;if TContact(Sender).NotaMainContact = False then  fiMainContactIDforCredit    := TContact(Sender).ID;end;
  if TContact(Sender).MainContactforBill        then begin fiDisabledMainContactIDforBill      := TContact(Sender).ID;if TContact(Sender).NotaMainContact = False then  fiMainContactIDforBill      := TContact(Sender).ID;end;
  if TContact(Sender).MainContactforPO          then begin fiDisabledMainContactIDforPO        := TContact(Sender).ID;if TContact(Sender).NotaMainContact = False then  fiMainContactIDforPO        := TContact(Sender).ID;end;
  if TContact(Sender).MainContactforRA          then begin fiDisabledMainContactIDforRA        := TContact(Sender).ID;if TContact(Sender).NotaMainContact = False then  fiMainContactIDforRA        := TContact(Sender).ID;end;
  if TContact(Sender).MainContactforRepair      then begin fiDisabledMainContactIDforRepair    := TContact(Sender).ID;if TContact(Sender).NotaMainContact = False then  fiMainContactIDforRepair    := TContact(Sender).ID;end;
  if TContact(Sender).MainContactforSupplierPayment then begin fiDisabledMainContactIDforSupplierPayment := TContact(Sender).ID;if TContact(Sender).NotaMainContact = False then  fiMainContactIDforSupplierPayment := TContact(Sender).ID;end;
end;

function TClient.GetBillingAddress: string;
begin
  Result:= ConcatStrings([BillStreet , BillStreet2  , BillStreet3  ,ConcatStrings([BillSuburb , BillState ,BillPostCode ], ' ') , BillCountry ],#13+#10);
end;

function TClient.GetBillingAddressWithName: string;
begin
  Result := trim(clientName +   #13 + #10 + BillingAddress);
end;

Function TClient.getClientDetails:String;
begin
      Result := Trim(Title + ' ' + FirstName  + ' ' +
                LastName+ #13 + #10 + ClientName + #13 + #10 +
                streetAddress);

end;

function TClient.GetStreetAddress: string;
var
  s: string;
begin
  Result := '';
  if Street <> '' then
    Result := Result + Street + #13 + #10;
  if Street2 <> '' then
    Result := Result + Street2 + #13 + #10;
  if Street3 <> '' then
    Result := Result + Street3 + #13 + #10;
  if Suburb <> '' then
    result := result + #13#10 + Suburb;
  s:= '';
  if State <> '' then
    s := State;
  if PostCode  <> '' then begin
    if s <> '' then s := s  + ' ';
    s := s  + Postcode;
  end;
  if s <> '' then
    result := result  + #13#10 + s;
  if Country <> '' then
    Result := Result + #13 + #10 + Country;
end;
function TClient.GetStreetAddressWithName: string;
begin
    Result := StreetAddress;
    if rEsult = '' then result := ClientName
    else Result := clientName +  #13 + #10 + Result;
end;
function TClient.GetStopCredit: Boolean;
begin
  if (ParentClientID > 0) and (ParentClientId <> self.Id) then
    Result := ParentClient.StopCredit
  else
    Result := GetBooleanField('StopCredit');
end;
procedure TClient.SetStopCredit(const Value: Boolean);
begin
  if Assigned(ParentClient) then
    ParentClient.StopCredit := Value
  else
    SetBooleanField('StopCredit', Value);
end;

function TCustomer.getShippingAddresses: TShippingAddress;
begin
  result := TShippingAddress(GetContainerComponent(TShippingAddress ,'Customer_ID = ' + IntToStr(Self.ID) ));
end;

function TCustomer.getShippingAddressLink: Tclienttoshipaddresslink;
begin
  result := Tclienttoshipaddresslink(GetContainerComponent(Tclienttoshipaddresslink ,'ClientID = ' + IntToStr(Self.ID) ));
end;

function TCustomer.getSOBackOrderBalance: double;
begin
     With GetNewDataset('select  sum(SL.LinePriceInc *SL.qtysold) Estimatedprice  '+
                        ' from tblsales S   '+
                        ' inner join tblsaleslines SL on S.SaleID = SL.SaleID   '+
                        ' where ifnull(S.BOID , "") = "" and S.IsSalesOrder = "T" and clientId = ' +inttostr(ID)  , true) do try
        result := fieldbyname('Estimatedprice').AsFloat;
     finally
        if active then close;
        Free;
     end;

end;
function TClient.GetClientTypeName: string;
begin
  if Assigned(ClientType) then
    result:= ClientType.TypeName
  else
    result:= '';
end;

procedure TClient.SetClientTypeName(const Value: string);
begin
  ClientTypeId:= TClientType.IDToggle(value,connection.Connection);
end;
function TClient.getCompanyname: String;
var
  strArray: TStringDynArray;
begin
  result:= '';
  if ClientName <> '' then begin
    strArray:= StrUtils.SplitString(ClientName,'^');
    result:= strArray[0];
    finalize(strArray);
  end;
end;
function TClient.getMainContactIDforSupplierPayment: Integer;
begin
  fiMainContactIDforSupplierPayment := 0;
  fiDisabledMainContactIDforSupplierPayment := 0;
  Contacts.IterateRecords(MainContactCallBack);
  result :=  fiMainContactIDforSupplierPayment;
end;


function TClient.getPrimarycontactNAme        : String  ;  begin fsPrimaryContactName         := '';Contacts.IterateRecords(MainContactCallBack); Result :=  fsPrimaryContactName        ; end;
function TClient.getPrimarycontactId          : Integer ;  begin fiPrimarycontactId           := 0; Contacts.IterateRecords(MainContactCallBack); Result :=  fiPrimarycontactId          ; end;
function Tclient.GetMainContactIDforCashSale  : Integer ;  begin fiMainContactIDforCashSale   := 0; fiDisabledMainContactIDforCashSale   := 0; Contacts.IterateRecords(MainContactCallBack); result :=  fiMainContactIDforCashSale  ; end;
function Tclient.GetMainContactIDforVoucher   : Integer ;  begin fiMainContactIDforVoucher    := 0; fiDisabledMainContactIDforVoucher    := 0; Contacts.IterateRecords(MainContactCallBack); result :=  fiMainContactIDforVoucher   ; end;
function Tclient.GetMainContactIDforPOS       : Integer ;  begin fiMainContactIDforPOS        := 0; fiDisabledMainContactIDforPOS        := 0; Contacts.IterateRecords(MainContactCallBack); result :=  fiMainContactIDforPOS       ; end;
function Tclient.GetMainContactIDforRefund    : Integer ;  begin fiMainContactIDforRefund     := 0; fiDisabledMainContactIDforRefund     := 0; Contacts.IterateRecords(MainContactCallBack); result :=  fiMainContactIDforRefund    ; end;
function Tclient.GetMainContactIDforInvoice   : Integer ;  begin fiMainContactIDforInvoice    := 0; fiDisabledMainContactIDforInvoice    := 0; Contacts.IterateRecords(MainContactCallBack); result :=  fiMainContactIDforInvoice   ; end;
function Tclient.GetMainContactIDforSalesOrder: Integer ;  begin fiMainContactIDforSalesOrder := 0; fiDisabledMainContactIDforSalesOrder := 0; Contacts.IterateRecords(MainContactCallBack); result :=  fiMainContactIDforSalesOrder; end;
function Tclient.GetMainContactIDforStatements: Integer ;  begin fiMainContactIDforStatements := 0; fiDisabledMainContactIDforStatements := 0; Contacts.IterateRecords(MainContactCallBack); result :=  fiMainContactIDforStatements; end;
function Tclient.GetMainContactIDforQuote     : Integer ;  begin fiMainContactIDforQuote      := 0; fiDisabledMainContactIDforQuote      := 0; Contacts.IterateRecords(MainContactCallBack); result :=  fiMainContactIDforQuote     ; end;
function Tclient.GetMainContactIDforCheque    : Integer ;  begin fiMainContactIDforCheque     := 0; fiDisabledMainContactIDforCheque     := 0; Contacts.IterateRecords(MainContactCallBack); result :=  fiMainContactIDforCheque    ; end;
function Tclient.GetMainContactIDforCredit    : Integer ;  begin fiMainContactIDforCredit     := 0; fiDisabledMainContactIDforCredit     := 0; Contacts.IterateRecords(MainContactCallBack); result :=  fiMainContactIDforCredit    ; end;
function Tclient.GetMainContactIDforBill      : Integer ;  begin fiMainContactIDforBill       := 0; fiDisabledMainContactIDforBill       := 0; Contacts.IterateRecords(MainContactCallBack); result :=  fiMainContactIDforBill      ; end;
function Tclient.GetMainContactIDforPO        : Integer ;  begin fiMainContactIDforPO         := 0; fiDisabledMainContactIDforPO         := 0; Contacts.IterateRecords(MainContactCallBack); result :=  fiMainContactIDforPO        ; end;
function Tclient.GetMainContactIDforRA        : Integer ;  begin fiMainContactIDforRA         := 0; fiDisabledMainContactIDforRA         := 0; Contacts.IterateRecords(MainContactCallBack); result :=  fiMainContactIDforRA        ; end;
function Tclient.GetMainContactIDforRepair    : Integer ;  begin fiMainContactIDforRepair     := 0; fiDisabledMainContactIDforRepair     := 0; Contacts.IterateRecords(MainContactCallBack); result :=  fiMainContactIDforRepair    ; end;
procedure TClient.SetFECode(const Value: string);begin  SetStringField('ForeignExchangeSellCode', Value);end;
function TClient.GetFirstName: string;begin  Result := GetStringField('FirstName');end;
function TClient.GetLastName: string;begin  Result := GetStringField('LastName');end;
function TClient.GetMiddleName: string;begin  Result := GetStringField('MiddleName');end;
function TClient.GetClientName: string;begin  Result := GetStringField('Company');end;
function TClient.GetPrintName : string;begin  Result := GetStringField('PrintName');end;
function TClient.GetTitle: string;begin  Result := GetStringField('Title');end;
function TClient.GetTermsName: string;begin  Result := GetStringField('Terms');end;
function TClient.GetABN: string;begin  Result := GetStringField('ABN');end;
function TClient.GetCreditLimit: Double;begin  Result := GetFloatField('CreditLimit');end;
procedure TClient.SetFirstName(const Value: string);begin  SetStringField('FirstName', Value);end;
procedure TClient.SetLastName(const Value: string);begin  SetStringField('LastName', Value);end;
procedure TClient.SetMiddleName(const Value: string);begin  SetStringField('MiddleName', Value);end;
procedure TClient.SetClientName(const Value: string);begin  SetStringField('Company', Value);end;
procedure TClient.SetPrintName(const Value: string);begin  SetStringField('PrintName', Value);end;
procedure TClient.SetTitle(const Value: string);begin  SetStringField('Title', Value);end;
procedure TClient.SetTermsName(const Value: string);begin  SetStringField('Terms', Value);end;
procedure TClient.SetABN(const Value: string);begin  SetStringField('ABN', Value);end;
procedure TClient.SetCreditLimit(const Value: Double);begin  SetFloatField('CreditLimit', Value);end;
function TClient.GetSalesOrderBalance: Double;begin  Result := GetFloatField('SOBalance');end;
function TClient.GetGroupDiscountOverridesAll: Boolean;begin  Result := GetBooleanField('GroupDiscountOverridesAll');end;
function TClient.getSpecialProductPriceOverridesAll: Boolean;begin  REsult := GetBooleanField('SpecialProductPriceOverridesAll');end;
function TClient.GetCreditCardHolderName: string;begin  Result := GetStringField('CreditCardCardHolderName');end;
function TClient.GetCreditCardExpiryDate: string;begin  Result := GetStringField('CreditCardExpiryDate');end;
function TClient.GetDefaultContactMethod: string;begin  Result := GetStringField('DefaultContactMethod');end;
function TClient.GetParentRelatedClientID: Integer;begin  Result := GetIntegerField('ParentRelatedClientID');end;
function TClient.GetForcePOOnBooking: Boolean;begin  Result := GetBooleanField('ForcePOOnBooking');end;
function TClient.GetHoursTakenForJob: Double;begin  Result := GetFloatField('HoursTakenForJob');end;
function TClient.GetOtherContactType: Integer;begin  Result := GetIntegerField('OtherContactType');end;
function TClient.GetCreditCardNumber: string;begin  Result := GetStringField('CreditCardNumber');end;
function TClient.GetCreditCardCVC: string;begin  Result := GetStringField('CreditCardCVC');end;
function TClient.GetCustomerJobNumber: string;begin  Result := GetStringField('CustomerJobNumber');end;
function TClient.GetSpecialInstructions: string;begin  Result := GetStringField('SpecialInstructions');end;
function TClient.GetApprovalFromDate: TDateTime;begin  Result := GetDateTimeField('ApprovalFromDate');end;
function TClient.GetPhonesupportTill: TDateTime;begin  Result := GetDateTimeField('PhonesupportTill');end;
function TClient.GetReminderDateTime: TDateTime;begin  Result := GetDateTimeField('ReminderDateTime');end;
function TClient.GetOtherContact: Boolean;begin  Result := GetBooleanField('OtherContact');end;
function TClient.GetAPBalance: Double;begin  Result := GetFloatField('APBalance');end;
function TClient.GetSpecialDiscount: Double;begin  Result := GetFloatField('SpecialDiscount');end;
function TClient.GetCompanyTypeId: Integer;begin  Result := GetIntegerField('CompanyTypeId');end;
function TClient.GetPickingPriority: Integer;begin  Result := GetIntegerField('PickingPriority');end;
function TClient.GetBankAccountBSB: string;begin  Result := GetStringField('BankAccountBSB');end;
function TClient.GetBankAccountName: string;begin  Result := GetStringField('BankAccountName');end;
function TClient.GetBankAccountNo: string;begin  Result := GetStringField('BankAccountNo');end;
function TClient.GetCreditCardNotes: string;begin  Result := GetStringField('CreditCardNotes');end;
function TClient.GetCreditCardType: string;begin  Result := GetStringField('CreditCardType');end;
function TClient.GetDeliveryNotes: string;begin  Result := GetStringField('DeliveryNotes');end;
function TClient.GetJobRegistration: string;begin  Result := GetStringField('JobRegistration');end;
function TClient.GetSerialNumber: string;begin  Result := GetStringField('SerialNumber');end;
function TClient.GetApprovalToDate: TDateTime;begin  Result := GetDateTimeField('ApprovalToDate');end;
function TClient.GetCompletionDate: TDateTime;begin  Result := GetDateTimeField('CompletionDate');end;
function TClient.GetCreationDate: TDateTime;begin  Result := GetDateTimeField('CreationDate');end;
function TClient.GetDateEntered: TDateTime;begin  Result := GetDateTimeField('DateEntered');end;
function TClient.GetDateInactive: TDateTime;begin  Result := GetDateTimeField('DateInactive');end;
function TClient.GetDischargeDate: TDateTime;begin  Result := GetDateTimeField('DischargeDate');end;
function TClient.GetExpiryDate: TDateTime;begin  Result := GetDateTimeField('ExpiryDate');end;
function TClient.GetExternalRef: string;begin  result := GetStringField('ExternalRef');end;
function TClient.GetCustomer: Boolean;begin  Result := GetBooleanField('Customer');end;
function TClient.GetSupplier: Boolean;begin  Result := GetBooleanField('Supplier');end;
function TClient.GetDocumentPath: string;begin  result := GetStringField('DocumentPath');end;
function TClient.GetDontContact: Boolean;begin  Result := GetBooleanField('DontContact');end;
function TClient.GetRequired: Boolean;begin  Result := GetBooleanField('Required');end;
function TClient.GetSendFTPXMLInvoices: boolean;begin  result := GetBooleanField('SendFTPXMLInvoices');end;
function TClient.GetSendFTPXMLPOs: boolean;begin  result := GetBooleanField('SendFTPXMLPOs');end;
function TClient.GetSendXMLInvoices: Boolean;begin  Result := GetBooleanField('SendXMLInvoices');end;
function TClient.GetSendXMLPOs: Boolean;begin  Result := GetBooleanField('SendXMLPOs');end;
function TClient.GetARBalance: Double;begin  Result := GetFloatField('ARBalance');end;
function TClient.GetDiscount: Double;begin  Result := GetFloatField('Discount');end;
function TClient.GetMedTypeID: Integer;begin  Result := GetIntegerField('MedTypeID');end;
function TClient.GetShippingID: Integer;begin  Result := GetIntegerField('ShippingID');end;
function TClient.GetPayMethodID: Integer;begin  Result := GetIntegerField('PayMethodID');end;
function TClient.GetForcePOOnSalesOrder: boolean;begin   result := GetBooleanField('ForcePOOnSalesOrder'); end;
function TClient.GetFTPAddress: string;begin  result := GetStringField('FTPAddress');end;
function TClient.GetFTPPassword: string;begin  result := GetStringField('FTPPassword');end;
function TClient.GetFTPUserName: string;begin  result := GetStringField('FTPUserName');end;
function TClient.GetGracePeriod: Integer;begin  Result := GetIntegerField('GracePeriod');end;
function TClient.GetJobNumber: Integer;begin  Result := GetIntegerField('JobNumber');end;
function TClient.GetFaxnumber: string;begin  Result := GetStringField('Faxnumber');end;
function TClient.GetAltcontact: string;begin  Result := GetStringField('Altcontact');end;
function TClient.GetAltPhone: string;begin  Result := GetStringField('AltPhone');end;
function TClient.GetClientNo: string;begin  Result := GetStringField('ClientNo');end;
function TClient.GetClientPaysShippment: boolean; begin   result := GetBooleanField('ClientPaysShippment'); end;
function TClient.GetPublishOnVS1: boolean; begin   result := GetBooleanField('PublishOnVS1'); end;
function TClient.GetCUSTFLD1: string;begin  Result := GetStringField('CUSTFLD1');end;
function TClient.GetCUSTFLD2: string;begin  Result := GetStringField('CUSTFLD2');end;
function TClient.GetCUSTFLD3: string;begin  Result := GetStringField('CUSTFLD3');end;
function TClient.GetCUSTFLD4: string;begin  Result := GetStringField('CUSTFLD4');end;
function TClient.GetCUSTFLD5: string;begin  Result := GetStringField('CUSTFLD5');end;
function TClient.GetCUSTFLD6: string;begin  Result := GetStringField('CUSTFLD6');end;
function TClient.GetCUSTFLD7: string;begin  Result := GetStringField('CUSTFLD7');end;
function TClient.GetCUSTFLD8: string;begin  Result := GetStringField('CUSTFLD8');end;
function TClient.GetCUSTFLD9: string;begin  Result := GetStringField('CUSTFLD9');end;
function TClient.GetCUSTFLD10: string;begin  Result := GetStringField('CUSTFLD10');end;
function TClient.GetCUSTFLD11: string;begin  Result := GetStringField('CUSTFLD11');end;
function TClient.GetCUSTFLD12: string;begin  Result := GetStringField('CUSTFLD12');end;
function TClient.GetCUSTFLD13: string;begin Result := GetStringField('CUSTFLD13');end;
function TClient.GetCUSTFLD14: string;begin  Result := GetStringField('CUSTFLD14');end;
function TClient.GetCUSTFLD15: string;begin  Result := GetStringField('CUSTFLD15');end;
function TClient.GetBankCode: string;begin  Result := GetStringField('BankCode');end;
function TClient.GetCardNumber: string;begin  Result := GetStringField('CardNumber');end;
function TClient.GetJobTitle: string;begin  Result := GetStringField('JobTitle');end;
function TClient.GetModelNumber: string;begin  Result := GetStringField('ModelNumber');end;
function TClient.GetManufactureName: string;begin  Result := GetStringField('Manufacture');end;
function TClient.GetEmailXML: string;begin  Result := GetStringField('EmailXML');end;
function TClient.GetEmailPOXML: string;begin  Result := GetStringField('EmailPOXML');end;
function TClient.GetExcessAmount: double;begin  Result := GetFloatField('ExcessAmount');end;
function TClient.GetUpdateDate: TDateTime;begin  Result := GetDateTimeField('UpdateDate');end;
function TClient.GetCUSTDATE1: TDateTime;begin  Result := GetDateTimeField('CUSTDATE1');end;
function TClient.GetCUSTDATE2: TDateTime;begin  Result := GetDateTimeField('CUSTDATE2');end;
function TClient.GetCUSTDATE3: TDateTime;begin Result := GetDateTimeField('CUSTDATE3');end;
function TClient.GetMobile: string;begin  Result := GetStringField('Mobile');end;
function TClient.GetEmail: string;begin Result := GetStringField('Email');end;
function TClient.GetNewOrUsed: string;begin result:= GetStringField('NewOrUsed');end;
function TClient.GetNotes: string;begin  Result := GetStringField('Notes');end;
function TClient.GetJobName: string;begin  Result := GetStringField('JobName');end;
function TClient.Getprintjobname: string;begin  Result := GetStringField('printjobname');end;
function TClient.GetAction: TDateTime;begin  Result := GetDateTimeField('Action');end;
function TClient.GetActive: Boolean;begin  Result := GetBooleanField('Active');end;
function TClient.GetURL: string;begin  Result := GetStringField('URL');end;
function TClient.GetArea: String;begin  Result := GetStringField('Area');end;
function TClient.GetAssessorsName: string;begin  Result := GetStringField('AssessorName');end;
function TClient.GetTasks: string;begin  Result := GetStringField('Tasks');end;
function TClient.Gethours: Double;begin  Result := GetFloatField('hours');end;
procedure TClient.SetSalesOrderBalance(const Value: Double);begin  SetFloatField('SOBalance', Value);end;
function TClient.GetWarrantyFinishDate: TDateTime;begin  Result := GetDateTimeField('WarrantyFinishDate');end;
function TClient.GetColour: string;begin  Result := GetStringField('Colour');end;
function TClient.GetCombInvBOID: string;begin  Result := GetStringField('CombinedInvoiceBOID');end;
procedure TClient.SetColour(const Value: string);begin  SetStringField('Colour', Value);end;
procedure TClient.SetCombInvBOID(const Value: string);begin  SetStringField('CombinedInvoiceBOID', Value);end;
function TClient.GetCombSOBOID: string;begin  Result := GetStringField('CombinedSaleOrderBOID');end;
procedure TClient.SetCombSOBOID(const Value: string);begin  SetStringField('CombinedSaleOrderBOID', Value);end;
function TClient.GetForcePONumOnInvoice: Boolean;begin  Result := GetBooleanField('ForcePOOnInvoice');end;
function TClient.getForcePOOnRepair: Boolean;begin  Result := GetBooleanField('ForcePOOnRepair');end;
procedure TClient.setForcePOOnRepair(const Value: Boolean);begin  SetBooleanField('ForcePOOnRepair', Value);end;
procedure TClient.SetForcePONumOnInvoice(const Value: Boolean);begin  SetBooleanField('ForcePOOnInvoice', Value);end;
function TClient.GetCustomerNextInvoiceNo: Integer;begin  Result := GetIntegerField('InvBaseNumber');end;
function TClient.GetUseCustomerInvoiceNo: Boolean;begin  Result := GetBooleanField('UseInvBase');end;
procedure TClient.SetCustomerNextInvoiceNo(const Value: Integer);begin  SetIntegerField('InvBaseNumber', Value);end;
procedure TClient.SetUseCustomerInvoiceNo(const Value: Boolean);begin  SetBooleanField('UseInvBase', Value);end;
function TClient.GetWarrantyPeriod: Double;begin  Result := GetFloatField('WarrantyPeriod');end;
function TClient.GetYear: TDateTime;begin  result:= GetdateTimeField('Year');end;
procedure TClient.SetWarrantyPeriod(const Value: Double);begin  SetFloatField('WarrantyPeriod', Value);end;
procedure TClient.SetYear(const Value: TDateTime);begin  SetDateTimeField('Year', Value);end;
function TClient.GetDefaultDelTemplateID: Integer;begin  Result := GetIntegerField('DefaultDeliveryTemplateID');end;
function TClient.GetDefaultInvTemplateID: Integer;begin  Result := GetIntegerField('DefaultInvoiceTemplateID');end;
function TClient.GetDefaultPOTemplateID: Integer;begin  Result := GetIntegerField('DefaultPurchaseOrderTemplateID');end;
function TClient.GetDefaultSOTemplateID: Integer; begin   result := GetIntegerField('DefaultSalesOrderTemplateID'); end;
procedure TClient.SetDefaultDelTemplateID(const Value: Integer);begin  SetIntegerField('DefaultDeliveryTemplateID', Value);end;
procedure TClient.SetDefaultInvTemplateID(const Value: Integer);begin  SetIntegerField('DefaultInvoiceTemplateID', Value);end;
procedure TClient.SetDefaultPOTemplateID(const Value: Integer);begin  SetIntegerField('DefaultPurchaseOrderTemplateID', Value);end;
procedure TClient.SetDefaultSOTemplateID(const Value: Integer); begin   SetIntegerField('DefaultSalesOrderTemplateID',Value); end;
procedure TClient.SetWarrantyFinishDate(const Value: TDateTime);begin  SetDateTimeField('WarrantyFinishDate', Value);end;
function TClient.GetIsCustomer: Boolean;begin  Result := GetBooleanField('Customer');end;
function TClient.GetIsInternal: boolean;begin  result := GetBooleanField('IsInternal');end;
function TClient.GetIsOtherContact: Boolean;begin  Result := GetBooleanField('OtherContact');end;
function TClient.GetIsSupplier: Boolean;begin  Result := GetBooleanField('Supplier');end;
procedure TClient.SetIsCustomer(const Value: Boolean);begin  SetBooleanField('Customer', Value);end;
procedure TClient.SetIsInternal(const Value: boolean);begin  SetBooleanField('IsInternal',Value);end;
procedure TClient.SetIsOtherContact(const Value: Boolean);begin  SetBooleanField('OtherContact', Value);end;
procedure TClient.SetIsSupplier(const Value: Boolean);begin  SetBooleanField('Supplier', Value);end;
function TClient.GetRepId: Integer;begin  Result := GetIntegerField('RepID');end;
function TClient.GetDefaultAPAccountID: Integer;begin  Result := GetIntegerField('DefaultAPAccountID');end;
function TClient.GetDefaultARAccountID: Integer;begin  Result := GetIntegerField('DefaultARAccountID');end;
function TClient.GetRepName: string;begin  Result := GetStringField('RepName');end;
function TClient.GetDefaultARAccount: string;begin  Result := GetStringField('DefaultARAccountName');end;
function TClient.GetDefaultAPAccount: string;begin  Result := GetStringField('DefaultAPAccountName');end;
procedure TClient.SetRepId(const Value: Integer);begin  SetIntegerField('RepID', Value);end;
procedure TClient.SetDefaultAPAccountID(const Value: Integer);begin SetIntegerField('DefaultAPAccountID', Value);end;
procedure TClient.SetDefaultARAccountID(const Value: Integer);begin  SetIntegerField('DefaultARAccountID', Value);end;
procedure TClient.SetRepName(const Value: string);begin  SetStringField('RepName', Value);end;
procedure TClient.SetDefaultARAccount(const Value: string);begin  SetStringField('DefaultARAccountName', Value);end;
procedure TClient.SetDefaultAPAccount(const Value: string);begin  SetStringField('DefaultAPAccountName', Value);end;
function TClient.GetBillCountry: string;begin  Result := GetStringField('BillCountry');end;
function TClient.GetBillStreet: string;begin  Result := GetStringField('BillStreet');end;
function TClient.GetBillStreet2: string;begin  Result := GetStringField('BillStreet2');end;
function TClient.GetBillStreet3: string;begin  Result := GetStringField('BillStreet3');end;
function TClient.GetBillSuburb: string;begin  Result := GetStringField('BillSuburb');end;
function TClient.GetBodyType: string;begin  result:= GetStringField('BodyType');end;
function TClient.GetCountry: string;begin  Result := GetStringField('Country');end;
function TClient.GetPostCode: string;begin  Result := GetStringField('PostCode');end;
function TClient.GetState: string;begin  Result := GetStringField('State');end;
function TClient.GetStreet: string;begin  Result := GetStringField('Street');end;
function TClient.GetStreet2: string;begin  Result := GetStringField('Street2');end;
function TClient.GetStreet3: string;begin  Result := GetStringField('Street3');end;
function TClient.GetSuburb: string;begin  Result := GetStringField('Suburb');end;
function TClient.GetStatus: string;begin  Result := GetStringField('Status');end;

procedure TClient.SetBillCountry(const Value: string);begin  SetStringField('BillCountry', Value);end;
procedure TClient.SetBillPostcode(const Value: string);begin  SetStringField('BillPostcode', Value);end;
procedure TClient.SetPhone(const Value: string);begin  SetStringField('Phone', Value);end;
procedure TClient.SetBillStreet(const Value: string);begin  SetStringField('BillStreet', Value);end;
procedure TClient.SetBillStreet2(const Value: string);begin  SetStringField('BillStreet2', Value);end;
procedure TClient.SetBillStreet3(const Value: string);begin  SetStringField('BillStreet3', Value);end;
procedure TClient.SetBillSuburb(const Value: string);begin  SetStringField('BillSuburb', Value);end;
procedure TClient.SetBodyType(const Value: string);begin  SetStringField('BodyType', Value);end;
procedure TClient.SetCountry(const Value: string);begin  SetStringField('Country', Value);end;
procedure TClient.SetPostCode(const Value: string);begin  SetStringField('PostCode', Value);end;
procedure TClient.SetState(const Value: string);begin  SetStringField('State', Value);end;
procedure TClient.SetStreet(const Value: string);begin  SetStringField('Street', Value);end;
procedure TClient.SetStreet2(const Value: string);begin  SetStringField('Street2', Value);end;
procedure TClient.SetStreet3(const Value: string);begin  SetStringField('Street3', Value);end;
procedure TClient.SetSuburb(const Value: string);begin  SetStringField('Suburb', Value);end;
function TClient.GetBillPostCode: string;begin  Result := GetStringField('BillPostCode');end;
function TClient.GetPhone: string;begin  Result := GetStringField('Phone');end;
function TClient.GetBillState: string;begin  Result := GetStringField('BillState');end;
procedure TClient.SetBillState(const Value: string);begin  SetStringField('BillState', Value);end;
function TClient.GetParentId: Integer;begin  Result := GetIntegerField('ParentClientId');end;
function TClient.GetStockReceivedDate: TDate;begin  result:= GetDateTimeField('StockReceivedDate');end;
function TClient.GetStormDate: TDateTime;begin  result:= GetDateTimeField('StormDate');end;
function TClient.GetStormLocation: string;begin  result:= GetStringField('StormLocation');end;
procedure TClient.SetParentClientId(const Value: Integer);begin  SetIntegerField('ParentClientId', Value);end;
procedure TClient.SetStockReceivedDate(const Value: TDate);begin  SetDateTimeField('StockeReceivedDate',Value);end;
procedure TClient.SetStormDate(const Value: TDateTime);begin  SetDateTimeField('StormDate', Value);end;
procedure TClient.SetStormLocation(const Value: string);begin  SetStringField('StormLocation', Value);end;
function TClient.GetClaimNumber: string;begin  result := GetStringField('ClaimNumber');end;
function TClient.GetClassName: string;begin  Result := GetStringField('DefaultClass');end;
procedure TClient.SetClaimNumber(const Value: string);begin  SetStringField('ClaimNumber', Value);end;
procedure TClient.SetClassName(const Value: string);begin  SetStringField('DefaultClass', Value);end;
function TClient.GetClientTypeId: Integer;begin  Result := GetIntegerField('ClientTypeId');end;
procedure TClient.SetClientTypeId(const Value: Integer);begin  SetIntegerField('ClientTypeId', Value);end;
function TClient.GetTaxID: Integer;begin  Result := GetIntegerField('TaxID');end;
procedure TClient.SetTaxID(const Value: Integer);begin  SetIntegerField('TaxID', Value);end;
function TClient.GetTermsId: Integer;begin  Result := GetIntegerField('TermsID');end;
procedure TClient.SetTermsID(const Value: Integer);begin  SetIntegerField('TermsID', Value);end;
procedure TClient.SetShipTime(const Value: Integer);begin  SetIntegerField('ShipTime', Value);end;
function TClient.getShipTime: Integer;begin  Result := getIntegerfield('ShipTime');end;
function TClient.getInvComment: string;begin  Result := getStringfield('InvoiceComment');end;
function TClient.getrepairComment: string;begin  Result := getStringfield('repairComment');end;
function TClient.getPOComment: string;begin  Result := getStringfield('POComment');end;
function TClient.GetInvComntPopUp: Boolean;begin  Result := GetBooleanField('InvoiceCommentPopUp');end;
function TClient.GetRepairCommentPopUpPopUp: Boolean;begin  Result := GetBooleanField('RepairCommentPopUp');end;
function TClient.GetPOCommentPopup: Boolean;begin  Result := GetBooleanField('POCommentPopup');end;
procedure TClient.SetInvoiceCommentPopUp(const Value: Boolean);begin  SetBooleanField('InvoiceCommentPopUp', Value);end;
procedure TClient.SetRepairCommentPopUp(const Value: Boolean);begin  SetBooleanField('RepairCommentPopUp', Value);end;
procedure TClient.SetPOCommentPopup(const Value: Boolean);begin  SetBooleanField('POCommentPopup', Value);end;
procedure TClient.SetPOComment(const Value: string);begin  SetStringField('POComment', Value);end;
procedure TClient.SetInvoiceComment(const Value: string);begin  SetStringField('InvoiceComment', Value);end;
procedure TClient.SetrepairComment(const Value: string);begin  SetStringField('repairComment', Value);end;
procedure TClient.SetGroupDiscountOverridesAll(const Value: Boolean);begin  SetBooleanField('GroupDiscountOverridesAll', Value);end;
procedure TClient.SetCreditCardHolderName(const Value: string);begin  SetStringField('CreditCardCardHolderName', Value);end;
procedure TClient.SetCreditCardExpiryDate(const Value: string);begin  SetStringField('CreditCardExpiryDate', Value);end;
procedure TClient.SetDefaultContactMethod(const Value: string);begin  SetStringField('DefaultContactMethod', Value);end;
procedure TClient.SetParentRelatedClientID(const Value: Integer);begin  SetIntegerField('ParentRelatedClientID', Value);end;
procedure TClient.SetForcePOOnBooking(const Value: Boolean);begin  SetBooleanField('ForcePOOnBooking', Value);end;
procedure TClient.SetHoursTakenForJob(const Value: Double);begin  SetFloatField('HoursTakenForJob', Value);end;
procedure TClient.SetOtherContactType(const Value: Integer);begin  SetIntegerField('OtherContactType', Value);end;
procedure TClient.SetCreditCardNumber(const Value: string);begin  SetStringField('CreditCardNumber', Value);end;
procedure TClient.SetCreditCardCVC(const Value: string);begin  SetStringField('CreditCardCVC', Value);end;
procedure TClient.SetCustomerJobNumber(const Value: string);begin  SetStringField('CustomerJobNumber', Value);end;
procedure TClient.SetSpecialInstructions(const Value: string);begin  SetStringField('SpecialInstructions', Value);end;
procedure TClient.SetApprovalFromDate(const Value: TDateTime);begin  SetDateTimeField('ApprovalFromDate', Value);end;
procedure TClient.SetPhonesupportTill(const Value: TDateTime);begin  SetDateTimeField('PhonesupportTill', Value);end;
procedure TClient.SetReminderDateTime(const Value: TDateTime);begin  SetDateTimeField('ReminderDateTime', Value);end;
procedure TClient.SetOtherContact(const Value: Boolean);begin  SetBooleanField('OtherContact', Value);end;
procedure TClient.SetAPBalance(const Value: Double);begin  SetFloatField('APBalance', Value);end;
procedure TClient.SetSpecialDiscount(const Value: Double);begin  SetFloatField('SpecialDiscount', Value);end;
procedure TClient.SetCompanyTypeId(const Value: Integer);begin  SetIntegerField('CompanyTypeId', Value);end;
procedure TClient.SetPickingPriority(const Value: Integer);begin  SetIntegerField('PickingPriority', Value);end;
procedure TClient.SetBankAccountBSB(const Value: string);begin  SetStringField('BankAccountBSB', Value);end;
procedure TClient.SetBankAccountName(const Value: string);begin  SetStringField('BankAccountName', Value);end;
procedure TClient.SetBankAccountNo(const Value: string);begin  SetStringField('BankAccountNo', Value);end;
procedure TClient.SetCreditCardNotes(const Value: string);begin  SetStringField('CreditCardNotes', Value);end;
procedure TClient.SetCreditCardType(const Value: string);begin  SetStringField('CreditCardType', Value);end;
procedure TClient.SetDeliveryNotes(const Value: string);begin  SetStringField('DeliveryNotes', Value);end;
procedure TClient.SetJobRegistration(const Value: string);begin  SetStringField('JobRegistration', Value);end;
procedure TClient.SetSerialNumber(const Value: string);begin SetStringField('SerialNumber', Value);end;
procedure TClient.SetApprovalToDate(const Value: TDateTime);begin  SetDateTimeField('ApprovalToDate', Value);end;
procedure TClient.SetCompletionDate(const Value: TDateTime);begin  SetDateTimeField('CompletionDate', Value);end;
procedure TClient.SetCreationDate(const Value: TDateTime);begin  SetDateTimeField('CreationDate', Value);end;
procedure TClient.SetDateEntered(const Value: TDateTime);begin  SetDateTimeField('DateEntered', Value);end;
procedure TClient.SetDateInactive(const Value: TDateTime);begin  SetDateTimeField('DateInactive', Value);end;
procedure TClient.SetDischargeDate(const Value: TDateTime);begin  SetDateTimeField('DischargeDate', Value);end;
procedure TClient.SetExpiryDate(const Value: TDateTime);begin  SetDateTimeField('ExpiryDate', Value);end;
procedure TClient.SetExternalRef(const Value: string); begin   SetStringField('ExternalRef',Value); end;
procedure TClient.SetCustomer(const Value: Boolean);begin  SetBooleanField('Customer', Value);end;
procedure TClient.SetSupplier(const Value: Boolean);begin  SetBooleanField('Supplier', Value);end;
procedure TClient.SetDocumentPath(const Value: string);begin  SetStringField('DocumentPath', Value);end;
procedure TClient.SetDontContact(const Value: Boolean);begin  SetBooleanField('DontContact', Value);end;
procedure TClient.SetRequired(const Value: Boolean);begin  SetBooleanField('Required', Value);end;
procedure TClient.SetSendFTPXMLInvoices(const Value: boolean);begin  SetBooleanField('SendFTPXMLInvoices',Value);end;
procedure TClient.SetSendFTPXMLPOs(const Value: boolean);begin  SetBooleanField('SendFTPXMLPOs',Value);end;
procedure TClient.SetSendXMLInvoices(const Value: Boolean);begin  SetBooleanField('SendXMLInvoices', Value);end;
procedure TClient.SetSendXMLPOs(const Value: Boolean);begin  SetBooleanField('SendXMLPOs', Value);end;
procedure TClient.SetARBalance(const Value: Double);begin  SetFloatField('ARBalance', Value);end;
procedure TClient.SetDiscount(const Value: Double);begin  SetFloatField('Discount', Value);end;
procedure TClient.SetMedTypeID(const Value: Integer);begin  SetIntegerField('MedTypeID', Value);end;
procedure TClient.SetShippingID(const Value: Integer);begin  SetIntegerField('ShippingID', Value);end;
procedure TClient.SetPayMethodID(const Value: Integer);begin  SetIntegerField('PayMethodID', Value);end;
procedure TClient.SetForcePOOnSalesOrder(const Value: boolean);begin   SetBooleanField('ForcePOOnSalesOrder', Value); end;
procedure TClient.SetFTPAddress(const Value: string);begin  SetStringField('FTPAddress', Value);end;
procedure TClient.SetFTPPassword(const Value: string);begin  SetStringField('FTPPassword', Value);end;
procedure TClient.SetFTPUserName(const Value: string);begin  SetStringField('FTPUserName', Value);end;
procedure TClient.SetGracePeriod(const Value: Integer);begin  SetIntegerField('GracePeriod', Value);end;
procedure TClient.SetJobNumber(const Value: Integer);begin  SetIntegerField('JobNumber', Value);end;
procedure TClient.SetFaxnumber(const Value: string);begin  SetStringField('Faxnumber', Value);end;
procedure TClient.SetAltcontact(const Value: string);begin  SetStringField('Altcontact', Value);end;
procedure TClient.SetAltPhone(const Value: string);begin  SetStringField('AltPhone', Value);end;
procedure TClient.SetClientNo(const Value: string);begin  SetStringField('ClientNo', Value);end;
procedure TClient.SetClientPaysShippment(const Value: boolean); begin   SetBooleanField('ClientPaysShippment', Value); end;
procedure TClient.SetPublishOnVS1(const Value: boolean); begin   SetBooleanField('PublishOnVS1', Value); end;
procedure TClient.SetClientShipperAccountNo(const Value: string); begin   SetStringField('ClientShipperAccountNo', Value); end;
procedure TClient.SetCUSTFLD1(const Value: string);begin  SetStringField('CUSTFLD1', Value);end;
procedure TClient.SetCUSTFLD2(const Value: string);begin  SetStringField('CUSTFLD2', Value);end;
procedure TClient.SetCUSTFLD3(const Value: string);begin  SetStringField('CUSTFLD3', Value);end;
procedure TClient.SetCUSTFLD4(const Value: string);begin  SetStringField('CUSTFLD4', Value);end;
procedure TClient.SetCUSTFLD5(const Value: string);begin  SetStringField('CUSTFLD5', Value);end;
procedure TClient.SetCUSTFLD6(const Value: string);begin SetStringField('CUSTFLD6', Value);end;
procedure TClient.SetCUSTFLD7(const Value: string);begin  SetStringField('CUSTFLD7', Value);end;
procedure TClient.SetCUSTFLD8(const Value: string);begin  SetStringField('CUSTFLD8', Value);end;
procedure TClient.SetCUSTFLD9(const Value: string);begin  SetStringField('CUSTFLD9', Value);end;
procedure TClient.SetCUSTFLD10(const Value: string);begin  SetStringField('CUSTFLD10', Value);end;
procedure TClient.SetCUSTFLD11(const Value: string);begin SetStringField('CUSTFLD11', Value);end;
procedure TClient.SetCUSTFLD12(const Value: string);begin  SetStringField('CUSTFLD12', Value);end;
procedure TClient.SetCUSTFLD13(const Value: string);begin  SetStringField('CUSTFLD13', Value);end;
procedure TClient.SetCUSTFLD14(const Value: string);begin  SetStringField('CUSTFLD14', Value);end;
procedure TClient.SetCUSTFLD15(const Value: string);begin  SetStringField('CUSTFLD15', Value);end;
procedure TClient.SetBankCode(const Value: string);begin  SetStringField('BankCode', Value);end;
procedure TClient.SetCardNumber(const Value: string);begin  SetStringField('CardNumber', Value);end;
procedure TClient.SetJobTitle(const Value: string);begin  SetStringField('JobTitle', Value);end;
procedure TClient.SetModelNumber(const Value: string);begin  SetStringField('ModelNumber', Value);end;
procedure TClient.SetManufactureName(const Value: string);begin  SetStringField('Manufacture', Value);end;
procedure TClient.SetEmailXML(const Value: string);begin  SetStringField('EmailXML', Value);end;
procedure TClient.SetEmailPOXML(const Value: string);begin  SetStringField('EmailPOXML', Value);end;
procedure TClient.SetExcessAmount(const Value: double);begin  SetFloatField('ExcessAmount', Value);end;
procedure TClient.SetUpdateDate(const Value: TDateTime);begin  SetDateTimeField('UpdateDate', Value);end;
procedure TClient.SetCUSTDATE1(const Value: TDateTime);begin  SetDateTimeField('CUSTDATE1', Value);end;
procedure TClient.SetCUSTDATE2(const Value: TDateTime);begin  SetDateTimeField('CUSTDATE2', Value);end;
procedure TClient.SetCUSTDATE3(const Value: TDateTime);begin  SetDateTimeField('CUSTDATE3', Value);end;
procedure TClient.SetMobile(const Value: string);begin  SetStringField('Mobile', Value);end;
procedure TClient.SetEmail(const Value: string);begin  SetStringField('Email', Value);end;
procedure TClient.SetNewOrUsed(const Value: string);begin  SetStringField('NewOrUsed',Value);end;
procedure TClient.SetNotes(const Value: string);begin  SetStringField('Notes', Value);end;
procedure TClient.SetJobName(const Value: string);begin SetStringField('JobName', Value);end;
procedure TClient.Setprintjobname(const Value: string);begin SetStringField('printjobname', Value);end;
procedure TClient.SetAction(const Value: TDateTime);begin  SetDateTimeField('Action', Value);end;
procedure TClient.SetActive(const Value: Boolean);begin  SetBooleanField('Active', Value);end;
procedure TClient.SetURL(const Value: string);begin  SetStringField('URL', Value);end;
Procedure  TClient.SetArea(Const Value : String);begin  SetStringField('Area', Value);end;
procedure TClient.SetAssessorsName(const Value: string);begin  SetStringField('AssessorsName', Value);end;
procedure TClient.SetTasks(const Value: string);begin  SetStringField('Tasks', Value);end;
procedure TClient.SetStatus(const Value: string);begin  SetStringField('Status', Value);end;

function TClient.GetBailmentAmountEx: double;begin  result:= GetFloatField('BailmentAmountEx');end;
function TClient.GetBailmentNumber: string;begin  result:= GetStringField('BailmentNumber');end;
function TClient.GetBalance: Double;begin  Result := GetFloatField('Balance');end;
procedure TClient.SetBailmentAmountEx(const Value: double);begin  SetFloatField('BailmentAmountEx',Value);end;
procedure TClient.SetBailmentNumber(const Value: string);begin  SetStringField('BailmentNumber',Value);end;
procedure TClient.SetBalance(const Value: Double);begin  SetFloatField('Balance', Value);end;
function TClient.GetIsJob: Boolean;begin  Result := GetBooleanField('IsJob');end;
procedure TClient.SetIsJob(const Value: Boolean);begin  SetBooleanField('IsJob', Value);end;
function TClient.GetClientAddress: string;begin  Result := ClientName + #13#10 + ClientPrintName(False, true , True)+ StreetAddress;end;
function TClient.getShippingMethodName: string;begin  Result := getStringfield('ShippingMethod');end;
procedure TClient.SetShippingMethodName(const Value: string);begin  SetStringField('ShippingMethod', Value);end;
procedure TClient.Sethours(const Value: Double);begin  SetFloatField('hours', Value);end;
class function TClient.GetKeyStringField: string;begin  result := 'Company';end;
class function TClient.GetKeyStringProperty: string;begin  result:= 'ClientName';end;
function TClient.GetBPAYBillerCode: string;begin  result:= GetStringField('BPAYBillerCode');end;
function TClient.GetBPAYReference: string;begin  result:= GetStringField('BPAYReference');end;
procedure TClient.SetBPAYBillerCode(const Value: string);begin  SetStringField('BPAYBillerCode',Value);end;
procedure TClient.SetBPAYReference(const Value: string);begin  SetStringField('BPAYReference',Value);end;
procedure TClient.setCallPriority(const Value: Integer);begin  SetIntegerField('CallPriority' , Value);end;
function TClient.GetManufacture: TManufacture;begin  result := TManufacture(GetContainerComponent(TManufacture ,'ID = ' + IntToStr(Self.ManufactureID), false));end;
function TClient.GetManufactureID: Integer;begin  REsult :=getIntegerField('ManufactureID');end;
procedure TClient.SetManufactureID(const Value: Integer);begin  SetIntegerfield('ManufactureID' , value);end;
procedure TClient.SetSpecialProductPriceOverridesAll(const Value: Boolean);begin  SetBooleanField('SpecialProductPriceOverridesAll' , Value);end;
function TClient.getFinalDestination: String;begin  REsult := getStringField('FinalDestination ');end;
function TClient.getIncoPlace: String;begin  REsult := getStringField('IncoPlace');end;
function TClient.getTeamviewerID: String;begin  REsult := getStringField('TeamviewerID');end;
function TClient.getClientCode: String;begin  REsult := getStringField('ClientCode');end;
function TClient.getSkypeName: String;begin  REsult := getStringField('SkypeName');end;
function TClient.getPortOfDischarge: String;begin  REsult := getStringField('PortOfDischarge ');end;
function TClient.getPortOfLanding: String;begin  REsult := getStringField('PortOfLanding ');end;
procedure TClient.setFinalDestination(const Value: String);begin  SetStringField(FinalDestination ,'FinalDestination');end;
procedure TClient.setIncoPlace(const Value: String);begin  SetStringField(IncoPlace,Value);end;
procedure TClient.setTeamviewerID(const Value: String);begin  SetStringField('TeamviewerID',Value);end;
procedure TClient.setClientCode(const Value: String);begin  SetStringField('ClientCode',Value);end;
procedure TClient.setSkypeName(const Value: String);begin  SetStringField('SkypeName',Value);end;
procedure TClient.setPortOfDischarge(const Value: String);begin  SetStringField(PortOfDischarge ,'PortOfDischarge');end;
procedure TClient.setPortOfLanding(const Value: String);begin  SetStringField(PortOfLanding ,'PortOfLanding');end;
function TClient.getShippingAgentID: Integer;begin  REsult := GetIntegerField('ShippingAgentID');end;
procedure TClient.setShippingAgentID(const Value: Integer);begin  SetIntegerField('ShippingAgentID' , Value);end;
function TClient.GetLicenseRenewDurationType: string;begin  Result := GetStringField('LicenseRenewDurationType'); if (Result<>'M') and (result<>'Y') then Result := 'M'; end;
procedure TClient.SetLicenseRenewDurationType(const Value: string);begin SetStringField('LicenseRenewDurationType', Value); if (value<>'M') and (value <> 'Y') then  SetStringField('LicenseRenewDurationType', 'M'); end;
function TClient.GetLicenseRenewDuration: Integer; begin   result := GetIntegerField('LicenseRenewDuration'); if result <1 then result := 1; end;
procedure TClient.SetLicenseRenewDuration(const Value: Integer); begin   SetIntegerField('LicenseRenewDuration',Value); end;
function TClient.GetAttachments: TAttachment;
begin
  Result := TAttachment(GetcontainerComponent(TAttachment,
    'Tablename = ' + Quotedstr(GetBusObjectTablename) + ' and TableID =' + IntToStr(ID)));
end;
function TClient.GetCompanyTypeName: string;
begin
  if CompanyTypeId > 0 then
    result:= BusObjSimpleTypes.TCompanyType.IDToggle(CompanyTypeId, Connection.Connection)
  else
    result:= '';
end;

procedure TClient.SetCompanyTypeName(const Value: string);
begin
  if Value <> '' then
    CompanyTypeId:= BusObjSimpleTypes.TCompanyType.IDToggle(Value, Connection.Connection)
  else
    CompanyTypeId:= 0;
end;

function TClient.GetSourceName: string;
begin
  if MedTypeID > 0 then
    Result:= TSource.IDToggle(MedTypeID, Connection.Connection)
  else
    Result:= '';
end;

procedure TClient.SetSourceName(const Value: string);
begin
  if Value <> '' then
    MedTypeID:= TSource.IDToggle(Value,Connection.Connection)
  else
    MedTypeID:= 0;
end;

function TClient.GetParentClientName: string;
begin
  if ParentClientId > 0 then
    result:= ParentClient.clientName
  else
    result:= '';
end;

procedure TClient.SetParentClientName(const Value: string);
begin
  if value <> '' then
    ParentClientId:= TClient.IDToggle(Value,Connection.Connection)
  else
    ParentClientId:= 0;
end;

function TClient.GetParentRelatedClientName: string;
begin
  if ParentRelatedClientID > 0 then
    result:= TClient.IDToggle(ParentRelatedClientID,Connection.Connection)
  else
    result:= '';
end;
Function  TClient.GetApptcount(Countuntil :TDatetime):Integer;
Var
   strSQL :String;
begin
  strSQL :='SELECT COUNT(*) as Count FROM tblappointments ' +
      ' WHERE Cancellation="F" AND Active="T" ' +
      ' AND CusID = ' + IntToStr(Self.ID) + ' AND STARTTIME < :STARTTIME';
  with TERPQuery.create(self) do try
    connection := Self.connection.connection;
    SQL.add(strSQL );
    Params.ParamByName('STARTTIME').AsDateTime := countUntil;
    open;
    REsult :=FieldByName('Count').AsInteger + 1;
  finally
    if active then close;
    free;
  end;
end;

function TClient.GetContractor: boolean;
begin
  result := GetBooleanField('Contractor');
end;

function TClient.GetCoreEDIConfig: TCoreEDIConfig;
begin
  result := TCoreEDIConfig(GetContainerComponent(TCoreEDIConfig ,'ClientID = ' + IntToStr(ID) ));
//  if result.ISEmpty and (ID > 0) then
//    result.New;
end;

procedure TClient.SetContractor(const Value: boolean);
begin
  SetBooleanField('Contractor', Value);
end;


function TCustomer.getARBackOrderbalance: double;
begin
     With GetNewDataset('select  sum(SL.LinePriceInc *SL.qtysold) Estimatedprice   '+
                        ' from tblsales S   '+
                        ' inner join tblsaleslines SL on S.SaleID = SL.SaleID   '+
                        ' where ifnull(S.BOID , "") = "" and S.IsInvoice = "T" and clientId = ' +inttostr(ID)  , true) do try
        result := fieldbyname('Estimatedprice').AsFloat;
     finally
        if active then close;
        Free;
     end;
end;

function TCustomer.GetBillAddressValid: boolean;
begin
  result := GetBooleanField('BillAddressValid');
end;

function TCustomer.getClientTaxExceptionProducts: TClientTaxExceptionProducts;
begin
  result := TClientTaxExceptionProducts(GetContainerComponent(TClientTaxExceptionProducts ,'ClientID = ' + IntToStr(Self.ID) ));
end;
function TClient.GetshipToAddress: string;
begin{check for blank field to avoid blank lines in the ship to address}
  Result := ConcatStrings([ClientName , street, street2, street3 , ConcatStrings([Suburb , State , Postcode], ' '), Country] , chr(13)+chr(10));
//  Exit;

//  Result := ClientName ;
//  if Street <> '' then
//    Result := Result + Chr(13) + Chr(10) + Street;
//  if Street2 <> '' then
//    Result := Result + Chr(13) + Chr(10) + Street2;
//  if Street3 <> '' then
//    Result := Result + Chr(13) + Chr(10) + Street3;
//  if (Suburb <> '') or (State <> '') then
//  begin
//    Result := Result + Chr(13) + Chr(10);
//    if (Suburb <> '') and (State <> '') then
//      Result := Result + Suburb + ' ' + State
//    else if Suburb = '' then
//      Result := Result + State
//    else
//      Result := Result + Suburb;
//  end;
//  if Postcode <> '' then
//    Result := Result + ' ' + Postcode;
end;


function TClient.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterPost(sender);
end;

Function  TClient.DoAfterInsert(Sender :TDatasetBusObj ):Boolean;
begin
  result := inherited DoAfterInsert(sender);
  if not result then Exit;
  if not RawMode then
    CreationDate := now;
  Active:= true;
  DocumentPath    := Appenv.DocPath.DocumentPath;
  if SilentMode then MedtypeId := CsahCustomerMedtypeId;
  PublishOnVS1 := False;
end;

function TClient.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(sender);
end;


procedure TClient.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.

  if Sysutils.SameText(Sender.fieldName , 'Company') then begin
    if PrintName = '' then
      PrintName := self.ClientName;
  end else if Sysutils.SameText(Sender.fieldName , 'TERMS') then begin
    self.TermsId:= TTerms.IDToggle(Sender.AsString, Connection.Connection);
  end else if Sysutils.SameText(Sender.fieldName , 'TermsID')             then begin self.TermsName         := TTerms.IDToggle          (Sender.AsInteger,Connection.Connection);
  end else if Sysutils.SameText(Sender.fieldName , 'ShippingMethod')      then begin self.ShippingID        := TShippingMethod.IDToggle (Sender.AsString, Connection.Connection);
  end else if Sysutils.SameText(Sender.fieldName , 'ShippingID')          then begin self.ShippingMethodName:= TShippingMethod.IDToggle (Sender.AsInteger,Connection.Connection);
  end else if Sysutils.SameText(Sender.fieldName , 'RepID')               then begin RepName                := TEmployeeDetails.IDToggle(Sender.AsInteger,Connection.Connection)
  end else if Sysutils.SameText(Sender.fieldName , 'DefaultARAccountID')  then begin DefaultARAccount       := TAccount.IDToggle        (Sender.AsInteger,Connection.Connection)
  end else if Sysutils.SameText(Sender.fieldName , 'DefaultAPAccountID')  then begin DefaultAPAccount       := TAccount.IDToggle        (Sender.AsInteger,Connection.Connection)
  end else if Sysutils.SameText(Sender.fieldName , 'DefaultARAccount')    then begin DefaultARAccountID     := TAccount.IDToggle        (Sender.AsString, Connection.Connection)
  end else if Sysutils.SameText(Sender.fieldName , 'DefaultAPAccount')    then begin DefaultAPAccountID     := TAccount.IDToggle        (Sender.AsString, Connection.Connection)
  end else if Sysutils.SameText(Sender.fieldName , 'RepName')             then begin RepId                  := TEmployeeDetails.IDToggle(Sender.AsString, Connection.Connection)
  end else if Sysutils.SameText(Sender.fieldName , 'Manufacture')         then begin ManufactureID          := TManufacture.IDToggle    (sender.AsString, Connection.Connection);
  end else if Sysutils.SameText(Sender.fieldName , 'ManufactureID')       then begin self.ManufactureName   := TManufacture.IDToggle    (sender.AsInteger,Connection.Connection);
  end else if Sysutils.SameText(Sender.fieldName , 'TaxID') then begin
    TaxCodeName:= TTaxCode.IDToggle(TaxID, Connection.Connection,'RegionID = ' + IntToStr(AppEnv.RegionalOptions.ID));
  end
  else if Sysutils.SameText(Sender.fieldName , 'Taxname') then begin
    TaxID:= TTaxCode.IDToggle(self.TaxCodeName, Connection.Connection,'RegionID = ' + IntToStr(AppEnv.RegionalOptions.ID));
  end;
end;

Function TClient.DoMakePrimaryContact:Integer;
begin
  REsult := 0;
  if (Contacts.count=0) or (not(Contacts.locate('IsPrimarycontact' , 'T' , []))) then begin
      connection.BeginNestedTransaction;
      try
        Contacts.New;
        Contacts.ClientID          := ID;
        Contacts.ContactTitle      := Title;
        Contacts.ContactFirstName  := FirstName;
        Contacts.ContactSurName    := LastName;
        Contacts.ContactMOB        := Mobile;
        Contacts.jobtitle          := JobTitle;
        Contacts.ContactEmail      := Email;
        Contacts.Company           := Trim(Contacts.ContactFirstName + ' ' + Contacts.ContactSurname);
        Contacts.ISPrimaryContact  := True;
        Contacts.ContactPH         := Phone;
        Contacts.ContactFax        := FaxNumber;
        Contacts.ContactAltPH      := AltPhone;
        Contacts.ContactAddress    := Street;
        Contacts.ContactAddress2   := Street2;
        Contacts.ContactCity       := Suburb;
        Contacts.ContactState      := State;
        Contacts.ContactPcode      := Postcode;
        Contacts.Contactcountry    := Country;
        Contacts.Active            := True;
        if Contacts.Save then begin
          result :=Contacts.Id;
          Connection.CommitNestedTransaction;
        end else begin
          Connection.RollbackNestedTransaction;
        end;
      Except
        on E:Exception do begin
          Connection.RollbackNestedTransaction;
        end;
      end;
  end;
end;

class function TClient.ClientDefaultPOTemplateID(const aClientID: integer;
  Conn: TCustomMyConnection): integer;
var
  qry: TERPQuery;
begin
  if Assigned(Conn) then
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select DefaultPurchaseOrderTemplateID from tblClients');
    qry.SQL.Add('where ClientID = ' + IntToStr(aClientID));
    qry.Open;
    result := qry.FieldByName('DefaultPurchaseOrderTemplateID').AsInteger;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TClient.ClientEmailAddress(aClientID: Integer;  Conn: TERPConnection): String;
var
  C: TClient;
begin
  result := '';
  c:= TClient.Create(nil);
  try
    C.Connection := TMyDacDataConnection.Create(C);
    if Assigned(Conn) then C.Connection.Connection := Conn
    else C.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
    C.Load(aclientID);
    if C.Count = 1 then
      result := C.Email;
  finally
    C.Free;
  end;

end;

class function TClient.ClientIdForJobName(const aJobName: string; aParentClientId: integer; Conn: TCustomMyConnection): integer;
var
  qry: TERPQuery;
begin
  if Assigned(Conn) then
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Conn)
  else
    qry := DbSharedObjectsObj.DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Add('select ClientId from tblClients');
    qry.SQL.Add('where JobName = ' + QuotedStr(aJobName));
    if aParentClientId > 0 then
      qry.SQL.Add('and ParentClientId = ' + IntToStr(aParentClientId));
    qry.Open;
    result := qry.FieldByName('ClientId').AsInteger;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TClient.ClientIsOtherCotact(const aCompanyName: string;
  Conn: TCustomMyConnection): boolean;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Conn) then qry.Connection:= Conn
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text:= 'select OtherContact from tblClients where Company = '  + QuotedStr(aCompanyName);
    qry.Open;
    result:= qry.FieldByName('OtherContact').AsBoolean;
  finally
    qry.Free;
  end;
end;

class function TClient.CompanyExists(const aCompanyName: string;
  Conn: TERPConnection): boolean;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Conn) then qry.Connection:= Conn
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Text:= 'select Company from tblClients where Company = '  + QuotedStr(aCompanyName);
    qry.Open;
    result:= not qry.IsEmpty;
  finally
    qry.Free;
  end;
end;


procedure TClient.SetParentRelatedClientName(const Value: string);
var
  qry: TERPQuery;
begin
  if Value <> '' then begin
    { just add the id here, validation needs to check there is a record in
      tblrelatedclients }
    ParentRelatedClientId:= TClient.IDToggle(Value,Connection.Connection);
  end
  else begin
    if ParentRelatedClientId > 0 then begin
      { we previously had an id so need to delete record from xref table }
      qry:= TERPQuery.Create(nil);
      try
        qry.Connection:= Connection.Connection;
        qry.SQL.Add('delete from tblrelatedclients where ChildClientID = ' + IntToStr(self.ID));
        qry.SQL.Add('and MasterClientId = ' + IntToStr(ParentRelatedClientId));
        qry.Execute;
      finally
        qry.Free;
      end;
      ParentRelatedClientId:= 0;
    end;
  end;
end;

function TClient.GetPaymentMethodName: string;
begin
  if PayMethodID > 0 then
    result:= TPaymentMethod.IDToggle(PayMethodID)
  else
    result:= '';
end;

procedure TClient.SetPaymentMethodName(const Value: string);
begin
  if Value <> '' then
    PayMethodID:= TPaymentMethod.IDToggle(Value)
  else
    PayMethodID:= 0;
end;

function TClient.GetShippingAgentCode: string;
begin
  if ShippingAgentID > 0 then
    result:= TShippingAgent.IDToggle(ShippingAgentID,Connection.Connection)
  else
    result:= '';
end;

procedure TClient.SetShippingAgentCode(const Value: string);
begin
  if Value <> '' then
    ShippingAgentID:= TShippingAgent.IDToggle(Value,Connection.Connection)
  else
    ShippingAgentID:= 0;
end;

function TClient.GetTaxCodeName: string;
begin
  result := GetStringField('Taxname');
end;

procedure TClient.SetTaxCodeName(const Value: string);
begin
  SetStringField('Taxname',Value);
end;

class function TClient.DoMakeclientrec(AOwner: TComponent; conn :TMyDacDataConnection; aFirstname, aLastname,aEmailID: String; aisCustomer,aIsSupplier,aIsOthercontact:boolean ;CreateifnotExists:Boolean =False; aSource:String = ''): Integer;
var
  Client :Tclient;
begin
  if conn <> nil then begin
    Client := Tclient.create(AOwner);
    Client.connection := conn;
  end else begin
    Client := Tclient.CreateWithNewConn(AOwner);
  end;
  result := Client.DoMakeclient(AOwner, afirstname +' ' + aLastname,CreateifnotExists, aSource);
  if result <>0 then begin
    if aIscustomer      then Client.iscustomer    := true;
    if aIsSupplier      then Client.IsSupplier    := true;
    if aIsOthercontact  then Client.IsOthercontact:= true;
    Client.PostDB;
  end;
end;

{ TSupplier }
constructor TSupplier.Create(AOwner: TComponent);
begin
  inherited;
  CustomFieldIdentifier := 'Supp';
  fSQL := 'SELECT * FROM tblClients WHERE (Supplier = "T")';
  {Supplier}
  ExportExcludeList.Add('altcontact');
  ExportExcludeList.Add('arbalance');
  ExportExcludeList.Add('area');
  ExportExcludeList.Add('cardnumber');
//  ExportExcludeList.Add('clientno');
  ExportExcludeList.Add('clienttype');
  ExportExcludeList.Add('clienttypename');
  ExportExcludeList.Add('companytypename');
  ExportExcludeList.Add('creationdate');
  ExportExcludeList.Add('creditbalance');
  ExportExcludeList.Add('creditcardexpirydate');
  ExportExcludeList.Add('creditcardholdername');
  ExportExcludeList.Add('creditcardnotes');
  ExportExcludeList.Add('creditcardnumber');
  ExportExcludeList.Add('CreditCardCVC');
  ExportExcludeList.Add('creditcardtype');
  ExportExcludeList.Add('creditlimit');
  ExportExcludeList.Add('customer');
  ExportExcludeList.Add('customerjobnumber');
  ExportExcludeList.Add('customernextinvoiceno');
  ExportExcludeList.Add('dateentered');
  ExportExcludeList.Add('dateinactive');
  ExportExcludeList.Add('defaultclassname');
  ExportExcludeList.Add('defaultcontactmethod');
  ExportExcludeList.Add('deliverynotes');
  ExportExcludeList.Add('dischargedate');
  ExportExcludeList.Add('ExpiryDate');
  ExportExcludeList.Add('discount');
  ExportExcludeList.Add('specialdiscount');
  ExportExcludeList.Add('dontcontact');
  ExportExcludeList.Add('emailxml');
  ExportExcludeList.Add('EmailPOXML');
  ExportExcludeList.Add('finaldestination');
  ExportExcludeList.Add('forceponumoninvoice');
  ExportExcludeList.Add('forcepoonbooking');
  ExportExcludeList.Add('forcepoonrepair');
  ExportExcludeList.Add('graceperiod');
  ExportExcludeList.Add('groupdiscounts');
  ExportExcludeList.Add('groupdiscountoverridesall');
  ExportExcludeList.Add('hours');
  ExportExcludeList.Add('hourstakenforjob');
  ExportExcludeList.Add('incoplace');
  ExportExcludeList.Add('TeamviewerID');
  ExportExcludeList.Add('ClientCode');
  //ExportExcludeList.Add('SkypeName');
  ExportExcludeList.Add('invoicecomment');
  ExportExcludeList.Add('repairComment');
  ExportExcludeList.Add('invoicecommentpopup');
  ExportExcludeList.Add('RepairCommentPopUp');
  ExportExcludeList.Add('POComment');
  ExportExcludeList.Add('POCommentPopup');
  ExportExcludeList.Add('jobname');
  ExportExcludeList.Add('printjobname');
  ExportExcludeList.Add('LicenseRenewDurationType');
  ExportExcludeList.Add('jobnumber');
  ExportExcludeList.Add('jobregistration');
  ExportExcludeList.Add('jobtitle');
  ExportExcludeList.Add('manufacture');
  ExportExcludeList.Add('middlename');
  ExportExcludeList.Add('modelnumber');
  ExportExcludeList.Add('othercontacttype');
  ExportExcludeList.Add('parentclient');
  ExportExcludeList.Add('parentclientname');
  ExportExcludeList.Add('parentrelatedclientname');
  ExportExcludeList.Add('phonesupporttill');
  ExportExcludeList.Add('pickingpriority');
  ExportExcludeList.Add('CallPriority');
  ExportExcludeList.Add('portofdischarge');
  ExportExcludeList.Add('portoflanding');
  ExportExcludeList.Add('reminderdatetime');
  ExportExcludeList.Add('relatedclients');
  ExportExcludeList.Add('required');
  ExportExcludeList.Add('salesorderbalance');
  ExportExcludeList.Add('serialnumber');
  ExportExcludeList.Add('shippingagentcode');
  ExportExcludeList.Add('sourcename');
  ExportExcludeList.Add('specialinstructions');
  ExportExcludeList.Add('specialproductpriceoverridesall');
  ExportExcludeList.Add('stopcredit');
  ExportExcludeList.Add('tasks');
  ExportExcludeList.Add('taxcodename');
  ExportExcludeList.Add('updatedate');
  ExportExcludeList.Add('usecustomerinvoiceno');
  ExportExcludeList.Add('warrantyfinishdate');
  ExportExcludeList.Add('warrantyperiod');
  ExportExcludeList.Add('isinternal');
end;

destructor TSupplier.Destroy;
begin
  inherited;
end;

function TSupplier.ForeignKeysValid(const node: IXMLNode): Boolean;
var
  fsXMLTag: string;
begin
  Result := false;
  inherited ForeignKeysValid(node);
  fiShippingMethodID := 0;
  fiPayMethodID := 0;
  fiDefaultPOTemplateID := 0;
  fsXMLTag := 'ShippingMethod';
  if GetXMLNodeStringValue(Node, fsXMLTag) <> '' then
  begin
    fiShippingMethodID := tcDataUtils.getshippingMethod(GetXMLNodeStringValue(Node, fsXMLTag));
    if fiShippingMethodID = 0 then
    begin
      ErrRecordNotfound(fsXMLTag, GetXMLNodeStringValue(Node, fsXMLTag));
      Exit;
    end;
  end;
  fsXMLTag := 'PayMethod';
  if GetXMLNodeStringValue(Node, fsXMLTag) <> '' then
  begin
    fiPayMethodID := tcDataUtils.getshippingMethod(GetXMLNodeStringValue(Node, fsXMLTag));
    if fiPayMethodID = 0 then
    begin
      ErrRecordNotfound(fsXMLTag, GetXMLNodeStringValue(Node, fsXMLTag));
      Exit;
    end;
  end;
  fsXMLTag := 'DefaultPurchaseOrderTemplate';
  if GetXMLNodeStringValue(Node, fsXMLTag) <> '' then
  begin
    fiDefaultPOTemplateID := tcDataUtils.GetTemplate(GetXMLNodeStringValue(Node, fsXMLTag));
    if fiDefaultPOTemplateID = 0 then
    begin
      ErrRecordNotfound(fsXMLTag, GetXMLNodeStringValue(Node, fsXMLTag));
      Exit;
    end;
  end;
  Result := true;
end;

procedure TSupplier.SaveToXMLNode(const Node: IXMLNode);
begin
  inherited;
  AddXMLNode(Node, 'ARBalance', ARBalance);
  AddXMLNode(Node, 'ShipTime', ShipTime);
  AddXMLNode(Node, 'ABN', ABN);
  AddXMLNode(Node, 'ClientNo', ClientNo);
  AddXMLNode(Node, 'ShippingMethodName', ShippingMethodName);
  AddXMLNode(Node, 'BankAccountName', BankAccountName);
  AddXMLNode(Node, 'BankCode', BankCode);
  AddXMLNode(Node, 'BankAccountBSB', BankAccountBSB);
  AddXMLNode(Node, 'BankAccountNo', BankAccountNo);
  AddXMLNode(Node, 'ForeignExchangeSellCode', ForeignExchangeCode);
  AddXMLNode(Node, 'JobTitle', JobTitle);
  AddXMLNode(Node, 'CreditCardType', CreditCardType);
  AddXMLNode(Node, 'PhoneSupportTill', PhoneSupportTill);
  AddXMLNode(Node, 'BankLodgementRef', BankLodgementRef);
  AddXMLNode(Node, 'Contractor', Contractor);
  if not SavingXMLTofile then  begin
    AddXMLNode(Node, 'PayMethodID', PayMethodID);
  end  else  begin
    AddXMLNode(Node, 'PayMethod', tcDataUtils.GetPaymentMethod(PayMethodID));
  end;
  ExportsubClasses(Node);
end;


Function TSupplier.ValidEFTSupplier :Boolean;
begin
    result := (not Empty(BankAccountName)) and
                (not Empty(BankAccountBSB)) and
                (not Empty(BankAccountNo));
end;
procedure TSupplier.LoadFromXMLNode(const Node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(Node, 'ARBalance');
  SetPropertyFromNode(Node, 'ShipTime');
  SetPropertyFromNode(Node, 'ABN');
  SetPropertyFromNode(Node, 'ClientNo');
  SetPropertyFromNode(Node, 'ShippingMethodName');
  SetPropertyFromNode(Node, 'BankAccountName');
  SetPropertyFromNode(Node, 'BankCode');
  SetPropertyFromNode(Node, 'BankAccountBSB');
  SetPropertyFromNode(Node, 'BankAccountNo');
  SetPropertyFromNode(Node, 'ForeignExchangeSellCode');
  SetPropertyFromNode(Node, 'JobTitle');
  SetPropertyFromNode(Node, 'CreditCardType');
  SetDateTimePropertyFromNode(Node, 'PhoneSupportTill');
  SetPropertyFromNode(Node, 'BankLodgementRef');
  SetBooleanPropertyFromNode(Node, 'Contractor');
  if not ImportingFromXMLFile then
  begin
    SetPropertyFromNode(Node, 'PayMethodID');
    SetPropertyFromNode(Node, 'DefaultPurchaseOrderTemplate');
  end
  else
  begin {foreignKeysValid is bein executed, so the fi variables has the value}
    PayMethodID := fiPayMethodID;
    DefaultPOTemplateID := fiDefaultPOTemplateID;
  end;
end;

class function TSupplier.MakeSupplier(AOwner:TComponent; aClientName:String;CreateifnotExists:Boolean =False; aSource:String = ''): Integer;
var
  Supplier :TSupplier;
begin
  Result := 0;
  if aClientName = '' then exit;
  Supplier:= TSupplier.CreateWithNewConn(AOwner);
  try
    Result := Supplier.DoMakeclient(AOwner,aClientName,CreateifnotExists);
    Supplier.IsSupplier := True;
    Supplier.MedTypeID := TSource.MakeSource(AOwner, aSource);
    Supplier.PostDB;
  finally
    Freeandnil(Supplier);
  end;

end;

function TSupplier.GetSupplierCreditLimit: double;begin  result:= GetFloatField('SupplierCreditLimit');end;
procedure TSupplier.SetBankLodgementRef(const Value: string);
begin
  SetStringField('BankLodgementRef', Value);
end;

function TSupplier.GetBankName: String; begin Result := GetStringField('BankName'); end;
procedure TSupplier.SetBankName(const Value: string);
begin
  SetStringField('BankName', Value);
end;

function TSupplier.GetSwiftCode: String; begin Result := GetStringField('SwiftCode'); end;
procedure TSupplier.SetSwiftCode(const Value: string);
begin
  SetStringField('SwiftCode', Value);
end;

function TSupplier.GetRoutingNumber: String; begin Result := GetStringField('RoutingNumber'); end;
procedure TSupplier.SetRoutingNumber(const Value: string);
begin
  SetStringField('RoutingNumber', Value);
end;

procedure TSupplier.SetIgnoreSupplierforProductLatestCost(const Value: Boolean);begin  SetBooleanField('IgnoreSupplierforProductLatestCost' , Value);end;
procedure TSupplier.SetSupplierCreditLimit(const Value: double);begin  SetFloatField('SupplierCreditLimit',Value);end;
function TSupplier.GetSupplierId: Integer;begin  Result := ID;end;
function TSupplier.GetBankLodgementRef: string;begin  result := GetStringField('BankLodgementRef');end;

function TSupplier.getIgnoreSupplierforProductLatestCost: Boolean;begin  Result := GetBooleanfield('IgnoreSupplierforProductLatestCost');end;

class function TSupplier.GetKeyStringProperty: string;begin  result:= 'ClientName';end;

function TSupplier.GetSupplierCustomfieldValues: TSupplierCustomfieldValues;
begin
  REsult := TSupplierCustomfieldValues(getContainerComponent(TSupplierCustomfieldValues ,'CFV.MasterId = ' + IntToStr(Self.ID) ));
end;
function TSupplier.getRunningAPBalance: double;
begin
  with getNewDataset('select Sum(ifnull(Balance,0)) Balance from tblpurchaseorders PO where (ISPO ="T" or IsBill ="T" ) and ClientId = ' +inttostr(ID) , true ) do try
    REsult := Fieldbyname('Balance').asFloat;
  finally
    if active then close;
    Free;
  end;
  with getNewDataset('select Sum(ifnull(Balance,0)) Balance from tblpurchaseorders PO where  ISCredit = "T" and ClientId = ' +inttostr(ID) , true ) do try
    REsult := Result - Fieldbyname('Balance').asFloat;
  finally
    if active then close;
    Free;
  end;
  with getNewDataset('select Sum(ifnull(Balance,0)) Balance from tblprepayments P where P.Supplier ="T" and ifnull(P.balance,0) <>0  and ClientId = ' +inttostr(ID) , true ) do try
    REsult := result - Fieldbyname('Balance').asFloat;
  finally
    if active then close;
    Free;
  end;
end;

function TSupplier.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  self.IsSupplier:= true;
  result:= inherited DoAfterInsert(Sender);
end;

class function TSupplier.IDToggle(const ID: Integer;
  Connection: TCustomMyConnection; const AndSQL: string): string;
begin
  result:= inherited IdToggle(ID, Connection,'Supplier = "T"');
end;

class function TSupplier.IDToggle(const KeyString: string;
  Connection: TCustomMyConnection; const AndSQL: string): Integer;
begin
  result:= inherited IdToggle(KeyString, Connection,'Supplier = "T"');
end;

function TSupplier.ValidateData: Boolean;
begin
  result:= inherited ValidateData;
  if not result then exit;
  result:= false;
  if (not Active) and (self.Balance <> 0) then begin
    AddResult(false,rssWarning,0,'Can not make this Supplier inactive as there is an outstanding balance');
    exit;
  end;
  if AppEnv.CompanyPrefs.EnforcesupplierFirstName then begin
    if FirstName = '' then begin
      AddResult(false, rssWarning, 0, 'You must provide the First Name of the Supplier');
      exit;
    end;
  end;

  result:= true;
end;

function TSupplier.Save: boolean;
begin
  result:= ValidateData;
  if result then
    result:= inherited Save;
end;

{ TCustomer }
constructor TCustomer.Create(AOwner: TComponent);
begin
  inherited;
  CustomFieldIdentifier := 'Cust';
  fSQL := 'SELECT * FROM tblClients WHERE (Customer = "T")';
  {Customer}
  ExportExcludeList.Add('apbalance');
  ExportExcludeList.Add('bpaybillercode');
  ExportExcludeList.Add('bpayreference');
  ExportExcludeList.Add('companytypename');
  ExportExcludeList.Add('customer');
  ExportExcludeList.Add('customerjobnumber');
  ExportExcludeList.Add('creationdate');
  ExportExcludeList.Add('creditcardexpirydate');
  ExportExcludeList.Add('creditcardholdername');
  ExportExcludeList.Add('creditcardnotes');
  ExportExcludeList.Add('creditcardnumber');
  ExportExcludeList.Add('CreditCardCVC');
  ExportExcludeList.Add('creditcardtype');
  ExportExcludeList.Add('dateinactive');
  ExportExcludeList.Add('dateentered');
  ExportExcludeList.Add('hourstakenforjob');
  //ExportExcludeList.Add('jobname');
  ExportExcludeList.Add('printjobname');
  ExportExcludeList.Add('LicenseRenewDurationType');
  ExportExcludeList.Add('jobnumber');
  ExportExcludeList.Add('jobregistration');
  ExportExcludeList.Add('jobtitle');
  ExportExcludeList.Add('manufacture');
  ExportExcludeList.Add('middlename');
  ExportExcludeList.Add('othercontacttype');
  ExportExcludeList.Add('reminderdatetime');
  ExportExcludeList.Add('required');
  ExportExcludeList.Add('serialnumber');
  ExportExcludeList.Add('shiptime');
  ExportExcludeList.Add('specialinstructions');
  ExportExcludeList.Add('tasks');
  ExportExcludeList.Add('updatedate');
  ExportExcludeList.Add('warrantyfinishdate');
  ExportExcludeList.Add('warrantyperiod');
end;

destructor TCustomer.Destroy;
begin
  fRelatedCustomers.Free;
  inherited;
end;

Function  TCustomer.DoBeforePost(Sender :TDatasetBusObj ):Boolean;
begin
    REsult := inherited DoBeforePost(Sender);
    if not result then Exit;
    if ClientTypeID=0 then clientTypeID := 0;
end;
function TCustomer.ForeignKeysValid(const node: IXMLNode): Boolean;
var
  fsXMLTag: string;
begin
  Result := false;
  inherited ForeignKeysValid(node);
  fiClientTypeID := 0;
  fiTAXCODEID := 0;
  fiDefaultInvTemplateID := 0;
  fiDefaultDelTemplateID := 0;
  fiShippingMethodID := 0;
  fiPayMethodID := 0;
  fsXMLTag := 'ShippingMethod';
  if GetXMLNodeStringValue(Node, fsXMLTag) <> '' then
  begin 
    fiShippingMethodID := tcDataUtils.getshippingMethod(GetXMLNodeStringValue(Node, fsXMLTag));
    if fiShippingMethodID = 0 then 
    begin 
      ErrRecordNotfound(fsXMLTag, GetXMLNodeStringValue(Node, fsXMLTag));
      Exit;
    end;
  end;
  fsXMLTag := 'PayMethod';
  if GetXMLNodeStringValue(Node, fsXMLTag) <> '' then 
  begin 
    fiPayMethodID := tcDataUtils.GetPaymentMethod(GetXMLNodeStringValue(Node, fsXMLTag));
    if fiPayMethodID = 0 then 
    begin 
      ErrRecordNotfound(fsXMLTag, GetXMLNodeStringValue(Node, fsXMLTag));
      Exit;
    end;
  end;
  fsXMLTag := 'ClientType';
  if GetXMLNodeStringValue(Node, fsXMLTag) <> '' then 
  begin 
    fiClientTypeID := tcDataUtils.getClientTypeID(GetXMLNodeStringValue(Node, fsXMLTag));
    if fiClientTypeID = 0 then 
    begin 
      ErrRecordNotfound(fsXMLTag, GetXMLNodeStringValue(Node, fsXMLTag));
      Exit;
    end;
  end;
  fsXMLTag := 'TAXCODE';
  if GetXMLNodeStringValue(Node, fsXMLTag) <> '' then 
  begin 
    fiTAXCODEID := tcDataUtils.getTaxcodeID(GetXMLNodeStringValue(Node, fsXMLTag));
    if fiTAXCODEID = 0 then 
    begin 
      ErrRecordNotfound(fsXMLTag, GetXMLNodeStringValue(Node, fsXMLTag));
      Exit;
    end;
  end;
  fsXMLTag := 'DefaultInvoiceTemplate';
  if GetXMLNodeStringValue(Node, fsXMLTag) <> '' then 
  begin 
    fiDefaultInvTemplateID := tcDataUtils.GetTemplate(GetXMLNodeStringValue(Node, fsXMLTag));
    if fiDefaultInvTemplateID = 0 then 
    begin 
      ErrRecordNotfound(fsXMLTag, GetXMLNodeStringValue(Node, fsXMLTag));
      Exit;
    end;
  end;
  fsXMLTag := 'DefaultDeliveryTemplate';
  if GetXMLNodeStringValue(Node, fsXMLTag) <> '' then 
  begin 
    fiDefaultDelTemplateID := tcDataUtils.GetTemplate(GetXMLNodeStringValue(Node, fsXMLTag));
    if fiDefaultDelTemplateID = 0 then 
    begin 
      ErrRecordNotfound(fsXMLTag, GetXMLNodeStringValue(Node, fsXMLTag));
      Exit;
    end;
  end;
  Result := true;
end;

function TCustomer.GetAddressValid: boolean;
begin
  result := GetBooleanField('AddressValid');
end;

function TClient.getCustomerEquipment: TCustomerEquipment;
begin
  REsult := TCustomerEquipment(getContainerComponent(TCustomerEquipment ,'ClientID = ' + IntToStr(Self.ID) ));
end;
function TCustomer.getCustomerShippingOptions: TCustomerShippingOptions;
begin
  REsult := TCustomerShippingOptions(getContainerComponent(TCustomerShippingOptions ,'CustomerId = ' + IntToStr(Self.ID) ));
end;
procedure TCustomer.SaveToXMLNode(const Node: IXMLNode);
begin 
  inherited;
  AddXMLNode(Node, 'InvoiceCommentPopup', InvoiceCommentPopup);
  AddXMLNode(Node, 'RepairCommentPopUp', RepairCommentPopUp);
  AddXMLNode(Node, 'POCommentPopup', POCommentPopup);
  AddXMLNode(Node, 'CreditLimit', CreditLimit);
  AddXMLNode(Node, 'hours', hours);
  AddXMLNode(Node, 'ARBalance', ARBalance);
  AddXMLNode(Node, 'GracePeriod', GracePeriod);
  AddXMLNode(Node, 'Area', Area);
  AddXMLNode(Node, 'AltContact', AltContact);
  AddXMLNode(Node, 'CardNumber', CardNumber);
  AddXMLNode(Node, 'DeliveryNotes', DeliveryNotes);
  AddXMLNode(Node, 'DefaultContactMethod', DefaultContactMethod);
  AddXMLNode(Node, 'CreditCardNumber', CreditCardNumber);
  AddXMLNode(Node, 'CreditCardCVC', CreditCardCVC);
  AddXMLNode(Node, 'CreditCardExpiryDate', CreditCardExpiryDate);
  AddXMLNode(Node, 'CreditCardCardHolderName', CreditCardHolderName);
  AddXMLNode(Node, 'CreditCardNotes', CreditCardNotes);
  AddXMLNode(Node, 'EmailXML', EmailXML);
  AddXMLNode(Node, 'EmailPOXML', EmailPOXML);
  AddXMLNode(Node, 'InvoiceComment', InvoiceComment);
  AddXMLNode(Node, 'repairComment', repairComment);
  AddXMLNode(Node, 'POComment', POComment);
  AddXMLNode(Node, 'ABN', ABN);
  AddXMLNode(Node, 'ClientNo', ClientNo);
  AddXMLNode(Node, 'ShippingMethodName', ShippingMethodName);
  AddXMLNode(Node, 'BankAccountName', BankAccountName);
  AddXMLNode(Node, 'BankCode', BankCode);
  AddXMLNode(Node, 'BankAccountBSB', BankAccountBSB);
  AddXMLNode(Node, 'BankAccountNo', BankAccountNo);
  AddXMLNode(Node, 'ForeignExchangeSellCode', ForeignExchangeCode);
  AddXMLNode(Node, 'JobTitle', JobTitle);
  AddXMLNode(Node, 'CreditCardType', CreditCardType);
  AddXMLNode(Node, 'DischargeDate', DischargeDate);
  AddXMLNode(Node, 'ExpiryDate', ExpiryDate);
  AddXMLNode(Node, 'PhoneSupportTill', PhoneSupportTill);
  if not SavingXMLTofile then  begin
    AddXMLNode(Node, 'ClientTypeId', ClientTypeId);
    AddXMLNode(Node, 'TAXID', TAXID);
    AddXMLNode(Node, 'DefaultDeliveryTemplateID', DefaultDelTemplateID);
    AddXMLNode(Node, 'DefaultInvoiceTemplateID', DefaultInvTemplateID);
    AddXMLNode(Node, 'ShippingID', ShippingID);
    AddXMLNode(Node, 'PayMethodID', PayMethodID);
  end  else  begin
    AddXMLNode(Node, 'ClientType', tcDataUtils.getClientTypeName(ClientTypeId));
    AddXMLNode(Node, 'TaxCode', tcDataUtils.getTaxcode(TaxID));
    AddXMLNode(Node, 'DefaultInvoiceTemplate', tcDataUtils.GetTemplate(DefaultInvTemplateID));
    AddXMLNode(Node, 'DefaultDeliveryTemplate', tcDataUtils.GetTemplate(DefaultDelTemplateID));
    AddXMLNode(Node, 'PayMethod', tcDataUtils.GetPaymentMethod(PayMethodID));
  end;
  ExportsubClasses(Node);
end;

procedure TCustomer.LoadFromXMLNode(const Node: IXMLNode);
begin 
  inherited;
    SetBooleanPropertyFromNode(Node, 'InvoiceCommentPopup');
    SetBooleanPropertyFromNode(Node, 'RepairCommentPopUp');
    SetBooleanPropertyFromNode(Node, 'POCommentPopup');
    SetPropertyFromNode(Node, 'CreditLimit');
    SetPropertyFromNode(Node, 'hours');
    SetPropertyFromNode(Node, 'ARBalance');
    SetPropertyFromNode(Node, 'GracePeriod');
    SetPropertyFromNode(Node, 'Area');
    SetPropertyFromNode(Node, 'AltContact');
    SetPropertyFromNode(Node, 'CardNumber');
    SetPropertyFromNode(Node, 'DeliveryNotes');
    SetPropertyFromNode(Node, 'DefaultContactMethod');
    SetPropertyFromNode(Node, 'CreditCardNumber');
    SetPropertyFromNode(Node, 'CreditCardCVC');
    SetPropertyFromNode(Node, 'CreditCardExpiryDate');
    SetPropertyFromNode(Node, 'CreditCardCardHolderName');
    SetPropertyFromNode(Node, 'CreditCardNotes');
    SetPropertyFromNode(Node, 'EmailXML');
    SetPropertyFromNode(Node, 'EmailPOXML');
    SetPropertyFromNode(Node, 'InvoiceComment');
    SetPropertyFromNode(Node, 'repairComment');
    SetPropertyFromNode(Node, 'POComment');
    SetPropertyFromNode(Node, 'ABN');
    SetPropertyFromNode(Node, 'ClientNo');
    SetPropertyFromNode(Node, 'ShippingMethodName');
    SetPropertyFromNode(Node, 'BankAccountName');
    SetPropertyFromNode(Node, 'BankCode');
    SetPropertyFromNode(Node, 'BankAccountBSB');
    SetPropertyFromNode(Node, 'BankAccountNo');
    SetPropertyFromNode(Node, 'ForeignExchangeSellCode');
    SetPropertyFromNode(Node, 'JobTitle');
    SetPropertyFromNode(Node, 'CreditCardType');
    SetDateTimePropertyFromNode(Node, 'DischargeDate');
    SetDateTimePropertyFromNode(Node, 'ExpiryDate');
    SetDateTimePropertyFromNode(Node, 'PhoneSupportTill');
  if not ImportingFromXMLFile then
  begin
    SetPropertyFromNode(Node, 'ClientTypeId');
    SetPropertyFromNode(Node, 'TAXID');
    SetPropertyFromNode(Node, 'DefaultInvoiceTemplateID');
    SetPropertyFromNode(Node, 'DefaultDeliveryTemplateID');
    SetPropertyFromNode(Node, 'ShippingID');
    SetPropertyFromNode(Node, 'PayMethodID');
  end
  else 
  begin 
    ClientTypeID := fiClientTypeID;
    TAXID        := fiTAXCODEID;
    DefaultInvTemplateID := fiDefaultInvTemplateID;
    DefaultDelTemplateID := fiDefaultDelTemplateID;
    ShippingID   := fiShippingMethodID;
    PayMethodID  := fiPayMethodID;
  end;
end;

class function TCustomer.MakeCustomer(AOwner:TComponent; aClientName:String;CreateifnotExists:Boolean =False; aSource:String = ''):Integer;
var
  Customer :TCustomer;
begin
  Result := 0;
  if aClientName = '' then exit;
  Customer:= TCustomer.CreateWithNewConn(AOwner);
  try
    Result := Customer.DoMakeclient(AOwner,aClientName,CreateifnotExists, aSource);
    Customer.IsCustomer := True;
    Customer.MedTypeID := TSource.MakeSource(AOwner, aSource);
    Customer.PostDB;
  finally
    Freeandnil(Customer);
  end;
end;
function Readfromjson  (json:TJsonObject;tagname:String):string;begin result := ''; if not json.Exists(tagname) then exit; REsult := json.S[tagname];end;
function Read_Address1 (json:TJsonObject):string;begin Result := ''; try if json.Exists('street') and (json.A['street'].Count>0) then result := json.A['street'].items[0].AsString; except end; end;
function Read_Address2 (json:TJsonObject):string;begin Result := ''; try if json.Exists('street') and (json.A['street'].Count>1) then result := json.A['street'].items[1].AsString; except end; end;
function Read_Address3 (json:TJsonObject):string;begin Result := ''; try if json.Exists('street') and (json.A['street'].Count>2) then result := json.A['street'].items[2].AsString; except end; end;
function Read_City     (json:TJsonObject):string;begin Result := ''; try Result := Readfromjson(json , 'city');                                                                     except end; end;
function Read_postCode (json:TJsonObject):string;begin Result := ''; try Result := Readfromjson(json , 'postcode');                                                                 except end; end;
function Read_telephone(json:TJsonObject):string;begin Result := ''; try Result := Readfromjson(json , 'telephone');                                                                 except end; end;
function Read_State    (json:TJsonObject):string;begin Result := ''; try if json.Exists('region') then Result := json.O['region'].S['region'];                                      except end; end;
function Read_Country  (json:TJsonObject):string;begin Result := ''; try  Result := Readfromjson(json , 'country_id');                                                             except end; end;

Class Function TCustomer.MakeMagentoGuestCustomer(Data: TJsonObject; conn :TMyDacDataConnection; aSource:String): Integer;
var
  JsMagentoCustomer:TJsonObject;
  aAddress:TJsonObject;
  ctr:Integer;
begin
  JsMagentoCustomer:= JO;
  try
      JsMagentoCustomer.S['firstname']  := trim(Data.S['customer_firstname']);
      JsMagentoCustomer.S['lastname']   := trim(Data.S['customer_lastname']);
      JsMagentoCustomer.S['email']      := trim(Data.S['customer_email']);
      if Data.Exists('billing_address') then begin
        aAddress := JO;
        aAddress.B['default_billing']:= True;
        aAddress.A['street'].add(Read_Address1(Data.O['billing_address']));
        aAddress.A['street'].add(Read_Address2(Data.O['billing_address']));
        aAddress.A['street'].add(Read_Address3(Data.O['billing_address']));
        aAddress.S['city']      := Read_City(Data.O['billing_address']);
        aAddress.S['postcode']  := Read_postCode(Data.O['billing_address']);
        aAddress.S['telephone'] := Read_telephone(Data.O['billing_address']);
        aAddress.S['country_id']:= Read_Country(Data.O['billing_address']);
        aAddress.O['region'].S['region'] := Readfromjson(Data.O['billing_address'] , 'region');
        JsMagentoCustomer.A['addresses'].Add(aAddress);
      end;
     if Data.Exists('extension_attributes') then
      if Data.O['extension_attributes'].Exists('shipping_assignments') and (Data.O['extension_attributes'].A['shipping_assignments'].count >0 ) then
        for ctr := 0 to  Data.O['extension_attributes'].A['shipping_assignments'].count -1 do
          if (Data.O['extension_attributes'].A['shipping_assignments'].items[ctr].asObject).exists('shipping') then
            if (Data.O['extension_attributes'].A['shipping_assignments'].items[ctr].asObject).O['shipping'].exists('address') then
              if (Data.O['extension_attributes'].A['shipping_assignments'].items[ctr].asObject).O['shipping'].O['address'].exists('address_type') and
                  ((Data.O['extension_attributes'].A['shipping_assignments'].items[ctr].asObject).O['shipping'].O['address'].S['address_type'] = 'shipping')  then begin
                    aAddress := JO;
                    aAddress.B['default_shipping']:= True;
                    aAddress.A['street'].add(Read_Address1((Data.O['extension_attributes'].A['shipping_assignments'].items[ctr].asObject).O['shipping'].O['address']));
                    aAddress.A['street'].add(Read_Address2((Data.O['extension_attributes'].A['shipping_assignments'].items[ctr].asObject).O['shipping'].O['address']));
                    aAddress.A['street'].add(Read_Address3((Data.O['extension_attributes'].A['shipping_assignments'].items[ctr].asObject).O['shipping'].O['address']));
                    aAddress.S['city']      := Read_City((Data.O['extension_attributes'].A['shipping_assignments'].items[ctr].asObject).O['shipping'].O['address']);
                    aAddress.S['postcode']  := Read_postCode((Data.O['extension_attributes'].A['shipping_assignments'].items[ctr].asObject).O['shipping'].O['address']);
                    aAddress.S['telephone'] := Read_telephone((Data.O['extension_attributes'].A['shipping_assignments'].items[ctr].asObject).O['shipping'].O['address']);
                    aAddress.S['country_id']:= Read_Country((Data.O['extension_attributes'].A['shipping_assignments'].items[ctr].asObject).O['shipping'].O['address']);
                    aAddress.O['region'].S['region'] := Readfromjson((Data.O['extension_attributes'].A['shipping_assignments'].items[ctr].asObject).O['shipping'].O['address'] , 'region');
                    JsMagentoCustomer.A['addresses'].Add(aAddress);
              end;
      Result := TCustomer.MakeMagentoCustomer(JsMagentoCustomer, conn , aSource);
  finally
    JsMagentoCustomer.free;
  end;
end;
Class function TCustomer.MakeMagentoCustomer(Data: TJsonObject; conn :TMyDacDataConnection; aSource:String): Integer;
var
  Customer :TCustomer;
  ctr:Integer;
  fiMedTypeID :Integer;
  fsAddress1,  fsAddress2,  fsCity,  fspostCode,  fsState,  fsCountry:String;


(*  function Readfromjson(json:TJsonObject;tagname:String):string;
  begin
    result := '';
    if not json.Exists(tagname) then exit;
    REsult := json.S[tagname];
  end;
  function Read_Address1(json:TJsonObject):string;begin Result := ''; try if json.Exists('street') and (json.A['street'].Count>0) then result := json.A['street'].items[0].AsString; except end; end;
  function Read_Address2(json:TJsonObject):string;begin Result := ''; try if json.Exists('street') and (json.A['street'].Count>1) then result := json.A['street'].items[1].AsString; except end; end;
  function Read_Address3(json:TJsonObject):string;begin Result := ''; try if json.Exists('street') and (json.A['street'].Count>2) then result := json.A['street'].items[2].AsString; except end; end;
  function Read_City    (json:TJsonObject):string;begin Result := ''; try Result := Readfromjson(json , 'city');                                                                     except end; end;
  function Read_postCode(json:TJsonObject):string;begin Result := ''; try Result := Readfromjson(json , 'postcode');                                                                 except end; end;
  function Read_State   (json:TJsonObject):string;begin Result := ''; try if json.Exists('region') then Result := json.O['region'].S['region'];                                      except end; end;
  function Read_Country (json:TJsonObject):string;begin Result := ''; try  Result := Readfromjson(json , 'country_id');                                                             except end; end;*)
  Function AddressObj :TJsonObject; begin result := Data.A['addresses'].Items[ctr].asObject; end;
begin
   Customer := TCustomer.Create(nil);
  try
    Customer.connection := conn;
    Customer.Connection.beginnestedTransaction;
    try
        //Customer.DoMakeclient(nil,trim(Data.S['firstname']) +' '+ trim(Data.S['lastname']),true, aSource);
        Customer.DoMakeMagentoclient(nil , trim(Data.S['firstname']), trim(Data.S['lastname']), trim(Data.S['email']), asource);
        if (Data.S['firstname'] <> '') then Customer.Firstname := Data.S['firstname'];
        if Data.S['lastname']   <> ''  then Customer.lastname  := Data.S['lastname'];
        if customer.Email       =  ''  then customer.Email     := Data.S['email'];
        if Customer.MedTypeID =0 then begin
          fiMedTypeID := TSource.MakeSource(Customer, aSource);
          if Customer.MedTypeID <> fiMedTypeID then Customer.MedTypeID :=  fiMedTypeID;
        end;
        if Customer.dirty and (not Customer.save) then begin
          Result := 0;
          Customer.Connection.RollbackNestedTransaction;
          Exit;
        end;
        if (Data.Exists('addresses')) and (Data.A['addresses'].Count>0) then begin
           for ctr := 0 to Data.A['addresses'].Count-1 do begin
              if trim(AddressObj.S['telephone'])<> '' then
                if  trim(customer.phone) ='' then customer.phone := trim(AddressObj.S['telephone'])
                else if  trim(customer.AltPhone) ='' then customer.AltPhone := trim(AddressObj.S['telephone']);
                fsAddress1:= trim(Read_Address1(AddressObj));
                fsAddress2:= trim(Read_Address2(AddressObj));
                fsCity    := trim(Read_City    (AddressObj));
                fspostCode:= trim(Read_postCode(AddressObj));
                fsState   := trim(Read_State   (AddressObj));
                fsCountry := trim(Read_Country (AddressObj));
                if fspostCode <> '' then
                       if copy(fsAddress1, length(fsAddress1)-length(fspostCode)+1,Length(fspostCode)+1) = fspostCode then fsAddress1 :=copy(fsAddress1, 1, length(fsAddress1)-length(fspostCode))
                  else if copy(fsAddress2, length(fsAddress2)-length(fspostCode)+1,Length(fspostCode)+1) = fspostCode then fsAddress2 :=copy(fsAddress2, 1, length(fsAddress1)-length(fspostCode));

              if Customer.ShippingAddresses.Locate('ShipAddress;ShipAddress1;ShipCity;ShipPostCode;ShipState' ,
                                      varArrayof([fsAddress1,fsAddress2,fsCity,fspostCode,fsState]), []) = False then begin
                  Customer.ShippingAddresses.New;
                  Customer.ShippingAddresses.CustomerID   := Customer.ID;
                  Customer.ShippingAddresses.CompanyName  := Customer.ClientName;
                  Customer.ShippingAddresses.ShipAddress  := fsAddress1;
                  Customer.ShippingAddresses.ShipAddress1 := fsAddress2;
                  Customer.ShippingAddresses.ShipCity     := fsCity;
                  Customer.ShippingAddresses.ShipPostCode := fspostCode;
                  Customer.ShippingAddresses.ShipState    := fsState;
                  Customer.ShippingAddresses.ShipCountry  := fsCountry;
                  Customer.ShippingAddresses.PostDB;

                  if (AddressObj.Exists('default_shipping') and AddressObj.B['default_shipping']) or (Customer.Street = '')  then begin
                    //if Customer.Street = '' then begin  // if address is blank
                      Customer.Street   := Customer.ShippingAddresses.ShipAddress;
                      Customer.Street2  := Customer.ShippingAddresses.ShipAddress1;
                      Customer.Suburb   := Customer.ShippingAddresses.ShipCity;
                      Customer.State    := Customer.ShippingAddresses.ShipState;
                      Customer.Country  := Customer.ShippingAddresses.ShipCountry;
                      Customer.Postcode := Customer.ShippingAddresses.ShipPostCode;
                      Customer.PostDB;
                    //end;
                  end;
                  if (AddressObj.Exists('default_billing') and AddressObj.B['default_billing']) or (Customer.BillStreet = '') then begin
                    //if Customer.BillStreet = '' then begin  // if bill address is blank
                      Customer.BillStreet   := Customer.ShippingAddresses.ShipAddress;
                      Customer.BillStreet2  := Customer.ShippingAddresses.ShipAddress1;
                      Customer.BillSuburb   := Customer.ShippingAddresses.ShipCity;
                      Customer.BillState    := Customer.ShippingAddresses.ShipState;
                      Customer.BillCountry  := Customer.ShippingAddresses.ShipCountry;
                      Customer.BillPostcode := Customer.ShippingAddresses.ShipPostCode;
                      Customer.PostDB;
                    //end;
                  end;
              end;
           end;
        end;
        Customer.Connection.CommitnestedTransaction;
        Result := Customer.ID;
    Except
      on E:EXception do begin
        Result := 0;
        Customer.Connection.RollbackNestedTransaction;
      end;
    end;

  finally
    Freeandnil(Customer);
  end;

end;

function TCustomer.getCustomerGlobalRef: String;
begin
  REsult := globalref;
  if isJob then
    Result := ParentClient.globalref;
end;

function TCustomer.getCustomerPhysicalAddressshipAddressID: Integer;
var
  fReadonly :Boolean;
begin
  fiCustomerPhysicalAddressshipAddressID := 0;
  ShippingAddresses.IterateRecords(CustomerPhysicalAddressshipAddressIDCallback);
  result :=fiCustomerPhysicalAddressshipAddressID;
  if result =0 then begin

    if Self.Lock(LockGroupName) =False then begin
      ResultStatus.AddItem(false, rssWarning, 0, replaceStr(replacestr(UserLock.LockMessage ,'Unable to update data.' , 'Unable to create the shipping address for the Customer''s Billing Address.' ),'accessing this record' , 'accessing this Customer record'));
      exit;
    end;

    fReadonly := Self.IsReadonly;
    IsReadonly := false;
    Try
      ShippingAddresses.New;
      ShippingAddresses.CustomerID := ID;
      ShippingAddresses.CustomerPhysicalAddress:= True;
      ShippingAddresses.CompanyName:= ClientName;
      ShippingAddresses.ContactName := Primarycontactname;
      ShippingAddresses.ShipAddress       := Street;
      ShippingAddresses.ShipAddress1      := Street2;
      ShippingAddresses.ShipCity          := Suburb;
      ShippingAddresses.ShipPostCode      := Postcode;
      ShippingAddresses.ShipState         := State;
      ShippingAddresses.ShipCountry       := Country;
      ShippingAddresses.ShipAddress2      := Street3;
      ShippingAddresses.Active            := True;
      ShippingAddresses.PortOfLanding     := PortOfLanding;
      ShippingAddresses.PortOfDischarge   := PortOfDischarge;
      ShippingAddresses.FinalDestination  := FinalDestination;
      ShippingAddresses.IncoPlace         := IncoPlace;
      ShippingAddresses.Phone             := Phone;
      ShippingAddresses.email             := Email;
      ShippingAddresses.Save;
      REsult := ShippingAddresses.ID;
    Finally
      IsReadonly := fReadonly;
    End;
  end;
end;
function TCustomer.getJobs: TJob;
begin
  REsult := TJob(getContainerComponent(TJob ,'ParentClientId= ' + IntToStr(Self.ID) ));
end;

procedure TCustomer.CustomerPhysicalAddressshipAddressIDCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not (Sender is TShippingAddress) then exit;
  if TShippingAddress(Sender).CustomerPhysicalAddress then begin
    fiCustomerPhysicalAddressshipAddressID := TShippingAddress(Sender).ID;
    Abort := True;
  end;
end;
class function TCustomer.GetKeyStringProperty: string;
begin
  result:= 'ClientName';
end;

function TCustomer.getTCustomerCustomfieldValues: TCustomerCustomfieldValues;
begin
  REsult := TCustomerCustomfieldValues(getContainerComponent(TCustomerCustomfieldValues ,'CFV.MasterId = ' + IntToStr(Self.ID) ));
end;

function TCustomer.getTShippingAgent: TShippingAgent;
begin
  REsult := TShippingAgent(getContainerComponent(TShippingAgent ,'ShippingAgentID = ' + IntToStr(Self.ShippingAgentID) ));
end;

function TCustomer.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  IsCustomer:= true;
  if AppEnv.CompanyPrefs.CustomerTypeRequired then begin
    self.ClientTypeId:= DefaultclientTypeId;
  end;
end;

class function TCustomer.IDToggle(const ID: Integer;
  Connection: TCustomMyConnection; const AndSQL: string): string;
begin
  result:= inherited IdToggle(ID, Connection,'Customer = "T"');
end;

class function TCustomer.IDToggle(const KeyString: string;
  Connection: TCustomMyConnection; const AndSQL: string): Integer;
begin
  result:= inherited IdToggle(KeyString, Connection,'Customer = "T"');
end;

function TCustomer.GetRelatedCustomers: TRelatedCustomer;
begin
  if not Assigned(fRelatedCustomers) then
  begin
    fRelatedCustomers := TRelatedCustomer.Create(self);
    if Assigned(Self.Connection) then
      fRelatedCustomers.Connection := Self.connection;
    fRelatedCustomers.LoadSelect('MasterClientID = ' + IntToStr(ID));
  end;
  Result := fRelatedCustomers;
end;

function TCustomer.ValidateData: Boolean;
begin
  result:= inherited ValidateData;
  if not result then exit;
  result:= false;
  if (not Active) and (self.Balance <> 0) then begin
    AddResult(false,rssWarning,0,'Can not make this Customer inactive as there is an outstanding balance');
    exit;
  end;
  if (self.ClientTypeId < 1) and AppEnv.CompanyPrefs.CustomerTypeRequired then begin
    AddResult(false,rssWarning,0,'Customer (Client) Type can not be blank');
    exit;
  end;
  if not AppEnv.CompanyPrefs.DisableCusSourceTracking then
  begin
    if MedTypeID = 0 then
    begin
      self.AddResult(false, rssWarning, 0, 'Source should not be blank');
      Exit;
    end;
  end;
  if (OpeningRewardPoints.Count > 0) and (not OpeningRewardPoints.ValidateData) then begin
    exit;
  end;
  if not RawMode then begin
    if AppEnv.CompanyPrefs.EnforceCustomerFirstAndLastName then begin
      if FirstName = '' then begin
        AddResult(false, rssWarning, 0, 'First Name should not be blank ');
        Exit;
      end;
      if LastName = '' then begin
        AddResult(false, rssWarning, 0, 'Last Name should not be blank ');
        Exit;
      end;
    end;

  end;
  result:= true;
end;

class function TCustomer._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TCustomer','ParentRelatedClientObj','ParentClientID','ParentRelatedClientID');
  TBOSchema.AddRefType(result,'TCustomer','ParentRelatedClientObj','ParentRelatedClientName','ClientName');
end;

function TCustomer.Save: boolean;
begin
  result:= ValidateData;
  if result then
    result:= inherited Save;
  if result then begin
    { delete reward points opening balance recored if fields blank
      eg user has imported data and cleared these fields }
    if (OpeningRewardPoints.Count > 0) and
       (OpeningRewardPoints.LinePoints = 0) and (OpeningRewardPoints.OpeningBalanceAsOn = 0) then begin
      result:= OpeningRewardPoints.Delete;
      if not Result then exit;
    end;
    if OpeningRewardPoints.Count > 0 then
      Result := OpeningRewardPoints.Save;
  end;
end;

function TCustomer.GetOpeningRewardPoints: TSalesLinesPoints;
begin
  if self.ID < 1 then
    self.PostDb;
  result := TSalesLinesPoints(getContainerComponent(TSalesLinesPoints,
    'ClientID = ' + IntToStr(Self.ID) + ' and IsOpeningBalance = "T" and Active = "T"'));
end;

function TCustomer.GetRewardPointsExpireDate: TDateTime;
begin
  result:= OpeningRewardPoints.PointExpiresOn;
end;

function TCustomer.GetRewardPointsOpeningBalance: double;
begin
  result:= OpeningRewardPoints.LinePoints;
end;

function TCustomer.GetRewardPointsOpeningDate: TDateTime;
begin
  result:= OpeningRewardPoints.OpeningBalanceAsOn;
end;

procedure TCustomer.SetAddressValid(const Value: boolean);
begin
  SetBooleanField('AddressValid', Value);
end;

procedure TCustomer.SetBillAddressValid(const Value: boolean);
begin
  SetBooleanField('BillAddressValid', Value);
end;

procedure TCustomer.SetRewardPointsExpireDate(const Value: TDateTime);
begin
  if (OpeningRewardPoints.Count = 0) then
    if Value <> 0 then
      OpeningRewardPoints.New
    else
      exit;
  OpeningRewardPoints.PointExpiresOn:= Value;
end;

procedure TCustomer.SetRewardPointsOpeningBalance(const Value: double);
begin
  if (OpeningRewardPoints.Count = 0) then
    if Value <> 0 then
      OpeningRewardPoints.New
    else
      exit;
  OpeningRewardPoints.LinePoints:= Value;
end;

procedure TCustomer.SetRewardPointsOpeningDate(const Value: TDateTime);
begin
  if (OpeningRewardPoints.Count = 0) then
    if Value <> 0 then
      OpeningRewardPoints.New
    else
      exit;
  OpeningRewardPoints.OpeningBalanceAsOn:= Value;
end;

{ TOtherContact }

constructor TOtherContact.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblClients WHERE (OtherContact = "T" and IsJob <> "T")';
  {OtherContact}
  ExportExcludeList.Add('arbalance');
  ExportExcludeList.Add('apbalance');
  ExportExcludeList.Add('altcontact');
  ExportExcludeList.Add('area');
  ExportExcludeList.Add('balance');
  ExportExcludeList.Add('bankaccountbsb');
  ExportExcludeList.Add('bankaccountname');
  ExportExcludeList.Add('bankaccountno');
  ExportExcludeList.Add('bankcode');
  ExportExcludeList.Add('abn');
  ExportExcludeList.Add('bpaybillercode');
  ExportExcludeList.Add('bpayreference');
  ExportExcludeList.Add('cardnumber');
  ExportExcludeList.Add('clientno');
  ExportExcludeList.Add('clienttypename');
  ExportExcludeList.Add('creditbalance');
  ExportExcludeList.Add('creditcardexpirydate');
  ExportExcludeList.Add('creditcardholdername');
  ExportExcludeList.Add('creditcardnotes');
  ExportExcludeList.Add('creditcardnumber');
  ExportExcludeList.Add('CreditCardCVC');
  ExportExcludeList.Add('creditcardtype');
  ExportExcludeList.Add('creditlimit');
  ExportExcludeList.Add('customer');
  ExportExcludeList.Add('customerjobnumber');
  ExportExcludeList.Add('customernextinvoiceno');
  ExportExcludeList.Add('dateinactive');
  ExportExcludeList.Add('dateentered');
  ExportExcludeList.Add('defaultclassname');
  ExportExcludeList.Add('defaultcontactmethod');
  ExportExcludeList.Add('deliverynotes');
  ExportExcludeList.Add('dischargedate');
  ExportExcludeList.Add('ExpiryDate');
  ExportExcludeList.Add('discount');
  ExportExcludeList.Add('documentpath');
  ExportExcludeList.Add('specialdiscount');
//  ExportExcludeList.Add('dontcontact');
  ExportExcludeList.Add('emailxml');
  ExportExcludeList.Add('EmailPOXML');
  ExportExcludeList.Add('finaldestination');
  ExportExcludeList.Add('foreignexchangecode');
  ExportExcludeList.Add('forceponumoninvoice');
  ExportExcludeList.Add('forcepoonbooking');
  ExportExcludeList.Add('forcepoonrepair');
  ExportExcludeList.Add('graceperiod');
  ExportExcludeList.Add('groupdiscountoverridesall');
  ExportExcludeList.Add('hours');
  ExportExcludeList.Add('hourstakenforjob');
  ExportExcludeList.Add('incoplace');
  ExportExcludeList.Add('TeamviewerID');
  ExportExcludeList.Add('ClientCode');
  //ExportExcludeList.Add('SkypeName');
  ExportExcludeList.Add('invoicecomment');
  ExportExcludeList.Add('repairComment');
  ExportExcludeList.Add('invoicecommentpopup');
  ExportExcludeList.Add('RepairCommentPopUp');
  ExportExcludeList.Add('POComment');
  ExportExcludeList.Add('POCommentPopup');
  ExportExcludeList.Add('jobname');
  ExportExcludeList.Add('printjobname');
  ExportExcludeList.Add('LicenseRenewDurationType');
  ExportExcludeList.Add('jobnumber');
  ExportExcludeList.Add('jobregistration');
  ExportExcludeList.Add('jobtitle');
  ExportExcludeList.Add('manufacturename');
  ExportExcludeList.Add('middlename');
  ExportExcludeList.Add('model');
  ExportExcludeList.Add('modelnumber');
  ExportExcludeList.Add('othercontacttype');
  ExportExcludeList.Add('parentclientname');
  ExportExcludeList.Add('parentrelatedclientname');
  ExportExcludeList.Add('paymentmethodname');
  ExportExcludeList.Add('phonesupporttill');
  ExportExcludeList.Add('pickingpriority');
  ExportExcludeList.Add('CallPriority');
  ExportExcludeList.Add('portofdischarge');
  ExportExcludeList.Add('portoflanding');
  ExportExcludeList.Add('reminderdatetime');
  ExportExcludeList.Add('salesorderbalance');
  ExportExcludeList.Add('serialnumber');
  ExportExcludeList.Add('shippingagentcode');
  ExportExcludeList.Add('shippingmethodname');
  ExportExcludeList.Add('shiptime');
  ExportExcludeList.Add('specialinstructions');
  ExportExcludeList.Add('specialproductpriceoverridesall');
  ExportExcludeList.Add('stopcredit');
  ExportExcludeList.Add('tasks');
  ExportExcludeList.Add('termsname');
  ExportExcludeList.Add('usecustomerinvoiceno');
  ExportExcludeList.Add('warrantyfinishdate');
  ExportExcludeList.Add('warrantyperiod');
  ExportExcludeList.Add('defailtclass');
  ExportExcludeList.Add('groupdiscounts');
  ExportExcludeList.Add('parentclient');
  ExportExcludeList.Add('relatedclients');
  ExportExcludeList.Add('required');
  ExportExcludeList.Add('shippingmethod');
  ExportExcludeList.Add('specialproducts');
  ExportExcludeList.Add('taxcodename');
  ExportExcludeList.Add('taxcode');
  ExportExcludeList.Add('terms');
  ExportExcludeList.Add('updatedate');
  ExportExcludeList.Add('defaultclass');
//  ExportExcludeList.Add('clientcustomfieldvalues');
  ExportExcludeList.Add('contactcustomfieldvalues');
  ExportExcludeList.Add('isinternal');
end;

destructor TOtherContact.Destroy;
begin
  inherited;
end;


function TOtherContact.ForeignKeysValid(const node: IXMLNode): Boolean;
var
  fsXMLTag: string;
begin
  Result := false;
  inherited ForeignKeysValid(node);
  fiOtherContactTypeID := 0;
  fsXMLTag := 'OtherContactType';
  if GetXMLNodeStringValue(Node, fsXMLTag) <> '' then 
  begin 
    fiOtherContactTypeID := tcDataUtils.getOtherType(GetXMLNodeStringValue(Node, fsXMLTag));
    if fiOtherContactTypeID = 0 then 
    begin 
      ErrRecordNotfound(fsXMLTag, GetXMLNodeStringValue(Node, fsXMLTag));
      Exit;
    end;
  end;
  fsXMLTag := 'col1';
  if GetXMLNodeStringValue(Node, fsXMLTag) <> '' then 
  begin 
    if not tcDataUtils.ProductColsExists(GetXMLNodeStringValue(Node, fsXMLTag), 1) then 
    begin 
      ErrRecordNotfound(AppEnv.DefaultClass.FirstColumn, GetXMLNodeStringValue(Node, fsXMLTag));
      Exit;
    end;
  end;
end;

procedure TOtherContact.SaveToXMLNode(const Node: IXMLNode);
begin 
  inherited;
  if not SavingXMLTofile then  begin
    AddXMLNode(Node, 'OtherContactType', OtherContactType);
  end  else  begin
    AddXMLNode(Node, 'OtherContactType', tcDataUtils.getOtherType(OtherContactType));
  end;
  ExportsubClasses(Node);
end;

procedure TOtherContact.LoadFromXMLNode(const Node: IXMLNode);
begin
  if not ImportingFromXMLFile then  begin
    SetPropertyFromNode(Node, 'OtherContactType');
  end  else  begin
    OtherContactType := fiOtherContactTypeID;
  end;
end;

class function TOtherContact.GetKeyStringProperty: string;
begin
  result:= 'ClientName';
end;

function TOtherContact.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  self.IsOtherContact:= true;
  result:= inherited DoAfterInsert(Sender);
end;

class function TOtherContact.IDToggle(const ID: Integer;
  Connection: TCustomMyConnection; const AndSQL: string): string;
begin
  result:= inherited IdToggle(ID, Connection,'OtherContact = "T"');
end;

class function TOtherContact.IDToggle(const KeyString: string;
  Connection: TCustomMyConnection; const AndSQL: string): Integer;
begin
  result:= inherited IdToggle(KeyString, Connection,'OtherContact = "T"');
end;

function TOtherContact.Save: boolean;
begin
  result:= ValidateData;
  if result then
    result:= inherited Save;
end;

function TOtherContact.ValidateData: Boolean;
begin
  result:= inherited ValidateData;
  if not result then exit;
end;

class function TOtherContact.XMLNodeName: String;
begin
  REsult:= 'Prospect'
end;

function TOtherContact.GetEmpID: Integer;
begin
  Result := GetIntegerField('EmpID');
end;

function TOtherContact.GetEmpName: String;
begin
  Result := GetStringField('EmpName');
end;

procedure TOtherContact.SetEmpID(const Value: Integer);
begin
  SetIntegerField('EmpID', Value);
end;

procedure TOtherContact.SetEmpName(const Value: String);
begin
  SetStringField('EmpName', Value);
end;

{TCustomerEquipment }
constructor TCustomerEquipment.Create(AOwner: TComponent);
begin 
  inherited Create(AOwner);
  IsTransferingtoAnotehrclient := false;
  fSQL := 'SELECT * FROM tblcustomerequip';
  fIsList:= true;
  ExportExcludeList.Add('clientid');
  ExportExcludeList.Add('uomid');
  ExportExcludeList.Add('keyvalue');
end;

destructor TCustomerEquipment.Destroy;
begin
  inherited;
end;

procedure TCustomerEquipment.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  if not ImportingFromXMLFile then
  begin
    SetPropertyFromNode(node, 'EquipmentId');
    SetPropertyFromNode(node, 'ClientId');
  end
  else
  begin
    Equipmentid := tcDatautils.getEquipmentId(GetXMLNodeStringValue(Node, 'Equipmentname'));
    Clientid    := TClient.IDToggle(GetXMLNodeStringValue(Node, 'CustomerName'), Connection.Connection);
  end;
  SetPropertyFromNode(Node, 'Notes');
  SetPropertyFromNode(Node, 'Description');
  SetPropertyFromNode(Node, 'EquipName');
  SetPropertyFromNode(Node, 'manufacture');
  SetPropertyFromNode(Node, 'Model');
  SetPropertyFromNode(Node, 'Serialno');
  SetPropertyFromNode(Node, 'Registration');
  SetPropertyFromNode(Node, 'WarantyPeriod');
  SetDateTimePropertyFromNode(Node, 'WarantyFinishDate');
  SetDateTimePropertyFromNode(Node, 'WarantyStartDate');
  SetDateTimePropertyFromNode(Node, 'ServiceDueDate');
  SetPropertyFromNode(Node, 'Quantity');
  SetPropertyFromNode(Node, 'UOM');
  SetPropertyFromNode(Node, 'UOMID');
  SetPropertyFromNode(Node, 'UOMMultiplier');
  SetPropertyFromNode(Node, 'UOMQty');
end;

procedure TCustomerEquipment.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  if not SavingXMLTofile then
  begin
    AddXMLNode(node, 'Equipmentid', Equipmentid);
    AddXMLNode(node, 'Clientid', Clientid);
  end
  else
  AddXMLNode(node, 'CustomerName', getClientName(Clientid));
  AddXMLNode(node, 'Notes', Notes);
  AddXMLNode(node, 'Description', Description);
  AddXMLNode(node, 'EquipName', EquipName);
  AddXMLNode(node, 'manufacture',manufacture);
  AddXMLNode(node, 'Model',Model);
  AddXMLNode(node, 'Serialno',Serialno);
  AddXMLNode(node, 'Registration',Registration);
  AddXMLNode(node, 'WarantyPeriod',WarantyPeriod);
  AddXMLNode(node, 'WarantyFinishDate',WarantyFinishDate);
  AddXMLNode(node, 'WarantyStartDate',WarantyStartDate);
  AddXMLNode(node, 'ServiceDueDate',ServiceDueDate);
  AddXMLNode(node, 'Quantity', Quantity);
  AddXMLNode(node, 'UOM' , UOM);
  AddXMLNode(node, 'UOMID' , uomid);
  AddXMLNode(node, 'UOMMultiplier' , UOMMultiplier);
  AddXMLNode(node, 'UOMQty', UOMQty);
end;

function TCustomerEquipment.ValidateXMLData(const node: IXMLNode): Boolean;
var 
  iClientID: Integer;
  iEquipmentID: Integer;
begin 
  Result := inherited ValidateXMLData(node);
  if not Result then 
    Exit;
  if not ImportingFromXMLFile then 
    Exit;
  XMLSearchRecordDesc := 'CustomerName = ' + BusObjUtils.GetXMLClientNAme(Self, node, 'CustomerName') + ' and EquipmentName = ' + GetXMLNodeStringValue(Node, 'Equipmentname');
  Result := false;{Foreign key validation}
  iClientID := CheckClient(Self, node, 'CustomerName');
  if iClientID = 0 then 
  begin 
    ErrRecordNotfound('CustomerName', GetXMLNodeStringValue(Node, 'CustomerName'));
    Exit;
  end;
  iEquipmentID := tcDataUtils.getEquipmentId(GetXMLNodeStringValue(Node, 'Equipmentname'));
  if iEquipmentID = 0 then 
  begin 
    ErrRecordNotfound('Equipment', GetXMLNodeStringValue(Node, 'Equipmentname'));
    Exit;
  end;
  Result := true;
  XMLSearchRecord := 'ClientID = ' + IntToStr(iClientID) + ' and Equipmentid = ' + IntToStr(iEquipmentid);
  LocateXMLRecord;
end;

class function TCustomerEquipment._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TEquipment','EquipmentObj','EquipmentID','ID');
  TBOSchema.AddRefType(result,'TModel','ModelObj','Model','ModelName');
  TBOSchema.AddRefType(result,'TManufacture','ManufactureObj','Manufacture','ManufactureName');
end;

function TCustomerEquipment.ValidateData: Boolean;
var
  qry: TERPQuery;
  Equip: TEquipment;
begin
  Result := false;
  Resultstatus.Clear;
  if Equipmentid = 0 then
  begin
    if not RawMode then begin
      qry:= TERPQuery.Create(nil);
      try
        qry.Connection:= Connection.Connection;
        qry.SQL.Add('select EquipmentID from tblEquipment');
        qry.SQL.Add('where EquipmentName = ' + QuotedStr(self.EquipName));
        if self.Manufacture <> '' then
          qry.SQL.Add('and Manufacture = ' + QuotedStr(self.Manufacture));
        if self.Model <> '' then
          qry.SQL.Add('and Model = ' + QuotedStr(self.Model));
        qry.Open;
        if qry.RecordCount > 1 then begin
          AddResult(false, rssError, 0, 'Could not link to Equipment, there is more than one Equipment record for this combination of Equipment Name, Manufacturer and Model');
          Exit;
        end
        else if qry.RecordCount = 1 then  begin
          EquipmentID := qry.FieldByName('EquipmentID').AsInteger;
          PostDb;
        end
        else begin
          AddResult(false, rssError, 0, 'Equipment ID is 0 or can not find Equipment ID for Equipment Name, Manufacture and Model combination');
          Exit;
        end;
      finally
        qry.Free;
      end;
    end
    else begin
      AddResult(false, rssError, 0, 'EquipmentID should not be blank');
      Exit;
    end;
  end;
  if Clientid = 0 then
  begin
    AddResult(false, rssError, 0, 'Customer should not be blank');
    Exit;
  end;
  if Equipname = '' then
  begin
    AddResult(false, rssError, 0, 'EquipName should not be blank');
    Exit;
  end;
  if Dirty and (SerialNO <> '') then begin
    if not IsTransferingtoAnotehrclient then begin
      {binny : this combination should be unique, but auto ingress got duplicate data which they want to transfer across clients, so this validation is just disabled for them}
      qry:= TERPQuery.Create(nil);
      try
        qry.Connection:= Connection.Connection;
        qry.SQL.Add('select CE.ID, CE.ClientID, CE.EquipmentID, CE.Manufacture, CE.Registration, CE.SerialNo,');
        qry.SQL.Add('C.Company');
        qry.SQL.Add('from tblCustomerEquip CE, tblClients C');
        qry.SQL.Add('where CE.ClientID = C.ClientID');
        qry.SQL.Add('and CE.ID <> ' + IntToStr(ID));
        qry.SQL.Add('and CE.EquipmentID = ' + IntToStr(EquipmentID));
        qry.SQL.Add('and IfNull(CE.Manufacture,"") = ' + QuotedStr(Manufacture));
        qry.SQL.Add('and IfNull(CE.Model,"") = ' + QuotedStr(Model));
        qry.SQL.Add('and IfNull(CE.SerialNo,"") = ' + QuotedStr(Serialno));
        qry.SQL.Add('and CE.Active = "T"');
        qry.Open;
        if not qry.IsEmpty then begin
          AddResult(false, rssError, 0, 'An active record already exists for this Equipment with the same Manufacture, Model and Serial Number combination for "' + qry.FieldByName('Company').AsString + '"');
          Exit;
        end;
      finally
        qry.Free;
      end;
    end;
  end;
  if UOM <> '' then begin
    Equip:= TEquipment.Create(nil);
    try
      Equip.Connection:= Connection;
      Equip.Load(EquipmentID);
      if Equip.ProductID > 0 then begin
        { UOM must be valid for this product }
        qry:= TERPQuery.Create(nil);
        try
          qry.Connection:= Connection.Connection;
          qry.SQL.Add('select * from tblUnitsOfMeasure');
          qry.SQL.Add('where UnitName = ' + QuotedStr(UOM));
          qry.SQL.Add('and (IfNull(PartID,0) = 0 or IfNull(PartID,0) = ' + IntToStr(Equip.ProductID) + ')');
          qry.Open;
          if qry.IsEmpty then begin
            AddResult(false, rssError, 0, 'UOM "' + UOM + '" is invalid for Equipment Product "' + Equip.ProductName + '".');
            Exit;
          end
          else begin
            UOMID:= qry.FieldByName('UnitID').AsInteger;
            { only change multiplier if this is a new record ie preserve multiplier when updating }
            if UOMMultiplier = 0 then
              UOMMultiplier:= qry.FieldByName('Multiplier').AsFloat;
          end;
        finally
          qry.Free;
        end;
      end
      else begin
        { must be UOM with product id = 0 }
        qry:= TERPQuery.Create(nil);
        try
          qry.Connection:= Connection.Connection;
          qry.SQL.Add('select * from tblUnitsOfMeasure');
          qry.SQL.Add('where UnitName = ' + QuotedStr(UOM));
          qry.SQL.Add('and IfNull(PartID,0) = 0');
          qry.Open;
          if qry.IsEmpty then begin
            AddResult(false, rssError, 0, 'UOM "' + UOM + '" is invalid for Equipment "' + self.EquipName + '".');
            Exit;
          end
          else begin
            UOMID:= qry.FieldByName('UnitID').AsInteger;
            { only change multiplier if this is a new record ie preserve multiplier when updating }
            if UOMMultiplier = 0 then
              UOMMultiplier:= qry.FieldByName('Multiplier').AsFloat;
          end;
        finally
          qry.Free;
        end;
      end;
    finally
      Equip.Free;
    end;
  end;

  Result := true;
end;

function TCustomerEquipment.Save: Boolean;
begin
  Result := false;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;

procedure TCustomerEquipment.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin 
  inherited;
end;

function TCustomerEquipment.Picturefieldname: String;
begin
  rEsult := 'StreetMap';
end;

function TCustomerEquipment.Picturetypefieldname: String;
begin
  REsult := 'StreetMaptype';
end;

procedure TCustomerEquipment.DoFieldOnChange(Sender: TField);
var
  UomObj: TUnitOfMeasure;
  EquipObj: TEquipment;
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.Fieldname , 'Equipmentid') then begin
    if not RawMode then begin
      if EquipmentID > 0  then begin
        EquipObj:= TEquipment.Create(nil);
        try
          EquipObj.Connection:= self.Connection;
          EquipObj.Load(EquipmentID);
          if EquipObj.Count > 0 then begin
            self.EquipName:= EquipObj.EquipmentName;
            self.Manufacture:= EquipObj.Manufacture;
            self.Model:= EquipObj.Model;
            self.WarantyPeriod:= EquipObj.DefaultWarrantyDuration;
          end
          else begin
            self.EquipName:= '';
            self.Manufacture:= '';
            self.Model:= '';
          end;
        finally
          EquipObj.Free;
        end;
      end
      else begin
        self.EquipName:= '';
        self.Manufacture:= '';
        self.Model:= '';
      end;
    end;
  end else if Sysutils.SameText(Sender.fieldName , 'UOMQty') then begin
    if not RawMode then begin
      Quantity := uomQty* UOMMultiplier;
    end;
  end else if Sysutils.SameText(Sender.fieldName , 'quantity') then begin
    if not RawMode then begin
      UOMQty := DivZer(quantity, UOMMultiplier);
    end;
  end else if Sysutils.SameText(Sender.fieldName , 'UOMID') then begin
    if UOMID > 0 then begin
      UomObj:= TUnitOfMeasure.Create(nil);
      try
        UomObj.Connection:= self.Connection;
        UomObj.Load(UOMID);
        if UomObj.Count > 0 then begin
          UOM:= UomObj.UOMName;
          UOMMultiplier:= UomObj.Multiplier;
        end
        else begin
          UOM:= '';
          UOMMultiplier:= 1;
        end;
      finally
        UomObj.Free;
      end;
    end
    else begin
      UOM:= '';
      UOMMultiplier:= 1;
    end;
  end else if Sysutils.SameText(Sender.Fieldname , 'WarantyStartDate')  or
              Sysutils.SameText(Sender.Fieldname , 'WarantyPeriod')  then begin
    if (WarantyStartDate <>0) and (WarantyPeriod<> 0) then WarantyFinishDate := IncMonth(WarantyStartDate ,trunc(WarantyPeriod));
  end;
end;

class function TCustomerEquipment.EquipmentNameForId(aId: integer;
  Conn: TCustomMyConnection): string;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Conn) then qry.Connection:= Conn
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select EquipName from tblCustomerEquip');
    qry.SQL.Add('where ID = ' + IntToStr(aId));
    qry.Open;
    result:= qry.FieldByName('EquipName').AsString;
  finally
    qry.Free;
  end;
end;

function TCustomerEquipment.GetSQL: string;
begin 
  Result := inherited GetSQL;
end;

class function TCustomerEquipment.GetIDField: string;
begin 
  Result := 'Id'
end;

function TCustomerEquipment.GetActive: boolean;
begin
  result:= GetBooleanField('Active');
end;

class function TCustomerEquipment.GetBusObjectTablename: string;
begin
  Result := 'tblcustomerequip';
end;

function TCustomerEquipment.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;
function TCustomerEquipment.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin 
    Result := inherited DoAfterInsert(Sender);
    if not result then Exit;
    if Assigned(Self.Owner) then
        if Self.owner is TClient then
            ClientID := Tclient(Self.Owner).Id;
    if not RawMode then begin
      WarantyStartDate := Date;
      Quantity := 1;
    end;
end;

{Property functions}
function TCustomerEquipment.GetEquipmentid: Integer;    begin  Result := GetIntegerField('Equipmentid');end;
function TCustomerEquipment.GetNotes: string;           begin  Result := GetStringField('Notes');       end;
function TCustomerEquipment.GetClientid: Integer;       begin  Result := GetIntegerField('Clientid');   end;
function TCustomerEquipment.GetCustFld1: string;
begin
  result:= GetStringField('CUSTFLD1');
end;

function TCustomerEquipment.GetCustFld10: string;
begin
  result:= GetStringField('CUSTFLD10');
end;

function TCustomerEquipment.GetCustFld2: string;
begin
  result:= GetStringField('CUSTFLD2');
end;

function TCustomerEquipment.GetCustFld3: string;
begin
  result:= GetStringField('CUSTFLD3');
end;

function TCustomerEquipment.GetCustFld4: string;
begin
  result:= GetStringField('CUSTFLD4');
end;

function TCustomerEquipment.GetCustFld5: string;
begin
  result:= GetStringField('CUSTFLD5');
end;

function TCustomerEquipment.GetCustFld6: string;
begin
  result:= GetStringField('CUSTFLD6');
end;

function TCustomerEquipment.GetCustFld7: string;
begin
  result:= GetStringField('CUSTFLD7');
end;

function TCustomerEquipment.GetCustFld8: string;
begin
  result:= GetStringField('CUSTFLD8');
end;

function TCustomerEquipment.GetCustFld9: string;
begin
  result:= GetStringField('CUSTFLD9');
end;

function TCustomerEquipment.GetCustomerName: string;
begin
  result:= TCustomer.IDToggle(ClientID, Connection.Connection);
end;

function TCustomerEquipment.GetDescription: string;     begin  Result := GetStringField('Description'); end;
function TCustomerEquipment.GetEquipname: string;       begin  Result := GetStringField('EquipName');   end;
function TCustomerEquipment.getmanufacture: String;     begin  REsult := GetStringfield('manufacture');end;
function TCustomerEquipment.getModel: String;           begin  REsult := GetStringfield('Model');end;
function TCustomerEquipment.getQuantity: Double;       begin  REsult := GetFloatfield('Quantity'); end;
function TCustomerEquipment.getRegistration: String;    begin  REsult := GetStringfield('Registration'); end;
function TCustomerEquipment.getSerialno: String;        begin  REsult := GetStringfield('Serialno'); end;
function TCustomerEquipment.getWarantyFinishDate: TDatetime; begin REsult := getDateTimeField('WarantyFinishDate'); end;
function TCustomerEquipment.getWarantyPeriod: Double;   begin  REsult := Getfloatfield('WarantyPeriod'); end;
procedure TCustomerEquipment.SetEquipmentid(const Value: Integer);  begin  SetIntegerField('Equipmentid', Value);   end;
procedure TCustomerEquipment.SetNotes(const Value: string);         begin  SetStringField('Notes', Value);          end;
procedure TCustomerEquipment.SetActive(const Value: boolean);begin  SetBooleanField('Active',Value);end;
procedure TCustomerEquipment.SetClientid(const Value: Integer);     begin  SetIntegerField('Clientid', Value);      end;
procedure TCustomerEquipment.SetCustFld1(const Value: string);begin  SetStringField('CUSTFLD1',Value);end;
procedure TCustomerEquipment.SetCustFld10(const Value: string);begin  SetStringField('CUSTFLD10',Value);end;
procedure TCustomerEquipment.SetCustFld2(const Value: string);begin  SetStringField('CUSTFLD2',Value);end;
procedure TCustomerEquipment.SetCustFld3(const Value: string);begin  SetStringField('CUSTFLD3',Value);end;
procedure TCustomerEquipment.SetCustFld4(const Value: string);begin  SetStringField('CUSTFLD4',Value);end;
procedure TCustomerEquipment.SetCustFld5(const Value: string);begin  SetStringField('CUSTFLD5',Value);end;
procedure TCustomerEquipment.SetCustFld6(const Value: string);begin  SetStringField('CUSTFLD6',Value);end;
procedure TCustomerEquipment.SetCustFld7(const Value: string);begin  SetStringField('CUSTFLD7',Value);end;
procedure TCustomerEquipment.SetCustFld8(const Value: string);begin  SetStringField('CUSTFLD8',Value);end;
procedure TCustomerEquipment.SetCustFld9(const Value: string);begin  SetStringField('CUSTFLD9',Value);end;
procedure TCustomerEquipment.SetCustomerName(const Value: string);begin  ClientID:= TCustomer.IDToggle(Value, Connection.Connection);end;
procedure TCustomerEquipment.SetDescription(const Value: string);   begin  SetStringField('Description', Value);    end;
procedure TCustomerEquipment.SetEquipname(const Value: string);
begin
  SetStringField('Equipname', Value);
end;
procedure TCustomerEquipment.Setmanufacture(const Value: String);   begin   SetStringField('manufacture' , value);end;
procedure TCustomerEquipment.SetModel(const Value: String);         begin  SetStringField('Model' , value);end;
procedure TCustomerEquipment.SetRegistration(const Value: String);  begin  SetStringField('Registration' , value);end;
procedure TCustomerEquipment.SetSerialno(const Value: String);      begin  SetStringField('Serialno' , value);end;
procedure TCustomerEquipment.SetWarantyFinishDate(const Value: TDatetime);begin  SetDateTimeField('WarantyFinishDate' , value);end;
procedure TCustomerEquipment.SetWarantyPeriod(const Value: Double); begin  SetFloatField('WarantyPeriod' , value);end;
Procedure TCustomerEquipment.SetQuantity(const Value: Double);     begin  SetFloatField('Quantity' , value);end;
function TCustomerEquipment.getUOM: String;begin  REsult := getStringField('UOM');end;
function TCustomerEquipment.getUOMID: Integer;begin  Result := GetIntegerfield('UOMID');end;
function TCustomerEquipment.GetUOMMultiplier: double;begin  Result := getFloatField('UOMMultiplier');  if result =0 then result := 1;end;
function TCustomerEquipment.GetUOMNameProductKey: string;begin  if UOMID > 0 then result := TUnitOfMeasure.IDToggle(UOMID, Connection.Connection)  else result := '';end;
function TCustomerEquipment.GetUOMQty: Double;begin  Result:= GetFloatfield('UOMQty');end;
procedure TCustomerEquipment.setUOM(const Value: String);begin    SetStringfield('UOM' , Value);end;
procedure TCustomerEquipment.setUOMID(const Value: Integer);begin  SetIntegerField('UOMID' , Value);end;
procedure TCustomerEquipment.setUOMMultiplier(const Value: double);begin  SetFloatfield('UOMMultiplier' , Value);end;
procedure TCustomerEquipment.setUOMQty(const Value: Double);begin  SetFloatfield('UOMQty' , Value);end;
function TCustomerEquipment.getWarantyStartDate: TDatetime;begin  REsult := GetDateTimeField('WarantyStartDate');end;
function TCustomerEquipment.getServiceDueDate: TDatetime;begin  REsult := GetDateTimeField('ServiceDueDate');end;
procedure TCustomerEquipment.setWarantyStartDate(const Value: TDatetime);begin  SetDateTimeField('WarantyStartDate' , Value);end;
procedure TCustomerEquipment.setServiceDueDate(const Value: TDatetime);begin  SetDateTimeField('ServiceDueDate' , Value);end;
procedure TCustomerEquipment.SetUOMNameProductKey(const Value: string);
var
  UomObj: TUnitOfMeasure;
begin
  if Value <> '' then begin
    UomObj:= TUnitOfMeasure.Create(nil);
    try
      UomObj.Connection:= self.Connection;
      UomObj.LoadSelect('UnitProductKeyName = ' + QuotedStr(Value));
      if UomObj.Count > 0 then begin
        UOMID:= UomObj.ID;
        UOM:= UomObj.UOMName;
        UOMMultiplier:= UomObj.Multiplier;
      end
      else begin
        UOMID:= 0;
        UOM:= '';
        UOMMultiplier:= 1;
      end;
    finally
      UomObj.Free;
    end;
  end
  else begin
    UOMID:= 0;
    UOM:= '';
    UOMMultiplier:= 1;
  end;
end;


function TCustomerEquipment.LocateProduct(const ProductID: Integer;
  const ProductName: String; const fsUOM:String; const createnewifnotfound: Boolean;
  const SerialNumber :String = ''):Boolean;
var
  equipID :Integer;
  cusId:Integer;
begin
    REsult := false;
    cusId := getHeaderclientId;
    equipID := CreateEquipment(ProductID, productName, SerialNumber);

    if Dataset.Locate('ClientID;EquipmentID;Serialno' ,
                VarArrayof([cusId ,equipID,SerialNumber ]) , []) then result := true
   else begin
    if   not createnewifnotfound then exit;
      if  equipID <> 0 then begin
          if cusId<> 0 then begin
            New;
            Equipmentid := equipID;
            Clientid    := cusId;
            Serialno    := SerialNumber;
            UOM         := fsUOM;
            PostDB;
            REsult      := True;
          end;
      end;
    end;
end;

function TCustomerEquipment.CreateEquipment(const ProductID: Integer; const ProductName: String; fsSerialNumber :String): Integer;
begin
    result := TEquipment.CreateEquipment(ProductId, ProductName ,fsSerialNumber, self.connection.connection, TopLevelBusObj.BusObjEvent);
end;

function TCustomerEquipment.getHeaderclientId: Integer;
begin
  result := 0;
  if assigned(Self.Owner) then
    if self.Owner is TClient then
      Result := tclient(Self.Owner).ID;
end;
  {TCustomerShippingOptions}

constructor TCustomerShippingOptions.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'CustomerShippingOptions';
  fSQL := 'SELECT * FROM tblcustomershippingoptions';
end;


destructor TCustomerShippingOptions.Destroy;
begin
  inherited;
end;


procedure TCustomerShippingOptions.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'CustomerID');
  SetPropertyFromNode(node,'ShipperType');
  SetPropertyFromNode(node,'PackageProvider');
  SetPropertyFromNode(node,'PayorType');
  SetPropertyFromNode(node,'AccountNumber');
  SetBooleanPropertyFromNode(node,'IsDefault');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TCustomerShippingOptions.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'CustomerID' ,CustomerID);
  AddXMLNode(node,'ShipperType' ,ShipperType);
  AddXMLNode(node,'PackageProvider' ,PackageProvider);
  AddXMLNode(node,'PayorType' ,PayorType);
  AddXMLNode(node,'AccountNumber' ,AccountNumber);
  AddXMLNode(node,'IsDefault' ,IsDefault);
  AddXMLNode(node,'Active' ,Active);
end;


function TCustomerShippingOptions.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if CustomerID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'CustomerID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TCustomerShippingOptions.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TCustomerShippingOptions.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TCustomerShippingOptions.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TCustomerShippingOptions.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TCustomerShippingOptions.GetIDField: string;
begin
  Result := 'CustomerShipingOptionID'
end;


class function TCustomerShippingOptions.GetBusObjectTablename: string;
begin
  Result:= 'tblcustomershippingoptions';
end;


function TCustomerShippingOptions.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TCustomerShippingOptions.GetCustomerID             : Integer   ; begin Result := GetIntegerField('CustomerID');end;
function  TCustomerShippingOptions.GetShipperType            : string    ; begin Result := GetStringField('ShipperType');end;
function  TCustomerShippingOptions.GetPackageProvider        : string    ; begin Result := GetStringField('PackageProvider');end;
function  TCustomerShippingOptions.GetPayorType              : string    ; begin Result := GetStringField('PayorType');end;
function  TCustomerShippingOptions.GetAccountNumber          : string    ; begin Result := GetStringField('AccountNumber');end;
function  TCustomerShippingOptions.GetIsDefault              : Boolean   ; begin Result := GetBooleanField('IsDefault');end;
function  TCustomerShippingOptions.GetActive                 : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TCustomerShippingOptions.SetCustomerID             (const Value: Integer   ); begin SetIntegerField('CustomerID'              , Value);end;
procedure TCustomerShippingOptions.SetShipperType            (const Value: string    ); begin SetStringField('ShipperType'             , Value);end;
procedure TCustomerShippingOptions.SetPackageProvider        (const Value: string    ); begin SetStringField('PackageProvider'         , Value);end;
procedure TCustomerShippingOptions.SetPayorType              (const Value: string    ); begin SetStringField('PayorType'               , Value);end;
procedure TCustomerShippingOptions.SetAccountNumber          (const Value: string    ); begin SetStringField('AccountNumber'           , Value);end;
procedure TCustomerShippingOptions.SetIsDefault              (const Value: Boolean   ); begin SetBooleanField('IsDefault'              , Value);end;
procedure TCustomerShippingOptions.SetActive                 (const Value: Boolean   ); begin SetBooleanField('Active'                  , Value);end;

{ Tsource }
Class function TSource.GetIDField: string;begin  Result := 'MedTypeID'end;
Class function TSource.GetKeyStringField: string;begin  Result := 'MediaType';end;
class function TSource.GetKeyStringProperty: string;begin  result:= 'MediaType';end;
Class function TSource.GetBusObjectTablename: string;begin  Result := 'tblsource'end;

constructor TSource.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'source';
  fSQL := 'SELECT * FROM tblsource';
  ExportExcludeList.Add('accountid');
  ExportExcludeList.Add('documentpath');
end;

destructor TSource.Destroy;
begin
  inherited;
end;


procedure TSource.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'MediaType');
  SetBooleanPropertyFromNode(node,'Active');
  SetBooleanPropertyFromNode(node,'Showingoogle');
  SetDateTimePropertyFromNode(node,'CreationDate');
  SetPropertyFromNode(node,'InactiveDate');
  SetPropertyFromNode(node,'Enquires');
  SetPropertyFromNode(node,'Cost');
  SetPropertyFromNode(node,'AccountID');
end;


class function TSource.MakeSource(aOwner:TComponent ;aSource: String; aConnection :TERPConnection = nil; CreateifnotExists:Boolean =False): Integer;
var
  Source :TSource;
begin
  result := 0;
  if aSource = '' then exit;

  if aConnection = nil then
    Source := TSource.CreateWithNewConn(aOwner)
  else begin
    Source := TSource.Create(AOwner);
    Source.Connection := TMyDacDataConnection.Create(Source);
    Source.Connection.MyDacConnection := aConnection;
  end;
  Source.LoadSelect('MediaType =' + quotedstr( aSource));
  if Source.count =0 then
    if CreateifnotExists then begin
         Source.new;
         Source.MediaType := aSource;
         Source.PostDB;
    end;
  result := Source.ID;
end;

procedure TSource.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'MediaType' ,MediaType);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'Showingoogle' ,Showingoogle);
  AddXMLNode(node,'CreationDate' ,CreationDate);
  AddXMLNode(node,'InactiveDate' ,InactiveDate);
  AddXMLNode(node,'Enquires' ,Enquires);
  AddXMLNode(node,'Cost' ,Cost);
  AddXMLNode(node,'AccountID' ,AccountID);
end;


function TSource.ValidateData: Boolean ;
var
  CleanMediaType: string;
begin
  Result := false;
  Resultstatus.Clear;
  if Dataset.State in [dsEdit, dsInsert] then begin
    try
      PostDb;
    except
      on e: exception do begin
        if (Pos('duplicate entry', SysUtils.LowerCase(e.Message)) > 0) then begin
          AddResult(false, rssError, 0, Db_Duplicate_Entry);
          Exit;
        end
        else
          raise;
      end;
    end;

  end;
  if Trim(MediaType) = '' then
  begin
    AddResult(false, rssError, 0, 'Description can not be blank');
    Exit;
  end;
  CleanMediaType:= self.GetXMLNodeStringValue(self.CleanXMLNode, 'MediaType');
  if (CleanMediaType <> '') and (CleanMediaType <> MediaType) then begin
    AddResult(false, rssError, BOR_Source_DescriptionBlank,
      'Description "' + CleanMediaType + '" can not be changed to "' +MediaType+
      '" for existing record');
    Exit;
  end;
  Result := True;
end;


class function TSource._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TAccount','AccountObj','AccountID','ID');
  TBOSchema.AddRefType(result,'TAccount','AccountObj','AccountName','AccountName');
end;

function TSource.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TSource.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TSource.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if self.Id < 1 then
    InitializeNewObject;
end;


function TSource.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TSource.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property functions}
function  TSource.GetMediaType   : string    ; begin Result := GetStringField('MediaType');end;
function  TSource.GetActive      : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TSource.GetShowingoogle: Boolean   ; begin Result := GetBooleanField('Showingoogle');end;
function  TSource.GetCreationDate: TDateTime ; begin Result := GetDateTimeField('CreationDate');end;
function  TSource.GetInactiveDate: TDateTime ; begin Result := GetDateTimeField('InactiveDate');end;
function  TSource.GetEnquires    : Integer   ; begin Result := GetIntegerField('Enquires');end;
function  TSource.GetCost        : Double    ; begin Result := GetFloatField('Cost');end;
function  TSource.GetAccountID   : Integer   ; begin Result := GetIntegerField('Account');end;
function TSource.GetAccountName: string;
begin
  result:= TAccount.IDToggle(AccountID, Connection.Connection);
end;

procedure TSource.SetMediaType   (const Value: string    ); begin SetStringField('MediaType'    , Value);end;
procedure TSource.SetActive      (const Value: Boolean   ); begin SetBooleanField('Active'       , Value);end;
procedure TSource.SetShowingoogle(const Value: Boolean   ); begin SetBooleanField('Showingoogle' , Value);end;
procedure TSource.SetCreationDate(const Value: TDateTime ); begin SetDateTimeField('CreationDate'       , Value);end;
procedure TSource.SetInactiveDate(const Value: TDateTime ); begin SetDateTimeField('InactiveDate'       , Value);end;
procedure TSource.SetEnquires    (const Value: Integer   ); begin SetIntegerField('Enquires'     , Value);end;
procedure TSource.SetCost        (const Value: Double    ); begin SetFloatField('Cost'         , Value);end;
procedure TSource.SetAccountID   (const Value: Integer   ); begin SetIntegerField('Account'      , Value);end;


procedure TSource.SetAccountName(const Value: string);
begin
  AccountID:= TAccount.IDToggle(Value, Connection.Connection);
end;

procedure TSource.InitializeNewObject;
begin
  inherited;
  Active:= true;
  CreationDate := now;
end;

procedure TSource.New;
begin
  inherited;
end;

{ TJob }

constructor TJob.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblClients WHERE (IsJob = "T")';
  ExportExcludeList.Add('area');
  ExportExcludeList.Add('apbalance');
  ExportExcludeList.Add('bpaybillercode');
  ExportExcludeList.Add('bpayreference');
  ExportExcludeList.Add('companytypename');
  ExportExcludeList.Add('customer');
  ExportExcludeList.Add('bankaccountbsb');
  ExportExcludeList.Add('bankaccountname');
  ExportExcludeList.Add('bankaccountno');
  ExportExcludeList.Add('bankcode');
  ExportExcludeList.Add('abn');
  ExportExcludeList.Add('cardnumber');
  ExportExcludeList.Add('clientno');
  ExportExcludeList.Add('creditcardexpirydate');
  ExportExcludeList.Add('creditcardholdername');
  ExportExcludeList.Add('creditcardnotes');
  ExportExcludeList.Add('creditcardnumber');
  ExportExcludeList.Add('CreditCardCVC');
  ExportExcludeList.Add('creditcardtype');
  ExportExcludeList.Add('customernextinvoiceno');
  ExportExcludeList.Add('defaultcontactmethod');
  ExportExcludeList.Add('deliverynotes');
  ExportExcludeList.Add('discount');
  ExportExcludeList.Add('documentpath');
  ExportExcludeList.Add('specialdiscount');
  ExportExcludeList.Add('dontcontact');
  ExportExcludeList.Add('finaldestination');
  ExportExcludeList.Add('forceponumoninvoice');
  ExportExcludeList.Add('forcepoonbooking');
  ExportExcludeList.Add('forcepoonrepair');
  ExportExcludeList.Add('incoplace');
  ExportExcludeList.Add('TeamviewerID');
  ExportExcludeList.Add('ClientCode');
  //ExportExcludeList.Add('SkypeName');
  ExportExcludeList.Add('invoicecomment');
  ExportExcludeList.Add('repairComment');
  ExportExcludeList.Add('invoicecommentpopup');
  ExportExcludeList.Add('RepairCommentPopUp');
  ExportExcludeList.Add('POComment');
  ExportExcludeList.Add('POCommentPopup');
  ExportExcludeList.Add('othercontacttype');
  ExportExcludeList.Add('parentrelatedclientname');
  ExportExcludeList.Add('pickingpriority');
  ExportExcludeList.Add('CallPriority');
  ExportExcludeList.Add('portofdischarge');
  ExportExcludeList.Add('portoflanding');
  ExportExcludeList.Add('required');
  ExportExcludeList.Add('salesorderbalance');
  ExportExcludeList.Add('shippingagentcode');
  ExportExcludeList.Add('shiptime');
  ExportExcludeList.Add('specialproductpriceoverridesall');
  ExportExcludeList.Add('stopcredit');
  ExportExcludeList.Add('url');
  ExportExcludeList.Add('usecustomerinvoiceno');
  ExportExcludeList.Add('relatedclients');
  ExportExcludeList.Add('specialproducts');
  ExportExcludeList.Add('clientcustomfieldvalues');
  ExportExcludeList.Add('isinternal');
end;

class function TJob.IDToggle(const ID: Integer;
  Connection: TCustomMyConnection; const AndSQL: string): string;
begin
  result:= inherited IdToggle(ID, Connection,'IsJob = "T"');
end;

class function TJob.IDToggle(const KeyString: string;
  Connection: TCustomMyConnection; const AndSQL: string): Integer;
begin
  result:= inherited IdToggle(KeyString, Connection,'IsJob = "T"');
end;


class function TJob.MakeJob(AOwner:TComponent; aCustomerName,aJobName:String ; aJobNumber :Integer;CreateifnotExists:Boolean =False; aSource:String = ''): Integer;
var
  Customer :TCustomer;
begin
  result := 0;

  if ajobname <> '' then Result := TJob.FindJob(AOwner, ajobname, ajobnumber);
  if result <> 0 then exit;

  if aCustomerName = '' then exit;

  Customer:= TCustomer.CreateWithNewConn(AOwner);
  try
    Result := Customer.DoMakeclient(AOwner,aCustomerName,CreateifnotExists, aSource);
    Customer.IsCustomer := True;
    Customer.MedTypeID := TSource.MakeSource(AOwner, aSource);
    Customer.PostDB;
    if ajobname <> '' then begin
      if Customer.Jobs.locate('jobname' , ajobname , []) = false then begin
        Customer.connection.BeginTransaction;
        try
          Customer.Jobs.New;
          Customer.Jobs.firstname       := Customer.ClientName;
          Customer.Jobs.ParentclientId  := Customer.Id;
          Customer.Jobs.jobname         := ajobname;
          Customer.Jobs.jobnumber       := aJobNumber;
          Customer.Jobs.Printjobname    := ajobname;
          Customer.Jobs.ClientName      := Customer.ClientName +'^' +aJobName;
          Customer.Jobs.Printname       := Customer.Jobs.ClientName;
          if not Customer.Jobs.Save then begin
            Customer.Connection.RollbackTransaction;
            Exit;
          end;
          Customer.Connection.CommitTransaction;
          Result := Customer.Jobs.ID;
        Except
          on E:Exception do begin
            Customer.Resultstatus.addItem(False ,rssWarning, 0 ,'Creation of customer Failed.' + NL+ E.message);
            Customer.Connection.RollbackTransaction;
            Exit;
          end;
        end;
      end;
    end;
  finally
    Freeandnil(Customer);
  end;
end;

function TJob.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  IsJob:= true;
  IsCustomer:= true;
  result:= inherited DoAfterInsert(Sender);
end;

procedure TJob.PopulateDataFromParentCust;
var
  cust: TCustomer;
begin
  if self.ParentClientId < 1 then exit;
  cust:= TCustomer.Create(nil);
  try
    cust.Connection:= self.Connection;
    cust.Load(self.ParentClientId);
    self.Title:= cust.Title;
    self.FirstName:= cust.FirstName;
    self.LastName:= cust.LastName;
    self.Phone:= cust.Phone;
    self.FaxNumber:= cust.Faxnumber;
    self.AltPhone:= cust.AltPhone;
    self.MedTypeID:= cust.MedTypeID;
    self.RepID:= cust.RepID;
    self.DefaultAPAccountID:= cust.DefaultAPAccountID;
    self.DefaultARAccountID:= cust.DefaultARAccountID;
    self.JobNumber:= StrToInt(CommonDbLib.GetSequenceNumber(SEQ_JobNumber));
    if AppEnv.CompanyPrefs.StartJobNameWithJobNumber then begin
      self.JobName:= IntToStr(self.JobNumber);
    end;
    self.CreditLimit:= cust.CreditLimit;
    self.GracePeriod:= cust.GracePeriod;
    self.TermsId:= cust.TermsId;
    Self.TermsName := Cust.TermsName;

  finally
    cust.Free;
  end;
end;

procedure TJob.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  if Sysutils.SameText(Sender.fieldName, 'ParentClientID') then begin
    if not RawMode then begin
      if Sender.NewValue <> Sender.OldValue then begin
        PopulateDataFromParentCust;
        ClientName := self.ParentClientName + '^' + JobName;
        PrintName := ClientName;
      end;
    end;
  end
  else if Sysutils.SameText(Sender.fieldName, 'JobName') then begin
    if not RawMode then begin
      if Sender.NewValue <> Sender.OldValue then begin
        ClientName := self.ParentClientName + '^' + Sender.AsString;
        PrintName := ClientName;
        PrintJobName := JobName;
      end;
    end;
  end
end;

class function TJob.FindJob(AOwner:TComponent; ajobname: String; ajobnumber: Integer): Integer;
var
  Job :TJob;
  fs:String;
begin
  Result := 0;
  if aJobName = '' then exit;

  fs := 'jobname =' + quotedstr(aJobName);
  if ajobnumber <> 0 then fs := fs +' and jobnumber =' + inttostr(ajobnumber);
  Job:= TJob.CreateWithNewConn(AOwner);
  try
    job.loadselect(fs);
    result := job.ID;
  finally
    Freeandnil(job);
  end;

end;

class function TJob.GetKeyStringProperty: string;
begin
  result:= 'ClientName';
end;

function TJob.ValidateData: Boolean;
begin
  result:= inherited ValidateData;
  if not result then exit;
  result:= false;
  if (not Active) and (self.Balance <> 0) then begin
    AddResult(false,rssWarning,0,'Can not make this Job inactive as there is an outstanding balance');
    exit;
  end;
  if self.ParentClientId = 0 then begin
    AddResult(false,rssWarning,0,'A Job must have a Parent Butomer');
    exit;
  end;
  if JobName = '' then begin
    AddResult(false,rssWarning,0,'A Job must have a Job Name');
    exit;
  end;
  result:= true;
end;

class function TJob._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TCustomer','ParentClient','ParentClientID','ID');
  TBOSchema.AddRefType(result,'TCustomer','ParentClient','ParentClientName','ClientName');
end;

function TJob.Save: boolean;
begin
  result:= ValidateData;
  if result then
    result:= inherited Save;
end;

  {TClients_eParcel}

constructor TClients_eParcel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'Clients_eParcel';
  fSQL := 'SELECT * FROM tblclients_eparcel';
end;


destructor TClients_eParcel.Destroy;
begin
  inherited;
end;


procedure TClients_eParcel.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ClientID');
  SetBooleanPropertyFromNode(node,'consigneePhoneonLabel');
  SetBooleanPropertyFromNode(node,'LeaveAtAddress');
  SetBooleanPropertyFromNode(node,'SignatureReqd');
  SetPropertyFromNode(node,'ExtraDeliveryInstructions');
  SetPropertyFromNode(node,'ChargeBackAcntID');
  SetPropertyFromNode(node,'ChargeBackAcnt');
  SetPropertyFromNode(node,'eParcelreference1');
  SetPropertyFromNode(node,'eParcelreference2');
  SetBooleanPropertyFromNode(node,'PrinteParcelreference1');
  SetBooleanPropertyFromNode(node,'PrinteParcelreference2');
  SetPropertyFromNode(node,'Return_Company');
  SetPropertyFromNode(node,'Return_Name');
  SetPropertyFromNode(node,'Return_Street1');
  SetPropertyFromNode(node,'Return_Street2');
  SetPropertyFromNode(node,'Return_Street3');
  SetPropertyFromNode(node,'Return_Suburb');
  SetPropertyFromNode(node,'Return_State');
  SetPropertyFromNode(node,'Return_Country');
  SetPropertyFromNode(node,'Return_Postcode');
  SetPropertyFromNode(node,'ReDir_Company');
  SetPropertyFromNode(node,'ReDir_Name');
  SetPropertyFromNode(node,'ReDir_Street1');
  SetPropertyFromNode(node,'ReDir_Street2');
  SetPropertyFromNode(node,'ReDir_Street3');
  SetPropertyFromNode(node,'ReDir_Suburb');
  SetPropertyFromNode(node,'ReDir_State');
  SetPropertyFromNode(node,'ReDir_Country');
  SetPropertyFromNode(node,'ReDir_Postcode');
  SetPropertyFromNode(node,'EmailNotification');
end;


procedure TClients_eParcel.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ClientID' ,ClientID);
  AddXMLNode(node,'consigneePhoneonLabel' ,consigneePhoneonLabel);
  AddXMLNode(node,'LeaveAtAddress' ,LeaveAtAddress);
  AddXMLNode(node,'SignatureReqd' ,SignatureReqd);
  AddXMLNode(node,'ExtraDeliveryInstructions' ,ExtraDeliveryInstructions);
  AddXMLNode(node,'ChargeBackAcntID' ,ChargeBackAcntID);
  AddXMLNode(node,'ChargeBackAcnt' ,ChargeBackAcnt);
  AddXMLNode(node,'eParcelreference1' ,eParcelreference1);
  AddXMLNode(node,'eParcelreference2' ,eParcelreference2);
  AddXMLNode(node,'PrinteParcelreference1' ,PrinteParcelreference1);
  AddXMLNode(node,'PrinteParcelreference2' ,PrinteParcelreference2);
  AddXMLNode(node,'Return_Company' ,Return_Company);
  AddXMLNode(node,'Return_Name' ,Return_Name);
  AddXMLNode(node,'Return_Street1' ,Return_Street1);
  AddXMLNode(node,'Return_Street2' ,Return_Street2);
  AddXMLNode(node,'Return_Street3' ,Return_Street3);
  AddXMLNode(node,'Return_Suburb' ,Return_Suburb);
  AddXMLNode(node,'Return_State' ,Return_State);
  AddXMLNode(node,'Return_Country' ,Return_Country);
  AddXMLNode(node,'Return_Postcode' ,Return_Postcode);
  AddXMLNode(node,'ReDir_Company' ,ReDir_Company);
  AddXMLNode(node,'ReDir_Name' ,ReDir_Name);
  AddXMLNode(node,'ReDir_Street1' ,ReDir_Street1);
  AddXMLNode(node,'ReDir_Street2' ,ReDir_Street2);
  AddXMLNode(node,'ReDir_Street3' ,ReDir_Street3);
  AddXMLNode(node,'ReDir_Suburb' ,ReDir_Suburb);
  AddXMLNode(node,'ReDir_State' ,ReDir_State);
  AddXMLNode(node,'ReDir_Country' ,ReDir_Country);
  AddXMLNode(node,'ReDir_Postcode' ,ReDir_Postcode);
  AddXMLNode(node,'EmailNotification' ,EmailNotification);
end;


function TClients_eParcel.ValidateData: Boolean ;
begin
  Result := False;
  Resultstatus.Clear;
  if ClientID = 0 then begin
    Resultstatus.AddItem(False , rssError , 0,  'ClientID should not be 0' , False );
    Exit;
  end;
  Result := True;
end;


function TClients_eParcel.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TClients_eParcel.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TClients_eParcel.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TClients_eParcel.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TClients_eParcel.GetIDField: string;
begin
  Result := 'ID'
end;


class function TClients_eParcel.GetBusObjectTablename: string;
begin
  Result:= 'tblclients_eparcel';
end;


function TClients_eParcel.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function TClients_eParcel.getClients_eParcel: TClients_eParcel;
begin
  Result := TClients_eParcel(getContainerComponent(TClients_eParcel ,'ClientID = ' + IntToStr(ID) ));
end;
function  TClients_eParcel.GetClientID              : Integer   ; begin Result := GetIntegerField('ClientID');end;
function  Tclients_eparcel.GetconsigneePhoneonLabel    : Boolean   ; begin Result := GetBooleanField('consigneePhoneonLabel');end;
function  Tclients_eparcel.GetLeaveAtAddress           : Boolean   ; begin Result := GetBooleanField('LeaveAtAddress');end;
function  Tclients_eparcel.GetSignatureReqd            : Boolean   ; begin Result := GetBooleanField('SignatureReqd');end;
function  Tclients_eparcel.GetExtraDeliveryInstructions: string    ; begin Result := GetStringField('ExtraDeliveryInstructions');end;
function  Tclients_eparcel.GetChargeBackAcntID         : Integer   ; begin Result := GetIntegerField('ChargeBackAcntID');end;
function  Tclients_eparcel.GetChargeBackAcnt           : string    ; begin Result := GetStringField('ChargeBackAcnt');end;
function  TClients_eParcel.GeteParcelreference1     : string    ; begin Result := GetStringField('eParcelreference1');end;
function  TClients_eParcel.GeteParcelreference2     : string    ; begin Result := GetStringField('eParcelreference2');end;
function  TClients_eParcel.GetPrinteParcelreference1: Boolean   ; begin Result := GetBooleanField('PrinteParcelreference1');end;
function  TClients_eParcel.GetPrinteParcelreference2: Boolean   ; begin Result := GetBooleanField('PrinteParcelreference2');end;
function  TClients_eParcel.GetReturn_Company        : string    ; begin Result := GetStringField('Return_Company');end;
function  TClients_eParcel.GetReturn_Name           : string    ; begin Result := GetStringField('Return_Name');end;
function  TClients_eParcel.GetReturn_Street1        : string    ; begin Result := GetStringField('Return_Street1');end;
function  TClients_eParcel.GetReturn_Street2        : string    ; begin Result := GetStringField('Return_Street2');end;
function  TClients_eParcel.GetReturn_Street3        : string    ; begin Result := GetStringField('Return_Street3');end;
function  TClients_eParcel.GetReturn_Suburb         : string    ; begin Result := GetStringField('Return_Suburb');end;
function  TClients_eParcel.GetReturn_State          : string    ; begin Result := GetStringField('Return_State');end;
function  TClients_eParcel.GetReturn_Country        : string    ; begin Result := GetStringField('Return_Country');end;
function  TClients_eParcel.GetReturn_Postcode       : string    ; begin Result := GetStringField('Return_Postcode');end;
function  TClients_eParcel.GetReDir_Company         : string    ; begin Result := GetStringField('ReDir_Company');end;
function  TClients_eParcel.GetReDir_Name            : string    ; begin Result := GetStringField('ReDir_Name');end;
function  TClients_eParcel.GetReDir_Street1         : string    ; begin Result := GetStringField('ReDir_Street1');end;
function  TClients_eParcel.GetReDir_Street2         : string    ; begin Result := GetStringField('ReDir_Street2');end;
function  TClients_eParcel.GetReDir_Street3         : string    ; begin Result := GetStringField('ReDir_Street3');end;
function  TClients_eParcel.GetReDir_Suburb          : string    ; begin Result := GetStringField('ReDir_Suburb');end;
function  TClients_eParcel.GetReDir_State           : string    ; begin Result := GetStringField('ReDir_State');end;
function  TClients_eParcel.GetReDir_Country         : string    ; begin Result := GetStringField('ReDir_Country');end;
function  TClients_eParcel.GetReDir_Postcode        : string    ; begin Result := GetStringField('ReDir_Postcode');end;
function  TClients_eParcel.GetEmailNotification     : string    ; begin Result := GetStringField('EmailNotification');end;
procedure TClients_eParcel.SetClientID              (const Value: Integer   ); begin SetIntegerField('ClientID'               , Value);end;
procedure Tclients_eparcel.SetconsigneePhoneonLabel    (const Value: Boolean   ); begin SetBooleanField('consigneePhoneonLabel'     , Value);end;
procedure Tclients_eparcel.SetLeaveAtAddress           (const Value: Boolean   ); begin SetBooleanField('LeaveAtAddress'            , Value);end;
procedure Tclients_eparcel.SetSignatureReqd            (const Value: Boolean   ); begin SetBooleanField('SignatureReqd'             , Value);end;
procedure Tclients_eparcel.SetExtraDeliveryInstructions(const Value: string    ); begin SetStringField('ExtraDeliveryInstructions' , Value);end;
procedure Tclients_eparcel.SetChargeBackAcntID         (const Value: Integer   ); begin SetIntegerField('ChargeBackAcntID'          , Value);end;
procedure Tclients_eparcel.SetChargeBackAcnt           (const Value: string    ); begin SetStringField('ChargeBackAcnt'            , Value);end;
procedure TClients_eParcel.SeteParcelreference1     (const Value: string    ); begin SetStringField('eParcelreference1'      , Value);end;
procedure TClients_eParcel.SeteParcelreference2     (const Value: string    ); begin SetStringField('eParcelreference2'      , Value);end;
procedure TClients_eParcel.SetPrinteParcelreference1(const Value: Boolean   ); begin SetBooleanField('PrinteParcelreference1' , Value);end;
procedure TClients_eParcel.SetPrinteParcelreference2(const Value: Boolean   ); begin SetBooleanField('PrinteParcelreference2' , Value);end;
procedure TClients_eParcel.SetReturn_Company        (const Value: string    ); begin SetStringField('Return_Company'         , Value);end;
procedure TClients_eParcel.SetReturn_Name           (const Value: string    ); begin SetStringField('Return_Name'            , Value);end;
procedure TClients_eParcel.SetReturn_Street1        (const Value: string    ); begin SetStringField('Return_Street1'         , Value);end;
procedure TClients_eParcel.SetReturn_Street2        (const Value: string    ); begin SetStringField('Return_Street2'         , Value);end;
procedure TClients_eParcel.SetReturn_Street3        (const Value: string    ); begin SetStringField('Return_Street3'         , Value);end;
procedure TClients_eParcel.SetReturn_Suburb         (const Value: string    ); begin SetStringField('Return_Suburb'          , Value);end;
procedure TClients_eParcel.SetReturn_State          (const Value: string    ); begin SetStringField('Return_State'           , Value);end;
procedure TClients_eParcel.SetReturn_Country        (const Value: string    ); begin SetStringField('Return_Country'         , Value);end;
procedure TClients_eParcel.SetReturn_Postcode       (const Value: string    ); begin SetStringField('Return_Postcode'        , Value);end;
procedure TClients_eParcel.SetReDir_Company         (const Value: string    ); begin SetStringField('ReDir_Company'          , Value);end;
procedure TClients_eParcel.SetReDir_Name            (const Value: string    ); begin SetStringField('ReDir_Name'             , Value);end;
procedure TClients_eParcel.SetReDir_Street1         (const Value: string    ); begin SetStringField('ReDir_Street1'          , Value);end;
procedure TClients_eParcel.SetReDir_Street2         (const Value: string    ); begin SetStringField('ReDir_Street2'          , Value);end;
procedure TClients_eParcel.SetReDir_Street3         (const Value: string    ); begin SetStringField('ReDir_Street3'          , Value);end;
procedure TClients_eParcel.SetReDir_Suburb          (const Value: string    ); begin SetStringField('ReDir_Suburb'           , Value);end;
procedure TClients_eParcel.SetReDir_State           (const Value: string    ); begin SetStringField('ReDir_State'            , Value);end;
procedure TClients_eParcel.SetReDir_Country         (const Value: string    ); begin SetStringField('ReDir_Country'          , Value);end;
procedure TClients_eParcel.SetReDir_Postcode        (const Value: string    ); begin SetStringField('ReDir_Postcode'         , Value);end;
procedure TClients_eParcel.SetEmailNotification     (const Value: string    ); begin SetStringField('EmailNotification'      , Value);end;


{ TCustomerExport }

constructor TCustomerExport.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblClients WHERE (Customer = "T" and ISJob ="F")';
end;

initialization
  RegisterClass(TClients_eParcel);
  RegisterClassOnce(TSource);
  RegisterClassOnce(TCustomerEquipment);
  RegisterClass(TCustomerShippingOptions);
  RegisterClassOnce(TCustomer);
  RegisterClassOnce(TJob);
  RegisterClassOnce(TSupplier);
  RegisterClassOnce(TOtherContact);
  RegisterClassOnce(TProspect);
  RegisterClassOnce(TCustomerExport);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Customer Equipment','TCustomerEquipment','TClientEquipmentlist');
  BusObjectListObj.TBusObjInfoList.Inst.Add('Customer','TCustomerExport','TCustomerExpressListWithNoJobsGUI');
  BusObjectListObj.TBusObjInfoList.Inst.Add('Job','TJob','TJobListGUI');
  BusObjectListObj.TBusObjInfoList.Inst.Add('Supplier','TSupplier','TSupplierListGUI');
  BusObjectListObj.TBusObjInfoList.Inst.Add('Prospect','TProspect','TfrmOthersList');
  BusObjectListObj.TBusObjInfoList.Inst.Add('Source','TSource','TSourceListGUI');
end.




