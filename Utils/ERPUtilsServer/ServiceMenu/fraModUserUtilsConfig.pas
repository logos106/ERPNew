unit fraModUserUtilsConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, fraUtilsConfigBase, ExtCtrls, StdCtrls, wwclearbuttongroup,
  wwradiogroup, DNMSpeedButton, JsonObject, Grids, AdvObj, BaseGrid, AdvGrid;

type
  TfrModUserUtilsConfig = class(TfrUtilsConfigBase)
    Label9: TLabel;
    btnShowLog: TDNMSpeedButton;
    rgLoggingLevel: TwwRadioGroup;
    Bevel1: TBevel;
    Label3: TLabel;
    cbDataBase: TComboBox;
    btnBackup: TDNMSpeedButton;
    btnRestore: TDNMSpeedButton;
    btnClone: TDNMSpeedButton;
    Label1: TLabel;
    btnReadonlyClose: TDNMSpeedButton;
    Label2: TLabel;
    btnRemove: TDNMSpeedButton;
    Label4: TLabel;
    btnCheckLicence: TDNMSpeedButton;
    btnCheckUpdate: TDNMSpeedButton;
    btnLogFile: TDNMSpeedButton;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure rgLoggingLevelClick(Sender: TObject);
    procedure btnShowLogClick(Sender: TObject);
    procedure btnBackupClick(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure btnCloneClick(Sender: TObject);
    procedure btnReadonlyCloseClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure btnCheckLicenceClick(Sender: TObject);
    procedure btnCheckUpdateClick(Sender: TObject);
    procedure btnLogFileClick(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
  protected
    function GetModuleName: string; override;
    procedure AfterGetModuleConfig; override;
    function ConfigHasChanged(newConfig, cleanConfig: TJsonObject): boolean; override;
    function GetModuleConfig: boolean; override;
    function SetModuleConfig(var msg: string): boolean; override;
    function VerifyAndSetModuleConfig: boolean; override;
  public
    { Public declarations }
  end;

var
  frModUserUtilsConfig: TfrModUserUtilsConfig;

implementation

uses
  LogMessageTypes, Vista_MessageDlg, ModuleConst,
  frmDatabaseBackup, frmArchiveSelect, ModalInputBoxGUI, InstallConst,
  ShellAPI, UpdateStoreObj, DB, SystemLib, LogThreadLib;

{$R *.dfm}

function ValidAlphaNumericCharacters(const sValue: string): boolean;
var
  iIndex: integer;
begin
  Result := true;
  for iIndex := 1 to Length(sValue) do begin
    if not CharInSet(sValue[iIndex],['a'..'z', 'A'..'Z', '0'..'9', '_']) then begin
      Result := false;
      Break;
    end;
  end;
end;

{ TfrModUserUtilsConfig }

procedure TfrModUserUtilsConfig.AfterGetModuleConfig;
begin
  inherited;
  rgLoggingLevel.ItemIndex := Ord(StrToLoggingLevel(Config.S['LoggingLevel']));
end;

procedure TfrModUserUtilsConfig.btnBackupClick(Sender: TObject);
var
  s: string;
  msg: string;
begin
  inherited;
  TLogger.Inst.Log('User ' + GetCurrentWindowsUserName + ' clicked on ' + TDNMSpeedButton(Sender).Caption + ' button.');
  if cbDatabase.Text = '' then begin
    MessageDlgXP_Vista('Please select the database that you wish to backup.',mtInformation,[mbOk],0);
    exit;
  end;
  UtilsClient.GetLoggedOnUserList(s, cbDatabase.Text);
  if s <> '' then begin
    MessageDlgXP_Vista('The following user(s) must exit the system: "' + s + '".',mtInformation,[mbOk],0);
    exit;
  end;
//  ShowLog;
  self.Enabled:= false;
  try
    if UtilsClient.AddUser(ERP_ADMIN_USER, cbDatabase.Text, msg,'','',false,true) then begin
      try
        if not frmDatabaseBackup.DbBackup(cbDatabase.Text,ERP_ADMIN_USER,UtilsClient,msg) then
          MessageDlgXP_Vista('Could not run backup: ' + msg,mtInformation,[mbOk],0);
      finally
        UtilsClient.RemoveUser(ERP_ADMIN_USER, cbDatabase.Text);
      end;
    end
    else
      MessageDlgXP_Vista('Could not run backup: ' + msg,mtInformation,[mbOk],0);
  finally
    self.Enabled:= true;
  end;
end;

procedure TfrModUserUtilsConfig.btnCheckLicenceClick(Sender: TObject);
begin
  inherited;
  TLogger.Inst.Log('User ' + GetCurrentWindowsUserName + ' clicked on ' + TDNMSpeedButton(Sender).Caption + ' button.');
  if UtilsClient.ForceLicenceCheck then begin
    MessageDlgXP_Vista('Request has been sent to update your licence information.' +
      #13#10 + #13#10+
      'Please close then reopen ERP to check licence status.',mtInformation,[mbOk],0);
  end
  else
    MessageDlgXP_Vista('The server failed to respond to request.',mtWarning,[mbOk],0);
end;

procedure TfrModUserUtilsConfig.btnCheckUpdateClick(Sender: TObject);
begin
  inherited;
  TLogger.Inst.Log('User ' + GetCurrentWindowsUserName + ' clicked on ' + TDNMSpeedButton(Sender).Caption + ' button.');
  if MessageDlgXP_Vista('ERP Server will now check for updates.' +
    #13#10 + #13#10+
    'Please ensure all users are logged out of ERP, then view the log for status.', mtInformation, [mbOk,mbCancel], 0) = mrCancel then
      Exit;
  if rgLoggingLevel.ItemIndex < 2 then begin
    MessageDlgXP_Vista('Changing Logging Level to Info.', mtInformation, [mbOk], 0);
    rgLoggingLevel.ItemIndex := 2;
  end;

  if UtilsClient.ForceUpdateCheck then begin
    ShowLog;
  end
  else
    MessageDlgXP_Vista('The server failed to respond to request.',mtWarning,[mbOk],0);
end;

procedure TfrModUserUtilsConfig.btnCloneClick(Sender: TObject);
var
  dbName: string;
  msg: string;
begin
  inherited;
  TLogger.Inst.Log('User ' + GetCurrentWindowsUserName + ' clicked on ' + TDNMSpeedButton(Sender).Caption + ' button.');
  if cbDatabase.ItemIndex < 0 then begin
    MessageDlgXP_Vista('Please select a database to copy.',mtInformation,[mbOk],0);
    exit;
  end;
  if not ModalInputBox('New Company DB', 'Enter New Company Database', dbName) then
    exit;
  if not ValidAlphaNumericCharacters(dbName) then begin
    MessageDlgXP_Vista('No non alphanumeric characters allowed in database name.', mtInformation, [mbOK], 0);
    exit;
  end;
  if cbDataBase.Items.IndexOf(dbName) > -1 then begin
    // It does, report error to user.
    MessageDlgXP_Vista('A Database With the Same Name Already Exists!', mtInformation, [mbOK], 0);
    Exit;
  end;


  if UtilsClient.AddUser(ERP_ADMIN_USER, cbDatabase.Text, msg,'','',false,true) then begin
    try
      if frmDatabaseBackup.DbCopy(cbDatabase.Text,dbName,ERP_ADMIN_USER,UtilsClient,msg) then begin
        cbDataBase.Items.Add(dbName);
      end
      else
        MessageDlgXP_Vista('Could not clone database: ' + msg,mtInformation,[mbOk],0);
    finally
      UtilsClient.RemoveUser(ERP_ADMIN_USER, dbName);
    end;
  end
  else
    MessageDlgXP_Vista('Could not clone database: ' + msg,mtInformation,[mbOk],0);

end;

procedure TfrModUserUtilsConfig.btnLogFileClick(Sender: TObject);
var
  fileName: string;
begin
  inherited;
  fileName := ERP_UTILITIES_LOG_DIR  + 'ERPModUserUtils_' + FormatDateTime('yyyy_mm_dd',now) + '.log';
  if FileExists(fileName) then
    ShellExecute(0,'open',PChar(fileName),nil,nil,SW_NORMAL)
  else
    MessageDlgXP_Vista('Log file not found.'#13#10+fileName, mtInformation, [mbOK], 0);
end;

procedure TfrModUserUtilsConfig.btnReadonlyCloseClick(Sender: TObject);
var
  dbName: string;
  msg: string;
begin
  inherited;
  TLogger.Inst.Log('User ' + GetCurrentWindowsUserName + ' clicked on ' + TDNMSpeedButton(Sender).Caption + ' button.');
  if cbDatabase.ItemIndex < 0 then begin
    MessageDlgXP_Vista('Please select a database to copy.',mtInformation,[mbOk],0);
    exit;
  end;
  if not ModalInputBox('New Company DB', 'Enter New Company Database', dbName) then
    exit;
  if not ValidAlphaNumericCharacters(dbName) then begin
    MessageDlgXP_Vista('No non alphanumeric characters allowed in database name.', mtInformation, [mbOK], 0);
    exit;
  end;
  if cbDataBase.Items.IndexOf(dbName) > -1 then begin
    // It does, report error to user.
    MessageDlgXP_Vista('A Database With the Same Name Already Exists!', mtInformation, [mbOK], 0);
    Exit;
  end;


  if UtilsClient.AddUser(ERP_ADMIN_USER, cbDatabase.Text, msg,'','',false,true) then begin
    try
      if frmDatabaseBackup.DbCopyRO(cbDatabase.Text,dbName,ERP_ADMIN_USER,UtilsClient,msg) then begin
        cbDataBase.Items.Add(dbName);
      end
      else
        MessageDlgXP_Vista('Could not clone database: ' + msg,mtInformation,[mbOk],0);
    finally
      UtilsClient.RemoveUser(ERP_ADMIN_USER, dbName);
    end;
  end
  else
    MessageDlgXP_Vista('Could not clone database: ' + msg,mtInformation,[mbOk],0);

end;

procedure TfrModUserUtilsConfig.btnRemoveClick(Sender: TObject);
var
  s: string;
  dbName: string;
  msg: string;
  MsgOption : Word;
  function NoBakupOption:String;
  begin
      REsult := '';
      if sametext(trim(cbDatabase.Text) , 'ErpNewDb') then  result := 'Remove Without Backing Up';
  end;
begin
  TLogger.Inst.Log('User ' + GetCurrentWindowsUserName + ' clicked on ' + TDNMSpeedButton(Sender).Caption + ' button.');
  inherited;
  MsgOption := MessageDlgXP_Vista('The Remove function Backs Up selected database then removes it from the server.' +
    #13#10 + #13#10 + #13#10 + 'REMOVE This Company Database ?', mtWarning, [mbYes, mbNo], 0 , nil , '','', false , nil ,  NoBakupOption);

  if MsgOption  = mrno then begin
    TLogger.Inst.Log('User elected not to remove database ' + cbDatabase.Text);
    exit;
  end;
  if cbDatabase.Text = '' then begin
    MessageDlgXP_Vista('Please select the database that you wish to remove.',mtInformation,[mbOk],0);
    exit;
  end;
  UtilsClient.GetLoggedOnUserList(s, cbDatabase.Text);
  if s <> '' then begin
    MessageDlgXP_Vista('The following user(s) must exit the system: "' + s + '".',mtInformation,[mbOk],0);
    TLogger.Inst.Log('Could not proceed with removal of ' + cbDatabase.Text + ' as there are users in the System.');
    exit;
  end;

  TLogger.Inst.Log('Proceeding with removal of ' + cbDatabase.Text + '.');
  dbName := cbDatabase.Text;
  if UtilsClient.AddUser(ERP_ADMIN_USER, dbName, msg,'','',false,true) then begin
    try
      if frmDatabaseBackup.DBRemove(cbDatabase.Text,ERP_ADMIN_USER,UtilsClient,msg , false, nil, MsgOption = mryes) then begin
        cbDataBase.Items.Delete(cbDataBase.Items.IndexOf(dbName));
        TLogger.Inst.Log('Removed ' + dbName + '.');
      end
      else begin
        MessageDlgXP_Vista('Could not remove database: ' + msg,mtInformation,[mbOk],0);
        TLogger.Inst.Log('Could not remove database: ' + msg);
      end;
    finally
      UtilsClient.RemoveUser(ERP_ADMIN_USER, dbName);
    end;
  end
  else begin
    MessageDlgXP_Vista('Could not remove database: ' + msg,mtInformation,[mbOk],0);
    TLogger.Inst.Log('Could not remove database: ' + msg);
  end;

end;

procedure TfrModUserUtilsConfig.btnRestoreClick(Sender: TObject);
var
  arcName, arcList, msg: string;
  dbName, userList: string;
  dbExists: boolean;

  function SplitDbName(const arcName: string): string;
  var
    x: integer;
    lastChar: string;
  begin
    x:= 1;
    lastChar:= '';
    while x <= Length(arcName) do begin
      if CharInSet(arcName[x],['0'..'9']) and (lastChar = '_') then begin
        result:= Copy(result,1,Length(result)-1);
        break;
      end
      else begin
        lastChar:= arcName[x];
        result:= result + lastChar;
        Inc(x);
      end;
    end;
  end;

begin
  inherited;
  TLogger.Inst.Log('User ' + GetCurrentWindowsUserName + ' clicked on ' + TDNMSpeedButton(Sender).Caption + ' button.');
  if not UtilsClient.GetBackupArchiveList(msg,arcList) then begin
    MessageDlgXP_Vista('Could not get backup archive list: ' + msg,mtInformation,[mbOk],0);
    TLogger.Inst.Log('Could not get backup archive list: ' + msg);
    exit;
  end;
  if frmArchiveSelect.GetArchiveName(arcList,cbDatabase.Text,arcName) then begin
    dbName:= SplitDbName(arcName);
    if not UtilsClient.GetLoggedOnUserList(userList,dbName) then begin
      MessageDlgXP_Vista('Could not get logged on user list from server.',mtInformation,[mbOk],0);
      TLogger.Inst.Log('Could not get logged on user list from server.');
      exit;
    end;
    if userList <> '' then begin
      MessageDlgXP_Vista('The following user(s) must exit the system: "' + userList + '".',mtInformation,[mbOk],0);
      TLogger.Inst.Log('The following user(s) must exit the system: "' + userList + '".');
      exit;
    end;
    dbExists := cbDataBase.Items.IndexOf(dbName) > -1;
    if dbExists then begin
      if MessageDlgXP_Vista(Format('WARNING....You are about to replace database %s ' + 'with an older version'#13#10'(%s). ' + #13#10'Do you wish to continue?', [dbName, arcName]), mtWarning, [mbYes, mbNo], 0) <> mrYes then begin
        TLogger.Inst.Log('User elected not to proceed with Restore.');
        exit;
      end;
    end
    else begin
      if MessageDlgXP_Vista(Format('Create database %s ' + #13#10'(%s). ' + #13#10'Do you wish to continue?', [dbName, arcName]), mtWarning, [mbYes, mbNo], 0) <> mrYes then begin
        TLogger.Inst.Log('User elected not to proceed with Restore.');
        exit;
      end;
    end;

    if UtilsClient.AddUser(ERP_ADMIN_USER, dbName, msg,'','',false,true) then begin
      try
        if frmDatabaseBackup.DbRestore(dbName,ERP_ADMIN_USER,arcName,dbExists,UtilsClient,msg) then begin
          if not dbExists then
            cbDataBase.Items.Add(dbName);
          TLogger.Inst.Log('User Restored ' + dbName);
        end
        else begin
          MessageDlgXP_Vista('Could not run restore: ' + msg,mtInformation,[mbOk],0);
          TLogger.Inst.Log('Could not run restore: ' + msg);
        end
      finally
        UtilsClient.RemoveUser(ERP_ADMIN_USER, dbName);
      end;
    end
    else begin
      MessageDlgXP_Vista('Could not run restore: ' + msg,mtInformation,[mbOk],0);
      TLogger.Inst.Log('Could not run restore: ' + msg);
    end;
  end;
end;

procedure TfrModUserUtilsConfig.btnShowLogClick(Sender: TObject);
begin
  inherited;
  ShowLog;
end;

function TfrModUserUtilsConfig.ConfigHasChanged(newConfig,
  cleanConfig: TJsonObject): boolean;
begin
  result := inherited;
//  result := not SameText(newConfig.S['LoggingLevel'],cleanConfig.S['LoggingLevel']);
end;

procedure TfrModUserUtilsConfig.DNMSpeedButton1Click(Sender: TObject);
var
  UpdateStore: TUpdateStore;
  ds: TDataSet;
  msg: string;
  path: string;
  Params, Cfg, J: TJsonObject;
  meth: string;
  obj: TJsonObject;
begin
  inherited;
  UpdateStore := TUpdateStore.Create;
  Params := JO;
  Cfg := JO;
  try
    meth := ModuleName;
    if meth <> '' then
      meth := meth + '.';
    meth := meth + 'GetConfig';
    j := UtilsClient.Client.SendRequest(meth,nil);
    if Assigned(j) then begin
      try
        if j.ObjectExists('result') then begin
          Cfg.Assign(j.O['result']);
        end;
      finally
        j.Free;
      end;
    end
    else begin
      Vista_MessageDlg.MessageDlgXP_Vista('Could not read configuration from ERP utilities Service.',mtWarning,[mbOk],0);
      exit;
    end;
    Params.S['OffsiteBackupConfigText'] := Cfg.S['OffsiteBackupConfigText'];
    Params.S['OffsiteRestoreConfigText'] := Cfg.S['OffsiteRestoreConfigText'];
    Params.S['ERPUtilsServer'] := self.UtilsClient.Client.ServerName;

    path := ExtractFilePath(Application.ExeName);
    Params.I['color'] := Application.MainForm.Color;
    Params.O['Position'].I['left'] := Application.MainForm.Left;
    Params.O['Position'].I['top'] := Application.MainForm.top;

    Params.SaveToFile(Path + 'OffSiteBackupConfig_Params.txt');
    UpdateStore.Server := UtilsClient.Client.ServerName;
    ds := UpdateStore.VersionUpdates('OffsiteBackupConfig','','');
    TBlobField(ds.FieldByName('File')).SaveToFile(path +'OffsiteBackupConfig.exe');
    ExecNewWinProcess(path +'OffsiteBackupConfig.exe', true, msg);
    { read back results when user has closed config form }
    Params.LoadFromFile(Path + 'OffSiteBackupConfig_Params.txt');
    if Params.I['ModalResult'] = mrOk then begin

      Cfg.S['OffsiteBackupConfigText'] := Params.S['OffsiteBackupConfigText'];
      Cfg.S['OffsiteRestoreConfigText'] := Params.S['OffsiteRestoreConfigText'];

      meth := ModuleName;
      if meth <> '' then
        meth := meth + '.';
      meth := meth + 'SetConfig';
      obj:= JO;
      obj.Assign(Cfg);
      j := UtilsClient.Client.SendRequest(meth,obj);
      if Assigned(j) then begin
        try
          if j.Exists('error') then begin
            if j.ObjectExists('error') then
              msg:= j.O['error'].S['message'];
            Vista_MessageDlg.MessageDlgXP_Vista('Could not update configuration on ERP utilities Service '+ msg,mtWarning,[mbOk],0);
          end;
        finally
          j.Free;
        end;
      end;

    end;

  finally
    UpdateStore.Free;
    Params.Free;
    Cfg.Free;
  end;
end;

function TfrModUserUtilsConfig.GetModuleConfig: boolean;
var
  j, params: TJsonObject;
  meth: string;
begin
  result := false;
  meth := ModuleName;
  if meth <> '' then
    meth := meth + '.';
  meth := meth + 'GetLoggingLevel';
  j := UtilsClient.Client.SendRequest(meth,nil);
  if Assigned(j) then begin
    try
      if j.ObjectExists('result') then begin
        Config.Assign(j.O['result']);
        ConfigClean.Assign(j.O['result']);
        result := true;
        Loading := true;
        try
          AfterGetModuleConfig;
        finally
          Loading := false;
        end;
      end;
    finally
      j.Free;
    end;
  end;
  if not result then exit;

  j := UtilsClient.Client.SendRequest(GetModuleName + '.getdatabaselist',nil);
  if Assigned(j) then begin
    try
      if j.StringExists('result') then begin
        cbDatabase.Items.CommaText := j.S['result'];
        (*
         {Dene asked to leave it - as need an option to drop it and restore a fresh one -
         one of the client data was currupted and couldn;t backup - and there was no option to restore a new one}
        { remove erpnewdb }
        if cbDatabase.Items.IndexOf('erpnewdb') > -1 then
          cbDatabase.Items.Delete(cbDatabase.Items.IndexOf('erpnewdb'));*)

        if cbDatabase.Items.Count > 0 then
          cbDatabase.ItemIndex := 0;
      end;
    finally
      j.Free;
    end;
  end;
end;

function TfrModUserUtilsConfig.GetModuleName: string;
begin
  result := 'ERPModUserUtils';
end;

procedure TfrModUserUtilsConfig.rgLoggingLevelClick(Sender: TObject);
begin
  inherited;
  if Loading then exit;
  Config.S['LoggingLevel'] := LoggingLevelToStr(TLoggingLevel(rgLoggingLevel.ItemIndex));
  VerifyAndSetModuleConfig;
//    if not self.VerifyAndSetModuleConfig then
//    if not self.SetModuleConfig then
//      MessageDlgXP_Vista('Error sending configuration changes to server.',mtInformation,[mbOk],0);
end;

function TfrModUserUtilsConfig.SetModuleConfig(var msg: string): boolean;
var
  j, obj: TJsonObject;
  meth: string;
begin
  result := true;
  meth := ModuleName;
  if meth <> '' then
    meth := meth + '.';
  meth := meth + 'SetLoggingLevel';
  obj:= JO;
  obj.Assign(Config);
  j := UtilsClient.Client.SendRequest(meth,obj);
  if Assigned(j) then begin
    try
      if j.Exists('error') then begin
        result := false;
        if j.ObjectExists('error') then
          msg:= j.O['error'].S['message'];
      end;
    finally
      j.Free;
    end;
  end;
  if result then
    ConfigClean.Assign(Config);
end;

function TfrModUserUtilsConfig.VerifyAndSetModuleConfig: boolean;
var
  j: TJsonObject;
  meth: string;
  msg: string;
begin
  meth := ModuleName;
  if meth <> '' then
    meth := meth + '.';
  meth := meth + 'GetLoggingLevel';
  j := UtilsClient.Client.SendRequest(meth,nil);
  if Assigned(j) then begin
    try
      if j.ObjectExists('result') then begin
        if ConfigHasChanged(j.O['result'],ConfigClean) then begin
          Vista_MessageDlg.MessageDlgXP_Vista('The configuration has been changed (possibly by another user), the new configuration will be loaded and your changes will need to be re-applied.',mtInformation,[mbOk],0);
          result := GetModuleConfig;
        end
        else begin
          result := SetModuleConfig(msg);
          if (not result) and (msg <> '') then
            Vista_MessageDlg.MessageDlgXP_Vista(msg,mtInformation,[mbOk],0);

        end;
      end
      else begin
       result := false;
      end;
    finally
      j.Free;
    end;
  end
  else begin
    result := false;
  end;
end;

end.
