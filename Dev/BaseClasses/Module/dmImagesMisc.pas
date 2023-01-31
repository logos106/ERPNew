unit dmImagesMisc;

interface

uses
  SysUtils, Classes, ImgList, Controls,dmImagesBase, PngImageList;

type
  Tdm_ImagesMisc = class(Tdm_ImagesBase)
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

{ Tdm_ImagesMisc }

function Tdm_ImagesMisc.GetImageList: TImageList;
begin
  Result := BigIcons;
end;

function Tdm_ImagesMisc.GetImageListSmlIcons: TImageList;
begin
  Result := SmallIcons;
end;

end.
