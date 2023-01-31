unit ProductPictureList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog, DBAccess, MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate,
  SelectionDialog, ActnList, PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel, BusObjBase, BusObjProductPicture;

type
  TProductPictureListGUI = class(TBaseListingGUI)
    qryMainPartsId: TIntegerField;
    qryMainPARTNAME: TWideStringField;
    qryMainPictype: TWideStringField;
    imagePart: TImage;
    qryMainpartpicID: TIntegerField;
    btnConvertImage: TDNMSpeedButton;
    qryMainpartpic: TBlobField;
    btnStretch: TDNMSpeedButton;
    procedure btnConvertImageClick(Sender: TObject);
    procedure qryMainAfterScroll(DataSet: TDataSet);
    procedure qryMainAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure btnStretchClick(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
    procedure grdMainMultiSelectAllRecords(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
  private
    fsconvertFromPicturetype , fsconvertToPicturetype:String;
    fiProductID :Integer;
    fiPictureID :Integer;
    procedure RefreshProductPic(DataSet: TDataSet);
    Procedure ConvertImageCallback(Const Sender: TBusObj; var Abort: Boolean);

  Protected
    procedure AfterPopup(Popupform:TComponent);Override;
    procedure SetGridColumns; Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Property ProductID:Integer read fiProductID write fiProductID;
    Property PictureID:Integer read fiPictureID write fiPictureID;
    Procedure RefreshQuery;Override;
  end;


implementation

uses CommonLib, frmPartsFrm,GIFimg, pngimage,jpeg, frmConvertProductPicture, tcConst,
  CommonFormLib;

{$R *.dfm}
{ TProductPictureListGUI }

procedure TProductPictureListGUI.AfterPopup(Popupform: TComponent);
begin
  if not(Assigned(Popupform)) then exit;
  if not (Popupform is TfrmParts) then exit;
  if TfrmParts(Popupform).KeyID =0 then exit;
  TfrmParts(Popupform).Pagecontrol.ActivePage := TfrmParts(Popupform).TabPicture;
  TfrmParts(Popupform).qryPartPics.Locate('partpicID' , QrymainpartpicID.asInteger , []);
end;
procedure TProductPictureListGUI.btnConvertImageClick(Sender: TObject);
var
  fsSelectedIds :String;
  ProductPicture :TProductPicture;
begin
  inherited;
  fsSelectedIds := SelectedIDs('partpicID');
  if fsSelectedIds = '' then begin
    MessageDlgXP_vista('Please Select Images to be converted', mtWarning, [mbOK], 0);
    Exit;
  end;
  With TfmConvertProductPicture.create(Self) do try
    ConvertFromType := qryMainPictype.AsString;
    ConvertToType := '';
    showmodal;
    if modalresult = mrcancel then exit;
    fsconvertFromPicturetype := ConvertFromType;;
    fsconvertToPicturetype := ConvertToType ;
  finally
    Free;
  end;
  if (fsconvertFromPicturetype ='') or (fsconvertToPicturetype = '') or (sametext(fsconvertFromPicturetype, fsconvertToPicturetype)) then exit;
  ProductPicture := TProductPicture.CreateWithNewConn(Self);
  try
     ProductPicture.LoadSelect('partpicID in (' + fsSelectedIds+')');
     if ProductPicture.count =0 then exit;
     ProductPicture.Connection.BeginTransaction;
     try
      DoShowProgressbar(ProductPicture.count , WAITMSG);
      try
        ProductPicture.iteraterecords(ConvertImageCallback);
      finally
        DoHideProgressbar;
      end;
      ProductPicture.Connection.CommitTransaction;
      RefreshQuery;
     Except
      on E:Exception do begin
        MessageDlgXP_vista('Conversion Failed with the followng message'+NL+E.Message, mtWarning, [mbOK], 0);
        ProductPicture.Connection.RollbackTransaction;
      end;
     end;
  finally
     FreeandNil(ProductPicture);
  end;
end;

procedure TProductPictureListGUI.btnStretchClick(Sender: TObject);
begin
  DisableForm;
  try
    (*if imagePart.Stretch then begin
      imagePart.Stretch := False;
    end else begin
      imagePart.Stretch := True;
    end;*)
    StretchImage(imagePart , not(imagePart.Stretch));
  finally
    EnableForm;
  end;

end;

procedure TProductPictureListGUI.ConvertImageCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not (Sender is  TProductPicture) then exit;
  DoStepProgressbar(TProductPicture(Sender).ProductName);
  if not sametext(TProductPicture(Sender).Pictype , fsconvertFromPicturetype) then exit;
  if TProductPicture(Sender).Dataset.FieldByName('partPic').AsString = '' then exit;
  if not TProductPicture(Sender).Userlock.lock('tblparts' , TProductPicture(Sender).ProductID) then exit;
  TProductPicture(Sender).Connection.BeginNestedTransaction;
  try
         if sametext(TProductPicture(Sender).Pictype , 'BMP') and Sametext(fsconvertToPicturetype , 'GIF') then TProductPicture(Sender).BMPtoGIF
    else if sametext(TProductPicture(Sender).Pictype , 'BMP') and Sametext(fsconvertToPicturetype , 'JPG') then TProductPicture(Sender).BMPtoJPG
    else if sametext(TProductPicture(Sender).Pictype , 'BMP') and Sametext(fsconvertToPicturetype , 'PNG') then TProductPicture(Sender).BMPtoPNG

    else if sametext(TProductPicture(Sender).Pictype , 'GIF') and Sametext(fsconvertToPicturetype , 'BMP') then TProductPicture(Sender).GIFtoBMP
    else if sametext(TProductPicture(Sender).Pictype , 'GIF') and Sametext(fsconvertToPicturetype , 'JPG') then TProductPicture(Sender).GIFtoJPG
    else if sametext(TProductPicture(Sender).Pictype , 'GIF') and Sametext(fsconvertToPicturetype , 'PNG') then TProductPicture(Sender).GIFtoPNG

    else if sametext(TProductPicture(Sender).Pictype , 'JPG') and Sametext(fsconvertToPicturetype , 'BMP') then TProductPicture(Sender).JPGtoBMP
    else if sametext(TProductPicture(Sender).Pictype , 'JPG') and Sametext(fsconvertToPicturetype , 'GIF') then TProductPicture(Sender).JPGtoGIF
    else if sametext(TProductPicture(Sender).Pictype , 'JPG') and Sametext(fsconvertToPicturetype , 'PNG') then TProductPicture(Sender).JPGtoPNG

    else if sametext(TProductPicture(Sender).Pictype , 'PNG') and Sametext(fsconvertToPicturetype , 'BMP') then TProductPicture(Sender).PNGtoBMP
    else if sametext(TProductPicture(Sender).Pictype , 'PNG') and Sametext(fsconvertToPicturetype , 'GIF') then TProductPicture(Sender).PNGtoGIF
    else if sametext(TProductPicture(Sender).Pictype , 'PNG') and Sametext(fsconvertToPicturetype , 'JPG') then TProductPicture(Sender).PNGtoJPG;

    TProductPicture(Sender).Connection.CommitNestedTransaction;
  Except
    on E:Exception do begin
      MessageDlgXP_vista('Conversion Failed with the followng message'+NL+E.Message, mtWarning, [mbOK], 0);
      TProductPicture(Sender).Connection.RollbackNestedTransaction;
    end;
  end;
end;

procedure TProductPictureListGUI.FormCreate(Sender: TObject);
begin
  fiProductID := 0;
  fiPictureID:= 0;
  inherited;

end;

procedure TProductPictureListGUI.grdMainMultiSelectAllRecords(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  RefreshProductPic(Qrymain);
end;

procedure TProductPictureListGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  RefreshProductPic(Qrymain);
end;

procedure TProductPictureListGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  RefreshProductPic(Qrymain);
end;

procedure TProductPictureListGUI.qryMainAfterScroll(DataSet: TDataSet);
begin
  inherited;
  RefreshProductPic(Qrymain);
end;

procedure TProductPictureListGUI.ReadnApplyGuiPrefExtra;
begin
  inherited;
  //imagePart.Stretch :=  GuiPrefs.Node['Options.ImageStretch'].asBoolean;
  StretchImage(imagePart , GuiPrefs.Node['Options.ImageStretch'].asBoolean);
end;

procedure TProductPictureListGUI.RefreshProductPic(DataSet: TDataSet);
var
 ms:TMemoryStream;
 BMP:TBitmap;
 GIF:TGIFImage;
 PNG:TPNGImage;
 JPG:TJPEGImage;

 Function IsPictureJPG :boolean; begin   Result := SameText(QrymainPictype.asString , 'JPG') or SameText(QrymainPictype.asString , 'JPEG'); end;
 Function IsPictureBMP :boolean; begin   Result := SameText(QrymainPictype.asString , 'BMP') ; end;
 Function IsPictureGIF :boolean; begin   Result := SameText(QrymainPictype.asString , 'GIF') ; end;
 Function IsPicturePNG :boolean; begin   Result := SameText(QrymainPictype.asString , 'PNG') ; end;

begin
  
  if Dataset.Active then begin
    if (Dataset.recordcount =0) and (QrymainpartPic.AsString ='') then begin
      imagePart.visible := False;
      Exit;
    end;
    if (Dataset.EOF or Dataset.BOF) and (QrymainpartPic.AsString ='') then begin
      imagePart.visible := False;
      Exit;
    end;
    imagePart.visible := True;
    ms:=TMemoryStream.Create;
    try
      TBlobField(QrymainpartPic).SaveToStream(ms);
      ms.Position := 0;
               if IsPictureJPG then begin JPG:=TJPEGImage.Create; try JPG.LoadFromStream(ms); imagePart.Picture.Assign(JPG); finally JPG.Free; end;
      end else if IsPictureBMP then begin BMP:=TBitmap.Create   ; try BMP.LoadFromStream(ms); imagePart.Picture.Assign(BMP); finally BMP.Free; end;
      end else if IsPictureGIF then begin GIF:=TGIFImage.Create ; try GIF.LoadFromStream(ms); imagePart.Picture.Assign(GIF); finally GIF.Free; end;
      end else if IsPicturePNG then begin PNG:=TPNGImage.Create ; try PNG.LoadFromStream(ms); imagePart.Picture.Assign(PNG); finally PNG.Free; end;
      end;
    finally
       ms.Free;
    end;
  end;
end;

procedure TProductPictureListGUI.RefreshQuery;
begin
  Qrymain.ParamByName('ProductID').AsInteger := ProductID;
  inherited;
  if fiPictureID <> 0 then
    qrymain.Locate(qrymainpartpicID.FieldName , PictureID , []);
end;

procedure TProductPictureListGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid(qrymainpartsid.fieldname);
  RemoveFieldfromGrid(qrymainpartpicID.fieldname);
end;
procedure TProductPictureListGUI.WriteGuiPrefExtra;
begin
  inherited;
    GuiPrefs.Node['Options.ImageStretch'].asBoolean := imagePart.Stretch;
end;

initialization
  RegisterClassOnce(TProductPictureListGUI);

end.

