unit AccountantDetails;

interface

uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  TAccountantDetails = class(TMSBusObj)

  private
    function GetFirstName: string;
    function GetLastName: string;
    function GetCompanyName: string;
    function GetAddress: string;
    function GetDocName: string;
    function GetTownCity: string;
    function GetPortalZip: string;
    function GetStateRegion: string;
    function GetCountry: string;
    function GetActive: Boolean;

    procedure SetFirstName(const Value: string);
    procedure SetLastName(const Value: string);
    procedure SetCompanyName(const Value: string);
    procedure SetAddress(const Value: string);
    procedure SetDocName(const Value: string);
    procedure SetTownCity(const Value: string);
    procedure SetPortalZip(const Value: string);
    procedure SetStateRegion(const Value: string);
    procedure SetCountry(const Value: string);
    procedure SetActive(const Value: Boolean);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: String; override;
    function DoAfterPost(Sender:TDatasetBusObj): Boolean; override;

  public
    class function GetIDField: String; override;
    class function GetBusObjectTablename: String; override;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;

  published
    property FirstName: string        read GetFirstName         write SetFirstName;
    property LastName: string         read GetLastName          write SetLastname;
    property CompanyName: string      read GetCompanyName       write SetCompanyName;
    property Address: string          read GetAddress           write SetAddress;
    property DocName: string          read GetDocName           write SetDocName;
    property TownCity: string         read GetTownCity          write SetTownCity;
    property PortalZip: string        read GetPortalZip         write SetPortalZip;
    property StateRegion: string      read GetStateRegion       write SetStateRegion;
    property Country: string          read GetCountry           write SetCountry;
    property Active: Boolean          read GetActive            write SetActive;

  end;

implementation

uses
  tcDataUtils, CommonLib;

{ TPayNotes }

constructor TAccountantDetails.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBusObjectTypeDescription:= 'AccountantDetails';
  FSQL:= 'SELECT * FROM tblaccountantdetails';
end;

destructor TAccountantDetails.Destroy;
begin
  inherited;
end;

procedure TAccountantDetails.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'FirstName');
  SetPropertyFromNode(node, 'LastName');
  SetPropertyFromNode(node, 'CompanyName');
  SetPropertyFromNode(node, 'Address');
  SetPropertyFromNode(node, 'DocName');
  SetPropertyFromNode(node, 'TownCity');
  SetPropertyFromNode(node, 'PortalZip');
  SetPropertyFromNode(node, 'StateRegion');
  SetPropertyFromNode(node, 'Country');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure TAccountantDetails.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'FirstName', FirstName);
  AddXMLNode(node, 'LastName', LastName);
  AddXMLNode(node, 'CompanyName', CompanyName);
  AddXMLNode(node, 'Address', Address);
  AddXMLNode(node, 'DocName', DocName);
  AddXMLNode(node, 'TownCity', TownCity);
  AddXMLNode(node, 'PortalZip', PortalZip);
  AddXMLNode(node, 'StateRegion', StateRegion);
  AddXMLNode(node, 'Country', Country);
  AddXMLNode(node, 'Active', Active);
end;

function TAccountantDetails.ValidateData: Boolean;
begin
  Result:= False;
  Resultstatus.Clear;
  Result:= True;
end;

function TAccountantDetails.Save: Boolean;
begin
  Result:= False;
  if not ValidateData then
    Exit;

  Result:= inherited Save;
end;

procedure TAccountantDetails.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TAccountantDetails.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TAccountantDetails.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

class function TAccountantDetails.GetIDField: String;
begin
  Result:= 'ID';
end;

class function TAccountantDetails.GetBusObjectTablename: String;
begin
  Result:= 'tblaccountantdetails';
end;

function TAccountantDetails.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin

  Result:= inherited DoAfterPost(Sender);
end;

function TAccountantDetails.GetFirstName: string;                     begin Result := GetStringField('FirstName');end;
function TAccountantDetails.GetLastName: string;                      begin Result := GetStringField('LastName');end;
function TAccountantDetails.GetCompanyName: string;                   begin Result := GetStringField('CompanyName');end;
function TAccountantDetails.GetAddress: string;                       begin Result := GetStringField('Address');end;
function TAccountantDetails.GetDocName: string;                       begin Result := GetStringField('DocName');end;
function TAccountantDetails.GetTownCity: string;                      begin Result := GetStringField('TownCity');end;
function TAccountantDetails.GetPortalZip: string;                    begin Result := GetStringField('PortalZip');end;
function TAccountantDetails.GetStateRegion: string;                  begin Result := GetStringField('StateRegion');end;
function TAccountantDetails.GetCountry: string;                      begin Result := GetStringField('Company');end;
function TAccountantDetails.GetActive: Boolean;                       begin Result := GetBooleanField('Active');end;

procedure TAccountantDetails.SetFirstName(const Value: string);       begin SetStringField('FirstName', Value);end;
procedure TAccountantDetails.SetLastName(const Value: string);        begin SetStringField('LastName', Value);end;
procedure TAccountantDetails.SetCompanyName(const Value: string);     begin SetStringField('CompanyName', Value);end;
procedure TAccountantDetails.SetAddress(const Value: string);         begin SetStringField('Address', Value);end;
procedure TAccountantDetails.SetDocName(const Value: string);         begin SetStringField('DocName', Value);end;
procedure TAccountantDetails.SetTownCity(const Value: string);        begin SetStringField('TownCity', Value); end;
procedure TAccountantDetails.SetPortalZip(const Value: string);       begin SetStringField('PortalZip', Value);end;
procedure TAccountantDetails.SetStateRegion(const Value: string);     begin SetStringField('StateRegion', Value);end;
procedure TAccountantDetails.Setcountry(const Value: string);         begin SetStringField('Ccompany', Value);end;
procedure TAccountantDetails.SetActive(const Value: Boolean);         begin SetBooleanField('Active', Value);end;

initialization
  RegisterClass(TAccountantDetails);

end.


