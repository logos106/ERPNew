unit frmMain;

(*
  Will search for zip file containing "ERPInstallInfo.txt" ...
  This file should have the following structure:

  "InstallType","InstallDefault","FileName","InstallDisplayName","InstallDescription"
  eg
  Server,True,"Server_Setup.exe","ERP Server","ERP MySQL Server and database files"

  The files will be displayed in list and checked (ticked) items will be
  extracted and installed in sequence

*)


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DNMSpeedButton, StdCtrls,
  ExtCtrls, CheckLst, jpeg, ERPInstallerObj, ProgressDialog, ComCtrls,
  AdvWiiProgressBar, AdvProgressBar;

type
  TfmMain = class(TForm)
    pnlTop: TPanel;
    Image1: TImage;
    Label2: TLabel;
    btnServer: TDNMSpeedButton;
    btnClient: TDNMSpeedButton;
    edtServer: TEdit;
    bnlBottom: TPanel;
    btnClose: TDNMSpeedButton;
    btnCustom: TDNMSpeedButton;
    lblProgressCaption: TLabel;
    ProgressBar1: TAdvProgressBar;
    ProgressBar2: TAdvProgressBar;
    lblProgressMessage: TLabel;
    Timer1: TTimer;
    chkInstallVideos: TCheckBox;
    lblInstallVideos: TLabel;
    Timer2: TTimer;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnServerClick(Sender: TObject);
    procedure btnClientClick(Sender: TObject);
    procedure btnCustomClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    Installer: TERPInstaller;
//    ProgDlg: TProgressDialog;
    LastProgressMessage: string;
    ServerVideoName,
    ClientVideoName: string;
    procedure DoInstallProgress(const aCaption, aMessage: string;
                                     StepNo, StepCount: integer);
    procedure DoProgress(const aCaption, aMessage: string;
                                     StepNo, StepCount: integer);
    procedure PlayVideo(const aFileName: string);
    procedure DoUserInputRequired(const msg: string; var AbortInstall: boolean);

  public
    { Public declarations }
  end;


var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses
  Vista_MessageDlg, LogThreadLib, LogMessageTypes, frmVideoPlayer,
  frmInstallVideoChoice, frmSoftwareLicence, frm_InstallPath;


 { TfmMain }

procedure TfmMain.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  TLogger.Inst.LogAllTypes; //   LogMessageTypes:= [ltNone, ltError, ltWarning, ltInfo, ltDetail, ltBlank, ltDebug];
  TLogger.Inst.Active:= false; { turn off logging }
  Installer:= TERPInstaller.Create;
  Installer.OnProgress:= DoInstallProgress;
  Installer.OnUserInputRequired := DoUserInputRequired;
  TLogger.Inst.LogPath:= Installer.Path + 'Log\';
  lblProgressMessage.Caption:= '';
  if not FileExists(ExtractFilePath(Application.ExeName) + 'ERP_Videos_Setup.exe') then begin
    chkInstallVideos.Checked:= false;
    chkInstallVideos.Visible:= false;
    lblInstallVideos.Visible:= false;
  end;
  ServerVideoName:= Installer.Path + '0_ERP_Server.avi';
  ClientVideoName:= Installer.Path + '1_ERP_User.avi';
  self.Left:= 50;
  self.Top:= Trunc((Screen.Height - self.Height) / 2);
end;

procedure TfmMain.FormDestroy(Sender: TObject);
begin
  Installer.Free;
  DeleteFile(ServerVideoName);
  DeleteFile(ClientVideoName);
end;

procedure TfmMain.btnServerClick(Sender: TObject);
var
  msg: string;
begin
  if SelectInstallOption('Server') = 'Video' then begin
    PlayVideo(ServerVideoName);
    exit;
  end;

  if not SetFolders(tstServer) then
    exit;

  Installer.ERPServerName:= edtServer.Text;
  if Installer.DoInstall('Server',msg) then begin
    DoProgress('Done', '',0, 0);
    Vista_MessageDlg.MessageDlgXP_Vista('Install Complete!',mtInformation,[mbOk],0);
  end
  else begin
    DoProgress('Error', '',0, 0);
    Vista_MessageDlg.MessageDlgXP_Vista('Install Failed: ' + #13#10 + #13#10 +
      msg,mtWarning,[mbOk],0);
  end;
end;

procedure TfmMain.btnCustomClick(Sender: TObject);
var
  msg: string;
begin
  if MessageDlgXP_Vista('This will Re-Install the services on your server, '+
    'is that what you want to do?',mtConfirmation,[mbYes,mbNo],0) <> mrYes then
    exit;
  Installer.ERPServerName:= edtServer.Text;
  if Installer.DoInstall('Services',msg) then begin
    DoProgress('Done', '',0, 0);
    Vista_MessageDlg.MessageDlgXP_Vista('Install Complete!',mtInformation,[mbOk],0);
  end
  else begin
    DoProgress('Done', '',0, 0);
    Vista_MessageDlg.MessageDlgXP_Vista('Install Failed: ' + #13#10 + #13#10 +
      msg,mtWarning,[mbOk],0);
  end;
end;

procedure TfmMain.btnClientClick(Sender: TObject);
var
  msg: string;
begin
  if SelectInstallOption('Client') = 'Video' then begin
    PlayVideo(ClientVideoName);
    exit;
  end;

  if not SetFolders(tstUser) then
    exit;

  if Trim(edtServer.Text) = '' then begin
    Vista_MessageDlg.MessageDlgXP_Vista('Please Enter the Name of your ERP Server or the Server IP Address',mtInformation,[mbOk],0);
    edtServer.SetFocus;
    exit;
  end;
  Installer.ERPServerName:= edtServer.Text;
  if chkInstallVideos.Checked then begin
    if Installer.DoInstall('User And Videos',msg) then begin
      DoProgress('Done', '',0, 0);
      Vista_MessageDlg.MessageDlgXP_Vista('Install Complete!',mtInformation,[mbOk],0);
    end
    else begin
      DoProgress('Done', '',0, 0);
      Vista_MessageDlg.MessageDlgXP_Vista('Install Failed: ' + #13#10 + #13#10 +
        msg,mtWarning,[mbOk],0);
    end;
  end
  else begin
    if Installer.DoInstall('User',msg) then begin
      DoProgress('Done', '',0, 0);
      Vista_MessageDlg.MessageDlgXP_Vista('Install Complete!',mtInformation,[mbOk],0);
    end
    else begin
      DoProgress('Done', '',0, 0);
      Vista_MessageDlg.MessageDlgXP_Vista('Install Failed: ' + #13#10 + #13#10 +
        msg,mtWarning,[mbOk],0);
    end;
  end;
end;

procedure TfmMain.DoInstallProgress(const aCaption, aMessage: string;
  StepNo, StepCount: integer);
begin
  DoProgress(aCaption, aMessage,StepNo, StepCount);
end;


procedure TfmMain.DoProgress(const aCaption, aMessage: string; StepNo,
  StepCount: integer);
begin
  lblProgressCaption.Caption:= aCaption;
  lblProgressMessage.Caption:= aMessage;
  if (StepNo = 0) and (StepCount = 0) then begin
    ProgressBar1.Position:= 0;
    ProgressBar2.Position:= 0;
  end
  else begin
    if LastProgressMessage <> aMessage then begin
      LastProgressMessage:= aMessage;
      ProgressBar2.Position:= 0;
    end;
    ProgressBar1.Position:= Trunc((StepNo/StepCount) * 100);
  end;
end;

procedure TfmMain.DoUserInputRequired(const msg: string;
  var AbortInstall: boolean);
begin
  if Vista_MessageDlg.MessageDlgXP_Vista(msg,mtConfirmation,[mbYes,mbNo],0) = mrNo then
    AbortInstall := true;
end;

procedure TfmMain.Timer1Timer(Sender: TObject);
begin
  if ProgressBar1.Position > 0 then begin
    if ProgressBar2.Position = 100 then
      ProgressBar2.Position:= 1
    else
      ProgressBar2.Position:= ProgressBar2.Position + 1;
  end;
end;

procedure TfmMain.PlayVideo(const aFileName: string);
begin
  if not FileExists(aFileName) then exit;
  PlayERPVideo(aFileName);
end;

procedure TfmMain.FormShow(Sender: TObject);
begin
  Timer2.Enabled:= true;
end;

procedure TfmMain.Timer2Timer(Sender: TObject);
var
  msg: string;
begin
  TTimer(Sender).Enabled:= false;
  if not AgreeToLicence then begin
    Close;
    exit;
  end;
  try
    if Installer.DoInstall('Setup Videos',msg) then begin
      DoProgress('', '',0, 0);
      self.PlayVideo(ServerVideoName);
    end
    else begin
      Vista_MessageDlg.MessageDlgXP_Vista('Unable to install setup videos!',mtInformation,[mbOk],0);
    end;
  finally
    btnServer.Enabled:= true;
    btnClient.Enabled:= true;
  end;
end;

end.
