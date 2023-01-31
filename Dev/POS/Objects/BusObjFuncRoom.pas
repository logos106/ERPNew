unit BusObjFuncRoom;

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf;

type
  TFuncRoom = class(TMSBusObj)
  private
    function GetRoomName: string;
    function GetCapacity: Integer;
    function GetResetTime: TDateTime;
    function GetPerDay: Double;
    function GetPerHalfDay: Double;
    function GetPerHour: Double;
//    function GetParentRoomID: Integer;
    function GetActive: Boolean;
    procedure SetRoomName(const Value: string);
    procedure SetCapacity(const Value: Integer);
    procedure SetResetTime(const Value: TDateTime);
    procedure SetPerDay(const Value: Double);
    procedure SetPerHalfDay(const Value: Double);
    procedure SetPerHour(const Value: Double);
//    procedure SetParentRoomID(const Value: Integer);
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
    property RoomName: string read GetRoomName write SetRoomName;
    property Capacity: Integer read GetCapacity write SetCapacity;
    property ResetTime: TDateTime read GetResetTime write SetResetTime;
    property PerDay: Double read GetPerDay write SetPerDay;
    property PerHalfDay: Double read GetPerHalfDay write SetPerHalfDay;
    property PerHour: Double read GetPerHour write SetPerHour;
//    property ParentRoomID: Integer read GetParentRoomID write SetParentRoomID;
    property Active: Boolean read GetActive write SetActive;
  end;

implementation

uses tcDataUtils, CommonLib, SysUtils;

{ TFuncRooms }

constructor TFuncRoom.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'FuncRooms';
  fSQL := 'SELECT * FROM tblfuncrooms';
end;

destructor TFuncRoom.Destroy;
begin
  inherited;
end;

procedure TFuncRoom.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'RoomName');
  SetPropertyFromNode(node, 'Capacity');
  SetDateTimePropertyFromNode(node, 'ResetTime');
  SetPropertyFromNode(node, 'PerDay');
  SetPropertyFromNode(node, 'PerHalfDay');
  SetPropertyFromNode(node, 'PerHour');
//  SetPropertyFromNode(node, 'ParentRoomID');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure TFuncRoom.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'RoomName', RoomName);
  AddXMLNode(node, 'Capacity', Capacity);
  AddXMLNode(node, 'ResetTime', ResetTime);
  AddXMLNode(node, 'PerDay', PerDay);
  AddXMLNode(node, 'PerHalfDay', PerHalfDay);
  AddXMLNode(node, 'PerHour', PerHour);
//  AddXMLNode(node, 'ParentRoomID', ParentRoomID);
  AddXMLNode(node, 'Active', Active);
end;

function TFuncRoom.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if Trim(RoomName) = '' then begin
    AddResult(false,rssWarning,0,'Room Name is blank');
    exit;
  end;
  Result := True;
end;

function TFuncRoom.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TFuncRoom.OnDataIDChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TFuncRoom.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TFuncRoom.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TFuncRoom.GetIDField: string;
begin
  Result := 'RoomID'
end;

class function TFuncRoom.GetBusObjectTablename: string;
begin
  Result := 'tblfuncrooms';
end;

function TFuncRoom.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }

function TFuncRoom.GetRoomName: string;
begin
  Result := GetStringField('Name');
end;

function TFuncRoom.GetCapacity: Integer;
begin
  Result := GetIntegerField('Capacity');
end;

function TFuncRoom.GetResetTime: TDateTime;
begin
  Result := GetDateTimeField('ResetTime');
end;

function TFuncRoom.GetPerDay: Double;
begin
  Result := GetFloatField('PerDay');
end;

function TFuncRoom.GetPerHalfDay: Double;
begin
  Result := GetFloatField('PerHalfDay');
end;

function TFuncRoom.GetPerHour: Double;
begin
  Result := GetFloatField('PerHour');
end;

//function TFuncRoom.GetParentRoomID: Integer;
//begin
//  Result := GetIntegerField('ParentRoomID');
//end;

function TFuncRoom.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

procedure TFuncRoom.SetRoomName(const Value: string);
begin
  SetStringField('Name', Value);
end;

procedure TFuncRoom.SetCapacity(const Value: Integer);
begin
  SetIntegerField('Capacity', Value);
end;

procedure TFuncRoom.SetResetTime(const Value: TDateTime);
begin
  SetDateTimeField('ResetTime', Value);
end;

procedure TFuncRoom.SetPerDay(const Value: Double);
begin
  SetFloatField('PerDay', Value);
end;

procedure TFuncRoom.SetPerHalfDay(const Value: Double);
begin
  SetFloatField('PerHalfDay', Value);
end;

procedure TFuncRoom.SetPerHour(const Value: Double);
begin
  SetFloatField('PerHour', Value);
end;

//procedure TFuncRooms.SetParentRoomID(const Value: Integer);
//begin
//  SetIntegerField('ParentRoomID', Value);
//end;

procedure TFuncRoom.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

initialization

RegisterClass(TFuncRoom);

end.
