unit ImagesDatamodule;

interface

uses
  SysUtils, Classes, ImgList, Controls, dmImagesBase;

type
  TImgDatamodule = class(TDataModule)
  protected
//    fImageList: TImageList;
//    fImageListSmlIcons: TImageList;
    procedure DataModuleCreate(Sender: TObject);
  private
    fMap: TStringList;
    fImagesBase: TDM_ImagesBase;
//    procedure GetImageListsDLL;
    function GetImageList: TImageList;
    function getImageListSmlIcons: TImageList;
    procedure CreateImageBase;
    property Map : TStringList read fMap write fMap;
    property Images : TDM_ImagesBase read fImagesBase write fImagesBase;
  public
    constructor Create(AOwner : TComponent);override;
    destructor Destroy; override;
    property ImageList : TImageList read GetImageList;
    property ImageListSmlIcons: TImageList read getImageListSmlIcons;
  end;

Function ImgDatamodule : TImgDatamodule;

implementation

uses Forms, ImageDLLLib, AppEnvironment, tcDataUtils,
  dmImagesDefault, dmImagesSmiley, dmImagesGirly, dmImagesGlossy, dmImagesMisc, dmImagesSuperHero;

{$R *.dfm}

var
  fImgDatamodule: TImgDatamodule;

Function ImgDatamodule : TImgDatamodule;
begin
  if  fImgDatamodule = nil then
  begin
    fImgDatamodule :=TImgDatamodule.Create(Application);
  end;
  Result := fImgDatamodule;
end;

{ TImgDatamodule }

constructor TImgDatamodule.Create(AOwner: TComponent);
begin
  inherited;
  Map := ImageSchemeNames;
end;

procedure TImgDatamodule.CreateImageBase;
var
  idx : integer;
begin
  if assigned(Images) then
    exit;

  if not assigned(Map) or (Map.Count <= 0) then
    idx := 0
  else begin
    idx := Map.IndexOf(Appenv.Employee.ImageScheme);
    if idx < 0 then
      idx := 0;
    idx := integer(Map.Objects[idx]);
  end;

  case idx of
    1 : Images := Tdm_ImagesDefault.Create(self);
    2 : Images := Tdm_ImagesGirly.Create(Self);
    3 : Images := Tdm_ImagesGlossy.Create(Self);
    4 : Images := Tdm_ImagesMisc.Create(Self);
    5 : Images := Tdm_ImagesSmiley.Create(Self);
    6 : Images := Tdm_ImagesSuperHero.Create(Self);
    else
        Images := Tdm_ImagesGirly.Create(Self);;  // make compiler happy
  end;
end;

procedure TImgDatamodule.DataModuleCreate(Sender: TObject);
begin
//  GetImageListsDLL;
  Map := ImageSchemeNames;
end;

destructor TImgDatamodule.Destroy;
begin
  FreeAndNil(fMap);
  FreeAndNil(fImagesBase);
  inherited;
end;

function TImgDatamodule.GetImageList: TImageList;
begin
  CreateImageBase;
  Result := Images.ImageList;
end;
(*
procedure TImgDatamodule.GetImageListsDLL;
begin
  ImageDLL.Images_ResToImageList(IMageList, true);
  ImageDLL.Images_ResToImageList(IMageListSmlIcons, False);
end;
*)
function TImgDatamodule.getImageListSmlIcons: TImageList;
begin
  CreateImageBase;
  Result := Images.ImageListSmlIcons;
end;

initialization
  fImgDatamodule := nil
Finalization
//  FreeAndNil(fImgDataModule);
end.
