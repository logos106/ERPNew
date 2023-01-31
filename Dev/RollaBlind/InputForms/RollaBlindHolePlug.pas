unit RollaBlindHolePlug;

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
  DNMPanel, StdCtrls, Mask, wwdbedit;

type
  TRollaBlindHolePlugGUI = class(TBaseRollaBlindInputGUI)
    edtMinDrop: TwwDBEdit;
    edtMaxDrop: TwwDBEdit;
    edtNumberOfPlugs: TwwDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    qryMainMinDrop: TFloatField;
    qryMainMaxDrop: TFloatField;
    qryMainPlugNumber: TFloatField;
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

procedure TRollaBlindHolePlugGUI.FormShow(Sender: TObject);
begin
  OpenQueries;

  if KeyID = 0 then
    qryMain.Insert
  else
    qryMain.Locate('HolePlugID', KeyID, [loCaseInsensitive]);

  inherited;
end;

initialization
  RegisterClassOnce(TRollaBlindHolePlugGUI);

  with FormFact do
  begin
    RegisterMe(TRollaBlindHolePlugGUI, 'TRollaBlindHolePlugListGUI_*=HolePlugID');
  end;                                      
finalization
  UnRegisterClass(TRollaBlindHolePlugGUI);
end.
