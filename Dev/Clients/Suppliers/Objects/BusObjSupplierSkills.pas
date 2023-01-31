unit BusObjSupplierSkills;

interface

uses
  BusObjBase, Classes, XMLDoc, XMLIntf, DB;

type

  TSupplierSkill = class(TMSBusObj)
  private
    function GetProviderID: integer;
    function GetProviderName: string;
    function GetSkillID: integer;
    function GetSkillName: string;
    procedure SetActive(const Value: boolean);
    procedure SetProviderID(const Value: integer);
    procedure SetProviderName(const Value: string);
    procedure SetSkillID(const Value: integer);
    procedure SetSkillName(const Value: string);
    function GetActive: boolean;
  protected
    procedure DoFieldOnChange(Sender: TField);                           override;
  public
    constructor      Create(AOwner: TComponent);                         override;
    destructor       Destroy;                                            override;
    //procedure        LoadFromXMLNode(const node: IXMLNode);              override;
    //procedure        SaveToXMLNode(const node: IXMLNode);                override;
    function         ValidateData: Boolean;                              override;
    function         Save: Boolean;                                      override;
    procedure New; override;
    Class function   GetIDField              : string;                   override;
    //Class function   GetKeyStringField       : string;                   override;
    Class function   GetBusObjectTablename   : string;                   override;
    //class function GetKeyStringProperty: string; override;
  published
    property ProviderID: integer read GetProviderID write SetProviderID;
    property ProviderName: string read GetProviderName write SetProviderName;
    property SkillID: integer read GetSkillID write SetSkillID;
    property SkillName: string read GetSkillName write SetSkillName;
    property Active: boolean read GetActive write SetActive;
  end;


implementation

uses
  BusObjClient, BusobjEmpskills, SysUtils;

{ TSupplierSkill }

constructor TSupplierSkill.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'SupplierSkill';
  fSQL := 'SELECT * FROM tblsupplierskills';

end;

destructor TSupplierSkill.Destroy;
begin

  inherited;
end;

procedure TSupplierSkill.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if (Sender.FieldKind <> fkData) or Dataset.ControlsDisabled then
    if DoFieldChangewhenDisabled= False then Exit; // we are only interested in data fields.
  if Sysutils.SameText(Sender.fieldName, 'SkillID') then begin
    SkillName := TSkills.IDToggle(SkillID, Connection.Connection);
  end
  else if Sysutils.SameText(Sender.fieldName, 'SkillName') then begin
    SkillID := TSkills.IDToggle(SkillName, Connection.Connection);
  end;
end;

function TSupplierSkill.GetActive: boolean;
begin
  result := GetBooleanField('Active');
end;

class function TSupplierSkill.GetBusObjectTablename: string;
begin
  result := 'tblsupplierskills';
end;

class function TSupplierSkill.GetIDField: string;
begin
  result := 'ID';
end;

function TSupplierSkill.GetProviderID: integer;
begin
  result := GetIntegerField('ProviderID');
end;

function TSupplierSkill.GetProviderName: string;
begin
  result := TSupplier.IDToggle(ProviderID, Connection.Connection);
end;

function TSupplierSkill.GetSkillID: integer;
begin
  result := GetIntegerField('skillid');
end;

function TSupplierSkill.GetSkillName: string;
begin
  result := GetStringField('Skillname');
end;

procedure TSupplierSkill.New;
begin
  inherited;

end;

function TSupplierSkill.Save: Boolean;
begin
  PostDB;
  resultStatus.Clear;
  result := ValidateData;
  if result then
    result := inherited;
end;

procedure TSupplierSkill.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TSupplierSkill.SetProviderID(const Value: integer);
begin
  SetIntegerField('ProviderID',Value);
end;

procedure TSupplierSkill.SetProviderName(const Value: string);
begin
  if Value = '' then
    ProviderID := 0
  else begin
    ProviderID := TSupplier.IDToggle(Value, Connection.Connection);
    if ProviderID = 0 then
      ProviderID := -1;
  end;
end;

procedure TSupplierSkill.SetSkillID(const Value: integer);
begin
  SetIntegerField('skillid', Value);
end;

procedure TSupplierSkill.SetSkillName(const Value: string);
begin
  SetStringField('Skillname', Value);
end;

function TSupplierSkill.ValidateData: Boolean;
begin
  result := false;
  if ProviderID < 0 then begin
    self.AddResult(false,rssWarning,0,'Provider (Supplier) not found');
    exit;
  end;
  if ProviderID = 0 then begin
    self.AddResult(false,rssWarning,0,'Provider (Supplier) is blank');
    exit;
  end;
  if SkillID = 0 then begin
    self.AddResult(false,rssWarning,0,'Skill is blank');
    exit;
  end;
  result := true;
end;

end.
