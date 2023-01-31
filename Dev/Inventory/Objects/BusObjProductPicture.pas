unit BusObjProductPicture;
{
  Date     Version  Who  What
  -------- -------- ---  ------------------------------------------------------
  26/05/08  1.00.00  A  Initial Version.
}

{$I ERP.inc}

interface

uses BusObjBase, DB, Classes, XMLDoc, XMLIntf, DBTables, BusObjDeletedItem, BusObjPicture;

type

  TProductPicture = class(TbusobjPicture)
  private
    function GetProductID: Integer;
    procedure SetProductID(const Value: Integer);
    function getisDefault: Boolean;
    procedure setISdefault(const Value: Boolean);
    function GetProductName: string;
    procedure SetProductName(const Value: string);
    function GetImageIndex: integer;
    function GetImageName: string;
    function GetImageTypes: string;
    procedure SetImageIndex(const Value: integer);
    procedure SetImageName(const Value: string);
    procedure SetImageTypes(const Value: string);
    function GetIdForImageName: integer;
    procedure SetIdForImageName(const Value: integer);
    procedure CheckImageName;
  protected
    procedure OnDataIdChange(const ChangeType: TBusObjDataChangeType); override;
    procedure DoFieldOnChange(Sender: TField); override;
    function GetSQL: string; override;
    function DoAfterPost(Sender: TDatasetBusObj): Boolean; override;
    function DoBeforePost(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterInsert(Sender: TDatasetBusObj): Boolean; override;
    function DoAfterDelete(Sender: TDatasetBusObj) : boolean; override;
    function GetId: Integer; override;
    function GetMIMEEncodedPicture: string; virtual;
    procedure SetMIMEEncodedPicture(const Value: string); virtual;
    function GetIsList: boolean; override;
    function Picturefieldname:String;Override;
    function Picturetypefieldname:String;Override;
    property IdForImageName: integer read GetIdForImageName write SetIdForImageName;
  public
    class function GetIDField: string; override;
    class function GetBusObjectTablename: string; override;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure LoadFromXMLNode(const node: IXMLNode); override;
    procedure SaveToXMLNode(const node: IXMLNode); override;
    function ValidateData: Boolean; override;
    function Save: Boolean; override;
    procedure Load(const fIsReadonly: Boolean = False); override;
    class function _Schema: string; override;
  published
    property ProductID: Integer read GetProductID write SetProductID;
    property ProductName: string read GetProductName write SetProductName;
    property IsDefault: Boolean read getisDefault write setISdefault;
    property ImageName: string read GetImageName write SetImageName;
    property ImageTypes: string read GetImageTypes write SetImageTypes;
    property ImageIndex: integer read GetImageIndex write SetImageIndex;

    property MIMEEncodedPicture: string read GetMIMEEncodedPicture write SetMIMEEncodedPicture;
  end;


  TProductJPGPicture = class(TProductPicture)
  protected
    function GetMIMEEncodedPicture: string; override;
    procedure SetMIMEEncodedPicture(const Value: string); override;
  public
  end;

  TProductPictureList = class(TProductPicture)
  protected
    property MIMEEncodedPicture: string read GetMIMEEncodedPicture write SetMIMEEncodedPicture;
  public
    constructor Create(AOwner: TComponent); override;
  end;

//  TDelectedProductPicture = class(TDeletedItem)
//  public
//    class function GetDeletedTablename: string; override;
//  end;

implementation

uses
  jpeg,Graphics, idCoderMIME, SysUtils, BusObjStock, BusObjSchemaLib,
  BusObjUtils, ErpDbComponents, DbSharedObjectsObj, SystemLib;


{ TProductPicture }

procedure TProductPicture.CheckImageName;
var
  qry: TERPQuery;
begin
  if ID = 0 then begin
    if Dataset.State = dsInsert then begin
      self.PostDb;
      self.EditDB;
    end;
  end;
  if Id = 0 then
    exit;
  if Pictype = '' then exit;

  if (ImageName = '') then
    ImageName := StringReplace(StrToValidFileName(ProductName),' ','-',[rfReplaceAll]) + '.' + self.Pictype;
  //self.PostDb;
  qry := DbSharedObj.GetQuery(self.Connection.Connection);
  try
    qry.SQL.Add('select * from tblpartspics');
    qry.SQL.Add('where partID = ' + IntToStr(self.ProductID));
    qry.SQL.Add('and partpicID <> ' + IntToStr(self.ID));
    qry.SQL.Add('and ImageName = ' + QuotedStr(ImageName));
    qry.Open;
    if not qry.IsEmpty then begin
      { append id to make name unique }
      IdForImageName := Id;
    end;
  finally
    DbSharedObj.ReleaseObj(qry);
  end;
end;

constructor TProductPicture.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fBusObjectTypeDescription := 'ProductPicture';
  fSQL := 'SELECT * FROM tblpartspics';
  ExportExcludeList.Add('productid');
  if Assigned(Owner) and (Owner is TProduct) then
    ExportExcludeList.Add('productname');
end;

destructor TProductPicture.Destroy;
begin
  inherited;
end;

procedure TProductPicture.LoadFromXMLNode(const node: IXMLNode);
begin
  inherited;
  SetPropertyFromNode(node, 'ProductID');
  SetBooleanPropertyFromNode(node, 'IsDefault');
  SetPropertyFromNode(node, 'Pictype');
end;

procedure TProductPicture.SaveToXMLNode(const node: IXMLNode);
begin
  inherited;
  AddXMLNode(node, 'ProductID', ProductID);
  AddXMLNode(node, 'IsDefault', IsDefault);
  AddXMLNode(node, 'Pictype', Pictype);
end;

procedure TProductPicture.SetIdForImageName(const Value: integer);
var
  img: string;
  x: integer;
begin
  x := Length(ImageName);
  img := ChangeFileExt(ImageName,'');
  while x > 0 do begin
    if not CharInSet(img[x],['0'..'9']) then
      break;
    Dec(x);
  end;
//  ImageName := Copy(ImageName,1,x) + '_' + IntToStr(Value) + ExtractFileExt(ImageName);
  ImageName := img + '_' + IntToStr(Value) + ExtractFileExt(ImageName);
end;

procedure TProductPicture.SetImageIndex(const Value: integer);
begin
  SetIntegerField('ImageIndex', Value);
end;

procedure TProductPicture.SetImageName(const Value: string);
begin
  SetStringField('ImageName', Value);
end;

procedure TProductPicture.SetImageTypes(const Value: string);
begin
  SetStringField('ImageTypes', Value);
end;

function TProductPicture.ValidateData: Boolean;
begin
  Result := False;
  Resultstatus.Clear;
  if ProductID = 0 then begin
    AddResult(False, rssError, 0, 'ProductID should not be 0', False);
    Exit;
  end;
  Result := True;
end;

class function TProductPicture._Schema: string;
begin
  result:= inherited;
  TBOSchema.AddRefType(result,'TProductWeb','ProductObj','ProductName','ProductName');

end;

function TProductPicture.Save: Boolean;
begin
  Result := False;
  if not ValidateData then Exit;
  Result := inherited Save;
end;

procedure TProductPicture.OnDataIdChange(const ChangeType: TBusObjDataChangeType);
begin
  inherited;
end;

function TProductPicture.Picturefieldname: String;
begin
    result := 'partPic';
end;

function TProductPicture.Picturetypefieldname: String;
begin
  result := 'Pictype';
end;

procedure TProductPicture.DoFieldOnChange(Sender: TField);
begin
  inherited;
  if SameText(Sender.FieldName, 'ImageName') then begin
    self.CheckImageName;
  end;
end;

function TProductPicture.GetSQL: string;
begin
  Result := inherited GetSQL;
end;

class function TProductPicture.GetIDField: string;
begin
  Result := 'partpicID'
end;

function TProductPicture.GetIdForImageName: integer;
var
  x: integer;
  s, img: string;
begin
  result := 0;
  if ImageName = '' then exit;
  s := '';
  img := ChangeFileExt(ImageName,'');
  x := Length(img);
  while x > 0 do begin
    if CharInSet(img[x], ['0'..'9']) then
      s := img[x] + s
    else
      break;
    Dec(x);
  end;
  result := StrToIntDef(s,0);
end;

function TProductPicture.GetImageIndex: integer;
begin
  result :=  GetIntegerField('ImageIndex');
end;

function TProductPicture.GetImageName: string;
begin
  result :=  GetStringField('ImageName');
end;

function TProductPicture.GetImageTypes: string;
begin
  result :=  GetStringField('ImageTypes');
end;

class function TProductPicture.GetBusObjectTablename: string;
begin
  Result := 'tblpartspics';
end;

function TProductPicture.DoAfterPost(Sender: TDatasetBusObj): Boolean;
begin
  Result := inherited DoAfterPost(Sender);
  CheckImageName;
end;

{ Property Functions }
function TProductPicture.GetProductID: Integer;
begin
  Result := GetIntegerField('partID');
end;

function TProductPicture.GetProductName: string;
begin
  result:= TProduct.IDToggle(ProductID, Connection.Connection);
end;

procedure TProductPicture.SetProductID(const Value: Integer);
begin
  SetIntegerField('partID', Value);
end;

procedure TProductPicture.SetProductName(const Value: string);
begin
  ProductID:= TProduct.IDToggle(Value, Connection.Connection);
end;

function TProductPicture.GetId: Integer;
begin
  Result := GetIntegerField('partpicID');
end;


procedure TProductPicture.Load(const fIsReadonly: Boolean = False);
begin
  inherited;
  FreeAndNil(fPictureStream);
end;

function TProductPicture.DoAfterDelete(Sender: TDatasetBusObj): boolean;
begin
  Result := true;
  try
    RefreshDb;
  except
    Result := false;
  end;
end;

function TProductPicture.DoAfterInsert(Sender: TDatasetBusObj): Boolean;
begin
  Result := True;
  if IsOwnerProduct(Self) then ProductID := TProduct(Self.Owner).ID;
end;

function TProductPicture.DoBeforePost(Sender: TDatasetBusObj): Boolean;
var
  strSQL: string;
begin
  Result := inherited DoBeforePost(Sender);
  if not Result then Exit;
  if IsDefault then begin
    strSQL := ' select * from tblpartspics where partId = ' + intToStr(ProductID) + ' and IsDefault ="T" and `partpicID` <> ' + intToStr(ID);
    with getNewDataset(strSQL, True) do
      try
        if recordcount <> 0 then IsDefault := False;
      finally
        if Active then close;
        Free;
      end;
  end else begin
    strSQL := ' select * from tblpartspics where partId = ' + intToStr(ProductID) + ' and IsDefault ="T" and `partpicID` <> ' + intToStr(ID);
    with getNewDataset(strSQL, True) do
      try
        if recordcount = 0 then IsDefault := True;
      finally
        if Active then close;
        Free;
      end;
  end;
  self.CheckImageName;
end;

function TProductPicture.getisDefault: Boolean;
begin
  Result := GetBooleanField('IsDefault')
end;

procedure TProductPicture.setISdefault(const Value: Boolean);
begin
  SetBooleanField('IsDefault', Value);
end;

function TProductPicture.GetIsList: boolean;
begin
  if Assigned(owner) and (owner is TProduct) then
    result:= true
  else
    result:= false;
end;

function TProductPicture.GetMIMEEncodedPicture: string;
var
  MIMEEncoder: TIdEncoderMIME;
begin
  MIMEEncoder := TIdEncoderMIME.Create(nil);
  try Result := MIMEEncoder.Encode(PictureStream);

  finally MIMEEncoder.Free;
  end;
end;

procedure TProductPicture.SetMIMEEncodedPicture(const Value: string);
var
  DecoderMIME: TIdDecoderMIME;
begin
  DecoderMIME := TIdDecoderMIME.Create(nil);
  try
    FreeAndNil(fPictureStream);
    if not(Dataset.State in [dsEdit, dsInsert]) then Dataset.Edit;
    DecoderMIME.DecodeBegin(PictureStream);
    try DecoderMIME.Decode(Value);
    finally DecoderMIME.DecodeEnd;
    end;
  finally DecoderMIME.Free;
  end;
end;


{ TProductJPGPicture }

function TProductJPGPicture.GetMIMEEncodedPicture: string;
var
  MIMEEncoder: TIdEncoderMIME;
  Bitmap: TBitmap;
  JpegImg: TJpegImage;
  stream: TMemoryStream;
begin
  MIMEEncoder := TIdEncoderMIME.Create(nil);
  Bitmap := TBitmap.Create;
  JpegImg := TJpegImage.Create;
  stream := TMemoryStream.Create;
  try
    Bitmap.LoadFromStream(PictureStream);
    JpegImg.Assign(Bitmap);
    JpegImg.SaveToStream(stream);
    stream.Position := 0;
    Result := MIMEEncoder.Encode(stream);
  finally
    Bitmap.Free;
    JpegImg.Free;
    MIMEEncoder.Free;
    stream.Free;
  end;
end;

procedure TProductJPGPicture.SetMIMEEncodedPicture(const Value: string);
var
  MIMEDecoder: TIdDecoderMIME;
  Bitmap: TBitmap;
  JpegImg: TJpegImage;
  stream: TMemoryStream;
begin
  MIMEDecoder := TIdDecoderMIME.Create(nil);
  Bitmap := TBitmap.Create;
  JpegImg := TJpegImage.Create;
  stream := TMemoryStream.Create;
  try
    FreeAndNil(fPictureStream);
    if not(Dataset.State in [dsEdit, dsInsert]) then Dataset.Edit;
    MIMEDecoder.DecodeBegin(stream);
    try MIMEDecoder.Decode(Value);
    finally MIMEDecoder.DecodeEnd;
    end;
    stream.Position := 0;
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

//{ TDelectedProductPicture }
//
//class function TDelectedProductPicture.GetDeletedTablename: string;
//begin
//  result := 'tblpartspics';
//end;


{ TProductPictureList }

constructor TProductPictureList.Create(AOwner: TComponent);
begin
  inherited;
  { return everything except the blob field .. }
  fSQL := 'SELECT GlobalRef, PartPicID, PartID, PicType, ImageName, ImageTypes, ' +
    ' SortOrder, msTimeStamp, IsDefault, msUpdateSiteCode ' +
    ' FROM tblpartspics';
end;

initialization

RegisterClass(TProductPicture);
RegisterClass(TProductJPGPicture);
RegisterClass(TProductPictureList);
//RegisterClass(TDelectedProductPicture);

end.
