unit frmchilkatTest;

interface

uses
  Classes, Controls, Forms,
  BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, Graphics;

type
  TfmchilkatTest = class(TBaseInputGUI)
    btnreadfile: TDNMSpeedButton;
    Memo1: TMemo;
    lblFilter: TLabel;
    btndownloadfile: TDNMSpeedButton;
    btnuploadfile: TDNMSpeedButton;
    procedure btnreadfileClick(Sender: TObject);
    procedure btndownloadfileClick(Sender: TObject);
    procedure btnuploadfileClick(Sender: TObject);
  private
    procedure Donloadfile(filetodownload, localfile: String);
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
    Windows, Messages, SysUtils, Variants,
    authUtil, Dialogs, SFtp, CommonLib,  global,
  CK_DLL_Const, shellapi;

{$R *.dfm}


Const
  FTPHOSTNAME ='sftp.wisau.com.au';
  FTPPORTNO = 2222;
  FTPUSERNAME ='WORKSCENE';
  FTPPASSWORD = 'fGl2jo';
  FTPFileToDownload = '/Test/Out/Archive/WORKSCENE_INV_782458_000000036.IN';
  FTPLocalFileNameToDownload = 'd:/temp/WORKSCENE_INV_782458_000000036.IN';
  FTPLocalfiletoUpload = 'd:/temp/WORKSCENE_INV.IN';
  FTPFileToUpload = '/Test/Out/Archive/WORKSCENE_INV.IN';




procedure TfmchilkatTest.btnreadfileClick(Sender: TObject);
var
  sftp: HCkSFtp;
  hostname: PWideChar;
  port: Integer;
  success: Boolean;
  handle: PWideChar;
  sText: PWideChar;
  glob: HCkGlobal;
begin
// This example assumes the Chilkat API to have been previously unlocked.
// See Global Unlock Sample for sample code.

  glob := CkGlobal_Create();
  if CkGlobal_UnlockBundle(glob,CHILCAT_UNLOCK_KEY) then try
        sftp := CkSFtp_Create();

        // Set some timeouts, in milliseconds:
        CkSFtp_putConnectTimeoutMs(sftp,5000);
        CkSFtp_putIdleTimeoutMs(sftp,15000);

        // Connect to the SSH server.
        // The standard SSH port = 22
        // The hostname may be a hostname or IP address.
        hostname := FTPHOSTNAMe;
        port := FTPPORTNO;
        success := CkSFtp_Connect(sftp,hostname,port);
        if (success <> True) then begin
            Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
            Exit;
        end;

        // Authenticate with the SSH server.  Chilkat SFTP supports
        // both password-based authenication as well as public-key
        // authentication.  This example uses password authenication.
        success := CkSFtp_AuthenticatePw(sftp,FTPUSERNAME,FTPPASSWORD);
        if (success <> True) then begin
            Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
            Exit;
        end;

        // After authenticating, the SFTP subsystem must be initialized:
        success := CkSFtp_InitializeSftp(sftp);
        if (success <> True) then begin
            Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
            Exit;
        end;

        // Open a file for reading.

        handle := CkSFtp__openFile(sftp,FTPFileToDownload,'readOnly','openExisting');
        if (CkSFtp_getLastMethodSuccess(sftp) <> True) then
          begin
            Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
            Exit;
          end;

        // Assume the file we are reading contains the following text:
        // abcdefghijklmnopqrstuvwxyz1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ
        // (in ANSI format -- i.e. one byte per char).

        // Read 26 bytes:

        sText := CkSFtp__readFileText(sftp,handle,26,'ansi');
        if (CkSFtp_getLastMethodSuccess(sftp) <> True) then
          begin
            Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
            Exit;
          end;

        // Should print "abcdefghijklmnopqrstuvwxyz"
        Memo1.Lines.Add(sText);

        // Read the next 10 bytes.
        sText := CkSFtp__readFileText(sftp,handle,10,'ansi');
        if (CkSFtp_getLastMethodSuccess(sftp) <> True) then
          begin
            Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
            Exit;
          end;

        // Should print "1234567890"
        Memo1.Lines.Add(sText);

        // Read the next 26 bytes.
        sText := CkSFtp__readFileText(sftp,handle,26,'ansi');
        if (CkSFtp_getLastMethodSuccess(sftp) <> True) then
          begin
            Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
            Exit;
          end;

        // Should print "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        Memo1.Lines.Add(sText);

        // Close the file.
        success := CkSFtp_CloseHandle(sftp,handle);
        if (success <> True) then
          begin
            Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
            Exit;
          end;

        Memo1.Lines.Add('Success.');

        CkSFtp_Dispose(sftp);
  finally
    CkGlobal_Dispose(glob);
  end;

end;

procedure TfmchilkatTest.btndownloadfileClick(Sender: TObject);
begin
  Donloadfile( FTPFileToDownload , FTPLocalFileNameToDownload);
end;
procedure TfmchilkatTest.Donloadfile(filetodownload, localfile:String);
var
  sftp: HCkSFtp;
  hostname: PWideChar;
  port: Integer;
  success: Boolean;
  handle: PWideChar;
  glob: HCkGlobal;
begin
// This example assumes the Chilkat API to have been previously unlocked.
// See Global Unlock Sample for sample code.

  glob := CkGlobal_Create();
  if CkGlobal_UnlockBundle(glob,CHILCAT_UNLOCK_KEY) then try

      sftp := CkSFtp_Create();

      // Set some timeouts, in milliseconds:
      CkSFtp_putConnectTimeoutMs(sftp,5000);
      CkSFtp_putIdleTimeoutMs(sftp,10000);

      // Connect to the SSH server.
      // The standard SSH port = 22
      // The hostname may be a hostname or IP address.
        hostname := FTPHOSTNAMe;
        port := FTPPORTNO;
      success := CkSFtp_Connect(sftp,hostname,port);
      if (success <> True) then
        begin
          Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      // Authenticate with the SSH server.  Chilkat SFTP supports
      // both password-based authenication as well as public-key
      // authentication.  This example uses password authenication.
      success := CkSFtp_AuthenticatePw(sftp,FTPUSERNAME,FTPPASSWORD);
      if (success <> True) then
        begin
          Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      // After authenticating, the SFTP subsystem must be initialized:
      success := CkSFtp_InitializeSftp(sftp);
      if (success <> True) then
        begin
          Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      // Open a file on the server:
      handle := CkSFtp__openFile(sftp,pwidechar(filetodownload),'readOnly','openExisting');
      if (CkSFtp_getLastMethodSuccess(sftp) <> True) then
        begin
          Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      // Download the file:
      success := CkSFtp_DownloadFile(sftp,handle,pwidechar(localfile));
      if (success <> True) then
        begin
          Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      // Close the file.
      success := CkSFtp_CloseHandle(sftp,handle);
      if (success <> True) then
        begin
          Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      Memo1.Lines.Add('Success.');
      ShellExecute(Self.Handle, 'Open', PChar(replacestr(localfile,'/','\')) , '', '', SW_SHOWNORMAL);
      CkSFtp_Dispose(sftp);
  finally
    CkGlobal_Dispose(glob);
  end;
end;

procedure TfmchilkatTest.btnuploadfileClick(Sender: TObject);
var
sftp: HCkSFtp;
hostname: PWideChar;
port: Integer;
success: Boolean;
handle: PWideChar;
  glob: HCkGlobal;
begin
// This example assumes the Chilkat API to have been previously unlocked.
// See Global Unlock Sample for sample code.

  glob := CkGlobal_Create();
  if CkGlobal_UnlockBundle(glob,CHILCAT_UNLOCK_KEY) then try

      sftp := CkSFtp_Create();

      // Set some timeouts, in milliseconds:
      CkSFtp_putConnectTimeoutMs(sftp,5000);
      CkSFtp_putIdleTimeoutMs(sftp,10000);

      // Connect to the SSH server.
      // The standard SSH port = 22
      // The hostname may be a hostname or IP address.
      hostname := FTPHOSTNAME;
      port := FTPPORTNO;
      success := CkSFtp_Connect(sftp,hostname,port);
      if (success <> True) then
        begin
          Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      // Authenticate with the SSH server.  Chilkat SFTP supports
      // both password-based authenication as well as public-key
      // authentication.  This example uses password authenication.
      success := CkSFtp_AuthenticatePw(sftp,FTPUSERNAME,FTPPASSWORD);
      if (success <> True) then
        begin
          Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      // After authenticating, the SFTP subsystem must be initialized:
      success := CkSFtp_InitializeSftp(sftp);
      if (success <> True) then
        begin
          Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      // Open a file for writing on the SSH server.
      // If the file already exists, it is overwritten.
      // (Specify "createNew" instead of "createTruncate" to
      // prevent overwriting existing files.)
      handle :=CkSFtp__openFile(sftp,FTPFileTouPload,'writeOnly','createTruncate');
      if (CkSFtp_getLastMethodSuccess(sftp) <> True) then
        begin
          Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      // Upload from the local file to the SSH server.
      success := CkSFtp_UploadFile(sftp,handle,FTPLocalfiletoUpload);
      if (success <> True) then
        begin
          Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      // Close the file.
      success := CkSFtp_CloseHandle(sftp,handle);
      if (success <> True) then
        begin
          Memo1.Lines.Add(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      Memo1.Lines.Add('Success.');
      Donloadfile(FTPFileTouPload, FTPLocalfiletoUpload+'.LOCAL');
      CkSFtp_Dispose(sftp);
  finally
    CkGlobal_Dispose(glob);
  end;
end;

initialization
  commonlib.RegisterClassOnce(TfmchilkatTest);

  end.
