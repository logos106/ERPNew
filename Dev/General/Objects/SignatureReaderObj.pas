unit SignatureReaderObj;

interface

uses
  Graphics, ExtCtrls;

type
  TSignatureReader = class(TObject)
  private
  protected
    fImage: TImage;
    procedure SetImage(const Value: TImage); virtual;
    function GetActive: boolean; virtual;
    procedure SetActive(const Value: boolean); virtual;
    function IsGUI: boolean;
    function GetIsBlank: boolean; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property Image: TImage read fImage write SetImage;
    property Active: boolean read GetActive write SetActive;
    procedure Clear; virtual;
    property IsBlank: boolean read GetIsBlank;
  end;




implementation

uses
  Types, Forms;

{ TSignatureReader }

procedure TSignatureReader.Clear;
begin
  if Assigned(fImage) then begin
//    fImage.Canvas.Brush.Color := clWhite;
//    fImage.Canvas.FillRect(Rect(0,0,fImage.Width,fImage.Height));
    fImage.Picture.Assign(nil);
//    fImage.Repaint;
//    fImage.Canvas.Pen.Color := clBlack;
//    fImage.Canvas.Pen.Width := 2;
//    fImage.Canvas.MoveTo(0,0);
  end;

end;

constructor TSignatureReader.Create;
begin

end;

destructor TSignatureReader.Destroy;
begin

  inherited;
end;

function TSignatureReader.GetActive: boolean;
begin
  result := false;
end;

function TSignatureReader.GetIsBlank: boolean;
begin
  result := true;
end;

function TSignatureReader.IsGUI: boolean;
begin
  result := Assigned(Application.MainForm);
end;

procedure TSignatureReader.SetActive(const Value: boolean);
begin

end;

procedure TSignatureReader.SetImage(const Value: TImage);
begin
  fImage := Value;
end;

end.
