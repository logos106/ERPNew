unit dmImagesSmiley;

interface

uses
  SysUtils, Classes, ImgList, Controls, dmImagesBase, PngImageList;

type
  Tdm_ImagesSmiley = class(TDm_ImagesBase)
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

{ Tdm_ImagesSmiley }

function Tdm_ImagesSmiley.GetImageList: TImageList;
begin
  Result := BigIcons;
end;

function Tdm_ImagesSmiley.GetImageListSmlIcons: TImageList;
begin
  Result := SmallIcons;
end;

end.
