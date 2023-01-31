unit frmdebugDB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DNMSpeedButton, ProgressDialog, DB, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog, Menus, ExtCtrls, StdCtrls;

type
  TfmdebugDB = class(TBaseInputGUI)
    DNMSpeedButton1: TDNMSpeedButton;
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmdebugDB: TfmdebugDB;

implementation

{$R *.dfm}

procedure TfmdebugDB.DNMSpeedButton1Click(Sender: TObject);
begin
(*var
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
  end;*)

end;

end.
