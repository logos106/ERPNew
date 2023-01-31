unit sFTPLib;

interface

type
  TStrProc = Procedure (Const Value:String) of object;

Function Donloadfile(fOnEvent:TStrProc; filetodownload, localfile:String;
          aFtpHostname:String;aPortNo:Integer; auser, aPass:String):Boolean;

implementation


uses     authUtil, SFtp,  global,
  CK_DLL_Const, shellapi ;


Function Donloadfile(fOnEvent:TStrProc; filetodownload, localfile:String;
          aFtpHostname:String;aPortNo:Integer;auser, aPass:String):Boolean;
var
  sftp: HCkSFtp;
  hostname: PWideChar;
  port: Integer;
  success: Boolean;
  handle: PWideChar;
  glob: HCkGlobal;
  Procedure Showmsg(Const Value:String);
  begin
    if value = '' then exit;
    if not(Assigned(fOnEvent)) then exit;
    fOnEvent(Value);
  end;
begin
// This example assumes the Chilkat API to have been previously unlocked.
// See Global Unlock Sample for sample code.
  Result := False;
  glob := CkGlobal_Create();
  if CkGlobal_UnlockBundle(glob,CHILCAT_UNLOCK_KEY) then try

      sftp := CkSFtp_Create();

      // Set some timeouts, in milliseconds:
      CkSFtp_putConnectTimeoutMs(sftp,5000);
      CkSFtp_putIdleTimeoutMs(sftp,10000);

      // Connect to the SSH server.
      // The standard SSH port = 22
      // The hostname may be a hostname or IP address.
        hostname := PWidechar(aFtpHostname);
        port := aPortNo;
      success := CkSFtp_Connect(sftp,hostname,port);
      if (success <> True) then
        begin
          Showmsg(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      // Authenticate with the SSH server.  Chilkat SFTP supports
      // both password-based authenication as well as public-key
      // authentication.  This example uses password authenication.
      success := CkSFtp_AuthenticatePw(sftp,PWidechar(aUser),PWidechar(aPass));
      if (success <> True) then
        begin
          Showmsg(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      // After authenticating, the SFTP subsystem must be initialized:
      success := CkSFtp_InitializeSftp(sftp);
      if (success <> True) then
        begin
          Showmsg(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      // Open a file on the server:
      handle := CkSFtp__openFile(sftp,pwidechar(filetodownload),'readOnly','openExisting');
      if (CkSFtp_getLastMethodSuccess(sftp) <> True) then
        begin
          Showmsg(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      // Download the file:
      success := CkSFtp_DownloadFile(sftp,handle,pwidechar(localfile));
      if (success <> True) then
        begin
          Showmsg(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      // Close the file.
      success := CkSFtp_CloseHandle(sftp,handle);
      if (success <> True) then
        begin
          Showmsg(CkSFtp__lastErrorText(sftp));
          Exit;
        end;

      Showmsg('Success.');
      REsult := True;
      (*ShellExecute(Self.Handle, 'Open', PChar(StringReplace(localfile, '/', '\',[rfReplaceAll,rfIgnoreCase])) , '', '', SW_SHOWNORMAL);*)

      CkSFtp_Dispose(sftp);
  finally
    CkGlobal_Dispose(glob);
  end;
end;

end.
