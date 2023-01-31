unit frmdoorJoinery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputDoorLookups, ActnList, DNMAction, Menus, AdvMenus,
  DataState, DB, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, StdCtrls,
  wwcheckbox, DNMSpeedButton, Shader, ExtCtrls, DNMPanel, BusobjDoorLookups,
  Wwdotdot, Wwdbcomb, Mask, wwdbedit;

type
  TfmdoorJoinery = class(TBaseInputdoorLookupGUI)
    Label6: TLabel;
    wwDBEdit5: TwwDBEdit;
    Label10: TLabel;
    wwDBEdit7: TwwDBEdit;
    Label1: TLabel;
    cboUnit: TwwDBComboBox;
    procedure FormCreate(Sender: TObject);
  private
    Joinery :TJoinery;
  public
    { Public declarations }
  end;


implementation

uses FormFactory, CommonLib;
{$R *.dfm}

procedure TfmdoorJoinery.FormCreate(Sender: TObject);
begin
    Joinery := TJoinery.create(Self);
    DBData := Joinery;
    inherited;
end;
initialization
    RegisterClassOnce(TfmdoorJoinery);
    with FormFact do begin
        RegisterMe(TfmdoorJoinery, 'TdoorJoineryGUI_*=Globalref');
    End;
end.
