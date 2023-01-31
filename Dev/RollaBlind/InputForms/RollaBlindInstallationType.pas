unit RollaBlindInstallationType;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 19/05/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseRollaBlindInput, DB, MemDS, DBAccess, MyAccess, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts,  DNMSpeedButton, ExtCtrls,
  DNMPanel;

type
  TRollaBlindInstallationTypeGUI = class(TBaseRollaBlindInputGUI)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  FormFactory, CommonLib;

procedure TRollaBlindInstallationTypeGUI.FormShow(Sender: TObject);
begin
  OpenQueries;

  if KeyID = 0 then
    qryMain.Insert
  else
    qryMain.Locate('InstallationTypeID', KeyID, [loCaseInsensitive]);

  inherited;
end;

initialization
  RegisterClassOnce(TRollaBlindInstallationTypeGUI);

  with FormFact do
  begin
    RegisterMe(TRollaBlindInstallationTypeGUI, 'TRollaBlindInstallationTypeListGUI_*=InstallationTypeID');
  end;                                      
finalization
  UnRegisterClass(TRollaBlindInstallationTypeGUI);
end.
