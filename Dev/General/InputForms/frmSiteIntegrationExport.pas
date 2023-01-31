unit frmSiteIntegrationExport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, ExtCtrls, StdCtrls,
  SiteIntegrationObj;

type
  TfmSiteIntegrationExport = class(TBaseInputGUI)
    pnlBottom: TPanel;
    btnExport: TButton;
    procedure btnExportClick(Sender: TObject);
    procedure DoOnProcessProgress(aCaption, aMsg: string; aCount, aCountTotal: integer);
  private
    ProgDialog: TProgressDialog;
  public
    { Public declarations }
  end;

var
  fmSiteIntegrationExport: TfmSiteIntegrationExport;

implementation

uses
  CommonDbLib;

{$R *.dfm}

procedure TfmSiteIntegrationExport.btnExportClick(Sender: TObject);
var
  SiteInt: TSiteIntegration;
begin
  inherited;
  SiteInt := TSiteIntegration.Create;
  try
    SiteInt.Connection := CommonDbLib.GetSharedMyDacConnection;
    SiteInt.OnProgress := DoOnProcessProgress;
    SiteInt.ExportData;
    ProgDialog.Free;
    ProgDialog := nil;
  finally
    SiteInt.Free;
  end;

end;

procedure TfmSiteIntegrationExport.DoOnProcessProgress(aCaption, aMsg: string;
  aCount, aCountTotal: integer);
begin
  if not Assigned(ProgDialog) then begin
    ProgDialog := TProgressDialog.Create(nil);
    ProgDialog.Step := 1;
    ProgDialog.Caption := aCaption;
    ProgDialog.Message := aMsg;
    ProgDialog.MaxValue := aCountTotal;
    ProgDialog.Value := aCount;
    ProgDialog.Execute;
  end
  else begin
    ProgDialog.Caption := aCaption;
    ProgDialog.Message := aMsg;
    ProgDialog.MaxValue := aCountTotal;
    ProgDialog.Value := aCount;
  end;


end;

initialization
  RegisterClass(TfmSiteIntegrationExport);

end.
