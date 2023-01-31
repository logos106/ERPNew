unit TripGroup;

interface

uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  TTripGroup = class(TMSBusObj)

  private
    function GetTripName: string;
    function GetDescription: string;
    function GetActive: Boolean;

    procedure SetTripName(const Value: String);
    procedure SetDescription(const Value: String);
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
    property TripName: string           read GetTripName      write SetTripName;
    property Description: string        read GetDescription   write SetDescription;
    property Active: Boolean            read GetActive        write SetActive;

  end;

implementation

uses
  tcDataUtils, CommonLib;

{ TPayNotes }

constructor TTripGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBusObjectTypeDescription:= 'TripGroup';
  FSQL:= 'SELECT * FROM tblTripGroup';
end;

destructor TTripGroup.Destroy;
begin
  inherited;
end;

procedure TTripGroup.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'TripName');
  SetPropertyFromNode(node, 'Description');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure TTripGroup.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'TripName', Name);
  AddXMLNode(node, 'Description', Description);
  AddXMLNode(node, 'Active', Active);
end;

function TTripGroup.ValidateData: Boolean;
begin
  Result:= False;
  Resultstatus.Clear;
  Result:= True;
end;

function TTripGroup.Save: Boolean;
begin
  Result:= False;
  if not ValidateData then
    Exit;

  Result:= inherited Save;
end;

procedure TTripGroup.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TTripGroup.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TTripGroup.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

class function TTripGroup.GetIDField: String;
begin
  Result:= 'ID';
end;

class function TTripGroup.GetBusObjectTablename: String;
begin
  Result:= 'tblTripGroup';
end;

function TTripGroup.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterPost(Sender);
end;

function TTripGroup.GetTripName: string;           begin Result := GetStringField('TripName');end;
function TTripGroup.GetDescription: string;    begin Result := GetStringField('Description');end;
function TTripGroup.GetActive: Boolean;        begin Result := GetBooleanField('Active');end;

procedure TTripGroup.SetTripName(const Value: string);     begin SetStringField('TripName', Value);end;
procedure TTripGroup.SetDescription(const Value: string);  begin SetStringField('Description', Value);end;
procedure TTripGroup.SetActive(const Value: Boolean);      begin SetBooleanField('Active', Value);end;

initialization
  RegisterClass(TTripGroup);

end.


