unit BusObjUser;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  10/05/13  1.00.00  A.  Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, BusObjEmployeeFormAccess;

type
  TUser = class(TMSBusObj)
  private
    fbIsVS1User: boolean;
    function GetEmployeeId: Integer;
    function GetLogon_Name: string;
    function GetLogon_Password: string;
    function GetOptionNo: Integer;
    procedure SetEmployeeId(const Value: Integer);
    procedure SetLogon_Name(const Value: string);
    procedure SetLogon_Password(const Value: string);
    procedure SetOptionNo(const Value: Integer);
    function GetEmployeeName: string;
    procedure SetEmployeeName(const Value: string);
    function GetLogonPassword: string;
    function GetPasswordHash: string;
    function GetActive: boolean;
    function GetPasswordDate: TDateTime;
    procedure SetPasswordDate(const Value: TDateTime);
    procedure SetLogonPassword(const Value: string);
    procedure InitVS1user;
    //function getEmployeeFormAccess: TEmployeeFormAccess;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function GetKeyValue: string; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    class function GetKeyStringField: string; override;
    class function GetKeyStringProperty: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function UserPasswordDate(const aLogonName, aServer, ADatabase: string): TDateTime;
    class function LoginExpireDate(const aLogonName, aServer, ADatabase: string): TDateTime;
    //Property EmployeeFormAccess : TEmployeeFormAccess read getEmployeeFormAccess;
  published
    property EmployeeId: Integer read GetEmployeeId write SetEmployeeId;
    property EmployeeName: string read GetEmployeeName write SetEmployeeName;
    property LogonName: string read GetLogon_Name write SetLogon_Name;
    property Logon_Name: string read GetLogon_Name write SetLogon_Name;
    property Logon_Password: string read GetLogon_Password write SetLogon_Password;
    property LogonPassword: string read GetLogonPassword write SetLogonPassword;
    property PasswordHash: string read GetPasswordHash;
    property OptionNo: Integer read GetOptionNo write SetOptionNo;
    property Active: boolean read GetActive;
    property PasswordDate: TDateTime read GetPasswordDate write SetPasswordDate;
    Property IsVS1User: boolean read fbIsVS1User write fbIsVS1User;
  end;
  TUserAceessLevels = class(TUser)
  Private
      function getEmployeeFormAccessVS1: TEmployeeFormAccess;
  Published
    Property EmployeeFormAccessVS1 : TEmployeeFormAccess read getEmployeeFormAccessVS1;
  end;

implementation

uses
  tcDataUtils, CommonLib, BusObjEmployee, SimpleEncrypt, CipherUtils,
  ERPDbComponents, DbSharedObjectsObj, CommonDbLib, SysUtils, DBUtils, DNMLib;

{ TUser }

constructor TUser.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'User';
  fSQL := 'SELECT * FROM tblpassword ';
  //ExportExcludeList.Add('employeeid');
  ExportExcludeList.Add('logon_password');
  //ExportExcludeList.Add('logonpassword');
  ExportExcludeList.Add('optionno');
  fbIsVS1User := False;
end;

destructor TUser.Destroy;
begin
  inherited;
end;

procedure TUser.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'EmployeeId');
  SetPropertyFromNode(node, 'LogonName');
  SetPropertyFromNode(node, 'Logon_Password');
  SetPropertyFromNode(node, 'OptionNo');
end;

procedure TUser.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'EmployeeId', EmployeeId);
  AddXMLNode(node, 'LogonName', LogonName);
  AddXMLNode(node, 'Logon_Password', Logon_Password);
  AddXMLNode(node, 'OptionNo', OptionNo);
end;

function TUser.ValidateData: Boolean;
begin
//  Result := False;
  Resultstatus.Clear;
  Result := True;
end;

function TUser.Save: Boolean;
begin
  Result := False;
  if not ValidateData then
    Exit;
  Result := inherited Save;
  if not result then exit;
  if fbIsVS1User then
    InitVS1user;
end;

procedure TUser.InitVS1user;
var
  qry: TERPQuery;
begin
  qry := SharedQuery;
  try
      qry.SQL.Clear;
      qry.SQL.add('INSERT IGNORE INTO tblemployeeformsaccess ' +
                  ' (EmployeeId, FormID, Access) ' +
                  ' SELECT '+ inttostr(EmployeeId) + ' AS EmployeeId, FormID, 1 AS Access FROM  tblforms ' +
                  ' WHERE (formname LIKE "FnRunBatch" ' +
                  ' OR formname LIKe "FnAllowInvoiceStockToNegative");' );
      {NO access for VS1 objects - this is only for VS1_cloud admin database }
      qry.SQL.add('INSERT IGNORE INTO tblemployeeformsaccess '+
                  ' (EmployeeId, FormID, Access)  '+
                  ' SELECT '+ inttostr(EmployeeId)+' AS EmployeeId, FormID, 6 AS Access FROM tblforms;' );
      qry.Execute;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure TUser.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TUser.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TUser.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TUser.GetIDField: string;
begin
  Result := 'Pswd_ID'
end;

class function TUser.GetKeyStringField: string;
begin
  result := 'Logon_Name,Logon_Password';
end;

class function TUser.GetKeyStringProperty: string;
begin
  result := 'LogonName,LogonPassword';
end;

function TUser.GetKeyValue: string;
begin
  result := LogonName + ',******';
end;

function TUser.GetActive: boolean;
var
  qry: TERPQuery;
begin
  Result := false;
  qry := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
  try
    qry.SQL.Text := 'select Active from tblemployees where EmployeeID = ' + IntToStr(EmployeeID);
    qry.Open;
    if not qry.IsEmpty then
      result := qry.FieldByName('Active').AsBoolean;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

class function TUser.GetBusObjectTablename: string;
begin
  Result := 'tblpassword';
end;

(*function TUser.getEmployeeFormAccess: TEmployeeFormAccess;
begin
  Result := TEmployeeFormAccess(getContainercomponent(TEmployeeFormAccess, 'EmployeeId = ' + inttostr(EmployeeId) ));
end;*)


function TUser.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterInsert(Sender);
  if not result then exit;
  if Assigned(Owner) then
    if Owner is Temployee then
       EmployeeId := Temployee(Owner).ID;
end;

function TUser.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TUser.GetEmployeeId: Integer;
begin
  Result := GetIntegerField('EmployeeId');
end;

function TUser.GetEmployeeName: string;
begin
  result := TEmployee.IDToggle(EmployeeID, Connection.Connection);
end;

function TUser.GetLogonPassword: string;
begin
  result := SimpleEncrypt.DeCrypt(Logon_Password, 'z');
end;

function TUser.GetLogon_Name: string;
begin
  Result := GetStringField('Logon_Name');
end;

function TUser.GetLogon_Password: string;
begin
  Result := GetStringField('Logon_Password');
end;

function TUser.GetOptionNo: Integer;
begin
  Result := GetIntegerField('OptionNo');
end;

function TUser.GetPasswordDate: TDateTime;
begin
  result := GetDateTimeField('PasswordDate');
end;

function TUser.GetPasswordHash: string;
begin
  result := MD5HashHex(LogonPassword);
end;

procedure TUser.SetEmployeeId(const Value: Integer);
begin
  SetIntegerField('EmployeeId', Value);
end;

procedure TUser.SetEmployeeName(const Value: string);
begin
  EmployeeID := TEmployee.IDToggle(Value, Connection.Connection);
end;

procedure TUser.SetLogonPassword(const Value: string);
begin
  Logon_Password := dnmlib.EnCrypt(Value, 'z');
end;

procedure TUser.SetLogon_Name(const Value: string);
begin
  SetStringField('Logon_Name', Value);
end;

procedure TUser.SetLogon_Password(const Value: string);
begin
  SetStringField('Logon_Password', Value);
end;

procedure TUser.SetOptionNo(const Value: Integer);
begin
  SetIntegerField('OptionNo', Value);
end;

procedure TUser.SetPasswordDate(const Value: TDateTime);
begin
  SetDateTimeField('PasswordDate', Value);
end;

class function TUser.UserPasswordDate(const aLogonName, aServer,
  ADatabase: string): TDateTime;
var
  conn: TERPConnection;
  qry: TERPQuery;
begin
  result := 0;
  if (aServer = '') or (aLogonName = '') or (aDatabase = '') then
    exit;
  try
    conn := DBUtils.GetNewDbConnection(aServer,aDatabase);
    qry := TERPQuery.Create(nil);
    try
      conn.Connect;
      qry.Connection := conn;
      qry.SQL.Add('select * from  tblPassword');
      qry.SQL.Add('where Logon_Name = ' + QuotedStr(aLogonName));
      qry.Open;
      result := qry.Fields.FieldByName('PasswordDate').AsDateTime;
    finally
      qry.Free;
      conn.Free;
    end;
  except

  end;
end;
class function TUser.LoginExpireDate(const aLogonName, aServer,
  ADatabase: string): TDateTime;
var
  conn: TERPConnection;
  qry: TERPQuery;
begin
  result := 0;
  if (aServer = '') or (aLogonName = '') or (aDatabase = '') then
    exit;
  try
    conn := DBUtils.GetNewDbConnection(aServer,aDatabase);
    qry := TERPQuery.Create(nil);
    try
      conn.Connect;
      qry.Connection := conn;
      qry.SQL.Add('SELECT  * FROM tbldbpreferences WHERE Name LIKE "LoginExpireDate"');
      qry.Open;
      try
        if trim(qry.Fields.FieldByName('fieldvalue').asString) = '' then Result := 0
        else Result := StrToFloatDef(trim(qry.Fields.FieldByName('fieldvalue').asString), 0);
      Except
        on E:EXception do begin
          Result := 0;
        end;
      end;
    finally
      qry.Free;
      conn.Free;
    end;
  except

  end;
end;

{ TUserAceessLevels }

function TUserAceessLevels.getEmployeeFormAccessVS1: TEmployeeFormAccess;
begin
  Result := TEmployeeFormAccess(getContainercomponent(TEmployeeFormAccess, 'EmployeeId = ' + inttostr(EmployeeId) +' and formid IN (select formid from tblforms where TabGroup = 26)'));
end;

initialization

RegisterClass(TUser);
RegisterClass(TUserAceessLevels);

end.
