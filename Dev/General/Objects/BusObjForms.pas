unit BusObjForms;

interface

uses
  classes, BusObjBase, DB;

type

  TERPForm = class(TMSBusObj)
  private
    function GetAccessLevels: boolean;
    function GetBusinessObjectName: string;
    function GetDescription: string;
    function GetFormName: string;
    function GetIsForm: boolean;
    function GetSkinsGroup: string;
    function GetTabGroup: integer;
    function GetTabGroupName: string;
  protected
    procedure DoFieldOnChange(Sender: TField); override;
    procedure OnDataIdChange(Const ChangeType: TBusObjDataChangeType); override;
  public
    class function GetBusObjectTablename: string; override;
    class function  GetIDField: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  Published
    property FormName: string read GetFormName;
    property BusinessObjectName: string read GetBusinessObjectName;
    property Description: string read GetDescription;
    property TabGroup: integer read GetTabGroup;
    property TabGroupName: string read GetTabGroupName;
    property IsForm: boolean read GetIsForm;
    property AccessLevels: boolean read GetAccessLevels;
    property SkinsGroup: string read GetSkinsGroup;
  end;


implementation

uses
  AccessLevelUtils;

{ TERPForm }

constructor TERPForm.Create(AOwner: TComponent);
begin
  inherited;
  fBusObjectTypeDescription:= 'ERPForm';
//  fSQL := 'SELECT * FROM tblemployeeprocesssteps';
end;

destructor TERPForm.Destroy;
begin

  inherited;
end;

procedure TERPForm.DoFieldOnChange(Sender: TField);
begin
  inherited;

end;

function TERPForm.GetAccessLevels: boolean;
begin
  result := GetBooleanField('AccessLevels');
end;

function TERPForm.GetBusinessObjectName: string;
begin
  result := GetStringField('BusinessObjectName');
end;

class function TERPForm.GetBusObjectTablename: string;
begin
  result := 'tblforms';
end;

function TERPForm.GetDescription: string;
begin
  result := GetStringField('Description');
end;

function TERPForm.GetFormName: string;
begin
  result := GetStringField('FormName');
end;

class function TERPForm.GetIDField: string;
begin
  result := 'FormID';
end;

function TERPForm.GetIsForm: boolean;
begin
  result := GetBooleanField('IsForm');
end;

function TERPForm.GetSkinsGroup: string;
begin
  result := GetStringField('SkinsGroup');
end;

function TERPForm.GetTabGroup: integer;
begin
  result := GetIntegerField('TabGroup');
end;

function TERPForm.GetTabGroupName: string;
begin
  result := AccessGroupIdToName(TabGroup);
end;

procedure TERPForm.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;

end;

initialization
  RegisterClass(TERPForm);

end.
