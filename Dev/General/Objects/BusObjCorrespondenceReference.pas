unit BusObjCorrespondenceReference;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  27/05/13  1.00.00  A.  Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, MyAccess;

type

  TCorrespondenceReference = class(TMSBusObj)
  private
    function GetTypeCode: string;
    function GetReference: string;
    function GetActive: Boolean;
    procedure SetTypeCode(const Value: string);
    procedure SetReference(const Value: string);
    procedure SetActive(const Value: Boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    Function  DoAfterInsert(Sender :TDatasetBusObj ):Boolean; override;
    procedure InitializeNewObject; override;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetKeyStringField: string; override;
    class function GetKeyStringProperty: string; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    class function CreateNew(aTypeCode, aReference: string; var msg: string; aConnection: TCustomMyConnection = nil): boolean;
  published
    property TypeCode: string read GetTypeCode write SetTypeCode;
    property Reference: string read GetReference write SetReference;
    property Active: Boolean read GetActive write SetActive;
  end;

  TEmailCorrespondenceReference = class(TCorrespondenceReference)
  private
  protected
    procedure InitializeNewObject; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function IDToggle(const ID: Integer; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): string; overload; override;
    class function IDToggle(const KeyString: string; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): Integer; overload; override;
  published
  end;

  TLetterCorrespondenceReference = class(TCorrespondenceReference)
  private
  protected
    procedure InitializeNewObject; override;
  public
    constructor Create(AOwner: TComponent); override;
    class function IDToggle(const ID: Integer; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): string; overload; override;
    class function IDToggle(const KeyString: string; Connection: TCustomMyConnection = nil; const AndSQL: string = ''): Integer; overload; override;
  published
  end;

implementation

uses tcDataUtils, CommonLib, SysUtils, CommonDbLib;

{ TCorrespondenceReference }

constructor TCorrespondenceReference.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'CorrespondenceReference';
  fSQL := 'SELECT * FROM tblcorrespondencereference';
end;

class function TCorrespondenceReference.CreateNew(aTypeCode, aReference: string;
  var msg: string; aConnection: TCustomMyConnection): boolean;
var
  CR: TCorrespondenceReference;
begin
  result:= true;
  CR := TCorrespondenceReference.Create(nil);
  try
    CR.Connection := TMyDacDataConnection.Create(CR);
    if Assigned(aConnection) then
      CR.Connection.Connection := aConnection
    else
      CR.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;

    CR.Connection.BeginNestedTransaction;
    CR.New;
    CR.TypeCode := aTypeCode;
    CR.Reference := aReference;
    if CR.Save then begin
      CR.Connection.CommitNestedTransaction;
    end
    else begin
      result:= false;
      msg:= CR.ResultStatus.Messages;
      CR.Connection.RollbackNestedTransaction;
    end;
  finally
    CR.Free;
  end;
end;

destructor TCorrespondenceReference.Destroy;
begin
  inherited;
end;

procedure TCorrespondenceReference.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'TypeCode');
  SetPropertyFromNode(node, 'Reference');
  SetBooleanPropertyFromNode(node, 'Active');
end;

procedure TCorrespondenceReference.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'TypeCode', TypeCode);
  AddXMLNode(node, 'Reference', Reference);
  AddXMLNode(node, 'Active', Active);
end;

function TCorrespondenceReference.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  try
    self.PostDb;
  except
    on e: exception do begin
      if (Pos('Duplicate entry',e.Message) > 0) and (Pos('RefIdx',e.Message) > 0) then begin
        AddResult(false,rssWarning,0,'This Reference already exists');
        exit;
      end
      else
        raise;
    end;
  end;
  if Trim(Reference) = '' then begin
    AddResult(false,rssWarning,0,'Reference is blank');
    exit;
  end;
  Result := True;
end;

function TCorrespondenceReference.Save: Boolean;
begin
  Result := False;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;

procedure TCorrespondenceReference.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TCorrespondenceReference.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TCorrespondenceReference.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TCorrespondenceReference.GetIDField: string;
begin
  Result := 'Id'
end;

class function TCorrespondenceReference.GetKeyStringField: string;
begin
  result := 'Reference';
end;

class function TCorrespondenceReference.GetKeyStringProperty: string;
begin
  result := 'Reference';
end;

class function TCorrespondenceReference.GetBusObjectTablename: string;
begin
  Result := 'tblcorrespondencereference';
end;

function TCorrespondenceReference.DoAfterInsert(
  Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  InitializeNewObject;
end;

function TCorrespondenceReference.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TCorrespondenceReference.GetTypeCode: string;
begin
  Result := GetStringField('TypeCode');
end;

procedure TCorrespondenceReference.InitializeNewObject;
begin
  inherited;
  Active := true;
end;

function TCorrespondenceReference.GetReference: string;
begin
  Result := GetStringField('Reference');
end;

function TCorrespondenceReference.GetActive: Boolean;
begin
  Result := GetBooleanField('Active');
end;

procedure TCorrespondenceReference.SetTypeCode(const Value: string);
begin
  SetStringField('TypeCode', Value);
end;

procedure TCorrespondenceReference.SetReference(const Value: string);
begin
  SetStringField('Reference', Value);
end;

procedure TCorrespondenceReference.SetActive(const Value: Boolean);
begin
  SetBooleanField('Active', Value);
end;

{ TEmailCorrespondenceReference }

constructor TEmailCorrespondenceReference.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM ' + GetBusObjectTablename + ' WHERE TypeCode = "Email"';
end;

class function TEmailCorrespondenceReference.IDToggle(const ID: Integer;
  Connection: TCustomMyConnection; const AndSQL: string): string;
begin
  result:= inherited IdToggle(ID, Connection, 'TypeCode = "Email"' );
end;

class function TEmailCorrespondenceReference.IDToggle(const KeyString: string;
  Connection: TCustomMyConnection; const AndSQL: string): Integer;
begin
  result:= inherited IdToggle(KeyString, Connection, 'TypeCode = "Email"' );
end;

procedure TEmailCorrespondenceReference.InitializeNewObject;
begin
  inherited;
  if TypeCode = '' then TypeCode:= 'Email';
end;

{ TLetterCorrespondenceReference }

constructor TLetterCorrespondenceReference.Create(AOwner: TComponent);
begin
  inherited;
  fSQL := 'SELECT * FROM ' + GetBusObjectTablename + ' WHERE TypeCode = "Letter"';
end;

class function TLetterCorrespondenceReference.IDToggle(const ID: Integer;
  Connection: TCustomMyConnection; const AndSQL: string): string;
begin
  result:= inherited IdToggle(ID, Connection, 'TypeCode = "Letter"' );
end;

class function TLetterCorrespondenceReference.IDToggle(const KeyString: string;
  Connection: TCustomMyConnection; const AndSQL: string): Integer;
begin
  result:= inherited IdToggle(KeyString, Connection, 'TypeCode = "Letter"' );
end;

procedure TLetterCorrespondenceReference.InitializeNewObject;
begin
  inherited;
  if TypeCode = '' then TypeCode:= 'Letter';
end;

initialization

RegisterClass(TEmailCorrespondenceReference);
RegisterClass(TLetterCorrespondenceReference);

end.
