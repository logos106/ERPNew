unit datImages;

interface

uses
  SysUtils, Classes, ImgList, Controls;

type
  TdmImages = class(TDataModule)
    ImageList: TImageList;
    SmlImageList: TImageList;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmImages: TdmImages;

implementation
{$R *.dfm}

initialization

  dmImages:=TdmImages.Create(nil);
finalization
  dmImages.Free;



end.
