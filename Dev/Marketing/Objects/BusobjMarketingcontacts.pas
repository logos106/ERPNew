unit BusobjMarketingcontacts;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  21/02/08  1.00.01  Binny  Initial Version.
  }


interface

uses
  BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjContact, busobjclient;

type

  TMarketingContactProduct = class(TMSBusObj)
  private
    function GetMarketingcontactId    : Integer   ;
    function GetProductID             : Integer   ;
    function GetProductName           : string    ;
    function GetProductPrintName      : string    ;
    function GetDescription           : string    ;
    function GetActive                : Boolean   ;
    procedure SetMarketingcontactId    (const Value: Integer   );
    procedure SetProductID             (const Value: Integer   );
    procedure SetProductName           (const Value: string    );
    procedure SetProductPrintName       (const Value: string    );
    procedure SetDescription           (const Value: string    );
    procedure SetActive                (const Value: Boolean   );
    function GetMarketingContactCompany: string;
    procedure SetMarketingContactCompany(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
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
    property MarketingContactID     :Integer     read GetMarketingcontactId   write SetMarketingcontactId;
    property MarketingContactCompany: string read GetMarketingContactCompany write SetMarketingContactCompany;
  published
    property ProductID              :Integer     read GetProductID            write SetProductID         ;
    property ProductName            :string      read GetProductName          write SetProductName       ;
    property ProductPrintName       :string      read GetProductPrintName     write SetProductPrintName  ;
    property Description            :string      read GetDescription          write SetDescription       ;
    property Active                 :Boolean     read GetActive               write SetActive            ;
  end;

  TMarketingContact = class;
  TMarketingContactContact = Class(TContactBase)
  private
    function GetMarketiongContactCompany: string;
    procedure SetMarketingContactCompany(const Value: string);
    function GetMarketingContactID: Integer;
    procedure SetMarketingContactID(const Value: Integer);
    function getMarketingContact: TMarketingContact;
  protected
    procedure DoFieldOnChange(Sender: TField); override;
    function GetCompany: string; override;
    procedure SetCompany(const Value: string); override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
  public
    constructor Create(AOwner: TComponent); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    class function GetBusObjectTablename: string; override;
    property MarketingContactID     :Integer     read GetMarketingContactID   write SetMarketingContactID;
    Property MarketingContact :TMarketingContact read getMarketingContact;
  published
    property ContactName: string read GetCompany write SetCompany;
    property MarketingContactCompany: string read GetMarketiongContactCompany write SetMarketingContactCompany;
  end;

  TRelatedContacts = class(TMSBusObj)
  private
    function GetMasterContactID     : Integer   ;
    function GetMasterCompany       : string    ;
    function GetChildContactID      : Integer   ;
    function GetChildCompany        : string    ;
    function GetCustomer            : Boolean   ;
    function GetSupplier            : Boolean   ;
    function GetOtherContact        : Boolean   ;
    function GetMarketingcontact    : Boolean   ;
    procedure SetMasterContactID     (const Value: Integer   );
    procedure SetMasterCompany       (const Value: string    );
    procedure SetChildContactID      (const Value: Integer   );
    procedure SetChildCompany        (const Value: string    );
    procedure SetCustomer            (const Value: Boolean   );
    procedure SetSupplier            (const Value: Boolean   );
    procedure SetOtherContact        (const Value: Boolean   );
    procedure SetMarketingcontact    (const Value: Boolean   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    Function  DoAfterInsert(sender:TDatasetBusobj):Boolean; override;
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
    property MasterContactID      :Integer     read GetMasterContactID    write SetMasterContactID ;
    property MasterCompany        :string      read GetMasterCompany      write SetMasterCompany   ;
    property ChildContactID       :Integer     read GetChildContactID     write SetChildContactID  ;
    property ChildCompany         :string      read GetChildCompany       write SetChildCompany    ;
    property Customer             :Boolean     read GetCustomer           write SetCustomer        ;
    property Supplier             :Boolean     read GetSupplier           write SetSupplier        ;
    property OtherContact         :Boolean     read GetOtherContact       write SetOtherContact    ;
    property MarketingContact     :Boolean     read GetMarketingcontact   write SetMarketingcontact;
  end;

  TMarketingContact = class(TMSBusObj)
  private
    fClient :Tclient;
    function GetCompanyTypeName       : string    ;
    function GetCOMPANY               : string    ;
    function GetStreet                : string    ;
    function GetStreet2               : string    ;
    function GetStreet3               : string    ;
    function GetSUBURB                : string    ;
    function GetSTATE                 : string    ;
    function GetPOSTCODE              : string    ;
    function GetCountry               : string    ;
    function GetBillStreet            : string    ;
    function GetBillStreet2           : string    ;
    function GetBillStreet3           : string    ;
    function GetBillSUBURB            : string    ;
    function GetBillSTATE             : string    ;
    function GetBillPOSTCODE          : string    ;
    function GetBillCountry           : string    ;
    function GetFaxNumber             : string    ;
    function GetPhone                 : string    ;
    function GetAltPhone              : string    ;
    function GetMobile                : string    ;
    function GetEmployeeSize          : string    ;
    function GetNotes                 : string    ;
    function GetActive                : Boolean   ;
    function GetJobTitle              : string    ;
    function GetTitle                 : string    ;
    function GetFirstName             : string    ;
    function GetMiddleName            : string    ;
    function GetLastName              : string    ;
    function GetEmail                 : string    ;
    function GetDateEntered           : TDateTime ;
    function GetCreatedOn             : TDateTime ;
    function GetEnteredEmpID          : Integer   ;
    function GetDateOfBirth           : TDateTime ;
    function GetDuration              : TDateTime ;
    function GetSource                : string    ;
    function GetNumUnansweredCalls    : Integer   ;
    function GetDoNotQualify          : Boolean   ;
    function GetClientID              : Integer   ;
    Function GetIsClient              : boolean   ;
    Function GetTypeId                : Integer;
    function getSourceID              : Integer;
    function getfullname              : String;
    Function getShiptoAddress         : String;
    Function getcleancompany          : String;
    Function getRepID :Integer;
    Function getREpName:String;
    Function getMedTypeID:Integer;
    Function getCUSTFLD1 :String;
    Function getCUSTFLD2 :String;
    Function getCUSTFLD3 :String;
    Function getCUSTFLD4 :String;
    Function getCUSTFLD5 :String;
    Function getCUSTFLD6 :String;
    Function getCUSTFLD7 :String;
    Function getCUSTFLD8 :String;
    Function getCUSTFLD9 :String;
    Function getCUSTFLD10 :String;
    Function getCUSTFLD11 :String;
    Function getCUSTFLD12 :String;
    Function getCUSTFLD13 :String;
    Function getCUSTFLD14 :String;
    Function getCUSTFLD15 :String;
    Function getCUSTDATE1 :TDateTime;
    Function getCUSTDATE2 :TDateTime;
    Function getCUSTDATE3 :TDateTime;
    Procedure SetRepID(Const Value :Integer);
    Procedure SetREpName(Const Value :String);
    Procedure SetMedTypeID(Const Value :Integer);
    Procedure SetCUSTFLD1 (Const Value :String);
    Procedure SetCUSTFLD2 (Const Value :String);
    Procedure SetCUSTFLD3 (Const Value :String);
    Procedure SetCUSTFLD4 (Const Value :String);
    Procedure SetCUSTFLD5 (Const Value :String);
    Procedure SetCUSTFLD6 (Const Value :String);
    Procedure SetCUSTFLD7 (Const Value :String);
    Procedure SetCUSTFLD8 (Const Value :String);
    Procedure SetCUSTFLD9 (Const Value :String);
    Procedure SetCUSTFLD10 (Const Value :String);
    Procedure SetCUSTFLD11 (Const Value :String);
    Procedure SetCUSTFLD12 (Const Value :String);
    Procedure SetCUSTFLD13 (Const Value :String);
    Procedure SetCUSTFLD14 (Const Value :String);
    Procedure SetCUSTFLD15 (Const Value :String);
    Procedure SetCUSTDATE1  (Const Value :TDateTime);
    Procedure SetCUSTDATE2  (Const Value :TDateTime);
    Procedure SetCUSTDATE3  (Const Value :TDateTime);
    procedure SetCompanyTypeName       (const Value: string    );
    procedure SetCOMPANY               (const Value: string    );
    procedure SetFaxNumber             (const Value: string    );
    procedure SetPhone                 (const Value: string    );
    procedure SetAltPhone              (const Value: string    );
    procedure SetMobile                (const Value: string    );
    procedure SetEmployeeSize          (const Value: string    );
    procedure SetNotes                 (const Value: string    );
    procedure SetActive                (const Value: Boolean   );
    procedure SetJobTitle              (const Value: string    );
    procedure SetTitle                 (const Value: string    );
    procedure SetFirstName             (const Value: string    );
    procedure SetMiddleName            (const Value: string    );
    procedure SetLastName              (const Value: string    );
    procedure SetEmail                 (const Value: string    );
    procedure SetStreet                (const Value: string    );
    procedure SetStreet2               (const Value: string    );
    procedure SetStreet3               (const Value: string    );
    procedure SetSUBURB                (const Value: string    );
    procedure SetSTATE                 (const Value: string    );
    procedure SetPOSTCODE              (const Value: string    );
    procedure SetCountry               (const Value: string    );
    procedure SetBillStreet            (const Value: string    );
    procedure SetBillStreet2           (const Value: string    );
    procedure SetBillStreet3           (const Value: string    );
    procedure SetBillSUBURB            (const Value: string    );
    procedure SetBillSTATE             (const Value: string    );
    procedure SetBillPOSTCODE          (const Value: string    );
    procedure SetBillCountry           (const Value: string    );
    procedure SetDateEntered           (const Value: TDateTime );
    procedure SetCreatedOn             (const Value: TDateTime );
    procedure SetEnteredEmpID          (const Value: Integer   );
    procedure SetDateOfBirth           (const Value: TDateTime );
    procedure SetDuration              (const Value: TDateTime );
    procedure SetSource                (const Value: string    );
    procedure SetNumUnansweredCalls    (const Value: Integer   );
    procedure SetDoNotQualify          (const Value: Boolean   );
    procedure SetClientID              (const Value: Integer   );
    function GetURL: string;
    procedure SetURL(const Value: string);
    function getRelatedContacts: TRelatedContacts;
    function getMarketingContactContacts: TMarketingContactContact;
    function getMarketingContactProducts: TMarketingContactProduct;
    procedure CreateClientContacts(Const Sender: TBusObj; var Abort: boolean);
    function getCallPriority: Integer;
    procedure setCallPriority(const Value: Integer);
    function getDefaultContactMethod: String;
    procedure setDefaultContactMethod(const Value: String);
    function GetCustomerName: string;
    function GetOtherContactName: string;
    procedure SetCustomerName(const Value: string);
    procedure SetOtherContactName(const Value: string);
    function GetSkypeName: string;
    procedure SetSkypeName(const Value: string);
    function getcurrentEmailID: String;
    function GetDoNotContact: boolean;
    procedure SetDoNotContact(const Value: boolean);
    function GetPrimaryContact: TMarketingContactContact;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);   override;
    procedure DoFieldOnChange(Sender: TField);                           override;
    function  GetSQL: string;                                            override;
    function  DoAfterPost(Sender: TDatasetBusObj): Boolean;              override;
    function  DoAfterInsert(Sender: TDatasetBusObj): Boolean;            override;
  public
    constructor      Create(AOwner: TComponent);                         override;
    destructor       Destroy;                                            override;
    procedure        LoadFromXMLNode(const node: IXMLNode);              override;
    procedure        SaveToXMLNode(const node: IXMLNode);                override;
    function         ValidateData: Boolean;                              override;
    function         Save: Boolean;                                      override;
    function         ConvertToClient(fISClient :Boolean): Boolean;
    Class function   GetIDField              : string;                   override;
    Class function   GetKeyStringField       : string;                   override;
    Class function   GetBusObjectTablename   : string;                   override;
    property ShipToAddress          : string read getShiptoAddress;
    Property cleancompany           : String read getcleancompany;
    Property    Fullname    : String       Read getfullname;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    property ClientID               :Integer     read GetClientID             write SetClientID          ;
    function HasTelemarketing :Boolean;
    Function HasLead:Boolean;
    property currentEmailID:String read getcurrentEmailID;
    property PrimaryContact: TMarketingContactContact read GetPrimaryContact;
  published
    property CompanyTypeName        :string      read GetCompanyTypeName      write SetCompanyTypeName   ;
    property Company                :string      read GetCOMPANY              write SetCOMPANY           ;
    property SkypeName: string read GetSkypeName write SetSkypeName;
    property Street                 :string      read GetStreet               write SetStreet            ;
    property Street2                :string      read GetStreet2              write SetStreet2           ;
    property Street3                :string      read GetStreet3              write SetStreet3           ;
    property Suburb                 :string      read GetSUBURB               write SetSUBURB            ;
    property State                  :string      read GetSTATE                write SetSTATE             ;
    property Postcode               :string      read GetPOSTCODE             write SetPOSTCODE          ;
    property Country                :string      read GetCountry              write SetCountry           ;
    property BillStreet                 :string      read GetBillStreet               write SetBillStreet            ;
    property BillStreet2                :string      read GetBillStreet2              write SetBillStreet2           ;
    property BillStreet3                :string      read GetBillStreet3              write SetBillStreet3           ;
    property BillSuburb                 :string      read GetBillSUBURB               write SetBillSUBURB            ;
    property BillState                  :string      read GetBillSTATE                write SetBillSTATE             ;
    property BillPostcode               :string      read GetBillPOSTCODE             write SetBillPOSTCODE          ;
    property BillCountry                :string      read GetBillCountry              write SetBillCountry           ;
    property FaxNumber              :string      read GetFaxNumber            write SetFaxNumber         ;
    property Phone                  :string      read GetPhone                write SetPhone             ;
    property AltPhone               :string      read GetAltPhone             write SetAltPhone          ;
    property Mobile                 :string      read GetMobile               write SetMobile            ;
    property URL                    :string      read GetURL                  write SetURL;
    property EmployeeSize           :string      read GetEmployeeSize         write SetEmployeeSize      ;
    property Notes                  :string      read GetNotes                write SetNotes             ;
    property Active                 :Boolean     read GetActive               write SetActive            ;
    property JobTitle               :string      read GetJobTitle             write SetJobTitle          ;
    property Title                  :string      read GetTitle                write SetTitle             ;
    property FirstName              :string      read GetFirstName            write SetFirstName         ;
    property MiddleName             :string      read GetMiddleName           write SetMiddleName        ;
    property LastName               :string      read GetLastName             write SetLastName          ;
    property Email                  :string      read GetEmail                write SetEmail             ;
    property DateEntered            :TDateTime   read GetDateEntered          write SetDateEntered       ;
    property CreatedOn              :TDateTime   read GetCreatedOn            write SetCreatedOn         ;
    property EnteredEmpID           :Integer     read GetEnteredEmpID         write SetEnteredEmpID      ;
    property DateOfBirth            :TDateTime   read GetDateOfBirth          write SetDateOfBirth       ;
    property Duration               :TDateTime   read GetDuration             write SetDuration          ;
    property Source                 :string      read GetSource               write SetSource            ;
    property NumUnansweredCalls     :Integer     read GetNumUnansweredCalls   write SetNumUnansweredCalls;
    property DoNotQualify           :Boolean     read GetDoNotQualify         write SetDoNotQualify      ;
    property CustomerName: string read GetCustomerName write SetCustomerName;
    property OtherContactName: string read GetOtherContactName write SetOtherContactName;
    property IsClient               :Boolean     read GetIsClient;
    property RepID :Integer read getRepID write setRepID;
    property MedTypeID:Integer read getMedTypeID Write setMedTypeID;
    property RepName:String read getREpName write setREpName;
    property CUSTFLD1 :String read getCUSTFLD1 Write setCUSTFLD1;
    property CUSTFLD2 :String read getCUSTFLD2 Write SetCUSTFLD2;
    property CUSTFLD3 :String read getCUSTFLD3 Write SetCUSTFLD3;
    property CUSTFLD4 :String read getCUSTFLD4 Write SetCUSTFLD4;
    property CUSTFLD5 :String read getCUSTFLD5 Write SetCUSTFLD5;
    property CUSTFLD6 :String read getCUSTFLD6 Write SetCUSTFLD6;
    property CUSTFLD7 :String read getCUSTFLD7 Write SetCUSTFLD7;
    property CUSTFLD8 :String read getCUSTFLD8 Write SetCUSTFLD8;
    property CUSTFLD9 :String read getCUSTFLD9 Write SetCUSTFLD9;
    property CUSTFLD10 :String read getCUSTFLD10 Write SetCUSTFLD10;
    property CUSTFLD11 :String read getCUSTFLD11 Write SetCUSTFLD11;
    property CUSTFLD12 :String read getCUSTFLD12 Write SetCUSTFLD12;
    property CUSTFLD13 :String read getCUSTFLD13 Write SetCUSTFLD13;
    property CUSTFLD14 :String read getCUSTFLD14 Write SetCUSTFLD14;
    property CUSTFLD15 :String read getCUSTFLD15 Write SetCUSTFLD15;
    property CUSTDATE1 :TDateTime read getCUSTDATE1 Write setCUSTDATE1;
    property CUSTDATE2 :TDateTime read getCUSTDATE2 Write setCUSTDATE2;
    property CUSTDATE3 :TDateTime read getCUSTDATE3 Write setCUSTDATE3;
    Property RelatedContacts : TRelatedContacts Read getRelatedContacts;
    Property MarketingContactContacts :TMarketingContactContact Read getMarketingContactContacts;
    Property MarketingContactProducts :TMarketingContactProduct REad getMarketingContactProducts;
    Property CallPriority :Integer read getCallPriority write setCallPriority;
    Property DefaultContactMethod :String read getDefaultContactMethod write setDefaultContactMethod;
    property DoNotContact: boolean read GetDoNotContact write SetDoNotContact;
  end;


implementation


uses CommonLib, sysutils,
  CommonDbLib, Dateutils, BusObjSimpleTypes, tcDataUtils,
  AppEnvironment, BusObjStock, MyAccess, BusObjEmployeeDetails,
  ERPdbComponents, BusObjectListObj, BusObjSchemaLib, DbSharedObjectsObj;



{ TMarketingContact }

constructor TMarketingContact.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'MarketingContact';
  fSQL := 'SELECT * FROM tblmarketingcontacts';
  ExportExcludeList.Add('repid');
  ExportExcludeList.Add('clientid');
  ExportExcludeList.Add('medtypeid');
  ExportExcludeList.Add('isclient');
  ExportExcludeList.Add('enteredempid');
  ExportExcludeList.Add('dateentered');
  ExportExcludeList.Add('CreatedOn');
end;


Class function TMarketingContact.GetIDField: string;
begin
  Result := 'ID'
end;


Class function TMarketingContact.GetKeyStringField: string;
begin
  Result := 'Company'
end;


class function TMarketingContact.GetKeyStringProperty: string;
begin
  result:= 'Company';
end;

Class function TMarketingContact.GetBusObjectTablename: string;
begin
  Result := 'tblmarketingcontacts'
end;


destructor TMarketingContact.Destroy;
begin
  inherited;
end;


procedure TMarketingContact.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'CompanyTypeName');
  SetPropertyFromNode(node,'Company');
  SetPropertyFromNode(node,'Street');
  SetPropertyFromNode(node,'Street2');
  SetPropertyFromNode(node,'Street3');
  SetPropertyFromNode(node,'Suburb');
  SetPropertyFromNode(node,'State');
  SetPropertyFromNode(node,'Postcode');
  SetPropertyFromNode(node,'Country');
  SetPropertyFromNode(node,'BillStreet');
  SetPropertyFromNode(node,'BillStreet2');
  SetPropertyFromNode(node,'BillStreet3');
  SetPropertyFromNode(node,'BillSuburb');
  SetPropertyFromNode(node,'BillState');
  SetPropertyFromNode(node,'BillPostcode');
  SetPropertyFromNode(node,'BillCountry');
  SetPropertyFromNode(node,'FaxNumber');
  SetPropertyFromNode(node,'Phone');
  SetPropertyFromNode(node,'AltPhone');
  SetPropertyFromNode(node,'Mobile');
  SetPropertyFromNode(node,'URL');
  SetPropertyFromNode(node,'EmployeeSize');
  SetPropertyFromNode(node,'Notes');
  SetPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'JobTitle');
  SetPropertyFromNode(node,'Title');
  SetPropertyFromNode(node,'FirstName');
  SetPropertyFromNode(node,'MiddleName');
  SetPropertyFromNode(node,'LastName');
  SetPropertyFromNode(node,'Email');
  SetPropertyFromNode(node,'DateEntered');
  SetPropertyFromNode(node,'CreatedOn');
  SetPropertyFromNode(node,'EnteredEmpID');
  SetPropertyFromNode(node,'DateOfBirth');
  SetPropertyFromNode(node,'Duration');
  SetPropertyFromNode(node,'Source');
  SetPropertyFromNode(node,'NumUnansweredCalls');
  SetPropertyFromNode(node,'DoNotQualify');
  SetPropertyFromNode(node,'ClientID');

    SetPropertyFromNode(node,'RepID');
    SetPropertyFromNode(node,'MedTypeID');
    SetPropertyFromNode(node,'REpName');
    SetPropertyFromNode(node,'CUSTFLD1');
    SetPropertyFromNode(node,'CUSTFLD2');
    SetPropertyFromNode(node,'CUSTFLD3');
    SetPropertyFromNode(node,'CUSTFLD4');
    SetPropertyFromNode(node,'CUSTFLD5');
    SetPropertyFromNode(node,'CUSTFLD6');
    SetPropertyFromNode(node,'CUSTFLD7');
    SetPropertyFromNode(node,'CUSTFLD8');
    SetPropertyFromNode(node,'CUSTFLD9');
    SetPropertyFromNode(node,'CUSTFLD10');
    SetPropertyFromNode(node,'CUSTFLD11');
    SetPropertyFromNode(node,'CUSTFLD12');
    SetPropertyFromNode(node,'CUSTFLD13');
    SetPropertyFromNode(node,'CUSTFLD14');
    SetPropertyFromNode(node,'CUSTFLD15');
    SetPropertyFromNode(node,'CallPriority');
    SetPropertyFromNode(node,'DefaultContactMethod');

    SetDateTimePropertyFromNode(node,'CUSTDATE1');
    SetDateTimePropertyFromNode(node,'CUSTDATE2 ');
    SetDateTimePropertyFromNode(node,'CUSTDATE3');
    SetBooleanPropertyFromNode(node, 'DoNotContact');
end;


procedure TMarketingContact.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'CompanyTypeName' ,CompanyTypeName);
  AddXMLNode(node,'Company' ,COMPANY);
  AddXMLNode(node,'Street' ,Street);
  AddXMLNode(node,'Street2' ,Street2);
  AddXMLNode(node,'Street3' ,Street3);
  AddXMLNode(node,'Suburb' ,SUBURB);
  AddXMLNode(node,'State' ,STATE);
  AddXMLNode(node,'Postcode' ,POSTCODE);
  AddXMLNode(node,'Country' ,Country);
  AddXMLNode(node,'BillStreet' ,Street);
  AddXMLNode(node,'BillStreet2' ,Street2);
  AddXMLNode(node,'BillStreet3' ,Street3);
  AddXMLNode(node,'BillSuburb' ,SUBURB);
  AddXMLNode(node,'BillState' ,STATE);
  AddXMLNode(node,'BillPostcode' ,POSTCODE);
  AddXMLNode(node,'BillCountry' ,Country);
  AddXMLNode(node,'FaxNumber' ,FaxNumber);
  AddXMLNode(node,'Phone' ,Phone);
  AddXMLNode(node,'AltPhone' ,AltPhone);
  AddXMLNode(node,'Mobile' ,Mobile);
  AddXMLNode(node,'URL' ,URL);
  AddXMLNode(node,'EmployeeSize' ,EmployeeSize);
  AddXMLNode(node,'Notes' ,Notes);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'JobTitle' ,JobTitle);
  AddXMLNode(node,'Title' ,Title);
  AddXMLNode(node,'FirstName' ,FirstName);
  AddXMLNode(node,'MiddleName' ,MiddleName);
  AddXMLNode(node,'LastName' ,LastName);
  AddXMLNode(node,'Email' ,Email);
  AddXMLNode(node,'DateEntered' ,DateEntered);
  AddXMLNode(node,'CreatedOn' ,CreatedOn);
  AddXMLNode(node,'EnteredEmpID' ,EnteredEmpID);
  AddXMLNode(node,'DateOfBirth' ,DateOfBirth);
  AddXMLNode(node,'Duration' ,Duration);
  AddXMLNode(node,'Source' ,Source);
  AddXMLNode(node,'NumUnansweredCalls' ,NumUnansweredCalls);
  AddXMLNode(node,'DoNotQualify' ,DoNotQualify);
  AddXMLNode(node,'ClientID' ,ClientID);
  AddXMLNode(node,'RepID' ,RepID);
  AddXMLNode(node,'MedTypeID' ,MedTypeID );
  AddXMLNode(node,'REpName' ,REpName);
  AddXMLNode(node,'CUSTFLD1' ,CUSTFLD1 );
  AddXMLNode(node,'CUSTFLD2' ,CUSTFLD2 );
  AddXMLNode(node,'CUSTFLD3' ,CUSTFLD3 );
  AddXMLNode(node,'CUSTFLD4' ,CUSTFLD4 );
  AddXMLNode(node,'CUSTFLD5' ,CUSTFLD5 );
  AddXMLNode(node,'CUSTFLD6' ,CUSTFLD6 );
  AddXMLNode(node,'CUSTFLD7' ,CUSTFLD7 );
  AddXMLNode(node,'CUSTFLD8' ,CUSTFLD8 );
  AddXMLNode(node,'CUSTFLD9' ,CUSTFLD9 );
  AddXMLNode(node,'CUSTFLD10' ,CUSTFLD10 );
  AddXMLNode(node,'CUSTFLD11' ,CUSTFLD11 );
  AddXMLNode(node,'CUSTFLD12' ,CUSTFLD12 );
  AddXMLNode(node,'CUSTFLD13' ,CUSTFLD13 );
  AddXMLNode(node,'CUSTFLD14' ,CUSTFLD14 );
  AddXMLNode(node,'CUSTFLD15' ,CUSTFLD15 );
  AddXMLNode(node,'CallPriority' ,CallPriority );
  AddXMLNode(node,'DefaultContactMethod' ,DefaultContactMethod);
  AddXMLNode(node,'CUSTDATE1' ,CUSTDATE1 );
  AddXMLNode(node,'CUSTDATE2' ,CUSTDATE2 );
  AddXMLNode(node,'CUSTDATE3' ,CUSTDATE3 );
  AddXMLNode(node,'DoNotContact', DoNotContact);
end;


function TMarketingContact.ValidateData: Boolean ;
begin
    Result := False;
    Resultstatus.Clear;
    if Trim(Company) = '' then begin
        AddResult(False, rssWarning , 0 , 'Company should not be blank');
        Exit;
    end;
    if (Trim(FirstName) = '') and (not SilentMode) then begin
        AddResult(False, rssWarning , 0 , 'First Name should not be blank');
        Exit;
    end;
    if Source <> '' then begin
        if tcDatautils.getMediatype(Source) = 0 then begin
            AddResult(False, rssWarning , 0 , 'Invalid Source "' + source +'".');
            Exit;
        end;
    end;
    if MarketingContactContacts.count > 0 then if not MarketingContactContacts.ValidateData then exit;
    if MarketingContactProducts.count > 0 then if not MarketingContactProducts.ValidateData then exit;
    if RelatedContacts.count > 0 then if not RelatedContacts.ValidateData then exit;

    Result := True;
end;
class function TMarketingContact._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TCompanyType','CompanyType_1','CompanyTypeName','TypeName');
  TBOSchema.AddRefType(result,'TSource','Source_1','Source','MediaType');
  TBOSchema.AddRefType(result,'TSource','Source_1','MedTypeID','MediaTypeID');
  TBOSchema.AddRefType(result,'TCustomer','Customer_1','CustomerName','ClientName');
  TBOSchema.AddRefType(result,'TOtherContact','OtherContact_1','OtherContactName','ClientName');
  TBOSchema.AddRefType(result,'TEmployee','Employee_1','RepID','ID');
  TBOSchema.AddRefType(result,'TEmployee','Employee_1','RepName','EmployeeName');
end;

function TMarketingContact.getTypeID:Integer;
var
  CompanyType: TCompanyType;
begin
  if CompanyTypeName <> '' then begin
    CompanyType:= TCompanyType.Create(self);
    try
      CompanyType.LoadSelect('Name = '+ QuotedStr(CompanyTypeName));
      if CompanyType.count = 0 then begin
        CompanyType.New;
        CompanyType.TypeName    := CompanyTypeName;
        CompanyType.Description := CompanyTypeName;
        CompanyType.IsDefault   := False;
        CompanyType.Active      := True;
        CompanyType.PostDB;
      end;
      Result := CompanyType.ID;
    finally
      CompanyType.Free;
    end;
  end
  else
    result := 0;
end;

function TMarketingContact.getCallPriority: Integer;begin  REsult := GetIntegerField('CallPriority');end;

function TMarketingContact.Getcleancompany:String;
begin
    result:= GetXMLNodeStringValue(CleanXMLNode, 'Company');
end;
function TMarketingContact.GetshipToAddress: string;
begin{check for blank field to avoid blank lines in the ship to address}
  Result := Company;
  if Street <> '' then
    Result := Result + Chr(13) + Chr(10) + Street;
  if Street2 <> '' then
    Result := Result + Chr(13) + Chr(10) + Street2;
  if Street3 <> '' then
    Result := Result + Chr(13) + Chr(10) + Street3;
  if (Suburb <> '') or (State <> '') then
  begin
    Result := Result + Chr(13) + Chr(10);
    if (Suburb <> '') and (State <> '') then
      Result := Result + Suburb + ' ' + State
    else if Suburb = '' then
      Result := Result + State
    else
      Result := Result + Suburb;
  end;
  if Postcode <> '' then
    Result := Result + ' ' + Postcode;
end;


Function TMarketingContact.getfullname:String;
begin
    Result := '';
    if Title <> '' then Result := Result + title + ' ';
    if FirstName <> '' then Result := Result + FirstName + ' ';
    if LastName <> '' then Result := Result + LastName + ' ';
    Result := Trim(Result);
end;
function TMarketingContact.getsourceID:Integer;
var
    sourceObj :TSource;
begin
    SourceObj := TSource.Create(Self) ;
    try
        SourceObj.LoadSelect('MediaType = '+ QuotedStr(Source));
        if SourceObj.count = 0 then begin
            SourceObj.New;
            SourceObj.MediaType := Source;
            SourceObj.Active := True;
            SourceObj.PostDB;
        end;
        Result := SourceObj.ID;
    finally
        FreeandNil(SourceObj);
    end;
end;
function TMarketingContact.ConvertToClient(fISClient :Boolean): Boolean;
begin
    Result := True;
    fClient := TClient.Create(nil);
    try
      fClient.Connection:= self.Connection;

      fClient.LoadSelect('company = ' +quotedStr(Company));
      if fClient.count> 0 then  begin
          clientId := fclient.Id;
          if fISClient and (not fclient.Customer) then begin
              fclient.Customer := fISClient;
              fclient.PostDB;
          end;
          PostDB;
          Exit;
      end;

      if not(Lock) then begin
        resultStatus.additem(False, rssWarning , 0 , replacestr(UserLock.LockMessage , 'Unable to update data.' , 'Unable to flag ' +Quotedstr(company)+' as Client/Customer.'));
        Result:= False;
        Exit;
      end;
      fClient.New;
      fClient.CompanyTypeId   := GetTypeId;
      fClient.OtherContact    := True;
      fClient.ClientName      := Company;
      fClient.Printname       := Company;
      fClient.FaxNumber       := FaxNumber;
      fClient.Phone           := Phone;
      fClient.AltPhone        := AltPhone;
      fClient.Mobile          := Mobile;
      fClient.Street          := Street;
      fClient.Street2         := Street2;
      fClient.Street3         := Street3;
      fClient.Suburb          := Suburb;
      fClient.State           := State;
      fClient.Postcode        := Postcode;
      fClient.Country         := Country;
      fClient.URL             := URL;
      fClient.BillStreet      := BillStreet;
      fClient.BillStreet2     := BillStreet2;
      fClient.BillStreet3     := BillStreet3;
      fClient.BillSuburb      := BillSuburb;
      fClient.BillState       := BillState;
      fClient.BillPostcode    := BillPostcode;
      fClient.BillCountry     := BillCountry;
      fClient.Customer        := fISClient;
      fClient.Notes           := Notes;
      fClient.Active          := Active;
      fClient.JobTitle        := JobTitle;
      fClient.Title           := Title;
      fClient.Firstname       := Firstname;
      fClient.Middlename      := Middlename;
      fClient.Lastname        := Lastname;
      fClient.Email           := Email;
      fClient.DateEntered     := DateEntered;
      fClient.MedTypeID       := getsourceID;
      fClient.PostDB;
      MarketingContactContacts.IterateRecords(CreateClientContacts);
      Result := fClient.Save;
      if Result then  begin
          ClientID := fClient.Id;
          PostDB;
      end;
    finally
        Freeandnil(fclient);
    end;
end;
function TMarketingContact.Save: Boolean ;
begin
  Result := False;
  PostDB;
  MarketingContactContacts.postdb;
  MarketingContactProducts.PostDB;
  RelatedContacts.postDB;
  if not ValidateData then Exit;
  Result := inherited Save;
  if result then begin
      if MarketingContactContacts.Count =0 then begin
          MarketingContactContacts.New;
          MarketingContactContacts.ContactTitle      := Title;
          MarketingContactContacts.ContactFirstName  := FirstName;
          MarketingContactContacts.ContactSurName    := LastName;
          MarketingContactContacts.ContactMOB        := Mobile;
          MarketingContactContacts.jobtitle          := JobTitle;
          MarketingContactContacts.ContactEmail      := Email;
          MarketingContactContacts.Company           := Trim(MarketingContactContacts.ContactFirstName + ' ' + MarketingContactContacts.ContactSurname);
          MarketingContactContacts.ISPrimaryContact  := True;
          MarketingContactContacts.ContactPH         := Phone;
          MarketingContactContacts.ContactFax        := FaxNumber;
          MarketingContactContacts.ContactAltPH      := AltPhone;
          MarketingContactContacts.ContactAddress    := Street;
          MarketingContactContacts.ContactAddress2   := Street2;
          MarketingContactContacts.ContactAddress3   := Street3;
          MarketingContactContacts.ContactCity       := Suburb;
          MarketingContactContacts.ContactState      := State;
          MarketingContactContacts.ContactPcode      := Postcode;
          MarketingContactContacts.ContactCountry    := Country;
          MarketingContactContacts.Active            := True;
          MarketingContactContacts.PostDB;
      end;
      Dirty := false;
  end;
end;


procedure TMarketingContact.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TMarketingContact.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  if Sysutils.SameText(Sender.fieldName , 'Firstname') then begin
    if not RawMode then begin
      if (company = '')  then Company := firstname + ' ' + LastName ;
    end;
  end else if Sysutils.SameText(Sender.fieldName , 'LastName') then begin
    if not RawMode then begin
      if (company = '')  or (trim(company) = firstname )  then Company := firstname + ' ' + LastName ;
    end;
  end
  else if Sysutils.SameText(Sender.fieldName , 'REpName') then begin
    RepId:= TEmployeeDetails.IDToggle(Sender.AsString,Connection.Connection);
  end
  else if Sysutils.SameText(Sender.fieldName , 'MedTypeID') then begin
    Source:= TSource.IDToggle(Sender.AsInteger, Connection.Connection);
  end
  else if Sysutils.SameText(Sender.fieldName , 'Source') then begin
    MedTypeID:= TSource.IDToggle(Sender.AsString, Connection.Connection);
  end;
end;


function TMarketingContact.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


function TMarketingContact.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
end;
function  TMarketingContact.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
    REsult := inherited DoAfterInsert(Sender);
    if not result then Exit;
    DateEntered := Dateof(Date);
    CreatedOn := now;
end;
function  TMarketingContact.GetIsClient:Boolean;
begin
    Result := clientId <> 0;
end;
{Property functions}
function  TMarketingContact.GetCompanyTypeName   : string    ; begin Result := GetStringField('CompanyTypeName');end;
function  TMarketingContact.GetCOMPANY           : string    ; begin Result := GetStringField('COMPANY');end;

function  TMarketingContact.GetStreet            : string    ; begin Result := GetStringField('Street');end;
function  TMarketingContact.GetStreet2           : string    ; begin Result := GetStringField('Street2');end;
function  TMarketingContact.GetStreet3           : string    ; begin Result := GetStringField('Street3');end;
function  TMarketingContact.GetSUBURB            : string    ; begin Result := GetStringField('SUBURB');end;
function  TMarketingContact.GetSTATE             : string    ; begin Result := GetStringField('STATE');end;
function  TMarketingContact.GetPOSTCODE          : string    ; begin Result := GetStringField('POSTCODE');end;
function TMarketingContact.GetPrimaryContact: TMarketingContactContact;
begin
  if not MarketingContactContacts.Locate('IsPrimaryContact','T',[loCaseInsensitive]) then
    MarketingContactContacts.First;
  result := MarketingContactContacts;
end;

function  TMarketingContact.GetCountry           : string    ; begin Result := GetStringField('Country');end;

function  TMarketingContact.GetBillStreet            : string    ; begin Result := GetStringField('BillStreet');end;
function  TMarketingContact.GetBillStreet2           : string    ; begin Result := GetStringField('BillStreet2');end;
function  TMarketingContact.GetBillStreet3           : string    ; begin Result := GetStringField('BillStreet3');end;
function  TMarketingContact.GetBillSUBURB            : string    ; begin Result := GetStringField('BillSUBURB');end;
function  TMarketingContact.GetBillSTATE             : string    ; begin Result := GetStringField('BillSTATE');end;
function  TMarketingContact.GetBillPOSTCODE          : string    ; begin Result := GetStringField('BillPOSTCODE');end;
function  TMarketingContact.GetBillCountry           : string    ; begin Result := GetStringField('BillCountry');end;

function  TMarketingContact.GetFaxNumber         : string    ; begin Result := GetStringField('FaxNumber');end;
function  TMarketingContact.GetPhone             : string    ; begin Result := GetStringField('Phone');end;
function  TMarketingContact.GetAltPhone          : string    ; begin Result := GetStringField('AltPhone');end;
function  TMarketingContact.GetMobile            : string    ; begin Result := GetStringField('Mobile');end;
function  TMarketingContact.GetEmployeeSize      : string    ; begin Result := GetStringField('EmployeeSize');end;
function  TMarketingContact.GetNotes             : string    ; begin Result := GetStringField('Notes');end;
function  TMarketingContact.GetActive            : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TMarketingContact.GetJobTitle          : string    ; begin Result := GetStringField('JobTitle');end;
function  TMarketingContact.GetTitle             : string    ; begin Result := GetStringField('Title');end;
function  TMarketingContact.GetFirstName         : string    ; begin Result := GetStringField('FirstName');end;
function  TMarketingContact.GetMiddleName        : string    ; begin Result := GetStringField('MiddleName');end;
function  TMarketingContact.GetLastName          : string    ; begin Result := GetStringField('LastName');end;
function  TMarketingContact.GetEmail             : string    ; begin Result := GetStringField('Email');end;

function TMarketingContact.GetCustomerName: string;
begin
  if ClientID > 0 then
    result:= TCustomer.IDToggle(ClientID,Connection.Connection)
  else
    result:= '';
end;

function  TMarketingContact.GetDateEntered       : TDateTime ; begin Result := GetDateTimeField('DateEntered');end;
function  TMarketingContact.GetCreatedOn         : TDateTime ; begin Result := GetDateTimeField('CreatedOn');end;
function  TMarketingContact.GetEnteredEmpID      : Integer   ; begin Result := GetIntegerField('EnteredEmpID');end;
function  TMarketingContact.GetDateOfBirth       : TDateTime ; begin Result := GetDateTimeField('DateOfBirth');end;
function TMarketingContact.getDefaultContactMethod: String;begin  result := getStringfield('DefaultContactMethod');end;

function  TMarketingContact.GetDuration          : TDateTime ; begin Result := GetDateTimeField('Duration');end;
function TMarketingContact.GetSkypeName: string;
begin
  result := GetStringField('SkypeName');
end;

function  TMarketingContact.GetSource            : string    ; begin Result := GetStringField('Source');end;
function  TMarketingContact.GetNumUnansweredCalls: Integer   ; begin Result := GetIntegerField('NumUnansweredCalls');end;
function TMarketingContact.GetOtherContactName: string;
begin
  if ClientID > 0 then
    result:= TOtherContact.IDToggle(ClientID,Connection.Connection)
  else
    result:= '';
end;

function TMarketingContact.GetDoNotContact: boolean;
begin
  result := GetBooleanField('DoNotContact');
end;

function  TMarketingContact.GetDoNotQualify      : Boolean   ; begin Result := GetBooleanField('DoNotQualify');end;
function  TMarketingContact.GetClientID          : Integer   ; begin Result := GetIntegerField('ClientID');end;
function  TMarketingContact.GetRepID :Integer; begin REsult := getIntegerfield('RepID'); end;
function  TMarketingContact.GetMedTypeID:Integer; begin REsult := getIntegerfield('MedTypeID'); end;
function  TMarketingContact.GetREpName:String; begin REsult := getStringfield('REpName'); end;
function  TMarketingContact.GetCUSTFLD1 :String; begin REsult := getStringfield('CUSTFLD1'); end;
function  TMarketingContact.GetCUSTFLD2 :String; begin REsult := getStringfield('CUSTFLD2'); end;
function  TMarketingContact.GetCUSTFLD3 :String; begin REsult := getStringfield('CUSTFLD3'); end;
function  TMarketingContact.GetCUSTFLD4 :String; begin REsult := getStringfield('CUSTFLD4'); end;
function  TMarketingContact.GetCUSTFLD5 :String; begin REsult := getStringfield('CUSTFLD5'); end;
function  TMarketingContact.GetCUSTFLD6 :String; begin REsult := getStringfield('CUSTFLD6'); end;
function  TMarketingContact.GetCUSTFLD7 :String; begin REsult := getStringfield('CUSTFLD7'); end;
function  TMarketingContact.GetCUSTFLD8 :String; begin REsult := getStringfield('CUSTFLD8'); end;
function  TMarketingContact.GetCUSTFLD9 :String; begin REsult := getStringfield('CUSTFLD9'); end;
function  TMarketingContact.GetCUSTFLD10 :String; begin REsult := getStringfield('CUSTFLD10'); end;
function  TMarketingContact.GetCUSTFLD11 :String; begin REsult := getStringfield('CUSTFLD11'); end;
function  TMarketingContact.GetCUSTFLD12 :String; begin REsult := getStringfield('CUSTFLD12'); end;
function  TMarketingContact.GetCUSTFLD13 :String; begin REsult := getStringfield('CUSTFLD13'); end;
function  TMarketingContact.GetCUSTFLD14 :String; begin REsult := getStringfield('CUSTFLD14'); end;
function  TMarketingContact.GetCUSTFLD15 :String; begin REsult := getStringfield('CUSTFLD15'); end;
function TMarketingContact.getcurrentEmailID: String;
begin
  Result := '';
  if ClientID <> 0 then begin
    with TClient.Create(Self) do try
      Connection := Self.Connection;
      Load(clientID);
      if count >0 then
        result := Email;
    finally
        Free;
    end;
  end;
  if result = '' then result := Email;
end;

function  TMarketingContact.GetCUSTDATE1 :TDateTime; begin REsult := getDateTimefield('CUSTDATE1'); end;
function  TMarketingContact.GetCUSTDATE2 :TDateTime; begin REsult := getDateTimefield('CUSTDATE2'); end;
function  TMarketingContact.GetCUSTDATE3 :TDateTime; begin REsult := getDateTimefield('CUSTDATE3'); end;


procedure TMarketingContact.SetCompanyTypeName   (const Value: string    ); begin SetStringField('CompanyTypeName'    , Value);end;
procedure TMarketingContact.SetCOMPANY           (const Value: string    ); begin SetStringField('COMPANY'            , Value);end;
procedure TMarketingContact.SetStreet            (const Value: string    ); begin SetStringField('Street'             , Value);end;
procedure TMarketingContact.SetStreet2           (const Value: string    ); begin SetStringField('Street2'            , Value);end;
procedure TMarketingContact.SetStreet3           (const Value: string    ); begin SetStringField('Street3'            , Value);end;
procedure TMarketingContact.SetSUBURB            (const Value: string    ); begin SetStringField('SUBURB'             , Value);end;
procedure TMarketingContact.SetSTATE             (const Value: string    ); begin SetStringField('STATE'              , Value);end;
procedure TMarketingContact.SetPOSTCODE          (const Value: string    ); begin SetStringField('POSTCODE'           , Value);end;
procedure TMarketingContact.SetCountry           (const Value: string    ); begin SetStringField('Country'            , Value);end;

procedure TMarketingContact.SetBillStreet            (const Value: string    ); begin SetStringField('BillStreet'             , Value);end;
procedure TMarketingContact.SetBillStreet2           (const Value: string    ); begin SetStringField('BillStreet2'            , Value);end;
procedure TMarketingContact.SetBillStreet3           (const Value: string    ); begin SetStringField('BillStreet3'            , Value);end;
procedure TMarketingContact.SetBillSUBURB            (const Value: string    ); begin SetStringField('BillSUBURB'             , Value);end;
procedure TMarketingContact.setCallPriority(const Value: Integer);begin  SetIntegerField('CallPriority',Value);end;

procedure TMarketingContact.SetBillSTATE             (const Value: string    ); begin SetStringField('BillSTATE'              , Value);end;
procedure TMarketingContact.SetBillPOSTCODE          (const Value: string    ); begin SetStringField('BillPOSTCODE'           , Value);end;
procedure TMarketingContact.SetBillCountry           (const Value: string    ); begin SetStringField('BillCountry'            , Value);end;

procedure TMarketingContact.SetFaxNumber         (const Value: string    ); begin SetStringField('FaxNumber'          , Value);end;
procedure TMarketingContact.SetPhone             (const Value: string    ); begin SetStringField('Phone'              , Value);end;
procedure TMarketingContact.SetAltPhone          (const Value: string    ); begin SetStringField('AltPhone'           , Value);end;
procedure TMarketingContact.SetMobile            (const Value: string    ); begin SetStringField('Mobile'             , Value);end;
procedure TMarketingContact.SetEmployeeSize      (const Value: string    ); begin SetStringField('EmployeeSize'       , Value);end;
procedure TMarketingContact.SetNotes             (const Value: string    ); begin SetStringField('Notes'              , Value);end;
procedure TMarketingContact.SetActive            (const Value: Boolean   ); begin SetBooleanField('Active'             , Value);end;
procedure TMarketingContact.SetJobTitle          (const Value: string    ); begin SetStringField('JobTitle'           , Value);end;
procedure TMarketingContact.SetTitle             (const Value: string    ); begin SetStringField('Title'              , Value);end;
procedure TMarketingContact.SetFirstName         (const Value: string    ); begin SetStringField('FirstName'          , Value);end;
procedure TMarketingContact.SetMiddleName        (const Value: string    ); begin SetStringField('MiddleName'         , Value);end;
procedure TMarketingContact.SetLastName          (const Value: string    ); begin SetStringField('LastName'           , Value);end;
procedure TMarketingContact.SetEmail             (const Value: string    ); begin SetStringField('Email'              , Value);end;
procedure TMarketingContact.SetDateEntered       (const Value: TDateTime ); begin SetDateTimeField('DateEntered'        , Value);end;
procedure TMarketingContact.SetCreatedOn         (const Value: TDateTime ); begin SetDateTimeField('CreatedOn'        , Value);end;
procedure TMarketingContact.SetEnteredEmpID      (const Value: Integer   ); begin SetIntegerField('EnteredEmpID'       , Value);end;
procedure TMarketingContact.SetDateOfBirth       (const Value: TDateTime ); begin SetDateTimeField('DateOfBirth'        , Value);end;
procedure TMarketingContact.setDefaultContactMethod(const Value: String);  begin  SetStringField('DefaultContactMethod' , value);end;

procedure TMarketingContact.SetDuration          (const Value: TDateTime ); begin SetDateTimeField('Duration'           , Value);end;
procedure TMarketingContact.SetSkypeName(const Value: string);
begin
  SetStringField('SkypeName',Value);
end;

procedure TMarketingContact.SetSource            (const Value: string    ); begin SetStringField('Source'             , Value);end;
procedure TMarketingContact.SetNumUnansweredCalls(const Value: Integer   ); begin SetIntegerField('NumUnansweredCalls'             , Value);end;
procedure TMarketingContact.SetOtherContactName(const Value: string);
begin
  ClientID:= TOtherContact.IDToggle(Value, Connection.Connection);
end;

procedure TMarketingContact.SetDoNotContact(const Value: boolean);
begin
  SetBooleanField('DoNotContact', Value);
end;

procedure TMarketingContact.SetDoNotQualify      (const Value: Boolean   ); begin SetBooleanField('DoNotQualify'       , Value);end;
procedure TMarketingContact.SetClientID          (const Value: Integer   ); begin SetIntegerField('ClientID'           , Value);end;
procedure TMarketingContact.SetRepID             (Const Value :Integer); begin SetIntegerField('RepID' , Value ); end;
procedure TMarketingContact.SetMedTypeID         (Const Value :Integer); begin SetIntegerField('MedTypeID' , Value ); end;
procedure TMarketingContact.SetREpName           (Const Value :String); begin SetStringField('REpName' , Value ); end;
procedure TMarketingContact.SetCUSTFLD1          (Const Value :String); begin SetStringField('CUSTFLD1' , Value ); end;
procedure TMarketingContact.SetCUSTFLD2          (Const Value :String); begin SetStringField('CUSTFLD2' , Value ); end;
procedure TMarketingContact.SetCUSTFLD3          (Const Value :String); begin SetStringField('CUSTFLD3' , Value ); end;
procedure TMarketingContact.SetCUSTFLD4          (Const Value :String); begin SetStringField('CUSTFLD4' , Value ); end;
procedure TMarketingContact.SetCUSTFLD5          (Const Value :String); begin SetStringField('CUSTFLD5' , Value ); end;
procedure TMarketingContact.SetCUSTFLD6          (Const Value :String); begin SetStringField('CUSTFLD6' , Value ); end;
procedure TMarketingContact.SetCUSTFLD7          (Const Value :String); begin SetStringField('CUSTFLD7' , Value ); end;
procedure TMarketingContact.SetCUSTFLD8          (Const Value :String); begin SetStringField('CUSTFLD8' , Value ); end;
procedure TMarketingContact.SetCUSTFLD9          (Const Value :String); begin SetStringField('CUSTFLD9' , Value ); end;
procedure TMarketingContact.SetCustomerName(const Value: string);
begin
  ClientID:= TCustomer.IDToggle(Value, Connection.Connection);
end;

procedure TMarketingContact.SetCUSTFLD10         (Const Value :String); begin SetStringField('CUSTFLD10' , Value ); end;
procedure TMarketingContact.SetCUSTFLD11         (Const Value :String); begin SetStringField('CUSTFLD11' , Value ); end;
procedure TMarketingContact.SetCUSTFLD12         (Const Value :String); begin SetStringField('CUSTFLD12' , Value ); end;
procedure TMarketingContact.SetCUSTFLD13         (Const Value :String); begin SetStringField('CUSTFLD13' , Value ); end;
procedure TMarketingContact.SetCUSTFLD14         (Const Value :String); begin SetStringField('CUSTFLD14' , Value ); end;
procedure TMarketingContact.SetCUSTFLD15         (Const Value :String); begin SetStringField('CUSTFLD15' , Value ); end;
procedure TMarketingContact.SetCUSTDATE1         (Const Value :TDateTime); begin SetDatetimeField('CUSTDATE1' , Value ); end;
procedure TMarketingContact.SetCUSTDATE2         (Const Value :TDateTime); begin SetDatetimeField('CUSTDATE2' , Value ); end;
procedure TMarketingContact.SetCUSTDATE3         (Const Value :TDateTime); begin SetDatetimeField('CUSTDATE3' , Value ); end;
function TMarketingContact.GetURL: string;
begin
  result:= GetStringField('URL');
end;

function TMarketingContact.HasLead: Boolean;
var
  Qry:TERPQuery;
begin
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    With Qry  do begin
      SQL.text := 'SELECT LeadID, islead FROM tblmarketingleads where MarketingContactID= ' + inttostr(ID);
      Open;
      result := (recordcount >0) and (Fieldbyname('ISLead').AsBoolean);
    end;
  finally
    DbSharedObj.releaseobj(Qry);
  end;
end;

function TMarketingContact.HasTelemarketing: Boolean;
var
  Qry:TERPQuery;
begin
  Qry := DbSharedObj.GetQuery(CommonDBLib.GetSharedMyDacConnection);
  try
    With Qry  do begin
      SQL.text := 'SELECT LeadID FROM tblmarketingleads where MarketingContactID= ' + inttostr(ID);
      open;
      result := (recordcount >0) ;
    end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;

procedure TMarketingContact.SetURL(const Value: string);
begin
  SetStringField('URL',Value);
end;


function TMarketingContact.getRelatedContacts: TRelatedContacts;
begin
  Result := TRelatedContacts(getContainerComponent(TRelatedContacts, ' MasterContactId = ' + IntToStr(Self.ID)));
end;

function TMarketingContact.getMarketingContactContacts: TMarketingContactContact;
begin
  Result := TMarketingContactContact(getContainerComponent(TMarketingContactContact, ' MarketingContactID = ' + IntToStr(Self.ID)));
end;

function TMarketingContact.getMarketingContactProducts: TMarketingContactProduct;
begin
  Result := TMarketingContactProduct(getContainerComponent(TMarketingContactProduct, ' MarketingContactID = ' + IntToStr(Self.ID)));
end;

procedure TMarketingContact.CreateClientContacts(const Sender: TBusObj;var Abort: boolean);
begin
  if not(sender is TMarketingContactContact) then exit;
  if not(Assigned(fClient)) then exit;
  fClient.Contacts.New;
  fClient.Contacts.ClientID := fClient.ID;
  fClient.Contacts.Company                := TMarketingContactContact(Sender).Company         ;
  fClient.Contacts.ContactTitle           := TMarketingContactContact(Sender).ContactTitle    ;
  fClient.Contacts.ContactFirstName       := TMarketingContactContact(Sender).ContactFirstName;
  fClient.Contacts.ContactSurName         := TMarketingContactContact(Sender).ContactSurName  ;
  fClient.Contacts.ContactAddress         := TMarketingContactContact(Sender).ContactAddress  ;
  fClient.Contacts.ContactAddress2        := TMarketingContactContact(Sender).ContactAddress2 ;
  fClient.Contacts.ContactAddress3        := TMarketingContactContact(Sender).ContactAddress3 ;
  fClient.Contacts.ContactCity            := TMarketingContactContact(Sender).ContactCity     ;
  fClient.Contacts.ContactState           := TMarketingContactContact(Sender).ContactState    ;
  fClient.Contacts.ContactPcode           := TMarketingContactContact(Sender).ContactPcode    ;
  fClient.Contacts.ContactCountry         := TMarketingContactContact(Sender).ContactCountry  ;
  fClient.Contacts.ContactPH              := TMarketingContactContact(Sender).ContactPH       ;
  fClient.Contacts.ContactAltPH           := TMarketingContactContact(Sender).ContactAltPH    ;
  fClient.Contacts.ContactMOB             := TMarketingContactContact(Sender).ContactMOB      ;
  fClient.Contacts.ContactFax             := TMarketingContactContact(Sender).ContactFax      ;
  fClient.Contacts.ContactEmail           := TMarketingContactContact(Sender).ContactEmail    ;
  fClient.Contacts.Notes                  := TMarketingContactContact(Sender).Notes           ;
  fClient.Contacts.Active                 := TMarketingContactContact(Sender).Active          ;
  fClient.Contacts.CardNumber             := TMarketingContactContact(Sender).CardNumber      ;
  fClient.Contacts.AccountNo              := TMarketingContactContact(Sender).AccountNo       ;
  fClient.Contacts.JobTitle               := TMarketingContactContact(Sender).JobTitle        ;
  fClient.Contacts.IsPrimarycontact       := TMarketingContactContact(Sender).IsPrimarycontact;
  fClient.Contacts.PostDB;
end;

{TRelatedContacts}

constructor TRelatedContacts.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'RelatedContacts';
  fSQL := 'SELECT * FROM tblrelatedcontacts';
  fIsList := true;
end;


destructor TRelatedContacts.Destroy;
begin
  inherited;
end;


procedure TRelatedContacts.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'MasterContactID');
  SetPropertyFromNode(node,'MasterCompany');
  SetPropertyFromNode(node,'ChildContactID');
  SetPropertyFromNode(node,'ChildCompany');
  SetBooleanPropertyFromNode(node,'Customer');
  SetBooleanPropertyFromNode(node,'Supplier');
  SetBooleanPropertyFromNode(node,'OtherContact');
  SetBooleanPropertyFromNode(node,'Marketingcontact');
end;


procedure TRelatedContacts.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'MasterContactID' ,MasterContactID);
  AddXMLNode(node,'MasterCompany' ,MasterCompany);
  AddXMLNode(node,'ChildContactID' ,ChildContactID);
  AddXMLNode(node,'ChildCompany' ,ChildCompany);
  AddXMLNode(node,'Customer' ,Customer);
  AddXMLNode(node,'Supplier' ,Supplier);
  AddXMLNode(node,'OtherContact' ,OtherContact);
  AddXMLNode(node,'Marketingcontact' ,Marketingcontact);
end;


function TRelatedContacts.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := True;
end;


function TRelatedContacts.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TRelatedContacts.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TRelatedContacts.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TRelatedContacts.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TRelatedContacts.GetIDField: string;
begin
  Result := 'RelatedContactID'
end;


class function TRelatedContacts.GetBusObjectTablename: string;
begin
  Result:= 'tblrelatedcontacts';
end;


function TRelatedContacts.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TRelatedContacts.GetMasterContactID : Integer   ; begin Result := GetIntegerField('MasterContactID');end;
function  TRelatedContacts.GetMasterCompany   : string    ; begin Result := GetStringField('MasterCompany');end;
function  TRelatedContacts.GetChildContactID  : Integer   ; begin Result := GetIntegerField('ChildContactID');end;
function  TRelatedContacts.GetChildCompany    : string    ; begin Result := GetStringField('ChildCompany');end;
function  TRelatedContacts.GetCustomer        : Boolean   ; begin Result := GetBooleanField('Customer');end;
function  TRelatedContacts.GetSupplier        : Boolean   ; begin Result := GetBooleanField('Supplier');end;
function  TRelatedContacts.GetOtherContact    : Boolean   ; begin Result := GetBooleanField('OtherContact');end;
function  TRelatedContacts.GetMarketingcontact: Boolean   ; begin Result := GetBooleanField('Marketingcontact');end;
procedure TRelatedContacts.SetMasterContactID (const Value: Integer   ); begin SetIntegerField('MasterContactID' , Value);end;
procedure TRelatedContacts.SetMasterCompany   (const Value: string    ); begin SetStringField('MasterCompany'    , Value);end;
procedure TRelatedContacts.SetChildContactID  (const Value: Integer   ); begin SetIntegerField('ChildContactID'   , Value);end;
procedure TRelatedContacts.SetChildCompany    (const Value: string    ); begin SetStringField('ChildCompany'     , Value);end;
procedure TRelatedContacts.SetCustomer        (const Value: Boolean   ); begin SetBooleanField('Customer'         , Value);end;
procedure TRelatedContacts.SetSupplier        (const Value: Boolean   ); begin SetBooleanField('Supplier'         , Value);end;
procedure TRelatedContacts.SetOtherContact    (const Value: Boolean   ); begin SetBooleanField('OtherContact'     , Value);end;
procedure TRelatedContacts.SetMarketingcontact(const Value: Boolean   ); begin SetBooleanField('Marketingcontact'     , Value);end;


function TRelatedContacts.DoAfterInsert(sender: TDatasetBusobj): Boolean;
begin
  result := inherited DoAfterInsert(Sender);
  if not result then Exit;
  if assigned(Self.Owner) then
    if Self.Owner is TMarketingContact then
      MasterContactID := TMarketingContact(Self.Owner).ID;
end;

  {TMarketingContactProduct}

constructor TMarketingContactProduct.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'MarketingContactProducts';
  fSQL := 'SELECT * FROM tblmarketingcontactproducts';
  fIsList := true;
  ExportExcludeList.Add('marketingcontactid');
  ExportExcludeList.Add('productid');
end;


destructor TMarketingContactProduct.Destroy;
begin
  inherited;
end;


procedure TMarketingContactProduct.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'MarketingcontactId');
  SetPropertyFromNode(node,'ProductID');
  SetPropertyFromNode(node,'ProductName');
  SetPropertyFromNode(node,'ProductPrintName');
  SetPropertyFromNode(node,'Description');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TMarketingContactProduct.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'MarketingcontactId' ,MarketingcontactId);
  AddXMLNode(node,'ProductID' ,ProductID);
  AddXMLNode(node,'ProductName' ,ProductName);
  AddXMLNode(node,'ProductPrintName' ,ProductPrintName);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'Active' ,Active);
end;


function TMarketingContactProduct.ValidateData: Boolean ;
begin
  Result := False;
  if (ProductId = 0) or (ProductName = '') then begin
    AddResult(False, rssWarning ,0, 'Product should not be blank');
    Exit;
  end;
  if self.MarketingContactID < 1 then begin
    AddResult(False, rssWarning, 0, 'Marketing Contact should not be blank');
    Exit;
  end;
  Result := True;
end;


function TMarketingContactProduct.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TMarketingContactProduct.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure TMarketingContactProduct.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;

  if Sysutils.SameText(Sender.fieldName , 'ProductName') then begin
    ProductId:= TProduct.IDToggle(Sender.AsString,Connection.Connection);
  end;
end;


function TMarketingContactProduct.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TMarketingContactProduct.GetIDField: string;
begin
  Result := 'ID'
end;


class function TMarketingContactProduct.GetBusObjectTablename: string;
begin
  Result:= 'tblmarketingcontactproducts';
end;


function TMarketingContactProduct.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;


{Property Functions}
function  TMarketingContactProduct.GetMarketingcontactId: Integer   ; begin Result := GetIntegerField('MarketingcontactId');end;
function  TMarketingContactProduct.GetProductID         : Integer   ; begin Result := GetIntegerField('ProductID');end;
function  TMarketingContactProduct.GetProductName       : string    ; begin Result := GetStringField('ProductName');end;
function  TMarketingContactProduct.GetProductPrintName  : string    ; begin Result := GetStringField('ProductPrintName');end;
function  TMarketingContactProduct.GetDescription       : string    ; begin Result := GetStringField('Description');end;
function  TMarketingContactProduct.GetActive            : Boolean   ; begin Result := GetBooleanField('Active');end;
procedure TMarketingContactProduct.SetMarketingcontactId(const Value: Integer   ); begin SetIntegerField('MarketingcontactId' , Value);end;
procedure TMarketingContactProduct.SetProductID         (const Value: Integer   ); begin SetIntegerField('ProductID'          , Value);end;
procedure TMarketingContactProduct.SetProductName       (const Value: string    ); begin SetStringField('ProductName'        , Value);end;
procedure TMarketingContactProduct.SetProductPrintName  (const Value: string    ); begin SetStringField('ProductPrintName'   , Value);end;
procedure TMarketingContactProduct.SetDescription       (const Value: string    ); begin SetStringField('Description'        , Value);end;
procedure TMarketingContactProduct.SetActive            (const Value: Boolean   ); begin SetBooleanField('Active'             , Value);end;


function TMarketingContactProduct.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not result then exit;
  Active := true;
  if assigned(Self.Owner) then
    if Self.Owner is TMarketingContact then
      MarketingcontactId := TMarketingContact(Self.Owner).ID;
end;

function TMarketingContactProduct.GetMarketingContactCompany: string;
begin
  result:= TMarketingContact.IDToggle(MarketingContactID,Connection.Connection)
end;

procedure TMarketingContactProduct.SetMarketingContactCompany(
  const Value: string);
begin
  MarketingContactID:= TMarketingContact.IDToggle(Value,Connection.Connection);
end;

{ TMarketingContactContact }

constructor TMarketingContactContact.Create(AOwner: TComponent);
begin
  inherited;
  fSQL:= 'select * from tblmarketingcontactcontacts';
  ExportExcludeList.Add('Company');
  fIsList:= true;
end;

function TMarketingContactContact.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  REsult := inherited DoAfterInsert(Sender);
  if not result then exit;
  if assigned(Self.Owner) then
    if Self.Owner is TMarketingContact then
      MarketingcontactId := TMarketingContact(Self.Owner).ID;
end;

procedure TMarketingContactContact.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
      if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
end;

class function TMarketingContactContact.GetBusObjectTablename: string;
begin
  result:= 'tblmarketingcontactcontacts';
end;

function TMarketingContactContact.GetCompany: string;
begin
  result:= inherited GetCompany;
end;

function TMarketingContactContact.getMarketingContact: TMarketingContact;
begin
  if Assigned(Owner) and (Owner is TMarketingContact) then begin
    result := TMarketingContact(Owner);
  end else begin
    Result := TMarketingContact(getContainerComponent(TMarketingContact, ' ID = ' + IntToStr(Self.MarketingContactID)));
  end;
end;

function TMarketingContactContact.GetMarketingContactID: Integer;
begin
  result:= GetIntegerField('MarketingContactID');
end;

function TMarketingContactContact.GetMarketiongContactCompany: string;
begin
  result:= TMarketingContact.IDToggle(MarketingContactID,Connection.Connection);
end;

procedure TMarketingContactContact.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'MarketingContactID');
end;

function TMarketingContactContact.Save: Boolean;
var
  cmd: TMyCommand;
begin
  result:= inherited Save;
  if result and IsPrimaryContact then begin
    cmd:= TMyCommand.Create(nil);
    try
      cmd.Connection:= Connection.Connection;
      cmd.SQL.Add('update tblmarketingcontactcontacts');
      cmd.SQL.Add('set IsPrimaryContact = "F"');
      cmd.SQL.Add('where MarketingContactID = ' + IntToStr(MarketingContactId));
      cmd.SQL.Add('and ContactID <> ' + IntToStr(ID));
      cmd.Execute;
    finally
      cmd.Free;
    end;
  end;
end;

procedure TMarketingContactContact.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'MarketingContactID' ,MarketingContactID);
end;

procedure TMarketingContactContact.SetCompany(const Value: string);
begin
  inherited SetCompany(Value);
end;

procedure TMarketingContactContact.SetMarketingContactCompany(
  const Value: string);
begin
  MarketingContactID:= TMarketingContact.IDToggle(Value,Connection.Connection);
end;

procedure TMarketingContactContact.SetMarketingContactID(
  const Value: Integer);
begin
  SetIntegerField('MarketingContactID',Value);
end;

function TMarketingContactContact.ValidateData: Boolean;
var
  CleanContactName: string;
begin
  if Trim(ContactName) = '' then begin
    result:= false;
    AddResult(False, rssWarning, 0, 'Contact Name should not be blank');
    exit;
  end;
  CleanContactName:= self.GetXMLNodeStringValue(self.CleanXMLNode,'Company');
  if (CleanContactName <> '') and (CleanContactName <> ContactName) then begin
    result:= false;
    AddResult(False, rssWarning, 0, 'Contact "' + CleanContactName +
    '" can not re renamed to "'+ContactName+ '" for existing record');
    exit;
  end;

  result:= inherited ValidateData;
  if result then begin
    result:= false;
    if self.MarketingContactID < 1 then begin
      AddResult(False, rssWarning, 0, 'Marketing Contact should not be blank');
      exit;
    end;
    result:= true;
  end;
end;

initialization
  RegisterClass(TMarketingContactProduct);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Marketing Contact Product','TMarketingContactProduct','TMarketingContactProductListGUI');
  RegisterClass(TContactBase);
  RegisterClass(TRelatedContacts);
  RegisterClassOnce(TMarketingContact);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Marketing Contact','TMarketingContact','TMarketingContactListGUI');
  RegisterClassOnce(TMarketingContactContact);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Marketing Contact Contact','TMarketingContactContact','TMarketingContactcontactListGUI');


end.
