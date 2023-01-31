unit BusObjPosKeypad;

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type
  TPosKeypad = class(TMSBusObj)
  private
    function GetDescription: string;
    function GetActive: Boolean;
    procedure SetDescription(const Value: string);
    procedure SetActive(const Value: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
  published
    property Description: string read GetDescription write SetDescription;
    property Active: Boolean read GetActive write SetActive;
  end;

implementation

uses tcDataUtils, CommonLib;

{ TPosKeypad }

constructor TPosKeypad.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'PosKeypad';
  fSQL := 'SELECT * FROM tblposkeypads';
end;

destructor TPosKeypad.Destroy;
begin
  inherited;
end;

procedure TPosKeypad.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'Description');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure TPosKeypad.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'Description', Description);
  AddXMLNode(node, 'Active', Active);
end;

function TPosKeypad.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if self.Description = '' then begin
    AddResult(False, rssWarning, 0, 'Keypad Description is blank.');
    Exit;
  end;
  Result := True;
end;

function TPosKeypad.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TPosKeypad.OnDataIDChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPosKeypad.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TPosKeypad.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TPosKeypad.GetIDField: string;
begin
  Result := 'KeypadID'
end;

class function TPosKeypad.GetBusObjectTablename: string;
begin
  Result := 'tblposkeypads';
end;

function TPosKeypad.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TPosKeypad.GetDescription: string;
begin
  Result := GetStringField('Description');
end;

function TPosKeypad.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

procedure TPosKeypad.SetDescription(const Value: string);
begin
  SetStringField('Description', Value);
end;

procedure TPosKeypad.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

initialization

RegisterClass(TPosKeypad);

end.
