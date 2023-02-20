unit frmLogonFrm;

(*  Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   30/06/05  1.00.01 IJB  Added code to clear UserLocks for current user in ValidateUser.
   21/08/06  1.00.02 BJ   new property added : ExitOnComplete
                          which gets value from the command line parameter /E. when its True
                          the application is terminated without any user message if the login
                          fails.
*)


interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DB, DBCtrls, Buttons, DNMSpeedButton, wwdblook, StdCtrls,
  ExtCtrls, Mask, wwdbedit, Wwdotdot, Wwdbcomb, DBAccess, MyAccess,ERPdbComponents, MemDS,
  Shader, DNMPanel, frmBase, ProgressDialog, Menus, pngimage, GIFImg, jpeg;

type
  TfrmLogon = class(TfrmBaseGUI)
    AutoLoginTimer: TTimer;
    Tmrinactivecheck: TTimer;
    pnlmain: TDNMPanel;
    Image1: TImage;
    Shader1: TShader;
    pnlActivePage: TLabel;
    pnldb: TDNMPanel;
    Label2: TLabel;
    lbServerName: TLabel;
    cboDatabases: TwwDBComboBox;
    cboServer: TwwDBComboBox;
    pnlLogon: TDNMPanel;
    Label1: TLabel;
    Label3: TLabel;
    lblPasswordMessage: TLabel;
    edtPassword: TEdit;
    cboUser: TwwDBComboBox;
    txtLogPswd: TEdit;
    btnNewPassword: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    cmdLogon: TDNMSpeedButton;
    btnHelp: TDNMSpeedButton;
    cmdCancel: TDNMSpeedButton;
    DNMPanel3: TDNMPanel;
    lblVersionLabel: TLabel;
    Panel1: TPanel;
    procedure cmdLogonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure cboDatabasesChange(Sender: TObject);
    procedure cboServerChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AutoLoginTimerTimer(Sender: TObject);
    procedure cboUserChange(Sender: TObject);
    procedure edtPasswordExit(Sender: TObject);
    procedure txtLogPswdDblClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure Label1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDblClick(Sender: TObject);
    procedure Label2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TmrinactivecheckTimer(Sender: TObject);
    procedure txtLogPswdChange(Sender: TObject);
    procedure btnNewPasswordClick(Sender: TObject);
    procedure pnlmainDblClick(Sender: TObject);
    procedure Label3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

  private
    { Private declarations }
    bControlKeyDown: boolean;
    bClosing: boolean;
    fbExitOnComplete :Boolean;
    Initialising: boolean;
    UpdateProgress: TProgressDialog;
    DaysUntilPasswordExpiry: integer;
    procedure GetDataBases;
    procedure GetUsers;
    procedure RefreshTitle;
    (*function CreateNewDatabase: boolean;*)
    Function getPassword(Const User: string):String;
    procedure CheckUserVersion;
    procedure DoOnDataTransferProgress(percent: integer);
    procedure CheckforadminUser;
    procedure NewPassEnabled;
    procedure RefreshDbname;
    procedure MinimiseAllApps;
    procedure initcolor;

  Protected
    function ignorelogInuseform:boolean;Override;

  public
    CompaniesAlreadyCreated: boolean;

    Property ExitOnComplete :Boolean read fbExitOnComplete write fbExitOnComplete ;
    { Public declarations }
  end;

implementation

{$R *.DFM}

uses
  tcConst,DnMLib,ShellApi,
  CommandLineFunctionsObj,
  CommonDbLib, UserLockObj, MAIN, CommonLib,
  AppDatabase, AppEnvironment, {MiddleTier,} ModalInputBoxGUI, LogUtils,
  StrUtils,
  UserUtilsClientObj, JsonObject, ModuleClientUtils, ModuleUtils, InstallConst,
  SystemLib, AppHelpProcessorObj, SimpleEncrypt, UtilsLib, ModuleConst,
  UpdateStoreObj, VersionUtils, DocReaderObj, frmPasswordChange,
  Clipbrd,  BusObjPersonalPreference, BusObjUser, ERPVersionConst, ColourLib;

const
  NewCompanyString = '[New Company]';
  AdminUser = 'admin';
  AdminPass = 'admin';
Procedure TfrmLogon.initcolor;
var
  ctr:integer;
begin
  for ctr := 0 to componentcount-1 do begin
    if components[ctr] is TDnmPanel then
      TDnmPanel(components[ctr]).color := clwhite;
  end;

end;
Procedure TfrmLogon.RefreshDbname;
begin
  pnlActivePage.caption :=' (Server : ' +  trim(cboServer.Text)+'. Database :' +trim(cboDatabases.Text)+' )';
end;
Procedure TfrmLogon.MinimiseAllApps;
var
  h: HWnd;
begin
  Exit;
  if devmode then exit;
  h := Handle;
  while h > 0 do
  begin
    if IsWindowVisible(h) then
      PostMessage(h, WM_SYSCOMMAND, SC_MINIMIZE, 0);
    h := GetNextWindow(h, GW_HWNDNEXT);
  end;
end;

procedure TfrmLogon.FormCreate(Sender: TObject);
begin
  inherited;
  MinimiseAllApps;
  SetButtonProperties(Self, '');
  lblPAsswordMessage.Caption := '';
  DaysUntilPasswordExpiry := 0;
  CompaniesAlreadyCreated:= False;
  Initialising := True;
  try
    bControlKeyDown := False;
    bClosing := False;
    fbExitOnComplete := False;
    cboServer.Items.Text:= AppEnv.AppDb.ServerList.Text;
    if (cboServer.Items.Count > 0) and (AppEnv.AppDb.Server <> '') then begin
      cboServer.ItemIndex := cboServer.Items.IndexOf(AppEnv.AppDb.Server);
    end;

    CheckUserVersion;

    GetDatabases;
    GetUsers;

    if (GetKeyState(VK_CONTROL) < 0) then begin
      bControlKeyDown      := True;
      cboServer.Visible    := True;
      lbServerName.Visible := True;
    end else begin
      {$IFDEF DevMode}
        cboServer.Visible    := True;
        lbServerName.Visible := True;
      {$ENDIF}
    end;

    if lbServerName.Visible then begin
       pnldb.Height := 90;
       Self.Height := 385;
    end else begin
       pnldb.height := 60;
       Self.Height := 350;
    end;

    btnNewPassword.Left := 273;
    btnNewPassword.Top := 74;

    if cboDatabases.Items.Count > 0 then begin
      if (cboDatabases.Items.Count = 1) and (cboDatabases.Text > '') and
        (cboDatabases.Text[1] <> '(') and (not cboServer.Visible) then begin
        cboDatabases.Visible := False;
        Label2.Visible := False;
      end;

    end else begin
      cboUser.Enabled:= False;
      cboDatabases.Text  := 'NO DATABASE FOUND';
    end;

    //lbClientVersion.Caption := GetFileVersion(Application.ExeName);
    lblVersionLabel.Caption := 'Client Version : ' + GetFileVersion(Application.ExeName);
    lblVersionLabel.Alignment := taCenter;

  finally
    Initialising := False;
  end;
end;

procedure TfrmLogon.FormDblClick(Sender: TObject);
var
s:String;
begin
  inherited;
  if not(DEvmode) then exit;
  if cboServer.Visible = False then exit;
  s := inputBox('Server name:','' , '');
  if s = '' then exit;
  if cboServer.Items.IndexOf(s) < 0 then begin
    cboServer.Items.Add(s);
    cboServer.Refresh;
  end;
end;

procedure TfrmLogon.FormDestroy(Sender: TObject);
begin
  if AppEnv.AppDb.Dirty then
    AppEnv.AppDb.Save;
  inherited;
end;

procedure TfrmLogon.GetDataBases;
var
  x, idx, addIdx: Integer;
  DbRec: TDatabaseRec;
begin
  cboDatabases.Items.Clear;
  idx := -1;
  for x := 0 to AppEnv.AppDb.DatabaseList.Count - 1 do begin
    DbRec := TDatabaseRec(AppEnv.AppDb.DatabaseList.Objects[x]);
    if DbRec.Name <> 'erpnewdb' then begin
      if DbRec.Name <> 'sample_company' then
        CompaniesAlreadyCreated := True;
      addIdx := cboDatabases.Items.AddObject(DbRec.VersionDesc, DbRec);
      if DbRec.Name = AppEnv.AppDb.Database then
        idx := addIdx;
    end;
  end;
(*  if not CompaniesAlreadyCreated then begin
    cboDatabases.Items.AddObject(NewCompanyString, nil);
  end;*)
  cboDatabases.ItemIndex := idx;
end;

procedure TfrmLogon.cmdLogonClick(Sender: TObject);
var
  newPass: string;
  passDate: TDateTime;
  fdLoginExpireDate: TDateTime;

  function isFieldEmpty(const txt, display: string): boolean;
  begin
    Result := Empty(txt);
    if Result then begin
     if not fbExitOnComplete then
        CommonLib.MessageDlgXP_Vista(display + ' missing.', mtWarning, [mbOK], 0);
      ModalResult := mrNone;
    end;
  end; //isFieldEmpty
  function DoChangePassword:boolean;
  begin
                Result := True;
                AutoLoginTimer.Enabled := false;
                CommonLib.MessageDlgXP_Vista('Your Password has Expired, Please Enter a New One.',mtInformation,[mbOk],0);
                tmrInactivecheck.Enabled := False;
                if ChangePassword(cboServer.Text,cboDatabases.Text,cboUser.Text,newPass) then begin
                  txtLogPswd.Text := newPass;
                end
                else begin
                  REsult := False;
                  exit;
                end;
  end;

begin
  DisableForm;
  try
      //cmdLogonClick

        (*if cboDatabases.Text = NewCompanyString then begin
          CreateNewDatabase;
          exit;
        end;*)
        if (not isFieldEmpty(cboUser.Text, 'Logon Name')) and
           (not isFieldEmpty(txtLogPswd.Text,'Password')) and
           (not isFieldEmpty(cboDatabases.Text, 'Database')) then begin
          if cboDatabases.Text[1] = '(' then begin
             if FBExitOnComplete then begin
                 ModalResult := MrCancel;
                 Exit;
             end;
             if (cboDatabases.ItemIndex >= 0) and SameText(TDatabaseRec(cboDatabases.Items.Objects[cboDatabases.ItemIndex]).Version,'Locked') then begin
               MessageDlgXP_Vista('Database ' + cboDatabases.Text + ' is currently locked, it is being Updated/Restored. Try again soon.', mtWarning, [mbOK], 0);
               ModalResult := mrNone;
               Exit;
             end
             else begin
               CommonLib.MessageDlgXP_Vista(Format('Database %s Version is not %s',[cboDatabases.Text, TABLE_VERSION]),mtWarning, [mbOK], 0);
               ModalResult := mrNone;
               Exit;
             end;
          end;
          try
            if not TPersonalPreferences.UserPasswordNeverExpires(cboUser.Text, cboServer.Text, cboDatabases.Text) then begin
              if AppEnv.AppDb.PasswordExpiryDays(DaysUntilPasswordExpiry)  and (DaysUntilPasswordExpiry < 0) then begin
                if not doChangePassword then exit;
              end;

              //if (AppEnv.CompanyPrefs.LoginExpireDate > 0) and (Date > Trunc(AppEnv.CompanyPrefs.LoginExpireDate)) then begin
              fdLoginExpireDate := TUser.LoginExpireDate(cboUser.Text,cboServer.Text,cboDatabases.Text);
              //passDate := TUser.UserPasswordDate(cboUser.Text,cboServer.Text,cboDatabases.Text);

              if ((fdLoginExpireDate > 0) and (Date > Trunc(fdLoginExpireDate))) then begin
                if not doChangePassword then exit;
                //if (passDate > 0) and (Trunc(passDate) < Trunc(fdLoginExpireDate)) then begin
                  (*CommonLib.MessageDlgXP_Vista('Your password has expired, please enter a new one.',mtInformation,[mbOk],0);
                  tmrInactivecheck.Enabled := False;
                  if ChangePassword(cboServer.Text,cboDatabases.Text,cboUser.Text,newPass) then begin
                    txtLogPswd.Text := newPass;
                  end
                  else
                    exit;*)
                end;

            end;

            AppEnv.AppDb.ConnectUser(cboUser.Text, txtLogPswd.Text);
            Tmrinactivecheck.Enabled := False;
            SetGlobalIsolationLevel(AppEnv.AppDb.Connection);
            Application.ProcessMessages;
            Application.Title := Application.Title+ ' [' + GetCompanyName+ ']';
            LogD('User logged into: ' + Application.Title);
            (*UserLock := TUserLock.Create(nil);
            try
              UserLock.UnlockAllCurrentUser;
            finally
              FreeandNil(UserLock);
            end;*)
            ModalResult := mrOk;
          except
            on E: exception do begin
              if fbExitOnComplete then
                 MainForm.TerminateApp
              else if CommonLib.MessageDlgXP_Vista(E.Message  + ' Try again?', mtWarning, [mbOK, mbCancel], 0) <> mrOk then
                MainForm.TerminateApp;
              txtLogPswd.Text := '';
              SetControlFocus(txtLogPswd);
              ModalResult     := mrNone;
            end;
          end;
        end;
  Finally
    EnableForm;
  end;
end;

procedure TfrmLogon.FormPaint(Sender: TObject);
begin
  Self.Color := Default_ColourERPSingle;//cDefaultGradientColor;
  (*pnlTitle.Color := Default_ColourERPSingle;//cDefaultGradientColor;
  TitleShader.FromColor := Default_ColourERPSingle;//cDefaultGradientColor;
  TitleShader.ToColorMirror := Default_ColourERPSingle;//cDefaultGradientColor;*)
  inherited;
  PaintGradientColor(Self, True);
end;

procedure TfrmLogon.cboDatabasesChange(Sender: TObject);
begin
  if Initialising then
    exit
(*  else if (cboDatabases.Text = NewCompanyString) then begin
    cboUser.Clear;
    cmdLogon.Caption:= 'Create';
    cboUser.Enabled:= false;
    txtLogPswd.Enabled:= false;
    exit;
  end*)
  else begin
    cmdLogon.Caption:= '&Logon';
    cboUser.Enabled:= true;
    txtLogPswd.Enabled:= true;
  end;

  CheckUserVersion;

  AppEnv.AppDb.Database:= cboDatabases.Text;

  AppEnv.AppDb.GetUserList(cboUser.Items);
  if AppEnv.AppDb.UserName <> '' then
    cboUser.ItemIndex:= cboUser.Items.IndexOf(AppEnv.AppDb.UserName);
  RefreshTitle;
  NewPassEnabled;
  RefreshDbname;
end;

procedure TfrmLogon.cboServerChange(Sender: TObject);
begin

  if Initialising then
    exit;

  AppEnv.AppDb.Server:= cboServer.Text;
  GetDataBases;
  GetUsers;
  RefreshDbname;
end;

procedure TfrmLogon.FormShow(Sender: TObject);
begin
  inherited;
  SetForegroundWindow(Self.Handle);
  //if devmode then borderstyle := bsDialog;
  if devmode then txtLogPswd.hint := 'ALT + CTRL + RIGHT click on the ' + quotedstr(Label2.caption) +' for password';

  If not Empty(CommandLineFunctions.Server) then Begin
    cboServer.ItemIndex := cboServer.Items.IndexOf(CommandLineFunctions.Server);
  end;

  If not Empty(CommandLineFunctions.Database) then Begin
    if cboDatabases.Items.Count > 0 then begin
      cboDatabases.ItemIndex := cboDatabases.Items.IndexOf(CommandLineFunctions.Database + #9 + 'Version ' + TABLE_VERSION);
      if (cboDatabases.Items.Count = 1) and (cboDatabases.Text > '') and
        (cboDatabases.Text[1] <> '(') and (not cboServer.Visible) then begin
        cboDatabases.Visible := false;
        Label2.Visible := false;
      end;
    end else begin
      cboUser.Enabled:= false;
      cboDatabases.Text  := 'NO DATABASE FOUND';
    end;
  end;

  if not Empty(CommandLineFunctions.User) then begin
    cboUser.ItemIndex:= cboUser.Items.IndexOf(CommandLineFunctions.User);
    txtLogPswd.Text:= CommandLineFunctions.Password;
  end
  else begin
    if AppEnv.AppDb.UserName <> '' then
      cboUser.ItemIndex:= cboUser.Items.IndexOf(AppEnv.AppDb.UserName)
    else if cboUser.Items.Count > 0 then
      cboUser.ItemIndex:= 0
    else
      cboUser.ItemIndex:= -1;

    if Empty(cboUser.Text) then
      SetControlFocus(cboUser)
    else if Empty(txtLogPswd.Text) then
      SetControlFocus(txtLogPswd)
    else
      SetControlFocus(cmdLogon);
  end;

  if devmode then begin
    if cboUser.ItemIndex <0 then cboUser.ItemIndex := cboUser.Items.IndexOf('Admin');
    if txtLogPswd.Text ='' then txtLogPswd.Text:= 'Admin';
  end;

  if (not bControlKeyDown) and (not Empty(cboUser.Text)) and (not Empty(txtLogPswd.Text)) then AutoLoginTimer.Enabled := true;
  Tmrinactivecheck.Enabled := true;
  NewPassEnabled;
  RefreshDbname;
  initcolor;
  //WindowState := wsMaximized;
end;

procedure TfrmLogon.RefreshTitle;
begin
  Caption := Application.Title+' Logon   -  ( Server : ' + cboServer.Text + ', Database : ' + cboDatabases.Text + ' )';
end;

procedure TfrmLogon.TmrinactivecheckTimer(Sender: TObject);
begin
  inherited;
  tmrInactivecheck.Enabled := False;
  Application.Terminate;
end;

procedure TfrmLogon.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  mainform.CompaniesAlreadyCreated := Self.CompaniesAlreadyCreated;
  if not bClosing then begin
    bClosing := true;
    Action   := caHide; //See Main, it Free's
    Application.MainForm.Align := alNone;
    AppEnv.AppDb.Connection.Disconnect;
  end;
end;

procedure TfrmLogon.AutoLoginTimerTimer(Sender: TObject);
begin
  AutoLoginTimer.Enabled := false;
  Application.ProcessMessages;
  cmdLogon.Click;
end;

procedure TfrmLogon.GetUsers;
begin
  AppEnv.AppDb.GetUserList(cboUser.Items);
  if AppEnv.AppDb.UserName <> '' then
    cboUser.ItemIndex:= cboUser.Items.IndexOf(AppEnv.AppDb.UserName);

  if (cboUser.ItemIndex < 0) and (cboUser.Items.Count > 0) then
    cboUser.ItemIndex:= 0;

  RefreshTitle;
end;


function TfrmLogon.ignorelogInuseform: boolean;
begin
  REsult := True;
end;

procedure TfrmLogon.Label1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if  (ssShift in shift) and (ssCtrl in Shift) and (ssRight in shift) then begin
       CheckforadminUser;
  end;

end;

procedure TfrmLogon.Label2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if  (ssAlt in shift) and (ssCtrl in Shift) and (ssRight in shift) then begin
       edtPassword.text:= getPassword(cboUser.Text);
       edtPassword.visible := true;
       SetControlFocus(edtPassword);
       SetControlFocus(txtLogPswd);
  end;

end;

procedure TfrmLogon.Label3MouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
var
  js: TJsonObject;
begin
  inherited;
  try
  if  (ssAlt in shift) and (ssCtrl in Shift) and (ssRight in shift) then begin
      if Clipboard.asText ='' then exit;
      js := jo(Clipboard.asText);
      try
          cboServer.text := 'localhost';
          if js.exists('DatabaseName') then cboDatabases.text := js.S['DatabaseName'];
          if js.exists('username') then cboUser.text := js.S['username'];
          if js.exists('Password') then edtPassword.text := js.S['Password'];
          cmdLogon.click;
      finally
        js.free;
      end;
  end;
  Except

  end;
end;

procedure TfrmLogon.NewPassEnabled;
begin
  btnNewPassword.Enabled :=
    (cboDatabases.Text <> '') and (cboUser.Text <> '') and (txtLogPswd.Text <> '');
end;

procedure TfrmLogon.pnlmainDblClick(Sender: TObject);
begin
  inherited;
  if devmode then borderstyle := bsDialog;
end;

procedure TfrmLogon.cboUserChange(Sender: TObject);
  procedure ShowPassWarning(const aMsg: string);
  begin
    lblPasswordMessage.Caption := aMsg;
    lblPasswordMessage.Visible := true;
    lblPasswordMessage.Transparent := false;
    lblPasswordMessage.Transparent := true;
  end;
begin
  AppEnv.AppDb.UserName:= cboUser.Text;
  lblPasswordMessage.Visible := False;

  if TPersonalPreferences.UserPasswordNeverExpires(cboUser.Text, cboServer.Text, cboDatabases.Text) then
    exit;
  if AppEnv.AppDb.PasswordExpiryDays(DaysUntilPasswordExpiry) then begin
    if (DaysUntilPasswordExpiry >= 0) and (DaysUntilPasswordExpiry <= 7) then begin
      if DaysUntilPasswordExpiry = 0 then
        ShowPassWarning('Your password will expire tomorrow.')
      else
        ShowPassWarning('Your password will expire in ' + IntToStr(DaysUntilPasswordExpiry) + ' days.');
    end;
  end;
  NewPassEnabled;
end;

(*function TfrmLogon.CreateNewDatabase: boolean;
var
  ServicesProgressForm: TMTUseServicesProgressForm;
  sl: TStringList;
  params: string;
//  sDefault: string;
  sDBName: string;
begin
  result:= false;
  self.Enabled:= false;
  try
    if not AppEnv.AppDb.DatabaseExists('erpnewdb') then begin
      CommonLib.MessageDlgXP_Vista('Please select the server where ERP has been installed', mtInformation, [mbOK], 0);
      exit;
    end;

//    sDefault := 'New_Database_Name_Here';
    if not ModalInputBox('New Company DB', 'Enter New Company Database', sDBName) then
      exit;
    if Trim(sDBName) = '' then begin
      CommonLib.MessageDlgXP_Vista('Database name can not be blank.', mtInformation, [mbOK], 0);
      exit;
    end;
    if not ValidAlphaNumericCharacters(sDBName) then begin
      CommonLib.MessageDlgXP_Vista('No non alphanumeric characters allowed in Database name.', mtInformation, [mbOK], 0);
      exit;
    end;
    // Ensure that the New database name doesnt already exist.
    if AppEnv.AppDb.DatabaseExists(sDBName) then begin
      // It does, report error to user.
      CommonLib.MessageDlgXP_Vista('A Database With the Same Name Already Exists!', mtWarning, [mbOK], 0);
      Exit;
    end;


    sl := TStringList.Create;
    ServicesProgressForm := TMTUseServicesProgressForm.Create(Self);
    AppEnv.AppDb.Connection.Disconnect;
    AppEnv.AppDb.Database:= 'erpnewdb';
    AppEnv.AppDb.ConnectUser(AdminUser,AdminPass);
    try
      with ServicesProgressForm do begin
         if not Connect(CommonDbLib.GetSharedMyDacConnection.Server,
                   CommonDbLib.GetSharedMyDacConnection.Username,
                   CommonDbLib.GetSharedMyDacConnection.Password, CommonDbLib.GetSharedMyDacConnection.Port) then begin
          CommonLib.MessageDlgXP_Vista('Could Not Connect to Server Services', mtWarning, [mbOK], 0);
        end else begin
          params := 'CREATEDB erpnewdb ' + CommonDbLib.GetSharedMyDacConnection.UserName + ' ' + CommonDbLib.GetSharedMyDacConnection.Password + ' ' + sDBName + ' ' + TABLE_NAMES_NOT_TO_BE_INNODB;

          if not Exec('CREATE DB IN PROGRESS', 'BackupManager.exe', params, sl) then begin
            CommonLib.MessageDlgXP_Vista('Creating Database Failed', mtWarning, [mbOK], 0);
            Exit;
          end
          else
            result:= true;

        end;
      end;
    finally
      FreeAndNil(ServicesProgressForm);
      FreeAndNil(sl);
      AppEnv.AppDb.Connection.Disconnect;
      if result then begin
        AppEnv.AppDb.PopulateDatabaseList;
        GetDatabases;
        GetUsers;
      end;
      cmdLogon.Caption:= '&Logon';
    end;
  finally
    self.Enabled:= true;
  end;
end;*)

procedure TfrmLogon.edtPasswordExit(Sender: TObject);
begin
  inherited;
  edtPassword.visible := false;
  txtLogPswd.text :=edtPassword.text;
end;
Procedure TfrmLogon.CheckforadminUser;
var
  QryEmp, QryUser:TERPQuery;
  fiEmployeeId:Integer;
begin
  if (cboDatabases.text = '') or (cboServer.text = '') then exit;
        QryEmp:= TERPQuery.Create(nil);
        QryUser:= TERPQuery.Create(nil);
        try
          QryEmp.Connection:= TERPConnection.create(Self);
            With TERPConnection(QryEmp.Connection) do begin
              Server := cboServer.text;
              Username:= SYSDB_USER;
              Password:= SYSDB_PASS;
              Port := MYSQL_PORT;
              Database :=cboDatabases.text;
              connected := true;
            end;
          QryUser.Connection := QryEmp.connection;
          QryEmp.SQL.Text:= 'Select employeeId, EmployeeName, Active from tblemployees where EmployeeName = "Admin ." ';
          QryEmp.Open;
          if QryEmp.recordcount =0 then exit;
          if (QryEmp.FieldByname('Active').asBoolean) then exit;
          fiEmployeeId:=QryEmp.FieldByname('EmployeeId').asInteger;


          QryUSer.SQl.clear;
          QryUSer.SQl.add('Select * from tblinuse where datasetname = "tblemployees" and KeyID = '+inttostr(fiEmployeeId));
          QryUSer.open;
          if QryUSer.recordcount> 0 then begin
            MessageDlgXP_Vista('Use Admin is Locked by '+QryUSer.FieldByname('USername').asString, mtInformation, [mbOK], 0);
            Exit;
          end;
          QryUSer.append;
          QryUSer.FieldByname('KeyID').asInteger:= fiEmployeeId;
          QryUSer.FieldByname('DatasetName').asString := 'tblemployees';
          QryUSer.FieldByname('USername').asString := 'Un-known';
          QryUSer.FieldByname('Classname').asString := 'Logon Form';
          QryUSer.FieldByname('Groupname').asString := 'Logon Form';
          QryUSer.FieldByname('timeentered').asDateTime := now;
          QryUSer.Post;
          try
            QryEmp.Edit;
            QryEmp.Fieldbyname('Active').asBoolean := True;
            QryEmp.Post;
            QryEmp.close;
            QryEmp.SQL.clear;
            QryEmp.SQL.add('Select * from tblpassword where EmployeeId = '+ inttostr(fiEmployeeId));
            QryEmp.open;
            if QryEmp.recordcount =0 then begin
              QryEmp.append;
              QryEmp.fieldbyname('employeeId').asInteger := fiEmployeeId;
            end else begin
              QryEmp.Edit;
            end;
            if QryEmp.fieldbyname('Logon_name').asString = '' then QryEmp.fieldbyname('Logon_name').asString:= 'Admin';
            if QryEmp.fieldbyname('Logon_Password').asString = '' then QryEmp.fieldbyname('Logon_Password').asString:= 'лочуш';
            QryEmp.Post;
          finally
            AppEnv.AppDb.GetUserList(cboUser.Items);
            if AppEnv.AppDb.UserName <> '' then
              cboUser.ItemIndex:= cboUser.Items.IndexOf(AppEnv.AppDb.UserName);
            QryUSer.DElete;
          end;
        finally
          QryEmp.ClosenFree;
          QryUser.ClosenFree;
        end;
end;

function TfrmLogon.getPassword(const User: string): String;
var
  qryLogon:TERPQuery;
begin
  result := '';
        qryLogon:= TERPQuery.Create(nil);
        try
          qryLogon.Connection:= TERPConnection.create(Self);
            With TERPConnection(qryLogon.Connection) do begin
              Server := cboServer.text;
              Username:= SYSDB_USER;
              Password:= SYSDB_PASS;
              Port := MYSQL_PORT;
              Database :=cboDatabases.text;
              connected := true;
            end;
          qryLogon.SQL.Add('SELECT Logon_Password');
          qryLogon.SQL.Add('FROM  tblPassword p');
          qryLogon.SQL.Add('inner join tblemployees e on e.EmployeeID = p.EmployeeID and e.Active = "T"');
          qryLogon.SQL.Add('WHERE Logon_Name =  ' +QuotedStr(User));
          qryLogon.Open;
          if qryLogon.recordcount > 0 then
            result := DeCrypt(qryLogon.Fields.FieldByName('Logon_Password').AsString, 'z');
        finally
          FreeandNil(qryLogon);
        end;
end;

procedure TfrmLogon.txtLogPswdChange(Sender: TObject);
begin
  inherited;
  NewPassEnabled;
end;

procedure TfrmLogon.txtLogPswdDblClick(Sender: TObject);
begin
  inherited;
  {$IFDEF DevMode}
       edtPassword.text:= getPassword(cboUser.Text);
       edtPassword.visible := true;
       SetControlFocus(edtPassword);
  {$ENDIF}
end;

procedure TfrmLogon.CheckUserVersion;
var
  dbRec: TDatabaseRec;
  dbName: string;
  UserUtils: TUserUtilsClient;
  UpdateInfo, UpdateConfig: TJsonObject;
  msg: string;
  UpdaterSource, UpdaterDest: string;
  UpdateStore: TUpdateStore;
  done: boolean;
begin
  dbName := Trim(cboDatabases.Text);
  if dbName <> '' then begin
    dbName := AnsiReplaceStr(dbName, '(', '');
    dbName := AnsiReplaceStr(dbName, ')', '');
    dbRec := AppEnv.AppDb.DatabaseRecord[dbName];
    if Assigned(dbRec) then begin
      if not dbRec.VersionOk then begin
        if SameText(dbRec.Version, 'Locked') then begin
          MessageDlgXP_Vista('Database ' + dbRec.Name + ' is currently locked, it is being Updated/Restored. Try again soon.', mtWarning, [mbOK], 0);
          Exit;
        end;
        if VersionUtils.VersionComp(dbRec.Version, TABLE_VERSION) > 0 then begin
          { The database has been updated to a newer version than the user.
            Check server for newer version. }
          UserUtils := TUserUtilsClient.Create;
          try
            UserUtils.Connect(AppEnv.AppDb.Server, ModuleConst.ERP_ADMIN_USER);

            if not UserUtils.Connected then begin
              MessageDlgXP_Vista('Unable to connect to ERP Server to check for ERP updates.', mtWarning, [mbOK], 0);
              exit;
            end;

            UpdateInfo := UserUtils.GetUserUpdateInfo(dbRec.Version);

            if Assigned(UpdateInfo) then begin
              try
                MessageDlgXP_Vista('A newer version of the ERP User application (' +
                  dbRec.Version + ')' + #13#10 + 'is available.' + #13#10 + #13#10 +
                  'ERP will now be updated.', mtInformation, [mbOK], 0);
                { now do the update }

                { get the client updater }
//@@                UpdaterSource:= ERP_SERVER_ROOT_DIR + ERP_UTILITIES_DIR + 'Updates\ERPClientUpdater.exe';
                UpdaterSource := ERP_UPDATES_DIR + 'ERPClientUpdater.exe';
                UpdaterDest := Commonlib.TempDir + 'ERPClientUpdater.exe';
                DeleteFile(UpdaterDest);
                UpdateProgress:= TProgressDialog.Create(nil);
                UpdateProgress.Message := 'Downloading updater ...';
                UpdateProgress.Execute;
                try
                  { try update store first }
                  msg := '';
                  done := False;
                  UpdateStore := TUpdateStore.Create;
                  try
                    try
                      UpdateStore.Server := AppEnv.AppDb.Server;
                      with UpdateStore.VersionUpdates('ERPClientUpdater', '', '') do begin
                        if RecordCount = 0 then begin
                          UpdateProgress.CloseDialog;
                          msg := 'Error - update not found on server for ERP Client Updater';
                          //exit;
                        end
                        else begin
                          TBlobField(FieldByName('File')).SaveToFile(UpdaterDest);
                          done := True;
                        end;
                      end;
                    except
                      on e: exception do begin
                        UpdateProgress.CloseDialog;
                        msg := 'Error getting ERP Client Updater file from server: ' + e.Message;
                        exit;
                      end;
                    end;
                  finally
                    UpdateStore.Free;
                  end;

                  if not done then begin
                    { try the old way }
                    if ModuleClientUtils.JsonGetFile('userutils', UpdaterSource, UpdaterDest, UserUtils.Client, DoOnDataTransferProgress, msg) then
                      done := True;
                  end;

                  if done then begin
                    UpdateConfig := TJsonObject.Create;
                    try
                      UpdateConfig.Assign(UpdateInfo);
                      UpdateConfig.S['installpath'] := SystemLib.ExeDir;
                      UpdateConfig.S['erpfilename'] := ExtractFileName(Application.ExeName);
                      UpdateConfig.S['servername'] := AppEnv.AppDb.Server;
                      UpdateConfig.S['databasename'] := dbName;
                      UpdateConfig.SaveToFile(Commonlib.TempDir + 'UpdateConfig.txt');
                    finally
                      UpdateConfig.Free;
                    end;
                    msg := '';
                    if not ExecNewWinProcess(UpdaterDest, false, msg) then begin
                      UpdateProgress.CloseDialog;
                      MessageDlgXP_Vista('Unable to run the user updater (ERPClientUpdater.exe) as the permissions are insufficient.' + #13#10 +
                        'Please open the folder containing the updater (ERPClientUpdater.exe):' + #13#10 +
                        ExtractFilePath(UpdaterDest) + #13#10 +
                        'and right click on the updater (ERPClientUpdater.exe) and select "Run as administrator"', mtInformation, [mbOK], 0);
                    end;
                    MainForm.TerminateApp;
                    Exit;
                  end
                  else begin
                    MessageDlgXP_Vista(msg, mtWarning, [mbOK], 0);
                  end;
                finally
                  UpdateProgress.CloseDialog;
                  UpdateProgress.Free;
                end;
              finally
                UpdateInfo.Free;
              end;

            end
            else begin
              MessageDlgXP_Vista('A newer version of the ERP user software (' +
                dbRec.Version + ') is required to connect to this database.' + #13#10 + #13#10 +
                'ERP was unable to get update information from your ERP Server.'+ #13#10 + #13#10 +
                'If this problem persists please do the following on your ERP Server machine:' + #13#10 +
                '1) Delete all files and folders from the following folder on the ERP server' + #13#10 +
//                'C:\ERP Software\Utilities\Updates' + #13#10 +
                ERP_UPDATES_DIR +
                'leaving the Updates folder empty.'  + #13#10 +
                '2) Open the ERP Service Menu and click on the "Check Update" button.' +  #13#10 +
                '3) When this has completed try logging into ERP again.' +  #13#10 +  #13#10 +

                'Select the "?" on the login screen for more information.', mtWarning, [mbOK], 0);
            end;

          finally
            UserUtils.Free;
          end;

        end;
      end;
    end
    else begin
      MessageDlgXP_Vista('Could not read Database Record.', mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TfrmLogon.btnHelpClick(Sender: TObject);
var
  res : integer;
begin
  inherited;
//  TDocReaderObj.ShowERPHelp(nil, self,true,'Log In Issue');
  if FileExists(ExtractFilePath(Application.ExeName) + 'Log In issue.pdf') then
  begin
    Res := ShellExecute(0, 'open', PChar(ExtractFilePath(Application.ExeName) + 'Log In issue.pdf'), nil, nil, SW_SHOW);
    if Res = SE_ERR_NOASSOC then
      MessageDlgXP_Vista('You Do Not Have Default PDF Reader Installed.'#13#10'Cannot Display Help File',
        mtWarning, [mbOk], 0);
  end
  else
    MessageDlgXP_Vista('Cannot Find Help File "Log In issue.pdf"', mtWarning,[mbOk], 0);
end;

procedure TfrmLogon.btnNewPasswordClick(Sender: TObject);
var
  newPass: string;
begin
//  inherited;
if not TPersonalPreferences.UserCanChangePassword(cboUser.Text, cboServer.Text, cboDatabases.Text) then begin
  MessageDlgXP_Vista('You are not Allowed to Change the Password.'+ NL+
                      'Settings Can be Altered in the Employee Card.', mtWarning, [mbOK], 0);
  Exit;
end;
  tmrInactivecheck.Enabled := False;
  if ChangePassword(cboServer.Text,cboDatabases.Text,cboUser.Text,newPass,txtLogPswd.Text) then begin
    txtLogPswd.Text := newPass;
    MessageDlgXP_vista('Your Pasword has been Changed!', mtWarning, [mbOK], 0);
  end;
end;

procedure TfrmLogon.DoOnDataTransferProgress(percent: integer);
begin
  if Assigned(UpdateProgress) then begin
//    sleep(100);
    UpdateProgress.MaxValue:= 100;
    UpdateProgress.Value:= percent;
  end;
end;

end.


