unit ModuleUserUtilsGuiObj;

interface

uses
  ModuleBaseClientObj, forms, JsonRpcBase, JsonObject, UserUtilsClientObj,
  classes;


type

  TModuleUserUtilsGui = class(TModuleBaseClient)
  private
    UtilsClient: TUserUtilsClient;
    procedure Log(msg: string);

  protected
    function GetGuiForm: TForm; override;
    procedure DoChange; override;
    procedure SetConnected(const Value: boolean); override;
    procedure SetActive(const Value: boolean); override;
  public
    BackupArchiveList: TStringList;
    constructor Create; override;
    destructor Destroy; override;
    procedure DoRequest(Client: TJsonRpcBase; RequestJson: TJsonObject;
      ResponseJson: TJsonObject = nil); override;
    function GetDatabaseUserList(const aDatabaseName: string): string;
    function BackupDatabase(const aDatabaseName: string; var msg: string): boolean;
    function RestoreDatabase(const aDatabaseName, aArchiveName: string; var msg: string): boolean;
    function CopyDatabase(const aDatabaseName, aNewDatabaseName: string; var msg: string): boolean;
    function CopyDatabaseRO(const aDatabaseName, aNewDatabaseName: string;var msg: string): boolean;
    function RemoveDatabase(const aDatabaseName: string; var msg: string): boolean;
    procedure AddArchivesToList(list: TStrings; aDbName: string);
    procedure PopulateDatabaseList;
    procedure PopulateArchiveList;
    function ForceLicenceCheck: boolean;
    function ForceUpdateCheck: boolean;
  published
  end;

  function GetModule(MainAppInst: TApplication): TModuleBaseClient;


implementation

uses
  frmUserUtilsConfigGui, ModuleBaseObj, JsonToObject, sysutils, ModuleConst,
  frmDatabaseBackup;

var
  fModuleUserUtilsGui: TModuleUserUtilsGui;

function GetModule(MainAppInst: TApplication): TModuleBaseClient;
begin
  fModuleUserUtilsGui.AppInst:= MainAppInst;
  result:= fModuleUserUtilsGui;
end;




{ TModuleUserUtilsGui }

procedure TModuleUserUtilsGui.AddArchivesToList(list: TStrings;
  aDbName: string);
var
  x: integer;
begin
  if aDBName = '' then begin
    list.Assign(BackupArchiveList);
  end
  else begin
    list.Clear;
    for x:= 0 to BackupArchiveList.Count -1 do begin
      if Pos(aDbName,BackupArchiveList[x]) = 1 then
        list.Add(BackupArchiveList[x]);
    end;
  end;
end;

function TModuleUserUtilsGui.BackupDatabase(const aDatabaseName: string; var msg: string): boolean;
begin
  result:= false;
  UtilsClient.Connect(Client.ServerName,ERP_ADMIN_USER);
  try
    if UtilsClient.AddUser(ERP_ADMIN_USER, aDatabaseName, msg) then begin
      result:= frmDatabaseBackup.DbBackup(aDatabaseName,ERP_ADMIN_USER,UtilsClient,msg);
//      if UtilsClient.LockLogon(msg, aDatabaseName, 'Performing a Backup DB') then begin
//        try
//          if UtilsClient.DatabaseBackup(Client.ServerName,aDatabaseName,msg) then begin
//            result:= true;
//          end;
//        finally
//          UtilsClient.UnlockLogon;
//        end;
//      end;
    end;
  finally
    UtilsClient.Disconnect;
  end;
end;

function TModuleUserUtilsGui.RestoreDatabase(const aDatabaseName,
  aArchiveName: string; var msg: string): boolean;
begin
  result:= false;
  UtilsClient.Connect(Client.ServerName,ERP_ADMIN_USER);
  try
    if UtilsClient.AddUser(ERP_ADMIN_USER, aDatabaseName, msg) then begin
      result:= frmDatabaseBackup.DbRestore(aDatabaseName,ERP_ADMIN_USER,aArchiveName,true,UtilsClient,msg);
//      if UtilsClient.LockLogon(msg, aDatabaseName, 'Performing a Restore DB') then begin
//        try
//          if UtilsClient.DatabaseRestore(Client.ServerName,aDatabaseName,aArchiveName,msg) then begin
//            result:= true;
//          end;
//        finally
//          UtilsClient.UnlockLogon;
//        end;
//      end;
    end;
  finally
    UtilsClient.Disconnect;
  end;
end;

function TModuleUserUtilsGui.CopyDatabase(const aDatabaseName,
  aNewDatabaseName: string; var msg: string): boolean;
begin
  result:= false;
  UtilsClient.Connect(Client.ServerName,ERP_ADMIN_USER);
  try
    if UtilsClient.AddUser(ERP_ADMIN_USER, aDatabaseName, msg) then begin
      result:= frmDatabaseBackup.DbCopy(aDatabaseName,aNewDatabaseName,ERP_ADMIN_USER,UtilsClient,msg);
//      if UtilsClient.LockLogon(msg, aDatabaseName, 'Performing a Copy DB') then begin
//        try
//          if UtilsClient.DatabaseCopy(Client.ServerName,aDatabaseName,aNewDatabaseName,msg) then begin
//            result:= true;
//          end;
//        finally
//          UtilsClient.UnlockLogon;
//        end;
//      end;
    end;
  finally
    UtilsClient.Disconnect;
  end;
end;
function TModuleUserUtilsGui.CopyDatabaseRO(const aDatabaseName,  aNewDatabaseName: string; var msg: string): boolean;
begin
  result:= false;
  UtilsClient.Connect(Client.ServerName,ERP_ADMIN_USER);
  try
    if UtilsClient.AddUser(ERP_ADMIN_USER, aDatabaseName, msg) then begin
      result:= frmDatabaseBackup.DbCopyRO(aDatabaseName,aNewDatabaseName,ERP_ADMIN_USER,UtilsClient,msg);
    end;
  finally
    UtilsClient.Disconnect;
  end;
end;

function TModuleUserUtilsGui.RemoveDatabase(const aDatabaseName: string;
  var msg: string): boolean;
begin
  result:= false;
  UtilsClient.Connect(Client.ServerName,ERP_ADMIN_USER);
  try
    if UtilsClient.AddUser(ERP_ADMIN_USER, aDatabaseName, msg) then begin
      result:= frmDatabaseBackup.DbRemove(aDatabaseName,ERP_ADMIN_USER,UtilsClient,msg);
//      if UtilsClient.LockLogon(msg, aDatabaseName, 'Performing a Remove DB') then begin
//        try
//          if UtilsClient.DatabaseRemove(Client.ServerName,aDatabaseName,msg) then begin
//            result:= true;
//          end;
//        finally
//          UtilsClient.UnlockLogon;
//        end;
//      end;
    end;
  finally
    UtilsClient.Disconnect;
  end;
end;


constructor TModuleUserUtilsGui.Create;
begin
  inherited;
  BackupArchiveList:= TStringList.Create;
  ServerModuleClassName:= 'TModuleUserUtils';
  UtilsClient:= TUserUtilsClient.Create;

end;

destructor TModuleUserUtilsGui.Destroy;
begin
  UtilsClient.Free;
  BackupArchiveList.Free;
  inherited;
end;

procedure TModuleUserUtilsGui.DoChange;
begin
  inherited;

end;

procedure TModuleUserUtilsGui.DoRequest(Client: TJsonRpcBase; RequestJson,
  ResponseJson: TJsonObject);
var
  method, eventname, value: string;
//  form: TfmUserUtilsConfigGui;
begin
//  form:= TfmUserUtilsConfigGui(self.GuiForm);
  method:= RequestJson.S['method'];
  if method = 'event' then begin
    eventname:= RequestJson.O['params'].S['eventname'];
    if eventname = 'Log' then begin
      value:= RequestJson.O['params'].S['value'];
      Log(value);
    end;
  end
  else begin
    Log('Unknown method: ' + method);

  end;
end;

function TModuleUserUtilsGui.GetDatabaseUserList(
  const aDatabaseName: string): string;
var
  UserList: string;
begin
  UserList:= '';
  UtilsClient.Connect(Client.ServerName,ERP_ADMIN_USER);
  try
    UtilsClient.GetLoggedOnUserList(UserList, aDatabaseName);
  finally
    UtilsClient.Disconnect;
  end;
  result:= UserList;
end;

function TModuleUserUtilsGui.GetGuiForm: TForm;
begin
  if not Assigned(fGuiForm) then begin
    fGuiForm:= TfmUserUtilsConfigGui.Create(nil);
    TfmUserUtilsConfigGui(fGuiForm).Module:= self;
    TfmUserUtilsConfigGui(fGuiForm).lblTitle.Caption:= 'Utilities'; //self.ModuleName;
    fGuiForm.OnDestroy:= self.DoGuiFormDestroy;
  end;
  result:= fGuiForm;
end;

procedure TModuleUserUtilsGui.Log(msg: string);
begin
  TfmUserUtilsConfigGui(fGuiForm).Log(msg);

end;

procedure TModuleUserUtilsGui.PopulateArchiveList;
var
  msg, list: string;
begin
  UtilsClient.Connect(Client.ServerName,ERP_ADMIN_USER);
  try
    if UtilsClient.GetBackupArchiveList(msg,list) then begin
//      TfmUserUtilsConfigGui(GuiForm).lbArchive.Items.CommaText:= list;
      BackupArchiveList.CommaText:= list;
      BackupArchiveList.Sort;
    end
    else begin



    end;
  finally
    UtilsClient.Disconnect;
  end;
end;

procedure TModuleUserUtilsGui.PopulateDatabaseList;
begin
  UtilsClient.Connect(Client.ServerName,ERP_ADMIN_USER);
  try
    TfmUserUtilsConfigGui(GuiForm).cbDataBase.Items.CommaText:= UtilsClient.GetDatabaseList(Client.ServerName);
  finally
    UtilsClient.Disconnect;
  end;
  if TfmUserUtilsConfigGui(GuiForm).cbDataBase.Items.Count > 0 then begin
    TfmUserUtilsConfigGui(GuiForm).cbDataBase.ItemIndex:= 0;
    TfmUserUtilsConfigGui(GuiForm).UpdateArchiveList;
  end;
end;

procedure TModuleUserUtilsGui.SetActive(const Value: boolean);
begin
  inherited;

end;

procedure TModuleUserUtilsGui.SetConnected(const Value: boolean);
var
  resp: TJsonObject;
begin
  inherited;
  if Value then begin
    PopulateArchiveList;
    PopulateDatabaseList;

  resp:= Client.SendRequest('UserUtils.RegisterForNotification',nil);
  try
    if Assigned(resp) then begin

    end;
  finally
    resp.Free;
  end;


  end;
end;

function TModuleUserUtilsGui.ForceLicenceCheck: boolean;
var
  resp: TJsonObject;
begin
  result:= false;
  resp:= Client.SendRequest('UserUtils.forcelicencecheck',nil);
  try
    if Assigned(resp) then begin
      result:= resp.BooleanExists('result') and resp.B['result'];
    end;
  finally
    resp.Free;
  end;
end;

function TModuleUserUtilsGui.ForceUpdateCheck: boolean;
var
  resp: TJsonObject;
begin
  result:= false;
  resp:= Client.SendRequest('UserUtils.forceupdatecheck',nil);
  try
    if Assigned(resp) then begin
      result:= resp.BooleanExists('result') and resp.B['result'];
    end;
  finally
    resp.Free;
  end;
end;

initialization
  if not Assigned(fModuleUserUtilsGui) then
    fModuleUserUtilsGui:= TModuleUserUtilsGui.Create;


finalization
  fModuleUserUtilsGui.Free;
  fModuleUserUtilsGui:= nil;

end.
