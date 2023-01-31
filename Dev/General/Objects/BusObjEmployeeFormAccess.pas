unit BusObjEmployeeFormAccess;

interface
uses
  classes, BusObjBase, DB;

type

  TEmployeeFormAccess = class(TMSBusObj)
  private
    function GetAccessLevel: integer;
    function GetAccessLevelName: string;
    function GetEmployeeId: integer;
    function GetFormId: integer;
    procedure SetAccessLevel(const Value: integer);
    procedure SetEmployeeId(const Value: integer);
    procedure SetFormId(const Value: integer);
  protected
    procedure DoFieldOnChange(Sender: TField); override;
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); override;
  public
    class function GetBusObjectTablename: string; override;
    class function  GetIDField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ValidateData: boolean; virtual;
    function Save: boolean; override;
  Published
    property EmployeeId: integer read GetEmployeeId write SetEmployeeId;
    property FormId: integer read GetFormId write SetFormId;
    property AccessLevel: integer read GetAccessLevel write SetAccessLevel;
    property AccessLevelName: string read GetAccessLevelName;
  end;

  TEmployeeFormAccessDetail = class(TMSBusObj)
  private
    function GetAccessLevel: integer;
    function GetAccessLevelName: string;
    function GetAccessLevels: boolean;
    function GetDescription: string;
    function GetEmployeeId: integer;
    function GetFormId: integer;
    function GetFormName: string;
    function GetIsForm: boolean;
    function GetSkinsGroup: string;
    function GetTabGroup: integer;

  protected
    Function DoAfterOpen(Sender: TDatasetBusObj): Boolean; Override;

  public
    class function GetBusObjectTablename: string; override;
    class function  GetIDField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ValidateData: boolean; virtual;
    function Save: boolean; override;

  Published
    property EmployeeId: integer read GetEmployeeId;
    property FormId: integer read GetFormId;
    property FormName: string read GetFormName;
    property Description: string read GetDescription;
    property TabGroup: integer read GetTabGroup;
    property IsForm: boolean read GetIsForm;
    property AccessLevels: boolean read GetAccessLevels;
    property SkinsGroup: string read GetSkinsGroup;
    property AccessLevel: integer read GetAccessLevel;
    property AccessLevelName: string read GetAccessLevelName;
  end;


implementation

uses
  AccessLevelUtils;

{ TEmployeeFormAccess }

constructor TEmployeeFormAccess.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription := 'EmployeeFormAccess';
end;

destructor TEmployeeFormAccess.Destroy;
begin

  inherited;
end;

procedure TEmployeeFormAccess.DoFieldOnChange(Sender: TField);
begin
  inherited;

end;

function TEmployeeFormAccess.GetAccessLevel: integer;
begin
  result := GetIntegerField('Access');
end;

function TEmployeeFormAccess.GetAccessLevelName: string;
begin
  result := AccessLevelUtils.AccessLevelToName(AccessLevel);
end;

class function TEmployeeFormAccess.GetBusObjectTablename: string;
begin
  result := 'tblEmployeeFormsAccess';
end;

function TEmployeeFormAccess.GetEmployeeId: integer;
begin
  result := GetIntegerField('EmployeeID');
end;

function TEmployeeFormAccess.GetFormId: integer;
begin
  result := GetIntegerField('FormID');
end;


class function TEmployeeFormAccess.GetIDField: string;
begin
  result := 'FormAccessLineID';
end;

procedure TEmployeeFormAccess.OnDataIdChange(
  const ChangeType: TBusObjDataChangeType);
begin
  inherited;

end;

function TEmployeeFormAccess.Save: boolean;
begin
  ResultStatus.Clear;
  result := ValidateData;
  if result then begin
    result := inherited;
  end;
end;

procedure TEmployeeFormAccess.SetAccessLevel(const Value: integer);
begin
  SetIntegerField('Access', Value);
end;

procedure TEmployeeFormAccess.SetEmployeeId(const Value: integer);
begin
  SetIntegerField('EmployeeId', Value);
end;

procedure TEmployeeFormAccess.SetFormId(const Value: integer);
begin
  SetIntegerField('FormId', Value);

end;

function TEmployeeFormAccess.ValidateData: boolean;
begin
  result := false;
  if FormID = 0 then begin
    AddResult(false, rssWarning, 0, 'Form ID is missing');
    exit;
  end;
  if AccessLevel = 0 then begin
    AddResult(false, rssWarning, 0, 'Access Level is missing');
    exit;
  end;
  if EmployeeID = 0 then begin
    AddResult(false, rssWarning, 0, 'Employee ID is missing');
    exit;
  end;
  result := true;
end;

{ TEmployeeFormAccessDetail }

constructor TEmployeeFormAccessDetail.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription:= 'EmployeeFormAccessDetail';
  fSQL := 'SELECT * FROM tblemployeeformsaccess INNER JOIN tblforms ON tblemployeeformsaccess.FormID = tblforms.FormID';
end;

destructor TEmployeeFormAccessDetail.Destroy;
begin

  inherited;
end;

function TEmployeeFormAccessDetail.DoAfterOpen(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited DoAfterOpen(Sender);
  if not result then exit;
end;

function TEmployeeFormAccessDetail.GetAccessLevel: integer;
begin
  result := GetIntegerField('Access');
end;

function TEmployeeFormAccessDetail.GetAccessLevelName: string;
begin
  result := AccessLevelUtils.AccessLevelToName(AccessLevel);
end;

function TEmployeeFormAccessDetail.GetAccessLevels: boolean;
begin
  result := GetBooleanField('AccessLevels');
end;

class function TEmployeeFormAccessDetail.GetBusObjectTablename: string;
begin
  result := 'tblemployeeformsaccess';
end;

function TEmployeeFormAccessDetail.GetDescription: string;
begin
  result := GetStringField('Description');
end;

function TEmployeeFormAccessDetail.GetEmployeeId: integer;
begin
  result := GetIntegerField('EmployeeId');
end;

function TEmployeeFormAccessDetail.GetFormId: integer;
begin
  result := GetIntegerField('FormId');
end;

function TEmployeeFormAccessDetail.GetFormName: string;
begin
  result := GetStringField('FormName');
end;

class function TEmployeeFormAccessDetail.GetIDField: string;
begin
  result := 'FormAccessLineID';
end;

function TEmployeeFormAccessDetail.GetIsForm: boolean;
begin
  result := GetBooleanField('IsField');
end;

function TEmployeeFormAccessDetail.GetSkinsGroup: string;
begin
  result := GetStringField('SkinsGroup');
end;

function TEmployeeFormAccessDetail.GetTabGroup: integer;
begin
  result := GetIntegerField('TabGroup');
end;

function TEmployeeFormAccessDetail.Save: boolean;
begin
  result := ValidateData;
end;

function TEmployeeFormAccessDetail.ValidateData: boolean;
begin
  result := false;
  AddResult(false,rssWarning,0,ClassName + ' is a read-only object');
end;

{ TVS1EmployeeFormAccessDetail }



initialization
  RegisterClass(TEmployeeFormAccess);
  RegisterClass(TEmployeeFormAccessDetail);

end.
