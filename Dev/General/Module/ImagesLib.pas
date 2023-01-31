unit ImagesLib;

interface

uses
  JPEG, Classes, Db, ExtCtrls, DNMPanel , BusObjPicture, ERPdbComponents,
  BusObjBase , ImageScroll;

procedure SelectPicture(PictureObjtype: TPictureObjtype; AOwner: TComponent;
  ds: TERPQuery; IDFieldname, FieldName: String; AddNew: boolean;
  PictypefieldName: String; AllowMultiselect: Boolean = false;
  BusObj: TMSBusObj = nil);
function JpegToDBField(Jpg  : TJpegImage;ds: TDataset; FieldName: String;AddNew: boolean):boolean;
function DBFieldtoJPEg(var JpgStream: TMemoryStream;ds: TDataset; FieldName: String):boolean;
procedure RefreshDsImage(DataSet: TDataSet; Picturefieldname, Picturetypefieldname :String; Img :TImage; pnlImage , pnlPicturetype :TDNMPanel);
procedure BMPToJPG(ds:TDataset; FieldName, PictypefieldName:String);
Function ImageScrollHeightFactor(aImageScroll :TImageScroll):Double;

implementation

uses Graphics, Dialogs, CommonLib, sysutils, CommonDbLib, tcConst, GIFimg , pngimage, LanguageTranslationObj, AppEnvironment;
Function ImageScrollHeightFactor(aImageScroll :TImageScroll):Double;
begin
  REsult := aImageScroll.HeightFactor;
  if result <=0 then
    result := 1;
end;
function DBFieldtoJPEg(var JpgStream: TMemoryStream;ds: TDataset; FieldName: String):boolean;
begin
  REsult:= False;
  if (ds = nil) or (ds.Active = False) or (fieldname = '') then exit;
  TBlobField(ds.fieldByname(FieldName)).SaveToStream(JpgStream);
  Result:= true;
end;
function JpegToDBField(Jpg  : TJpegImage;ds: TDataset; FieldName: String;AddNew: boolean):boolean;
var
  JpgStream: TMemoryStream;
begin
  REsult:= False;
  if (ds = nil) or (ds.Active = False) or (fieldname = '') then exit;
  JpgStream := TMemoryStream.Create;
  try
    try
      Jpg.SaveToStream(JpgStream);
      if (AddNew or (ds.recordcount = 0)) and (ds.State <> dsInsert) then ds.Append else editDB(ds);
      JpgStream.Position := 0;
      TBlobField(ds.fieldByname(FieldName)).LoadFromStream(JpgStream);
      Result:= true;
    Except
      on E:Exception do begin
        MessageDlgXP_Vista('Saving Failed ' + NL + e.Message, mtWarning, [mbOK], 0);
        Exit;
      end;
    end;
  finally
    Freeandnil(JpgStream);
  end;
end;

procedure SelectPicture(PictureObjtype: TPictureObjtype; AOwner: TComponent;
  ds: TERPQuery; IDFieldname, FieldName: String; AddNew: boolean;
  PictypefieldName: String; AllowMultiselect: Boolean = false;
  BusObj: TMSBusObj = nil);
var
  OpenDialog :TOpenDialog;
  BlobStream: TStream;
  fileStream :TFileStream;
  ctr:Integer;
  fid:Integer;

  procedure DsAppend;
  begin
    if Assigned(BusObj) then BusObj.New
    else ds.Append;
  end;

  procedure DsPost;
  begin
    if Assigned(BusObj) then BusObj.PostDb
    else PostDb(ds);
  end;

  procedure DsEdit;
  begin
    if Assigned(BusObj) then
    else EditDb(ds);
  end;

begin
  try
    OpenDialog := TOpenDialog.Create(AOwner);
      try
          OpenDialog.Filter := 'JPG (*.jpg)|*.jpg'+
                               '|Bitmap (*.bmp)|*.bmp'+
                               '|Gif (*.Gif)|*.Gif'+
                               '|Png (*.Png)|*.Png';

        try
            if AllowMultiselect then OpenDialog.Options := [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing];
            if not OpenDialog.Execute then exit;
            if OpenDialog.Files.count =0 then exit;
            for ctr:= 0 to OpenDialog.files.count-1 do begin
              try
                if (AddNew or (ds.recordcount = 0)) and (ds.State <> dsInsert) then DsAppend
                else DsEdit;
                try
                      fileStream := TFileStream.Create(OpenDialog.files[ctr] , fmOpenRead);
                      fileStream.Position:= 0;
                      BlobStream := ds.CreateBlobStream(ds.fieldByname(FieldName) , bmWrite);
                      BlobStream.CopyFrom(fileStream,0);
                      PostDB(ds);
                finally
                  Freeandnil(fileStream);
                  Freeandnil(BlobStream);
                end;
                DsEdit;
                ds.fieldByname(PictypefieldName).asString := uppercase(replacestr(ExtractFileExt(OpenDialog.files[ctr]), '.' , ''));
                DsPost;
                if sametext(ds.fieldByname(PictypefieldName).asString , 'BMP') then
                  With TbusobjPicture.PictureObjInstance(PictureObjtype , ds.FieldByName(IDfieldName).AsInteger,  ds.Owner , nil , TERPConnection(ds.connection)) do try
                    fid:= ds.FieldByName(IDfieldName).AsInteger;
                    ds.Disablecontrols;
                    Try
                     ds.active := False;
                     BMPToJPG;
                     ds.Open;
                     ds.locate(IDfieldname , fid , []);
                     MessageDlgXP_vista('The BMP files are very big in size.'+NL+NL+
                                        'So ERP has autromatically converted ' + quotedstr(UpperCase(OpenDialog.files[ctr])) +' into JPG. ', mtInformation, [mbOK], 0);
                    Finally
                      ds.enablecontrols;
                    End;
                  finally
                     Free;
                  end;
                  //BMPToJPG(ds, FieldName, PictypefieldName);
              except
                  on e: Exception do
                    CommonLib.MessageDlgXP_Vista('Could not load the image file: "' + OpenDialog.files[ctr] + '"' +#13#10 + #13#10 +'The following error occured while loading the image: ' + e.Message, mtInformation, [mbOk], 0);
              end;
              AddNew := true;
            end;
            CommonLib.MessageDlgXP_Vista(inttostr(OpenDialog.Files.count) +' images(s) saved.', mtInformation, [mbOk], 0);

        except
            on e: Exception do
              CommonLib.MessageDlgXP_Vista('The following error occured while loading the image: ' + e.Message, mtInformation, [mbOk], 0);
        end;
      finally
        freeandNil(OpenDialog);
      end;
  finally
    DsPost;
  end;
end;
procedure RefreshDsImage(DataSet: TDataSet; Picturefieldname, Picturetypefieldname:String; Img :TImage; pnlImage , pnlPicturetype :TDNMPanel);
var
 ms:TMemoryStream;
 BMP:TBitmap;
 GIF:TGIFImage;
 PNG:TPNGImage;
 JPG:TJPEGImage;

 Function IsPictureJPG :boolean; begin   Result := SameText(Dataset.Findfield(Picturetypefieldname).asString , 'JPG') or SameText(Dataset.Findfield(Picturetypefieldname).asString , 'JPEG'); end;
 Function IsPictureBMP :boolean; begin   Result := SameText(Dataset.Findfield(Picturetypefieldname).asString , 'BMP') ; end;
 Function IsPictureGIF :boolean; begin   Result := SameText(Dataset.Findfield(Picturetypefieldname).asString , 'GIF') ; end;
 Function IsPicturePNG :boolean; begin   Result := SameText(Dataset.Findfield(Picturetypefieldname).asString , 'PNG') ; end;

begin

  if Dataset.Active then begin
    if (Dataset.Findfield(Picturefieldname).AsString ='') then begin
      Img.visible := False;
      if Assigned(pnlPicturetype) then
        pnlPicturetype.visible := False;
      if Assigned(pnlImage) then
        pnlImage.Caption := TLanguageTranslationObj.Inst.DoTranslate('No Picture found', TLanguageTranslationObj.Inst.UserLanguageId, []);
      Exit;
    end;

    if Assigned(pnlImage) then
      pnlImage.Caption := '';
    if Assigned(pnlPicturetype) then
      pnlPicturetype.visible := True;
    Img.visible := True;
    ms:=TMemoryStream.Create;
    try
      TBlobField(Dataset.Findfield(Picturefieldname)).SaveToStream(ms);
      ms.Position := 0;
      if trim(Picturetypefieldname) ='' then begin JPG:=TJPEGImage.Create; try JPG.LoadFromStream(ms); Img.Picture.Assign(JPG); finally JPG.Free; end;
      end else if IsPictureJPG then begin JPG:=TJPEGImage.Create; try JPG.LoadFromStream(ms); Img.Picture.Assign(JPG); finally JPG.Free; end;
      end else if IsPictureBMP then begin BMP:=TBitmap.Create   ; try BMP.LoadFromStream(ms); Img.Picture.Assign(BMP); finally BMP.Free; end;
      end else if IsPictureGIF then begin GIF:=TGIFImage.Create ; try GIF.LoadFromStream(ms); Img.Picture.Assign(GIF); finally GIF.Free; end;
      end else if IsPicturePNG then begin PNG:=TPNGImage.Create ; try PNG.LoadFromStream(ms); Img.Picture.Assign(PNG); finally PNG.Free; end;
      end;
    finally
       ms.Free;
    end;
  end;
end;

procedure BMPToJPG(ds:TDataset; FieldName, PictypefieldName:String);
begin

end;

end.
