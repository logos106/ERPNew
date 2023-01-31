unit RollaBlindTechData;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 22/05/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseRollaBlindInput, DB, MemDS, DBAccess, MyAccess, Menus, AdvMenus,
  DataState, SelectionDialog, AppEvnts,  DNMSpeedButton, ExtCtrls,
  DNMPanel, wwdbedit, StdCtrls, Mask, Wwdotdot, Wwdbcomb;

type
  TRollaBlindTechDataGUI = class(TBaseRollaBlindInputGUI)
    Label1: TLabel;
    cboCategory: TwwDBComboBox;
    wwDBEdit1: TwwDBEdit;
    cboGuideType: TwwDBComboBox;
    wwDBComboBox1: TwwDBComboBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
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

procedure TRollaBlindTechDataGUI.FormShow(Sender: TObject);
begin
  OpenQueries;

  if KeyID = 0 then
    qryMain.Insert
  else
    qryMain.Locate('MeasurementID', KeyID, [loCaseInsensitive]);

  inherited;
end;

initialization
  RegisterClassOnce(TRollaBlindTechDataGUI);

  with FormFact do
  begin
    RegisterMe(TRollaBlindTechDataGUI, 'TRollaBlindTechDataListGUI_*=MeasurementID');
  end;
finalization
  UnRegisterClass(TRollaBlindTechDataGUI);
end.
