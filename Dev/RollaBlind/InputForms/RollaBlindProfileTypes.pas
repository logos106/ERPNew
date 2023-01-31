unit RollaBlindProfileTypes;

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
  DNMPanel, StdCtrls, Mask, wwdbedit;

type
  TRollaBlindProfileTypesGUI = class(TBaseRollaBlindInputGUI)
    Label1: TLabel;
    wwDBEdit1: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    Label2: TLabel;
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

procedure TRollaBlindProfileTypesGUI.FormShow(Sender: TObject);
begin
  OpenQueries;

  if KeyID = 0 then
    qryMain.Insert
  else
    qryMain.Locate('ProfileTypeID', KeyID, [loCaseInsensitive]);

  inherited;
end;

initialization
  RegisterClassOnce(TRollaBlindProfileTypesGUI);

  with FormFact do
  begin
    RegisterMe(TRollaBlindProfileTypesGUI, 'TRollaBlindProfileTypesListGUI_*=ProfileTypeID');
  end;                                      
finalization
  UnRegisterClass(TRollaBlindProfileTypesGUI);
end.
