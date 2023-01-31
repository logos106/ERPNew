unit frmButtonArray;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ActnList, AdvSmoothButton, JsonObject;

type
  TfmButtonArray = class(TForm)
    pnlButtonArray: TPanel;
    ActionList1: TActionList;
    actCustomise: TAction;
    pnlOptions: TPanel;
    pnlButtons: TPanel;
    btnCustomise: TAdvSmoothButton;
    actHome: TAction;
    btnHome: TAdvSmoothButton;
    procedure actCustomiseExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Config: TJsonObject;
    procedure LoadConfig;
    procedure SaveConfig;
  public
    { Public declarations }
  end;

var
  fmButtonArray: TfmButtonArray;

implementation

{$R *.dfm}

uses
  frmButtonArrayCustomise;

procedure TfmButtonArray.actCustomiseExecute(Sender: TObject);
begin
  if frmButtonArrayCustomise.DoCustomiseButtons(Config) then begin
    SaveConfig;

  end;
end;

procedure TfmButtonArray.FormCreate(Sender: TObject);
begin
  inherited;
  Config:= TJsonObject.Create;
  LoadConfig;
end;

procedure TfmButtonArray.FormDestroy(Sender: TObject);
begin
  inherited;
  Config.Free;
end;

procedure TfmButtonArray.LoadConfig;
begin
  Config.LoadFromFile(ExtractFilePath(Application.ExeName)+ 'ButtonArrayConfig.txt');
end;

procedure TfmButtonArray.SaveConfig;
begin
  Config.SaveToFile(ExtractFilePath(Application.ExeName)+ 'ButtonArrayConfig.txt');
end;

end.
