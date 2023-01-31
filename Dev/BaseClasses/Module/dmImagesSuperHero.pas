unit dmImagesSuperHero;

interface

uses
  SysUtils, Classes, ImgList, Controls, dmImagesBase, PngImageList;

type
  Tdm_ImagesSuperHero = class(Tdm_ImagesBase)
    BigIcons: TPngImageList;
    SmallIcons: TPngImageList;
  private
    { Private declarations }
  protected
    function GetImageList: TImageList;override;
    function GetImageListSmlIcons: TImageList;override;
  public
    { Public declarations }
  end;

var
  dm_ImagesSuperHero: Tdm_ImagesSuperHero;

implementation

{$R *.dfm}

{ Tdm_ImagesSuperHero }

function Tdm_ImagesSuperHero.GetImageList: TImageList;
begin
  Result := BigIcons;
end;

function Tdm_ImagesSuperHero.GetImageListSmlIcons: TImageList;
begin
  Result := SmallIcons;
end;

end.
