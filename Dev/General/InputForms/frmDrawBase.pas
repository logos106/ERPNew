unit frmDrawBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  JPEG, Dialogs, frmBase, ExtCtrls, StdCtrls, db;

type
  TfmDrawBase = class(TfrmBaseGUI)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fDataset: Tdataset;
    fsfieldname: string;
    fsDrawtimefield: String;
    fbDirty: boolean;
  Protected
    fImage :TBitmap;
    fJPEGStream :TMemoryStream;
    JPEG: TJpegImage;
    function Image: TBitmap;Virtual;abstract;
  public
    function SaveToDBField(ds: TDataset; FieldName: String;AddNew: boolean):boolean;Virtual;
    Procedure SaveToJPG(const filename:String);Virtual;
    Procedure SaveToBMP(const filename:String);Virtual;
    Property Dataset :Tdataset read fDataset write fdataset;
    Property fieldname : string read fsfieldname write fsfieldname;
    property Drawtimefield :String read fsDrawtimefield  write fsDrawtimefield ;
    Procedure PostDB;virtual;
    Property Dirty :boolean read fbDirty write fbdirty;
  end;

implementation

uses CommonDbLib, ImagesLib, CommonLib, tcConst;

{$R *.dfm}

procedure TfmDrawBase.FormCreate(Sender: TObject);
begin
  inherited;
    Dataset       := nil;
    fieldname     := '';
    Drawtimefield :='';
    Dirty         := False;
    fImage        :=TBitmap.create;
    fJPEGStream   :=TMemoryStream.Create;
    JPEG          := TJpegImage.Create;
end;

procedure TfmDrawBase.FormDestroy(Sender: TObject);
begin
  Freeandnil(fImage);
  inherited;
end;

procedure TfmDrawBase.PostDB;
begin
  if not dirty then exit;
  Try
  if SaveToDBField(Dataset, fieldname, false) then begin
    if Drawtimefield <> '' then begin
      editDb(dataset);
      dataset.fieldbyname(Drawtimefield).asDateTime := now;
      commondblib.PostDB(dataset);
    end;
  end;
  Except
    on E:Exception do begin
        MessageDlgXP_Vista('Saving Failed ' + NL + e.Message, mtWarning, [mbOK], 0);
        Exit;
    end;
  End;
end;


procedure TfmDrawBase.SaveToBMP(const filename: String);
begin
  Image.SaveToFile(filename);
end;

function TfmDrawBase.SaveToDBField(ds: TDataset; FieldName: String; AddNew: boolean): boolean;
begin
  REsult:= False;
  try
    JPEG.Assign(Image);
    //JPEG.Compress;
    result:= ImagesLib.JpegToDBField(JPEG, ds, fieldname, addnew);
  Except
    on E:Exception do begin
      MessageDlgXP_Vista('1: Exception : '+ E.message, mtWarning, [mbOK], 0);
    end;
  end;

end;

procedure TfmDrawBase.SaveToJPG(const filename: String);
begin
  try
     JPEG.CompressionQuality:=50;
     JPEG.ProgressiveEncoding:=false;
     JPEG.Smoothing:=true;
     JPEG.Assign(Image);
     JPEG.SaveToFile(filename);
  Except
    on E:Exception do begin
      MessageDlgXP_Vista('2: Exception : '+ E.message, mtWarning, [mbOK], 0);
    end;
  end;
end;

end.

