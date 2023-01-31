unit PrefSettingsListForm;

 {
 Date     Version  Who Comment
 -------- -------- --- ---------------------------------------------------------
 01/11/05 _1.00.01 IJB Modified create to set GuiPrefs to appropriate mode
                       (so GuiPrefs will only save data for Global or User)
}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseListingForm, ActnList, PrintDAT, ImgList,
  Menus, AdvMenus, DB,  Buttons, DNMSpeedButton, Wwdbigrd, Grids, Wwdbgrid, ComCtrls,AdvOfficeStatusBar, StdCtrls,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, DNMPanel, DBAccess,
  MyAccess, MemDS, wwdbdatetimepicker, ProgressDialog, CustomInputBox,
  wwdblook, Shader, kbmMemTable;

type
  TPrefSettingsListGUI = class(TBaseListingGUI)
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure qryMainBeforeOpen(DataSet: TDataSet);
  protected
  public
    function isPrefSettingsForm(var forCompany: boolean): boolean; override;
  end;

var
  doCompany: boolean;

implementation

uses GuiPrefsObj,  Forms, AppEnvironment, CommonLib;

{$R *.dfm}

function TPrefSettingsListGUI.isPrefSettingsForm(var forCompany: boolean): boolean;
begin
  forCompany := doCompany;
  Result := true;
end;

procedure TPrefSettingsListGUI.FormShow(Sender: TObject);
begin
  inherited;
  GuiPrefs.Active := True;
  if doCompany then self.Caption := 'List Preferences Company Wide'
  else self.Caption := 'List Preferences for ' + AppEnv.Employee.LogonName;
end;

procedure TPrefSettingsListGUI.FormCreate(Sender: TObject);
begin
  inherited;
  if doCompany then begin
    GuiPrefs.UserType        := puGlobal;
    GuiPrefs.GlobalPrefsOnly := true;
    GuiPrefs.UserPrefsOnly   := false;
  end else begin
    GuiPrefs.UserType        := puUser;
    GuiPrefs.GlobalPrefsOnly := false;
    GuiPrefs.UserPrefsOnly   := true;
  end;
end;

procedure TPrefSettingsListGUI.qryMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryMain.Params.ParamByName('xRegionID').AsInteger := AppEnv.RegionalOptions.RegionID;
end;

initialization
  RegisterClassOnce(TPrefSettingsListGUI);  
end.
