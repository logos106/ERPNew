unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Menus, ImgList, kbmMemTable, kbmMemBinaryStreamFormat,
  DB, Grids, Wwdbigrd, Wwdbgrid, BaseForm, AdvMenus, AdvMenuStylers,
  ExtCtrls, AdvNavBar, rwButtonArray, StdCtrls, DNMPanel,
  AdvOfficeStatusBar, AdvOfficeStatusBarStylers;

type
  TMainGUI = class(TBaseFormGUI)
    ImageList: TImageList;
    MainMenu: TAdvMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Utilities1: TMenuItem;
    Backup1: TMenuItem;
    Restore1: TMenuItem;
    Window1: TMenuItem;
    ile1: TMenuItem;
    Cascade1: TMenuItem;
    ArrangeAll1: TMenuItem;
    AdvMenuFantasyStyler: TAdvMenuFantasyStyler;
    ExceptionEmails1: TMenuItem;
    ExceptionEmailList1: TMenuItem;
    DownloadEmails1: TMenuItem;
    StatusBar: TAdvOfficeStatusBar;
    AdvOfficeStatusBarOfficeStyler1: TAdvOfficeStatusBarOfficeStyler;
    procedure FormShow(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure ile1Click(Sender: TObject);
    procedure Cascade1Click(Sender: TObject);
    procedure ArrangeAll1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Backup1Click(Sender: TObject);
    procedure UserList1Click(Sender: TObject);
    procedure NewUser1Click(Sender: TObject);
    procedure Restore1Click(Sender: TObject);
    procedure UsersFilterList1Click(Sender: TObject);
    procedure ExceptionEmailList1Click(Sender: TObject);
    procedure DownloadEmails1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    FileName:String;
    OriginalCaption:String;
  public
    { Public declarations }
    AllowClose:Boolean;    
    Procedure SetCaption;    
  end;

var
  MainGUI: TMainGUI;  

{ TMainGUI }

implementation
  uses Menu,Login,FuncLib, BaseDataMod, DBBackupObj,
       UserGUI, UserListGUI, UsersFilterListGUI,
       ExceptionEmailsLib,ExceptionEmailsListGUI;

{$R *.dfm}

procedure TMainGUI.FormShow(Sender: TObject);
begin
  Application.ProcessMessages;
  Refresh;
  If not Assigned(MenuGUI) then Begin
    MenuGUI := TMenuGUI.Create(Self);
    MenuGUI.Top := (Screen.Height - MenuGUI.Height - (self.ClientOrigin.Y*2)) div 2;
    MenuGUI.Left := (Screen.Width - MenuGUI.Width) div 2;    
    MenuGUI.Show;
  end;    
  BaseDataModule.StartCheckEmailTimer;
end;

procedure TMainGUI.Exit1Click(Sender: TObject);
begin
  AllowClose := True;
  Close;
end;

procedure TMainGUI.ile1Click(Sender: TObject);
begin
  Tile;
end;

procedure TMainGUI.Cascade1Click(Sender: TObject);
begin
  Cascade;
end;

procedure TMainGUI.ArrangeAll1Click(Sender: TObject);
begin
  ArrangeIcons;
end;

procedure TMainGUI.FormCreate(Sender: TObject);
begin
  // Login
  with TLoginGUI.Instance do begin
    ShowModal;
  end;
  AllowClose := False;  
end;

procedure TMainGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMainGUI.SetCaption;
begin
  If Empty(OriginalCaption) then Begin
    OriginalCaption :=Self.Caption;
  end;
  Self.Caption := OriginalCaption + '  -  (' + ExtractFileName(FileName)+')' ;
  Application.Title := Self.Caption;
end;

procedure TMainGUI.Backup1Click(Sender: TObject);
Var DBBackup: TDBBackupObj;
    Save_Cursor:TCursor;
begin
  inherited;
  Save_Cursor := Screen.Cursor;
  DBBackup := TDBBackupObj.Create(Self);
  try
    Screen.Cursor := crHourGlass;
    DBBackup.Init(BaseDataModule.NonTransDBConnection.Server,
                 BaseDataModule.NonTransDBConnection.Database,
                 Username,
                 Password);
    Application.ProcessMessages;
    DBBackup.doBackup(ExtractFilePath(Application.ExeName)+'Backup\');
  finally
    DBBackup.Free;
    Screen.Cursor := Save_Cursor;
  end;
end;

procedure TMainGUI.UserList1Click(Sender: TObject);
begin
  inherited;
  if not Assigned(UsersList) then begin
    UsersList := TUsersList.Create(Application);
    UsersList.FormStyle := fsMDIChild;
    UsersList.BringToFront;
  end else begin
    UsersList.Show;
  end;
end;

procedure TMainGUI.NewUser1Click(Sender: TObject);
begin
  inherited;
  with TUser.Instance do begin
    FormStyle := fsMDIChild;
    BringToFront;
  end;
end;

procedure TMainGUI.Restore1Click(Sender: TObject);
Var DBBackup: TDBBackupObj;
    OpenDialog: TOpenDialog;
    Save_Cursor:TCursor;
begin
  inherited;
  Save_Cursor := Screen.Cursor;
  OpenDialog := TOpenDialog.Create(Self);
  DBBackup := TDBBackupObj.Create(Self);
  try
    Screen.Cursor := crHourGlass;
    OpenDialog.Title := 'Select Backup To Restore';
    OpenDialog.Filter := 'Backup (*.zip) | *.zip';
    If OpenDialog.Execute then Begin
      DBBackup.Init(BaseDataModule.NonTransDBConnection.Server,
                   BaseDataModule.NonTransDBConnection.Database,
                   Username,
                   Password);
      Application.ProcessMessages;
      If FileExists(OpenDialog.FileName) Then
        DBBackup.doRestore(OpenDialog.FileName)
      else
        MessageDlg('File Does Not Exist !', mtWarning, [mbOK], 0);
    end;
  finally
    DBBackup.Free;
    OpenDialog.Free;
    Screen.Cursor := Save_Cursor;
  end;
end;

procedure TMainGUI.UsersFilterList1Click(Sender: TObject);
begin
  inherited;
  if not Assigned(UsersFilterList) then begin
    UsersFilterList := TUsersFilterList.Create(Application);
    UsersFilterList.FormStyle := fsMDIChild;
    UsersFilterList.BringToFront;
  end else begin
    UsersFilterList.Show;
  end;
end;

procedure TMainGUI.ExceptionEmailList1Click(Sender: TObject);
begin
  inherited;
  if not Assigned(ExceptionEmailsList) then begin
    ExceptionEmailsList := TExceptionEmailsList.Create(Application);
    ExceptionEmailsList.FormStyle := fsMDIChild;
    ExceptionEmailsList.BringToFront;
  end else begin
    ExceptionEmailsList.Show;
  end;
end;

procedure TMainGUI.DownloadEmails1Click(Sender: TObject);
Begin
  inherited;
  ExceptionEmailsLib.ImportExceptionEmails;
end;

procedure TMainGUI.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited;
  CanClose := AllowClose;
  BaseDataModule.TrayIconShow;
end;

procedure TMainGUI.FormPaint(Sender: TObject);
begin
// inherited; NO PAYMENT
end;

end.
