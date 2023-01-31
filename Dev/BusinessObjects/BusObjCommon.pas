unit BusObjCommon;
{ Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 14/07/06  1.00.00 BJ  Initial version.
 10/08/06 1.00.01  BJ  SpecialPrice object updating the productId when gets the product name
                       XML fiel contains the names instead of IDs, so will have the productname when exporting from XML
}
interface

uses  BusObjBase, db,  Classes, BusobjProductProperties, XMLDoc, XMLIntf, MyAccess , BusObjRepServices;

type

(*   TSeqNumbers = class(TMSBusObj)
   private
      Function GetSeqname          :String    ;
      Function GetSeqvalue         :Integer   ;
      Function GetSeqmin           :Integer   ;
      Function GetSeqmax           :Integer   ;
      Function GetSeqstep          :Integer   ;
      Function GetSeqrecycle       :Boolean   ;
      Function GetPadtodigits      :Integer   ;
      Procedure SetSeqname          (Const Value :String    );
      Procedure SetSeqvalue         (Const Value :Integer   );
      Procedure SetSeqmin           (Const Value :Integer   );
      Procedure SetSeqmax           (Const Value :Integer   );
      Procedure SetSeqstep          (Const Value :Integer   );
      Procedure SetSeqrecycle       (Const Value :Boolean   );
      Procedure SetPadtodigits      (Const Value :Integer   );
   Protected
      procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
      procedure DoFieldOnChange(Sender: TField);                           Override;
      Function  GetSQL : STring;                                           Override;
      Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
   Public
      class function GetIDField: string; override;
      class function GetBusObjectTablename: string; Override;
      Constructor  Create(AOwner: TComponent);                             override;
      Destructor   Destroy;                                                override;
      Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
      Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
      Function     ValidateData :Boolean ;                                 Override;
      Function     Save :Boolean ;                                         Override;
      function     GetSequenceNumber(const fsSeqName: string;
                                     CreateSeqIfNotFound: boolean = false): string;


      Property Seqname           :String       Read getSeqname        Write SetSeqname    ;
      Property Seqvalue          :Integer      Read getSeqvalue       Write SetSeqvalue   ;
      Property Seqmin            :Integer      Read getSeqmin         Write SetSeqmin     ;
      Property Seqmax            :Integer      Read getSeqmax         Write SetSeqmax     ;
      Property Seqstep           :Integer      Read getSeqstep        Write SetSeqstep    ;
      Property Seqrecycle        :Boolean      Read getSeqrecycle     Write SetSeqrecycle ;
      Property Padtodigits       :Integer      Read getPadtodigits    Write SetPadtodigits;
   End;*)

  TServices = class(TMSBusObj)
	private
		Function Getservicedesc		:String;
		Function Getactive		:Boolean;
		Function Getissoftware		:String;
		Function Getishardware		:String;
		Function Getcreationdate		:TDatetime;
		Function Getupdatedate		:TDatetime;
		Function Getstandardrate		:Double;
		Function Getranking		:Integer;
    Function GetProductId		:Integer;
		Function Getisfixedrate		:String;
		Procedure Setservicedesc		(Const Value :String);
		Procedure Setactive		(Const Value :Boolean);
		Procedure Setissoftware		(Const Value :String);
		Procedure Setishardware		(Const Value :String);
		Procedure Setcreationdate		(Const Value :TDatetime);
		Procedure Setupdatedate		(Const Value :TDatetime);
		Procedure Setstandardrate		(Const Value :Double);
		Procedure Setranking		(Const Value :Integer);
    Procedure SetProductId		(Const Value :Integer);
		Procedure Setisfixedrate		(Const Value :String);
    procedure DeleteServiceSubObjects;
    function getRepServices: TRepServices;
    procedure DeleteServiceSubObjectsCallback(const Sender: TBusObj;
      var Abort: Boolean);
	Protected
		procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType);   Override;
		Function  GetSQL : STring;                                           Override;
		Function  DoAfterPost(Sender :TDatasetBusObj ):Boolean;              Override;
	Public
		procedure DoFieldOnChange(Sender: TField);                           Override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    class function GetKeyStringField: string; override;
    class function GetKeyStringProperty: string; override;
		Constructor  Create(AOwner: TComponent);                             override;
		Destructor   Destroy;                                                override;
		Procedure    LoadFromXMLNode(Const node: IXMLNode);                  override;
		Procedure    SaveToXMLNode(Const node: IXMLNode);                    override;
		Function     ValidateData :Boolean ;                                 Override;
		Function     Save :Boolean ;                                         Override;
    class function ServiceDescUnique(const aServiceDesc: string; const IgnoreId: integer;
      Conn: TCustomMyConnection = nil): boolean;
    class function _Schema: string; override;
  published
		Property ServiceDesc		 :String	REad getservicedesc	 Write Setservicedesc;
		Property Active		 :Boolean	REad getactive	 Write Setactive;
		Property IsSoftware		 :String	REad getissoftware	 Write Setissoftware;
		Property IsHardware		 :String	REad getishardware	 Write Setishardware;
		Property CreationDate		 :TDatetime	REad getcreationdate	 Write Setcreationdate;
		Property UpdateDate		 :TDatetime	REad getupdatedate	 Write Setupdatedate;
		Property StandardRate		 :Double	REad getstandardrate	 Write Setstandardrate;
		Property Ranking		 :Integer	REad getranking	 Write Setranking;
    Property ProductId		 :Integer	REad getProductId	 Write SetProductId;
		Property IsFixedRate		 :String	REad getisfixedrate	 Write Setisfixedrate;
    Property RepServices :TRepServices read getRepServices;
	End;


  TShippingMethod = class(TMSBusObj)
  Private
    Function  GetActive         :Boolean;
    Function  GetShippingMethod :String;
    Procedure SetActive(const Value :Boolean);
    Procedure SetShippingMethod(Const Value :String);
  Protected
    function  GetSQL:String ;                                   Override;
  Public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    class function GetKeyStringField: string; override;
    function    ValidateData :Boolean ;         Override;
    function    Save :Boolean ;                 Override;
    procedure   SaveToXMLNode(const Node: IXMLNode);  Override;
    procedure   LoadFromXMLNode(const Node: IXMLNode);Override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
  published
    Property  ShippingMethod: string    read getShippingMethod  Write SetShippingMethod;
    Property  Active        : Boolean   Read getActive          Write SetActive;
  End;

  TTerms = class(TMSBusObj)
  private
    Function GetActive: boolean;
    procedure SetActive(const Value: boolean);
    Function GetDays: Integer;
    Function GetDescription: String;
    Function GetEarlyDiscountPercent: double;
    Function GetIsEOM: boolean;
    Function GetIsEOMPlus: boolean;
    Function GetIsDays: boolean;
    Function GetISProgressPayment: boolean;
    Function GetRequired: boolean;
    Function GetPublishOnVS1: boolean;
    Function GetisPurchasedefault: boolean;
    Function GetisSalesdefault: boolean;
    Function GetProgressPaymentfirstPayonSaleDate: boolean;
    Function GetTermsName: String;
    Function GetProgressPaymentDuration: Integer;
    Function GetProgressPaymentDaysAfterfirstPay: Integer;
    Function GetProgressPaymentInstallments: Integer;
    function getProgressPaymenttype :String;
    procedure SetDays(const Value: Integer);
    procedure SetDescription(const Value: String);
    procedure SetEarlyDiscountPercent(const Value: double);
    procedure SetIsEOM(const Value: boolean);
    procedure SetIsEOMPlus(const Value: boolean);
    procedure SetIsDays(const Value: boolean);
    procedure SetISProgressPayment(const Value: boolean);
    procedure SetRequired(const Value: boolean);
    procedure SetPublishOnVS1(const Value: boolean);
    procedure SetisPurchasedefault(const Value: boolean);
    procedure SetisSalesdefault(const Value: boolean);
    procedure SetProgressPaymentfirstPayonSaleDate(const Value: boolean);
    procedure SetTermsName(const Value: String);
    procedure SetProgressPaymentDuration(const Value: Integer);
    procedure SetProgressPaymentDaysAfterfirstPay(const Value: Integer);
    procedure SetProgressPaymentInstallments(const Value: Integer);
    Procedure SetProgressPaymenttype(const Value :String);
    function GetEarlyPaymentDays: integer;
    procedure SetEarlyPaymentDays(const Value: integer);
  protected
    Function  ValidateXMLData(const Node :IXMLNode) :Boolean; Override;
    Function  ExportsubClasses(const Node: IXMLNode):Boolean; Override;
    Function  ImportsubClasses(const node: IXMLNode):Boolean; Override;
    Function  ForeignKeysValid(const Node:IXMLNode):Boolean; Override;
    Function DoAfterInsert(Sender :TDatasetBusObj): Boolean; override;
  public
    procedure DoFieldOnChange(Sender: TField); override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    class function GetKeyStringField: string; override;
    constructor Create(AOwner: TComponent); Override;
    destructor Destroy; Override;
    function    ValidateData :Boolean ;         Override;
    function    Save :Boolean ;                 Override;
    procedure   SaveToXMLNode(const Node: IXMLNode);  Override;
    procedure   LoadFromXMLNode(const Node: IXMLNode);Override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    Function Duedate(const BaseDate:TDateTime; TransObj:Tbusobj):TDateTime;
    Function InstallmentDate(const BaseDate:TDateTime; InstallmentNo:Integer):TDateTime;
    Class Function DueonReceipt :String;
  published
    property TermsName: String Read GetTermsName Write SetTermsName;
    property Days: Integer Read GetDays Write SetDays;

    property IsEOM: boolean Read GetIsEOM Write SetIsEOM;
    property IsEOMPlus: boolean Read GetIsEOMPlus Write SetIsEOMPlus;
    property IsDays: boolean Read GetIsDays Write SetIsDays;
    property ISProgressPayment: boolean Read GetISProgressPayment Write SetISProgressPayment;

    property Description                      : String  Read GetDescription                       Write SetDescription;
    property Required                         : boolean Read GetRequired                          Write SetRequired;
    property PublishOnVS1                     : boolean Read GetPublishOnVS1                      Write SetPublishOnVS1;
    property isPurchasedefault                : boolean Read GetisPurchasedefault                 Write SetisPurchasedefault;
    property isSalesdefault                   : boolean Read GetisSalesdefault                    Write SetisSalesdefault;
    property ProgressPaymentFirstPayonSaleDate: boolean Read GetProgressPaymentfirstPayonSaleDate Write SetProgressPaymentfirstPayonSaleDate;
    property EarlyDiscountPercent             : double  Read GetEarlyDiscountPercent              Write SetEarlyDiscountPercent;
    property EarlyPaymentDays: integer read GetEarlyPaymentDays write SetEarlyPaymentDays;
    property Active                           : boolean Read GetActive                            Write SetActive;
    property ProgressPaymentDuration          : Integer Read GetProgressPaymentDuration           Write SetProgressPaymentDuration;
    property ProgressPaymentDaysAfterFirstPay : Integer Read GetProgressPaymentDaysAfterfirstPay  Write SetProgressPaymentDaysAfterfirstPay;
    property ProgressPaymentInstallments      : Integer Read GetProgressPaymentInstallments       write setProgressPaymentInstallments;
    Property ProgressPaymentType              : String  read getProgressPaymenttype               write SetProgressPaymenttype;

  end;

  TClientType = class(TMSBusObj)
  private
    fTerms                  : TTerms;
    Function  GetActive: boolean;
    Function  GetTypeDescription: String;
    Function  GetTypeName: String;
    Function  GetCreditLimit: double;
    Function  GetDefaultPostAccount: String;
    Function  GetDefaultPostAccountId: Integer;
    Function  GetGracePeriod: Integer;
    Function  GetTermsId: Integer;
    procedure SetActive(const Value: boolean);
    procedure SetTypeDescription(const Value: String);
    procedure SetTypeName(const Value: String);
    procedure SetCreditLimit(const Value: double);
    procedure SetDefaultPostAccount(const Value: String);
    procedure SetDefaultPostAccountId(const Value: Integer);
    procedure SetGracePeriod(const Value: Integer);
    procedure SetTermsId(const Value: Integer);
    Function  GetTerms: TTerms;
    function GetTermsName: string;
    procedure SetTermsName(const Value: string);
  protected
    procedure   OnDataIdChange(Const ChangeType: TBusObjDataChangeType); Override;
    Function    GetSQL                          :String ;          Override;
  public
    procedure DoFieldOnChange(Sender: TField); override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    class function GetKeyStringField: string; Override;
    constructor Create(AOwner: TComponent);     Override;
    destructor  Destroy;                        Override;
    Function    ValidateData :Boolean ;         Override;
    Function    Save :Boolean ;                 Override;
    procedure   SaveToXMLNode(const Node: IXMLNode);  Override;
    procedure   LoadFromXMLNode(const Node: IXMLNode);Override;
    property    Terms               : TTerms    Read GetTerms;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
  published
    property    TypeName            : String    Read GetTypeName             Write SetTypeName;
    property    TypeDescription     : String    Read GetTypeDescription      Write SetTypeDescription;
    property    TermsId             : Integer   Read GetTermsId              Write SetTermsId;
    property    TermsName: string read GetTermsName write SetTermsName;
    property    CreditLimit         : double    Read GetCreditLimit          Write SetCreditLimit;
    property    GracePeriod         : Integer   Read GetGracePeriod          Write SetGracePeriod;
    property    Active              : boolean   Read GetActive               Write SetActive;
    property    DefaultPostAccount  : String    Read GetDefaultPostAccount   Write SetDefaultPostAccount;
    property    DefaultPostAccountId: Integer   Read GetDefaultPostAccountId Write SetDefaultPostAccountId;
  end;

  TOtherFollowUps = class(TMSBusObj)
  Private
    fiOtherContactID                : Integer;
    fiEmployeeID                    : Integer;
    fiClientID                      : Integer;
    fiResultTypeId                  : Integer;
    fiTypeId                        : Integer;
    Function  GetOtherContactID		: Integer;
    Function  GetEmployeeID			: Integer;
    Function  GetClientID			: Integer;
    Function  GetFollowUpDate		: TDateTime;
    Function  GetNotes				: String;
    Function  GetDone				: Boolean;
    Function  GetAppearDays			: Integer;
    Function  GetCreationDate		: TDateTime;
    Function  GetUpdateDate			: TDateTime;
    Function  GetIsSupplier			: Boolean;
    Function  GetIsOtherContact		: Boolean;
    Function  GetIsCustomer			: Boolean;
    Function  GetHours				: Double;
    Function  GetTypeId				: Integer;
    Function  GetResultTypeId		: Integer;
    Function  GetIsPhoneFollowUp	: Boolean;
    Function  GetCustomField1		: String;
    Function  GetCustomField2		: String;
    Function  GetCustomField3		: String;
    Function  GetCustomField4		: String;
    Function  GetCustomField5		: String;
    Function  GetCustomField6		: String;
    Function  GetCustomField7		: String;
    Function  GetCustomField8		: String;
    Function  GetCustomField9		: String;
    Function  GetCustomField10	: String;
    function  GetLeadLineID     : Integer;
    Procedure SetOtherContactID		(Const Value: Integer);
    Procedure SetEmployeeID			(Const Value: Integer);
    Procedure SetClientID			(Const Value: Integer);
    Procedure SetFollowUpDate		(Const Value: TDateTime);
    Procedure SetNotes				(Const Value: String);
    Procedure SetDone				(Const Value: Boolean);
    Procedure SetAppearDays			(Const Value: Integer);
    Procedure SetCreationDate		(Const Value: TDateTime);
    Procedure SetUpdateDate			(Const Value: TDateTime);
    Procedure SetIsSupplier			(Const Value: Boolean);
    Procedure SetIsOtherContact		(Const Value: Boolean);
    Procedure SetIsCustomer			(Const Value: Boolean);
    Procedure SetHours				(Const Value: Double);
    Procedure SetTypeId				(Const Value: Integer);
    Procedure SetResultTypeId		(Const Value: Integer);
    Procedure SetIsPhoneFollowUp	(Const Value: Boolean);
    Procedure SetCustomField1		(Const Value: String);
    Procedure SetCustomField2		(Const Value: String);
    Procedure SetCustomField3		(Const Value: String);
    Procedure SetCustomField4		(Const Value: String);
    Procedure SetCustomField5		(Const Value: String);
    Procedure SetCustomField6		(Const Value: String);
    Procedure SetCustomField7		(Const Value: String);
    Procedure SetCustomField8		(Const Value: String);
    Procedure SetCustomField9		(Const Value: String);
    Procedure SetCustomField10	(Const Value: String);
    procedure SetLeadLineID     (const Value: Integer);
    function GetEmployeeName: string;
    function GetOtherContactName: string;
    procedure SetEmployeeName(const Value: string);
    procedure SetOtherContactName(const Value: string);
    function GetResultTypeName: string;
    function GetTypeName: string;
    procedure SetResultTypeName(const Value: string);
    procedure SetTypeName(const Value: string);
    function GetCustomerName: string;
    function GetSupplierName: string;
    procedure SetCustomerName(const Value: string);
    procedure SetSupplierName(const Value: string);
    function GetRepairID: Integer;
    procedure SetRepairID(const Value: Integer);
  Protected
    Function DoAfterInsert(Sender :TDatasetBusObj): Boolean; override;
    function GetIsList: boolean; override;
  Public
    constructor Create(AOwner: TComponent);     Override;
    function    ValidateData :Boolean ;         Override;
    function    Save :Boolean ;                 Override;
    procedure   SaveToXMLNode(const Node: IXMLNode);  Override;
    procedure   LoadFromXMLNode(const Node: IXMLNode);Override;
    function  GetSQL:String ;                                   Override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    Function  ValidateXMLData(const Node :IXMLNode) :Boolean ;        Override;
    Function  ForeignKeysValid(const Node       :IXMLNode):Boolean;   Override;
    Property	ClientID	: Integer	Read getClientID			Write SetClientID;
    Property	OtherContactID	:Integer	Read getOtherContactID		Write SetOtherContactID;
    Property	IsSupplier	: Boolean	Read getIsSupplier			Write SetIsSupplier;
    Property	IsOtherContact	: Boolean	Read getIsOtherContact		Write SetIsOtherContact;
    Property	IsCustomer	: Boolean	Read getIsCustomer			Write SetIsCustomer;
    class function _Schema: string; override;
  published
    property  OtherContactName: string read GetOtherContactName write SetOtherContactName;
    property CustomerName: string read GetCustomerName write SetCustomerName;
    property SupplierName: string read GetSupplierName write SetSupplierName;
    Property	EmployeeID	: Integer	Read getEmployeeID			Write SetEmployeeID;
    property  EmployeeName: string read GetEmployeeName write SetEmployeeName;
    Property	FollowUpDate	: TDateTime	Read getFollowUpDate		Write SetFollowUpDate;
    Property	Notes		: String	Read getNotes				Write SetNotes;
    Property	Done		: Boolean	Read getDone				Write SetDone;
    Property	AppearDays	: Integer	Read getAppearDays			Write SetAppearDays;
    Property	CreationDate	: TDateTime	Read getCreationDate		Write SetCreationDate;
    Property	UpdateDate	: TDateTime	Read getUpdateDate			Write SetUpdateDate;
    Property	Hours		: Double        Read getHours				Write SetHours;
    Property	TypeId		: Integer	Read getTypeId				Write SetTypeId;
    property  TypeName: string read GetTypeName write SetTypeName;
    Property	ResultTypeId	: Integer	Read getResultTypeId		Write SetResultTypeId;
    property  ResultTypeName: string read GetResultTypeName write SetResultTypeName;
    Property	IsPhoneFollowUp	: Boolean	Read getIsPhoneFollowUp		Write SetIsPhoneFollowUp;
    Property	CUSTFLD1	: String	Read getCustomField1		Write SetCustomField1;
    Property	CUSTFLD2	: String	Read getCustomField2		Write SetCustomField2;
    Property	CUSTFLD3	: String	Read getCustomField3		Write SetCustomField3;
    Property	CUSTFLD4	: String	Read getCustomField4		Write SetCustomField4;
    Property	CUSTFLD5	: String	Read getCustomField5		Write SetCustomField5;
    Property	CUSTFLD6	: String	Read getCustomField6		Write SetCustomField6;
    Property	CUSTFLD7	: String	Read getCustomField7		Write SetCustomField7;
    Property	CUSTFLD8	: String	Read getCustomField8		Write SetCustomField8;
    Property	CUSTFLD9	: String	Read getCustomField9		Write SetCustomField9;
    Property	CUSTFLD10	: String	Read getCustomField10		Write SetCustomField10;
    Property  LeadLineID      : Integer Read getLeadLineID      Write SetLeadLineID;
    Property	RepairID	: Integer	Read GetRepairID			Write SetRepairID;
  End;

  TRelatedClients = class(TMSBusObj)
  Private
    fiMasterClientID	            : Integer;
    fiChildClientID	                : Integer;
    Function  GetMasterClientID		: Integer;
    Function  GetMasterCompany		: String;
    Function  GetChildClientID		: Integer;
    Function  GetChildCompany		: String;
    Procedure SetMasterClientID		(Const Value: Integer);
    Procedure SetMasterCompany		(Const Value: String);
    Procedure SetChildClientID		(Const Value: Integer);
    Procedure SetChildCompany		(Const Value: String);
  Protected
    function  GetSQL:String ;                                   Override;
    Function  ValidateXMLData(const Node :IXMLNode) :Boolean ;        Override;
    Function  ForeignKeysValid(const Node       :IXMLNode):Boolean;   Override;
    function FindClient(const aClientId: integer): string; overload; virtual;
    function FindClient(const aClientName: string): integer; overload;  virtual;
  Public
    procedure DoFieldOnChange(Sender: TField);                           Override;
    constructor Create(AOwner: TComponent);     Override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    function    ValidateData :Boolean ;         Override;
    function    Save :Boolean ;                 Override;
    procedure   SaveToXMLNode(const Node: IXMLNode);  Override;
    procedure   LoadFromXMLNode(const Node: IXMLNode);Override;
  published
    Property	MasterClientID			: Integer	Read getMasterClientID		Write SetMasterClientID;
    Property	MasterCompany			: String	Read getMasterCompany		Write SetMasterCompany;
    Property	ChildClientID			: Integer	Read getChildClientID		Write SetChildClientID;
    Property	ChildCompany			: String	Read getChildCompany		Write SetChildCompany;
  End;

  TRelatedCustomer = class(TRelatedClients)
  protected
    function FindClient(const aClientId: integer): string; overload; override;
    function FindClient(const aClientName: string): integer; overload;  override;
  end;

  TProductGroupDiscount= class(TMSBusObj)
  Private
    ficlientId :Integer;
    Function getClientID	:	Integer	;
    Function getCol1	    :	String	;
    Function getCol2	    :	String	;
    Function getCol3	    :	String	;
    Function getDiscount	:	Double	;
    Procedure SetClientID	(Const Value :	Integer);
    Procedure SetCol1	    (Const Value :	String);
    Procedure SetCol2	    (Const Value :	String);
    Procedure SetCol3	    (Const Value :	String);
    Procedure SetDiscount	(Const Value :	Double);
    function GetClientName: string;
    procedure SetClientName(const Value: string);
    function GetMustMatch: boolean;
    procedure SetMustMatch(const Value: boolean);
  Protected
    function  GetSQL:String ;                                   Override;
    Function  ValidateXMLData(const Node :IXMLNode) :Boolean ;        Override;
    Function  ExportsubClasses(const Node: IXMLNode):Boolean;         Override;
    Function  ImportsubClasses(const node: IXMLNode):Boolean;         Override;
    Function  ForeignKeysValid(const Node       :IXMLNode):Boolean;   Override;
    function GetIsList: boolean; override;
    function  DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  Public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    constructor Create(AOwner: TComponent);     override;
    function    ValidateData :Boolean ;         Override;
    function    Save :Boolean ;                 Override;
    procedure   SaveToXMLNode(const Node: IXMLNode);  Override;
    procedure   LoadFromXMLNode(const Node: IXMLNode);Override;
    Property 	ClientID	:	Integer	Read getClientID	Write SetClientID	;
    class function _Schema: string; override;
  published
    property  CustomerName: string read GetClientName write SetClientName;
    Property 	Col1	    :	String	Read getCol1	    Write SetCol1	;
    Property 	Col2	    :	String	Read getCol2	    Write SetCol2	;
    Property 	Col3	    :	String	Read getCol3	    Write SetCol3	;
    Property 	Discount	:	Double	Read getDiscount	Write SetDiscount	;
    property MustMatch: boolean read GetMustMatch write SetMustMatch;
  End;

  TSpecialProducts = Class(TMSBusObj)
  Private
    fiProductId :Integer;
    fiCustomerID:Integer;
    {field property functions }
    Function getCustomerId	  :	Integer	;
    Function GetProductID	    :	Integer	;
    Function getProductName   :	String	;
    Function getDescription	  :	String	;
    Function getOrigPrice	    :	Double	;
    Function getLinePrice	    :	Double	;
    Function getIncludeInRun	:	Boolean	;
    Function getUOM	          :	String	;
    Function getUOMID	        :	Integer	;
    Function getUOMMultiplier :	Double	;
    Procedure SetCustomerId	        (Const Value :	Integer	);
    Procedure SetProductID	        (Const Value :	Integer	);
    Procedure SetSpecialProductName	(Const Value :	String	);
    Procedure SetDescription	      (Const Value :	String	);
    Procedure SetOrigPrice	        (Const Value :	Double	);
    Procedure SetLinePrice	        (Const Value :	Double	);
    Procedure SetIncludeInRun	    (Const Value :	Boolean	);
    function GetCustomerName: string;
    procedure SetCustomerName(const Value: string);
    function getDateFrom: TDatetime;
    procedure setDateFrom(const Value: TDatetime);
    function getDateTo: TDatetime;
    procedure setDateTo(const Value: TDatetime);
    Procedure SetUOMID	            (Const Value :	Integer	);
    Procedure SetUOM	              (Const Value :	String	);
    Procedure SetUOMMultiplier      (Const Value :	Double	);

  Protected
    function  GetSQL:String ;                                   Override;
    Function  ValidateXMLData(const Node :IXMLNode) :Boolean ;        Override;
    Function  ExportsubClasses(const Node: IXMLNode):Boolean;         Override;
    Function  ImportsubClasses(const node: IXMLNode):Boolean;         Override;
    Function  ForeignKeysValid(const Node       :IXMLNode):Boolean;     Override;
    function GetIsList: boolean; override;
    Function DoAfterInsert(Sender :TDatasetBusObj): Boolean; override;
    Function DoBeforePost(Sender :TDatasetBusObj): Boolean; override;
  Public
    procedure DoFieldOnChange(Sender: TField); override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    constructor Create(AOwner: TComponent);     override;
    function    ValidateData :Boolean ;         Override;
    function    Save :Boolean ;                 Override;
    procedure   SaveToXMLNode(const Node: IXMLNode);  Override;
    procedure   LoadFromXMLNode(const Node: IXMLNode);Override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    class function SepcialPriceID(const aID, aCustomerId,aProductId ,aUOMID:Integer; const aDateFrom, aDateTo:TDatetime;  Conn:TCustomMyConnection) :Integer;

  published
    Property 	CustomerId	  :	Integer	Read getCustomerId		Write SetCustomerId	;
    property  CustomerName  : string  read GetCustomerName  write SetCustomerName;
    Property 	ProductID	    :	Integer	Read GetProductID	    Write SetProductID	;
    Property 	ProductName	  :	String	Read getProductName	  Write SetSpecialProductName	;
    Property 	Description	  :	String	Read getDescription	  Write SetDescription	;
    Property 	OrigPrice	    :	Double	Read getOrigPrice	    Write SetOrigPrice	;
    Property 	LinePrice	    :	Double	Read getLinePrice	    Write SetLinePrice	;
    Property 	IncludeInRun	:	Boolean	Read getIncludeInRun	Write SetIncludeInRun	;
    Property 	DateFrom      : TDatetime read getDateFrom    write setDateFrom;
    Property 	DateTo        : TDatetime read getDateTo      write setDateTo;
    Property 	UOM	          :	String	  Read getUOM	        Write SetUOM	;
    Property 	UOMID	        :	Integer	Read getUOMID		      Write SetUOMID	;
    Property 	UOMMultiplier	:	Double	Read getUOMMultiplier	Write SetUOMMultiplier	;
  End;

//  TContact = class(TMSBusObj)
//  Private
//    fiCusID         : Integer;
//    fiSupID         : Integer;
//    fiEmployeeID    : Integer;
//    Function  GetCusID				: Integer;
//    Function  GetSupID				: Integer;
//    Function  GetEmployeeID			: Integer;
//    Function  GetCompany			: String;
//    Function  GetContactTitle		: String;
//    Function  GetContactFirstName	: String;
//    Function  GetContactSurName		: String;
//    Function  GetContactAddress		: String;
//    Function  GetContactCity		: String;
//    Function  GetContactState		: String;
//    Function  GetContactPcode		: String;
//    Function  GetContactCountry : String;
//    Function  GetContactPH			: String;
//    Function  GetContactAltPH		: String;
//    Function  GetContactMOB			: String;
//    Function  GetContactFax			: String;
//    Function  GetContactEmail		: String;
//    Function  GetNotes				: String;
//    Function  GetContactAddress2	: String;
//    Function  GetContactAddress3	: String;
//    Function  GetCardNumber			: String;
//    Function  GetAccountNo			: String;
//    Function  GetJobTitle			: String;
//    Function  GetActive				: Boolean;
//    Function  GetContactIsCustomer	: Boolean;
//    Function  GetContactIsJob		: Boolean;
//    Function  GetContactIsSupplier	: Boolean;
//    Function  GetIsOtherContact		: Boolean;
//    Function  GetUseOnRun			: Boolean;
//    Procedure SetCusID				(Const Value: Integer);
//    Procedure SetSupID				(Const Value: Integer);
//    Procedure SetEmployeeID			(Const Value: Integer);
//    Procedure SetCompany			(Const Value: String);
//    Procedure SetContactTitle		(Const Value: String);
//    Procedure SetContactFirstName	(Const Value: String);
//    Procedure SetContactSurName		(Const Value: String);
//    Procedure SetContactAddress		(Const Value: String);
//    Procedure SetContactCity		(Const Value: String);
//    Procedure SetContactState		(Const Value: String);
//    Procedure SetContactPcode		(Const Value: String);
//    Procedure SetContactCountry (Const Value: String);
//    Procedure SetContactPH			(Const Value: String);
//    Procedure SetContactAltPH		(Const Value: String);
//    Procedure SetContactMOB			(Const Value: String);
//    Procedure SetContactFax			(Const Value: String);
//    Procedure SetContactEmail		(Const Value: String);
//    Procedure SetNotes				(Const Value: String);
//    Procedure SetContactAddress2	(Const Value: String);
//    Procedure SetContactAddress3	(Const Value: String);
//    Procedure SetActive				(Const Value: Boolean);
//    Procedure SetCardNumber			(Const Value: String);
//    Procedure SetAccountNo			(Const Value: String);
//    Procedure SetJobTitle			(Const Value: String);
//    Procedure SetContactIsCustomer	(Const Value: Boolean);
//    Procedure SetContactIsJob		(Const Value: Boolean);
//    Procedure SetContactIsSupplier	(Const Value: Boolean);
//    Procedure SetIsOtherContact		(Const Value: Boolean);
//    Procedure SetUseOnRun			(Const Value: Boolean);
//    function GetCustomerName: string;
//    function GetEmployeeName: string;
//    function GetSupplierName: string;
//    procedure SetCustomerName(const Value: string);
//    procedure SetEmployeeName(const Value: string);
//    procedure SetSupplierName(const Value: string);
//    procedure SetContactIsOtherContact(const Value: Boolean);
//    function GetContactIsOtherContact: Boolean;
//  Protected
//    function  GetSQL:String ;                                   Override;
//    Function  ValidateXMLData(const Node :IXMLNode) :Boolean ;        Override;
//    Function  ForeignKeysValid(const Node       :IXMLNode):Boolean;   Override;
//    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean; override;
//  Public
//    class function GetIDField: string; override;
//    class function GetBusObjectTablename: string; Override;
//    Class function   GetKeyStringField       : string;  override;
//    constructor Create(AOwner: TComponent);     Override;
//    function    ValidateData :Boolean ;         Override;
//    function    Save :Boolean ;                 Override;
//    procedure   SaveToXMLNode(const Node: IXMLNode);  Override;
//    procedure   LoadFromXMLNode(const Node: IXMLNode);Override;
//  published
//    Property	CusID					: Integer	Read getCusID				Write SetCusID;
//    property    CustomerName: string read GetCustomerName write SetCustomerName;
//    Property	SupID					: Integer	Read getSupID				Write SetSupID;
//    property    SupplierName: string read GetSupplierName write SetSupplierName;
//    Property	EmployeeID				: Integer	Read getEmployeeID			Write SetEmployeeID;
//    property    EmployeeName: string read GetEmployeeName write SetEmployeeName;
//    Property	Company					: String	Read getCompany				Write SetCompany;
//    Property	ContactTitle			: String	Read getContactTitle		Write SetContactTitle;
//    Property	ContactFirstName		: String	Read getContactFirstName	Write SetContactFirstName;
//    Property	ContactSurName			: String	Read getContactSurName		Write SetContactSurName;
//    Property	ContactAddress			: String	Read getContactAddress		Write SetContactAddress;
//    Property	ContactAddress2			: String	Read getContactAddress2		Write SetContactAddress2;
//    Property	ContactAddress3			: String	Read getContactAddress3		Write SetContactAddress3;
//    Property	ContactCity				: String	Read getContactCity			Write SetContactCity;
//    Property	ContactState			: String	Read getContactState		Write SetContactState;
//    Property	ContactPcode			: String	Read getContactPcode		Write SetContactPcode;
//    Property	ContactCountry	  : String	Read getContactCountry  Write SetContactCountry;
//    Property	ContactPH				: String	Read getContactPH			Write SetContactPH;
//    Property	ContactAltPH			: String	Read getContactAltPH		Write SetContactAltPH;
//    Property	ContactMOB				: String	Read getContactMOB			Write SetContactMOB;
//    Property	ContactFax				: String	Read getContactFax			Write SetContactFax;
//    Property	ContactEmail			: String	Read getContactEmail		Write SetContactEmail;
//    Property	Notes					: String	Read getNotes				Write SetNotes;
//    Property	Active					: Boolean	Read getActive				Write SetActive;
//    Property	CardNumber				: String	Read getCardNumber			Write SetCardNumber;
//    Property	AccountNo				: String	Read getAccountNo			Write SetAccountNo;
//    Property	JobTitle				: String	Read getJobTitle			Write SetJobTitle;
//    Property	ContactIsCustomer		: Boolean	Read getContactIsCustomer	Write SetContactIsCustomer;
//    Property	ContactIsJob			: Boolean	Read getContactIsJob		Write SetContactIsJob;
//    Property	ContactIsOtherContact: Boolean read GetContactIsOtherContact write SetContactIsOtherContact;
//    Property	ContactIsSupplier		: Boolean	Read getContactIsSupplier	Write SetContactIsSupplier;
//    Property	IsOtherContact	        : Boolean	Read getIsOtherContact      Write SetIsOtherContact;
//    Property	UseOnRun				    : Boolean	Read getUseOnRun			Write SetUseOnRun;
//  End;



implementation

uses Sysutils, tcDataUtils, BusObjClient,
   BusObjUtils, AppEnvironment, CommonLib, BusObjSimpleTypes, MySQLConst,
   BusObjGLAccount, ERPDbComponents, Variants,
   BusObjEmployeeDetails, BusObjMarketingLeads, CommonDbLib, BusObjectListObj,
   BusObjSchemaLib, BusObjRepairs, Dateutils, BusObjConst,
  BusObjSales, tcConst, BusObjStock, DbSharedObjectsObj;

 {Tservices}

constructor Tservices.Create(AOwner: TComponent);
begin
	inherited Create(AOwner)
end;


destructor Tservices.Destroy;
begin
	inherited;
end;


procedure   Tservices.LoadFromXMLNode(Const node: IXMLNode);
begin
	inherited;
    SetPropertyFromNode(Node,'servicedesc');
    SetPropertyFromNode(Node,'active');
    SetPropertyFromNode(Node,'issoftware');
    SetPropertyFromNode(Node,'ishardware');
    SetDateTimePropertyFromNode(Node,'creationdate');
    SetDateTimePropertyFromNode(Node,'updatedate');
    SetPropertyFromNode(Node,'standardrate');
    SetPropertyFromNode(Node,'ranking');
    SetPropertyFromNode(Node,'ProductId');
    SetPropertyFromNode(Node,'isfixedrate');
end;


procedure   Tservices.SaveToXMLNode(Const node: IXMLNode);
begin
	inherited;
		AddXMLNode(node,'servicedesc' ,servicedesc);
		AddXMLNode(node,'active' ,active);
		AddXMLNode(node,'issoftware' ,issoftware);
		AddXMLNode(node,'ishardware' ,ishardware);
		AddXMLNode(node,'creationdate' ,creationdate);
		AddXMLNode(node,'updatedate' ,updatedate);
		AddXMLNode(node,'standardrate' ,standardrate);
		AddXMLNode(node,'ranking' ,ranking);
    AddXMLNode(node,'ProductId' ,ProductId);
		AddXMLNode(node,'isfixedrate' ,isfixedrate);
end;


function    Tservices.ValidateData :Boolean ;
begin
  Result := False;
	Resultstatus.Clear;
  PostDb;
	if servicedesc = '' then begin
		AddResult(False , rssWarning , 0,  'Service Description should not be blank');
		Exit;
	end;
  if not TServices.ServiceDescUnique(ServiceDesc,ID) then begin
		AddResult(False , rssWarning , 0,  'A Service already exists with this Description');
		Exit;
  end;
  { The form is not validating standard rate }
//	if standardrate = 0 then begin
//		AddResult(False , rssWarning , 0,  'Standard Rate should not be blank');
//		Exit;
//	end;
  Result := true;
end;


class function TServices._Schema: string;
begin
  result:= inherited;
end;

function    Tservices.Save :Boolean ;
begin
	Result := False;
	if not ValidateData then Exit;
  DeleteServiceSubObjects;
	Result := Inherited Save;
end;
procedure Tservices.DeleteServiceSubObjects;
begin
  if (Active)  then Exit;
  RepServices.iteraterecords(DeleteServiceSubObjectsCallback);
end;
procedure Tservices.DeleteServiceSubObjectsCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if Sender is TRepServices then begin
    if TRepServices(Sender).Active <> Self.Active then begin
      Connection.beginnestedtransaction;
      try
        TRepServices(Sender).Active := Self.Active;
        TRepServices(Sender).PostDB;
        if not TRepServices(Sender).Save then begin
          Connection.rollbacknestedtransaction;
          Exit;
        end;
        Connection.commitnestedtransaction;
      Except
        Connection.rollbacknestedtransaction;
      end;
    end;
  end;
end;
procedure Tservices.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
	inherited;
end;


procedure Tservices.DoFieldOnChange(Sender: TField);
begin
	inherited;
end;


Function Tservices.GetSQL: String ;
begin
	fSQL := 'SELECT * FROM tblservices';
	Result := Inherited GetSQL;
end;


class function  Tservices.GetIDField : String;
begin
	Result := 'serviceid'
end;

class function Tservices.GetBusObjectTablename: string;
begin
  Result := 'tblservices';
end;

Function  Tservices.DoAfterPost(Sender :TDatasetBusObj ):Boolean;
begin
	REsult := inherited DoAfterPost(sender);
End;


{Property functions}
Function Tservices.Getservicedesc:String; begin Result := GetStringField('servicedesc');End;
Function Tservices.Getactive:Boolean; begin Result := GetBooleanField('active');End;
Function Tservices.Getissoftware:String; begin Result := GetStringField('issoftware');End;
class function TServices.GetKeyStringField: string;
begin
  result := 'ServiceDesc';
end;

class function TServices.GetKeyStringProperty: string;
begin
  result := 'ServiceDesc';
end;

Function Tservices.Getishardware:String; begin Result := GetStringField('ishardware');End;
Function Tservices.Getcreationdate:TDatetime; begin Result := GetDatetimeField('creationdate');End;
Function Tservices.Getupdatedate:TDatetime; begin Result := GetDatetimeField('updatedate');End;
Function Tservices.Getstandardrate:Double; begin Result := GetFloatField('standardrate');End;
Function Tservices.Getranking:Integer; begin Result := GetIntegerField('ranking');End;
Function Tservices.GetProductId:Integer; begin Result := GetIntegerField('ProductId');End;
Function Tservices.Getisfixedrate:String; begin Result := GetStringField('isfixedrate');End;
Procedure Tservices.Setservicedesc(Const Value :String); begin SetStringField('servicedesc' , Value);End;
function TServices.getRepServices: TRepServices;
begin
  result := TRepservices(getContainercomponent(TRepservices , 'ServiceID = ' + IntToStr(self.ID)));
end;
class function TServices.ServiceDescUnique(const aServiceDesc: string;
  const IgnoreId: integer; Conn: TCustomMyConnection = nil): boolean;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Conn) then qry.Connection:= conn
    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select * from tblServices');
    qry.SQL.Add('where ServiceDesc = ' + QuotedStr(aServiceDesc));
    qry.SQL.Add('and ServiceID <> ' + IntToStr(IgnoreId));
    qry.Open;
    result:= qry.IsEmpty;
  finally
    qry.Free;
  end;
end;

Procedure Tservices.Setactive(Const Value :Boolean); begin SetBooleanField('active' , Value);End;
Procedure Tservices.Setissoftware(Const Value :String); begin SetStringField('issoftware' , Value);End;
Procedure Tservices.Setishardware(Const Value :String); begin SetStringField('ishardware' , Value);End;
Procedure Tservices.Setcreationdate(Const Value :TDatetime); begin SetDatetimeField('creationdate' , Value);End;
Procedure Tservices.Setupdatedate(Const Value :TDatetime); begin SetDatetimeField('updatedate' , Value);End;
Procedure Tservices.Setstandardrate(Const Value :Double); begin SetFloatField('standardrate' , Value);End;
Procedure Tservices.Setranking(Const Value :Integer); begin SetIntegerField('ranking' , Value);End;
Procedure Tservices.SetProductId(Const Value :Integer); begin SetIntegerField('ProductId' , Value);End;
Procedure Tservices.Setisfixedrate(Const Value :String); begin SetStringField('isfixedrate' , Value);End;


 { TShippingMethod }

function  TShippingMethod.GetSQL:String ;
begin
    fSQL := 'Select * from tblShippingMethods ';
    result := inherited GetSQL;
End;
class function  TShippingMethod.GetIDField :String;
begin
    REsult := 'ShippingMethodID';
End;

class function TShippingMethod.GetBusObjectTablename: string;
begin
  Result := 'tblShippingMethods';
end;

function TShippingMethod.ValidateData :Boolean ;
var
  CleanShippingMethod: string;
begin
  result := inherited ValidateData;
  if not result then Exit;
  result:= false;
  if Trim(ShippingMethod) = '' then begin
    AddResult(False,rssWarning,0,'Method should not be blank');
    exit;
  end;
  CleanShippingMethod:= self.GetXMLNodeStringValue(self.CleanXMLNode,'ShippingMethod');
  if (CleanShippingMethod <> '') and (CleanShippingMethod <> ShippingMethod) then begin
    AddResult(False,rssWarning,0,'Method "'+CleanShippingMethod+
    '" can not be changed to "' + ShippingMethod + '" for existing record');
    exit;
  end;
  result:= true;
end;

class function TShippingMethod._Schema: string;
begin
  result:= inherited;
end;

function    TShippingMethod.Save :Boolean ;
begin
  result:= ValidateData;
  if not result then exit;
  Result := inherited Save;
end;
procedure   TShippingMethod.SaveToXMLNode(Const Node: IXMLNode);
begin
    inherited;
    AddXMLNode(Node , 'ShippingMethod',ShippingMethod);
    AddXMLNode(Node , 'Active',Active);
end;
procedure   TShippingMethod.LoadFromXMLNode(Const Node: IXMLNode);
begin
    inherited;
    SetPropertyFromNode(Node, 'ShippingMethod');
    SetBooleanPropertyFromNode(Node , 'Active');
end;
Function  TShippingMethod.GetActive         :Boolean;
begin
    Result := getBooleanfield('Active');
end;
Function  TShippingMethod.GetShippingMethod :String;
begin
    Result := getStringField('ShippingMethod');
end;
Procedure TShippingMethod.SetActive(const Value :Boolean);
begin
    SetBooleanfield('Active' , Value);
end;
Procedure TShippingMethod.SetShippingMethod(Const Value :String);
begin
    SetStringfield('ShippingMethod' , Value);
end;


 { TClientType }

Function TClientType.GetTerms: TTerms;
begin
  if not Assigned(fTerms) then fTerms := TTerms.Create(self);
  if fTerms.Id <> TermsID then fTerms.LoadSelect('TermsID =' + IntToStr(TermsID));
  Result := fTerms;
end;

constructor TClientType.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblClientType';
  ExportExcludeList.Add('defaultpostaccountid');
  ExportExcludeList.Add('termsid');
end;

destructor TClientType.Destroy;
begin
  inherited;
end;

Function    TClientType.ValidateData :Boolean ;
var
  CleanTypeName: string;
  qry: TERPQuery;
begin
    result := inherited ValidateData;
    if not result then Exit;
    Result := False;
    Resultstatus.Clear;
    if TypeName = '' then begin
        AddResult(False , rssWarning , 0,  'Type name should not be blank');
        Exit;
    end;
    PostDB;
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := self.Connection.Connection;
      qry.SQL.Add('select * from '+ self.TableName + ' where TypeName = ' +  QuotedStr(self.TypeName));
      qry.SQL.Add('and ' + self.GetIDField + ' <> ' + IntToStr(ID));
      qry.Open;
      if qry.RecordCount > 0 then begin
        AddResult(False , rssWarning , 0,  'Type Name (' + TypeName + ') already exists in ERP');
        Exit;
      end;
    finally
      qry.Free;
    end;
    CleanTypeName:= self.GetXMLNodeStringValue(self.CleanXMLNode,'TypeName');
    if (CleanTypeName <> '') and (CleanTypeName <> TypeName) then begin
        AddResult(False , rssWarning , 0,  'Type name can not be changed for an existiong record');
        Exit;
    end;
    Result := true;
end;

class function TClientType._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TTerms','Terms','TermsID','ID');
  TBOSchema.AddRefType(result,'TTerms','Terms','TermsName','TermsName');
  TBOSchema.AddRefType(result,'TAccount','DefaultPostAccount_1','DefaultPostAccount','AccountName');
  TBOSchema.AddRefType(result,'TAccount','DefaultPostAccount_1','DefaultPostAccountID','ID');
end;

Function    TClientType.Save :Boolean ;
begin
  Result := False;
//  PostDB;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure   TClientType.SaveToXMLNode(Const Node: IXMLNode);
begin
    inherited;
    AddXMLNode(Node , 'TypeName',TypeName);
    AddXMLNode(Node , 'TypeDescription',TypeDescription);
    AddXMLNode(Node , 'CreditLimit',CreditLimit);
    AddXMLNode(Node , 'GracePeriod',GracePeriod);
    AddXMLNode(Node , 'Active',Active);
    AddXMLNode(Node , 'TermsID'   ,TermsID);
    AddXMLNode(Node , 'DefaultPostAccountID',DefaultPostAccountID);
    AddXMLNode(Node , 'DefaultPostAccount',DefaultPostAccount);
end;

procedure   TClientType.LoadFromXMLNode(Const Node: IXMLNode);
begin
    inherited;
    SetPropertyFromNode(Node, 'TermsId');
    SetPropertyFromNode(Node, 'DefaultPostAccountID');
    SetPropertyFromNode(Node, 'TypeName');
    SetPropertyFromNode(Node, 'TypeDescription');
    SetPropertyFromNode(Node, 'CreditLimit');
    SetPropertyFromNode(Node, 'GracePeriod');
    SetBooleanPropertyFromNode(Node, 'Active');
    SetPropertyFromNode(Node, 'DefaultPostAccount');
    SetPropertyFromNode(Node, 'DefaultPostAccountID');
end;

procedure TClientType.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
  if Assigned(fTerms) then FreeAndNil(fTerms);
end;

Function TClientType.GetActive: boolean;
begin
  Result := GetBooleanField('Active');
end;

Function TClientType.GetTypeDescription: String;
begin
  Result := GetStringField('TypeDescription');
end;

Function TClientType.GetTypeName: String;
begin
  Result := GetStringField('TypeName');
end;


Function TClientType.GetCreditLimit: double;
begin
  Result := GetFloatField('CreditLimit');
end;

Function TClientType.GetDefaultPostAccount: String;
begin
  Result := GetStringField('DefaultPostAccount');
end;

Function TClientType.GetDefaultPostAccountId: Integer;
begin
  Result := GetIntegerField('DefaultPostAccountId');
end;

Function TClientType.GetGracePeriod: Integer;
begin
  Result := GetIntegerField('GracePeriod');
end;
class Function TClientType.GetIDField :String ;
begin
    Result :='ClientTypeId';
end;

class function TClientType.GetBusObjectTablename: string;
begin
  Result := 'tblClientType';
end;

Function TClientType.GetSQL: String;
begin
    fSQL := 'SELECT * FROM tblClientType';
    Result := inherited GetSQL;
end;

Function TClientType.GetTermsId: Integer;
begin
  Result := GetIntegerField('TermsId');
end;

procedure TClientType.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TClientType.SetTypeDescription(const Value: String);
begin
  SetStringField('TypeDescription', Value);
end;

procedure TClientType.SetTypeName(const Value: String);
begin
  SetStringField('TypeName', Value);
end;

procedure TClientType.SetCreditLimit(const Value: double);
begin
  SetFloatField('CreditLimit', Value);
end;

procedure TClientType.SetDefaultPostAccount(const Value: String);
begin
  SetStringField('DefaultPostAccount', Value);
end;

procedure TClientType.SetDefaultPostAccountId(const Value: Integer);
begin
  SetIntegerField('DefaultPostAccountId', Value);
end;

procedure TClientType.SetGracePeriod(const Value: Integer);
begin
  SetIntegerField('GracePeriod', Value);
end;

procedure TClientType.SetTermsId(const Value: Integer);
begin
  SetIntegerField('TermsId', Value);
end;


procedure TClientType.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then Exit; // we are only interested in data fields.
  inherited;

  if Sysutils.SameText(Sender.FieldName , 'DefaultPostAccountID') then begin
    if Sender.AsInteger > 0 then
      DefaultPostAccount:= TAccount.IDToggle(Sender.AsInteger,Connection.Connection)
    else
      DefaultPostAccount:= '';
  end
  else if Sysutils.SameText(Sender.FieldName , 'DefaultPostAccount') then begin
    if sender.AsString <> '' then
      DefaultPostAccountID:= TAccount.IDToggle(Sender.AsString,Connection.Connection)
    else
      DefaultPostAccountID:= 0;
  end
end;

function TClientType.GetTermsName: string;
begin
  result:= Terms.TermsName;
end;

procedure TClientType.SetTermsName(const Value: string);
begin
  TermsId:= TTerms.IDToggle(Value,Connection.Connection);
end;

{ TTerms }

constructor TTerms.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblTerms';
end;

destructor TTerms.Destroy;
begin
  inherited;
end;

function TTerms.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  if not result then exit;
  IsEOM := TRue;
  Days := 0;
  ProgressPaymentDuration := 1;
  ProgressPaymentInstallments := 1;
  ProgressPaymenttype := 'M';
  PublishOnVS1 := False;
end;

procedure TTerms.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.FieldName, 'PP') then begin
    if ISProgressPayment then begin
      ProgressPaymenttype := 'M';
      if ProgressPaymentInstallments =0 then ProgressPaymentInstallments := 1;
      if ProgressPaymentDuration =0 then ProgressPaymentDuration := 1;
      SendEvent(BusObjEvent_Change, BusObjEventVal_ProgressPaymenttype,Self );
    end;
  end else if Sysutils.SameText(Sender.FieldName, 'PublishOnVS1') then begin
  end;

end;

function TTerms.Duedate(const BaseDate: TDateTime; TransObj:Tbusobj): TDateTime;
begin
  if isDays then begin
    Result := IncDay(BaseDate, Days);
  end else If IsEOM Then Begin
    Result := IncDay(IncHour(EndOfTheMonth(BaseDate), -1), Days);
  End Else  If isEOMPlus Then Begin
    REsult := IncDay(IncHOur(EndOfTheMonth(IncMonth(BaseDate, 1)), -1), Days);
  End Else if ISProgressPayment then begin
    Result :=   IncDay(BaseDate, iif(ProgressPaymentfirstPayonSaleDate , ProgressPaymentDaysAfterfirstPay , 0));
  end else begin
    REsult := BaseDate;
  End;
end;

class function TTerms.DueonReceipt: String;
var
  Terms : TTerms;
begin
  Terms := TTerms.CreateWithNewConn(Nil);
  try
    Terms.LoadSelect('TErms =' + Quotedstr(TERMS_ON_RCPT));
    if Terms.Count = 0 then Terms.LoadSelect('Days ="T" and TermsAmount=0');
    if Terms.Count =0 then begin
      Terms.New;
      Terms.TermsName := TERMS_ON_RCPT;
      Terms.IsDays := True;
      Terms.IsEOM:= False;
      Terms.IsEOMPlus := False;
      Terms.ISProgressPayment := False;
      Terms.Description := 'Due at the time of recieving the invoice';
      Terms.Days := 0;
      Terms.PostDB;
    end;
    REsult := Terms.TermsName;
  finally
    Freeandnil(Terms);
  end;

end;

Function TTerms.GetActive: boolean;
begin
  Result := GetBooleanField('Active');
end;

Function TTerms.GetDays: Integer;
begin
  Result := GetIntegerField('TermsAmount');
end;
Function TTerms.GetProgressPaymentDuration: Integer;
begin
  Result := GetIntegerField('ProgressPaymentDuration');
end;
Function TTerms.GetProgressPaymentDaysAfterfirstPay: Integer;
begin
  Result := Days;
end;
Function TTerms.GetProgressPaymentInstallments: Integer;
begin
  Result := GEtIntegerField('ProgressPaymentInstallments');
end;

function TTerms.getProgressPaymenttype: String;
begin
  Result := getStringField('ProgressPaymenttype');
end;

Function TTerms.GetDescription: String;
begin
  Result := GetStringField('Description');
end;

Function TTerms.GetEarlyDiscountPercent: double;
begin
  Result := GetFloatField('EarlyPaymentDiscount');
end;

function TTerms.GetEarlyPaymentDays: integer;
begin
  result := GetIntegerField('EarlyPaymentDays');
end;

Function TTerms.GetIsEOM: boolean;
begin
  Result := GetBooleanField('EOM');
end;

Function TTerms.GetIsEOMPlus: boolean;
begin
  Result := GetBooleanField('EOMPlus');
end;
Function TTerms.GetIsDays: boolean;
begin
  Result := GetBooleanField('Days');
end;
Function TTerms.GetISProgressPayment: boolean;
begin
  Result := GetBooleanField('PP');
end;


class Function TTerms.GetIDField :String ;
begin
    Result :='TermsID';
end;

class function TTerms.GetBusObjectTablename: string;
begin
  Result := 'tblTerms';
end;

Function TTerms.GetRequired: boolean;
begin
  Result := GetBooleanField('Required');
end;
Function TTerms.GetPublishOnVS1: boolean;
begin
  Result := GetBooleanField('PublishOnVS1');
end;
Function TTerms.GetisPurchasedefault: boolean;
begin
  Result := Appenv.Companyprefs.DebitTermsId = Id;
end;
Function TTerms.GetisSalesdefault: boolean;
begin
  Result := Appenv.Companyprefs.CreditTermsId = Id;
end;
Function TTerms.GetProgressPaymentfirstPayonSaleDate: boolean;
begin
  Result := GetBooleanField('ProgressPaymentfirstPayonSaleDate');
end;

Function TTerms.GetTermsName: String;
begin
  Result := GetStringField('Terms');
end;

procedure TTerms.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TTerms.SetDays(const Value: Integer);
begin
  SetIntegerField('TermsAmount', Value);
end;
procedure TTerms.SetProgressPaymentDuration(const Value: Integer);
begin
  SetIntegerField('ProgressPaymentDuration', Value);
end;
procedure TTerms.SetProgressPaymentDaysAfterfirstPay(const Value: Integer);
begin
  Days := Value
end;
procedure TTerms.SetProgressPaymentInstallments(const Value: Integer);
begin
    SetIntegerField('ProgressPaymentInstallments' , Value);
end;

procedure TTerms.SetProgressPaymenttype(const Value: String);
begin
  SetStringfield('ProgressPaymenttype', Value);
end;

procedure TTerms.SetDescription(const Value: String);
begin
  SetStringField('Description', Value);
end;

procedure TTerms.SetEarlyDiscountPercent(const Value: double);
begin
  SetFloatField('EarlyPaymentDiscount', Value);
end;

procedure TTerms.SetEarlyPaymentDays(const Value: integer);
begin
  SetIntegerField('EarlyPaymentDays',Value);
end;

procedure TTerms.SetIsEOM(const Value: boolean);
begin
  SetBooleanField('EOM', Value);
end;

procedure TTerms.SetIsEOMPlus(const Value: boolean);
begin
  SetBooleanField('EOMPlus', Value);
end;
procedure TTerms.SetIsDays(const Value: boolean);
begin
  SetBooleanField('Days', Value);
end;
procedure TTerms.SetISProgressPayment(const Value: boolean);
begin
  SetBooleanField('PP', Value);
end;

procedure TTerms.SetRequired(const Value: boolean);
begin
  SetBooleanField('Required', Value);
end;
procedure TTerms.SetPublishOnVS1(const Value: boolean);
begin
  SetBooleanField('PublishOnVS1', Value);
end;
procedure TTerms.SetisPurchasedefault(const Value: boolean);
begin
  if value then
    Appenv.Companyprefs.DebitTermsId := Id
  else if Appenv.Companyprefs.DebitTermsId = ID then Appenv.Companyprefs.DebitTermsId := 0;
end;
procedure TTerms.SetisSalesdefault(const Value: boolean);
begin
  if value then
    Appenv.Companyprefs.CreditTermsId := ID
  else if Appenv.Companyprefs.CreditTermsId = Id then Appenv.Companyprefs.CreditTermsId := 0;
end;
procedure TTerms.SetProgressPaymentfirstPayonSaleDate(const Value: boolean);
begin
  SetBooleanField('ProgressPaymentfirstPayonSaleDate', Value);
end;

procedure TTerms.SetTermsName(const Value: String);
begin
  SetStringField('Terms', Value);
end;
Function  TTerms.ValidateXMLData(Const Node :IXMLNode) :Boolean ;
begin
    Result := inherited ValidateXMLData(Node);

    if not Result then Exit;
    if not ImportingFromXMLFile then Exit;
    XMLSearchRecordDesc := 'Terms='  + GetXMLNodeStringValue(Node, 'Terms');
    Result := true;
    XMLSearchRecord := 'Terms='  + QuotedStr(GetXMLNodeStringValue(Node, 'Terms'));
    LocateXMLRecord;
end;
class function TTerms._Schema: string;
begin
  result:= inherited;
end;

Function  TTerms.ExportsubClasses(Const Node: IXMLNode):Boolean;
begin
    REsult := True;
end;
Function  TTerms.ImportsubClasses(Const node: IXMLNode):Boolean;
begin
    Result := True;
end;
function TTerms.InstallmentDate(const BaseDate: TDateTime;InstallmentNo: Integer): TDateTime;
begin
           if ProgressPaymenttype ='D' then REsult :=   IncDay  (BaseDate, InstallmentNo*ProgressPaymentDuration)
      else if ProgressPaymenttype ='W' then REsult :=   IncWeek (BaseDate, InstallmentNo*ProgressPaymentDuration)
      else if ProgressPaymenttype ='M' then REsult :=   IncMonth(BaseDate, InstallmentNo*ProgressPaymentDuration)
      else REsult :=   BaseDate;
end;

Function  TTerms.ForeignKeysValid(Const Node :IXMLNode):Boolean;
begin
    Result := true;
end;

function    TTerms.ValidateData :Boolean ;
var
  CleanTermsName: string;
begin
    result := inherited ValidateData;
    if not result then Exit;
    Result := False;
    Resultstatus.Clear;
    if TermsName = '' then begin
        AddResult(False , rssWarning , 0,  'Terms should not be blank');
        Exit;
    end;
    CleanTermsName:= self.GetXMLNodeStringValue(self.CleanXMLNode,'TermsName');
    if (CleanTermsName <> '') and (CleanTermsName <> TermsName) then begin
      AddResult(False , rssWarning , 0,
        'Terms "'+CleanTermsName+'" can not be renamed to "' +TermsName+
        '" for existing recored');
      Exit;
    end;
    Result := true;
end;

function TTerms.Save :Boolean ;
begin
  result:= ValidateData;
  if not result then exit;
  result := inherited Save;
end;

procedure   TTerms.SaveToXMLNode(Const Node: IXMLNode);
begin
    inherited;
    AddXMLNode(Node , 'TermsName' , TermsName);
    AddXMLNode(Node , 'Description', Description);
    AddXMLNode(Node , 'Days' , Days);
    AddXMLNode(Node , 'ProgressPaymentDuration' , ProgressPaymentDuration);
    AddXMLNode(Node , 'ProgressPaymentDaysAfterfirstPay' , ProgressPaymentDaysAfterfirstPay);
    AddXMLNode(Node , 'ProgressPaymentInstallments' , ProgressPaymentInstallments);
    AddXMLNode(Node , 'IsEOM' , IsEOM);
    AddXMLNode(Node , 'IsEOMPlus' , IsEOMPlus);
    AddXMLNode(Node , 'IsDays' , IsDays);
    AddXMLNode(Node , 'ISProgressPayment' , ISProgressPayment);
    AddXMLNode(Node , 'Required' , Required);
    AddXMLNode(Node , 'PublishOnVS1' , PublishOnVS1);
    AddXMLNode(Node , 'ProgressPaymentfirstPayonSaleDate' , ProgressPaymentfirstPayonSaleDate);
    AddXMLNode(Node , 'EarlyDiscountPercent' , EarlyDiscountPercent);
    AddXMLNode(Node , 'Active', Active);
end;
procedure   TTerms.LoadFromXMLNode(Const Node: IXMLNode);
begin
    inherited;
    SetPropertyFromNode(Node, 'TermsName');
    SetPropertyFromNode(Node, 'Days');
    SetBooleanPropertyFromNode(Node, 'IsEOM');
    SetBooleanPropertyFromNode(Node, 'IsEOMPlus');
    SetBooleanPropertyFromNode(Node, 'IsDays');
    SetPropertyFromNode(Node, 'ProgressPaymentDuration');
    SetPropertyFromNode(Node, 'ProgressPaymentDaysAfterfirstPay');
    SetBooleanPropertyFromNode(Node, 'ProgressPaymentInstallments');
    SetBooleanPropertyFromNode(Node, 'ISProgressPayment');
    SetPropertyFromNode(Node, 'Description');
    SetBooleanPropertyFromNode(Node, 'Required');
    SetBooleanPropertyFromNode(Node, 'PublishOnVS1');
    SetBooleanPropertyFromNode(Node, 'ProgressPaymentfirstPayonSaleDate');
    SetPropertyFromNode(Node, 'EarlyDiscountPercent');
    SetBooleanPropertyFromNode(Node, 'Active');
end;

{ TRelatedClients }

Function TRelatedClients.GetMasterClientID	: Integer	;
Begin
	Result :=  GetIntegerField('MasterClientID');
End;
Function TRelatedclients.GetMasterCompany	: String	;
Begin
	Result :=  GetStringField('MasterCompany');
End;
Function TRelatedclients.GetChildClientID	: Integer	;
Begin
	Result :=  GetIntegerField('ChildClientID');
End;
Function TRelatedclients.GetChildCompany	: String	;
Begin
	Result :=  GetStringField('ChildCompany');
End;
Procedure TRelatedclients.SetMasterClientID(Const Value: Integer);
Begin
	SetIntegerField('MasterClientID' , Value);
End;
Procedure TRelatedclients.SetMasterCompany(Const Value: String);
Begin
	SetStringField('MasterCompany' , Value);
End;
Procedure TRelatedclients.SetChildClientID(Const Value: Integer);
Begin
	SetIntegerField('ChildClientID' , Value);
End;
Procedure TRelatedclients.SetChildCompany(Const Value: String);
Begin
	SetStringField('ChildCompany' , Value);
End;

function  TRelatedclients.GetSQL:String ;
begin
    fSQL := 'Select * from tblrelatedclients';
    result := inherited GetSQL;
End;
class function  TRelatedclients.GetIDField :String;
begin
    REsult := 'RelatedClientID';
End;

class function TRelatedclients.GetBusObjectTablename: string;
begin
  Result := 'tblrelatedclients';
end;

Function  TRelatedclients.ValidateXMLData(Const Node :IXMLNode) :Boolean ;
begin
    Result := inherited ValidateXMLData(Node);
    if not Result then Exit;
    if not ImportingFromXMLFile then Exit;
    XMLSearchRecordDesc := 'MasterCompany='  + GetXMLNodeStringValue(Node, 'MasterCompany') +
                        ' and ChildCompany = ' + GetXMLNodeStringValue(Node, 'ChildCompany');
    Result := False;
    if not ForeignKeysValid(Node) then Exit;
    Result := true;
    XMLSearchRecord := 'MasterCompany='  + QuotedStr(GetXMLNodeStringValue(Node, 'MasterCompany')) + ' and ChildCompany = ' + QuotedSTr(GetXMLNodeStringValue(Node, 'ChildCompany'));
    LocateXMLRecord;
End;


Function  TRelatedclients.ForeignKeysValid(Const Node :IXMLNode):Boolean;
var
    fsXMLTag :String;
begin
    Result          := False;
    fiMasterClientID	            :=0;
    fiChildClientID	                :=0;

    fsXMLTag :='MasterCompany';
    if GetXMLNodeStringValue(Node, fsXMLTag) <>'' then begin
        fiMasterClientID := CheckClient(Self,Node, fsXMLTag);
        if  fiMasterClientID = 0 then begin
            ErrRecordNotfound(fsXMLTag , GetXMLNodeStringValue(Node, fsXMLTag));
            Exit;
        End;
    end;
    fsXMLTag :='ChildCompany';
    if GetXMLNodeStringValue(Node, fsXMLTag) <>'' then begin
        fiChildClientID := TClient.IDToggle(GetXMLNodeStringValue(Node, fsXMLTag), Connection.Connection);
        if  fiChildClientID = 0 then begin
            ErrRecordNotfound(fsXMLTag , GetXMLNodeStringValue(Node, fsXMLTag));
            Exit;
        End;
    end;
    Result := True;
end;

function TRelatedclients.ValidateData :Boolean ;
begin
    result := inherited ValidateData;
    if not result then Exit;
    Result := False;
    Resultstatus.Clear;
    if (MasterClientID = 0) or (MasterCompany = '') then begin
        AddResult(False, rssWarning, 0, 'Master client should not be blank' , False);
        Exit;
    end;
    if (ChildClientID = 0) or (ChildCompany = '') then begin
        AddResult(False, rssWarning, 0, 'Child Client should not be blank' , False);
        Exit;
    end;
    if MasterClientId = ChildClientID then begin
        AddResult(False, rssWarning, 0, 'Child and Master can not be the same Company' , False);
        Exit;
    end;
    Result := true;
end;

function TRelatedclients.Save :Boolean ;
begin
    Result := False;
    PostDB;
    if not ValidateData then Exit;
    Result := Inherited Save;
end;

procedure TRelatedclients.SaveToXMLNode(Const Node: IXMLNode);
begin
    inherited;
    if not SavingXMLTofile then begin
        if not IsOwnerclient(self) then
            AddXMLNode(Node , 'MasterClientID',MasterClientID)
        else AddXMLNode(Node , 'MasterClientID',TClient(Self.Owner).ID);
        AddXMLNode(Node , 'ChildClientID',ChildClientID);
    end;
    if not IsOwnerclient(self) then
        AddXMLNode(Node , 'MasterCompany',MasterCompany);
    AddXMLNode(Node , 'ChildCompany',ChildCompany);
end;

procedure TRelatedClients.LoadFromXMLNode(Const Node: IXMLNode);
begin
    inherited;
    if not ImportingFromXMLFile then begin
        fiMasterClientID	    := GetXMLNodeIntegerValue (Node, 'MasterClientID');
        fiChildClientID	        := GetXMLNodeIntegerValue (Node, 'ChildClientID');
    end else begin
        fiMasterClientID	    := CheckClient(Self,Node, 'MasterCompany');
        fiChildClientID	:= TClient.IDToggle(GetXMLNodeStringValue(Node, 'ChildCompany'), Connection.Connection);
    end;
    MasterClientID	:=fiMasterClientID;
    ChildClientID	:=fiChildClientID;
    if Self.Owner is TClient then
        MasterCompany	:= OwnerClientname(Self)
    else
    SetPropertyFromNode(Node, 'MasterCompany');
    SetPropertyFromNode(Node, 'ChildCompany');
end;

constructor TRelatedClients.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ExportExcludeList.Add('masterclientid');
  ExportExcludeList.Add('childclientid');
end;

procedure TRelatedClients.DoFieldOnChange(Sender: TField);

  procedure RemoveChildClient(aChildClientId: integer);
  var qry: TERPQuery;
  begin
    qry:= TERPQuery.Create(nil);
    try
      qry.Connection:= Connection.Connection;
      qry.SQL.Text:= 'update tblclients set ParentRelatedClientID = 0 ' +
        'where ClientId = ' + IntToStr(aChildClientId);
      qry.Execute;
    finally
      qry.Free;
    end;
  end;

  procedure UpdateChildClient;
  var qry: TERPQuery;
  begin
    if (ChildClientId = 0) or (MasterClientId = 0) then exit;
    qry:= TERPQuery.Create(nil);
    try
      qry.Connection:= Connection.Connection;
      qry.SQL.Text:= 'update tblclients set ParentRelatedClientID = ' +
        IntToStr(MasterClientId) +
        ' where ClientId = ' + IntToStr(ChildClientId);
      qry.Execute;
    finally
      qry.Free;
    end;
  end;

begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then Exit; // we are only interested in data fields.
  inherited;

  if Sysutils.SameText(Sender.FieldName, 'MasterClientID') then begin
    if Sender.AsInteger > 0 then
      MasterCompany:= FindClient(Sender.AsInteger)
    else
      MasterCompany:= '';
    if not RawMode then begin
      UpdateChildClient;
    end;
  end
  else if Sysutils.SameText(Sender.FieldName, 'MasterCompany') then begin
    if Sender.AsString <> '' then
      MasterClientID:= FindClient(Sender.AsString)
    else
      MasterClientID:= 0;
    if not RawMode then begin
      UpdateChildClient;
    end;
  end
  else if Sysutils.SameText(Sender.FieldName, 'ChildClientID') then begin
    if (not VarIsNull(Sender.OldValue)) and (Sender.NewValue <> Sender.OldValue) then
      RemoveChildClient(Sender.OldValue);
    if Sender.AsInteger > 0 then
      ChildCompany:= FindClient(Sender.AsInteger)
    else
      ChildCompany:= '';
    if not RawMode then begin
      UpdateChildClient;
    end;
  end
  else if Sysutils.SameText(Sender.FieldName, 'ChildCompany') then begin
    if ChildClientId <> 0 then
      RemoveChildClient(ChildClientId);
    if Sender.AsString <> '' then
      ChildClientID:= FindClient(Sender.AsString)
    else
      ChildClientID:= 0;
    if not RawMode then begin
      UpdateChildClient;
    end;
  end;
end;

function TRelatedClients.FindClient(const aClientId: integer): string;
begin
  result:= TClient.IDToggle(aClientId, Connection.Connection);
end;

function TRelatedClients.FindClient(const aClientName: string): integer;
begin
  result:= TClient.IDToggle(aClientName, Connection.Connection);
end;

{ TOtherFollowUps }

Function TOtherFollowUps.GetOtherContactID	: Integer	;
Begin
	Result :=  GetIntegerField('OtherContactID');
End;

Function TOtherFollowUps.GetRepairID	: Integer	;
Begin
	Result :=  GetIntegerField('RepairID');
End;

Function TOtherFollowUps.GetEmployeeID	: Integer	;
Begin
	Result :=  GetIntegerField('EmployeeID');
End;
Function TOtherFollowUps.GetClientID	: Integer	;
Begin
	Result :=  GetIntegerField('ClientID');
End;
Function TOtherFollowUps.GetFollowUpDate	: TDateTime	;
Begin
	Result :=  GetDateTimeField('FollowUpDate');
End;
Function TOtherFollowUps.GetNotes	: String	;
Begin
	Result :=  GetStringField('Notes');
End;
Function TOtherFollowUps.GetDone	: Boolean	;
Begin
	Result :=  GetBooleanField('Done');
End;
Function TOtherFollowUps.GetAppearDays	: Integer	;
Begin
	Result :=  GetIntegerField('AppearDays');
End;
Function TOtherFollowUps.GetCreationDate	: TDateTime	;
Begin
	Result :=  GetDateTimeField('CreationDate');
End;
Function TOtherFollowUps.GetUpdateDate	: TDateTime	;
Begin
	Result :=  GetDateTimeField('UpdateDate');
End;
Function TOtherFollowUps.GetIsSupplier	: Boolean	;
Begin
	Result :=  GetBooleanField('IsSupplier');
End;
Function TOtherFollowUps.GetIsOtherContact	: Boolean	;
Begin
	Result :=  GetBooleanField('IsOtherContact');
End;
Function TOtherFollowUps.GetIsCustomer	: Boolean	;
Begin
	Result :=  GetBooleanField('IsCustomer');
End;
function TOtherFollowUps.GetIsList: boolean;
begin
  result:= true;
end;

Function TOtherFollowUps.GetHours	: Double	;
Begin
	Result :=  GetFloatField('Hours');
End;
Function TOtherFollowUps.GetTypeId	: Integer	;
Begin
	Result :=  GetIntegerField('TypeId');
End;
Function TOtherFollowUps.GetResultTypeId	: Integer	;
Begin
	Result :=  GetIntegerField('ResultTypeId');
End;
Function TOtherFollowUps.GetIsPhoneFollowUp	: Boolean	;
Begin
	Result :=  GetBooleanField('IsPhoneFollowUp');
End;
function TOtherFollowUps.GetCustomerName: string;
begin
  if self.IsCustomer then
    result:= TCustomer.IDToggle(ClientID, Connection.Connection)
  else
    result:= '';
end;

Function TOtherFollowUps.GetCustomField1	: String	;
Begin
	Result :=  GetStringField('CustomField1');
End;
Function TOtherFollowUps.GetCustomField2	: String	;
Begin
	Result :=  GetStringField('CustomField2');
End;
Function TOtherFollowUps.GetCustomField3	: String	;
Begin
	Result :=  GetStringField('CustomField3');
End;
Function TOtherFollowUps.GetCustomField4	: String	;
Begin
	Result :=  GetStringField('CustomField4');
End;
Function TOtherFollowUps.GetCustomField5	: String	;
Begin
	Result :=  GetStringField('CustomField5');
End;
Function TOtherFollowUps.GetCustomField6	: String	;
Begin
	Result :=  GetStringField('CustomField6');
End;
Function TOtherFollowUps.GetCustomField7	: String	;
Begin
	Result :=  GetStringField('CustomField7');
End;
Function TOtherFollowUps.GetCustomField8	: String	;
Begin
	Result :=  GetStringField('CustomField8');
End;
Function TOtherFollowUps.GetCustomField9	: String	;
Begin
	Result :=  GetStringField('CustomField9');
End;
Function TOtherFollowUps.GetCustomField10	: String	;
Begin
	Result :=  GetStringField('CustomField10');
End;
function TOtherFollowUps.getLeadLineID: Integer;
begin
	Result :=  GetIntegerField('LeadLineID');
end;
Procedure TOtherFollowUps.SetOtherContactID(Const Value: Integer);
Begin
	SetIntegerField('OtherContactID' , Value);
End;

Procedure TOtherFollowUps.SetRepairID(Const Value: Integer);
Begin
	SetIntegerField('RepairID' , Value);
End;

Procedure TOtherFollowUps.SetEmployeeID(Const Value: Integer);
Begin
	SetIntegerField('EmployeeID' , Value);
End;
Procedure TOtherFollowUps.SetClientID(Const Value: Integer);
Begin
	SetIntegerField('ClientID' , Value);
End;
Procedure TOtherFollowUps.SetFollowUpDate(Const Value: TDateTime);
Begin
	SetDateTimeField('FollowUpDate' , Value);
End;
Procedure TOtherFollowUps.SetNotes(Const Value: String);
Begin
	SetStringField('Notes' , Value);
End;
Procedure TOtherFollowUps.SetDone(Const Value: Boolean);
Begin
	SetBooleanField('Done' , Value);
End;
Procedure TOtherFollowUps.SetAppearDays(Const Value: Integer);
Begin
	SetIntegerField('AppearDays' , Value);
End;
Procedure TOtherFollowUps.SetCreationDate(Const Value: TDateTime);
Begin
	SetDateTimeField('CreationDate' , Value);
End;
Procedure TOtherFollowUps.SetUpdateDate(Const Value: TDateTime);
Begin
	SetDateTimeField('UpdateDate' , Value);
End;
Procedure TOtherFollowUps.SetIsSupplier(Const Value: Boolean);
Begin
	SetBooleanField('IsSupplier' , Value);
End;
Procedure TOtherFollowUps.SetIsOtherContact(Const Value: Boolean);
Begin
	SetBooleanField('IsOtherContact' , Value);
End;
Procedure TOtherFollowUps.SetIsCustomer(Const Value: Boolean);
Begin
	SetBooleanField('IsCustomer' , Value);
End;
Procedure TOtherFollowUps.SetHours(Const Value: Double);
Begin
	SetFloatField('Hours' , Value);
End;
Procedure TOtherFollowUps.SetTypeId(Const Value: Integer);
Begin
	SetIntegerField('TypeId' , Value);
End;
Procedure TOtherFollowUps.SetResultTypeId(Const Value: Integer);
Begin
	SetIntegerField('ResultTypeId' , Value);
End;
Procedure TOtherFollowUps.SetIsPhoneFollowUp(Const Value: Boolean);
Begin
	SetBooleanField('IsPhoneFollowUp' , Value);
End;

procedure TOtherFollowUps.SetCustomerName(const Value: string);
begin
  IsCustomer:= true;
  IsSupplier:= false;
  IsOtherContact:= false;
  ClientID:= TCustomer.IDToggle(Value,Connection.Connection);
  if TCustomer.ClientIsOtherCotact(Value,Connection.Connection) then
    OtherContactID:= ClientID
  else
    OtherContactID:= 0;
end;

Procedure TOtherFollowUps.SetCustomField1(Const Value: String);
Begin
	SetStringField('CustomField1' , Value);
End;
Procedure TOtherFollowUps.SetCustomField2(Const Value: String);
Begin
	SetStringField('CustomField2' , Value);
End;
Procedure TOtherFollowUps.SetCustomField3(Const Value: String);
Begin
	SetStringField('CustomField3' , Value);
End;
Procedure TOtherFollowUps.SetCustomField4(Const Value: String);
Begin
	SetStringField('CustomField4' , Value);
End;
Procedure TOtherFollowUps.SetCustomField5(Const Value: String);
Begin
	SetStringField('CustomField5' , Value);
End;
Procedure TOtherFollowUps.SetCustomField6(Const Value: String);
Begin
	SetStringField('CustomField6' , Value);
End;
Procedure TOtherFollowUps.SetCustomField7(Const Value: String);
Begin
	SetStringField('CustomField7' , Value);
End;
Procedure TOtherFollowUps.SetCustomField8(Const Value: String);
Begin
	SetStringField('CustomField8' , Value);
End;
Procedure TOtherFollowUps.SetCustomField9(Const Value: String);
Begin
	SetStringField('CustomField9' , Value);
End;
Procedure TOtherFollowUps.SetCustomField10(Const Value: String);
Begin
	SetStringField('CustomField10' , Value);
End;
procedure TOtherFollowUps.SetLeadLineID(const Value: Integer);
begin
	SetIntegerField('LeadLineID' , Value);
end;
function  TOtherFollowUps.GetSQL:String ;
begin
    fSQL := 'Select * from tblotherfollowup';
    result := inherited GetSQL;
End;
function TOtherFollowUps.GetSupplierName: string;
begin
  if self.IsSupplier then
    result:= TSupplier.IDToggle(ClientID, Connection.Connection)
  else
    result:= '';
end;

class function  TOtherFollowUps.GetIDField :String;
begin
    REsult := 'FollowUpID';
End;

class function TOtherFollowUps.GetBusObjectTablename: string;
begin
  Result := 'tblotherfollowup';
end;

Function  TOtherFollowUps.ForeignKeysValid(Const Node :IXMLNode):Boolean;
var
    fsXMLTag : String;
begin
    Result := False;
    fiOtherContactID:= 0;
//    fiRepairID      := 0;
    fiEmployeeID    := 0;
    fiClientID      := 0;
    fiTypeId        := 0;
    fiResultTypeId  := 0;
    fsXMLTag :='OtherContact';
    if GetXMLNodeStringValue(Node,fsXMLTag ) <> '' then begin
        fiOtherContactID:= CheckClient(Self,Node, fsXMLTag);
        if fiOtherContactID = 0 then begin
            ErrRecordNotfound(fsXMLTag , GetXMLNodeStringValue(Node, fsXMLTag));
            Exit;
        end;
    end;
//    fsXMLTag :='Repair';
//    if GetXMLNodeStringValue(Node,fsXMLTag ) <> '' then begin
//        fiRepairID:= tcdataUtils.getRepairId(GetXMLNodeStringValue(Node, fsXMLTag));
//        if fiRepairID = 0 then begin
//            ErrRecordNotfound(fsXMLTag , GetXMLNodeStringValue(Node, fsXMLTag));
//            Exit;
//        end;
//    end;
    fsXMLTag :='Employee';
    if GetXMLNodeStringValue(Node,fsXMLTag ) <> '' then begin
        fiEmployeeID:= tcdataUtils.getEmployeeID(GetXMLNodeStringValue(Node, fsXMLTag));
        if fiEmployeeID = 0 then begin
            ErrRecordNotfound(fsXMLTag , GetXMLNodeStringValue(Node, fsXMLTag));
            Exit;
        end;
    end;
    fsXMLTag :='Client';
    if GetXMLNodeStringValue(Node,fsXMLTag ) <> '' then begin
        fiClientID:= CheckClient(Self,Node, fsXMLTag);
        if fiClientID = 0 then begin
            ErrRecordNotfound(fsXMLTag , GetXMLNodeStringValue(Node, fsXMLTag));
            Exit;
        end;
    end;
    fsXMLTag :='Type';
    if GetXMLNodeStringValue(Node,fsXMLTag ) <> '' then begin
//        fitypeID:= tcdataUtils.getSimpletype(GetXMLNodeStringValue(Node, fsXMLTag) , SimpleTypes_FollowUpType);
        fitypeID:= TFollowUpType.IDToggle(GetXMLNodeStringValue(Node,fsXMLTag),self.Connection.Connection);
        if fiClientID = 0 then begin
            ErrRecordNotfound(fsXMLTag , GetXMLNodeStringValue(Node, fsXMLTag));
            Exit;
        end;
    end;
    fsXMLTag :='ResultType';
    if GetXMLNodeStringValue(Node,fsXMLTag) <> '' then begin
//        fiResultTypeID:= tcdataUtils.getSimpletype(GetXMLNodeStringValue(Node, fsXMLTag) , SimpleTypes_FollowUpResultType);
        fiResultTypeId:= TFollowUpResultType.IDToggle(GetXMLNodeStringValue(Node,fsXMLTag), self.Connection.Connection);
        if fiResultTypeID = 0 then begin
            ErrRecordNotfound(fsXMLTag , GetXMLNodeStringValue(Node, fsXMLTag));
            Exit;
        end;
    end;
end;
Function  TOtherFollowUps.ValidateXMLData(Const Node :IXMLNode) :Boolean ;
begin
    Result := inherited ValidateXMLData(Node);

    if not Result then Exit;
    if not ImportingFromXMLFile then Exit;

    if GetXMLNodeStringValue(Node, 'Othercontact') <> '' then
        XMLSearchRecordDesc := 'OtherContact='  + GetXMLNodeStringValue(Node, 'Othercontact')
//    else if GetXMLNodeStringValue(Node, 'Repair') <> '' then
//        XMLSearchRecordDesc := 'Repair='  + GetXMLNodeStringValue(Node, 'Repair')
    else if GetXMLNodeStringValue(Node, 'Employee') <> '' then
        XMLSearchRecordDesc := 'Employee='  + GetXMLNodeStringValue(Node, 'Employee')
    else if GetXMLNodeStringValue(Node, 'Client') <> '' then
        XMLSearchRecordDesc := 'Client='  + GetXMLNodeStringValue(Node, 'Client');
    if XMLSearchRecordDesc <> '' then XMLSearchRecordDesc := XMLSearchRecordDesc + ' and ';
    XMLSearchRecordDesc := XMLSearchRecordDesc + 'FollowUpDate = ' + QuotedStr(FormatDateTime(MysqlDateFormat , GetXMLNodeDatetimeValue(Node, 'FollowUpDate')));

    Result := False;
    if not ForeignKeysValid(Node) then Exit;
    Result := true;
    XMLSearchRecord := '';
    if GetXMLNodeStringValue(Node, 'Othercontact') <> '' then
        XMLSearchRecord := 'OtherContactID='  + IntToStr(CheckClient(Self,Node, 'Othercontact'))
//    else if GetXMLNodeStringValue(Node, 'Repair') <> '' then
//        XMLSearchRecord := 'RepairID='  + IntToStr(tcdatautils.getRepairID(GetXMLNodeStringValue(Node, 'Repair')))
    else if GetXMLNodeStringValue(Node, 'Employee') <> '' then
        XMLSearchRecord := 'EmployeeID='  + IntToStr(tcdatautils.getEmployeeId(GetXMLNodeStringValue(Node, 'Employee')))
    else if GetXMLNodeStringValue(Node, 'Client') <> '' then
        XMLSearchRecord := 'ClientID='  + IntToStr(CheckClient(Self, Node, 'Client'));
    if XMLSearchRecord <> '' then XMLSearchRecord := XMLSearchRecord + ' and ';
    XMLSearchRecord := XMLSearchRecord + 'FollowUpDate = ' + QuotedStr(FormatDateTime(MysqlDateFormat , GetXMLNodeDatetimeValue(Node, 'FollowUpDate')));
    LocateXMLRecord;
End;

class function TOtherFollowUps._Schema: string;
begin
  result:= inherited;
//  TBOSchema.AddRefType(result,'TOtherContact','OtherContactObj','OtherContactName','ClientName');
//  TBOSchema.AddRefType(result,'TSupplier','SupplierObj','SupplierName','ClientName');
//  TBOSchema.AddRefType(result,'TCustomer','CustomerObj','CustomerName','ClientName');
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','EmployeeID','ID');
  TBOSchema.AddRefType(result,'TEmployee','EmployeeObj','EmployeeName','EmployeeName');
  TBOSchema.AddRefType(result,'TFollowUpType','FollowUpTypeObj','TypeID','ID');
  TBOSchema.AddRefType(result,'TFollowUpType','FollowUpTypeObj','TypeName','TypeName');
  TBOSchema.AddRefType(result,'TFollowUpResultType','FollowUpResultTypeObj','ResultTypeID','ID');
  TBOSchema.AddRefType(result,'TFollowUpResultType','FollowUpResultTypeObj','ResultTypeName','TypeName');



end;

function TOtherFollowUps.ValidateData :Boolean ;
begin
    result := inherited ValidateData;
    if not result then Exit;
    Result := False;
    Resultstatus.Clear;
    if FollowUpDate = 0 then begin
        AddResult(False , rssWarning , 0,  'Followup date should not be blank' , True );
        Exit;
    end;
    if (OtherContactID = 0 ) {and (RepairID=0)} and (EmployeeID = 0) and (ClientID = 0) then begin
        AddResult(False , rssWarning , 0,  'Followup reference should not be blank (Other Contacts/Employee/Customer)' , True );
        Exit;
    end;
    if (LeadLineId > 0) then begin
      if not CommonDbLib.RecordForIdExists(TLeadLines.GetBusObjectTablename,LeadLineId) then begin
        AddResult(False, rssWarning, 0, 'No Lead Line found for specified LeadLineId', True);
        Exit;
      end;
    end;
    Result := true;
end;

function    TOtherFollowUps.Save :Boolean ;
begin
    Result := False;
    PostDB;
    if not ValidateData then Exit;
    Result := Inherited Save;
end;

procedure   TOtherFollowUps.SaveToXMLNode(Const Node: IXMLNode);
begin
    inherited;
    if not SavingXMLTofile then begin
        AddXMLNode(Node , 'OtherContactID'  ,OtherContactID);
//        AddXMLNode(Node , 'RepairID'        ,RepairID);
        AddXMLNode(Node , 'EmployeeID'      ,EmployeeID);
        AddXMLNode(Node , 'ClientID'        ,ClientID);
        AddXMLNode(Node , 'ResultTypeId'    ,ResultTypeId);
        AddXMLNode(Node , 'TypeId'          ,TypeId);
    end else begin
        if not IsOwnerclient(self) then
            AddXMLNode(Node , 'Othercontact'    , tcDatautils.getClientName(OtherContactID));
//        AddXMLNode(Node , 'Repair'          , tcDatautils.getrepairGlobalref(RepairID));
        AddXMLNode(Node , 'Employee'        , tcDatautils.getemployeeName(EmployeeId));
        if not IsOwnerclient(self) then
            AddXMLNode(Node , 'Client'          , tcDatautils.getClientName(clientID));
        AddXMLNode(Node , 'Resulttype'      , tcDatautils.GetSimpleType(ResultTypeId));
        AddXMLNode(Node , 'Type'            , tcDatautils.GetSimpleType(TypeId));
    end;
    AddXMLNode(Node , 'FollowUpDate'        ,FollowUpDate);
    AddXMLNode(Node , 'Notes'               ,Notes);
    AddXMLNode(Node , 'Done'                ,Done);
    AddXMLNode(Node , 'AppearDays'          ,AppearDays);
    AddXMLNode(Node , 'CreationDate'        ,CreationDate);
    AddXMLNode(Node , 'UpdateDate'          ,UpdateDate);
    AddXMLNode(Node , 'IsSupplier'          ,IsSupplier);
    AddXMLNode(Node , 'IsOtherContact'      ,IsOtherContact);
    AddXMLNode(Node , 'IsCustomer'          ,IsCustomer);
    AddXMLNode(Node , 'Hours'               ,Hours);
    AddXMLNode(Node , 'IsPhoneFollowUp'     ,IsPhoneFollowUp);
    AddXMLNode(Node , 'CUSTFLD1'        ,CUSTFLD1);
    AddXMLNode(Node , 'CUSTFLD2'        ,CUSTFLD2);
    AddXMLNode(Node , 'CUSTFLD3'        ,CUSTFLD3);
    AddXMLNode(Node , 'CUSTFLD4'        ,CUSTFLD4);
    AddXMLNode(Node , 'CUSTFLD5'        ,CUSTFLD5);
    AddXMLNode(Node , 'CUSTFLD6'        ,CUSTFLD6);
    AddXMLNode(Node , 'CUSTFLD7'        ,CUSTFLD7);
    AddXMLNode(Node , 'CUSTFLD8'        ,CUSTFLD8);
    AddXMLNode(Node , 'CUSTFLD9'        ,CUSTFLD9);
    AddXMLNode(Node , 'CUSTFLD10'       ,CUSTFLD10);

end;
procedure   TOtherFollowUps.LoadFromXMLNode(Const Node: IXMLNode);
begin
    inherited;
    if not ImportingFromXMLFile then begin
        fiOtherContactID:= GetXMLNodeIntegerValue(Node, 'OtherContactID');
//        fiRepairID      := GetXMLNodeIntegerValue(Node, 'RepairID');
        fiEmployeeID    := GetXMLNodeIntegerValue(Node, 'EmployeeID');
        fiClientID      := GetXMLNodeIntegerValue(Node, 'ClientID');
        fiTypeId        := GetXMLNodeIntegerValue(Node, 'TypeId');
        fiResultTypeId  := GetXMLNodeIntegerValue(Node, 'ResultTypeId');
    end else begin
        fiOtherContactID:= CheckClient(Self, Node, 'OtherContact');
//        fiRepairID      := tcdataUtils.getRepairID(GetXMLNodeStringValue(Node, 'Repair'));
        fiEmployeeID    := tcdataUtils.GetEmployeeID(GetXMLNodeStringValue(Node, 'Employee'));
        fiClientID      := CheckClient(Self, Node, 'Client');
//        fiTypeId        := tcdataUtils.getSimpletype(GetXMLNodeStringValue(Node, 'Type') , SimpleTypes_FollowUpType);
//        fiResultTypeId  := tcdataUtils.getSimpletype(GetXMLNodeStringValue(Node, 'ResultType') , SimpleTypes_FollowUpResultType);
        fiTypeId        := TFollowUpType.IDToggle(GetXMLNodeStringValue(Node, 'Type'),self.Connection.Connection);
        fiResultTypeId  := TFollowUpResultType.IDToggle(GetXMLNodeStringValue(Node, 'ResultType'),self.Connection.Connection);
    end;
    OtherContactID      := fiOtherContactID;
//    RepairID            := fiRepairID;
    EmployeeID          := fiEmployeeID;
    ClientID            := fiClientID;
    TypeId              := fiTypeId;
    ResultTypeId        := fiResultTypeId;
    SetDateTimePropertyFromNode(Node, 'FollowUpDate');
    SetPropertyFromNode(Node, 'Notes');
    SetBooleanPropertyFromNode(Node, 'Done');
    SetPropertyFromNode(Node, 'AppearDays');
    SetDateTimePropertyFromNode(Node, 'CreationDate');
    SetDateTimePropertyFromNode(Node, 'UpdateDate');
    SetBooleanPropertyFromNode(Node, 'IsSupplier');
    SetBooleanPropertyFromNode(Node, 'IsOtherContact');
    SetBooleanPropertyFromNode(Node, 'IsCustomer');
    SetPropertyFromNode(Node, 'Hours');
    SetBooleanPropertyFromNode(Node, 'IsPhoneFollowUp');
    SetPropertyFromNode(Node, 'CUSTFLD1');
    SetPropertyFromNode(Node, 'CUSTFLD2');
    SetPropertyFromNode(Node, 'CUSTFLD3');
    SetPropertyFromNode(Node, 'CUSTFLD4');
    SetPropertyFromNode(Node, 'CUSTFLD5');
    SetPropertyFromNode(Node, 'CUSTFLD6');
    SetPropertyFromNode(Node, 'CUSTFLD7');
    SetPropertyFromNode(Node, 'CUSTFLD8');
    SetPropertyFromNode(Node, 'CUSTFLD9');
    SetPropertyFromNode(Node, 'CUSTFLD10');
end;
  //------------------------------------------------------------------------------
  { TProductGroupDiscount }
  //------------------------------------------------------------------------------
Function TProductGroupDiscount.getClientID:Integer;
begin
    Result := getIntegerField('ClientID');
End;
Function TProductGroupDiscount.getCol1:String;
begin
    Result := getStringField('Col1');
End;
Function TProductGroupDiscount.getCol2:String;
begin
    Result := getStringField('Col2');
End;
Function TProductGroupDiscount.getCol3:String;
begin
    Result := getStringField('Col3');
End;
Function TProductGroupDiscount.getDiscount:Double;
begin
    Result := getFloatfield('Discount');
End;

Procedure TProductGroupDiscount.SetClientID(Const Value :Integer	);
begin
    SetIntegerField('ClientID' , Value);
End;
Procedure TProductGroupDiscount.SetCol1(Const Value :String	);
begin
    SetStringField('Col1' , Value);
End;
Procedure TProductGroupDiscount.SetCol2(Const Value :String	);
begin
    SetStringField('Col2' , Value);
End;
Procedure TProductGroupDiscount.SetCol3(Const Value :String	);
begin
    SetStringField('Col3' , Value);
End;
Procedure TProductGroupDiscount.SetDiscount(Const Value :Double	);
begin
    SetFloatfield('Discount' , Value);
End;

procedure TProductGroupDiscount.SetMustMatch(const Value: boolean);
begin
  SetBooleanField('MustMatch',Value);
end;

function TProductGroupDiscount.ValidateData :Boolean ;
begin
    result := inherited ValidateData;
    if not result then Exit;
    Result := False;
    if Discount = 0 then begin
        AddResult(False , rssWarning , 0 , 'Discount should not be blank' , True);
        Exit;
    end;
    if (col1 = '') and (col2 = '') and (col3 = '') then begin
        AddResult(False, rssWarning , 0 , 'One of the 3 descriptive fields - ' + AppEnv.DefaultClass.FirstColumn+', ' +AppEnv.DefaultClass.Secondcolumn + ' or ' + AppEnv.DefaultClass.thirdcolumn + ' should have a value');
        Exit;
    end;
    if clientId = 0 then begin
        AddResult(False , rssWarning , 0 , 'Customer should not be blank');
        Exit;
    end;
    if (col1 <> '') and (not ProductColsExists(col1, 1)) then begin
        AddResult(False, rssWarning, 0, 'No products found for "' +
          AppEnv.DefaultClass.FirstColumn + '" with value "' + col1 + '" for Customer "' + CustomerName + '"');
        Exit;
    end;
    if (col2 <> '') and (not ProductColsExists(col2, 2)) then begin
        AddResult(False, rssWarning, 0, 'No products found for "' +
          AppEnv.DefaultClass.SecondColumn + '" with value "' + col2 + '" for Customer "' + CustomerName + '"');
        Exit;
    end;
    if (col3 <> '') and (not ProductColsExists(col3, 3)) then begin
        AddResult(False, rssWarning, 0, 'No products found for "' +
          AppEnv.DefaultClass.ThirdColumn + '" with value "' + col3 + '" for Customer "' + CustomerName + '"');
        Exit;
    end;

    Result := True;
end;
function    TProductGroupDiscount.Save :Boolean ;
Begin
    Result := False;
    PostDB;
    if not ValidateData then Exit;
    Result := inherited Save;
End;
procedure   TProductGroupDiscount.SaveToXMLNode(Const Node: IXMLNode);
Begin
    Inherited;
    AddXMLNode(Node , 'Col1',Col1);
    AddXMLNode(Node , 'Col2',Col2);
    AddXMLNode(Node , 'Col3',Col3);
    AddXMLNode(Node , 'Discount',Discount);
    if not IsOwnerclient(self) then
        AddXMLNode(Node , 'ClientName',tcDatautils.GetclientName(ClientID));
    ExportsubClasses(Node);
End;
procedure   TProductGroupDiscount.LoadFromXMLNode(Const Node: IXMLNode);
Begin
    inherited;
    if not ImportingFromXMLFile then
        ficlientID	        := GetXMLNodeIntegerValue (Node, 'ClientID')
    else
        fiClientID		    := CheckClient(Self, Node, 'ClientName');
    clientId :=fiClientID;
    SetPropertyFromNode(Node , 'col1');
    SetPropertyFromNode(Node , 'col2');
    SetPropertyFromNode(Node , 'col3');
    SetPropertyFromNode(Node , 'Discount');
End;
function  TProductGroupDiscount.GetSQL:String ;
Begin
    fSQL := 'select * from tblProdGroupdiscs';
    Result := inherited GetSQL;
End;
class function  TProductGroupDiscount.GetIDField :String;
Begin
    Result := 'GrpDiscID';
End;

function TProductGroupDiscount.GetIsList: boolean;
begin
  result:= true;
end;

function TProductGroupDiscount.GetMustMatch: boolean;
begin
  result := GetBooleanField('MustMatch');
end;

class function TProductGroupDiscount.GetBusObjectTablename: string;
begin
  Result := 'tblProdGroupdiscs';
end;

Function  TProductGroupDiscount.ValidateXMLData(Const Node :IXMLNode) :Boolean ;
Begin
    Result := inherited ValidateXMLData(Node);
    if not Result then Exit;
    if not ImportingFromXMLFile then Exit;
    XMLSearchRecordDesc :=  ' Col1 = '  + GetXMLNodeStringValue(Node, 'Col1') +
                        ' and Col2 = ' + GetXMLNodeStringValue(Node, 'Col2') +
                        ' and Col3 = ' + GetXMLNodeStringValue(Node, 'Col3');
    Result := False;
    if not ForeignKeysValid(Node) then Exit;
    Result := true;
    XMLSearchRecord :=  ' Col1 = '  + QuotedStr(GetXMLNodeStringValue(Node, 'Col1')) +
                        ' and Col2 = ' + QuotedSTr(GetXMLNodeStringValue(Node, 'Col2')) +
                        ' and Col3 = ' + QuotedSTr(GetXMLNodeStringValue(Node, 'Col3'));
    LocateXMLRecord;
End;
class function TProductGroupDiscount._Schema: string;
begin
  result:= inherited;
end;

function TProductGroupDiscount.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterPost(Sender);
  if not result then exit;
  if (Col1 = '') and (Col2 = '') and (Col3 = '') and (Discount = 0) then begin
    self.Delete;
  end;
end;

function TProductGroupDiscount.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited;
end;

Function  TProductGroupDiscount.ExportsubClasses(Const Node: IXMLNode):Boolean;
Begin
    Result := True;
End;
Function  TProductGroupDiscount.ImportsubClasses(Const node: IXMLNode):Boolean;
Begin
    REsult := True;
End;
Function  TProductGroupDiscount.ForeignKeysValid(Const Node :IXMLNode):Boolean;
var
    fsXMLTag:String;
Begin
    Result          := False;
    ficlientId	    :=0;
    fsXMLTag :='ClientName';
    if GetXMLNodeStringValue(Node, fsXMLTag) <>'' then begin
        ficlientId := CheckClient(Self,Node, fsXMLTag);
        if  ficlientId = 0 then begin
            ErrRecordNotfound(fsXMLTag , GetXMLNodeStringValue(Node, fsXMLTag));
            Exit;
        End;
    end;
    Result := True;
End;

  { TSpecialProducts }

  class function TSpecialProducts.GetKeyStringProperty: string;
begin
  result:= '';
end;
Function TSpecialProducts.getCustomerId:Integer	;Begin    Result := getIntegerField('CustomerId');End;
Function TSpecialProducts.GetProductID:Integer	;Begin    Result := getIntegerField('ProductID');End;
Function TSpecialProducts.getProductName:String	;Begin    Result := getStringField('Name');End;
Function TSpecialProducts.getDescription:String	;Begin    Result := getStringField('Description');End;
Function TSpecialProducts.getOrigPrice:Double	;begin    Result := getfloatfield('OrigPrice');End;
Function TSpecialProducts.getLinePrice:Double	; Begin    Result := getfloatfield('LinePrice');End;
Function TSpecialProducts.getIncludeInRun:Boolean	;Begin    Result := getBooleanField('IncludeInRun');End;
function TSpecialProducts.GetIsList: boolean;begin  result:= true;end;
function TSpecialProducts.getDateFrom: TDatetime;begin  Result := GetDatetimefield('Datefrom');end;
function TSpecialProducts.getDateTo: TDatetime;begin  Result := GetDatetimefield('DateTo');end;
Function TSpecialProducts.getUOMID:Integer	;Begin    Result := getIntegerField('UOMID');End;
Function TSpecialProducts.getUOM:String	;Begin    Result := getStringField('UOM');End;
Function TSpecialProducts.getUOMMultiplier:Double	;Begin    Result := getfloatfield('UOMMultiplier');End;


Procedure  TSpecialProducts.SetCustomerId(Const Value : Integer); Begin    SetIntegerField('CustomerId' , Value);End;
Procedure  TSpecialProducts.SetProductID(Const Value : Integer);Begin    SetIntegerField('ProductID' , Value);End;
Procedure  TSpecialProducts.SetSpecialProductName(Const Value : String);Begin    SetStringField('Name' , Value);End;
Procedure  TSpecialProducts.SetDescription(Const Value : String);Begin    SetStringField('Description' , Value);End;
Procedure  TSpecialProducts.SetOrigPrice(Const Value : Double);Begin    Setfloatfield('OrigPrice' , Value);End;
Procedure  TSpecialProducts.SetLinePrice(Const Value : Double);Begin    Setfloatfield('LinePrice' , Value);End;
Procedure  TSpecialProducts.SetIncludeInRun(Const Value : Boolean);Begin    SetBooleanField('IncludeInRun' , Value);End;
procedure TSpecialProducts.setDateFrom(const Value: TDatetime);begin  SetDAteTimefield('dateFrom' , Value);end;
procedure TSpecialProducts.setDateTo(const Value: TDatetime);begin  SetDAteTimefield('DateTo' , Value);end;
Procedure  TSpecialProducts.SetUOMID(Const Value : Integer);Begin    SetIntegerField('UOMID' , Value);End;
Procedure  TSpecialProducts.SetUOM(Const Value : String);Begin    SetStringField('UOM' , Value);End;
Procedure  TSpecialProducts.SetUOMMultiplier(Const Value : Double);Begin    Setfloatfield('UOMMultiplier' , Value);End;

function  TSpecialProducts.GetSQL:String ;
begin
    result := inherited GetSQL;
End;
class function  TSpecialProducts.GetIDField :String;
begin
    REsult := 'CustomerLinesID';
End;

class function TSpecialProducts.GetBusObjectTablename: string;
begin
  Result := 'tblCustomerLines';
end;

Function  TSpecialProducts.ValidateXMLData(Const Node :IXMLNode) :Boolean ;
begin
    Result := inherited ValidateXMLData(Node);

    if not Result then Exit;
    if not ImportingFromXMLFile then Exit;
    XMLSearchRecordDesc := 'Product = '  + GetXMLNodeStringValue(Node, 'Product') +
                ' and Customer = ' + GetXMLClientNAme(Self,Node, 'ClientName');
    Result := False;
    if not ForeignKeysValid(Node) then Exit;
    Result := true;
    XMLSearchRecord := 'ProductID = '  + IntToStr(tcDataUtils.GetProduct(GetXMLNodeStringValue(Node, 'Product'))) +
                ' and CustomerId = ' + IntToStr(CheckClient(Self,Node, 'ClientName'));
    LocateXMLRecord;
End;
class function TSpecialProducts._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TProductWeb','ProductObj','ProductID','ID');
  TBOSchema.AddRefType(result,'TProductWeb','ProductObj','Name','ProductName');
end;
class function TSpecialProducts.SepcialPriceID(const aID, aCustomerId,aProductId, aUOMID: Integer; const aDateFrom, aDateTo: TDatetime;Conn: TCustomMyConnection): Integer;
var
  qry: TMyQuery;
begin
  qry := TMyQuery.Create(nil);
  try
    if Assigned(Conn) then qry.Connection := Conn
    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('Select * from tblCustomerLines');
    qry.SQL.Add('where CustomerLinesID <> ' + IntToStr(aID));
    qry.SQL.Add('and CustomerId = ' + IntToStr(aCustomerId));
    if aProductId > 0 then qry.SQL.Add('and ProductID = ' + IntToStr(aProductID));
    if aUOMId     > 0 then qry.SQL.Add('and UOMID = '     + IntToStr(aUOMId));
    if aDateFrom  > 0 then qry.SQL.Add('and DateFrom = '  + QuotedStr(FormatDateTime(MysqlDateFormat, aDateFrom))) else qry.SQL.Add('and IsNull(DateFrom)');
    if aDateTo    > 0 then qry.SQL.Add('and DateTo = '    + QuotedStr(FormatDateTime(MysqlDateFormat, aDateTo)))   else qry.SQL.Add('and IsNull(DateTo)');
    qry.Open;
    Result := qry.fieldbyname('CustomerLinesID').AsInteger;
  finally qry.Free;
  end;
end;

Function  TSpecialProducts.ExportsubClasses(Const Node: IXMLNode):Boolean;
begin
    Result := true;
End;
Function  TSpecialProducts.ImportsubClasses(Const node: IXMLNode):Boolean;
begin
    Result := true;
end;
function TSpecialProducts.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited;
  if Assigned(Owner) and (Owner is TProduct) then
    self.ProductID:= TProduct(Owner).ID
  else if Assigned(Owner) and (Owner is TCustomer) then
    self.CustomerID:= TCustomer(Owner).ID;
end;

function TSpecialProducts.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoBeforePost(Sender);
end;

procedure TSpecialProducts.DoFieldOnChange(Sender: TField);

function Product: TProduct;
var
  s: string;
  s1: string;
begin
  if ID = 0 then PostDb; // BJ: this is to get the id if in insert mode
  if Self.ProductName <> '' then begin
    s := 'PartName = ' + Quotedstr(StringDataForSQL(ProductName));
    s1 := 'PARTSID = ' + inttostr(Self.ProductID);
    Result := TProduct(getContainerComponent(TProduct, ProductName,'PartName' ,  Self.SilentMode, False, True, s1, True));
  end else begin
    s := 'PARTSID = ' + inttostr(Self.ProductID);
    s1 := 'PartName = ' + Quotedstr(StringDataForSQL(ProductName));
    Result := TProduct(getContainerComponent(TProduct, ProductID,'PARTSID' ,  Self.SilentMode, False, True, s1, True));
  end;
end;

Procedure DoOnProductChange;
begin
  with Product do begin
    Description	  := SalesDescription;
    OrigPrice	    := SellQty1Price;
    LinePrice	    := SellQty1Price;
  end;
end;


begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;

  if SameText(Sender.fieldname, 'ProductID')  then begin
      if ProductID > 0 then self.ProductName := TProduct.IDToggle(ProductID, Connection.Connection);
      DoOnProductChange;
  end else if SameText(Sender.fieldname, 'name')  then begin
      if ProductName <> '' then self.ProductID := TProduct.IDToggle(ProductName, Connection.Connection);
      DoOnProductChange;
  end else if SameText(Sender.fieldname , 'UOM') then begin
    UOMID :=tcdatautils.getUOMID(UOM, ProductID);
    with Product do begin
      if ProductUOMLocate(UOM)  then begin
        Self.UOMMultiplier := UOMList.Multiplier;
        Self.UOMID := UOMList.ID;
        Self.UOM := UOMList.UOMName;
        SendEvent(BusObjEvent_Change, BusObjEventVal_uomChanged, self);
      end;
    end;
  end else if sametext(Sender.fieldname, 'UOMID') then begin
    UOM	        := tcdatautils.GetUOMName(UOMID);
    DoFieldOnChange(dataset.findfield('uom'));

  end;
end;
Function    TSpecialProducts.ForeignKeysValid(Const Node :IXMLNode):Boolean;
var
    fsXMLTag :String;
begin
    Result := False;
    fiProductID := 0;
    fsXMLTag :='Product';
    if GetXMLNodeStringValue(Node, fsXMLTag) <>'' then begin
        fiProductId := tcDataUtils.getproduct(GetXMLNodeStringValue(Node, fsXMLTag));
        if  fiProductID = 0 then begin
            ErrRecordNotfound(fsXMLTag , GetXMLNodeStringValue(Node, fsXMLTag));
            Exit;
        End;
    end;
    ficustomerId := 0;
    fsXMLTag :='ClientName';
    if GetXMLNodeStringValue(Node, fsXMLTag) <>'' then begin
        ficustomerId := CheckClient(Self,Node, 'ClientName');
        if  ficustomerId = 0 then begin
            ErrRecordNotfound(fsXMLTag , GetXMLNodeStringValue(Node, fsXMLTag));
            Exit;
        End;
    end;
    result:= True;
end;

function TSpecialProducts.ValidateData :Boolean ;
begin
    result := inherited ValidateData;
    if not result then Exit;
    Result := False;
    Resultstatus.Clear;
    if ProductID = 0 then begin
        AddResult(False , rssWarning , 0,  'Product should not be blank' , True );
        Exit;
    end;
    if customerId = 0 then begin
        AddResult(False , rssWarning , 0,  'Customer should not be blank' , True );
        Exit;
    end;
    Result := true;
end;

function TSpecialProducts.Save :Boolean ;
begin
  result:= ValidateData;
  if not result then exit;
  result:= Inherited Save;
end;

procedure   TSpecialProducts.SaveToXMLNode(Const Node: IXMLNode);
begin
    inherited;
    if not SavingXMLTofile then begin
        AddXMLNode(Node , 'ProductID'   , ProductID);
        if not IsOwnerClient(Self) then
            AddXMLNode(Node , 'CustomerID'   , CustomerID);
    end else begin
        //AddXMLNode(Node , 'Product'   , tcDatautils.getProduct(ProductID));
        if not IsOwnerClient(Self) then
            AddXMLNode(Node , 'ClientName'   , tcDatautils.getClientName(CustomerId));
    end;
    AddXMLNode(Node , 'UOMID'   , UOMID);
    AddXMLNode(Node , 'Product'   , ProductName);
    AddXMLNode(Node , 'Description'   , Description);
    AddXMLNode(Node , 'OrigPrice'   , OrigPrice);
    AddXMLNode(Node , 'LinePrice'   , LinePrice);
    AddXMLNode(Node , 'UOMMultiplier'   , UOMMultiplier);
    AddXMLNode(Node , 'IncludeInRun'   , IncludeInRun);
    AddXMLNode(Node , 'DateFrom'   , DateFrom);
    AddXMLNode(Node , 'DateTo'   , DateTo);
    AddXMLNode(Node , 'UOM'   , UOM);
    ExportsubClasses(Node);
end;

procedure   TSpecialProducts.LoadFromXMLNode(Const Node: IXMLNode);
begin
    inherited;
    if not ImportingFromXMLFile then begin
        fiProductID	        := GetXMLNodeIntegerValue (Node, 'ProductID');
    end else begin
        fiProductID	        := tcDataUtils.GetProduct(GetXMLNodeStringValue (Node, 'Product'));
    end;
    ficustomerId    := CheckClient(Self,Node, 'ClientName');
    ProductId       := fiProductID;
    customerId      := ficustomerId ;
    SetPropertyFromNode(Node, 'UOMID');
    SetPropertyFromNode(Node, 'Product');
    SetPropertyFromNode(Node, 'Description');
    SetPropertyFromNode(Node, 'OrigPrice');
    SetPropertyFromNode(Node, 'LinePrice');
    SetPropertyFromNode(Node, 'UOMMultiplier');
    SetBooleanPropertyFromNode(Node, 'IncludeInRun');
    SetDateTimePropertyFromNode(Node, 'DateFrom');
    SetDateTimePropertyFromNode(Node, 'DateTo');
    SetPropertyFromNode(Node, 'UOM');
end;

constructor TSpecialProducts.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'Select * from tblCustomerLines';
  ExportExcludeList.Delete(ExportExcludeList.IndexOf('name'));
  ExportExcludeList.Add('productid');
  ExportExcludeList.Add('customerid');
end;

function TSpecialProducts.GetCustomerName: string;
begin
  if Assigned(Owner) and (Owner is TCustomer) then
    result:= TCustomer(Owner).ClientName
  else begin
    if CustomerId > 0 then
      result:= TClient.IDToggle(CustomerId, Connection.Connection)
    else
      result:= ''
  end;
end;

procedure TSpecialProducts.SetCustomerName(const Value: string);
begin
  if Value <> '' then
    CustomerID:= TClient.IDToggle(Value,Connection.Connection)
  else
    CustomerID:= 0;
end;

class function TTerms.GetKeyStringField: string;
begin
  result:= 'Terms';
end;

class function TTerms.GetKeyStringProperty: string;
begin
  result:= 'TermsName';
end;

class function TShippingMethod.GetKeyStringField: string;
begin
  result:= 'ShippingMethod';
end;

class function TShippingMethod.GetKeyStringProperty: string;
begin
  result:= 'ShippingMethod';
end;

class function TClientType.GetKeyStringField: string;
begin
  result:= 'TypeName';
end;

class function TClientType.GetKeyStringProperty: string;
begin
  result:= 'TypeName';
end;

constructor TOtherFollowUps.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ExportExcludeList.Add('othercontactid');
  ExportExcludeList.Add('employeeid');
  ExportExcludeList.Add('clientid');
  ExportExcludeList.Add('typeid');
  ExportExcludeList.Add('resulttypeid');
  ExportExcludeList.Add('repairid');
end;

function TOtherFollowUps.GetEmployeeName: string;
begin
  if EmployeeID > 0 then
    result:= TEmployeeDetails.IDToggle(EmployeeID,Connection.Connection)
  else
    result:= '';
end;

function TOtherFollowUps.GetOtherContactName: string;
begin
  if OtherContactID > 0 then
    result:= TOtherContact.IDToggle(OtherContactID,Connection.Connection)
  else
    result:= '';
end;

procedure TOtherFollowUps.SetEmployeeName(const Value: string);
begin
  if Value <> '' then
    EmployeeID:= TEmployeeDetails.IDToggle(Value,Connection.Connection)
  else
    EmployeeID:= 0;
end;

procedure TOtherFollowUps.SetOtherContactName(const Value: string);
begin
  IsOtherContact:= true;
  IsCustomer:= false;
  IsSupplier:= false;
  if Value <> '' then
    OtherContactID:= TOtherContact.IDToggle(Value,Connection.Connection)
  else
    OtherContactID:= 0;
end;

function TOtherFollowUps.GetResultTypeName: string;
begin
  if ResultTypeId > 0 then
    result:= TFollowUpResultType.IDToggle(ResultTypeId,Connection.Connection)
  else
    result:= '';
end;

function TOtherFollowUps.GetTypeName: string;
begin
  if TypeId > 0 then
    result:= TFollowUpType.IDToggle(TypeId,Connection.Connection)
  else
    result:= '';
end;

procedure TOtherFollowUps.SetResultTypeName(const Value: string);
begin
  if Value <> '' then
    ResultTypeId:= TFollowUpResultType.IDToggle(Value,Connection.Connection)
  else
    ResultTypeId:= 0;
end;

procedure TOtherFollowUps.SetSupplierName(const Value: string);
begin
  IsSupplier:= true;
  IsCustomer:= false;
  IsOtherContact:= false;
  ClientID:= TSupplier.IDToggle(Value,Connection.Connection);
  if TSupplier.ClientIsOtherCotact(Value,Connection.Connection) then
    OtherContactID:= ClientID
  else
    OtherContactID:= 0;
end;

procedure TOtherFollowUps.SetTypeName(const Value: string);
begin
  if Value <> '' then
    TypeId:= TFollowUpType.IDToggle(Value,Connection.Connection)
  else
    TypeId:= 0;
end;

function TOtherFollowUps.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  if Assigned(Owner) then begin
    if Owner is TSupplier then begin
      IsSupplier:= true;
      ClientID:= TCustomer(Owner).ID;
      if TClient(Owner).IsOtherContact then
        OtherContactID:= ClientID;
    end
    else if Owner is TCustomer then begin
      IsCustomer:= true;
      ClientID:= TCustomer(Owner).ID;
    end
    else if Owner is TOtherContact then begin
      IsOtherContact:= true;
      OtherContactID:= TOtherContact(Owner).ID;
    end
    else if Owner is TRepairs then begin
      TRepairs(Self.Owner).PostDB;
      RepairID := TRepairs(Self.Owner).ID;
      ClientId := TRepairs(Self.Owner).ClientID;
    end;
    CreationDate:= now;
    EmployeeId:= AppEnv.Employee.EmployeeID;
  end;
  result:= inherited DoAfterInsert(Sender);
end;

constructor TProductGroupDiscount.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ExportExcludeList.Add('clientid');
end;

function TProductGroupDiscount.GetClientName: string;
begin
  if Assigned(Owner) and (Owner is TClient) then
    result:= TClient(Owner).ClientName
  else begin
    if ClientId > 0 then
      result:= TClient.IDToggle(ClientId, Connection.Connection)
    else
      result:= '';
  end;
end;

procedure TProductGroupDiscount.SetClientName(const Value: string);
begin
  if Assigned(Owner) and (Owner is TClient) then
    { do nothing }
  else begin
    if Value <> '' then
      ClientId:= TClient.IDToggle(Value, Connection.Connection)
    else
      ClientId:= 0;
  end;
end;

{ TRelatedCustomer }

function TRelatedCustomer.FindClient(const aClientId: integer): string;
begin
  result:= TCustomer.IDToggle(aClientId, Connection.Connection);
end;

function TRelatedCustomer.FindClient(const aClientName: string): integer;
begin
  result:= TCustomer.IDToggle(aClientName, Connection.Connection);
end;

initialization
(*  RegisterClassOnce(TSeqNumbers);*)
  RegisterClassOnce(TSpecialProducts);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Special Product','TSpecialProducts','TSpecialProductsGUI');
  RegisterClassOnce(TOtherFollowUps);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Other Followup','TOtherFollowUps','TOtherfollowupsGUI');
  RegisterClassOnce(TShippingMethod);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Shipping Method','TShippingMethod','TShippingMethodsGUI');
  RegisterClassOnce(TClientType);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Client Type','TClientType','TClientTypeListGUI');
  RegisterClassOnce(TTerms);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Terms','TTerms','TTermsListGUI');
  RegisterClassOnce(TProductGroupDiscount);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Product Group Discount','TProductGroupDiscount','TProductgroupdiscountListGUI');
  RegisterClassOnce(TRelatedClients);
  RegisterClassOnce(TRelatedCustomer);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Related Customer','TRelatedCustomer','TRelatedCustomerListGUI');
  RegisterClass(TServices);
end.
