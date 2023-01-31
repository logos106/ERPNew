unit dmImagesBase;

interface

uses
  SysUtils, Classes, ImgList, Controls;

type
  Tdm_ImagesBase = class(TDataModule)
  protected
    function GetImageList: TImageList;virtual;abstract;
    function GetImageListSmlIcons: TImageList;virtual;abstract;
    { Private declarations }

  public
    { Public declarations }
    property ImageList : TImageList read GetImageList;
    property ImageListSmlIcons : TImageList read GetImageListSmlIcons;
  end;


implementation

{$R *.dfm}

{ Tdm_ImagesBase }


end.
