unit BusObjPicture;

interface

uses ERPdbComponents,  BusObjBase, DB, Classes, XMLDoc, XMLIntf, DBTables, BusObjDeletedItem;

type

  TPictureObjtype = (TpotCustomerEquipment=1 , TpotEquipmentImages=2 , TpotAssetPicture=3 , TpotProductPicture=4, TpotEquipmentPicture=5, TPotCompLogo =6);

  TBusObjPicture = class(TMSBusObj)
  Private
    function getPictype: String;
    procedure setPictype(const Value: String);
    function GetPictureStream: TStream;

  Protected
    fPictureStream: TStream;
    procedure LoadPicturefromStream(stream: TMemoryStream; fsPictype: String);
    function Picturefieldname:String;virtual;abstract;
    function Picturetypefieldname:String;virtual;abstract;
  Public
    destructor Destroy; override;
    property PictureStream: TStream read GetPictureStream;
    Procedure BMPToGIF;
    Procedure BMPToJPG;
    Procedure BMPToPNG;
    Procedure GIFToBMP;
    Procedure GIFToJPG;
    Procedure GIFToPNG;
    Procedure JPGToBMP;
    Procedure JPGToGIF;
    Procedure JPGToPNG;
    Procedure PNGToBMP;
    Procedure PNGToGIF;
    Procedure PNGToJPG;
    class function PictureObjInstance(PictureObjtype:TPictureObjtype; PictureObjID:Integer;AOwner:TComponent; Conn :TMyDacDataConnection; erpconn : TERPConnection ): TbusobjPicture;
  Published
    Property PicType :String read getPictype write setPictype;
  end;

implementation

uses SysUtils, Graphics, jpeg,GIFimg, pngimage, BusObjClient,BusObjEquipment,BusObjFixedAsset,BusObjProductPicture, CommonDbLib,
  busobjcomplogo;


{TbusobjPicture}
function TbusobjPicture.GetPictureStream: TStream;
var
  fld: TField;
begin
  Result := nil;
  if Assigned(Dataset) and Dataset.Active then begin
    if not Assigned(fPictureStream) then begin
      fld := Dataset.FieldByName('partPic');
      if (Dataset.State in [dsEdit, dsInsert]) then fPictureStream := Dataset.CreateBlobStream(TBlobField(fld), bmReadWrite)
      else fPictureStream := Dataset.CreateBlobStream(TBlobField(fld), bmRead);
    end;
    fPictureStream.Position := 0;
    Result := fPictureStream;
  end;
end;


procedure TbusobjPicture.setPictype(const Value: String);
begin
  SetStringfield(Picturetypefieldname, Value);
end;
function TbusobjPicture.getPictype: String;
begin
  result := getStringfield(Picturetypefieldname);
end;
Procedure TbusobjPicture.LoadPicturefromStream(stream : TMemoryStream; fsPictype :String);
var
    BlobStream: TStream;
begin
    stream.Position := 0;
    editdb;
    BlobStream := Dataset.CreateBlobStream(Dataset.fieldByname(PicturefieldName) , bmWrite);
    BlobStream.CopyFrom(stream,0);
    Pictype := fsPictype;
    PostDB;
end;

Procedure TbusobjPicture.BMPToGIF;var  BMP:TBitmap;  GIF:TGIFImage;  stream : TMemoryStream;begin  BMP:=TBitmap.Create;  GIF:=TGIFImage.Create;  stream := TMemoryStream.Create;  try    bmp.LoadFromStream(PictureStream);    GIF.Assign(bmp);    GIF.SaveToStream(stream);    LoadPictureFromStream(Stream, 'GIF');  finally    Freeandnil(stream);    Freeandnil(BMP);    Freeandnil(GIF);  end;end;
Procedure TbusobjPicture.BMPToJPG;var  BMP:TBitmap;  JPG:TJPEGImage; stream : TMemoryStream;begin  BMP:=TBitmap.Create;  JPG:=TJPEGImage.Create; stream := TMemoryStream.Create;  try    bmp.LoadFromStream(PictureStream);    JPG.Assign(bmp);    JPG.SaveToStream(stream);    LoadPictureFromStream(Stream, 'JPG');  finally    Freeandnil(stream);    Freeandnil(BMP);    Freeandnil(JPG);  end;end;
Procedure TbusobjPicture.BMPToPNG;
var
  BMP:TBitmap;
  PNG:TPngImage;
  stream : TMemoryStream;
begin
  BMP:=TBitmap.Create;
  PNG:=TPngImage.Create;
  stream := TMemoryStream.Create;
  try
    bmp.LoadFromStream(PictureStream);
    PNG.Assign(bmp);
    PNG.SaveToStream(stream);
    LoadPictureFromStream(Stream, 'PNG');
  finally
    Freeandnil(stream);
    Freeandnil(BMP);
    Freeandnil(PNG);
  end;
end;

Procedure TbusobjPicture.GIFToBMP;var  GIF:TGIFImage;  BMP:TBitmap;    stream : TMemoryStream;begin  GIF:=TGIFImage.Create;  BMP:=TBitmap.Create;    stream := TMemoryStream.Create;  try    GIF.LoadFromStream(PictureStream);    BMP.Assign(GIF);    BMP.SaveToStream(stream);    LoadPictureFromStream(Stream, 'BMP');  finally    Freeandnil(stream);    Freeandnil(GIF);    Freeandnil(BMP);  end;end;
Procedure TbusobjPicture.GIFToJPG;var  GIF:TGIFImage;  JPG:TJPEGImage; stream : TMemoryStream;begin  GIF:=TGIFImage.Create;  JPG:=TJPEGImage.Create; stream := TMemoryStream.Create;  try    GIF.LoadFromStream(PictureStream);    JPG.Assign(GIF);    JPG.SaveToStream(stream);    LoadPictureFromStream(Stream, 'JPG');  finally    Freeandnil(stream);    Freeandnil(GIF);    Freeandnil(JPG);  end;end;
Procedure TbusobjPicture.GIFToPNG;var  GIF:TGIFImage;  PNG:TPngImage;  stream : TMemoryStream;begin  GIF:=TGIFImage.Create;  PNG:=TPngImage.Create;  stream := TMemoryStream.Create;  try    GIF.LoadFromStream(PictureStream);    PNG.Assign(GIF);    PNG.SaveToStream(stream);    LoadPictureFromStream(Stream, 'PNG');  finally    Freeandnil(stream);    Freeandnil(GIF);    Freeandnil(PNG);  end;end;

class function TbusobjPicture.PictureObjInstance(PictureObjtype: TPictureObjtype; PictureObjID: Integer;AOwner:TComponent; Conn :TMyDacDataConnection; erpconn : TERPConnection): TbusobjPicture;
begin
  result := nil;
       if PictureObjtype = TpotCustomerEquipment  then REsult := TCustomerEquipment.create(Aowner)
  else if PictureObjtype = TpotEquipmentImages    then REsult := TEquipmentImages.create(Aowner)
  else if PictureObjtype = TpotAssetPicture       then REsult := TAssetPicture.create(Aowner)
  else if PictureObjtype = TpotProductPicture     then REsult := TProductPicture.create(Aowner)
  else if PictureObjtype = TpotEquipmentPicture   then Result := TEquipmentPicture.create(Aowner)
  else if PictureObjtype = TPotCompLogo           then REsult := TCompLogo.create(Aowner)
  else exit;

  if Assigned(Conn) then Result.connection := conn
  else if erpconn = nil then begin
    Result.connection :=  TMyDAcDataconnection.Create(Result);
    Result.connection.Connection := GetNewMyDacConnection(Result);
  end else begin
    Result.connection :=  TMyDAcDataconnection.Create(Result);
    Result.connection.Connection := erpconn;
  end;
  Result.Load(PictureObjID);
end;

Procedure TbusobjPicture.JPGToBMP;var  JPG:TJPEGImage;  BMP:TBitmap;  stream : TMemoryStream;begin  JPG:=TJPEGImage.Create;  BMP:=TBitmap.Create;  stream := TMemoryStream.Create;  try    JPG.LoadFromStream(PictureStream);    BMP.Assign(JPG);    BMP.SaveToStream(stream);    LoadPictureFromStream(Stream, 'BMP');  finally    Freeandnil(stream);    Freeandnil(JPG);    Freeandnil(BMP);  end;end;
Procedure TbusobjPicture.JPGToGIF;var  JPG:TJPEGImage;  GIF:TGIFImage;stream : TMemoryStream;begin  JPG:=TJPEGImage.Create;  GIF:=TGIFImage.Create;stream := TMemoryStream.Create;  try    JPG.LoadFromStream(PictureStream);    GIF.Assign(JPG);    GIF.SaveToStream(stream);    LoadPictureFromStream(Stream, 'GIF');  finally    Freeandnil(stream);    Freeandnil(JPG);    Freeandnil(GIF);  end;end;
Procedure TbusobjPicture.JPGToPNG;var  JPG:TJPEGImage;  PNG:TPngImage;stream : TMemoryStream;begin  JPG:=TJPEGImage.Create;  PNG:=TPngImage.Create;stream := TMemoryStream.Create;  try    JPG.LoadFromStream(PictureStream);    PNG.Assign(JPG);    PNG.SaveToStream(stream);    LoadPictureFromStream(Stream, 'PNG');  finally    Freeandnil(stream);    Freeandnil(JPG);    Freeandnil(PNG);  end;end;

Procedure TbusobjPicture.PNGToBMP;var  PNG:TPNGImage;  BMP:TBitmap;   stream : TMemoryStream;begin  PNG:=TPNGImage.Create;  BMP:=TBitmap.Create;   stream := TMemoryStream.Create;  try    PNG.LoadFromStream(PictureStream);    BMP.Assign(PNG);    BMP.SaveToStream(stream);    LoadPictureFromStream(Stream, 'BMP');  finally    Freeandnil(stream);    Freeandnil(PNG);    Freeandnil(BMP);  end;end;
Procedure TbusobjPicture.PNGToGIF;var  PNG:TPNGImage;  GIF:TGIFImage; stream : TMemoryStream;begin  PNG:=TPNGImage.Create;  GIF:=TGIFImage.Create; stream := TMemoryStream.Create;  try    PNG.LoadFromStream(PictureStream);    GIF.Assign(PNG);    GIF.SaveToStream(stream);    LoadPictureFromStream(Stream, 'GIF');  finally    Freeandnil(stream);    Freeandnil(PNG);    Freeandnil(GIF);  end;end;
Procedure TbusobjPicture.PNGToJPG;var  PNG:TPNGImage;  JPG:TJPEGImage;stream : TMemoryStream;begin  PNG:=TPNGImage.Create;  JPG:=TJPEGImage.Create;stream := TMemoryStream.Create;  try    PNG.LoadFromStream(PictureStream);    JPG.Assign(PNG);    JPG.SaveToStream(stream);    LoadPictureFromStream(Stream, 'JPG');  finally    Freeandnil(stream);    Freeandnil(PNG);    Freeandnil(JPG);  end;end;

destructor TbusobjPicture.Destroy;
begin
  FreeAndNil(fPictureStream);
  inherited;
end;

end.

