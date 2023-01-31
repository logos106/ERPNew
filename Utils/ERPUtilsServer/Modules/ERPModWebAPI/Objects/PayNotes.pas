unit PayNotes;

interface

uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  TPayNotes = class(TMSBusObj)
  private
    function GetEmployeeID: Integer;
    function GetActive: Boolean;
    function GetUserID: Integer;
    function GetUserName: String;
    function GetNotes: String;
    function GetCreatedAt: TDateTime;

    procedure SetEmployeeID(const Value: Integer);
    procedure SetActive(const Value: Boolean);
    procedure SetUserID(const Value: Integer);
    procedure SetUserName(const Value: String);
    procedure SetNotes(const Value: String);
    procedure SetCreatedAt(const Value: TDateTime);
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
    property UserName: String read GetUserName write SetUserName;
    property Notes: String read GetNotes write SetNotes;
    property CreatedAt: TDateTime read GetCreatedAt write SetCreatedAt;
  end;

implementation

uses
  tcDataUtils, CommonLib;

{ TPayNotes }

constructor TPayNotes.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBusObjectTypeDescription:= 'PayNotes';
  FSQL:= 'SELECT * FROM tblPayNotes';
end;

destructor TPayNotes.Destroy;
begin
  inherited;
end;

procedure TPayNotes.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'EmployeeID');
  SetBooleanPropertyFromNode(node, 'Active');
  SetPropertyFromNode(node, 'UserID');
  SetPropertyFromNode(node, 'UserName');
  SetPropertyFromNode(node, 'Notes');
  SetDatetimePropertyFromNode(node, 'CreatedAt');
end;

procedure TPayNotes.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'EmployeeID', EmployeeID);
  AddXMLNode(node, 'Active', Active);
  AddXMLNode(node, 'UserID', UserID);
  AddXMLNode(node, 'UserName', UserName);
  AddXMLNode(node, 'Notes', Notes);
  AddXMLNode(node, 'CreatedAt', CreatedAt);
end;

function TPayNotes.ValidateData: Boolean;
begin
  Result:= False;
  Resultstatus.Clear;
  Result:= True;
end;

function TPayNotes.Save: Boolean;
begin
  Result:= False;
  if not ValidateData then
    Exit;

  Result:= inherited Save;
end;

procedure TPayNotes.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TPayNotes.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TPayNotes.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

class function TPayNotes.GetIDField: String;
begin
  Result:= 'ID';
end;

class function TPayNotes.GetBusObjectTablename: String;
begin
  Result:= 'tblPayNotes';
end;

function TPayNotes.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterPost(Sender);
end;

function TPayNotes.GetEmployeeID: Integer;
begin
  Result := GetIntegerField('EmployeeID');
end;

function TPayNotes.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

function TPayNotes.GetUserID: Integer;
begin
  Result := GetIntegerField('UserID');
end;

function TPayNotes.GetUserName: String;
begin
  Result := GetStringField('UserName');
end;

function TPayNotes.GetNotes: String;
begin
  Result := GetStringField('Notes');
end;

function TPayNotes.GetCreatedAt: TDateTime;
begin
  Result := GetDateTimeField('CreatedAt');
end;

procedure TPayNotes.SetEmployeeID(const Value: Integer);
begin
  SetIntegerField('EmployeeID', Value);
end;

procedure TPayNotes.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TPayNotes.SetUserID(const Value: Integer);
begin
  SetIntegerField('UserID', Value);
end;

procedure TPayNotes.SetUserName(const Value: String);
begin
  SetStringField('UserName', Value);
end;

procedure TPayNotes.SetNotes(const Value: String);
begin
  SetStringField('Notes', Value);
end;

procedure TPayNotes.SetCreatedAt(const Value: TDateTime);
begin
  SetDateTimeField('CreatedAt', Value);
end;

initialization
  RegisterClass(TPayNotes);

end.


