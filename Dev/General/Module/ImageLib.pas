unit ImageLib;

interface
  Procedure RotateImage(const ImagefileName:String);

implementation

uses Graphics, FlipReverseRotateLibrary;

procedure RotateImage(const ImagefileName: String);
var
  BitmapOriginal   :  TBitmap;
  BitmapFlipReverse:  TBitmap;
begin
    BitmapOriginal := TBitmap.Create;
    BitmapOriginal.LoadFromFile(ImagefileName);
    BitmapFlipReverse := FlipReverseCopyRect( False,False,BitmapOriginal);
    BitmapFlipReverse.SaveToFile(ImagefileName);
end;

end.

