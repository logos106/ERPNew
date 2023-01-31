unit frmSiteIntegrationLinesReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, DAScript, MyScript, ERPdbComponents, DB,
  kbmMemTable,  Menus, AdvMenus, ProgressDialog, DBAccess,
  MyAccess, MemDS, ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList,
  PrintDAT, ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader,
  DNMPanel;

type
  TfmSiteIntegrationLinesReport = class(TBaseListingGUI)
    qryMainLogTime: TDateTimeField;
    qryMainLogType: TWideStringField;
    qryMainLogText: TWideMemoField;
    procedure FormCreate(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject); override;
  private
    FLogType: string;
    FParentId: integer;
    procedure SetLogType(const Value: string);
    procedure SetParentId(const Value: integer);
    { Private declarations }
  protected
    procedure RefreshQuery; override;
  public
    property ParentId: integer read FParentId write SetParentId;
    property LogType: string read FLogType write SetLogType;
  end;

var
  fmSiteIntegrationLinesReport: TfmSiteIntegrationLinesReport;

implementation

uses
  CommonDbLib, DbConst;

{$R *.dfm}

{ TfmSiteIntegrationLinesReport }

procedure TfmSiteIntegrationLinesReport.FormCreate(Sender: TObject);
begin
  inherited;
  MyConnection1.Server := CommonDbLib.GetSharedMyDacConnection.Server;
  MyConnection1.Username := CommonDbLib.GetSharedMyDacConnection.Username;
  MyConnection1.Password := CommonDbLib.GetSharedMyDacConnection.Password;
  MyConnection1.Database := 'services';
  MyConnection1.Options.Compress:= MYDAC_OPTIONS_COMPRESS;
  MyConnection1.Options.Protocol:= MYDAC_OPTIONS_PROTOCOL;
  MyConnection1.Port := CommonDbLib.GetSharedMyDacConnection.Port;
  qryMain.Connection:= MyConnection1;
end;

procedure TfmSiteIntegrationLinesReport.grdMainDblClick(Sender: TObject);
begin
  if grdMain.SelectedField.Name = 'qryMainLogText' then begin

  end
  else
    inherited;

end;

procedure TfmSiteIntegrationLinesReport.RefreshQuery;
begin
  qryMain.ParamByName('ParentId').AsInteger:= fParentId;
  qryMain.ParamByName('LogType').AsString:= fLogType;
  inherited;
end;

procedure TfmSiteIntegrationLinesReport.SetLogType(const Value: string);
begin
  FLogType := Value;
end;

procedure TfmSiteIntegrationLinesReport.SetParentId(const Value: integer);
begin
  FParentId := Value;
end;

end.
