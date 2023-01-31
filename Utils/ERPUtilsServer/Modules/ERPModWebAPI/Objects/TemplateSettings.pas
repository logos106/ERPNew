unit TemplateSettings;

interface

uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  TTemplateSettings = class(TMSBusObj)

  private
    function GetEmployeeID: Integer;
    function GetSettingName: string;
    function GetDescription: string;
    function GetTemplate: Integer;
    function GetActive: Boolean;

    procedure SetEmployeeID(const Value: Integer);
    procedure SetSettingName(const Value: String);
    procedure SetDescription(const Value: string);
    procedure SetTemplate(const Value: Integer);
    procedure SetActive(const Value: Boolean);

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
    property EmployeeID: Integer    read GetEmployeeID    write SetEmployeeID;
    property SettingName: string    read GetSettingName   write SetSettingName;
    property Description: string    read GetDescription   write SetDescription;
    property Template: Integer      read GetTemplate      write SetTemplate;
    property Active: Boolean        read GetActive        write SetActive;

  end;

implementation

uses
  tcDataUtils, CommonLib;

{ TPayNotes }

constructor TTemplateSettings.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBusObjectTypeDescription:= 'TemplateSettings';
  FSQL:= 'SELECT * FROM tblTemplateSettings';
end;

destructor TTemplateSettings.Destroy;
begin
  inherited;
end;

procedure TTemplateSettings.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'EmployeeID');
  SetPropertyFromNode(node, 'SettingName');
  SetPropertyFromNode(node, 'Description');
  SetPropertyFromNode(node, 'Template');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure TTemplateSettings.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'EmployeeID', EmployeeID);
  AddXMLNode(node, 'SettingName', SettingName);
  AddXMLNode(node, 'Description', Description);
  AddXMLNode(node, 'Template', Template);
  AddXMLNode(node, 'Active', Active);
end;

function TTemplateSettings.ValidateData: Boolean;
begin
  Result:= False;
  Resultstatus.Clear;
  Result:= True;
end;

function TTemplateSettings.Save: Boolean;
begin
  Result:= False;
  if not ValidateData then
    Exit;

  Result:= inherited Save;
end;

procedure TTemplateSettings.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TTemplateSettings.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TTemplateSettings.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

class function TTemplateSettings.GetIDField: String;
begin
  Result:= 'ID';
end;

class function TTemplateSettings.GetBusObjectTablename: String;
begin
  Result:= 'tblTemplateSettings';
end;

function TTemplateSettings.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterPost(Sender);
end;

function TTemplateSettings.GetEmployeeID: Integer;    begin Result := GetIntegerField('EmployeeID');end;
function TTemplateSettings.GetSettingName: string;    begin Result := GetStringField('SettingName');end;
function TTemplateSettings.GetDescription: string;    begin Result := GetStringField('Description');end;
function TTemplateSettings.GetTemplate: Integer;      begin Result := GetIntegerField('Template');end;
function TTemplateSettings.GetActive: Boolean;        begin Result := GetBooleanField('Active');end;

procedure TTemplateSettings.SetEmployeeID(const Value: Integer);     begin SetIntegerField('EmployeeID', Value);end;
procedure TTemplateSettings.SetSettingName(const Value: string);    begin SetStringField('SettingName', Value);end;
procedure TTemplateSettings.SetDescription(const Value: string);    begin SetStringField('Description', Value);end;
procedure TTemplateSettings.SetTemplate(const Value: Integer);      begin SetIntegerField('Template', Value);end;
procedure TTemplateSettings.SetActive(const Value: Boolean);        begin SetBooleanField('Active', Value);end;

initialization
  RegisterClass(TTemplateSettings);

end.


