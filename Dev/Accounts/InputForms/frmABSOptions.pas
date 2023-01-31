unit frmABSOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, DNMSpeedButton, Shader,
  DNMPanel;

type
  TfmABSOptions = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    cmdOk: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    optExportFileMode: TRadioGroup;
    procedure cmdOkClick(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
  private
    procedure setExportFileMode(const Value: Integer);
    function getExportFileMode: Integer;
  public
    Property ExportFileMode :Integer read getExportFileMode write setExportFileMode;
  end;

var
  fmABSOptions: TfmABSOptions;

implementation

uses CommonLib;

{$R *.dfm}

procedure TfmABSOptions.cmdCancelClick(Sender: TObject);
begin
  inherited;
  modalresult:= mrCancel;
end;

procedure TfmABSOptions.cmdOkClick(Sender: TObject);
begin
  inherited;
  modalresult:= mrOK;
end;

function TfmABSOptions.getExportFileMode: Integer;
begin
  result:=  optExportFileMode.itemindex +1;
end;

procedure TfmABSOptions.setExportFileMode(const Value: Integer);
begin
  optExportFileMode.itemindex := Value-1;
end;
Initialization
  RegisterClassOnce(TfmABSOptions);

end.

