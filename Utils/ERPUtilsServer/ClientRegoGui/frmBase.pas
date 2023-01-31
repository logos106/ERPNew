unit frmBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TfmBase = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  protected
    LoadingConfig: integer;
    AutoReopen: boolean;
    procedure LoadConfig; virtual;
    procedure SaveConfig; virtual;
  public
    procedure RefreshData; virtual;
    procedure Close(Reopen: boolean); overload;
  end;

var
  fmBase: TfmBase;

implementation

{$R *.dfm}

uses
  AppConfigObj;

procedure TfmBase.Close(Reopen: boolean);
begin
  AppConfig.Data.O[ClassName].B['reopen']:= Reopen;
  inherited Close;
end;

procedure TfmBase.FormCreate(Sender: TObject);
begin
  LoadingConfig:= 0;
  AutoReopen:= false;
  inherited;
  LoadConfig;
end;

procedure TfmBase.FormDestroy(Sender: TObject);
begin
  SaveConfig;
  inherited;
end;

procedure TfmBase.LoadConfig;
begin
  Inc(LoadingConfig);
  try
    Left:= AppConfig.Data.O[ClassName].I['left'];
    Top:= AppConfig.Data.O[ClassName].I['top'];
    if AppConfig.Data.O[ClassName].I['width'] > 0 then
      Width:= AppConfig.Data.O[ClassName].I['width'];
    if AppConfig.Data.O[ClassName].I['height'] > 0 then
      Height:= AppConfig.Data.O[ClassName].I['height'];
  finally
    Dec(LoadingConfig);
  end;  
end;

procedure TfmBase.RefreshData;
begin

end;

procedure TfmBase.SaveConfig;
begin
  AppConfig.Data.O[ClassName].I['left']:= Left;
  AppConfig.Data.O[ClassName].I['top']:= Top;
  AppConfig.Data.O[ClassName].I['width']:= Width;
  AppConfig.Data.O[ClassName].I['height']:= Height;
  AppConfig.Data.O[ClassName].B['autoreopen']:= AutoReopen;
end;

end.
