unit frmOffsiteBackupMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmStandAloneConfigBase, DNMSpeedButton, StdCtrls, ExtCtrls,
  DNMPanel, OffsiteBackupConfigObj, OffsiteRestoreConfigObj, CheckLst, ComCtrls,
  ActnList;

type
  TfmOffsiteBackupConfig = class(TfmStandAloneConfigBase)
    PageControl1: TPageControl;
    tabBackup: TTabSheet;
    tabRestore: TTabSheet;
    pnlBackup: TDNMPanel;
    rgOffsiteBackupTargetType: TRadioGroup;
    chkEnableOffsiteBackup: TCheckBox;
    pnlFTPServer: TDNMPanel;
    Label1: TLabel;
    Label154: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edtFTPHost: TEdit;
    edtFTPUser: TEdit;
    edtFTPPass: TEdit;
    pnlDatabaseList: TDNMPanel;
    Label4: TLabel;
    lstDbList: TCheckListBox;
    pnlRestore: TDNMPanel;
    Label5: TLabel;
    edtFTPPath: TEdit;
    chkEnableOffsiteRestore: TCheckBox;
    DNMPanel1: TDNMPanel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    edtRestoreFTPHost: TEdit;
    edtRestoreFTPUser: TEdit;
    edtRestoreFTPPass: TEdit;
    edtRestoreFTPPath: TEdit;
    DNMPanel2: TDNMPanel;
    Label11: TLabel;
    Label12: TLabel;
    edtRestoreLocalPath: TEdit;
    btnRestoreLocalPath: TDNMSpeedButton;
    lstRestoreDb: TCheckListBox;
    lblMsg2: TLabel;
    lblMsg1: TLabel;
    pnlTime: TDNMPanel;
    Label13: TLabel;
    dtRestoreTimeEnd: TDateTimePicker;
    Label14: TLabel;
    Label15: TLabel;
    dtRestoreTimeStart: TDateTimePicker;
    Label16: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chkEnableOffsiteBackupClick(Sender: TObject);
    procedure rgOffsiteBackupTargetTypeClick(Sender: TObject);
    procedure edtFTPHostChange(Sender: TObject);
    procedure edtFTPUserChange(Sender: TObject);
    procedure edtFTPPassChange(Sender: TObject);
    procedure lstDbListClickCheck(Sender: TObject);
    procedure edtFTPPathChange(Sender: TObject);
    procedure chkEnableOffsiteRestoreClick(Sender: TObject);
    procedure edtRestoreFTPHostChange(Sender: TObject);
    procedure edtRestoreFTPUserChange(Sender: TObject);
    procedure edtRestoreFTPPathChange(Sender: TObject);
    procedure edtRestoreFTPPassChange(Sender: TObject);
    procedure edtRestoreLocalPathChange(Sender: TObject);
    procedure btnRestoreLocalPathClick(Sender: TObject);
    procedure lstRestoreDbClickCheck(Sender: TObject);
    procedure dtRestoreTimeStartChange(Sender: TObject);
    procedure dtRestoreTimeEndChange(Sender: TObject);
    procedure dtRestoreTimeEndCloseUp(Sender: TObject);
    procedure dtRestoreTimeStartCloseUp(Sender: TObject);
  private
    OffsiteBackupConfig: TOffsiteBackupConfig;
    OffsiteRestoreConfig: TOffsiteRestoreConfig;
    procedure GetDatabaseList;
    procedure Load;
  protected
    function Validate: boolean; override;
  public
    { Public declarations }
  end;

var
  fmOffsiteBackupConfig: TfmOffsiteBackupConfig;

implementation

uses
  JsonObject, LogMessageTypes, StdActns, InstallConst;

{$R *.dfm}

procedure TfmOffsiteBackupConfig.btnRestoreLocalPathClick(Sender: TObject);
begin
  with TFileOpenDialog.Create(nil) do try
    Options := [fdoPickFolders];
    DefaultFolder  := ERP_SERVER_ROOT_DIR + ERP_BACKUP_DIR;
    FormStyle := fsNormal;
    if Execute then begin
      edtRestoreLocalPath.Text := FileName;
    end;
    FormStyle := fsStayOnTop;
  finally
    Free;
  end;
end;

procedure TfmOffsiteBackupConfig.chkEnableOffsiteBackupClick(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  OffsiteBackupConfig.OffsiteBackupEnabled := chkEnableOffsiteBackup.Checked;
end;

procedure TfmOffsiteBackupConfig.chkEnableOffsiteRestoreClick(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  OffsiteRestoreConfig.OffsiteRestoreEnabled := chkEnableOffsiteRestore.Checked;

end;

procedure TfmOffsiteBackupConfig.dtRestoreTimeEndChange(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  OffsiteRestoreConfig.TimeEnd := TDateTimePicker(Sender).Time;
end;

procedure TfmOffsiteBackupConfig.dtRestoreTimeEndCloseUp(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  TDateTimePicker(Sender).OnChange(Sender);
end;

procedure TfmOffsiteBackupConfig.dtRestoreTimeStartChange(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  OffsiteRestoreConfig.TimeStart := TDateTimePicker(Sender).Time;
end;

procedure TfmOffsiteBackupConfig.dtRestoreTimeStartCloseUp(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  TDateTimePicker(Sender).OnChange(Sender);
end;

procedure TfmOffsiteBackupConfig.edtFTPHostChange(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  OffsiteBackupConfig.FTPHost := TEdit(Sender).Text;
end;

procedure TfmOffsiteBackupConfig.edtFTPPassChange(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  OffsiteBackupConfig.FTPPass := TEdit(Sender).Text;
end;

procedure TfmOffsiteBackupConfig.edtFTPPathChange(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  OffsiteBackupConfig.FTPPath := TEdit(Sender).Text;
end;

procedure TfmOffsiteBackupConfig.edtFTPUserChange(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  OffsiteBackupConfig.FTPUser := TEdit(Sender).Text;
end;

procedure TfmOffsiteBackupConfig.edtRestoreFTPHostChange(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  OffsiteRestoreConfig.FTPHost := TEdit(Sender).Text;
end;

procedure TfmOffsiteBackupConfig.edtRestoreFTPPassChange(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  OffsiteRestoreConfig.FTPPass := TEdit(Sender).Text;
end;

procedure TfmOffsiteBackupConfig.edtRestoreFTPPathChange(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  OffsiteRestoreConfig.FTPPath := TEdit(Sender).Text;
end;

procedure TfmOffsiteBackupConfig.edtRestoreFTPUserChange(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  OffsiteRestoreConfig.FTPUser := TEdit(Sender).Text;
end;

procedure TfmOffsiteBackupConfig.edtRestoreLocalPathChange(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  OffsiteRestoreConfig.LocalPath := TEdit(Sender).Text;
end;

procedure TfmOffsiteBackupConfig.FormCreate(Sender: TObject);
begin
  inherited;
  PageControl1.ActivePageIndex := 0;
  OffsiteBackupConfig := TOffsiteBackupConfig.Create;
  OffsiteRestoreConfig := TOffsiteRestoreConfig.Create;
  OffsiteBackupConfig.AsString := Params.S['OffsiteBackupConfigText'];
  OffsiteRestoreConfig.AsString := Params.S['OffsiteRestoreConfigText'];
  if Params.IntegerExists('Color') then begin
    pnlBackup.Color := self.Color;
    pnlRestore.Color := self.Color;
    pnlTime.Color := self.Color;
  end;

  Load;
end;

procedure TfmOffsiteBackupConfig.FormDestroy(Sender: TObject);
begin
  OffsiteBackupConfig.Free;
  OffsiteRestoreConfig.Free;
  inherited;
end;

procedure TfmOffsiteBackupConfig.GetDatabaseList;
var
  j: TJsonObject;
  x: integer;
begin
  if not UtilsClient.Connected then begin
    Log('Utils Client is not connected',ltError);
    exit;
  end;
  j := UtilsClient.Client.SendRequest('ERPModUserUtils.getdatabaselist',nil);
  if Assigned(j) then begin
    try
      //Log('found databasses: ' + j.S['result']);
      if j.StringExists('result') then begin
        lstDbList.Items.CommaText := j.S['result'];
        lstRestoreDb.Items.CommaText := j.S['result'];

        for x := 0 to lstDbList.Items.Count -1 do begin
          if OffsiteBackupConfig.DatabaseItems.IndexOf(lstDbList.Items[x]) > -1 then
            lstDbList.Checked[x] := true;
        end;

        for x := 0 to lstRestoreDb.Items.Count -1 do begin
          if OffsiteRestoreConfig.DatabaseItems.IndexOf(lstRestoreDb.Items[x]) > -1 then
            lstRestoreDb.Checked[x] := true;
        end;
      end;
    finally
      j.Free;
    end;
  end
  else begin
    { nothing returned }
    Log('Nothing returned for db list', ltError);
  end;
end;

procedure TfmOffsiteBackupConfig.Load;
begin
  Loading := true;
  try
    { offsite backup options }
    GetDatabaseList;
    chkEnableOffsiteBackup.Checked := OffsiteBackupConfig.OffsiteBackupEnabled;
    rgOffsiteBackupTargetType.ItemIndex := Ord(OffsiteBackupConfig.OffsiteBackupTarget);
    edtFTPHost.Text := OffsiteBackupConfig.FTPHost;
    edtFTPPath.Text := OffsiteBackupConfig.FTPPath;
    edtFTPUser.Text := OffsiteBackupConfig.FTPUser;
    edtFTPPass.Text := OffsiteBackupConfig.FTPPAss;
    pnlFTPServer.Enabled := OffsiteBackupConfig.OffsiteBackupTarget = obCustomServer;
    lblMsg1.Visible := OffsiteBackupConfig.OffsiteBackupTarget = obCustomServer;

    { offsite restore options }
    chkEnableOffsiteRestore.Checked := OffsiteRestoreConfig.OffsiteRestoreEnabled;
    edtRestoreFTPHost.Text := OffsiteRestoreConfig.FTPHost;
    edtRestoreFTPPath.Text := OffsiteRestoreConfig.FTPPath;
    edtRestoreFTPUser.Text := OffsiteRestoreConfig.FTPUser;
    edtRestoreFTPPass.Text := OffsiteRestoreConfig.FTPPAss;
    edtRestoreLocalPath.Text := OffsiteRestoreConfig.LocalPath;
    dtRestoreTimeStart.Time := OffsiteRestoreConfig.TimeStart;
    dtRestoreTimeEnd.Time := OffsiteRestoreConfig.TimeEnd;
    //lstRestoreDb.Items.CommaText := OffsiteRestoreConfig.DatabaseList;
  finally
    Loading := false;
  end;
end;

procedure TfmOffsiteBackupConfig.lstDbListClickCheck(Sender: TObject);
var
  x: integer;
begin
  inherited;
  if Loading then Exit;
  OffsiteBackupConfig.DatabaseItems.Clear;
  for x := 0 to lstDbList.Items.Count -1 do begin
    if lstDbList.Checked[x] then
      OffsiteBackupConfig.DatabaseItems.Add(lstDbList.Items[x]);
  end;
end;

procedure TfmOffsiteBackupConfig.lstRestoreDbClickCheck(Sender: TObject);
var
  x: integer;
begin
  inherited;
  if Loading then Exit;
  OffsiteRestoreConfig.DatabaseItems.Clear;
  for x := 0 to lstRestoreDb.Items.Count -1 do begin
    if lstRestoreDb.Checked[x] then
      OffsiteRestoreConfig.DatabaseItems.Add(lstRestoreDb.Items[x]);
  end;
end;

procedure TfmOffsiteBackupConfig.rgOffsiteBackupTargetTypeClick(
  Sender: TObject);
begin
  inherited;
  if Loading then exit;
  OffsiteBackupConfig.OffsiteBackupTarget := TOffsiteBackupTargetType(rgOffsiteBackupTargetType.ItemIndex);
  if OffsiteBackupConfig.OffsiteBackupTarget = obERPServer then begin
    edtFTPHost.Text := '[ERP Server]';
    edtFTPHost.OnChange(edtFTPHost);
    edtFTPUser.Text := '';
    edtFTPUser.OnChange(edtFTPUser);
    edtFTPPass.Text := '';
    edtFTPPass.OnChange(edtFTPPass);
    edtFTPPath.Text := '';
    edtFTPPath.OnChange(edtFTPPath);
  end;

  pnlFTPServer.Enabled := OffsiteBackupConfig.OffsiteBackupTarget = obCustomServer;
  lblMsg1.Visible := OffsiteBackupConfig.OffsiteBackupTarget = obCustomServer;
end;

function TfmOffsiteBackupConfig.Validate: boolean;
begin
  result := inherited;
  Params.S['OffsiteBackupConfigText'] := OffsiteBackupConfig.AsString;
  Params.S['OffsiteRestoreConfigText'] := OffsiteRestoreConfig.AsString;
end;

end.
