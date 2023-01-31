unit BusObjAttachment;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  18/09/12  1.00.00  A.  Initial Version.
}

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, myAccess;

type
  TAttachment = class(TMSBusObj)
  private
    function GetTableId: Integer;
    function GetAttachmentName: string;
    procedure SetTableId(const Value: Integer);
    procedure SetAttachmentName(const Value: string);
    function GetAttachment: string;
    procedure SetAttachment(const Value: string);
    function GetDescription: string;
    procedure SetDescription(const Value: string);
    function GetAttachmentText: string;
    procedure SetAttachmentText(const Value: string);
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function GetIsList: boolean; override;
    function GetTableName: string; virtual;
    procedure SetTableName(const Value: string); virtual;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    procedure SaveToFile(const aFileName: string);
    procedure LoadFromFile(const aFileName: string);
    property AttachmentText: string read GetAttachmentText write SetAttachmentText;
    class procedure Clone(ID: integer; newTableName: string; newTableId: integer; Conn: TCustomMyConnection = nil); overload;
    class procedure Clone(tableName: string; tableId: integer; newTableName: string; newTableId: integer; Conn: TCustomMyConnection = nil); overload;
  published
    property TableName: string read GetTableName write SetTableName;
    property TableId: Integer read GetTableId write SetTableId;
    property AttachmentName: string read GetAttachmentName write SetAttachmentName;
    { returns MIME Encoded attachment text, set as MIME encoded text }
    property Attachment: string read GetAttachment write SetAttachment;
    property Description: string read GetDescription write SetDescription;
    property Active: boolean read GetActive write SetActive;
  end;

implementation

uses
  tcDataUtils, CommonLib, idCoderMIME, SysUtils, CommonDbLib, SystemLib,
  ERPDBComponents, BusObjDeletedItem;

{ TAttachment }

class procedure TAttachment.Clone(ID: integer; newTableName: string;
  newTableId: integer; Conn: TCustomMyConnection = nil);
var
  Att: TAttachment;
  AttName: string;
  fileName: string;
begin
  Att := TAttachment.Create(nil);
  try
    Att.Connection := TMyDacDataConnection.Create(Att);
    if Assigned(Conn) then
      Att.Connection.Connection := Conn
    else
      Att.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
    Att.Load(ID);
    AttName := Att.AttachmentName;
    fileName := SystemLib.GetAppTempDir + '\' + AttName;
    Att.SaveToFile(fileName);
    Att.Load(0);
    Att.New;
    Att.TableName := newTableName;
    Att.TableId := newTableId;
    Att.AttachmentName := AttName;
    Att.LoadFromFile(fileName);
    Att.Save;
  finally
    Att.Free;
  end;
end;

class procedure TAttachment.Clone(tableName: string; tableId: integer;
  newTableName: string; newTableId: integer; Conn: TCustomMyConnection);
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    if Assigned(Conn) then qry.Connection := conn
    else qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select AttachmentId from tblattachments');
    qry.SQL.Add('where TableName = ' + QuotedStr(tableName));
    qry.SQL.Add('and TableId = ' + IntToStr(tableId));
    qry.Open;
    while not qry.Eof do begin
      TAttachment.Clone(qry.FieldByName('AttachmentId').AsInteger,newTableName,newTableId,Conn);
      qry.Next;
    end;
  finally
    qry.Free;
  end;
end;

constructor TAttachment.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'Attachment';
  fSQL := 'SELECT * FROM tblattachments';
end;

destructor TAttachment.Destroy;
begin
  inherited;
end;

procedure TAttachment.LoadFromFile(const aFileName: string);
begin
  TBlobField(Dataset.FieldByName('Attachment')).LoadFromFile(aFileName);
end;

procedure TAttachment.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'TableName');
  SetPropertyFromNode(node, 'TableId');
  SetPropertyFromNode(node, 'AttachmentName');
  SetPropertyFromNode(node, 'Attachment');
  SetPropertyFromNode(node, 'Description');
end;

procedure TAttachment.SaveToFile(const aFileName: string);
begin
  if Count > 0 then
    TBlobField(Dataset.FieldByName('Attachment')).SaveToFile(aFileName);
end;

procedure TAttachment.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'TableName', TableName);
  AddXMLNode(node, 'TableId', TableId);
  AddXMLNode(node, 'AttachmentName', AttachmentName);
  AddXMLNode(node, 'Attachment', Attachment);
  AddXMLNode(node, 'Description', Description);
end;

function TAttachment.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if Trim(TableName) = '' then begin
    AddResult(False, rssError, 0, 'Table Name should not be blank.');
    exit;
  end;
  if TableId = 0 then begin
    AddResult(False, rssError, 0, 'Table ID should not be 0.');
    exit;
  end;
  if Trim(AttachmentName) = '' then begin
    AddResult(False, rssError, 0, 'Attachment Name should not be blank.');
    exit;
  end;
  Result := True;
end;

function TAttachment.Save: Boolean;
var
  msg: string;
begin
  Result := False;
  PostDb;
  if not Active then begin
    if GlobalRef <> '' then begin
      if not  TDeletedItem.AddDeleted('tblAttachments','TAttachment',GlobalRef,ID,Connection.Connection, msg, false) then begin
        result := false;
        AddResult(false,rssWarning,0,msg);
      end;
    end;
    if not self.Delete then begin
      result := false;
      AddResult(false,rssWarning,0,'Could not delete Attachment');
      exit;
    end;
    result := true;
  end;
  if not ValidateData then
    Exit;
  Result := inherited Save;
end;

procedure TAttachment.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

procedure TAttachment.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;

function TAttachment.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TAttachment.GetIDField: string;
begin
  Result := 'AttachmentId'
end;

function TAttachment.GetIsList: boolean;
begin
  result := true;
end;

class function TAttachment.GetBusObjectTablename: string;
begin
  Result := 'tblattachments';
end;

function TAttachment.GetDescription: string;
begin
  result := GetStringField('Description');
end;

function TAttachment.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  result := inherited;
  if Assigned(Owner) and (Owner is TBusObj) then begin
    self.TableName := TBusObj(Owner).BusObjectTableName;
    self.TableId := TBusObj(Owner).ID;
  end;
end;

function TAttachment.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

{ Property Functions }
function TAttachment.GetTableName: string;
begin
  Result := GetStringField('TableName');
end;

function TAttachment.GetTableId: Integer;
begin
  Result := GetIntegerField('TableId');
end;

function TAttachment.GetActive: boolean;
begin
  result := GetBooleanField('Active');
end;

function TAttachment.GetAttachment: string;
var
  MIMEEncoder: TIdEncoderMIME;
  Stream: TStream;
  fld: TField;
begin
  MIMEEncoder := TIdEncoderMIME.Create(nil);
  fld := Dataset.FieldByName('Attachment');
  if (Dataset.State in [dsEdit, dsInsert]) then
    Stream := Dataset.CreateBlobStream(TBlobField(fld), bmReadWrite)
  else
    Stream := Dataset.CreateBlobStream(TBlobField(fld), bmRead);
  try
    Result := MIMEEncoder.Encode(Stream);
  finally
    MIMEEncoder.Free;
    Stream.Free;
  end;
end;

function TAttachment.GetAttachmentName: string;
begin
  Result := GetStringField('AttachmentName');
end;

function TAttachment.GetAttachmentText: string;
begin
  result := GetStringField('Attachment');
end;

procedure TAttachment.SetTableName(const Value: string);
begin
  SetStringField('TableName', Value);
end;

procedure TAttachment.SetTableId(const Value: Integer);
begin
  SetIntegerField('TableId', Value);
end;

procedure TAttachment.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TAttachment.SetAttachment(const Value: string);
var
  DecoderMIME: TIdDecoderMIME;
  Stream: TStream;
  fld: TField;
begin
  DecoderMIME := TIdDecoderMIME.Create(nil);
  try
    if not(Dataset.State in [dsEdit, dsInsert]) then Dataset.Edit;
    fld := Dataset.FieldByName('Attachment');
    Stream := Dataset.CreateBlobStream(TBlobField(fld), bmReadWrite);
    try
      DecoderMIME.DecodeBegin(Stream);
      try
        DecoderMIME.Decode(Value);
      finally
        DecoderMIME.DecodeEnd;
      end;
    finally
      Stream.free;
    end;
  finally
    DecoderMIME.Free;
  end;
end;

procedure TAttachment.SetAttachmentName(const Value: string);
begin
  SetStringField('AttachmentName', Value);
end;

procedure TAttachment.SetAttachmentText(const Value: string);
begin
  SetStringField('Attachment', Value);
end;

procedure TAttachment.SetDescription(const Value: string);
begin
  SetStringField('Description', Value);
end;

initialization

RegisterClass(TAttachment);

end.
