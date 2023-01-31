unit dmImagesDefault;

interface

uses
  SysUtils, Classes, ImgList, Controls, dmImagesBase, PngImageList;

type
  Tdm_ImagesDefault = class(Tdm_ImagesBase)
    BigIcons: TPngImageList;
    SmallIcons: TPngImageList;
  protected
    function GetImageList: TImageList;override;
    function GetImageListSmlIcons: TImageList;override;
  public

  end;

implementation

{$R *.dfm}

{ Tdm_ImagesDefault }


function Tdm_ImagesDefault.GetImageList: TImageList;
begin
  Result := BigIcons;
end;

function Tdm_ImagesDefault.GetImageListSmlIcons: TImageList;
begin
  Result := SmallIcons;
end;

end.
