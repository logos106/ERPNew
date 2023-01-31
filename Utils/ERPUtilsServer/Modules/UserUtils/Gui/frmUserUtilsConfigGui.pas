unit frmUserUtilsConfigGui;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmModuleConfigBase, Buttons, StdCtrls, Shader, DNMPanel,
  ExtCtrls, AdvPageControl, ComCtrls, DNMSpeedButton, ModuleBaseClientObj;

type
  TfmUserUtilsConfigGui = class(TfmModuleConfigBase)
    Label3: TLabel;
    cbDataBase: TComboBox;
    pcBackup: TAdvPageControl;
    AdvTabSheet1: TAdvTabSheet;
    btnBackup: TDNMSpeedButton;
    AdvTabSheet2: TAdvTabSheet;
    lbRestore: TLabel;
    Label5: TLabel;
    lbArchive: TListBox;
    cbShowAllDBs: TCheckBox;
    btnRestore: TDNMSpeedButton;
    AdvTabSheet3: TAdvTabSheet;
    btnClone: TDNMSpeedButton;
    btnRemove: TDNMSpeedButton;
    tabLog: TAdvTabSheet;
    memLog: TMemo;
    tabLicence: TAdvTabSheet;
    btnCheckLicence: TDNMSpeedButton;
    tabUpdate: TAdvTabSheet;
    btnCheckUpdate: TDNMSpeedButton;
    btnReadonlyClose: TDNMSpeedButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    procedure btnBackupClick(Sender: TObject);
    procedure cbShowAllDBsClick(Sender: TObject);
    procedure cbDataBaseChange(Sender: TObject);
    procedure btnRestoreClick(Sender: TObject);
    procedure btnCloneClick(Sender: TObject);
    procedure btnRemoveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCheckLicenceClick(Sender: TObject);
    procedure btnCheckUpdateClick(Sender: TObject);
  private
    LogFileName: string;
    function CopyDatabase(Sender : TObject; sDbname,sNewDbName:String ; var msg:string):boolean;
  protected
    procedure SetModule(const Value: TModuleBaseClient); override;
  public
    procedure UpdateArchiveList;
    procedure Log(msg: string);
  end;

var
  fmUserUtilsConfigGui: TfmUserUtilsConfigGui;

implementation

{$R *.dfm}

uses
  Vista_MessageDlg, ModuleUserUtilsGuiObj, ModalInputBoxGUI;


procedure TfmUserUtilsConfigGui.btnBackupClick(Sender: TObject);
var
  s, msg: string;
begin
  inherited;
  if cbDatabase.Text = '' then begin
    MessageDlgXP_Vista('Please select the database that you wish to backup.',mtInformation,[mbOk],0);
    exit;
  end;
  s:= TModuleUserUtilsGui(Module).GetDatabaseUserList(cbDatabase.Text);
  if s <> '' then begin
    MessageDlgXP_Vista('The following user(s) must exit the system: "' + s + '".',mtInformation,[mbOk],0);
    exit;
  end;
  pcBackup.ActivePage:= tabLog;
  Application.ProcessMessages;
  pnlMain.Enabled:= false;
  try
    Log(FormatDateTime('dd/mm/yyyy hh:nn:ss',now) + ' Backup of ' + cbDatabase.Text + ' started ...');
    if not TModuleUserUtilsGui(Module).BackupDatabase(cbDatabase.Text,msg) then begin
      Log(FormatDateTime('dd/mm/yyyy hh:nn:ss',now) + ' Backup failed with message: ' + msg);
//      MessageDlgXP_Vista('The backup failed with message: ' + msg,mtInformation,[mbOk],0);
    end
    else begin
      TModuleUserUtilsGui(Module).PopulateArchiveList;
      UpdateArchiveList;
      Log(FormatDateTime('dd/mm/yyyy hh:nn:ss',now) + ' Backup complete');
//      MessageDlgXP_Vista('Backup complete.',mtInformation,[mbOk],0);
    end;
  finally
    pnlMain.Enabled:= true;
  end;
end;

procedure TfmUserUtilsConfigGui.UpdateArchiveList;
begin
  if cbShowAllDBs.Checked then begin
    TModuleUserUtilsGui(Module).AddArchivesToList(lbArchive.Items,'');
  end
  else begin
    TModuleUserUtilsGui(Module).AddArchivesToList(lbArchive.Items,cbDataBase.Text);
  end;
end;

procedure TfmUserUtilsConfigGui.cbShowAllDBsClick(Sender: TObject);
begin
  inherited;
  UpdateArchiveList;
end;

procedure TfmUserUtilsConfigGui.cbDataBaseChange(Sender: TObject);
begin
  inherited;
  UpdateArchiveList;
  btnClone.Enabled := not SameText(cbDatabase.Text,'erpnewdb');
  btnRemove.Enabled := not SameText(cbDatabase.Text,'erpnewdb');
end;

procedure TfmUserUtilsConfigGui.btnRestoreClick(Sender: TObject);
var
  s, msg, arcName, dbName: string;

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
  if lbArchive.ItemIndex < 0 then begin
    MessageDlgXP_Vista('Please select an archive to restore.',mtInformation,[mbOk],0);
    exit;
  end;
  s:= TModuleUserUtilsGui(Module).GetDatabaseUserList(cbDatabase.Text);
  if s <> '' then begin
    MessageDlgXP_Vista('The following user(s) must exit the system: "' + s + '".',mtInformation,[mbOk],0);
    exit;
  end;
  arcName:= lbArchive.Items[lbArchive.ItemIndex];
  dbName:= SplitDbName(arcName);

  if cbDataBase.Items.IndexOf(dbName) > -1 then begin
    if MessageDlgXP_Vista(Format('WARNING....You are about to replace database %s ' + 'with an older version'#13#10'(%s). ' + #13#10'Do you wish to continue?', [dbName, arcName]), mtWarning, [mbYes, mbNo], 0) <> mrYes then begin
      exit;
    end;
  end
  else begin
    if MessageDlgXP_Vista(Format('Create database %s ' + #13#10'(%s). ' + #13#10'Do you wish to continue?', [dbName, arcName]), mtWarning, [mbYes, mbNo], 0) <> mrYes then begin
      exit;
    end;
  end;
  pcBackup.ActivePage:= tabLog;
  Application.ProcessMessages;
  pnlMain.Enabled:= false;
  try
    Log(FormatDateTime('dd/mm/yyyy hh:nn:ss',now) + ' Restore of ' + arcName + ' to database ' + dbName + ' started ...');
    if not TModuleUserUtilsGui(Module).RestoreDatabase(dbName,arcName,msg) then begin
      Log(FormatDateTime('dd/mm/yyyy hh:nn:ss',now) + ' Restore failed with message: ' + msg);
//      MessageDlgXP_Vista('The restore failed with message: ' + msg,mtInformation,[mbOk],0);
    end
    else begin
      TModuleUserUtilsGui(Module).PopulateDatabaseList;
      Log(FormatDateTime('dd/mm/yyyy hh:nn:ss',now) + ' Restore complete.');
      MessageDlgXP_Vista('Restore complete.' + #13#10 + #13#10 +
        'ERP will now check this database for updates, please do not log in ' +
        'to ERP untill updating has finished as per the Log tab on the ' +
        'ERP Service Menu.',mtInformation,[mbOk],0);
    end;
  finally
    pnlMain.Enabled:= true;
  end;
end;

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
function TfmUserUtilsConfigGui.CopyDatabase(Sender : TObject; sDbname,sNewDbName:String ; var msg:string):boolean;
begin
  if sender = btnClone then begin
    result := TModuleUserUtilsGui(Module).CopyDatabase(sDbName,sNewDbName,msg);
  end else begin
    result := TModuleUserUtilsGui(Module).CopyDatabaseRO(sDbName,sNewDbName,msg);
  end;
end;

procedure TfmUserUtilsConfigGui.btnCloneClick(Sender: TObject);
var
  sNewDbName, msg: string;

  function DBExists(aDbName: string): boolean;
  begin
    result:= cbDataBase.Items.IndexOf(aDbName) > -1;
  end;

begin
  inherited;
  if cbDatabase.ItemIndex < 0 then begin
    MessageDlgXP_Vista('Please select a database to copy.',mtInformation,[mbOk],0);
    exit;
  end;
  if not ModalInputBox('New Company DB', 'Enter New Company Database', sNewDBName) then
    exit;
  if not ValidAlphaNumericCharacters(sNewDBName) then begin
    MessageDlgXP_Vista('No non alphanumeric characters allowed in Database name.', mtInformation, [mbOK], 0);
    exit;
  end;
  if DBExists(sNewDBName) then begin
    // It does, report error to user.
    MessageDlgXP_Vista('A Database With the Same Name Already Exists!', mtInformation, [mbOK], 0);
    Exit;
  end;
  pcBackup.ActivePage:= tabLog;
  Application.ProcessMessages;
  pnlMain.Enabled:= false;
  try
    Log(FormatDateTime('dd/mm/yyyy hh:nn:ss',now) + ' Copy of ' + cbDatabase.Text + ' to new database ' + sNewDbName + ' started ...');
    if not CopyDatabase(sender, cbDatabase.Text,sNewDbName,msg) then begin
      Log(FormatDateTime('dd/mm/yyyy hh:nn:ss',now) + ' Copy failed with message: ' + msg);
//      MessageDlgXP_Vista('The copy failed with message: ' + msg,mtInformation,[mbOk],0);
    end
    else begin
      TModuleUserUtilsGui(Module).PopulateDatabaseList;
      Log(FormatDateTime('dd/mm/yyyy hh:nn:ss',now) + ' Copy complete.');
//      MessageDlgXP_Vista('Clone complete.',mtInformation,[mbOk],0);
    end;
  finally
    pnlMain.Enabled:= true;
  end;
end;

procedure TfmUserUtilsConfigGui.btnRemoveClick(Sender: TObject);
var
  s, msg: string;
begin
  inherited;
  if MessageDlgXP_Vista('The Remove function back''s up selected database then removes it from the server.' +
    #13#10 + #13#10 + #13#10 + 'REMOVE This Company Database ?', mtWarning, [mbYes, mbNo], 0) <> mrYes then
    exit;
  if cbDatabase.Text = '' then begin
    MessageDlgXP_Vista('Please select the database that you wish to remove.',mtInformation,[mbOk],0);
    exit;
  end;
  s:= TModuleUserUtilsGui(Module).GetDatabaseUserList(cbDatabase.Text);
  if s <> '' then begin
    MessageDlgXP_Vista('The following user(s) must exit the system: "' + s + '".',mtInformation,[mbOk],0);
    exit;
  end;
  pcBackup.ActivePage:= tabLog;
  Application.ProcessMessages;
  pnlMain.Enabled:= false;
  try
    Log(FormatDateTime('dd/mm/yyyy hh:nn:ss',now) + ' Removal of ' + cbDatabase.Text + ' started ...');
    if not TModuleUserUtilsGui(Module).RemoveDatabase(cbDatabase.Text,msg) then begin
      Log(FormatDateTime('dd/mm/yyyy hh:nn:ss',now) + ' Removal failed with message ' + msg);
      MessageDlgXP_Vista('The copy failed with message: ' + msg,mtInformation,[mbOk],0);
    end
    else begin
      TModuleUserUtilsGui(Module).PopulateDatabaseList;
      Log(FormatDateTime('dd/mm/yyyy hh:nn:ss',now) + ' Removal complete.');
      MessageDlgXP_Vista('Remove complete.',mtInformation,[mbOk],0);
    end;
  finally
    pnlMain.Enabled:= true;
  end;
end;

procedure TfmUserUtilsConfigGui.Log(msg: string);
begin
  while memLog.Lines.Count > 1000 do
    memLog.Lines.Delete(0);
  if Pos('Download progress:',msg) > 0 then begin
    if (memLog.Lines.Count > 0) and (Pos('Download progress:',memLog.Lines[memLog.Lines.Count-1]) > 0) then
      memLog.Lines[memLog.Lines.Count-1]:= msg
    else
      memLog.Lines.Add(msg);
  end
  else
    memLog.Lines.Add(msg);
end;

procedure TfmUserUtilsConfigGui.FormDestroy(Sender: TObject);
begin
  inherited;
//  memLog.Lines.SaveToFile(LogFileName);
end;

procedure TfmUserUtilsConfigGui.SetModule(const Value: TModuleBaseClient);
begin
  inherited;
  LogFileName:= ExtractFilePath(Application.ExeName) + Module.ModuleName + '_Log.txt';
//  if FileExists(LogFileName) then
//    memLog.Lines.LoadFromFile(LogFileName);
  pnlMain.BringToFront;
end;

procedure TfmUserUtilsConfigGui.btnCheckLicenceClick(Sender: TObject);
begin
  inherited;
  if TModuleUserUtilsGui(Module).ForceLicenceCheck then begin
    MessageDlgXP_Vista('Request has been sent to update your licence information.' +
      #13#10 + #13#10+
      'Please close then reopen ERP to check licence status.',mtInformation,[mbOk],0);
    pcBackup.ActivePage:= tabLog;
  end
  else
    MessageDlgXP_Vista('The server failed to respond to request.',mtWarning,[mbOk],0);
end;

procedure TfmUserUtilsConfigGui.btnCheckUpdateClick(Sender: TObject);
begin
  inherited;
  MessageDlgXP_Vista('ERP Server will now check for updates.' +
    #13#10 + #13#10+
    'Please ensure all users are logged out of ERP, then view the log tab for status.',mtInformation,[mbOk],0);
  if TModuleUserUtilsGui(Module).ForceUpdateCheck then begin
    pcBackup.ActivePage:= tabLog;
  end
  else
    MessageDlgXP_Vista('The server failed to respond to request.',mtWarning,[mbOk],0);
end;

initialization
  RegisterClass(TfmUserUtilsConfigGui);


end.
