unit RollaBlindDropData;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 18/05/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseRollaBlindInput, DB, MemDS, DBAccess, MyAccess, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts,  DNMSpeedButton, ExtCtrls,
  DNMPanel, StdCtrls, wwdblook, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  wwcheckbox;

type
  TRollaBlindDropDataGUI = class(TBaseRollaBlindInputGUI)
    qryProfileType: TMyQuery;
    cboProfileType: TwwDBLookupCombo;
    Label1: TLabel;
    Label2: TLabel;
    cboGuideType: TwwDBComboBox;
    Label3: TLabel;
    edtMinDrop: TwwDBEdit;
    Label4: TLabel;
    edtMaxDrop: TwwDBEdit;
    Label5: TLabel;
    edtHiddenProfiles: TwwDBEdit;
    Label6: TLabel;
    edtProfileWidth: TwwDBEdit;
    edtHousingHeight: TwwDBEdit;
    Label7: TLabel;
    chkPerforated: TwwCheckBox;
    Label8: TLabel;
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

procedure TRollaBlindDropDataGUI.FormShow(Sender: TObject);
begin
  OpenQueries;

  if KeyID = 0 then
    qryMain.Insert
  else
    qryMain.Locate('ProfDataID', KeyID, [loCaseInsensitive]);

  inherited;
end;

initialization
  RegisterClassOnce(TRollaBlindDropDataGUI);

  with FormFact do
  begin
    RegisterMe(TRollaBlindDropDataGUI, 'TRollaBlindDropDataListGUI_*=ProfDataID');
  end;
finalization
  UnRegisterClass(TRollaBlindDropDataGUI);
end.
