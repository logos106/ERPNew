program ErrTrack;

uses
  FastMM4,
  ExcMagic,
  ExcMagicGUI,
  Forms,
  BaseForm in 'BasesForms\BaseForm.pas' {BaseFormGUI},
  BaseDataMod in 'BasesForms\BaseDataMod.pas' {BaseDataModule: TDataModule},
  BaseInputForm in 'BasesForms\BaseInputForm.pas' {BaseInputGUI},
  BaseListingForm in 'BasesForms\BaseListingForm.pas' {BaseListingGUI},
  FuncLib in 'CommonUnits\FuncLib.pas',
  FormFactory in 'CommonUnits\FormFactory.pas',
  Main in 'GeneralForms\Main.pas' {MainGUI},
  Menu in 'GeneralForms\Menu.pas' {MenuGUI},
  Login in 'GeneralForms\Login.pas' {LoginGUI},
  DBBackupObj in 'Objects\DBBackupObj.pas',
  CustomFilterGUI in 'InputForms\CustomFilterGUI.pas' {CustomFilter},
  UsersFilterListGUI in 'ListsForms\UsersFilterListGUI.pas' {UsersFilterList},
  ExceptionEmailsLib in 'CommonUnits\ExceptionEmailsLib.pas',
  ExceptionEmailsListGUI in 'ListsForms\ExceptionEmailsListGUI.pas' {ExceptionEmailsList},
  ExceptionEmailGUI in 'InputForms\ExceptionEmailGUI.pas' {ExceptionEmail},
  InternalExceptions in 'CommonUnits\InternalExceptions.pas',
  DataTreeObj in 'CustomiseForms\DataTreeObj.pas',
  GuiPrefsObj in 'CustomiseForms\GuiPrefs\Objects\GuiPrefsObj.pas',
  frmFormGuiPrefsEdit in 'CustomiseForms\GuiPrefs\Forms\frmFormGuiPrefsEdit.pas' {fmFormGuiPrefsEdit},
  frameGuiElementEdit in 'CustomiseForms\GuiPrefs\Forms\frameGuiElementEdit.pas' {frGuiElementEdit: TFrame},
  frameWwDbGridGuiEdit in 'CustomiseForms\GuiPrefs\Forms\frameWwDbGridGuiEdit.pas' {frWwDbGridGuiEdit: TFrame},
  UserGUI in 'InputForms\UserGUI.pas' {User},
  UserInfoObj in 'Objects\UserInfoObj.pas',
  UserListGUI in 'ListsForms\UserListGUI.pas' {UsersList};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Error Tracking';
  Application.CreateForm(TMainGUI, MainGUI);
  Application.Run;
end.
