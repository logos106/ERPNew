unit BusObjAbility;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  15/03/12  1.00.00  A.  Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type

  TAbility = class(TMSBusObj)
  private
    function GetAbilityDesc: string;
    function GetAbilityValue: Integer;
    function GetActive: Boolean;
    procedure SetAbilityDesc(const Value: string);
    procedure SetAbilityValue(const Value: Integer);
    procedure SetActive(const Value: Boolean);
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
  published
    property AbilityDesc: string read GetAbilityDesc write SetAbilityDesc;
    property AbilityValue: Integer read GetAbilityValue write SetAbilityValue;
    property Active: Boolean read GetActive write SetActive;
  end;

implementation

uses tcDataUtils, CommonLib, SysUtils;

{ TAbility }

constructor TAbility.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Ability';
  fSQL := 'SELECT * FROM tblability';
end;

destructor TAbility.Destroy;
begin
  inherited;
end;

procedure TAbility.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'AbilityDesc');
  SetPropertyFromNode(node, 'AbilityValue');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure TAbility.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'AbilityDesc', AbilityDesc);
  AddXMLNode(node, 'AbilityValue', AbilityValue);
  AddXMLNode(node, 'Active', Active);
end;

function TAbility.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if Trim(AbilityDesc) = '' then begin
    AddResult(false, rssWarning, 0, 'Ability Description is blank');
    exit;
  end;
  Result := True;
end;

function TAbility.Save: Boolean;
begin
  Result := False;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;

procedure TAbility.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TAbility.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TAbility.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TAbility.GetIDField: string;
begin
  Result := 'AbilityID'
end;

class function TAbility.GetKeyStringField: string;
begin
  result := 'AbilityDesc';
end;

class function TAbility.GetKeyStringProperty: string;
begin
  result := 'AbilityDesc';
end;

class function TAbility.GetBusObjectTablename: string;
begin
  Result := 'tblability';
end;

function TAbility.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TAbility.GetAbilityDesc: string;
begin
  Result := GetStringField('AbilityDesc');
end;

function TAbility.GetAbilityValue: Integer;
begin
  Result := GetIntegerField('AbilityValue');
end;

function TAbility.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

procedure TAbility.SetAbilityDesc(const Value: string);
begin
  SetStringField('AbilityDesc', Value);
end;

procedure TAbility.SetAbilityValue(const Value: Integer);
begin
  SetIntegerField('AbilityValue', Value);
end;

procedure TAbility.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

initialization

RegisterClass(TAbility);

end.
