unit frmSignatureEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseFormForm, SelectionDialog, Menus, ExtCtrls, StdCtrls,
  DNMSpeedButton, SignatureReaderEPadLinkObj, DB;

type
  TfmSignatureEdit = class(TBaseForm)
    btnSave: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    btnClear: TDNMSpeedButton;
    Image: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    Reader: TSignatureReaderEPadLink;
    Cleared: boolean;
    //StartX, StartY, EndX, EndY : integer;
    LastX, LastY: integer;
  public
    DataField: TBlobField;
    DataStream: TStream;
    DateTimeField : TDateTimeField;
  end;

function GetClientSignature(aBlobField: TBlobField; aDateTimeField : TDateTimeField): boolean; overload;
function GetClientSignature(aStream: TStream): boolean; overload;

implementation

uses
  jpeg, CommonLib;

{$R *.dfm}

function GetClientSignature(aBlobField: TBlobField; aDateTimeField : TDateTimeField): boolean;
var
  form: TfmSignatureEdit;
begin
  form := TfmSignatureEdit.Create(nil);
  try
    form.DataField := aBlobField;
    form.DateTimeField := aDateTimeField;
    result := form.ShowModal = mrOk;
  finally
    form.Release;
  end;
end;

function GetClientSignature(aStream: TStream): boolean;
var
  form: TfmSignatureEdit;
begin
  form := TfmSignatureEdit.Create(nil);
  try
    form.DataStream := aStream;
    result := form.ShowModal = mrOk;
  finally
    form.Release;
  end;
end;


{TfmSignatureEdit}

procedure TfmSignatureEdit.btnClearClick(Sender: TObject);
begin
  inherited;
   Cleared := true;
  if Reader.Active then begin
    Reader.Clear;
  end
  else begin
    Image.Picture := nil;
    Image.Canvas;
    try
      Reader.Active := true;
      if not Reader.Active then begin
        { clear the image anyway .. }
        if Assigned(DataField) then
          self.EditDB(DataField.DataSet);
        if Assigned(DataField) then
        begin
          DataField.Clear;
          if assigned(DateTimeField) then
            DateTimeField.Clear;
        end
        else if Assigned(DataStream) then
        begin
          if DataStream is TMemoryStream then
            TMemoryStream(DataStream).Clear;
        end;
//        Close;
      end;
    except
      on e: exception do begin
        CommonLib.MessageDlgXP_Vista('Error connecting to Signature Reader: ' + e.Message, mtWarning,[mbOk],0);
        Close;
      end;
    end;
  end;
end;

procedure TfmSignatureEdit.btnSaveClick(Sender: TObject);
var
  JpegImg: TJpegImage;
  PictureStream: TStream;
  fileStream: TFileStream;
begin
  inherited;
  if Assigned(DataField) then
    self.EditDB(DataField.DataSet);
  if Reader.IsBlank and Reader.Active then
  begin
    if Cleared then
    begin
      if Assigned(DataField) then
      begin
        DataField.Clear;
        if assigned(DateTimeField) then
          DateTimeField.Clear;
      end
      else if Assigned(DataStream) then
      begin
        if DataStream is TMemoryStream then
          TMemoryStream(DataStream).Clear;
      end;
    end
    else begin
      ModalResult := mrCancel;
      exit;
    end;
  end
  else
  begin
    JpegImg := TJpegImage.Create;
    PictureStream := nil;
    if Assigned(DataField) then
      PictureStream := DataField.DataSet.CreateBlobStream(TBlobField(DataField), bmReadWrite);
    try
      JpegImg.Assign(Image.Picture.Bitmap);
      //JpegImg.JPEGNeeded;

//      DeleteFile('c:\temp\temp.jpg');
//      fileStream := TFileStream.Create('c:\temp\temp.jpg', fmCreate);
//      try
//        JpegImg.SaveToStream(fileStream);
//      finally
//        fileStream.Free;
//      end;


      if Assigned(PictureStream) then
        JpegImg.SaveToStream(PictureStream)
      else if Assigned(DataStream) then begin
        if DataStream is TMemoryStream then
          TMemoryStream(DataStream).Clear;
        JpegImg.SaveToStream(DataStream);
      end;
      if assigned(DateTimeField) then
        DateTimeField.AsDateTime := Now();
    finally
      JpegImg.Free;
      PictureStream.Free;
    end;
  end;
  ModalResult := mrOk;
end;

procedure TfmSignatureEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Reader.Free;
end;

procedure TfmSignatureEdit.FormCreate(Sender: TObject);
begin
  inherited;
  Reader := TSignatureReaderEPadLink.Create;
  Reader.Image := Image;
  Cleared := false;
end;

procedure TfmSignatureEdit.FormShow(Sender: TObject);
var
  JpegImg: TJpegImage;
  PictureStream: TStream;
begin
  inherited;
  if (Assigned(DataField) and (DataField.BlobSize > 0)) or (Assigned(DataStream) and (DataStream.Size > 0)) then begin
    JpegImg := TJpegImage.Create;
    PictureStream := nil;
    if Assigned(DataField) then
      PictureStream := DataField.DataSet.CreateBlobStream(TBlobField(DataField), bmRead);
    try
      if Assigned(PictureStream) then
        JpegImg.LoadFromStream(PictureStream)
      else if Assigned(DataStream) then
        JpegImg.LoadFromStream(DataStream);
      Image.Picture.Bitmap.Assign(JpegImg);
    finally
      JpegImg.Free;
      PictureStream.Free;
    end;
  end
  else begin
    { no existing signature, capture a new one }
    Image.Picture := nil;
    Image.Canvas;
    try
      Reader.Active := true;
//      if not Reader.Active then
//        Close;
      if not Reader.Active then begin

      end;
    except
      on e: exception do begin
        CommonLib.MessageDlgXP_Vista('Error connecting to Signature Reader: ' + e.Message, mtWarning,[mbOk],0);
        Close;
      end;
    end;
  end;
end;

procedure TfmSignatureEdit.ImageMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  //
  if Reader.Active then
    exit;
//  StartX := x;
//  StartY := y;
//  EndX := x;
//  EndY := y;
  LastX := X;
  LastY := Y;
end;

procedure TfmSignatureEdit.ImageMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited;
  //
  if Reader.Active then
    exit;
  if ssLeft in Shift then begin
    Image.Canvas.Pen.Mode := pmBlack; //pmNotXor;
//    Canvas.MoveTo(StartX,StartY);
//    Canvas.LineTo(EndX,EndY);
//    Canvas.MoveTo(StartX,StartY);
    Image.Canvas.MoveTo(LastX,LastY);
    Image.Canvas.LineTo(x,y);
//    EndX := x;
//    EndY := y;
    LastX := x;
    LastY := y;
  end;
end;

procedure TfmSignatureEdit.ImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  //
  if Reader.Active then
    exit;
  Image.Canvas.MoveTo(LastX, LastY);
  Image.Canvas.LineTo(x,y);
end;

end.
