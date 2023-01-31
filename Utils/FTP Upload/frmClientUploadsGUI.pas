unit frmClientUploadsGUI;

interface

uses
  Forms,ComCtrls, StdCtrls, Controls, Buttons, Classes, ExtCtrls,
  {IpUtils, IpSock, IpFtp,} Dialogs,Messages ,SysUtils, Menus, Gauges,
  {EsLabel,} DNMSpeedButton, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdFTP, IdAntiFreezeBase, IdAntiFreeze, AdvOfficeStatusBar,
  AdvOfficeStatusBarStylers, AdvPanel, Shader, IdExplicitTLSClientServerBase;

type
  TClientUploadsGUI = class(TForm)
    AdvPanel1: TAdvPanel;
    Bevel2: TBevel;
    lblUploadSummary: TLabel;
    Letter_Label: TLabel;
    lblCompanyName: TLabel;
    ProgressBar1: TGauge;
    Label2: TLabel;
    FilesList: TMemo;
    txtCompanyName: TEdit;
    BtnUploadFiles: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    OpenDialog1: TOpenDialog;
    PopupMenu: TPopupMenu;
    AddFiles1: TMenuItem;
    ClearFiles1: TMenuItem;
    IdAntiFreeze1: TIdAntiFreeze;
    FtpClient: TIdFTP;
    AdvOfficeStatusBarOfficeStyler2: TAdvOfficeStatusBarOfficeStyler;
    StatusBar1: TAdvOfficeStatusBar;
    AdvPanelStyler1: TAdvPanelStyler;
    pnlHeader: TPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure btnCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnUploadFilesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AddFiles1Click(Sender: TObject);
    procedure ClearFiles1Click(Sender: TObject);

  private
    { Private declarations }
    CancelAllProccess :Boolean;
    TransferInProgress :Boolean;
    CurrentUpload:Integer;
    CurrentFileSize:Integer;
    UploadsCount:Integer;
    TotalUploadSize:Integer;
    BytesToTransfer: LongWord;
    UploadTimeStamp: String;
    STime: TDateTime;    
    procedure Login;
    Procedure Logout;
    Procedure SetupProxyServer;
    Procedure SaveCompanyName;
    function Empty(const s: string): boolean;
    procedure CancelProcess;
    Procedure SetTotalUploadSize;
    Function UploadFile(Const LocalPathName:String):Boolean;
    Function FileSize(Const FilePathName: String): LongInt;
    Procedure DragDropMessages(var Message: TWMDROPFILES); Message wm_DropFiles;
    procedure FtpClientDisconnected(Sender: TObject);
    procedure FtpClientWork(Sender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure FtpClientWorkBegin(Sender: TObject; AWorkMode: TWorkMode;  AWorkCountMax: Int64);
    procedure FtpClientWorkEnd(Sender: TObject; AWorkMode: TWorkMode);

  end;

var
  ClientUploadsGUI: TClientUploadsGUI;

implementation
{$R *.DFM}
uses
  ShellApi,Graphics,IniFiles, IdFTPCommon, IdException, IdStack, InstallConst;

Var
  AverageSpeed: Double = 0;  

Const
  OPTIONS_INI_FILE: String  = 'ClientUploads.ini';
  WebSiteAddress: String  = 'ftp.trueerp.com';
  WebSiteUser: String  = 'uploads@trueerp.com';
  WebSitePassword: String  = 'karl1karl1';
  FTP_PATH: String  = '/client_uploads';


procedure TClientUploadsGUI.FormCreate(Sender: TObject);
begin
  DragAcceptFiles(Handle,True);
  TransferInProgress := False;
  CurrentUpload := 0;
  FtpClient.TransferType := ftBinary;
  FtpClient.Passive := True;
  FtpClient.OnDisconnected := FtpClientDisconnected;
  FtpClient.OnWork := FtpClientWork;
  FtpClient.OnWorkBegin := FtpClientWorkBegin;
  FtpClient.OnWorkEnd := FtpClientWorkEnd;
  SetupProxyServer;
end;


procedure TClientUploadsGUI.SetupProxyServer;
var
  OptionsIni: TMemIniFile;
begin
  OptionsIni:= TMemIniFile.Create(ExtractFilePath(Application.ExeName)+OPTIONS_INI_FILE);
  Try
     txtCompanyName.Text := OptionsIni.ReadString('Setup', 'CompanyName', '');
  finally
    OptionsIni.Free;
  end;
end;

Function TClientUploadsGUI.FileSize(Const FilePathName: String): LongInt;
Var
   f: file of Byte;
   Size: Longint;
Begin
  Result := 0;
  if FileExists(FilePathName) then Begin
    Try
      AssignFile(f, FilePathName);
      Reset(f);
      try
        Size := System.FileSize(f);
      finally
        CloseFile(f);
      end;
      Result := Size;
    Except
      Result := 0;
    End;
  End;
End;

procedure TClientUploadsGUI.btnCancelClick(Sender: TObject);
begin
  CancelProcess;
  SaveCompanyName;
  Self.Close;
end;

procedure TClientUploadsGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TClientUploadsGUI.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not btnCancel.Enabled  then begin
    CanClose := false;
  end;
end;

procedure TClientUploadsGUI.Login;
var
  Save_Cursor:TCursor;
begin
  Save_Cursor := Screen.Cursor;
  Try
    Screen.Cursor := crHourGlass;
    lblUploadSummary.Caption := 'Connecting to Upload Server';
    FtpClient.Username := WebSiteUser;
    FtpClient.Password := WebSitePassword;
    FtpClient.Host := WebSiteAddress;
    Try
      FtpClient.Connect;
    Except
     MessageDlg('Upload Server is Not Available', mtInformation, [mbOK], 0);
     Logout;
     lblUploadSummary.Caption :='';
     btnCancel.Enabled :=True;
     BtnUploadFiles.Enabled :=True;
     CancelAllProccess := True;
     Application.ProcessMessages;
    end;
  finally
    Screen.Cursor := Save_Cursor;
  end;
end;

procedure TClientUploadsGUI.Logout;
begin
  if FtpClient.Connected then try
    if TransferInProgress then
      FtpClient.Abort;
    Try
      FtpClient.Disconnect;
    Except
      on EIdSocketError do;
      on EIdConnClosedGracefully do;
    End;
  finally
    Application.ProcessMessages;
  end
end;

procedure TClientUploadsGUI.CancelProcess;
begin
  Logout;
  Application.ProcessMessages;
  Sleep(100);
  Application.ProcessMessages;
  CancelAllProccess := True;
  TransferInProgress := False;
end;

procedure TClientUploadsGUI.DragDropMessages(var Message: TWMDROPFILES);
var
  NumFiles : longint;
  i : longint;
  buffer : array[0..255] of char;
begin
  NumFiles := DragQueryFile(Message.Drop,$FFFFFFFF,nil,0);
  for i := 0 to (NumFiles - 1) do begin
    DragQueryFile(Message.Drop,i,@buffer,sizeof(buffer));
    FilesList.Lines.Add(buffer);
  end;
end;

procedure TClientUploadsGUI.AddFiles1Click(Sender: TObject);
begin
//  OpenDialog1.InitialDir := 'c:\erp software\backup';
  OpenDialog1.InitialDir := ExcludeTrailingPathDelimiter(ERP_SERVER_ROOT_DIR + ERP_BACKUP_DIR);
  if OpenDialog1.Execute then begin
    FilesList.Lines.Add(Opendialog1.FileName);
  end;
end;

procedure TClientUploadsGUI.ClearFiles1Click(Sender: TObject);
begin
  FilesList.Lines.Clear;
end;

procedure TClientUploadsGUI.SetTotalUploadSize;
Var
  iCount: Integer;
begin
  TotalUploadSize := 0;
  UploadsCount := FilesList.Lines.Count;
  For iCount := 0 to FilesList.Lines.Count-1 do Begin
    TotalUploadSize := TotalUploadSize + FileSize(FilesList.Lines[iCount]);
  end;
end;

function TClientUploadsGUI.UploadFile(const LocalPathName: String): Boolean;
var
  tmpPath : String;
begin
  Result := False;
  If not TransferInProgress then Begin
    TransferInProgress :=True;
    Try
      if Not FileExists(ExtractFilePath(LocalPathName)) then Begin
        Application.ProcessMessages;
        if FtpClient.Connected then begin
            Try
              FtpClient.MakeDir(FTP_PATH);
            Except
            end;  
            tmpPath := FTP_PATH+'/'+Trim(txtCompanyName.Text);
            Try
              FtpClient.MakeDir(tmpPath);
            Except
            end;
            tmpPath := tmpPath+'/'+UploadTimeStamp;
            Try
              FtpClient.MakeDir(tmpPath);
            Except
            end;
            try
              FtpClient.ChangeDir(tmpPath);
            Except
            end;
            Application.ProcessMessages;
            ProgressBar1.MinValue := 0;
            ProgressBar1.Progress := ProgressBar1.MinValue;
            ProgressBar1.MaxValue := CurrentFileSize;
            lblUploadSummary.caption := 'Uploading File ('+ IntToStr(CurrentUpload) +' of '+IntToStr(UploadsCount)+')   -    0.0 KB  of   '+ FloatToStrF(CurrentFileSize/1024,ffFixed,18,1) +' KB';
            Application.ProcessMessages;
            FtpClient.TransferType := ftBinary;
            FtpClient.Put(LocalPathName, ExtractFileName(LocalPathName));
            Result := True;
        end;
      end;
    Finally
      TransferInProgress := False;
    end;
  end;
end;

procedure TClientUploadsGUI.BtnUploadFilesClick(Sender: TObject);
Var
  iCount: Integer;
  NoErrors:Boolean;
begin
  If not Empty(txtCompanyName.Text) then begin
    SaveCompanyName;
  end else Begin
    MessageDlg('Must Enter Company Name !', mtInformation, [mbOK], 0);
    txtCompanyName.SetFocus;
    Exit;
  end;
  BtnUploadFiles.Enabled := False;
  btnCancel.Caption:='Cancel';
  ProgressBar1.Progress := 0;
  lblUploadSummary.Caption := '';
  Try
    NoErrors := False;
    SetTotalUploadSize;    
    If (UploadsCount=0) AND (TotalUploadSize=0) then Begin
      MessageDlg('There Are No Files To Upload !', mtConfirmation, [mbOK], 0);
      BtnUploadFiles.Enabled := True;
      Exit;
    end;
    Login;
    If CancelAllProccess then Exit;
    UploadTimeStamp := Trim(FormatDateTime('dd-mm-yyyy h:nn:ss am/pm', Now()));
    For iCount := 0 to FilesList.Lines.Count-1 do Begin
      NoErrors := False;
      if FileExists(FilesList.Lines[iCount]) then Begin
        CurrentUpload := iCount+1;
        CurrentFileSize := FileSize(FilesList.Lines[iCount]);
        TransferInProgress := False;
        NoErrors := UploadFile(FilesList.Lines[iCount]);
      end;
      If Not NoErrors then Begin
        MessageDlg('Upload Failed !', mtWarning, [mbOK], 0);
        Exit;
      end;
    end;
    ProgressBar1.Progress := 0;
    lblUploadSummary.Caption := '';
    Sleep(20);
    Application.ProcessMessages;
    Logout;
    Application.ProcessMessages;
    If NoErrors And (CurrentUpload=UploadsCount) Then Begin
      ProgressBar1.Progress := ProgressBar1.MaxValue;
      lblUploadSummary.Caption := 'Upload Completed Successfully';
      MessageDlg('Upload Completed Successfully', mtInformation, [mbOK], 0);
      BtnUploadFiles.Enabled := False;
    end else Begin
      BtnUploadFiles.Enabled := True;
    end;
  Finally
   btnCancel.Caption:='Close';
  end;
end;

procedure TClientUploadsGUI.SaveCompanyName;
var
  OptionsIni: TMemIniFile;
begin
  OptionsIni:= TMemIniFile.Create(ExtractFilePath(Application.ExeName)+OPTIONS_INI_FILE);
  Try
    OptionsIni.WriteString('Setup', 'CompanyName', txtCompanyName.Text);
    OptionsIni.UpdateFile;
  finally
    OptionsIni.Free;
  end;
end;

function TClientUploadsGUI.Empty(const s: string): boolean;
begin
  result := (Trim(s) = '');
end;


procedure TClientUploadsGUI.FtpClientDisconnected(Sender: TObject);
begin
  lblUploadSummary.Caption := 'Disconnected.';
end;

procedure TClientUploadsGUI.FtpClientWork(Sender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
Var
  S: String;
  TotalTime: TDateTime;
  H, M, Sec, MS: Word;
  DLTime: Double;
begin
  TotalTime :=  Now - STime;
  DecodeTime(TotalTime, H, M, Sec, MS);
  Sec := Sec + M * 60 + H * 3600;
  DLTime := Sec + MS / 1000;
  if DLTime > 0 then
    AverageSpeed := (AWorkCount / 1024) / DLTime{) / 2};

  if AverageSpeed > 0 then begin
    Sec := Trunc(((ProgressBar1.MaxValue - AWorkCount) / 1024) / AverageSpeed);

 //   S := Format('%2d:%2d:%2d', [Sec div 3600, (Sec div 60) mod 60, Sec mod 60]);

    S :=  IntToStr(Sec div 3600) + ' hrs '+IntToStr((Sec div 60) mod 60) + ' min '+IntToStr(Sec mod 60) + ' sec';

    S := 'Time remaining : ' + S;
  end
  else S := '';

  S := FormatFloat('0.00 KB/s', AverageSpeed) + '      ' + S;
  case AWorkMode of
    wmRead: StatusBar1.Panels[0].Text := 'Download speed ' + S;
    wmWrite: StatusBar1.Panels[0].Text := 'Upload speed ' + S;
  end;

  if CancelAllProccess then FtpClient.Abort;

  ProgressBar1.Progress := AWorkCount;

  lblUploadSummary.caption := 'Uploading File ('+ IntToStr(CurrentUpload) +' of '+IntToStr(UploadsCount)+
                              ')   -    '+FloatToStrF(AWorkCount/1024,ffFixed,18,1) + ' KB  of   '+ FloatToStrF(CurrentFileSize/1024,ffFixed,18,1) +' KB';

  CancelAllProccess := false;
end;

procedure TClientUploadsGUI.FtpClientWorkBegin(Sender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  TransferInProgress := true;
  CancelAllProccess := false;
  STime := Now;
  if AWorkCountMax > 0 then ProgressBar1.MaxValue := AWorkCountMax
  else ProgressBar1.MaxValue := BytesToTransfer;
  AverageSpeed := 0;
end;

procedure TClientUploadsGUI.FtpClientWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
  StatusBar1.Panels[0].Text := 'Uploading File ('+ IntToStr(CurrentUpload) +' of '+IntToStr(UploadsCount)+') Transfer complete.';
  BytesToTransfer := 0;
  TransferInProgress := false;
  ProgressBar1.Progress := 0;
  AverageSpeed := 0;
end;

end.







