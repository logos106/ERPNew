unit SignatureReaderEPadLinkObj;

interface

uses
  SignatureReaderObj, EpadInkLib_TLB, Classes, Types, ExtCtrls;

type
  TePadData = class;

  TSignatureReaderEPadLink = class(TSignatureReader)
  private
    Pad: TEpadInk;
    Data: TePadData;
    fActive: boolean;
    minX, maxX,
    minY, maxY: integer;
    Scale: integer;
    adjX, adjY: integer;
    procedure OnFireData(ASender: TObject; abs_x: Integer; abs_y: Integer; abs_z: Integer;
                                                    fTouch: Smallint; dwTimestamp: Integer;
                                                    dwSeqenceNum: Integer);
    procedure DrawLine(idx: integer);
    procedure DrawImage;
  protected
    function GetActive: boolean; override;
    procedure SetActive(const Value: boolean); override;
    procedure SetImage(const Value: TImage); override;
    function GetIsBlank: boolean; Override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Clear; override;
  end;

  //PPoint TPoint
  TePadData = class
  private
    fList: TList;
    fOnMinXChange: TNotifyEvent;
    fOnMinYChange: TNotifyEvent;
    fMaxX: LongInt;
    fMaxY: LongInt;
    fMinX: LongInt;
    fMinY: LongInt;
    function GetCount: integer;
    function GetItem(idx: integer): TPoint;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(aX, aY: LongInt);
    property MinX: LongInt read fMinX;
    property MaxX: LongInt read fMaxX;
    property MinY: LongInt read fMinY;
    property MaxY: LongInt read fMaxY;
    procedure Clear;
    property OnMinXChange: TNotifyEvent read fOnMinXChange write fOnMinXChange;
    property OnMinYChange: TNotifyEvent read fOnMinYChange write fOnMinYChange;
    property Count: integer read GetCount;
    property Item[idx: integer]: TPoint read GetItem; default;
  end;


implementation

uses
  SysUtils, Vista_MessageDlg, Dialogs, Graphics;

const
  Image_Border = 10;

{ TSignatureReaderEPadLink }

procedure TSignatureReaderEPadLink.Clear;
begin
  if Assigned(Pad) then begin
    //Pad.connClearScreen;
    if Active then begin
      Active := false;
      Active := true;
    end;
  end;
  Data.Clear;
  minX := 0;
  minY := 0;
  maxX := 0;
  maxY := 0;
  adjX := 0;
  adjY := 0;
  inherited;
end;

constructor TSignatureReaderEPadLink.Create;
begin
  inherited;
  fActive := false;
  minX := 0;
  minY := 0;
  maxX := 0;
  maxY := 0;
  adjX := 0;
  adjY := 0;
  Data := TePadData.Create;
end;

destructor TSignatureReaderEPadLink.Destroy;
begin
  inherited;
  Active := false;
end;

procedure TSignatureReaderEPadLink.DrawImage;
var
  i: integer;
begin
  if not Assigned(Image) then exit;

//  Image.Canvas.Brush.Color := clWhite;
//  Image.Canvas.FillRect(Rect(0,0,Image.Width,Image.Height));
  Image.Picture := nil;
  adjX := 0;
  adjY := 0;
  if Data.MinX > 0 then adjX := Data.MinX  - Image_Border;
  if Data.MinY > 0 then adjY := Data.MinY - Image_Border;

  for i := 0 to Data.Count -1 do begin
    DrawLine(i);
  end;
end;

procedure TSignatureReaderEPadLink.DrawLine(idx: integer);
var
  x,y: integer;
begin
  if not Assigned(Image) then exit;
  Image.Canvas.Pen.Color := clBlack;
  Image.Canvas.Pen.Width := 2;
  x := ((Data[idx].X - adjX) div Scale) + Image_Border;
  y := ((Data[idx].Y - adjY) div Scale) + Image_Border;
  if (idx = 0) or (Data[idx-1].X = 0) then begin
    Image.Canvas.MoveTo(x,y);
  end
  else begin
    if Data[idx].X = 0 then exit;
    Image.Canvas.LineTo(x,y);
  end;
end;

function TSignatureReaderEPadLink.GetActive: boolean;
begin
  result := fActive;
end;

function TSignatureReaderEPadLink.GetIsBlank: boolean;
begin
  result := Data.Count = 0;
end;

procedure TSignatureReaderEPadLink.OnFireData(ASender: TObject; abs_x, abs_y,
  abs_z: Integer; fTouch: Smallint; dwTimestamp, dwSeqenceNum: Integer);
begin
  if fTouch > 0 then begin
    Data.Add(abs_x,abs_y);
    if Assigned(Image) then begin
      Scale := (Data.MaxY - Data.MinY) div (Image.Height-20);
      if Scale < 1 then Scale := 1;
    end;

    if (minX <> Data.MinX) or (minY <> Data.MinY) or
      (maxX <> Data.MaxX) or (maxY <> Data.MaxY) then begin
      minX := Data.MinX;
      minY := Data.MinY;
      maxX := Data.MaxX;
      maxY := Data.MaxY;
      DrawImage;
    end
    else begin
      if Data.Count = 1 then begin
        adjX := 0;
        adjY := 0;
        if Data.MinX > 0 then adjX := Data.MinX;
        if Data.MinY > 0 then adjY := Data.MinY;
      end;
      DrawLine(Data.Count-1);
    end;

  end
  else begin
    Data.Add(0,0);
  end;
end;

procedure TSignatureReaderEPadLink.SetActive(const Value: boolean);
var
  res: integer;
begin
  if fActive = Value then exit;
  inherited;
  if Value then begin
    try
      Pad := TEpadInk.Create(nil);
      Pad.OnFirePadData := self.OnFireData;
    except
      on e: exception do begin
        Pad := nil;
        if IsGUI then
          Vista_MessageDlg.MessageDlgXP_Vista('There was a problem connecting to the ePad.' +
            #13#10 + #13#10 +
            'This probably means that the manufactures driver software for the ePad has not been installed on this computer.' +
            ' Please install/re-install the ePad software.', mtWarning, [mbOk],0)
        else
          raise;
        exit;
      end;
    end;
    { now try and connect .. }
    res := Pad.OpenConnection(0);
    if res <> 1 then begin
      try
        FreeAndNil(Pad);
      except
      end;
      if IsGui then
        Vista_MessageDlg.MessageDlgXP_Vista('There was a problem connecting to the ePad.' +
          #13#10 + #13#10 +
          'Please make sure the ePad is plugged into this computer and that the manufactures driver software has been installed.', mtWarning, [mbOk],0)
      else
        raise Exception.Create('Failed to communicate with the ePad');
      exit;
    end;
    { we are connected! }
    fActive := true;
    if Assigned(Image) then begin
      Image.Canvas.Pen.Color := clBlack;
      Image.Canvas.Pen.Width := 2;
    end;
  end
  else begin
    { disconnect }
    try
      Pad.CloseConnection;
      FreeAndNil(Pad);
    except
    end;
    fActive := false;
  end;
end;

procedure TSignatureReaderEPadLink.SetImage(const Value: TImage);
begin
  inherited;
  if Assigned(Image) then begin


  end;
end;

{ TePadData }

procedure TePadData.Add(aX, aY: Integer);
var
  pt: PPoint;
begin
  New(pt);
  pt^.X := aX;
  pt^.Y := aY;
  fList.Add(pt);

  if ((pt^.X < fMinX) or (fMinX  = 0)) and (pt^.X <> 0) then begin
    fMinX := pt^.X;
    if Assigned(fOnMinXChange) then
      fOnMinXChange(self);
  end;
  if (pt^.X > fMaxX) or (fMaxX = 0) then
    fMaxX := pt^.X;

  if ((pt^.Y < fMinY) or (fMinY = 0)) and (pt^.Y <> 0) then begin
    fMinY := pt^.Y;
    if Assigned(fOnMinYChange) then
      fOnMinYChange(self);
  end;
  if (pt^.Y > fMaxY) or (fMaxY = 0) then
    fMaxY := pt^.Y;
end;

procedure TePadData.Clear;
begin
  while fList.Count > 0 do begin
    Dispose(fList[0]);
    fList.Delete(0);
  end;
  fMinX := 0;
  fMaxX := 0;
  fMinY := 0;
  fMaxY := 0;
end;

constructor TePadData.Create;
begin
  fList := TList.Create;
  fMinX := 0;
  fMaxX := 0;
  fMinY := 0;
  fMaxY := 0;
end;

destructor TePadData.Destroy;
begin
  Clear;
  fList.Free;
  inherited;
end;

function TePadData.GetCount: integer;
begin
  result := fList.Count;
end;

function TePadData.GetItem(idx: integer): TPoint;
begin
  result:= PPoint(fList[idx])^;
end;

end.
