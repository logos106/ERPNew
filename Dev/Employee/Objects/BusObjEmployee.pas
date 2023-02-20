unit BusObjEmployee;

interface

uses BusObjClass, BusobjPersonalPreference, BusObjBase, DB, Classes, XMLDoc,
  XMLIntf, MyAccess, BusObjAttachment, BusObjUser;

type
  TEmployee = class(TMSBusObj)
  private
    PP: TPersonalPreferences;
    function getAbn: string;
    function GetActive: Boolean;
    function GetAltContact: string;
    function GetAltphone: string;
    function GetCanvasser: Boolean;
    function GetCompany: string;
    function GetCountry: string;
    function GetCreationDate: TDatetime;
    function GetCustfld1: string;
    function GetCustfld10: string;
    function GetCustfld11: string;
    function GetCustfld12: string;
    function GetCustfld13: string;
    function GetCustfld14: string;
    function GetCustfld15: string;
    function GetCustfld2: string;
    function GetCustfld3: string;
    function GetCustfld4: string;
    function GetCustfld5: string;
    function GetCustfld6: string;
    function GetCustfld7: string;
    function GetCustfld8: string;
    function GetCustfld9: string;
    function GetDateFinished: TDatetime;
    function GetDateStarted: TDatetime;
    function GetDefaultClassID: Integer;
    function GetClientID: Integer;
    function GetDefaultClassName: string;
    function GetDOB: TDatetime;
    function GetEmail: string;
    function GetEmployeeName: string;
    function getEmployeeno: Integer;
    function GetFaxnumber: string;
    function GetFirstName: string;
    function getFormatedEmployeeName: string;
    function getInitials: string;
    function GetLastName: string;
    function GetLastUpdated: TDatetime;
    function GetMiddleName: string;
    function GetMobile: string;
    function GetNotes: string;
    function GetPhone: string;
    function GetPosition: string;
    function GetPostcode: string;
    function GetRep: Boolean;
    function GetSex: string;
    function GetSkypeName: string;
    function GetArea: String;
    function GetState: string;
    function GetStreet: string;
    function GetStreet2: string;
    function GetSuburb: string;
    function GetTFN: string;
    function GetTitle: string;
    function GetWorkPhone: string;
    procedure SetAbn(const Value: string);
    procedure SetActive(const Value: Boolean);
    procedure SetAltContact(const Value: string);
    procedure SetAltphone(const Value: string);
    procedure SetCanvasser(const Value: Boolean);
    procedure SetCompany(const Value: string);
    procedure SetCountry(const Value: string);
    procedure SetCreationDate(const Value: TDatetime);
    procedure SetCustfld1(const Value: string);
    procedure SetCustfld10(const Value: string);
    procedure SetCustfld11(const Value: string);
    procedure SetCustfld12(const Value: string);
    procedure SetCustfld13(const Value: string);
    procedure SetCustfld14(const Value: string);
    procedure SetCustfld15(const Value: string);
    procedure SetCustfld2(const Value: string);
    procedure SetCustfld3(const Value: string);
    procedure SetCustfld4(const Value: string);
    procedure SetCustfld5(const Value: string);
    procedure SetCustfld6(const Value: string);
    procedure SetCustfld7(const Value: string);
    procedure SetCustfld8(const Value: string);
    procedure SetCustfld9(const Value: string);
    procedure SetDateFinished(const Value: TDatetime);
    procedure SetDateStarted(const Value: TDatetime);
    procedure SetDefaultClassID(const Value: Integer);
    procedure SetClientID(const Value: Integer);
    procedure SetDefaultClassName(const Value: string);
    procedure SetDOB(const Value: TDatetime);
    procedure SetEmail(const Value: string);
    procedure SetEmployeeName(const Value: string);
    procedure SetEmployeeno(const Value: Integer);
    procedure SetFaxnumber(const Value: string);
    procedure SetFirstName(const Value: string);
    procedure SetInitials(const Value: string);
    procedure SetLastName(const Value: string);
    procedure SetLastUpdated(const Value: TDatetime);
    procedure SetMiddleName(const Value: string);
    procedure SetMobile(const Value: string);
    procedure SetNotes(const Value: string);
    procedure SetPhone(const Value: string);
    procedure SetPosition(const Value: string);
    procedure SetPostcode(const Value: string);
    procedure SetRep(const Value: Boolean);
    procedure SetSex(const Value: string);
    procedure SetSkypeName(const Value: string);
    procedure  SetArea(const Value: String);
    procedure SetState(const Value: string);
    procedure SetStreet(const Value: string);
    procedure SetStreet2(const Value: string);
    procedure SetSuburb(const Value: string);
    procedure SetTFN(const Value: string);
    procedure SetTitle(const Value: string);
    procedure SetWorkPhone(const Value: string);
    function GetEmailsFromEmployeeAddress: Boolean;
    procedure SetEmailsFromEmployeeAddress(const Value: Boolean);
    function GetStreet3: string;
    procedure SetStreet3(const Value: string);
    function getPersonalPreferences: TPersonalPreferences;
    function getDefaultClass: TDeptClass;
    function GetIsTerminated: boolean;
    procedure SetIsTerminated(const Value: boolean);
    function GetGoogleEmail: string;
    function GetGooglePassword: string;
    function GetSynchWithGoogle: boolean;
    function GetonPMRoster: boolean;
    procedure SetGoogleEmail(const Value: string);
    procedure SetGooglePassword(const Value: string);
    procedure SetSynchWithGoogle(const Value: Boolean);
    procedure SetonPMRoster(const Value: boolean);
    function  GetTrackSales: boolean;
    procedure SetTrackSales(const Value: boolean);
    function  GetUser: TUser;
    function  GetDashboardOption: String;
    procedure SetDashboardOption(const Value: String);
    function  GetLoginDefault: String;
    procedure SetLoginDefault(const Value: String);
    function  GetSalesQuota: Double;
    procedure SetSalesQuota(const Value: Double);

  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;

  public
    procedure DoFieldOnChange(Sender: TField); override;
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class function GetKeyStringField: string; override;
    constructor Create(AOwner: TComponent); override;
    function GetId: Integer; override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    property FormatedEmployeeName: string read getFormatedEmployeeName;
    class function GetKeyStringProperty: string; override;
    class function _Schema: string; override;
    Property PersonalPreferences: TPersonalPreferences read getPersonalPreferences;
    Property DefaultClass:TDeptClass read getDefaultClass;
    class function EmailForEmployeeID(const aEmpID: integer; Connection: TCustomMyConnection = nil): string;
    class function TFNForEmployeeID(const aEmpID: integer; Connection: TCustomMyConnection = nil): string;
    class function EmployeeNameForID(const aEmpID: integer; Connection: TCustomMyConnection = nil): string;
    class function ValidateAddressFields(const EmpID: integer; var msg: string; const CheckCountry: boolean = true): boolean;
    Function CopyTosupplier:Integer;

  published
    property Title: string read GetTitle write SetTitle;
    property FirstName: string read GetFirstName write SetFirstName;
    property MiddleName: string read GetMiddleName write SetMiddleName;
    property LastName: string read GetLastName write SetLastName;
    property Street: string read GetStreet write SetStreet;
    property Street2: string read GetStreet2 write SetStreet2;
    property Street3: string read GetStreet3 write SetStreet3;
    property Suburb: string read GetSuburb write SetSuburb;
    property PostCode: string read GetPostcode write SetPostcode;
    property State: string read GetState write SetState;
    property Country: string read GetCountry write SetCountry;
    property Phone: string read GetPhone write SetPhone;
    property AltPhone: string read GetAltphone write SetAltphone;
    property FaxNumber: string read GetFaxnumber write SetFaxnumber;
    property Mobile: string read GetMobile write SetMobile;
    property WorkPhone: string read GetWorkPhone write SetWorkPhone;
    property Email: string read GetEmail write SetEmail;
    property AltContact: string read GetAltContact write SetAltContact;
    property Company: string read GetCompany write SetCompany;
    property Position: string read GetPosition write SetPosition;
    property ABN: string read getAbn write SetAbn;
    property Canvasser: Boolean read GetCanvasser write SetCanvasser;
    property Rep: Boolean read GetRep write SetRep;
    property CreationDate: TDatetime read GetCreationDate write SetCreationDate;
    property DateStarted: TDatetime read GetDateStarted write SetDateStarted;
    property DateFinished: TDatetime read GetDateFinished write SetDateFinished;
    property IsTerminated: boolean read GetIsTerminated write SetIsTerminated;
    property Notes: string read GetNotes write SetNotes;
    property Active: Boolean read GetActive write SetActive;
    property CustFld1: string read GetCustfld1 write SetCustfld1;
    property CustFld2: string read GetCustfld2 write SetCustfld2;
    property CustFld3: string read GetCustfld3 write SetCustfld3;
    property CustFld4: string read GetCustfld4 write SetCustfld4;
    property CustFld5: string read GetCustfld5 write SetCustfld5;
    property CustFld6: string read GetCustfld6 write SetCustfld6;
    property CustFld7: string read GetCustfld7 write SetCustfld7;
    property CustFld8: string read GetCustfld8 write SetCustfld8;
    property CustFld9: string read GetCustfld9 write SetCustfld9;
    property CustFld10: string read GetCustfld10 write SetCustfld10;
    property CustFld11: string read GetCustfld11 write SetCustfld11;
    property CustFld12: string read GetCustfld12 write SetCustfld12;
    property CustFld13: string read GetCustfld13 write SetCustfld13;
    property CustFld14: string read GetCustfld14 write SetCustfld14;
    property CustFld15: string read GetCustfld15 write SetCustfld15;
    property EmployeeNo: Integer read getEmployeeno write SetEmployeeno;
    property TFN: string read GetTFN write SetTFN;
    property DOB: TDatetime read GetDOB write SetDOB;
    property Initials: string read getInitials write SetInitials;
    property Sex: string read GetSex write SetSex;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property DefaultClassName: string read GetDefaultClassName write SetDefaultClassName;
    property DefaultClassID: Integer read GetDefaultClassID write SetDefaultClassID;
    property ClientID: Integer read GetClientID write SetClientID;
    property LastUpdated: TDatetime read GetLastUpdated write SetLastUpdated;
    property EmailsFromEmployeeAddress: Boolean read GetEmailsFromEmployeeAddress write SetEmailsFromEmployeeAddress;
    property SkypeName: string read GetSkypeName write SetSkypeName;
    Property Area: String read getArea write setArea;
    property GoogleEmail: string read GetGoogleEmail write SetGoogleEmail;
    property GooglePassword: string read GetGooglePassword write SetGooglePassword;
    property TrackSales : boolean read GetTrackSales write SetTrackSales;
    property SynchWithGoogle: boolean read GetSynchWithGoogle write SetSynchWithGoogle;
    property onPMRoster: boolean read GetonPMRoster write SetonPMRoster;
    Property User :TUser read getUser;
    Property DashboardOption: String  read GetDashboardOption   write SetDashboardOption;
    Property LoginDefault:    String  read GetLoginDefault      write SetLoginDefault;
    Property SalesQuoata:     Double  read GetSalesQuota        write SetSalesQuota;

    { the following does not seem to be used anywhere }
    // property EmployeeTypeID: integer read GetEmployeeTypeID write SetEmployeeTypeID;
  end;
  TEmployeeEx = class(TEmployee)
  Private
    function GetAttachments: TAttachment;
  Published
    property Attachments: TAttachment read GetAttachments;
  end;

implementation

uses AppEnvironment, SysUtils, BusObjConst, BusObjectListObj, BusObjSchemaLib,
  ERPDbComponents, CommonDbLib, BusObjClient, utVS1Const, tcDataUtils, UtilsLib;

{ TEmployee }

function TEmployee.CopyTosupplier: Integer;
var
  fClient :  Tclient;
begin
  REsult:= 0;
  if clientID>0 then begin
    REsult:=  ClientID ;
    exit;
  end;
    fClient :=  Tclient.Create(Self);
    try
      fClient.Connection := Connection;
//      fClient.Load(ClientID);
      fClient.LoadSelect('Company = ' + QuotedStr(EmployeeName));
      fClient.connection.BeginNestedTransaction;
      try
        if fClient.Count = 0 then begin
          fClient.New;
          fClient.IsSupplier    := True;
          fClient.ClientName      := EmployeeName;
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
          fClient.BillStreet      := Street;
          fClient.BillStreet2     := Street2;
          fClient.BillStreet3     := Street3;
          fClient.BillSuburb      := Suburb;
          fClient.BillState       := State;
          fClient.BillPostcode    := Postcode;
          fClient.BillCountry     := Country;
          fClient.IsSupplier      := true;
          fClient.Active          := TRue;
          fClient.Title           := Title;
          fClient.Firstname       := Firstname;
          fClient.Middlename      := Middlename;
          fClient.Lastname        := Lastname;
          fClient.Email           := Email;
          fClient.DateEntered     := DAte;
        end
        else begin
          { make sure client is supplier }
          fClient.IsSupplier    := True;
        end;
        fClient.PostDB;
        if fClient.Save then begin
          fClient.Connection.CommitNestedTransaction;
          ClientId :=fClient.ID;
          PostDB;
          Result:=ClientId;
        end else begin
          fClient.Connection.RollbackNestedTransaction;
        end;
      Except
        on E:Exception do begin
          fClient.Connection.RollbackNestedTransaction;
        end;
      end;
    finally
        Freeandnil(fclient);
    end;
end;

constructor TEmployee.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSQL := 'SELECT * FROM tblemployees Where Firstname <> ' + quotedstr(ERP_VS1CLOUD_DEFAULT_USERFirstName);
end;

destructor TEmployee.Destroy;
begin

  inherited;
end;

function TEmployee.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  DefaultClassName := AppEnv.DefaultClass.DefaultClassName;
  CreationDate := Now();
  result := inherited;
  FirstName:='';
  LastName:= '';
  Middlename:= '';
end;

function TEmployee.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterPost(Sender);
  if not result then exit;
    if PersonalPreferences.Count = 0 then begin
      PersonalPreferences.New;
      PersonalPreferences.EmployeeId := Self.ID;
      PersonalPreferences.MaxDiscountPercentage := Appenv.companyprefs.MaxDiscountPercentage;
      PersonalPreferences.PostDB;
    end;
end;

function TEmployee.DoBeforePost(Sender: TDatasetBusObj): Boolean;
begin
  if DefaultClassID < 1 then begin
    DefaultClassID:= AppEnv.DefaultClass.ClassID;
    DefaultClassName:= AppEnv.DefaultClass.DefaultClassName;
  end;
  result:= inherited DoBeforePost(Sender);
end;

procedure TEmployee.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (SysUtils.SameText(Sender.FieldName, 'FirstName')) or (SysUtils.SameText(Sender.FieldName, 'LastName')) then begin
    EmployeeName := FirstName + ' ' + LastName;
    PostDB;
  end
  else if (SysUtils.SameText(Sender.FieldName, 'DefaultClassName')) then begin
    DefaultClassID := TDeptClass.IDToggle(Sender.AsString, Self.connection.connection);
  end
  else if (SysUtils.SameText(Sender.FieldName, 'DefaultClassID')) then begin
    DefaultClassName := TDeptClass.IDToggle(Sender.AsInteger, Self.connection.connection);
  end;
end;

class function TEmployee.EmailForEmployeeID(const aEmpID: integer;
  Connection: TCustomMyConnection): string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection := Connection
    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select Email from tblEmployees');
    qry.SQL.Add('where EmployeeID = ' + IntToStr(aEmpID));
    qry.Open;
    result:= qry.FieldByName('Email').AsString;
  finally
    qry.Free;
  end;
end;

class function TEmployee.EmployeeNameForID(const aEmpID: integer;
  Connection: TCustomMyConnection): string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection := Connection
    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select EmployeeName from tblEmployees');
    qry.SQL.Add('where EmployeeID = ' + IntToStr(aEmpID));
    qry.Open;
    result:= qry.FieldByName('EmployeeName').AsString;
  finally
    qry.Free;
  end;
end;
function TEmployee.getFormatedEmployeeName: string;
begin
  result := LastName + '.';
  if FirstName <> '' then result := result + ' ' + FirstName;
  if MiddleName <> '' then result := result + ' ' + MiddleName;
end;
function TEmployee.getPersonalPreferences: TPersonalPreferences;
begin
  if not(Assigned(PP)) then begin
    PP:= TPersonalPreferences.Create(nil);
    PP.Connection := Self.connection;
    PP.LoadSelect('EmployeeId = ' + IntToStr(Self.ID));
  end
  else begin
   if PP.EmployeeID <> self.ID then begin
     PP.LoadSelect('EmployeeId = ' + IntToStr(Self.ID));
   end;
  end;
  result:= PP;
end;
function TEmployee.getDefaultClass: TDeptClass;
begin
  result := TDeptClass(Getcontainercomponent(TDeptClass ,'ClassID = ' + IntToStr(Self.DefaultClassID)));
end;
function TEmployee.getUser: TUser;
begin
  result := TUser(Getcontainercomponent(TUser ,'EmployeeId = ' + IntToStr(Self.ID)));
end;
procedure TEmployee.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;

end;

function TEmployee.Save: Boolean;
begin
  result := False;
  if Assigned(PP) and PP.Dirty then begin
    result := PP.Save;
    if not result then exit;
  end;
  result := False;
  if not ValidateData then exit;
  result := inherited Save;
  PostDB;
end;

class function TEmployee.GetBusObjectTableName: string; begin   result := 'tblemployees'; end;
class function TEmployee.GetIDField: string; begin   result := 'EmployeeID' end;
class function TEmployee.GetKeyStringField: string; begin   result := 'EmployeeName'; end;
class function TEmployee.GetKeyStringProperty: string;begin   result:= 'EmployeeName'; end;
function TEmployee.GetSQL: string;begin  result := inherited GetSQL;end;
function TEmployee.getAbn: string;begin   result := GetStringField('ABN'); end;
function TEmployee.GetActive: Boolean;begin   result := GetBooleanField('Active'); end;
function TEmployee.GetAltContact: string; begin   result := GetStringField('Altcontact') end;
function TEmployee.GetAltphone: string; begin   result := GetStringField('Altphone'); end;
function TEmployee.GetCanvasser: Boolean; begin   result := GetBooleanField('Canvasser'); end;
function TEmployee.GetCompany: string; begin   result := GetStringField('Company'); end;
function TEmployee.GetCountry: string; begin   result := GetStringField('Country'); end;
function TEmployee.GetCreationDate: TDatetime; begin   result := GetDatetimeField('Creationdate'); end;
function TEmployee.GetCustfld1: string; begin   result := GetStringField('Custfld1'); end;
function TEmployee.GetCustfld10: string; begin   result := GetStringField('Custfld10'); end;
function TEmployee.GetCustfld11: string; begin   result := GetStringField('Custfld11'); end;
function TEmployee.GetCustfld12: string; begin   result := GetStringField('Custfld12'); end;
function TEmployee.GetCustfld13: string; begin  result := GetStringField('Custfld13'); end;
function TEmployee.GetCustfld14: string; begin   result := GetStringField('Custfld14'); end;
function TEmployee.GetCustfld15: string; begin   result := GetStringField('Custfld15'); end;
function TEmployee.GetCustfld2: string; begin   result := GetStringField('Custfld2'); end;
function TEmployee.GetCustfld3: string;begin   result := GetStringField('Custfld3'); end;
function TEmployee.GetCustfld4: string; begin   result := GetStringField('Custfld4'); end;
function TEmployee.GetCustfld5: string; begin   result := GetStringField('Custfld5'); end;
function TEmployee.GetCustfld6: string; begin   result := GetStringField('Custfld6'); end;
function TEmployee.GetCustfld7: string;begin   result := GetStringField('Custfld7'); end;
function TEmployee.GetCustfld8: string;begin   result := GetStringField('Custfld8'); end;
function TEmployee.GetCustfld9: string;begin   result := GetStringField('Custfld9'); end;
function TEmployee.GetDateFinished: TDatetime;begin   result := GetDatetimeField('Datefinished'); end;
function TEmployee.GetDateStarted: TDatetime; begin   result := GetDatetimeField('Datestarted'); end;
function TEmployee.GetDefaultClassID: Integer; begin   result := GetIntegerField('Defaultclassid');end;
function TEmployee.GetClientID: Integer;begin   result := GetIntegerField('ClientID'); end;
function TEmployee.GetDefaultClassName: string; begin   result := GetStringField('Defaultclassname');end;
function TEmployee.GetDOB: TDatetime; begin   result := GetDatetimeField('Dob'); end;
function TEmployee.GetEmail: string; begin   result := GetStringField('Email');end;
function TEmployee.GetEmailsFromEmployeeAddress: Boolean; begin   result := GetBooleanField('Emailsfromemployeeaddress'); end;
function TEmployee.GetEmployeeName: string; begin   result := GetStringField('Employeename'); end;
function TEmployee.getEmployeeno: Integer; begin   result := GetIntegerField('Employeeno'); end;
function TEmployee.GetFaxnumber: string; begin   result := GetStringField('Faxnumber'); end;
function TEmployee.GetFirstName: string; begin   result := GetStringField('Firstname'); end;
function TEmployee.GetGoogleEmail: string;begin   result := GetStringField('GoogleEmail'); end;
function TEmployee.GetGooglePassword: string; begin   result := GetStringField('GooglePassword');end;
function TEmployee.GetId: Integer; begin   result := GetIntegerField('EmployeeID'); end;
function TEmployee.getInitials: string; begin   result := GetStringField('Initials'); end;
function TEmployee.GetIsTerminated: boolean; begin   result := GetBooleanField('IsTerminated'); end;
function TEmployee.GetLastName: string;begin  result := GetStringField('Lastname');end;
function TEmployee.GetLastUpdated: TDatetime;begin  result := GetDatetimeField('Lastupdated');end;
function TEmployee.GetMiddleName: string;begin  result := GetStringField('Middlename');end;
function TEmployee.GetMobile: string;begin  result := GetStringField('Mobile');end;
function TEmployee.GetNotes: string;begin  result := GetStringField('Notes');end;
function TEmployee.GetPhone: string;begin  result := GetStringField('Phone');end;
function TEmployee.GetPosition: string;begin  result := GetStringField('Position');end;
function TEmployee.GetPostcode: string;begin  result := GetStringField('Postcode');end;
function TEmployee.GetRep: Boolean;begin  result := GetBooleanField('Rep');end;
function TEmployee.GetSex: string;begin  result := GetStringField('Sex');end;
function TEmployee.GetSkypeName: string;begin  result := GetStringField('SkypeName');end;
function  TEmployee.GetArea: String; begin Result := GetStringField('Area');end;
function TEmployee.GetState: string;begin  result := GetStringField('State');end;
function TEmployee.GetStreet: string;begin  result := GetStringField('Street');end;
function TEmployee.GetStreet2: string;begin  result := GetStringField('Street2');end;
function TEmployee.GetStreet3: string;begin  result := GetStringField('Street3');end;
function TEmployee.GetSuburb: string;begin  result := GetStringField('Suburb');end;
function TEmployee.GetSynchWithGoogle: boolean;begin  result := GetBooleanField('SynchWithGoogle');end;
function TEmployee.GetonPMRoster: boolean;begin  result := GetBooleanField('onPMRoster');end;
function TEmployee.GetTFN: string;begin  result := GetStringField('Tfn');end;
function TEmployee.GetTitle: string;begin  result := GetStringField('Title');end;
function TEmployee.GetTrackSales: boolean;begin  Result := GetBooleanField('TrackSales');end;
function TEmployee.GetWorkPhone: string;begin  result := GetStringField('WorkPhone');end;
function TEmployee.GetDashboardOption:  string;   begin Result := GetStringField('DashboardOption');  end;
function TEmployee.GetLoginDefault:     string;   begin Result := GetStringField('LoginDefault');     end;
function TEmployee.GetSalesQuota:       Double;   begin Result := GetFloatField('SalesTarget');        end;

procedure TEmployee.SetAbn(const Value: string);begin  SetStringField('Abn', Value);end;
procedure  TEmployee.SetArea(const Value: String); begin SetStringField('Area' , Value);end;
procedure TEmployee.SetActive(const Value: Boolean);begin  SetBooleanField('Active', Value);end;
procedure TEmployee.SetAltContact(const Value: string);begin  SetStringField('Altcontact', Value);end;
procedure TEmployee.SetAltphone(const Value: string);begin  SetStringField('Altphone', Value);end;
procedure TEmployee.SetCanvasser(const Value: Boolean);begin  SetBooleanField('Canvasser', Value);end;
procedure TEmployee.SetCompany(const Value: string);begin  SetStringField('Company', Value);end;
procedure TEmployee.SetCountry(const Value: string);begin  SetStringField('Country', Value);end;
procedure TEmployee.SetCreationDate(const Value: TDatetime);begin  SetDatetimeField('Creationdate', Value);end;
procedure TEmployee.SetCustfld1(const Value: string);begin  SetStringField('Custfld1', Value);end;
procedure TEmployee.SetCustfld10(const Value: string);begin  SetStringField('Custfld10', Value);end;
procedure TEmployee.SetCustfld11(const Value: string);begin  SetStringField('Custfld11', Value);end;
procedure TEmployee.SetCustfld12(const Value: string);begin  SetStringField('Custfld12', Value);end;
procedure TEmployee.SetCustfld13(const Value: string);begin  SetStringField('Custfld13', Value);end;
procedure TEmployee.SetCustfld14(const Value: string);begin  SetStringField('Custfld14', Value);end;
procedure TEmployee.SetCustfld15(const Value: string);begin  SetStringField('Custfld15', Value);end;
procedure TEmployee.SetCustfld2(const Value: string);begin  SetStringField('Custfld2', Value);end;
procedure TEmployee.SetCustfld3(const Value: string);begin  SetStringField('Custfld3', Value);end;
procedure TEmployee.SetCustfld4(const Value: string);begin  SetStringField('Custfld4', Value);end;
procedure TEmployee.SetCustfld5(const Value: string);begin  SetStringField('Custfld5', Value);end;
procedure TEmployee.SetCustfld6(const Value: string);begin  SetStringField('Custfld6', Value);end;
procedure TEmployee.SetCustfld7(const Value: string);begin  SetStringField('Custfld7', Value);end;
procedure TEmployee.SetCustfld8(const Value: string);begin  SetStringField('Custfld8', Value);end;
procedure TEmployee.SetCustfld9(const Value: string);begin  SetStringField('Custfld9', Value);end;
procedure TEmployee.SetDateFinished(const Value: TDatetime);begin  SetDatetimeField('Datefinished', Value);end;
procedure TEmployee.SetDateStarted(const Value: TDatetime);begin  SetDatetimeField('Datestarted', Value);end;
procedure TEmployee.SetDefaultClassID(const Value: Integer);begin  SetIntegerField('Defaultclassid', Value);end;
procedure TEmployee.SetClientID(const Value: Integer);begin  SetIntegerField('ClientID', Value);end;
procedure TEmployee.SetDefaultClassName(const Value: string);begin  SetStringField('Defaultclassname', Value);end;
procedure TEmployee.SetDOB(const Value: TDatetime);begin  SetDatetimeField('Dob', Value);end;
procedure TEmployee.SetEmail(const Value: string);begin  SetStringField('Email', Value);end;
procedure TEmployee.SetEmailsFromEmployeeAddress(const Value: Boolean);begin  SetBooleanField('Emailsfromemployeeaddress', Value);end;
procedure TEmployee.SetEmployeeName(const Value: string);begin  SetStringField('Employeename', Value);end;
procedure TEmployee.SetEmployeeno(const Value: Integer);begin  SetIntegerField('Employeeno', Value);end;
procedure TEmployee.SetFaxnumber(const Value: string);begin  SetStringField('Faxnumber', Value);end;
procedure TEmployee.SetFirstName(const Value: string);begin  SetStringField('Firstname', Value);end;
procedure TEmployee.SetGoogleEmail(const Value: string);begin  SetStringField('GoogleEmail', Value);end;
procedure TEmployee.SetGooglePassword(const Value: string);begin  SetStringField('GooglePassword', Value);end;
procedure TEmployee.SetInitials(const Value: string);begin  SetStringField('Initials', Value);end;
procedure TEmployee.SetIsTerminated(const Value: boolean);begin  SetBooleanField('IsTerminated', Value);end;
procedure TEmployee.SetLastName(const Value: string);begin  SetStringField('Lastname', Value);end;
procedure TEmployee.SetLastUpdated(const Value: TDatetime);begin  SetDatetimeField('Lastupdated', Value);end;
procedure TEmployee.SetMiddleName(const Value: string);begin  SetStringField('Middlename', Value);end;
procedure TEmployee.SetMobile(const Value: string);begin  SetStringField('Mobile', Value);end;
procedure TEmployee.SetNotes(const Value: string);begin  SetStringField('Notes', Value);end;
procedure TEmployee.SetPhone(const Value: string);begin  SetStringField('Phone', Value);end;
procedure TEmployee.SetPosition(const Value: string);begin SetStringField('Position', Value);end;
procedure TEmployee.SetPostcode(const Value: string);begin  SetStringField('Postcode', Value);end;
procedure TEmployee.SetRep(const Value: Boolean);begin  SetBooleanField('Rep', Value);end;
procedure TEmployee.SetSex(const Value: string);begin  SetStringField('Sex', Value);end;
procedure TEmployee.SetSkypeName(const Value: string);begin  SetStringField('SkypeName', Value);end;
procedure TEmployee.SetState(const Value: string);begin  SetStringField('State', Value);end;
procedure TEmployee.SetStreet(const Value: string);begin  SetStringField('Street', Value);end;
procedure TEmployee.SetStreet2(const Value: string);begin  SetStringField('Street2', Value);end;
procedure TEmployee.SetStreet3(const Value: string);begin  SetStringField('Street3', Value);end;
procedure TEmployee.SetSuburb(const Value: string);begin  SetStringField('Suburb', Value);end;
procedure TEmployee.SetSynchWithGoogle(const Value: boolean);begin  SetBooleanField('SynchWithGoogle', Value);end;
procedure TEmployee.SetonPMRoster(const Value: boolean);begin  SetBooleanField('onPMRoster', Value);end;
procedure TEmployee.SetTFN(const Value: string);begin  SetStringField('Tfn', Value);end;
procedure TEmployee.SetTitle(const Value: string);begin  SetStringField('Title', Value);end;
procedure TEmployee.SetTrackSales(const Value: boolean);begin  SetBooleanField('TrackSales', Value);end;
procedure TEmployee.SetWorkPhone(const Value: string);begin  SetStringField('WorkPhone', Value);end;
procedure TEmployee.SetDashboardOption(const Value: string);  begin SetStringField('DashboardOption', Value);   end;
procedure TEmployee.SetLoginDefault(const Value: string);     begin SetStringField('LoginDefault',    Value);   end;
procedure TEmployee.SetSalesQuota(const Value: Double);       begin SetFloatField('SalesTarget',      Value);   end;

procedure TEmployee.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'Title');
  SetPropertyFromNode(node, 'FirstName');
  SetPropertyFromNode(node, 'MiddleName');
  SetPropertyFromNode(node, 'LastName');
  SetPropertyFromNode(node, 'Street');
  SetPropertyFromNode(node, 'Street2');
  SetPropertyFromNode(node, 'Suburb');
  SetPropertyFromNode(node, 'PostCode');
  SetPropertyFromNode(node, 'State');
  SetPropertyFromNode(node, 'Country');
  SetPropertyFromNode(node, 'Phone');
  SetPropertyFromNode(node, 'AltPhone');
  SetPropertyFromNode(node, 'FaxNumber');
  SetPropertyFromNode(node, 'Mobile');
  SetPropertyFromNode(node, 'Email');
  SetPropertyFromNode(node, 'AltContact');
  SetPropertyFromNode(node, 'Company');
  SetPropertyFromNode(node, 'Position');
  SetPropertyFromNode(node, 'Abn');
  SetBooleanPropertyFromNode(node, 'Canvasser');
  SetBooleanPropertyFromNode(node, 'Rep');
  SetPropertyFromNode(node, 'CreationDate');
  SetDateTimePropertyFromNode(node, 'DateStarted');
  SetDateTimePropertyFromNode(node, 'DateFinished');
  SetPropertyFromNode(node, 'Notes');
  SetBooleanPropertyFromNode(node, 'Active');
  SetPropertyFromNode(node, 'Custfld1');
  SetPropertyFromNode(node, 'Custfld2');
  SetPropertyFromNode(node, 'Custfld3');
  SetPropertyFromNode(node, 'Custfld4');
  SetPropertyFromNode(node, 'Custfld5');
  SetPropertyFromNode(node, 'Custfld6');
  SetPropertyFromNode(node, 'Custfld7');
  SetPropertyFromNode(node, 'Custfld8');
  SetPropertyFromNode(node, 'Custfld9');
  SetPropertyFromNode(node, 'Custfld10');
  SetPropertyFromNode(node, 'Custfld11');
  SetPropertyFromNode(node, 'Custfld12');
  SetPropertyFromNode(node, 'Custfld13');
  SetPropertyFromNode(node, 'Custfld14');
  SetPropertyFromNode(node, 'Custfld15');
  SetPropertyFromNode(node, 'Employeeno');
  SetPropertyFromNode(node, 'TFN');
  SetDateTimePropertyFromNode(node, 'DOB');
  SetPropertyFromNode(node, 'Initials');
  SetPropertyFromNode(node, 'Sex');
  SetBooleanPropertyFromNode(node, 'Emailsfromemployeeaddress');
  SetPropertyFromNode(node, 'EmployeeName');
  SetDateTimePropertyFromNode(node, 'LastUpdated');
  SetPropertyFromNode(node, 'WorkPhone');
  SetPropertyFromNode(node,'Area');
  SetBooleanPropertyFromNode(node, 'IsTerminated');
  SetPropertyFromNode(node,'GoogleEmail');
  SetPropertyFromNode(node,'GooglePassword');
  SetBooleanPropertyFromNode(node, 'SynchWithGoogle');
  SetBooleanPropertyFromNode(node, 'onPMRoster');
end;
procedure TEmployee.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Title', Title);
  AddXMLNode(node, 'FirstName', FirstName);
  AddXMLNode(node, 'MiddleName', MiddleName);
  AddXMLNode(node, 'LastName', LastName);
  AddXMLNode(node, 'Street', Street);
  AddXMLNode(node, 'Street2', Street2);
  AddXMLNode(node, 'Suburb', Suburb);
  AddXMLNode(node, 'Postcode', PostCode);
  AddXMLNode(node, 'State', State);
  AddXMLNode(node, 'Country', Country);
  AddXMLNode(node, 'Phone', Phone);
  AddXMLNode(node, 'AltPhone', AltPhone);
  AddXMLNode(node, 'FaxNumber', FaxNumber);
  AddXMLNode(node, 'Mobile', Mobile);
  AddXMLNode(node, 'Email', Email);
  AddXMLNode(node, 'AltContact', AltContact);
  AddXMLNode(node, 'Company', Company);
  AddXMLNode(node, 'Position', Position);
  AddXMLNode(node, 'ABN', ABN);
  AddXMLNode(node, 'Canvasser', Canvasser);
  AddXMLNode(node, 'Rep', Rep);
  AddXMLNode(node, 'CreationDate', CreationDate);
  AddXMLNode(node, 'DateStarted', DateStarted);
  AddXMLNode(node, 'DateFinished', DateFinished);
  AddXMLNode(node, 'Notes', Notes);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'Custfld1', CustFld1);
  AddXMLNode(node, 'Custfld2', CustFld2);
  AddXMLNode(node, 'Custfld3', CustFld3);
  AddXMLNode(node, 'Custfld4', CustFld4);
  AddXMLNode(node, 'Custfld5', CustFld5);
  AddXMLNode(node, 'Custfld6', CustFld6);
  AddXMLNode(node, 'Custfld7', CustFld7);
  AddXMLNode(node, 'Custfld8', CustFld8);
  AddXMLNode(node, 'Custfld9', CustFld9);
  AddXMLNode(node, 'Custfld10', CustFld10);
  AddXMLNode(node, 'Custfld11', CustFld11);
  AddXMLNode(node, 'Custfld12', CustFld12);
  AddXMLNode(node, 'Custfld13', CustFld13);
  AddXMLNode(node, 'Custfld14', CustFld14);
  AddXMLNode(node, 'Custfld15', CustFld15);
  AddXMLNode(node, 'EmployeeNo', EmployeeNo);
  AddXMLNode(node, 'TFN', TFN);
  AddXMLNode(node, 'DOB', DOB);
  AddXMLNode(node, 'Initials', Initials);
  AddXMLNode(node, 'Sex', Sex);
  AddXMLNode(node, 'Employeename', EmployeeName);
  AddXMLNode(node, 'Emailsfromemployeeaddress', EmailsFromEmployeeAddress);
  AddXMLNode(node, 'SkypeName', SkypeName);
  AddXMLNode(node,'Area' ,Area);
  AddXMLNode(node, 'Lastupdated', LastUpdated);
  AddXMLNode(node, 'WorkPhone', WorkPhone);
  AddXMLNode(node, 'UsTerminated', IsTerminated);
  AddXMLNode(node,'GoogleEmail', GoogleEmail);
  AddXMLNode(node,'GooglePassword', GooglePassword);
  AddXMLNode(node,'SynchWithGoogle', SynchWithGoogle);
  AddXMLNode(node,'onPMRoster', onPMRoster);
end;
class function TEmployee.TFNForEmployeeID(const aEmpID: integer;
  Connection: TCustomMyConnection): string;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection := Connection
    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select TFN from tblEmployees');
    qry.SQL.Add('where EmployeeID = ' + IntToStr(aEmpID));
    qry.Open;
    result:= qry.FieldByName('TFN').AsString;
  finally
    qry.Free;
  end;
end;

class function TEmployee.ValidateAddressFields(const EmpID: integer;
  var msg: string; const CheckCountry: boolean): boolean;
var
  emp: TEmployee;
begin
  result := true;
  emp := TEmployee.CreateWithSharedConn(nil);
  try
    emp.Load(EmpID);
    if Trim(emp.Street) = '' then begin
      result := false;
      msg := 'The first line of the Street Address for ' + emp.EmployeeName + ' is blank.';
      exit;
    end;
    if Trim(emp.Suburb) = '' then begin
      result := false;
      msg := 'The Suburb/Town for the the Address of ' + emp.EmployeeName + ' is blank.';
      exit;
    end;
    if Trim(emp.State) = '' then begin
      result := false;
      msg := 'The State for the Address of ' + emp.EmployeeName + ' is blank.';
      exit;
    end;
    if Trim(emp.PostCode) = '' then begin
      result := false;
      msg := 'The Post Code for the Address of ' + emp.EmployeeName + ' is blank.';
      exit;
    end;
    if CheckCountry then begin
      if Trim(emp.Country) = '' then begin
        result := false;
        msg := 'The Country for the Address of ' + emp.EmployeeName + ' is blank.';
        exit;
      end;
    end;


  finally
    emp.Free;
  end;
end;

function TEmployee.ValidateData: Boolean;
var
//  tmpResultStatus: TResultStatusItem;
  tmpBusobjEventVal_Failed: string;
begin
  result := False;
  Resultstatus.Clear;
  tmpBusobjEventVal_Failed := BusobjEventVal_FailedInformationValidateData;
  try
    if FirstName = '' then begin
      AddResult(False, rssError, BOR_Employee_Err_NoFirstName, 'First name should not be blank');
      SendEvent(IntToStr(BOR_Employee_Err_NoFirstName), tmpBusobjEventVal_Failed);
      exit;
    end;
    if LastName = '' then begin
      AddResult(False, rssError, BOR_Employee_Err_NoLastName, 'Last name should not be blank');
      SendEvent(IntToStr(BOR_Employee_Err_NoLastName), tmpBusobjEventVal_Failed);
      exit;
    end;
    if DateStarted = 0 then begin
      AddResult(False, rssError, BOR_Employee_Err_NoDateStarted, 'Date started should not be blank');
      SendEvent(IntToStr(BOR_Employee_Err_NoDateStarted), tmpBusobjEventVal_Failed);
      exit;
    end;
    if DOB = 0 then begin
      AddResult(False, rssError, BOR_Employee_Err_NoDOB, 'DOB should not be blank');
      SendEvent(IntToStr(BOR_Employee_Err_NoDOB), tmpBusobjEventVal_Failed);
      exit;
    end;
    if Sex = '' then begin
      AddResult(False, rssError, BOR_Employee_Err_NoSex, 'Sex should not be blank');
      SendEvent(IntToStr(BOR_Employee_Err_NoSex), tmpBusobjEventVal_Failed);
      exit;
    end;
    if (Sex <> 'Male') and (Sex <> 'Female') and (Sex <> 'M') and (Sex <> 'F') then begin
      AddResult(False, rssError, BOR_Employee_Err_NoSex, 'Invalid value for Sex');
      SendEvent(IntToStr(BOR_Employee_Err_NoSex), tmpBusobjEventVal_Failed);
      exit;
    end;
    if DefaultClassName = '' then begin
      AddResult(False, rssError, BOR_Employee_Err_NoDefaultDepartment, 'Default department name should not be blank');
      SendEvent(IntToStr(BOR_Employee_Err_NoDefaultDepartment), tmpBusobjEventVal_Failed);
      exit;
    end;
    //use systemaddress for VS1 databases
    if EmailsFromEmployeeAddress then
      if Email = '' then
        if HasVS1data(connection.Connection) then EmailsFromEmployeeAddress := False;

    if EmailsFromEmployeeAddress then begin
      if Email = '' then begin
        AddResult(False, rssError, BOR_Employee_Err_NoEmail, 'Email is blank and "Send from Employee address" is enabled');
        tmpBusobjEventVal_Failed := BusobjEventVal_FailedAddressValidateData;
        SendEvent(IntToStr(BOR_Employee_Err_NoEmail), tmpBusobjEventVal_Failed);
        exit;
      end;
    end;
    if IsTerminated and (DateFinished = 0) then begin
      AddResult(False, rssError, BOR_Employee_Err_NoDateFinished, 'Employee is terminated but Date Finished is blank');
      SendEvent(IntToStr(BOR_Employee_Err_NoDateFinished), tmpBusobjEventVal_Failed);
      exit;
    end;
    result := true;
  finally
//    if not result then begin
//      tmpResultStatus := Resultstatus.GetLastStatusItem;
//      if Assigned(tmpResultStatus) then
//        if Assigned(Self.Owner) and (Self.Owner is TBusobj) then TBusobj(Self.Owner).SendEvent(IntToStr(tmpResultStatus.Code), tmpBusobjEventVal_Failed);
//    end;
  end;
end;

class function TEmployee._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TDeptClass','DefaultClass','DefaultClassID','ID');
  TBOSchema.AddRefType(result,'TDeptClass','DefaultClass','DefaultClassName','DeptClassName');
end;
function TEmployeeEx.GetAttachments: TAttachment;
begin
  Result := TAttachment(GetcontainerComponent(TAttachment,
            'Tablename = ' + Quotedstr(GetBusObjectTablename) +
            ' and TableID =' + IntToStr(ID)));
end;

initialization
  RegisterClass(TEmployee);
  RegisterClass(TEmployeeEx);
  BusObjectListObj.TBusObjInfoList.Inst.Add('Employee', 'TEmployee', 'TfrmEmployeeList');
end.
