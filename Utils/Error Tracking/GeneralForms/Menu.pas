unit Menu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, rwButtonArray, ExtCtrls, DNMPanel, ComCtrls,
  BaseForm, AdvPageControl, Shader, DNMSpeedButton, AdvReflectionLabel;

type
  TMenuGUI = class(TBaseFormGUI)
    Title: TAdvReflectionLabel;
    Panel1: TPanel;
    btnExit: TDNMSpeedButton;
    pnlButtons: TPanel;
    Shader1: TShader;
    pnlActivePage: TLabel;
    btnDownload: TDNMSpeedButton;
    btnErrList: TDNMSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnErrListClick(Sender: TObject);
    procedure btnDownloadClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MenuGUI: TMenuGUI;

implementation

uses Main,FuncLib,GraphUtil;

{$R *.dfm}

procedure TMenuGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  MenuGUI := nil;
end;

procedure TMenuGUI.btnExitClick(Sender: TObject);
begin
  inherited;
  MainGUI.Exit1Click(Sender);
end;

procedure TMenuGUI.FormShow(Sender: TObject);
begin
  inherited;
  pnlButtons.Color := ColorAdjustLuma(cDefaultGradientColor,cAdjustLuma div 2, False);
end;

procedure TMenuGUI.btnErrListClick(Sender: TObject);
begin
  inherited;
  MainGUI.ExceptionEmailList1.Click;

end;

procedure TMenuGUI.btnDownloadClick(Sender: TObject);
begin
  inherited;
  MainGUI.DownloadEmails1.Click;
end;

end.
