unit EmailHistory;

interface

uses
  SysUtils, BusObjBase, DB, Classes, XMLDoc, XMLIntf, IdCoderMIME;

type
  TEmailHistory = class(TMSBusObj)

  private
    function GetDateSent: TDateTime;
    function GetEmployeeID: Integer;
    function GetEmployeeName: string;
    function GetCLabel: string;
    function GetMemo: string;
    function GetSubject: string;
    function GetRecipientEmail: string;
    function GetTemplateID: Integer;
    function GetActive: Boolean;

    procedure SetDateSent(const Value: TDateTime);
    procedure SetEmployeeID(const Value: Integer);
    procedure SetEmployeeName(const Value: string);
    procedure SetCLabel(const Value: string);
    procedure SetMemo(const Value: string);
    procedure SetSubject(const Value: string);
    procedure SetRecipientEmail(const Value: string);
    procedure SetTemplateID(const Value: Integer);
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
    property DateSent: TDateTime          read GetDateSent          write SetDateSent;
    property EmployeeID: Integer          read GetEmployeeID        write SetEmployeeID;
    property EmployeeName: string         read GetEmployeeName      write SetEmployeeName;
    property ELabel: string               read GetCLabel            write SetCLabel;
    property Memo: string                 read GetMemo              write SetMemo;
    property Subject: string              read GetSubject           write SetSubject;
    property RecipientEmail: string       read GetRecipientEmail    write SetRecipientEmail;
    property TemplateID: Integer          read GetTemplateID        write SetTemplateID;
    property Active: Boolean              read GetActive            write SetActive;

  end;

implementation

uses
  tcDataUtils, CommonLib;

{ TPayNotes }

constructor TEmailHistory.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBusObjectTypeDescription:= 'EmailHistory';
  FSQL:= 'SELECT * FROM tblEmailHistory';
end;

destructor TEmailHistory.Destroy;
begin
  inherited;
end;

procedure TEmailHistory.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;

  SetPropertyFromNode(node, 'DateSent');
  SetPropertyFromNode(node, 'EmployeeID');
  SetPropertyFromNode(node, 'EmployeeName');
  SetPropertyFromNode(node, 'ELabel');
  SetPropertyFromNode(node, 'Memo');
  SetPropertyFromNode(node, 'Subject');
  SetPropertyFromNode(node, 'RecipientEmail');
  SetPropertyFromNode(node, 'TemplateID');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure TEmailHistory.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;

  AddXMLNode(node, 'DateSent', DateSent);
  AddXMLNode(node, 'EmployeeID', EmployeeID);
  AddXMLNode(node, 'EmployeeName', EmployeeName);
  AddXMLNode(node, 'ELabel', ELabel);
  AddXMLNode(node, 'Memo', Memo);
  AddXMLNode(node, 'Subject', Subject);
  AddXMLNode(node, 'RecipientEmail', RecipientEmail);
  AddXMLNode(node, 'TemplateID', TemplateID);
  AddXMLNode(node, 'Active', Active);
end;

function TEmailHistory.ValidateData: Boolean;
begin
  Result:= False;
  Resultstatus.Clear;
  Result:= True;
end;

function TEmailHistory.Save: Boolean;
begin
  Result:= False;
  if not ValidateData then
    Exit;

  Result:= inherited Save;
end;

procedure TEmailHistory.OnDataIdChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TEmailHistory.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TEmailHistory.GetSQL: String;
begin
  Result:= inherited GetSQL;
end;

class function TEmailHistory.GetIDField: String;
begin
  Result:= 'ID';
end;

class function TEmailHistory.GetBusObjectTablename: String;
begin
  Result:= 'tblEmailHistory';
end;

function TEmailHistory.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result:= inherited DoAfterPost(Sender);
end;

function TEmailHistory.GetDateSent: TDateTime;                  begin Result := GetDateTimeField('DateSent');end;
function TEmailHistory.GetEmployeeID: Integer;                  begin Result := GetIntegerField('EmployeeID');end;
function TEmailHistory.GetEmployeeName: string;                 begin Result := GetStringField('EmployeeName');end;
function TEmailHistory.GetCLabel: string;                       begin Result := GetStringField('CLabel');end;
function TEmailHistory.GetMemo: string;                         begin Result := GetStringField('Memo');end;
function TEmailHistory.GetSubject: string;                      begin Result := GetStringField('Subject');end;
function TEmailHistory.GetRecipientEmail: string;               begin Result := GetStringField('RecipientEmail');end;
function TEmailHistory.GetTemplateID: Integer;                  begin Result := GetIntegerField('TemplateID');end;
function TEmailHistory.GetActive: Boolean;                      begin Result := GetBooleanField('Active');end;

procedure TEmailHistory.SetDateSent(const Value: TDateTime);    begin SetDateTimeField('DateSent', Value);end;
procedure TEmailHistory.SetEmployeeID(const Value: Integer);    begin SetIntegerField('EmployeeID', Value);end;
procedure TEmailHistory.SetEmployeeName(const Value: string);   begin SetStringField('EmployeeName', Value);end;
procedure TEmailHistory.SetCLabel(const Value: string);         begin SetStringField('CLabel', Value);end;
procedure TEmailHistory.SetMemo(const Value: string);           begin SetStringField('Memo', Value);end;
procedure TEmailHistory.SetSubject(const Value: string);        begin SetStringField('Subject', Value);end;
procedure TEmailHistory.SetRecipientEmail(const Value: string); begin SetStringField('RecipientEmail', Value); end;
procedure TEmailHistory.SetTemplateID(const Value: Integer);    begin SetIntegerField('TemplateID', Value);end;
procedure TEmailHistory.SetActive(const Value: Boolean);        begin SetBooleanField('Active', Value);end;

initialization
  RegisterClass(TEmailHistory);

end.


