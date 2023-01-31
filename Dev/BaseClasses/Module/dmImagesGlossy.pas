unit dmImagesGlossy;

interface

uses
  SysUtils, Classes, ImgList, Controls, dmImagesBase, PngImageList;

type
  Tdm_ImagesGlossy = class(Tdm_ImagesBase)
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

implementation

{$R *.dfm}

{ Tdm_ImagesGlossy }

function Tdm_ImagesGlossy.GetImageList: TImageList;
begin
  Result := BigIcons;
end;

function Tdm_ImagesGlossy.GetImageListSmlIcons: TImageList;
begin
  Result := SmallIcons;
end;

end.
