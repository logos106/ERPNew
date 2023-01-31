unit BusObjPreference;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  22/07/11  1.00.00  A.  Initial Version.
}

interface

uses BusObjBase, DB, Classes, MyAccess, BusObjDeletedItem;

type
  TPreference = class(TMSBusObj)
  private
    function GetPackageID: Integer;
    function GetUserID: Integer;
    function GetPrefGroup: string;
    function GetPrefName: string;
    function GetPrefType: string;
    function GetPrefValue: string;
    function GetPrefDesc: string;
    function GetDepartment: string;
    procedure SetPackageID(const Value: Integer);
    procedure SetUserID(const Value: Integer);
    procedure SetPrefGroup(const Value: string);
    procedure SetPrefName(const Value: string);
    procedure SetPrefType(const Value: string);
    procedure SetPrefValue(const Value: string);
    procedure SetPrefDesc(const Value: string);
    procedure SetDepartment(const Value: string);
    function GetUserName: string;
    procedure SetUserName(const Value: string);
    function GetIndustryId: integer;
    procedure SetIndustryId(const Value: integer);
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
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    procedure Load(aUserID: Integer; aPrefGroup, aPrefName: string; aDepartment: string = ''; aPrefType: string = ''; aPackageId: Integer = 0; AutoCreate: Boolean = true; AIndustryId : integer = 0); overload;
    class function DeleteUserPrefs(aUserID: integer; var msg: string; Connection: TCustomMyConnection = nil): boolean;
    class function CopyPreference(FromUserID, ToUserID: integer; aPrefGroup, aPrefName: string; var msg: string; Connection: TCustomMyConnection = nil): boolean;
    class function _Schema: string; override;
  published
    property PackageID: Integer read GetPackageID write SetPackageID;
    property UserID: Integer read GetUserID write SetUserID;
    property UserName: string read GetUserName write SetUserName;
    property PrefGroup: string read GetPrefGroup write SetPrefGroup;
    property PrefName: string read GetPrefName write SetPrefName;
    property PrefType: string read GetPrefType write SetPrefType;
    property PrefValue: string read GetPrefValue write SetPrefValue;
    property PrefDesc: string read GetPrefDesc write SetPrefDesc;
    property Department: string read GetDepartment write SetDepartment;
    property IndustryId : integer read GetIndustryId write SetIndustryId;
  end;

//  TDeletedPreference = class(TDeletedItem)
//  public
//    class function GetDeletedTablename: string; override;
//  end;

implementation

uses tcDataUtils, CommonLib, sysutils, BusObjEmployee, BusObjSchemaLib,
  ERPDbComponents, CommonDbLib, AppEnvironment;

{ TPreference }

class function TPreference.CopyPreference(FromUserID, ToUserID: integer;
  aPrefGroup, aPrefName: string; var msg: string; Connection: TCustomMyConnection = nil): boolean;
var
  SrcPref, DstPref: TPreference;
  qry : TERPQuery;
  id : integer;
begin
  result:= true;
  SrcPref:= TPreference.Create(nil);
  DstPref:= TPreference.Create(nil);
  try
    SrcPref.Connection:= TMyDacDataConnection.Create(srcPref);
    if Assigned(Connection) then SrcPref.Connection.Connection:= Connection
    else SrcPref.Connection.Connection:= CommonDbLib.GetSharedMyDacConnection;
    DstPref.Connection:= TMyDacDataConnection.Create(DstPref);
    DstPref.Connection.Connection:= SrcPref.Connection.Connection;
    SrcPref.Load(FromUserID,aPrefGroup,aPrefName,'','',0,false);
    if SrcPref.Count > 0 then begin
      DstPref.Load(ToUserID,aPrefGroup,aPrefName,'','',0,true);
      DstPref.PackageID:= SrcPref.PackageID;
      DstPref.PrefType:= SrcPref.PrefType;
      DstPref.PrefValue:= SrcPref.PrefValue;
      DstPref.PrefDesc:= SrcPref.PrefDesc;
      DstPref.Department:= SrcPref.Department;
      DstPref.msUpdateSiteCode:= SrcPref.msUpdateSiteCode;
      if not DstPref.Save then begin
        result:= false;
        msg:= DstPref.ResultStatus.Messages;
      end;
      qry := TERPQuery.Create(nil);
      try
        qry.Connection := GetSharedMyDacConnection;
        qry.SQL.Text := 'select max(id) from tblPageLayout';
        qry.open;
        if qry.RecordCount = 0 then
          id := 1
        else
          id := qry.Fields[0].AsInteger + 1;
        qry.Close;
        qry.SQL.Clear;
        // add only the active layouts
        qry.SQL.Add('update tblPageLayout set Active="F" where UserId=' + IntToStr(ToUserId) + ' and IndustryId=' + IntToStr(AppEnv.CompanyInfo.IndustryId));
        qry.ExecSQL;

        qry.SQL.Text := 'insert into tblpagelayout (Packageid, UserId, PageName, ActionName,EndActionName, TopLeft, Top, Width, Height, NodeType, LineWidth, LineHeads,';
        qry.sql.add('LineColor, SelectedColor,MarkColor, MarkSize, ArrowColor, LineStyle, Arrow1Kind, Arrow2Kind, Active, IndustryId, id)');
        qry.sql.add('select Packageid,' + IntToStr(ToUserId) + ', PageName, ActionName,EndActionName, TopLeft, Top, Width, Height, NodeType, LineWidth, LineHeads,');
        qry.sql.add('LineColor, SelectedColor,MarkColor, MarkSize, ArrowColor, LineStyle, Arrow1Kind, Arrow2Kind, Active,');
        qry.SQL.Add(IntToStr(AppEnv.CompanyInfo.IndustryId) + ',' + IntToStr(id));
        qry.sql.add('from tblPageLayout where userid=' + IntToStr(FromUserId) + ' and Active = "T" and IndustryId=' + IntToStr(AppEnv.CompanyInfo.IndustryId));
        qry.ExecSQL;
      finally
        qry.Free;
      end;
    end
    else begin
      result:= false;
      msg:= 'Source Preference not found';
    end;
  finally
    SrcPref.Free;
    DstPref.Free;
  end;
end;

constructor TPreference.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Preference';
  fSQL := 'SELECT * FROM tblpreferences where IndustryId=' + IntToStr(AppEnv.CompanyInfo.IndustryId);
end;

class function TPreference.DeleteUserPrefs(aUserID: integer; var msg: string;
  Connection: TCustomMyConnection): boolean;
var
  qry: TERPQuery;
begin
  result:= true;
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Connection) then qry.Connection:= Connection
    else qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select PreferenceID, GlobalRef from tblpreferences');
    qry.SQL.Add('where UserID = ' + IntToStr(aUserID));
    qry.SQL.Add('and IndustryId=' + IntToStr(AppEnv.CompanyInfo.IndustryId));
    qry.Open;
    while not qry.Eof do begin
      if qry.FieldByName('GlobalRef').AsString = '' then begin
        qry.Edit;
        qry.FieldByName('GlobalRef').AsString:= AppEnv.Branch.SiteCode + qry.FieldByName('PreferenceID').AsString;
        qry.Post;
      end;
      if not TDeletedItem.AddDeleted('tblpreferences','TPreference',qry.FieldByName('GlobalRef').AsString,qry.FieldByName('PreferenceID').AsInteger,qry.Connection,msg) then begin
        result:= false;
        exit;
      end;
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

destructor TPreference.Destroy;
begin
  inherited;
end;

function TPreference.ValidateData: Boolean;
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
  if (UserID > 0) and (UserName = '') then begin
    { try and get employee name again }
    UserName := TEmployee.IDToggle(UserID,Connection.Connection);
  end;
  if (UserID > 0) and (UserName = '') then begin
    AddResult(false,rssWarning,0,'User not found for ID: ' + IntToStr(UserID));
    exit;
  end;
  if (UserID = 0) and (UserName <> '') then begin
    { try and get employee id again }
    UserID := TEmployee.IDToggle(UserName,Connection.Connection);
  end;
  if (UserID = 0) and (UserName <> '') then begin
    AddResult(false,rssWarning,0,'User ID not found for User Name: "' + UserName + '"');
    exit;
  end;
  Result := True;
end;

class function TPreference._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TEmployee','UserObj','UserID','ID');
  TBOSchema.AddRefType(result,'TEmployee','UserObj','UserName','EmployeeName');
end;

function TPreference.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TPreference.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPreference.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  if Sysutils.SameText(Sender.fieldName, 'UserID') then begin
    UserName:= TEmployee.IDToggle(UserID, Connection.Connection);
  end
  else if Sysutils.SameText(Sender.fieldName, 'UserName') then begin
    UserID:= TEmployee.IDToggle(UserName, Connection.Connection);
  end;
end;

function TPreference.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TPreference.GetIDField: string;
begin
  Result := 'PreferenceID'
end;

function TPreference.GetIndustryId: integer;
begin
  Result := GetIntegerField('IndustryId');
end;

class function TPreference.GetKeyStringField: string;
begin
  result:= 'UserName,PrefGroup,PrefName,IdustryId';
end;

class function TPreference.GetKeyStringProperty: string;
begin
  result:= 'UserName,PrefGroup,PrefName,IndustryId';
end;

class function TPreference.GetBusObjectTablename: string;
begin
  Result := 'tblpreferences';
end;

function TPreference.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TPreference.GetPackageID: Integer;
begin
  Result := GetIntegerField('PackageID');
end;

function TPreference.GetUserID: Integer;
begin
  Result := GetIntegerField('UserID');
end;

function TPreference.GetUserName: string;
begin
  result:= GetStringField('UserName');
end;

function TPreference.GetPrefGroup: string;
begin
  Result := GetStringField('PrefGroup');
end;

function TPreference.GetPrefName: string;
begin
  Result := GetStringField('PrefName');
end;

function TPreference.GetPrefType: string;
begin
  Result := GetStringField('PrefType');
end;

function TPreference.GetPrefValue: string;
begin
  Result := GetStringField('PrefValue');
end;

function TPreference.GetPrefDesc: string;
begin
  Result := GetStringField('PrefDesc');
end;

function TPreference.GetDepartment: string;
begin
  Result := GetStringField('Department');
end;

procedure TPreference.SetPackageID(const Value: Integer);
begin
  SetIntegerField('PackageID', Value);
end;

procedure TPreference.SetUserID(const Value: Integer);
begin
  SetIntegerField('UserID', Value);
end;

procedure TPreference.SetUserName(const Value: string);
begin
  SetStringField('UserName', Value);
end;

procedure TPreference.SetPrefGroup(const Value: string);
begin
  SetStringField('PrefGroup', Value);
end;

procedure TPreference.SetPrefName(const Value: string);
begin
  SetStringField('PrefName', Value);
end;

procedure TPreference.SetPrefType(const Value: string);
begin
  SetStringField('PrefType', Value);
end;

procedure TPreference.SetPrefValue(const Value: string);
begin
  SetStringField('PrefValue', Value);
end;

procedure TPreference.SetPrefDesc(const Value: string);
begin
  SetStringField('PrefDesc', Value);
end;

procedure TPreference.SetDepartment(const Value: string);
begin
  SetStringField('Department', Value);
end;

procedure TPreference.SetIndustryId(const Value: integer);
begin
  SetIntegerField('IndustryId', Value);
end;

procedure TPreference.Load(aUserID: Integer; aPrefGroup, aPrefName: string;
  aDepartment: string = ''; aPrefType: string = ''; aPackageId: Integer = 0;
  AutoCreate: Boolean = true; AIndustryId : integer = 0);
var
  select: string;
begin
  if aPrefGroup = '' then raise Exception.Create('TPreference.Load - no PrefGroup defined.');
  if aPrefName = '' then raise Exception.Create('TPreference.Load - no PrefName defined.');
  select := 'PackageID = ' + IntToStr(aPackageId) + ' and UserID = ' + IntToStr(aUserID) + ' and PrefGroup = ' + QuotedStr(aPrefGroup) + ' and PrefName = ' + QuotedStr(aPrefName);
  if aDepartment <> '' then select := select + ' and Department = ' + QuotedStr(aDepartment);
  if aPrefType <> '' then select := select + ' and PrefType = ' + QuotedStr(aPrefType);
  if AIndustryId=0 then
    Select := Select + ' and IndustryId = ' + IntToStr(AppEnv.CompanyInfo.IndustryId)
  else
    Select := Select + ' and IndustryId = ' + IntToStr(AIndustryId);
  LoadSelect(select);
  if (Count = 0) and AutoCreate then begin
    New;
    UserID := aUserID;
    PackageID := aPackageId;
    PrefGroup := aPrefGroup;
    PrefName := aPrefName;
    if aDepartment <> '' then Department := aDepartment;
    if aPrefType <> '' then PrefType := aPrefType;
    PostDb;
  end;
end;

//{ TDeletedPreference }
//
//class function TDeletedPreference.GetDeletedTablename: string;
//begin
//  result := 'tblpreferences';
//end;

initialization

RegisterClass(TPreference);
//RegisterClass(TDeletedPreference);

end.
