unit BusObjContact;

interface

uses
   ERPDBComponents,BusObjBase, DB, classes, XMLDoc, XMLIntf, busobjcustomfields;

type

  TContactBase = class(TMSBusObj)
  private
    function GetContactTitle          : string    ;
    function GetContactFirstName      : string    ;
    function GetContactSurName        : string    ;
    function GetContactAddress        : string    ;
    function GetContactAddress2       : string    ;
    function GetContactAddress3       : string    ;
    function GetContactCity           : string    ;
    function GetContactState          : string    ;
    function GetContactPcode          : string    ;
    function GetContactCountry        : string    ;
    function GetTeamviewerID          : string    ;
    function GetContactPH             : string    ;
    function GetContactAltPH          : string    ;
    function GetContactMOB            : string    ;
    function GetContactFax            : string    ;
    function GetContactEmail          : string    ;
    function GetNotes                 : string    ;
    function GetActive                : Boolean   ;
    function GetCardNumber            : string    ;
    function GetAccountNo             : string    ;
    function GetJobTitle              : string    ;
    function GetIsPrimarycontact      : Boolean   ;
    procedure SetContactTitle          (const Value: string    );
    procedure SetContactFirstName      (const Value: string    );
    procedure SetContactSurName        (const Value: string    );
    procedure SetContactAddress        (const Value: string    );
    procedure SetContactAddress2       (const Value: string    );
    procedure SetContactAddress3       (const Value: string    );
    procedure SetContactCity           (const Value: string    );
    procedure SetContactState          (const Value: string    );
    procedure SetContactPcode          (const Value: string    );
    procedure SetContactCountry        (const Value: string    );
    procedure SetTeamviewerID          (const Value: string    );
    procedure SetContactPH             (const Value: string    );
    procedure SetContactAltPH          (const Value: string    );
    procedure SetContactMOB            (const Value: string    );
    procedure SetContactFax            (const Value: string    );
    procedure SetContactEmail          (const Value: string    );
    procedure SetNotes                 (const Value: string    );
    procedure SetActive                (const Value: Boolean   );
    procedure SetCardNumber            (const Value: string    );
    procedure SetAccountNo             (const Value: string    );
    procedure SetJobTitle              (const Value: string    );
    procedure SetIsPrimarycontact      (const Value: Boolean   );
    function GetDoNotContact: boolean;
    procedure SetDoNotContact(const Value: boolean);
    function GetFullName: string;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  DoAfterPost(Sender:TDatasetBusObj): Boolean; override;
    function GetCompany: string; virtual;
    procedure SetCompany(const Value: string); virtual;
    function GetIsList: boolean; override;
  public
    procedure DoFieldOnChange(Sender: TField); override;
    class function GetIDField: string; override;
    class function GetKeyStringField: string;  override;
    constructor  Create(AOwner: TComponent); override;
    destructor   Destroy; override;
    procedure    LoadFromXMLNode(const node: IXMLNode); override;
    procedure    SaveToXMLNode(const node: IXMLNode); override;
    function     ValidateData: Boolean; override;
    function     Save: Boolean; override;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    property FullName: string read GetFullName;
  published
    property Company                :string      read GetCompany              write SetCompany           ;
    property ContactTitle           :string      read GetContactTitle         write SetContactTitle      ;
    property ContactFirstName       :string      read GetContactFirstName     write SetContactFirstName  ;
    property ContactSurName         :string      read GetContactSurName       write SetContactSurName    ;
    property ContactAddress         :string      read GetContactAddress       write SetContactAddress    ;
    property ContactAddress2        :string      read GetContactAddress2      write SetContactAddress2   ;
    property ContactAddress3        :string      read GetContactAddress3      write SetContactAddress3   ;
    property ContactCity            :string      read GetContactCity          write SetContactCity       ;
    property ContactState           :string      read GetContactState         write SetContactState      ;
    property ContactPcode           :string      read GetContactPcode         write SetContactPcode      ;
    property ContactCountry         :string      read GetContactCountry       write SetContactCountry    ;
    property TeamviewerID           :string      read GetTeamviewerID         write SetTeamviewerID      ;
    property ContactPH              :string      read GetContactPH            write SetContactPH         ;
    property ContactAltPH           :string      read GetContactAltPH         write SetContactAltPH      ;
    property ContactMOB             :string      read GetContactMOB           write SetContactMOB        ;
    property ContactFax             :string      read GetContactFax           write SetContactFax        ;
    property ContactEmail           :string      read GetContactEmail         write SetContactEmail      ;
    property Notes                  :string      read GetNotes                write SetNotes             ;
    property Active                 :Boolean     read GetActive               write SetActive            ;
    property CardNumber             :string      read GetCardNumber           write SetCardNumber        ;
    property AccountNo              :string      read GetAccountNo            write SetAccountNo         ;
    property JobTitle               :string      read GetJobTitle             write SetJobTitle          ;
    property IsPrimaryContact       :Boolean     read GetIsPrimarycontact     write SetIsPrimarycontact  ;
    property DoNotContact: boolean read GetDoNotContact write SetDoNotContact;
  end;

  TContact = class(TContactBase)
  Private
    Function  GetUseOnRun			: Boolean;
    Procedure SetUseOnRun			(Const Value: Boolean);
    function GetClientID: integer;
    function GetClientName: string;
    procedure SetClientID(const Value: integer);
    procedure SetClientName(const Value: string);
    procedure UpdateClientInfo;
    function getcontactfullName: String;
    function GetMainContactforCashSale      : Boolean   ;
    function GetMainContactforVoucher       : Boolean   ;
    function GetMainContactforPOS           : Boolean   ;
    function GetMainContactforRefund        : Boolean   ;
    function GetMainContactforInvoice       : Boolean   ;
    function GetMainContactforSalesOrder    : Boolean   ;
    function GetMainContactforStatements    : Boolean   ;
    function GetMainContactforQuote         : Boolean   ;
    function GetMainContactforCheque        : Boolean   ;
    function GetMainContactforCredit        : Boolean   ;
    function GetMainContactforBill          : Boolean   ;
    function GetMainContactforPO            : Boolean   ;
    function GetMainContactforRA            : Boolean   ;
    function GetNotaMainContact             : Boolean   ;
    function GetMainContactforRepair        : Boolean   ;
    procedure SetMainContactforCashSale      (const Value: Boolean   );
    procedure SetMainContactforVoucher       (const Value: Boolean   );
    procedure SetMainContactforPOS           (const Value: Boolean   );
    procedure SetMainContactforRefund        (const Value: Boolean   );
    procedure SetMainContactforInvoice       (const Value: Boolean   );
    procedure SetMainContactforSalesOrder    (const Value: Boolean   );
    procedure SetMainContactforStatements    (const Value: Boolean   );
    procedure SetMainContactforQuote         (const Value: Boolean   );
    procedure SetMainContactforCheque        (const Value: Boolean   );
    procedure SetMainContactforCredit        (const Value: Boolean   );
    procedure SetMainContactforBill          (const Value: Boolean   );
    procedure SetMainContactforPO            (const Value: Boolean   );
    procedure SetMainContactforRA            (const Value: Boolean   );
    procedure SetNotaMainContact             (const Value: Boolean   );
    procedure SetMainContactforRepair        (const Value: Boolean   );
    procedure ValidateMainContactFlags(Sender: TField);
    function getContactDetails: String;
    function getcontactcityDetails: String;
    function GetMainContactforSupplierPayment: Boolean;
    procedure SetMainContactforSupplierPayment(const Value: Boolean);
    function GetClientrCustomFieldValues: TContactCustomFieldValues;
  Protected
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean; override;
    Function  DoBeforePost(Sender :TDatasetBusObj ):Boolean; override;
    procedure DoFieldOnChange(Sender: TField); override;
  Public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; Override;
    class function GetKeyStringField: string; override;
    class function GetKeyStringProperty: string; override;
    constructor Create(AOwner: TComponent);     Override;
    function    ValidateData :Boolean ;         Override;
    function    Save :Boolean ;                 Override;
    procedure   SaveToXMLNode(const Node: IXMLNode);  Override;
    procedure   LoadFromXMLNode(const Node: IXMLNode);Override;
    class function _Schema: string; override;
    Class function contactname(const ID: Integer; Connection: TERPConnection = nil): string;
    Class function contactID(const contactName,clientName: string; Connection: TERPConnection = nil): Integer;
    Property contactfullname:String read getcontactfullName;
    Property ContactDetails :String read getContactDetails;
    Property contactcityDetails :String read getcontactcityDetails;
    class function ContactEmailForType(aClientId: integer; aMainContactForFieldName: string; Connection: TERPConnection = nil): string;
  published
    property ClientID: integer read GetClientID write SetClientID;
    property ClientName: string read GetClientName write SetClientName;
    Property	UseOnRun				    : Boolean	Read getUseOnRun			Write SetUseOnRun;
    property MainContactforCashSale       :Boolean     read GetMainContactforCashSale     write SetMainContactforCashSale  ;
    property MainContactforVoucher        :Boolean     read GetMainContactforVoucher      write SetMainContactforVoucher   ;
    property MainContactforPOS            :Boolean     read GetMainContactforPOS          write SetMainContactforPOS       ;
    property MainContactforRefund         :Boolean     read GetMainContactforRefund       write SetMainContactforRefund    ;
    property MainContactforInvoice        :Boolean     read GetMainContactforInvoice      write SetMainContactforInvoice   ;
    property MainContactforSalesOrder     :Boolean     read GetMainContactforSalesOrder   write SetMainContactforSalesOrder;
    property MainContactforStatements     :Boolean     read GetMainContactforStatements   write SetMainContactforStatements;
    property MainContactforQuote          :Boolean     read GetMainContactforQuote        write SetMainContactforQuote     ;
    property MainContactforCheque         :Boolean     read GetMainContactforCheque       write SetMainContactforCheque    ;
    property MainContactforCredit         :Boolean     read GetMainContactforCredit       write SetMainContactforCredit    ;
    property MainContactforBill           :Boolean     read GetMainContactforBill         write SetMainContactforBill      ;
    property MainContactforPO             :Boolean     read GetMainContactforPO           write SetMainContactforPO        ;
    property MainContactforRA             :Boolean     read GetMainContactforRA           write SetMainContactforRA        ;
    property NotaMainContact              :Boolean     read GetNotaMainContact            write SetNotaMainContact         ;
    property MainContactforRepair         :Boolean     read GetMainContactforRepair       write SetMainContactforRepair    ;
    property MainContactforSupplierPayment: Boolean    read GetMainContactforSupplierPayment write SetMainContactforSupplierPayment;

    Property ContactCustomFieldValues :TContactCustomFieldValues Read GetClientrCustomFieldValues;

  end;


implementation


uses
  sysutils, BusObjUtils, tcdatautils, BusObjClient,
  BusObjEmployeeDetails, BusObjectListObj, BusObjSchemaLib,
  CommonDbLib, SMSUtils, DbSharedObjectsObj, CommonLib;

{TContactBase}

constructor TContactBase.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'MarketingContactContacts';
  fSQL := 'SELECT * FROM tblmarketingcontactcontacts';
  ExportExcludeList.Add('marketingcontactid');
end;

destructor TContactBase.Destroy;
begin
  inherited;
end;

procedure TContactBase.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'Company');
  SetPropertyFromNode(node,'ContactTitle');
  SetPropertyFromNode(node,'ContactFirstName');
  SetPropertyFromNode(node,'ContactSurName');
  SetPropertyFromNode(node,'ContactAddress');
  SetPropertyFromNode(node,'ContactAddress2');
  SetPropertyFromNode(node,'ContactAddress3');
  SetPropertyFromNode(node,'ContactCity');
  SetPropertyFromNode(node,'ContactState');
  SetPropertyFromNode(node,'ContactPcode');
  SetPropertyFromNode(node,'ContactCountry');
  SetPropertyFromNode(node,'TeamviewerID');
  SetPropertyFromNode(node,'ContactPH');
  SetPropertyFromNode(node,'ContactAltPH');
  SetPropertyFromNode(node,'ContactMOB');
  SetPropertyFromNode(node,'ContactFax');
  SetPropertyFromNode(node,'ContactEmail');
  SetPropertyFromNode(node,'Notes');
  SetBooleanPropertyFromNode(node,'Active');
  SetPropertyFromNode(node,'CardNumber');
  SetPropertyFromNode(node,'AccountNo');
  SetPropertyFromNode(node,'JobTitle');
  SetBooleanPropertyFromNode(node,'IsPrimarycontact');
  SetBooleanPropertyFromNode(node,'DoNotContact');
end;

procedure TContactBase.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'Company' ,Company);
  AddXMLNode(node,'ContactTitle' ,ContactTitle);
  AddXMLNode(node,'ContactFirstName' ,ContactFirstName);
  AddXMLNode(node,'ContactSurName' ,ContactSurName);
  AddXMLNode(node,'ContactAddress' ,ContactAddress);
  AddXMLNode(node,'ContactAddress2' ,ContactAddress2);
  AddXMLNode(node,'ContactAddress3' ,ContactAddress3);
  AddXMLNode(node,'ContactCity' ,ContactCity);
  AddXMLNode(node,'ContactState' ,ContactState);
  AddXMLNode(node,'ContactPcode' ,ContactPcode);
  AddXMLNode(node,'ContactCountry' ,ContactCountry);
  AddXMLNode(node,'TeamviewerID' ,TeamviewerID);
  AddXMLNode(node,'ContactPH' ,ContactPH);
  AddXMLNode(node,'ContactAltPH' ,ContactAltPH);
  AddXMLNode(node,'ContactMOB' ,ContactMOB);
  AddXMLNode(node,'ContactFax' ,ContactFax);
  AddXMLNode(node,'ContactEmail' ,ContactEmail);
  AddXMLNode(node,'Notes' ,Notes);
  AddXMLNode(node,'Active' ,Active);
  AddXMLNode(node,'CardNumber' ,CardNumber);
  AddXMLNode(node,'AccountNo' ,AccountNo);
  AddXMLNode(node,'JobTitle' ,JobTitle);
  AddXMLNode(node,'IsPrimarycontact' ,IsPrimarycontact);
  AddXMLNode(node,'DoNotContact', DoNotContact);
end;

function TContactBase.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  Result := false;
  if Trim(Company) = '' then begin
    AddResult(False, rssWarning, 0, 'Company should not be blank');
    exit
  end;
  result:= true;
end;

class function TContactBase._Schema: string;
begin
  result:= inherited;
end;

function TContactBase.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TContactBase.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TContactBase.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

class function TContactBase.GetIDField: string;
begin
  Result := 'ContactID'
end;

function TContactBase.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{Property Functions}
function  TContactBase.GetCompany           : string    ; begin Result := GetStringField('Company');end;
function  TContactBase.GetContactTitle      : string    ; begin Result := GetStringField('ContactTitle');end;
function  TContactBase.GetContactFirstName  : string    ; begin Result := GetStringField('ContactFirstName');end;
function  TContactBase.GetContactSurName    : string    ; begin Result := GetStringField('ContactSurName');end;
function  TContactBase.GetContactAddress    : string    ; begin Result := GetStringField('ContactAddress');end;
function  TContactBase.GetContactAddress2   : string    ; begin Result := GetStringField('ContactAddress2');end;
function  TContactBase.GetContactAddress3   : string    ; begin Result := GetStringField('ContactAddress3');end;
function  TContactBase.GetContactCity       : string    ; begin Result := GetStringField('ContactCity');end;
function  TContactBase.GetContactState      : string    ; begin Result := GetStringField('ContactState');end;
function  TContactBase.GetContactPcode      : string    ; begin Result := GetStringField('ContactPcode');end;
function  TContactBase.GetContactCountry    : string    ; begin Result := GetStringField('ContactCountry');end;
function  TContactBase.GetTeamviewerID      : string    ; begin Result := GetStringField('TeamviewerID');end;
function  TContactBase.GetContactPH         : string    ; begin Result := GetStringField('ContactPH');end;
function  TContactBase.GetContactAltPH      : string    ; begin Result := GetStringField('ContactAltPH');end;
function  TContactBase.GetContactMOB        : string    ; begin Result := GetStringField('ContactMOB');end;
function  TContactBase.GetContactFax        : string    ; begin Result := GetStringField('ContactFax');end;
function  TContactBase.GetContactEmail      : string    ; begin Result := GetStringField('ContactEmail');end;
function  TContactBase.GetNotes             : string    ; begin Result := GetStringField('Notes');end;
function  TContactBase.GetActive            : Boolean   ; begin Result := GetBooleanField('Active');end;
function  TContactBase.GetCardNumber        : string    ; begin Result := GetStringField('CardNumber');end;
function  TContactBase.GetAccountNo         : string    ; begin Result := GetStringField('AccountNo');end;
function  TContactBase.GetJobTitle          : string    ; begin Result := GetStringField('JobTitle');end;
function TContactBase.GetIsList: boolean;
begin
  result:= true;
end;

function  TContactBase.GetIsPrimarycontact  : Boolean   ; begin Result := GetBooleanField('IsPrimarycontact');end;
procedure TContactBase.SetCompany           (const Value: string    ); begin SetStringField('Company'            , Value);end;
procedure TContactBase.SetContactTitle      (const Value: string    ); begin SetStringField('ContactTitle'       , Value);end;
procedure TContactBase.SetContactFirstName  (const Value: string    ); begin SetStringField('ContactFirstName'   , Value);end;
procedure TContactBase.SetContactSurName    (const Value: string    ); begin SetStringField('ContactSurName'     , Value);end;
procedure TContactBase.SetContactAddress    (const Value: string    ); begin SetStringField('ContactAddress'     , Value);end;
procedure TContactBase.SetContactAddress2   (const Value: string    ); begin SetStringField('ContactAddress2'    , Value);end;
procedure TContactBase.SetContactAddress3   (const Value: string    ); begin SetStringField('ContactAddress3'    , Value);end;
procedure TContactBase.SetContactCity       (const Value: string    ); begin SetStringField('ContactCity'        , Value);end;
procedure TContactBase.SetContactState      (const Value: string    ); begin SetStringField('ContactState'       , Value);end;
procedure TContactBase.SetContactPcode      (const Value: string    ); begin SetStringField('ContactPcode'       , Value);end;
procedure TContactBase.SetContactCountry    (const Value: string    ); begin SetStringField('ContactCountry'     , Value);end;
procedure TContactBase.SetTeamviewerID      (const Value: string    ); begin SetStringField('TeamviewerID'     , Value);end;
procedure TContactBase.SetContactPH         (const Value: string    ); begin SetStringField('ContactPH'          , Value);end;
procedure TContactBase.SetContactAltPH      (const Value: string    ); begin SetStringField('ContactAltPH'       , Value);end;
procedure TContactBase.SetContactMOB        (const Value: string    ); begin SetStringField('ContactMOB'         , Value);end;
procedure TContactBase.SetContactFax        (const Value: string    ); begin SetStringField('ContactFax'         , Value);end;
procedure TContactBase.SetContactEmail      (const Value: string    ); begin SetStringField('ContactEmail'       , Value);end;
procedure TContactBase.SetNotes             (const Value: string    ); begin SetStringField('Notes'              , Value);end;
procedure TContactBase.SetActive            (const Value: Boolean   ); begin SetBooleanField('Active'             , Value);end;
procedure TContactBase.SetCardNumber        (const Value: string    ); begin SetStringField('CardNumber'         , Value);end;
procedure TContactBase.SetAccountNo         (const Value: string    ); begin SetStringField('AccountNo'          , Value);end;
procedure TContactBase.SetJobTitle          (const Value: string    ); begin SetStringField('JobTitle'           , Value);end;
procedure TContactBase.SetIsPrimarycontact  (const Value: Boolean   ); begin SetBooleanField('IsPrimarycontact'   , Value);end;

class function TContactBase.GetKeyStringField: string;
begin
  result := 'Company';
end;

class function TContactBase.GetKeyStringProperty: string;
begin
  result:= 'Company';
end;

function TContactBase.GetDoNotContact: boolean;
begin
  result := GetBooleanField('DoNotContact');
end;

function TContactBase.GetFullName: string;
begin
  Result := '';
  if ContactTitle <> '' then Result := Result + ContactTitle + ' ';
  if ContactFirstName <> '' then Result := Result + ContactFirstName + ' ';
  if ContactSurName <> '' then Result := Result + ContactSurName + ' ';
  Result := Trim(Result);
end;

procedure TContactBase.SetDoNotContact(const Value: boolean);
begin
  SetBooleanField('DoNotContact', Value);
end;


{ TContact }

function TContact.GetClientID: integer;
begin
  result:= GetIntegerField('ClientID');
end;

function TContact.GetClientName: string;
begin
  result:= GetStringField('ClientName');
end;

function TContact.GetClientrCustomFieldValues: TContactCustomFieldValues;
begin
  result := TContactCustomFieldValues(GetContainerComponent(TContactCustomFieldValues ,'MasterId = ' + IntToStr(Self.ID) ));
end;

function TContact.getcontactcityDetails: String;
begin
    result := ContactCity;
    result := trim(result + ' ' +ContactState);
    result := trim(result + ' ' +ContactPcode);
end;

function TContact.getContactDetails: String;
begin
  Result:= ConcatStrings([contactfullName , ContactAddress  , ContactAddress2  ,ContactAddress3 , contactcityDetails] ,#13+#10);
end;

function TContact.getcontactfullName: String;
begin
  Result:= ConcatStrings([ContactTitle ,ContactFirstName ,ContactSurName ], ' ');
  if result = '' then result := Company;
end;

Function TContact.GetUseOnRun	: Boolean	;
Begin
	Result :=  GetBooleanField('UseOnRun');
End;

procedure TContact.SetClientID(const Value: integer);
begin
  SetIntegerField('ClientID',Value);
end;

procedure TContact.SetClientName(const Value: string);
begin
  SetStringField('ClientName',Value);
end;




Procedure TContact.SetUseOnRun(Const Value: Boolean);Begin	SetBooleanField('UseOnRun' , Value);End;
function  Tcontact.GetMainContactforCashSale  : Boolean   ; begin Result := GetBooleanField('MainContactforCashSale');end;
function  Tcontact.GetMainContactforVoucher   : Boolean   ; begin Result := GetBooleanField('MainContactforVoucher');end;
function  Tcontact.GetMainContactforPOS       : Boolean   ; begin Result := GetBooleanField('MainContactforPOS');end;
function  Tcontact.GetMainContactforRefund    : Boolean   ; begin Result := GetBooleanField('MainContactforRefund');end;
function  Tcontact.GetMainContactforInvoice   : Boolean   ; begin Result := GetBooleanField('MainContactforInvoice');end;
function  Tcontact.GetMainContactforSalesOrder: Boolean   ; begin Result := GetBooleanField('MainContactforSalesOrder');end;
function  Tcontact.GetMainContactforStatements: Boolean   ; begin Result := GetBooleanField('MainContactforStatements');end;
function TContact.GetMainContactforSupplierPayment: Boolean;
begin
  result := GetBooleanField('MainContactforSupplierPayment');
end;

function  Tcontact.GetMainContactforQuote     : Boolean   ; begin Result := GetBooleanField('MainContactforQuote');end;
function  Tcontact.GetMainContactforCheque    : Boolean   ; begin Result := GetBooleanField('MainContactforCheque');end;
function  Tcontact.GetMainContactforCredit    : Boolean   ; begin Result := GetBooleanField('MainContactforCredit');end;
function  Tcontact.GetMainContactforBill      : Boolean   ; begin Result := GetBooleanField('MainContactforBill');end;
function  Tcontact.GetMainContactforPO        : Boolean   ; begin Result := GetBooleanField('MainContactforPO');end;
function  Tcontact.GetMainContactforRA        : Boolean   ; begin Result := GetBooleanField('MainContactforRA');end;
function  Tcontact.GetNotaMainContact         : Boolean   ; begin Result := GetBooleanField('NotaMainContact');end;
function  Tcontact.GetMainContactforRepair    : Boolean   ; begin Result := GetBooleanField('MainContactforRepair');end;
procedure Tcontact.SetMainContactforCashSale  (const Value: Boolean   ); begin SetBooleanField('MainContactforCashSale'   , Value);end;
procedure Tcontact.SetMainContactforVoucher   (const Value: Boolean   ); begin SetBooleanField('MainContactforVoucher'    , Value);end;
procedure Tcontact.SetMainContactforPOS       (const Value: Boolean   ); begin SetBooleanField('MainContactforPOS'        , Value);end;
procedure Tcontact.SetMainContactforRefund    (const Value: Boolean   ); begin SetBooleanField('MainContactforRefund'     , Value);end;
procedure Tcontact.SetMainContactforInvoice   (const Value: Boolean   ); begin SetBooleanField('MainContactforInvoice'    , Value);end;
procedure Tcontact.SetMainContactforSalesOrder(const Value: Boolean   ); begin SetBooleanField('MainContactforSalesOrder' , Value);end;
procedure Tcontact.SetMainContactforStatements(const Value: Boolean   ); begin SetBooleanField('MainContactforStatements' , Value);end;
procedure TContact.SetMainContactforSupplierPayment(const Value: Boolean);
begin
  SetBooleanField('MainContactforSupplierPayment', Value);
end;

procedure Tcontact.SetMainContactforQuote     (const Value: Boolean   ); begin SetBooleanField('MainContactforQuote'      , Value);end;
procedure Tcontact.SetMainContactforCheque    (const Value: Boolean   ); begin SetBooleanField('MainContactforCheque'     , Value);end;
procedure Tcontact.SetMainContactforCredit    (const Value: Boolean   ); begin SetBooleanField('MainContactforCredit'     , Value);end;
procedure Tcontact.SetMainContactforBill      (const Value: Boolean   ); begin SetBooleanField('MainContactforBill'       , Value);end;
procedure Tcontact.SetMainContactforPO        (const Value: Boolean   ); begin SetBooleanField('MainContactforPO'         , Value);end;
procedure Tcontact.SetMainContactforRA        (const Value: Boolean   ); begin SetBooleanField('MainContactforRA'         , Value);end;
procedure Tcontact.SetNotaMainContact         (const Value: Boolean   ); begin SetBooleanField('NotaMainContact'         , Value);end;
procedure Tcontact.SetMainContactforRepair    (const Value: Boolean   ); begin SetBooleanField('MainContactforRepair'     , Value);end;

procedure TContact.UpdateClientInfo;
var
  qry: TERPQuery;
  sl: TStringList;
  x: integer;
begin
  if IsPrimaryContact then begin
    sl:= TStringList.Create;
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := Connection.Connection;
      qry.SQL.Add('select Title, FirstName, MiddleName, LastName, SkypeName, Position, Phone, FaxNumber, Mobile, Email, AltContact, AltPhone, JobTitle');
      qry.SQL.Add('from tblclients where ClientId = ' + IntToStr(self.ClientID));
      qry.Open;
      if qry.RecordCount = 1 then begin
        if not SameText(qry.FieldByName('Title').AsString,ContactTitle) then begin
          sl.Add('Title = ' + QuotedStr(StringDataForSQL(ContactTitle)));
        end;
        if not SameText(qry.FieldByName('FirstName').AsString,ContactFirstName) then begin
          sl.Add('FirstName = ' + QuotedStr(StringDataForSQL(ContactFirstName)));
        end;
        if not SameText(qry.FieldByName('LastName').AsString,ContactSurName) then begin
          sl.Add('LastName = ' + QuotedStr(StringDataForSQL(ContactSurName)));
        end;
        if not SameText(qry.FieldByName('Phone').AsString,ContactPH) then begin
          sl.Add('Phone = ' + QuotedStr(ContactPH));
        end;
        if not SameText(qry.FieldByName('FaxNumber').AsString,ContactFax) then begin
          sl.Add('FaxNumber = ' + QuotedStr(ContactFax));
        end;
        if not SameText(qry.FieldByName('Email').AsString,ContactEmail) then begin
          sl.Add('Email = ' + QuotedStr(ContactEmail));
        end;
        if not SameText(qry.FieldByName('Mobile').AsString,ContactMOB) then begin
          sl.Add('Mobile = ' + QuotedStr(ContactMOB));
        end;
        if not SameText(qry.FieldByName('AltPhone').AsString,ContactAltPH) then begin
          sl.Add('AltPhone = ' + QuotedStr(ContactAltPH));
        end;
        if not SameText(qry.FieldByName('JobTitle').AsString, JobTitle) then
          sl.Add('JobTitle = ' + QuotedStr(StringDataForSQL(JobTitle)));

        if sl.Count > 0 then begin
          qry.Close;
          qry.SQL.Text := 'update tblclients set';
          qry.SQL.Add(sl[0]);
          for x := 1 to sl.Count -1 do
            qry.SQL.Add(',' + sl[x]);
          qry.SQL.Add('where clientid = ' + IntToStr(self.ClientID));
          qry.Execute;
        end;
      end;
    finally
      sl.Free;
      qry.Free;
    end;
  end;
end;

class function  TContact.GetIDField :String;
begin
    REsult := 'ContactID';
End;

class function TContact.GetKeyStringField: string;
begin
  result := 'ClientName,Company';
end;

class function TContact.GetKeyStringProperty: string;
begin
  result := 'ClientName,Company';
end;

class function TContact.GetBusObjectTablename: string;
begin
  Result := 'tblContacts';
end;

function    TContact.ValidateData :Boolean ;
begin
    result := inherited ValidateData;
    if not result then Exit;
    Result := False;
    Resultstatus.Clear;
//    if ClientName = '' then begin
//        AddResult(False , rssWarning , 0 , 'Client Name shouldn''t be blank');
//        Exit;
//    end;
    if ClientID = 0 then begin
        AddResult(False , rssWarning , 0 , 'Client ID shouldn''t be blank');
        Exit;
    end;
    if Company = '' then begin
        AddResult(False , rssWarning , 0 , 'Company shouldn''t be blank');
        Exit;
    end;
    if ContactFirstName = '' then begin
        AddResult(False , rssWarning , 0 , 'Contact First Name shouldn''t be blank');
        Exit;
    end;
    if not(self.IsUnique(ID,'Company = ' + QuotedStr(StringDataForSQL(Company ))+ ' and ClientName = ' + quotedstr(StringDataForSQL(ClientName )) )) then begin
        AddResult(False , rssWarning , 0 , 'This contact already exists');
        Exit;
    end;
  if (ContactMOB <> '') and
    (not SMSUtils.NumberHasCorrectPrefix(ContactMOB, Self.Connection.Connection)) then begin
    AddResult(False, rssWarning, 0, 'Mobile number format is invalid, number must begin with "+" followed by country code with no leading zero''s.');
    exit;
  end;

    Result := true;
end;
class function TContact._Schema: string;
begin
  result:= inherited;
end;

function    TContact.Save :Boolean ;
begin
    Result := False;
    if not ValidateData then exit;
    postdb;
    UpdateClientInfo;
    Result := Inherited Save;
end;

procedure TContact.SaveToXMLNode(Const Node: IXMLNode);
begin
    inherited;
    AddXMLNode(Node , 'ClientName', ClientName);
    AddXMLNode(Node , 'UseOnRun'                ,UseOnRun);
  AddXMLNode(node,'MainContactforCashSale' ,MainContactforCashSale);
  AddXMLNode(node,'MainContactforVoucher' ,MainContactforVoucher);
  AddXMLNode(node,'MainContactforPOS' ,MainContactforPOS);
  AddXMLNode(node,'MainContactforRefund' ,MainContactforRefund);
  AddXMLNode(node,'MainContactforInvoice' ,MainContactforInvoice);
  AddXMLNode(node,'MainContactforSalesOrder' ,MainContactforSalesOrder);
  AddXMLNode(node,'MainContactforStatements' ,MainContactforStatements);
  AddXMLNode(node,'MainContactforQuote' ,MainContactforQuote);
  AddXMLNode(node,'MainContactforCheque' ,MainContactforCheque);
  AddXMLNode(node,'MainContactforCredit' ,MainContactforCredit);
  AddXMLNode(node,'MainContactforBill' ,MainContactforBill);
  AddXMLNode(node,'MainContactforPO' ,MainContactforPO);
  AddXMLNode(node,'MainContactforRA' ,MainContactforRA);
  AddXMLNode(node,'NotaMainContact' ,NotaMainContact);
  AddXMLNode(node,'MainContactforRepair' ,MainContactforRepair);
  AddXMLNode(node,'MainContactforSupplierPayment', MainContactforSupplierPayment);
end;

procedure   TContact.LoadFromXMLNode(Const Node: IXMLNode);
begin
    inherited;
    SetBooleanPropertyFromNode(Node, 'UseOnRun');
    SetPropertyFromNode(Node, 'ClientName');
  SetBooleanPropertyFromNode(node,'MainContactforCashSale');
  SetBooleanPropertyFromNode(node,'MainContactforVoucher');
  SetBooleanPropertyFromNode(node,'MainContactforPOS');
  SetBooleanPropertyFromNode(node,'MainContactforRefund');
  SetBooleanPropertyFromNode(node,'MainContactforInvoice');
  SetBooleanPropertyFromNode(node,'MainContactforSalesOrder');
  SetBooleanPropertyFromNode(node,'MainContactforStatements');
  SetBooleanPropertyFromNode(node,'MainContactforQuote');
  SetBooleanPropertyFromNode(node,'MainContactforCheque');
  SetBooleanPropertyFromNode(node,'MainContactforCredit');
  SetBooleanPropertyFromNode(node,'MainContactforBill');
  SetBooleanPropertyFromNode(node,'MainContactforPO');
  SetBooleanPropertyFromNode(node,'MainContactforRA');
  SetBooleanPropertyFromNode(node,'NotaMainContact');
  SetBooleanPropertyFromNode(node,'MainContactforRepair');
  SetBooleanPropertyFromNode(node,'MainContactforSupplierPayment');
end;

class function TContact.ContactEmailForType(aClientId: integer;
  aMainContactForFieldName: string; Connection: TERPConnection): string;
var
  qry: TERPQuery;
begin
  if Assigned(Connection) then
    qry := DbSharedObj.GetQuery(Connection)
  else
    qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Text := 'select ContactEmail from tblContacts where ClientID = ' + IntToStr(aClientId) +
      ' and ' + aMainContactForFieldName + ' = "T"';
    qry.Open;
    result := qry.FieldByName('ContactEmail').AsString;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TContact.contactID(const contactName,clientName: string;Connection: TERPConnection): Integer;
begin
  Result := 0;
  With CommondbLib.tempMyQuery(Connection) do try
    SQL.Add('select');
    SQL.Add(GetIDField +' contactID ' );
    SQL.Add('from ' + GetBusObjectTablename);
    SQL.Add('where company = ' + Quotedstr(StringDataForSQL(contactName)) +' and   ClientName = ' +quotedstr( StringDataForSQL(clientName)) );
    Open;
    if not Eof then begin
      REsult := Fieldbyname('contactID').asInteger
    end;
  finally
    closenFree;
  end;
end;

class function TContact.contactname(const ID: Integer;  Connection: TERPConnection = nil): string;
begin
  Result := '';
  if ID = 0 then Exit;
  With CommondbLib.tempMyQuery(Connection) do try
    SQL.Add('select');
    SQL.Add('Company');
    SQL.Add('from ' + GetBusObjectTablename);
    SQL.Add('where ' + GetIDField + ' = ' + IntToStr(ID));
    Open;
    if not Eof then begin
      REsult := Fieldbyname('Company').asString
    end;
  finally
    closenFree;
  end;
end;

constructor TContact.Create(AOwner: TComponent);
begin
  inherited;
  CustomFieldIdentifier := 'Cont';
  fSQL := 'Select * from tblContacts ';
  IsList := true;
end;


function TContact.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result:= inherited DoAfterInsert(Sender);
  if not result then exit;

  if Assigned(Owner) and (Owner is TClient) then begin
    ClientID := TClient(Owner).ID;
  end;

end;

function TContact.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoBeforePost(Sender);
end;
Procedure TContact.ValidateMainContactFlags(Sender:TField);
const
(*
  MainContactFlagfields : Array [1..16] of string = ('ISPrimaryContact',
                                                     'MainContactforCashSale',
                                                     'MainContactforVoucher',
                                                     'MainContactforPOS',
                                                     'MainContactforRefund',
                                                     'MainContactforInvoice',
                                                     'MainContactforSalesOrder',
                                                     'MainContactforStatements',
                                                     'MainContactforQuote',
                                                     'MainContactforCheque',
                                                     'MainContactforCredit',
                                                     'MainContactforBill',
                                                     'MainContactforPOS',
                                                     'MainContactforRA',
                                                     'MainContactforRepair',
                                                     'MainContactforSupplierPayment');
*)
  MainContactFlagfields : Array [1..1] of string = ('ISPrimaryContact');
var
  ctr:Integer;
  StrSQL:String;
begin
              { there can be only 1 record with these flags true
                don;t use update SQL - locks the table }

  StrSQL := 'Select * from tblcontacts Where ContactID <> ' + IntToStr(ID);
  StrSQL := StrSQL + ' and ClientID = ' + IntToStr(ClientID)+' and ' +idfieldname +' <> ' + inttostr(ID);
  With GetNewDataset(StrSQL, True) Do Try
    If Recordcount > 0 Then Begin
      First;
      While Eof = False Do Begin
        For Ctr := Low(MainContactFlagfields) To High(MainContactFlagfields) Do Begin
          If Sysutils.SameText(Sender.Fieldname, MainContactflagfields[Ctr]) Then Begin
            If Not RawMode Then Begin
              If Sender.AsBoolean Then Begin
                Edit;
                Fieldbyname(MainContactflagfields[Ctr]).AsBoolean := False;
                Post;
              End;
            End;
          End;
        End;
        Next;
      End;
    end;
  Finally
        If Active Then Close;
        Free;
  End;
end;
procedure TContact.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if not DoFieldChangewhenDisabled then Exit; // we are only interested in data fields.
  inherited;
  ValidateMaincontactFlags(Sender);
  if Sysutils.SameText(Sender.fieldname , 'ClientID') then begin
    if ClientID > 0 then begin
      if Assigned(Owner) and (Owner is TClient) then begin
        if ClientID = TClient(Owner).ID then
          ClientName := TClient(Owner).ClientName
        else
          ClientName := ''
      end
      else begin
        ClientName := TClient.IDToggle(ClientID, Connection.Connection);
      end;
    end
    else
      ClientName:= '';
  end
  else if Sysutils.SameText(Sender.fieldname , 'ClientName') then begin
    if ClientName <> '' then begin
      if Assigned(Owner) and (Owner is TClient) then begin
        if ClientName = TClient(Owner).ClientName then
          ClientID := TClient(Owner).ID
        else
          ClientID := 0
      end
      else begin
        ClientID := TClient.IDToggle(ClientName, Connection.Connection);
      end;
    end
    else
      ClientID:= 0;
  end;
end;

initialization
  RegisterClass(TContact);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Contact','TContact','TContactListGUI');


end.
