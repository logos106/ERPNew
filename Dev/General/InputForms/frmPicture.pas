unit frmPicture;

interface

 {-----------------------------------------------------------------------------}

 uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
    Dialogs, ExtCtrls, StdCtrls, DNMPanel, frmDrawBase, frmBase, db, DNMSpeedButton, Menus, AdvMenus;

 {-----------------------------------------------------------------------------}

 const
       WM_USER                    = 1024;
       WM_CAP_DRIVER_CONNECT      = 1034;
       WM_CAP_DRIVER_DISCONNECT   = 1035;
       WM_CAP_GET_FRAME           = 1084;
       WM_CAP_COPY                = 1054;
       WM_CAP_START               = WM_USER;
       WM_CAP_DLG_VIDEOFORMAT     = WM_CAP_START + 41;
       WM_CAP_DLG_VIDEOSOURCE     = WM_CAP_START + 42;
       WM_CAP_DLG_VIDEODISPLAY    = WM_CAP_START + 43;
       WM_CAP_GET_VIDEOFORMAT     = WM_CAP_START + 44;
       WM_CAP_SET_VIDEOFORMAT     = WM_CAP_START + 45;
       WM_CAP_DLG_VIDEOCOMPRESSION= WM_CAP_START + 46;
       WM_CAP_SET_PREVIEW         = WM_CAP_START + 50;
       PICWIDTH                   = 640;
       PICHEIGHT                  = 480;


type
  TfmPicture = class(TfmDrawBase)
    pnlMal: TDNMPanel;
    pnlPicture: TDNMPanel;
    Timer1: TTimer;
    btnPicture: TDNMSpeedButton;
    btnClose: TDNMSpeedButton;
    mnuVideo: TAdvPopupMenu;
    VideoSource1: TMenuItem;
    Videoformat1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnPictureClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure pnlMalDblClick(Sender: TObject);
    procedure VideoSource1Click(Sender: TObject);
    procedure Videoformat1Click(Sender: TObject);
  private
    FCapHandle : THandle;
    fsPhotonamefield: String;
    Function JPGFielName:String;
    //Function BMPFielName:String;
  protected
    function Image: TBitmap;Override;

  public
    class function TakePicture(Title:String; PicutreDataset:TDataset;PicturefieldName:string; filefielname:String):Boolean;
    Property Photonamefield:String read fsPhotonamefield write fsPhotonamefield;
    function SaveToDBField(ds: TDataset; FieldName: String;AddNew: boolean):boolean;Override;

  end;

implementation

uses CommonDbLib;

{$R *.dfm}
 {-----------------------------------------------------------------------------}

 function capCreateCaptureWindow(lpszWindowName: LPCSTR; dwStyle: DWORD;
 x, y, nWidth, nHeight: integer; hwndParent: HWND; nID: integer): HWND; stdcall;
 external 'AVICAP32.DLL' name 'capCreateCaptureWindowA';


(*function TfmPicture.BMPFielName: String;
begin
  REsult:= 'Photo_' + FormatDateTime('yyyy-mm-dd HH-nn-ss', now)+'.bmp';
end;*)

procedure TfmPicture.btnCloseClick(Sender: TObject);
begin
  inherited;
  ModalResult:= MrCancel;
end;

procedure TfmPicture.btnPictureClick(Sender: TObject);
begin
  dirty:= True;
  PostDB;
  ModalResult := mrOk;
end;


function TfmPicture.JPGFielName: String;
begin
  REsult:= 'Photo_' + FormatDateTime('yyyy-mm-dd HH-nn-ss', now)+'.jpg'
end;

procedure TfmPicture.pnlMalDblClick(Sender: TObject);
begin
  inherited;
  Self.height := Self.height-1;
end;

function TfmPicture.SaveToDBField(ds: TDataset; FieldName: String; AddNew: boolean): boolean;
begin
  result:= inherited;
  if not result then exit;
    if Photonamefield <> '' then begin
      editDb(dataset);
      dataset.fieldbyname(Photonamefield).asString := JPGFielName;
      commondblib.PostDB(dataset);
    end;
end;

procedure TfmPicture.FormCreate(Sender: TObject);
begin
  inherited;
 FCapHandle:= capCreateCaptureWindow('Video', WS_CHILD or WS_VISIBLE, 0, 0, PICWIDTH, PICHEIGHT, pnlPicture.Handle, 1);
 SendMessage(FCapHandle, WM_CAP_DRIVER_CONNECT,0,0);
 // these are for the camera settings - video source and video format
 //SendMessage(FCapHandle, WM_CAP_DLG_VIDEOSOURCE,0,0);
 //SendMessage(FCapHandle, WM_CAP_DLG_VIDEOFORMAT,0,0);
 fsPhotonamefield :='';
end;

procedure TfmPicture.FormDestroy(Sender: TObject);
begin
 SendMessage(FCapHandle,WM_CAP_DRIVER_DISCONNECT, 0, 0);
end;

function TfmPicture.Image: TBitmap;
begin
      fImage.Width := pnlPicture.Width;
      fImage.Height := pnlPicture.Height;
      fImage.Canvas.CopyRect(Rect(0, 0, fImage.Width, fImage.Height), pnlPicture.Canvas, Rect(0, 0, fImage.Width, fImage.Height));
      REsult:= fImage;
end;

class Function  TfmPicture.TakePicture(Title:String; PicutreDataset: TDataset; PicturefieldName: string; filefielname:String):boolean;
var
  form :  TfmPicture;
begin
  form := TfmPicture.Create(nil);
  try
    form.Dataset := PicutreDataset;
    form.fieldname := PicturefieldName;
    form.Photonamefield := filefielname;
    Form.Caption := Title;
    form.Showmodal;
    REsult:= Form.ModalResult = mrOk;
  finally
    Freeandnil(Form);
  end;
end;

procedure TfmPicture.Timer1Timer(Sender: TObject);
begin
  SendMessage(FCapHandle,WM_CAP_GET_FRAME, 0, 0);
end;

procedure TfmPicture.Videoformat1Click(Sender: TObject);
begin
  inherited;
  SendMessage(FCapHandle, WM_CAP_DLG_VIDEOFORMAT,0,0);
end;

procedure TfmPicture.VideoSource1Click(Sender: TObject);
begin
  inherited;
  SendMessage(FCapHandle, WM_CAP_DLG_VIDEOSOURCE,0,0);
end;

end.

