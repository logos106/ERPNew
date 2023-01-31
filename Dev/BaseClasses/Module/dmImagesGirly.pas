unit dmImagesGirly;

interface

uses
  SysUtils, Classes, ImgList, Controls, dmImagesBase, PngImageList;

type
  Tdm_ImagesGirly = class(Tdm_ImagesBase)
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

{ TDataModule2 }

function Tdm_ImagesGirly.GetImageList: TImageList;
begin
  Result := BigIcons;
end;

function Tdm_ImagesGirly.GetImageListSmlIcons: TImageList;
begin
  Result := SmallIcons;
end;

end.
