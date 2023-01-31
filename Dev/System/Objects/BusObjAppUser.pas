unit BusObjAppUser;

interface

uses
  Classes, BusObjBase;

type
  TAppUser = class(TBusObj)
  private
    function GetDatabaseName: string;
    function GetFirstName: string;
    function GetLastName: string;
    function GetLastTime: TDateTime;
    function GetMultiLogon: boolean;
    function GetObjRef: integer;
    function GetOrganisationKey: string;
    function GetUserName: string;
    function GetEmployeeID: integer;
  published
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class function GetKeyStringField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property UserName: string read GetUserName;
    property FirstName: string read GetFirstName;
    property LastName: string read GetLastName;
    property DatabaseName: string read GetDatabaseName;
    property OrganisationKey: string read GetOrganisationKey;
    property LastTime: TDateTime read GetLastTime;
    property MultiLogon: boolean read GetMultiLogon;
    property ObjRef: integer read GetObjRef;
    property EmployeeID: integer read GetEmployeeID;
  end;

implementation

{ TAppUser }

constructor TAppUser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'AppUser';
  fSQL := 'SELECT services.tblAppUserList.*, EmployeeID FROM services.tblAppUserList left join tblpassword on tblpassword.Logon_Name = services.tblAppUserList.UserName';
end;

destructor TAppUser.Destroy;
begin
  inherited;
end;

class function TAppUser.GetBusObjectTablename: string;
begin
  result := 'services.tblAppUserList';
end;

function TAppUser.GetDatabaseName: string;
begin
  result := GetStringField('DatabaseName');
end;

function TAppUser.GetEmployeeID: integer;
begin
  result := GetIntegerField('EmployeeID');
end;

function TAppUser.GetFirstName: string;
begin
  result := GetStringField('FirstName');
end;

class function TAppUser.GetIDField: string;
begin
  result := 'ID';
end;

class function TAppUser.GetKeyStringField: string;
begin
  result := inherited;
end;

function TAppUser.GetLastName: string;
begin
  result := GetStringField('LastName');
end;

function TAppUser.GetLastTime: TDateTime;
begin
  result := GetDateTimeField('LastTime');
end;

function TAppUser.GetMultiLogon: boolean;
begin
  result := GetBooleanField('MultiLogon');
end;

function TAppUser.GetObjRef: integer;
begin
  result := GetIntegerField('ObjRef');
end;

function TAppUser.GetOrganisationKey: string;
begin
  result := GetStringField('OrganisationKey');
end;

function TAppUser.GetUserName: string;
begin
  result := GetStringField('UserName');
end;

initialization
  RegisterClass(TAppUser);

end.
