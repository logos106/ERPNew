unit BusObjProductGroup;
  {
   Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  16/05/11  1.00.00  A.  Initial Version.
  }


interface


uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, MyAccess;


type
  TProductGroup = class(TMSBusObj)
  private
    fPictureStream: TStream;
    function GetGroupName         : string    ;
    function GetDescription       : string    ;
    procedure SetGroupName         (const Value: string    );
    procedure SetDescription       (const Value: string    );
    function GetPictureStream: TStream;
    function GetParentGroupName: string;
    procedure SetParentGroupName(const Value: string);
    function GetParentProductGroup: TProductGroup;
    function GetActive: boolean;
    procedure SetActive(const Value: boolean);
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType);  override;
    procedure DoFieldOnChange(Sender: TField);                          override;
    function  GetSQL                             : string;              override;
    function  DoAfterPost(Sender:TDatasetBusObj) : Boolean;             override;
    function GetMIMEEncodedPicture: string; virtual;
    procedure SetMIMEEncodedPicture(const Value: string); virtual;
  public
    class function  GetIDField                   : string;              override;
    class function GetKeyStringField: string; override;
    class function  GetBusObjectTablename        : string;              override;
    class function ParentGroupForGroup(const aGroupName: string; Connection: TMyConnection): string;
    constructor  Create(AOwner: TComponent);                            override;
    destructor   Destroy;                                               override;
    procedure    LoadFromXMLNode(const node: IXMLNode);                 override;
    procedure    SaveToXMLNode(const node: IXMLNode);                   override;
    function     ValidateData: Boolean ;                                override;
    function     Save: Boolean ;                                        override;
    property PictureStream: TStream read GetPictureStream;
    property ParentProductGroup: TProductGroup read GetParentProductGroup;
  published
    property GroupName: string read GetGroupName write SetGroupName;
    property ParentGroupName: string read GetParentGroupName write SetParentGroupName;
    property Description: string read GetDescription write SetDescription;
    property MIMEEncodedPicture: string read GetMIMEEncodedPicture write SetMIMEEncodedPicture;
    property Active: boolean read GetActive write SetActive;
  end;

  TProductJPGGroup = class(TProductGroup)
  protected
    function GetMIMEEncodedPicture: string; override;
    procedure SetMIMEEncodedPicture(const Value: string); override;
  end;

implementation


uses
  tcDataUtils, CommonLib, sysutils, idCoderMIME, Graphics, jpeg,
  ERPDbComponents, CommonDbLib;


  {TProductGroup}

constructor TProductGroup.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription:= 'ProductGroup';
  fSQL := 'SELECT * FROM tblproductgroup';
end;


destructor TProductGroup.Destroy;
begin
  FreeAndNil(fPictureStream);
  inherited;
end;


procedure TProductGroup.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node,'GroupName');
  SetPropertyFromNode(node,'ParentGroupName');
  SetPropertyFromNode(node,'Description');
  SetBooleanPropertyFromNode(node,'Active');
end;


procedure TProductGroup.SaveToXMLNode(Const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node,'GroupName' ,GroupName);
  AddXMLNode(node,'ParentGroupName' ,GroupName);
  AddXMLNode(node,'Description' ,Description);
  AddXMLNode(node,'Active', Active);
end;


function TProductGroup.ValidateData: Boolean ;
  function FindParent(aName: string): boolean;
  begin
    With getNewdataset('select ParentGroupName from tblproductgroup where GroupName = ' +quotedstr(aName) , true) do try
      result := (Sametext(fieldbyname('ParentGroupName').asString , aName)) or (Sametext(fieldbyname('ParentGroupName').asString , GroupName));
      if (not (result)) and (fieldbyname('ParentGroupName').asString <> '') then
        result := FindParent(fieldbyname('ParentGroupName').asString);
    finally
      if active then close;
      free;
    end;
  end;
begin
  Result := False;
  Resultstatus.Clear;
  if Trim(GroupName) = '' then begin
    self.AddResult(false,rssWarning,0,'Group Name is blank');
    exit;
  end
  else if Lowercase(GroupName) = LowerCase(ParentGroupName) then begin
    self.AddResult(false,rssWarning,0,'Group can not have its self as a Parent Group');
    exit;
  end
  else if (ParentGroupName <> '') and FindParent(GroupName) then begin
    self.AddResult(false,rssWarning,0,'Parent Group has a circular reference back to this Group');
    exit;
  end;
  Result := True;
end;


function TProductGroup.Save: Boolean ;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;


procedure TProductGroup.OnDataIDChange(Const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;


class function TProductGroup.ParentGroupForGroup(const aGroupName: string;
  Connection: TMyConnection): string;
var
  qry: TERPQuery;
begin
  qry:= TERPQuery.Create(nil);
  try
    if Assigned(Connection) then
      qry.Connection:= Connection
    else
      qry.Connection:= CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Add('select ParentGroupName from tblProductGroup');
    qry.SQL.Add('where GroupName = ' + QuotedStr(aGroupName));
    qry.Open;
    result:= qry.FieldByName('ParentGroupName').AsString;
  finally
    qry.Free;
  end;
end;

procedure TProductGroup.DoFieldOnChange(Sender: TField);
begin
  inherited;
end;


function TProductGroup.GetSQL: string;
begin
  Result := inherited GetSQL;
end;


class function TProductGroup.GetIDField: string;
begin
  Result := 'ProductGroupID'
end;


class function TProductGroup.GetKeyStringField: string;
begin
  result:= 'GroupName';
end;

function TProductGroup.GetMIMEEncodedPicture: string;
var
  MIMEEncoder: TIdEncoderMIME;
begin
  MIMEEncoder:= TIdEncoderMIME.Create(nil);
  try
    result:= MIMEEncoder.Encode(PictureStream);
  finally
    MIMEEncoder.Free;
  end;
end;

function TProductGroup.GetParentGroupName: string;
begin
  Result := GetStringField('ParentGroupName');
end;

function TProductGroup.GetParentProductGroup: TProductGroup;
begin
  // be carefull when u use this property when the object gets its dataset from form in busobjevent as the type is the same
  result := TProductGroup(GetContainerComponent(TProductGroup, 'GroupName = "' + ParentGroupName + '"', true, False,true,'',true));
end;

function TProductGroup.GetPictureStream: TStream;
var
  fld: TField;
begin
  result:= nil;
  if Assigned(Dataset) and Dataset.Active then begin
    if not Assigned(fPictureStream) then begin
      fld:= Dataset.FieldByName('Picture');
      if (Dataset.State in [dsEdit, dsInsert]) then
        fPictureStream:= Dataset.CreateBlobStream(TBlobField(fld), bmReadWrite)
      else
        fPictureStream:= Dataset.CreateBlobStream(TBlobField(fld), bmRead);
    end;
    fPictureStream.Position:= 0;
    result:= fPictureStream;
  end;
end;

function TProductGroup.GetActive: boolean;
begin
  result := GetBooleanField('Active');
end;

class function TProductGroup.GetBusObjectTablename: string;
begin
  Result:= 'tblproductgroup';
end;

function TProductGroup.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
end;

function  TProductGroup.GetGroupName     : string;
begin
  Result := GetStringField('GroupName');
end;

function  TProductGroup.GetDescription   : string;
begin
  Result := GetStringField('Description');
end;

procedure TProductGroup.SetGroupName(const Value: string);
begin
  SetStringField('GroupName', Value);
end;

procedure TProductGroup.SetMIMEEncodedPicture(const Value: string);
var
  DecoderMIME: TIdDecoderMIME;
begin
  DecoderMIME:= TIdDecoderMIME.Create(nil);
  try
    FreeAndNil(fPictureStream);
    if not (Dataset.State in [dsEdit,dsInsert]) then
    Dataset.Edit;
    DecoderMIME.DecodeBegin(PictureStream);
    try
      DecoderMIME.Decode(Value);
    finally
      DecoderMIME.DecodeEnd;
    end;
  finally
    DecoderMIME.Free;
  end;
end;

procedure TProductGroup.SetParentGroupName(const Value: string);
begin
  SetStringField('ParentGroupName', Value);
end;

procedure TProductGroup.SetActive(const Value: boolean);
begin
  SetBooleanField('Active', Value);
end;

procedure TProductGroup.SetDescription(const Value: string);
begin
  SetStringField('Description', Value);
end;


{ TProductJPGGroup }

function TProductJPGGroup.GetMIMEEncodedPicture: string;
var
  MIMEEncoder: TIdEncoderMIME;
  Bitmap: TBitmap;
  JpegImg: TJpegImage;
  stream: TMemoryStream;
begin
  MIMEEncoder:= TIdEncoderMIME.Create(nil);
  Bitmap:= TBitmap.Create;
  JpegImg:= TJpegImage.Create;
  stream:= TMemoryStream.Create;
  try
    Bitmap.LoadFromStream(PictureStream);
    JpegImg.Assign(Bitmap);
    JpegImg.SaveToStream(stream);
    stream.Position:= 0;
    result:= MIMEEncoder.Encode(stream);
  finally
    Bitmap.Free;
    JpegImg.Free;
    MIMEEncoder.Free;
    stream.Free;
  end;
end;

procedure TProductJPGGroup.SetMIMEEncodedPicture(const Value: string);
var
  MIMEDecoder: TIdDecoderMIME;
  Bitmap: TBitmap;
  JpegImg: TJpegImage;
  stream: TMemoryStream;
begin
  MIMEDecoder:= TIdDecoderMIME.Create(nil);
  Bitmap:= TBitmap.Create;
  JpegImg:= TJpegImage.Create;
  stream:= TMemoryStream.Create;
  try
    FreeAndNil(fPictureStream);
    if not (Dataset.State in [dsEdit,dsInsert]) then
    Dataset.Edit;
    MIMEDecoder.DecodeBegin(stream);
    try
      MIMEDecoder.Decode(Value);
    finally
      MIMEDecoder.DecodeEnd;
    end;
    stream.Position:= 0;
    JpegImg.LoadFromStream(stream);
    Bitmap.Assign(JpegImg);
    Bitmap.SaveToStream(PictureStream);
  finally
    Bitmap.Free;
    JpegImg.Free;
    MIMEDecoder.Free;
    stream.Free;
  end;
end;

initialization
  RegisterClass(TProductGroup);
  RegisterClass(TProductJPGGroup);


end.
