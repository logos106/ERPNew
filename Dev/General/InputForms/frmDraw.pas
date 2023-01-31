unit frmDraw;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, DNMPanel, frmDrawBase, db, AdvPicture, frmBase;

type
  TfmDraw = class(TfmDrawBase)
    pnlMain: TDNMPanel;
    PaintBox1: TPaintBox;
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1Paint(Sender: TObject);
  private
    { Private declarations }
    Zoom:integer;
    XFrom,YFrom:Integer;
    fColour: TColor;
    fOnDraw: TNotifyEvent;
    fOnDrew: TNotifyEvent;
    fsDefaultJPG: String;
    fOndrawPaint: TNotifyEvent;
    outsidePaintboxMsg:String;
    procedure DrawLine(xS, YS, xE, yE, size: integer; Col: TColor);
    procedure Setcolour(const Value: TColor);
    procedure loadDefaultJPG(const Value: String); overload;
    procedure loadDefaultJPG; overload;
    function isInsidePaintbox(const x1, y1, x2, y2:Integer):Boolean;
  Protected
    function Image: TBitmap;Override;
  public
    Property DefaultJPG :String read fsDefaultJPG write loadDefaultJPG;
    Property Colour :TColor read fColour write Setcolour;
    Procedure RefreshDB;
    Property OnDraw : TNotifyEvent REad fOnDraw write fOnDraw;
    Property OnDrew : TNotifyEvent Read fOnDrew write fOnDrew;
    Property OndrawPaint : TNotifyEvent Read fOndrawPaint write fOndrawPaint;
    Procedure Clear;
    Procedure Relaod;
    class function  DoDraw(Const Ownerform :TfrmBaseGUI; Parentcomp:TWinControl;  const ImagefileName:String ; PanelAlign:TAlign = alclient): TfmDraw;
  end;

implementation

uses ImagesLib, CommonDbLib, CommonLib;

{$R *.DFM}

procedure TfmDraw.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin
  XFrom:=X;
  YFrom:=Y;
end;


procedure TfmDraw.Setcolour(const Value: TColor);
begin
  fColour := Value;
end;

procedure TfmDraw.FormCreate(Sender: TObject);
begin
  inherited;
  try
    Zoom          := 4;
    fcolour       := clblack;
    fOnDraw       := nil;
    fOnDrew       := nil;
    fOndrawPaint  := nil;

  Except
    on E:Exception do begin
      MessageDlgXP_Vista('3: Exception : '+ E.message, mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TfmDraw.FormDestroy(Sender: TObject);
begin
  Freeandnil(fJPEGStream );
  Freeandnil(JPEG);
end;

procedure TfmDraw.loadDefaultJPG;
begin
  try
    if fsDefaultJPG = '' then begin
      PaintBox1.canvas.refresh;
    end else begin
        fJPEGStream .LoadFromFile(fsDefaultJPG);
        JPEG.LoadFromStream(fJPEGStream );
        PaintBox1.canvas.Draw(0,0,JPEG);
    end;
    Dirty := True;
    if assigned(fOnDraw) then fOnDraw(Self);
  Except
    on E:Exception do begin
      MessageDlgXP_Vista('4: Exception : '+ E.message, mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TfmDraw.loadDefaultJPG(const Value: String);
begin
  fsDefaultJPG := Value;
  loadDefaultJPG;
end;

procedure TfmDraw.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
begin
   if (ssLeft in shift)  then begin
    DrawLine(XFrom,YFrom,x,y,zoom, fcolour);
    XFrom:= x;
    YFrom:= y;
   end;
   Dirty := True;
end;

procedure TfmDraw.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  Paintbox1.Canvas.Draw(0,0, image);
  if assigned(fOnDrew) then fOnDrew(Self);
end;

procedure TfmDraw.PaintBox1Paint(Sender: TObject);
begin
  inherited;
  Paintbox1.Canvas.Draw(0,0, fimage);
  if assigned(fOndrawPaint) then
    fOndrawPaint(self);
end;


procedure TfmDraw.RefreshDB;
begin
  try
    DBFieldtoJPEg(fJPEGStream , dataset, fieldname);
    fImage.LoadFromStream(fJPEGStream );
    PaintBox1.canvas.Draw(0,0,fImage);
    PaintBox1.canvas.refresh;
  Except
    on E:Exception do begin
      MessageDlgXP_Vista('5: Exception : '+ E.message, mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TfmDraw.Relaod;
begin

end;

procedure TfmDraw.DrawLine(xS,YS,xE,yE,size:integer; Col:TColor);
begin
  if isInsidePaintbox(xs, ys, xe, ye) then begin
     paintbox1.Canvas.MoveTo(xS,YFrom);
     paintbox1.Canvas.pen.Color :=col;
     paintbox1.Canvas.pen.Width:=size;
     paintbox1.Canvas.LineTo(xE,yE);
  end else begin
  end;
end;


procedure TfmDraw.Clear;
begin
  PaintBox1.canvas.refresh;
end;

class function  TfmDraw.DoDraw(Const Ownerform :TfrmBaseGUI;  Parentcomp:TWinControl;   const ImagefileName: String; PanelAlign : TAlign = alclient):TfmDraw;
var
  form :  TfmDraw;
begin
  form := TfmDraw.Create(Ownerform);
  form.pnlMain.Parent := Parentcomp;
  form.pnlMain.Align  := PanelAlign;
  //form.DefaultImage   := ImageFileName;
  form.DefaultJPG :=ImageFileName;
  result:= Form;
end;

function TfmDraw.Image: TBitmap;
begin
      fImage.Width := paintbox1.Width;
      fImage.Height := paintbox1.Height;
      fImage.Canvas.CopyRect(Rect(0, 0, fImage.Width, fImage.Height), paintbox1.Canvas, Rect(0, 0, fImage.Width, fImage.Height));
      result:= fImage;
end;

function TfmDraw.isInsidePaintbox(const x1, y1, x2, y2: Integer): Boolean;
begin
  result:= False;
  outsidePaintboxMsg:= '';
  if x1 <0 then begin outsidePaintboxMsg:= 'x1 = '+ inttostr(x1)+ ' <0'; exit; end;
  if x2 <0 then begin outsidePaintboxMsg:= 'y1 = '+ inttostr(y1)+ ' <0';exit; end;
  if y1 <0 then begin outsidePaintboxMsg:= 'x2 = '+ inttostr(x2)+ ' <0';exit; end;
  if y2 <0 then begin outsidePaintboxMsg:= 'y2 = '+ inttostr(y2)+ ' <0';exit; end;

  if x1 > PaintBox1.ClientWidth then begin outsidePaintboxMsg:= 'x1 = '+ inttostr(x1)+ ' > ' + inttostr(PaintBox1.ClientWidth);exit; end;
  if x2 > PaintBox1.ClientWidth then begin outsidePaintboxMsg:= 'x2 = '+ inttostr(x2)+ ' > ' + inttostr(PaintBox1.ClientWidth); exit; end;

  if y1 > PaintBox1.ClientHeight then begin  outsidePaintboxMsg:= 'y1 = '+ inttostr(y1)+ ' > ' + inttostr(PaintBox1.Clientheight); exit; end;
  if y2 > PaintBox1.ClientHeight then begin   outsidePaintboxMsg:= 'y2 = '+ inttostr(y2)+ ' > ' + inttostr(PaintBox1.Clientheight); exit; exit; end;
  REsult:= True;
end;

end.



