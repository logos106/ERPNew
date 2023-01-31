unit frmAuditExportPerge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, MemDS, DBAccess, MyAccess, ERPdbComponents,
  ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls,
  ComCtrls, AdvProgr, StdCtrls, wwdbdatetimepicker, DNMSpeedButton, Shader,
  DNMPanel, AdvProgressBar, BusObjAudit, ProgressDialog;

type
  TfmAuditExportPerge = class(TBaseInputGUI)
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    dtTo: TwwDBDateTimePicker;
    chkExport: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    chkPurge: TCheckBox;
    edtExport: TEdit;
    Label4: TLabel;
    dlgSave: TSaveDialog;
    btnFile: TButton;
    ProgBar: TAdvProgressBar;
    lblMessage: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnFileClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Audit: TAudit;
    function GetExportAudit: boolean;
    function GetPurgeAudit: boolean;
    procedure SetExportAudit(const Value: boolean);
    procedure SetPurgeAudit(const Value: boolean);
    procedure SetupDisplay;
    procedure DoOnExportProgress(Sender: TObject);
  public
    property ExportAudit: boolean read GetExportAudit write SetExportAudit;
    property PurgeAudit: boolean read GetPurgeAudit write SetPurgeAudit;
  end;

var
  fmAuditExportPerge: TfmAuditExportPerge;

implementation

uses
  CommonLib, CommonDbLib, BusObjBase, DnMLib, AuditTrailPurgeObj;

{$R *.dfm}

procedure TfmAuditExportPerge.btnCancelClick(Sender: TObject);
begin
  inherited;
  if Assigned(Audit) and Audit.ProcessActive then
    Audit.ProcessActive := false
  else
    Close;
end;

procedure TfmAuditExportPerge.btnFileClick(Sender: TObject);
begin
  inherited;
  if dlgSave.Execute then
    edtExport.Text := dlgSave.FileName;

end;

procedure TfmAuditExportPerge.btnOkClick(Sender: TObject);
var
  msg: string;
begin
  inherited;
  ProgBar.Position := 0;
  if not (ExportAudit or PurgeAudit) then begin
    CommonLib.MessageDlgXP_Vista('Please select Export Audit Trail and/or Purge Audit Trail',mtInformation,[mbOk],0);
    exit;
  end;
  if ExportAudit and (edtExport.Text = '') then begin
    CommonLib.MessageDlgXP_Vista('Please select a file you would like to export the Audit Trail to',mtInformation,[mbOk],0);
    exit;
  end;
  if PurgeAudit then begin
    if MessageDlgXP_Vista('This will permently delete all of your Audit Trail data prior to ' + DateToStr(dtTo.Date) + ', is that what you want to do?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
      exit
  end;
  Audit:= TAudit.Create(nil);
  try
    Audit.Connection := TMyDacDataConnection.Create(Audit);
    Audit.Connection.Connection := CommonDbLib.GetSharedMyDacConnection;
    Audit.OnExportProgres := DoOnExportProgress;
    if ExportAudit then begin
      if FileExists(edtExport.Text) then begin
        if MessageDlgXP_Vista('The file already exists, is it ok to delete the existing file?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
          exit
        else begin
          DeleteFile(edtExport.Text);
        end;
      end;
      if not Audit.ExportData(0,dtTo.Date,edtExport.Text,msg) then begin
        MessageDlgXP_Vista('Export failed: ' + msg,mtWarning,[mbOk],0);
        exit;
      end;
    end;
    if PurgeAudit then begin
      lblMessage.Caption := 'Purging Audit Trail ..';
      ProgBar.Position:= 50;
      if not Audit.PurgeData(0,dtTo.Date,msg) then begin
        MessageDlgXP_Vista('Purge failed: ' + msg,mtWarning,[mbOk],0);
        exit;
      end;
    end;
  finally
    Audit.Free;
    Audit:= nil;
  end;
  ProgBar.Position := 100;
  lblMessage.Caption := 'Done.';
  MessageDlgXP_Vista('All Done',mtInformation,[mbOk],0);
end;

procedure TfmAuditExportPerge.DoOnExportProgress(Sender: TObject);
begin
  ProgBar.Position := Trunc((TAuditTrailPurge(Sender).RecordNumber / TAuditTrailPurge(Sender).RecordCount) * 100);
  lblMessage.Caption := TAuditTrailPurge(Sender).CurrentProcess;
  Application.ProcessMessages;
end;

procedure TfmAuditExportPerge.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TfmAuditExportPerge.FormCreate(Sender: TObject);
begin
  inherited;

  ProgBar.Level0Color  := clLime;
  ProgBar.Level0ColorTo:= $00E1FFE1;
  ProgBar.Level1Color  := clLime;
  ProgBar.Level1ColorTo:= $00CAFFFF;
  ProgBar.Level2Color  := clLime;
  ProgBar.Level2ColorTo:= $00A8D3FF;
  ProgBar.Level3Color  := clLime;
  ProgBar.Level3ColorTo:= $00CACAFF;

  ProgBar.Position:= 0;

  dtTo.Date:= GetCurrentFiscalYearStart(now)-1;

end;

function TfmAuditExportPerge.GetExportAudit: boolean;
begin
  result := chkExport.Checked;
end;

function TfmAuditExportPerge.GetPurgeAudit: boolean;
begin
  result := chkPurge.Checked;
end;

procedure TfmAuditExportPerge.SetExportAudit(const Value: boolean);
begin
  chkExport.Checked := Value;
  SetupDisplay;
end;

procedure TfmAuditExportPerge.SetPurgeAudit(const Value: boolean);
begin
  chkPurge.Checked := Value;
end;

procedure TfmAuditExportPerge.SetupDisplay;
begin
  edtExport.Enabled := ExportAudit;
  btnFile.Enabled := ExportAudit;
end;

initialization
  RegisterClass(TfmAuditExportPerge);

end.
