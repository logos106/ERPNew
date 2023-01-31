unit BusObjShippingAddress;

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, ShipIntegrationTypes;

type
  TClientToShipAddressLink = class;
  TShippingAddress = class(TMSBusObj)
  private
    function GetCustomer_ID: Integer;
    function GetDeptID: Integer;
    function GetDeptAddresstype: string;
    function GetShipAddress: string;
    function GetShipAddress1: string;
    function GetShipCity: string;
    function GetShipPostCode: string;
    function GetShipState: string;
    function GetShipCountry: string;
    function GetShipAddress2: string;
    function GetActive: Boolean;
    function GetPortOfLanding: string;
    function GetPortOfDischarge: string;
    function GetFinalDestination: string;
    function GetIncoPlace: string;
    function GetPhone: string;
    function GetEmail: string;
    procedure SetCustomer_ID(const Value: Integer);
    procedure SetDeptID(const Value: Integer);
    procedure SetDeptAddresstype(const Value: string);
    procedure SetShipAddress(const Value: string);
    procedure SetShipAddress1(const Value: string);
    procedure SetShipCity(const Value: string);
    procedure SetShipPostCode(const Value: string);
    procedure SetShipState(const Value: string);
    procedure SetShipCountry(const Value: string);
    procedure SetShipAddress2(const Value: string);
    procedure SetActive(const Value: Boolean);
    procedure SetPortOfLanding(const Value: string);
    procedure SetPortOfDischarge(const Value: string);
    procedure SetFinalDestination(const Value: string);
    procedure SetIncoPlace(const Value: string);
    procedure SetPhone(const Value: string);
    procedure SetEmail(const Value: string);
    function GetCustomerName: string;
    procedure SetCustomerName(const Value: string);
    function GetContactName: string;
    procedure SetContactName(const Value: string);
    function getClientToShipAddressLink: TClientToShipAddressLink;
    function getCustomerPhysicalAddress: Boolean;
    procedure SetCustomerPhysicalAddress(const Value: Boolean);
    function GetAddressValidated: boolean;
    procedure SetAddressValidated(const Value: boolean);
    function GetFax: string;
    procedure SetFax(const Value: string);
    function GetLocationCode: string;
    procedure SetLocationCode(const Value: string);
  protected
    function GetCompanyName: string;
    procedure SetCompanyName(const Value: string);
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
  public
    procedure DoFieldOnChange(Sender: TField); override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function _Schema: string; override;
    Property ClientToShipAddressLink : TClientToShipAddressLink read getClientToShipAddressLink;
    function AddressAsSingleLine(IncludeCompanyAndContsct: boolean = true): string;
    function AddressAsString(Delimeter:String =  #13#10) : string;
    function ContactAsString: string;
    function UpdateFromAddress(Address: TAddress): boolean;
    Function ShiptoForSales:String;
    Class Function IsAddressValidated(const aID:Integer ):boolean;
    Class Function NewShippingAddress(aOwner :TComponent;
                                      aCustomerName:string;
                                      aContactName: string ;
                                      aShipAddress: string ;
                                      aDocShipAddress1: string ;
                                      aDocShipAddress2: string ;
                                      aDocShipCity: string ;
                                      aDocShipPostCode: string ;
                                      aDocShipState: string ;
                                      aDocShipCountry: string ;
                                      aDocPortOfLanding: string ;
                                      aDocPortOfDischarge: string ;
                                      aDocFinalDestination: string ;
                                      aDocIncoPlace: string ;
                                      aDocPhone: string ;
                                      aDocEmail: string ;
                                      aDocFax: string ;
                                      aActive:Boolean=True):Integer;


  published
    { Company name can be anything .. id does not have to match customer name }
    property CompanyName: string read GetCompanyName write SetCompanyName;
    { CustomerID is the customer that this Shipping Address belongs to }
    property CustomerID: Integer read GetCustomer_ID write SetCustomer_ID;
    property DeptID: Integer read GetDeptID write SetDeptID;
    property DeptAddresstype: string read GetDeptAddresstype write SetDeptAddresstype;
    property CustomerName: string read GetCustomerName write SetCustomerName;
    property ContactName: string read GetContactName write SetContactName;
    property ShipAddress: string read GetShipAddress write SetShipAddress;
    property ShipAddress1: string read GetShipAddress1 write SetShipAddress1;
    property ShipCity: string read GetShipCity write SetShipCity;
    property ShipPostCode: string read GetShipPostCode write SetShipPostCode;
    property ShipState: string read GetShipState write SetShipState;
    property ShipCountry: string read GetShipCountry write SetShipCountry;
    property ShipAddress2: string read GetShipAddress2 write SetShipAddress2;
    property Active: Boolean read GetActive write SetActive;
    property PortOfLanding: string read GetPortOfLanding write SetPortOfLanding;
    property PortOfDischarge: string read GetPortOfDischarge write SetPortOfDischarge;
    property FinalDestination: string read GetFinalDestination write SetFinalDestination;
    property IncoPlace: string read GetIncoPlace write SetIncoPlace;
    property Phone: string read GetPhone write SetPhone;
    property Email: string read GetEmail write SetEmail;
    property Fax: string read GetFax write SetFax;
    Property CustomerPhysicalAddress :Boolean read getCustomerPhysicalAddress write SetCustomerPhysicalAddress;
    property AddressValidated: boolean read GetAddressValidated write SetAddressValidated;
    property LocationCode: string read GetLocationCode write SetLocationCode;
  end;

  TClientToShipAddressLink = class(TMSBusObj)
  private
    function GetClientID            : Integer   ;
    function GetShipAddressID       : Integer   ;
    procedure SetClientID            (const Value: Integer   );
    procedure SetShipAddressID       (const Value: Integer   );
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function  DoAfterInsert(Sender:TDatasetBusObj) : Boolean;           override;
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
  published
    property ClientID             :Integer     read GetClientID           write SetClientID        ;
    property ShipAddressID        :Integer     read GetShipAddressID      write SetShipAddressID   ;
  end;

  TCustomerShippingAddress = class(TShippingAddress)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TSupplierShippingAddress = class(TShippingAddress)
  public
    constructor Create(AOwner: TComponent); override;
    property CustomerName;
  published
    property SupplierName: string read GetCompanyName write SetCompanyName;
  end;
  TAddressRec = class(TObject)
  private
    fState: string;
    fLine2: string;
    fId: integer;
    fLine3: string;
    fLine1: string;
    fCountry: string;
    fPostcode: string;
    fCity: string;
  public
    property Id: integer read fId write fId;
    property Line1: string read fLine1 write fLine1;
    property Line2: string read fLine2 write fLine2;
    property Line3: string read fLine3 write fLine3;
    property City: string read fCity write fCity;
    property State: string read fState write fState;
    property Postcode: string read fPostcode write fPostcode;
    property Country: string read fCountry write fCountry;
  end;

implementation

uses tcDataUtils, CommonLib, BusObjClient, SysUtils, BusObjSchemaLib, BusObjectListObj,
  tcConst,LogThreadLib;

{ TShippingAddress }

function TShippingAddress.AddressAsSingleLine(IncludeCompanyAndContsct: boolean = true): string;
begin
  result := '';
  if IncludeCompanyAndContsct then begin
    if CustomerName <> '' then result := CustomerName;
    if ContactName <> '' then begin
      if (result <> '') then result := result + ' ';
      result := result + ContactName;
    end;
  end;
  if (result <> '') then result := result + ' ';
  result := result + ShipAddress;
  if ShipAddress1 <> '' then result := result + ' ' + ShipAddress1;
  if ShipAddress2 <> '' then result := result + ' ' + ShipAddress2;
  if ShipCity <> '' then result := result + ' ' + ShipCity;
  if ShipState <> '' then result := result + ' ' + ShipState;
  if ShipPostCode <> '' then result := result + ' ' + ShipPostCode;
  if ShipCountry <> '' then result := result + ' ' + ShipCountry;
end;

function TShippingAddress.AddressAsString(Delimeter:String =  #13#10) : string;
var
  s: string;
begin
  result := '';
  if ShipAddress <> '' then
    result := ShipAddress;
  if ShipAddress1 <> '' then begin
    if result <> '' then result := result + Delimeter;
    result := result + ShipAddress1;
  end;
  if ShipAddress2 <> '' then begin
    if result <> '' then result := result + Delimeter;
    result := result + ShipAddress2;
  end;
  s := ShipCity;
  if ShipState <> '' then begin
    if s <> '' then s := s + ' ';
    s := s + ShipState;
  end;
  if ShipPostCode <> '' then begin
    if s <> '' then s := s + ' ';
    s := s + ShipPostCode;
  end;
  if s <> '' then begin
    if result <> '' then result := result + Delimeter;
    result := result + s;
  end;
  if self.ShipCountry <> '' then begin
    if result <> '' then result := result + Delimeter;
    result := result + ShipCountry;
  end;
end;

function TShippingAddress.ContactAsString: string;
begin
  result := ContactName;
  if CustomerName <> '' then begin
    if result <> '' then result := result + #13#10;
    result := result + CustomerName;
  end;
end;

constructor TShippingAddress.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'ShippingAddress';
  fSQL := 'SELECT * FROM tblshippingaddress';
  ExportExcludeList.Add('customerid');
end;

destructor TShippingAddress.Destroy;
begin
  inherited;
end;

procedure TShippingAddress.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'CompanyName');
  SetPropertyFromNode(node, 'CustomerID');
  SetPropertyFromNode(node, 'DeptID');
  SetPropertyFromNode(node, 'DeptAddresstype');
  SetPropertyFromNode(node, 'ShipAddress');
  SetPropertyFromNode(node, 'ShipAddress1');
  SetPropertyFromNode(node, 'ShipCity');
  SetPropertyFromNode(node, 'ShipPostCode');
  SetPropertyFromNode(node, 'ShipState');
  SetPropertyFromNode(node, 'ShipCountry');
  SetPropertyFromNode(node, 'ShipAddress2');
  SetBooleanPropertyFromNode(node, 'Active');
  SetBooleanPropertyFromNode(node, 'CustomerPhysicalAddress');
  SetPropertyFromNode(node, 'PortOfLanding');
  SetPropertyFromNode(node, 'PortOfDischarge');
  SetPropertyFromNode(node, 'FinalDestination');
  SetPropertyFromNode(node, 'IncoPlace');
  SetPropertyFromNode(node, 'Phone');
  SetPropertyFromNode(node, 'Email');

end;

procedure TShippingAddress.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'CompanyName', CompanyName);
  AddXMLNode(node, 'CustomerID', CustomerID);
  AddXMLNode(node, 'DeptID', DeptID);
  AddXMLNode(node, 'DeptAddresstype', DeptAddresstype);
  AddXMLNode(node, 'ShipAddress', ShipAddress);
  AddXMLNode(node, 'ShipAddress1', ShipAddress1);
  AddXMLNode(node, 'ShipCity', ShipCity);
  AddXMLNode(node, 'ShipPostCode', ShipPostCode);
  AddXMLNode(node, 'ShipState', ShipState);
  AddXMLNode(node, 'ShipCountry', ShipCountry);
  AddXMLNode(node, 'ShipAddress2', ShipAddress2);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'CustomerPhysicalAddress', CustomerPhysicalAddress);
  AddXMLNode(node, 'PortOfLanding', PortOfLanding);
  AddXMLNode(node, 'PortOfDischarge', PortOfDischarge);
  AddXMLNode(node, 'FinalDestination', FinalDestination);
  AddXMLNode(node, 'IncoPlace', IncoPlace);
  AddXMLNode(node, 'Phone', Phone);
  AddXMLNode(node, 'Email', Email);
end;

function TShippingAddress.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if CompanyName = '' then begin
    AddResult(false,rssWarning,0,'Company Name is blank.');
    exit;
  end;
  if DeptID=0 then
      if CustomerID < 1 then begin
        AddResult(false,rssWarning,0,'Parent Customer is blank.');
        exit;
      end;
  Result := True;
end;

class function TShippingAddress._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TCustomer','CustomerObj','CustomerID','ID');
end;

function TShippingAddress.Save: Boolean;
begin
  PostDb;
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
  if not result then exit;

  if customerId <> 0 then
    if (ClientToShipAddressLink.count = 0) or (ClientToShipAddressLink.locate('clientID' ,customerId , [])= False) then begin
      ClientToShipAddressLink.New;
      ClientToShipAddressLink.clientId := CustomerID;
      ClientToShipAddressLink.ShipAddressID := ID;
      ClientToShipAddressLink.PostDB;
    end;
end;

procedure TShippingAddress.OnDataIDChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TShippingAddress.DoFieldOnChange(Sender: TField);
begin
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled = false then
      Exit; // we are only interested in data fields.
  inherited;
  if SameText(Sender.fieldName, 'CompanyName') then begin
  end  else if SameText(Sender.fieldName, 'Customer_Id') then begin
  end  else if SameText(Sender.fieldName, 'DeptID') then begin
  end;
end;
function TShippingAddress.getClientToShipAddressLink: TClientToShipAddressLink;
begin
  Result := TClientToShipAddressLink(getContainercomponent(TClientToShipAddressLink, 'ShipAddressID = ' + inttostr(ID)));
end;
function TShippingAddress.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
end;

function TShippingAddress.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function TShippingAddress.GetSQL: string;begin  Result := inherited GetSQL;end;
class function TShippingAddress.IsAddressValidated(const aID: Integer): boolean;
begin
  with TShippingAddress.CreateWithNewConn(nil) do try
    Load(aID);
    REsult := AddressValidated;
  finally
    Free;
  end;

end;

class function TShippingAddress.GetIDField: string;begin  Result := 'ShipAddressID'end;
class function TShippingAddress.GetBusObjectTablename: string;begin  Result := 'tblshippingaddress';end;

{ Property Functions }
function TShippingAddress.GetCompanyName: string;begin  Result := GetStringField('CompanyName');end;
function TShippingAddress.GetContactName: string;begin  result := GetStringField('ContactName');end;
function TShippingAddress.getCustomerPhysicalAddress: Boolean;begin  Result := getBooleanfield('CustomerPhysicalAddress')end;
function TShippingAddress.GetCustomer_ID: Integer;begin  Result := GetIntegerField('Customer_ID');end;
function TShippingAddress.GetDeptID: Integer;begin  Result := GetIntegerField('DeptID');end;
function TShippingAddress.GetDeptAddresstype: string;begin  Result := GetStringField('DeptAddresstype');end;
function TShippingAddress.GetShipAddress: string;begin  Result := GetStringField('ShipAddress');end;
function TShippingAddress.GetShipAddress1: string;begin  Result := GetStringField('ShipAddress1');end;
function TShippingAddress.GetShipCity: string;begin  Result := GetStringField('ShipCity');end;
function TShippingAddress.GetShipPostCode: string;begin  Result := GetStringField('ShipPostCode');end;
function TShippingAddress.GetShipState: string;begin  Result := GetStringField('ShipState');end;
function TShippingAddress.GetShipCountry: string;begin  Result := GetStringField('ShipCountry');end;
function TShippingAddress.GetShipAddress2: string;begin  Result := GetStringField('ShipAddress2');end;
function TShippingAddress.GetActive: Boolean;begin  Result := GetBooleanField('Active');end;
function TShippingAddress.GetAddressValidated: boolean;
begin
  result := GetBooleanField('AddressValidated');
end;

function TShippingAddress.GetPortOfLanding: string;begin  Result := GetStringField('PortOfLanding');end;
function TShippingAddress.GetPortOfDischarge: string;begin  Result := GetStringField('PortOfDischarge');end;
function TShippingAddress.GetFax: string;
begin
  result := GetStringField('Fax');
end;

function TShippingAddress.GetFinalDestination: string;begin  Result := GetStringField('FinalDestination');end;
function TShippingAddress.GetIncoPlace: string;begin  Result := GetStringField('IncoPlace');end;
function TShippingAddress.GetLocationCode: string;
begin
  result := GetStringField('LocationCode');
end;

function TShippingAddress.GetPhone: string;begin  Result := GetStringField('Phone');end;
function TShippingAddress.GetEmail: string;begin  Result := GetStringField('Email');end;
procedure TShippingAddress.SetCompanyName(const Value: string);begin  SetStringField('CompanyName', Value);end;
procedure TShippingAddress.SetContactName(const Value: string);begin  SetStringField('ContactName', Value);end;
procedure TShippingAddress.SetCustomerPhysicalAddress(const Value: Boolean);begin  SetBooleanField('CustomerPhysicalAddress' , Value);end;
procedure TShippingAddress.SetCustomer_ID(const Value: Integer);begin  SetIntegerField('Customer_ID', Value);end;
procedure TShippingAddress.SetDeptID(const Value: Integer);begin  SetIntegerField('DeptID', Value);end;
procedure TShippingAddress.SetDeptAddresstype(const Value: string);begin  SetStringField('DeptAddresstype', Value);end;
procedure TShippingAddress.SetShipAddress(const Value: string);begin  SetStringField('ShipAddress', Value);end;
procedure TShippingAddress.SetShipAddress1(const Value: string);begin  SetStringField('ShipAddress1', Value);end;
procedure TShippingAddress.SetShipCity(const Value: string);begin  SetStringField('ShipCity', Value);end;
procedure TShippingAddress.SetShipPostCode(const Value: string);begin  SetStringField('ShipPostCode', Value);end;
procedure TShippingAddress.SetShipState(const Value: string);begin  SetStringField('ShipState', Value);end;
function TShippingAddress.ShiptoForSales: String;
begin
    Result :='';
    if ContactName <> '' then Result := ContactName ;
    Result := Result + NLnLF+ CompanyName;
    if not Empty(ShipAddress)   then Result :=Result + NLnLF + ShipAddress;
    if not Empty(ShipAddress1)  then Result :=Result + NLnLF + ShipAddress1;
    if not Empty(ShipAddress2)  then Result :=Result + NLnLF + ShipAddress2;
    if not Empty(ShipCity)      then Result :=Result + NLnLF + ShipCity;
    if not Empty(ShipState)     then Result :=Result+ ' ' +  ShipState;
    if not Empty(ShipPostCode)  then Result :=Result+ ' ' +  ShipPostCode;
    if not Empty(ShipCountry)   then Result :=Result + NLnLF + ShipCountry;
    TLogger.Inst.Log(Result);
end;

function TShippingAddress.UpdateFromAddress(Address: TAddress): boolean;
begin
  result := false;
  if not SameText(self.ShipAddress, Address.AddressLine1) then begin
    self.ShipAddress := Address.AddressLine1;
    result := true;
  end;
  if not SameText(self.ShipAddress1, Address.AddressLine2) then begin
    self.ShipAddress1 := Address.AddressLine2;
    result := true;
  end;
  if not SameText(self.ShipAddress2, Address.AddressLine3) then begin
    self.ShipAddress2 := Address.AddressLine3;
    result := true;
  end;
  if not SameText(self.ShipCity, Address.City) then begin
    self.ShipCity := Address.City;
    result := true;
  end;
  if not SameText(self.ShipState, Address.State) then begin
    self.ShipState := Address.State;
    result := true;
  end;
  if not SameText(self.ShipPostCode, Address.PostCode) then begin
    self.ShipPostCode := Address.PostCode;
    result := true;
  end;
end;
Class Function TShippingAddress.NewShippingAddress( aOwner :TComponent;
                                                    aCustomerName:string;
                                                    aContactName: string ;
                                                    aShipAddress: string ;
                                                    aDocShipAddress1: string ;
                                                    aDocShipAddress2: string ;
                                                    aDocShipCity: string ;
                                                    aDocShipPostCode: string ;
                                                    aDocShipState: string ;
                                                    aDocShipCountry: string ;
                                                    aDocPortOfLanding: string ;
                                                    aDocPortOfDischarge: string ;
                                                    aDocFinalDestination: string ;
                                                    aDocIncoPlace: string ;
                                                    aDocPhone: string ;
                                                    aDocEmail: string ;
                                                    aDocFax: string ;
                                                    aActive:Boolean=True):Integer;
var
  aCustomerID:Integer;
  s:String;
begin
  result := 0;
  aCustomerID := Tclient.idtoggle(aCustomerName);
  if aCustomerID =0 then exit;
  s:= 'Customer_ID =' + inttostr(aCustomerID);
  if aContactName        <> '' then s:= s +' and (ContactName'          +'= ' + quotedstr(aContactName)        + ' OR ifnull(ContactName     ,"") = "") ';
  if aShipAddress        <> '' then s:= s +' and (ShipAddress'          +'= ' + quotedstr(aShipAddress)        + ' OR ifnull(ShipAddress     ,"") = "") ';
  if aDocShipAddress1    <> '' then s:= s +' and (ShipAddress1'         +'= ' + quotedstr(aDocShipAddress1)    + ' OR ifnull(ShipAddress1    ,"") = "") ';
  if aDocShipAddress2    <> '' then s:= s +' and (ShipAddress2'         +'= ' + quotedstr(aDocShipAddress2)    + ' OR ifnull(ShipAddress2    ,"") = "") ';
  if aDocShipCity        <> '' then s:= s +' and (ShipCity'             +'= ' + quotedstr(aDocShipCity)        + ' OR ifnull(ShipCity        ,"") = "") ';
  if aDocShipPostCode    <> '' then s:= s +' and (ShipPostCode'         +'= ' + quotedstr(aDocShipPostCode)    + ' OR ifnull(ShipPostCode    ,"") = "") ';
  if aDocShipState       <> '' then s:= s +' and (ShipState'            +'= ' + quotedstr(aDocShipState)       + ' OR ifnull(ShipState       ,"") = "") ';
  if aDocShipCountry     <> '' then s:= s +' and (ShipCountry'          +'= ' + quotedstr(aDocShipCountry)     + ' OR ifnull(ShipCountry     ,"") = "") ';
  if aDocPortOfLanding   <> '' then s:= s +' and (PortOfLanding'        +'= ' + quotedstr(aDocPortOfLanding)   + ' OR ifnull(PortOfLanding   ,"") = "") ';
  if aDocPortOfDischarge <> '' then s:= s +' and (PortOfDischarge'      +'= ' + quotedstr(aDocPortOfDischarge) + ' OR ifnull(PortOfDischarge ,"") = "") ';
  if aDocFinalDestination<> '' then s:= s +' and (FinalDestination'     +'= ' + quotedstr(aDocFinalDestination)+ ' OR ifnull(FinalDestination,"") = "") ';
  if aDocIncoPlace       <> '' then s:= s +' and (IncoPlace'            +'= ' + quotedstr(aDocIncoPlace)       + ' OR ifnull(IncoPlace       ,"") = "") ';
  if aDocPhone           <> '' then s:= s +' and (Phone'                +'= ' + quotedstr(aDocPhone)           + ' OR ifnull(Phone           ,"") = "") ';
  if aDocEmail           <> '' then s:= s +' and (email'                +'= ' + quotedstr(aDocEmail)           + ' OR ifnull(email           ,"") = "") ';
  if aDocFax             <> '' then s:= s +' and (Fax'                  +'= ' + quotedstr(aDocFax)             + ' OR ifnull(Fax             ,"") = "") ';

  with TShippingAddress.CreateWithNewConn(AOwner) do try
    Loadselect(s);
     if count =0 then begin
        New;
        CustomerID := aCustomerID;
        CompanyName := aCustomerName;
     end;
     if aContactName        <> ''  then ContactName          := aContactName;
     if aShipAddress        <> ''  then ShipAddress          := aShipAddress;
     if aDocShipAddress1    <> ''  then ShipAddress1         := aDocShipAddress1;
     if aDocShipAddress2    <> ''  then ShipAddress2         := aDocShipAddress2;
     if aDocShipCity        <> ''  then ShipCity             := aDocShipCity;
     if aDocShipPostCode    <> ''  then ShipPostCode         := aDocShipPostCode;
     if aDocShipState       <> ''  then ShipState            := aDocShipState;
     if aDocShipCountry     <> ''  then ShipCountry          := aDocShipCountry;
     if aDocPortOfLanding   <> ''  then PortOfLanding        := aDocPortOfLanding;
     if aDocPortOfDischarge <> ''  then PortOfDischarge      := aDocPortOfDischarge;
     if aDocFinalDestination<> ''  then FinalDestination     := aDocFinalDestination;
     if aDocIncoPlace       <> ''  then IncoPlace            := aDocIncoPlace;
     if aDocPhone           <> ''  then Phone                := aDocPhone;
     if aDocEmail           <> ''  then email                := aDocEmail;
     if aDocFax             <> ''  then Fax                  := aDocFax;
     Active := aActive;
     PostDB;
     Result := ID;
     with Tclienttoshipaddresslink.CreateWithNewConn(AOwner) do try
       LoadSelect('ShipAddressId =' + inttostr(result)+' and clientId = ' + inttostr(aCustomerID));
       if count =0 then begin
           ShipAddressId := Result;
           ClientId := aCustomerID;
           PostDB;
       end;
     finally
       Free;
     end;
  finally
    Free;
  end;
end;

procedure TShippingAddress.SetShipCountry(const Value: string);begin  SetStringField('ShipCountry', Value);end;
procedure TShippingAddress.SetShipAddress2(const Value: string);begin  SetStringField('ShipAddress2', Value);end;
procedure TShippingAddress.SetActive(const Value: Boolean);begin  SetBooleanField('Active', Value);end;
procedure TShippingAddress.SetAddressValidated(const Value: boolean);
begin
  SetBooleanField('AddressValidated',Value);
end;

procedure TShippingAddress.SetPortOfLanding(const Value: string);begin  SetStringField('PortOfLanding', Value);end;
procedure TShippingAddress.SetPortOfDischarge(const Value: string);begin  SetStringField('PortOfDischarge', Value);end;
procedure TShippingAddress.SetFax(const Value: string);
begin
  SetStringField('Fax', Value);
end;

procedure TShippingAddress.SetFinalDestination(const Value: string);begin  SetStringField('FinalDestination', Value);end;
procedure TShippingAddress.SetIncoPlace(const Value: string);begin SetStringField('IncoPlace', Value);end;
procedure TShippingAddress.SetLocationCode(const Value: string);
begin
  SetStringField('LocationCode', Value);
end;

procedure TShippingAddress.SetPhone(const Value: string);begin  SetStringField('Phone', Value);end;
procedure TShippingAddress.SetEmail(const Value: string);begin  SetStringField('Email', Value);end;
procedure TShippingAddress.SetCustomerName(const Value: string);
begin
  if Value <> '' then
    CustomerID:= TCustomer.IDToggle(Value, Connection.Connection)
  else
    CustomerID:= 0;
end;
function TShippingAddress.GetCustomerName: string;
begin
  if CustomerID > 0 then
    result:= TCustomer.IDToggle(CustomerID, Connection.Connection)
  else
    result:= '';
end;

  {Tclienttoshipaddresslink}

constructor Tclienttoshipaddresslink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'clienttoshipaddresslink';
  fSQL := 'SELECT * FROM tblclienttoshipaddresslink';
end;


destructor Tclienttoshipaddresslink.Destroy;
begin
  inherited;
end;


procedure Tclienttoshipaddresslink.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'ClientID');
  SetPropertyFromNode(node,'ShipAddressID');
end;


procedure Tclienttoshipaddresslink.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'ClientID' ,ClientID);
  AddXMLNode(node,'ShipAddressID' ,ShipAddressID);
end;


function Tclienttoshipaddresslink.ValidateData: Boolean ;
begin
  Resultstatus.Clear;
  result := false;
  if self.ClientID = 0 then begin
    AddResult(false,rssWarning,0,'Client ID is blank');
    exit;
  end;
  if self.ShipAddressID = 0 then begin
    AddResult(false,rssWarning,0,'Shipping Address ID is blank');
    exit;
  end;
  Result := True;
end;


function Tclienttoshipaddresslink.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure Tclienttoshipaddresslink.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


procedure Tclienttoshipaddresslink.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function Tclienttoshipaddresslink.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function Tclienttoshipaddresslink.GetIDField: string;
begin
  Result := 'ID'
end;


class function Tclienttoshipaddresslink.GetBusObjectTablename: string;
begin
  Result:= 'tblclienttoshipaddresslink';
end;


function TClientToShipAddressLink.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
end;

function Tclienttoshipaddresslink.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  if not result then exit;
end;


{Property Functions}
function  Tclienttoshipaddresslink.GetClientID        : Integer   ; begin Result := GetIntegerField('ClientID');end;
function  Tclienttoshipaddresslink.GetShipAddressID   : Integer   ; begin Result := GetIntegerField('ShipAddressID');end;
procedure Tclienttoshipaddresslink.SetClientID        (const Value: Integer   ); begin SetIntegerField('ClientID'         , Value);end;
procedure Tclienttoshipaddresslink.SetShipAddressID   (const Value: Integer   ); begin SetIntegerField('ShipAddressID'    , Value);end;


{ TCustomerShippingAddress }

constructor TCustomerShippingAddress.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblshippingaddress' +
    ' inner join tblclients on tblclients.ClientId = tblshippingaddress.Customer_ID and tblClients.Customer = "T"';
end;

{ TSupplierShippingAddress }

constructor TSupplierShippingAddress.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM tblshippingaddress' +
    ' inner join tblclients on tblclients.ClientId = tblshippingaddress.Customer_ID and tblClients.Supplier = "T"';
end;

initialization
  RegisterClass(Tclienttoshipaddresslink);
  RegisterClass(TShippingAddress);
  RegisterClass(TCustomerShippingAddress);
  RegisterClass(TSupplierShippingAddress);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Customer Shipping Address','TCustomerShippingAddress','TCustomerShipAddressListFormGUI');
  BusObjectListObj.TBusObjInfoList.Inst.Add('Supplier Shipping Address','TSupplierShippingAddress','TSupplierShipAddressListFormGUI');

end.
