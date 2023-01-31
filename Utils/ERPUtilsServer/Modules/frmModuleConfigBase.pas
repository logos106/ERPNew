unit frmModuleConfigBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Shader, DNMPanel, Buttons, ComCtrls,
  ToolWin, ImgList, ModuleBaseClientObj;

type

  TfmModuleConfigBase = class(TForm)
    pnlMain: TPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    lblTitle: TLabel;
    pnlModuleButtons: TPanel;
    btnModule: TSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnModuleClick(Sender: TObject);
  private
    fModule: TModuleBaseClient;
  protected
    procedure SetModule(const Value: TModuleBaseClient); virtual;
  public
    property Module: TModuleBaseClient read fModule write SetModule;
    procedure DoOnModuleChange; virtual;
  end;

var
  fmModuleConfigBase: TfmModuleConfigBase;

implementation

{$R *.dfm}



procedure TfmModuleConfigBase.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action:= caFree;
end;

procedure TfmModuleConfigBase.btnModuleClick(Sender: TObject);
begin
  pnlMain.BringToFront;
end;

procedure TfmModuleConfigBase.DoOnModuleChange;
begin

end;

procedure TfmModuleConfigBase.SetModule(const Value: TModuleBaseClient);
begin
  fModule := Value;
end;

initialization

end.
