unit Vs1CardPreference;

interface

uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  TVs1CardPreference = class(TMSBusObj)
  private
    function GetEmployeeID: Integer;
    function GetActive: Boolean;
    function GetUserID: Integer;
    function GetTabGroup: Integer;
    function GetPosition: Integer;
    function GetCardKey: String;

    procedure SetEmployeeID(const Value: Integer);
    procedure SetActive(const Value: Boolean);
    procedure SetUserID(const Value: Integer);
    procedure SetTabGroup(const Value: Integer);
    procedure SetPosition(const Value: Integer);
    procedure SetCardKey(const Value: String);
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
    property EmployeeID: Integer read GetEmployeeID write SetEmployeeID;
    property Active: Boolean read GetActive write SetActive;
    property UserID: Integer read GetUserID write SetUserID;
    property TabGroup: Integer read GetTabGroup write SetTabGroup;
    property Position: Integer read GetPosition write SetPosition;
    property CardKey: String read GetCardKey write SetCardKey;
  end;

implementation

uses
  tcDataUtils, CommonLib;

{ TVs1CardPreference }

constructor TVs1CardPreference.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBusObjectTypeDescription:= 'Vs1CardPreference';
  FSQL:= 'SELECT * FROM tblVs1CardPreference';
end;

destructor TVs1CardPreference.Destroy;
begin
  inherited;
end;

procedure TVs1CardPreference.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'Vs1CardPreferenceEmployeeID');
  SetBooleanPropertyFromNode(node, 'Vs1CardPreferenceActive');
  SetPropertyFromNode(node, 'Vs1CardPreferenceUserID');
  SetPropertyFromNode(node, 'Vs1CardPreferenceTabGroup');
  SetPropertyFromNode(node, 'Vs1CardPreferencePosition');
  SetPropertyFromNode(node, 'Vs1CardPreferenceCardKey');
end;

procedure TVs1CardPreference.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'EmployeeID', EmployeeID);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'UserID', UserID);
  AddXMLNode(node, 'TabGroup', TabGroup);
  AddXMLNode(node, 'Position', Position);
  AddXMLNode(node, 'CardKey', CardKey);
end;

function TVs1CardPreference.ValidateData: Boolean;
begin
  Result:= False;
  Resultstatus.Clear;
  Result:= True;
end;

function TVs1CardPreference.Save: Boolean;
begin
  Result:= False;
  if not ValidateData then
    Exit;

  Result:= inherited Save;
end;

procedure TVs1CardPreference.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TVs1CardPreference.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TVs1CardPreference.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

class function TVs1CardPreference.GetIDField: String;
begin
  Result:= 'ID'
end;

class function TVs1CardPreference.GetBusObjectTablename: String;
begin
  Result:= 'tblVs1CardPreference';
end;

function TVs1CardPreference.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterPost(Sender);
end;

function TVs1CardPreference.GetEmployeeID: Integer;
begin
  Result := GetIntegerField('EmployeeID');
end;

function TVs1CardPreference.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TVs1CardPreference.GetUserID: Integer;
begin
  Result := GetIntegerField('UserID');
end;

function TVs1CardPreference.GetTabGroup: Integer;
begin
  Result := GetIntegerField('TabGroup');
end;

function TVs1CardPreference.GetPosition: Integer;
begin
  Result := GetIntegerField('Position');
end;

function TVs1CardPreference.GetCardKey: String;
begin
  Result := GetStringField('CardKey');
end;

procedure TVs1CardPreference.SetEmployeeID(const Value: Integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

procedure TVs1CardPreference.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TVs1CardPreference.SetUserID(const Value: Integer);
begin
  SetIntegerField('UserID', Value);
end;

procedure TVs1CardPreference.SetTabGroup(const Value: Integer);
begin
  SetIntegerField('TabGroup', Value);
end;

procedure TVs1CardPreference.SetPosition(const Value: Integer);
begin
  SetIntegerField('Position', Value);
end;

procedure TVs1CardPreference.SetCardKey(const Value: String);
begin
  SetStringField('CardKey', Value);
end;

initialization
  RegisterClass(TVs1CardPreference);

end.

CREATE TABLE tblVs1CardPreference(
  ID INT(11) NOT NULL AUTO_INCREMENT,
  GlobalRef VARCHAR(255),
  EmployeeID INTEGER,
  Active ENUM('T', 'F'),
  UserID INTEGER,
  TabGroup INTEGER,
  Position INTEGER,
  CardKey VARCHAR(50),
  mstimestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  msUpdateSiteCode VARCHAR(3),
  PRIMARY KEY (ID)
);
