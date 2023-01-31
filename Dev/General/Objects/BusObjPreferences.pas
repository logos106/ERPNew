unit BusObjPreferences;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  10/02/12  1.00.00  A.  Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, MyAccess;

type
  TPreferences = class(TMSBusObj)
  private
    function GetPackageID: Integer;
    function GetUserID: Integer;
    function GetPrefGroup: string;
    function GetPrefName: string;
    function GetPrefType: Boolean;
    function GetPrefValue: string;
    function GetPrefDesc: string;
    function GetDepartment: string;
    procedure SetPackageID(const Value: Integer);
    procedure SetUserID(const Value: Integer);
    procedure SetPrefGroup(const Value: string);
    procedure SetPrefName(const Value: string);
    procedure SetPrefType(const Value: Boolean);
    procedure SetPrefValue(const Value: string);
    procedure SetPrefDesc(const Value: string);
    procedure SetDepartment(const Value: string);
    function GetUserName: string;
    procedure SetUserName(const Value: string);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
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
    class function IDToggle(const ID: Integer; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): string; overload; override;
    class function IDToggle(const KeyString: string; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): Integer; overload; override;
    class function _Schema: string; override;
  published
    property PackageID: Integer read GetPackageID write SetPackageID;
    property UserID: Integer read GetUserID write SetUserID;
    property UserName: string read GetUserName write SetUserName;
    property PrefGroup: string read GetPrefGroup write SetPrefGroup;
    property PrefName: string read GetPrefName write SetPrefName;
    property PrefType: Boolean read GetPrefType write SetPrefType;
    property PrefValue: string read GetPrefValue write SetPrefValue;
    property PrefDesc: string read GetPrefDesc write SetPrefDesc;
    property Department: string read GetDepartment write SetDepartment;
  end;

implementation

uses tcDataUtils, CommonLib, BusObjEmployee, BusObjSchemaLib,
  ERPDbComponents, CommonDbLib, sysutils;

{ TPreferences }

constructor TPreferences.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Preferences';
  fSQL := 'SELECT * FROM tblpreferences';
  self.ExportExcludeList.Add('userid');
end;

destructor TPreferences.Destroy;
begin
  inherited;
end;

procedure TPreferences.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'PackageID');
  SetPropertyFromNode(node, 'UserID');
  SetPropertyFromNode(node, 'PrefGroup');
  SetPropertyFromNode(node, 'PrefName');
  SetBooleanPropertyFromNode(node, 'PrefType');
  SetPropertyFromNode(node, 'PrefValue');
  SetPropertyFromNode(node, 'PrefDesc');
  SetPropertyFromNode(node, 'Department');
  SetPropertyFromNode(node, 'msUpdateSiteCode');
end;

procedure TPreferences.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'PackageID', PackageID);
  AddXMLNode(node, 'UserID', UserID);
  AddXMLNode(node, 'PrefGroup', PrefGroup);
  AddXMLNode(node, 'PrefName', PrefName);
  AddXMLNode(node, 'PrefType', PrefType);
  AddXMLNode(node, 'PrefValue', PrefValue);
  AddXMLNode(node, 'PrefDesc', PrefDesc);
  AddXMLNode(node, 'Department', Department);
  AddXMLNode(node, 'msUpdateSiteCode', msUpdateSiteCode);
end;

function TPreferences.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if PrefGroup = '' then begin
    AddResult(false,rssWarning,0,'PrefGroup is blank.');
    exit;
  end;
  if PrefName = '' then begin
    AddResult(false,rssWarning,0,'PrefName is blank.');
    exit;
  end;
  if UserID < 0 then begin
    AddResult(false,rssWarning,0,'Could not find User.');
    exit;
  end;
  Result := True;
end;

class function TPreferences._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TEmployee','UserObj','UserID','ID');
  TBOSchema.AddRefType(result,'TEmployee','UserObj','UserName','EmployeeName');
end;

function TPreferences.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TPreferences.OnDataIDChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPreferences.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TPreferences.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TPreferences.GetIDField: string;
begin
  Result := 'PreferenceID'
end;

class function TPreferences.GetKeyStringField: string;
begin
  result:= 'UserName,PrefGroup,PrefName';
end;

class function TPreferences.GetKeyStringProperty: string;
begin
  result:= 'UserName,PrefGroup,PrefName';
end;

class function TPreferences.GetBusObjectTablename: string;
begin
  Result := 'tblpreferences';
end;

function TPreferences.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TPreferences.GetPackageID: Integer;
begin
  Result := GetIntegerField('PackageID');
end;

function TPreferences.GetUserID: Integer;
begin
  Result := GetIntegerField('UserID');
end;

function TPreferences.GetUserName: string;
begin
  result:= TEmployee.IDToggle(UserID, Connection.Connection);
end;

class function TPreferences.IDToggle(const ID: Integer;
  Connection: TCustomMyConnection; const AndSQL: string): string;
var
  qry: TERPQuery;
  sl: TStringList;
begin
  qry:= TERPQuery.Create(nil);
  sl:= TStringList.Create;
  try
    if Assigned(Connection) then
      qry.Connection := Connection
    else
      qry.Connection := CommonDBLib.GetSharedMyDacConnection;
    qry.SQL.Add('select UserID,PrefGroup,PrefName from tblPreferences where');
    qry.SQL.Add('PreferenceID = ' + IntToStr(ID));
    qry.Open;
    if not qry.IsEmpty then begin
      sl.Add(TEmployee.IDToggle(qry.FieldByName('UserID').AsInteger,qry.Connection));
      sl.Add(qry.FieldByName('PrefGroup').AsString);
      sl.Add(qry.FieldByName('PrefName').AsString);
      result:= sl.CommaText;
    end
    else
      result:= '';
  finally
    sl.Free;
    qry.Free;
  end;
end;

class function TPreferences.IDToggle(const KeyString: string;
  Connection: TCustomMyConnection; const AndSQL: string): Integer;
var
  qry: TERPQuery;
  sl: TStringList;
begin
  qry:= TERPQuery.Create(nil);
  sl:= TStringList.Create;
  try
    if Assigned(Connection) then
      qry.Connection := Connection
    else
      qry.Connection := CommonDBLib.GetSharedMyDacConnection;
    sl.CommaText:= KeyString;
    qry.SQL.Add('select PreferenceID from tblPreferences where');
    qry.SQL.Add('UserID = ' + IntToStr(TEmployee.IDToggle(sl[0], qry.Connection)));
    qry.SQL.Add('and PrefGroup = ' + QuotedStr(sl[1]));
    qry.SQL.Add('and PrefName = ' + QuotedStr(sl[2]));
    qry.Open;
    if not qry.IsEmpty then
      result:= qry.Fields[0].AsInteger
    else
      result:= 0;
  finally
    sl.Free;
    qry.Free;
  end;
end;

function TPreferences.GetPrefGroup: string;
begin
  Result := GetStringField('PrefGroup');
end;

function TPreferences.GetPrefName: string;
begin
  Result := GetStringField('PrefName');
end;

function TPreferences.GetPrefType: Boolean;
begin
  Result := GetBooleanField('PrefType');
end;

function TPreferences.GetPrefValue: string;
begin
  Result := GetStringField('PrefValue');
end;

function TPreferences.GetPrefDesc: string;
begin
  Result := GetStringField('PrefDesc');
end;

function TPreferences.GetDepartment: string;
begin
  Result := GetStringField('Department');
end;

procedure TPreferences.SetPackageID(const Value: Integer);
begin
  SetIntegerField('PackageID', Value);
end;

procedure TPreferences.SetUserID(const Value: Integer);
begin
  SetIntegerField('UserID', Value);
end;

procedure TPreferences.SetUserName(const Value: string);
begin
  if Value <> '' then begin
    UserID:= TEmployee.IDToggle(Value, Connection.Connection);
    if UserId = 0 then
      UserID:= -1;
  end
  else
    UserID:= 0;
end;

procedure TPreferences.SetPrefGroup(const Value: string);
begin
  SetStringField('PrefGroup', Value);
end;

procedure TPreferences.SetPrefName(const Value: string);
begin
  SetStringField('PrefName', Value);
end;

procedure TPreferences.SetPrefType(const Value: Boolean);
begin
  SetBooleanField('PrefType', Value);
end;

procedure TPreferences.SetPrefValue(const Value: string);
begin
  SetStringField('PrefValue', Value);
end;

procedure TPreferences.SetPrefDesc(const Value: string);
begin
  SetStringField('PrefDesc', Value);
end;

procedure TPreferences.SetDepartment(const Value: string);
begin
  SetStringField('Department', Value);
end;

initialization

RegisterClass(TPreferences);

end.
