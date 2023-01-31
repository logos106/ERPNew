unit frmdoorstiles;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputDoorLookups, ActnList, DNMAction, Menus, AdvMenus,
  DataState, DB, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, StdCtrls,
  wwcheckbox, DNMSpeedButton, Shader, ExtCtrls, DNMPanel, BusobjDoorLookups,
  Wwdotdot, Wwdbcomb, Mask, wwdbedit;

type
  Tfmdoorstiles = class(TBaseInputdoorLookupGUI)
    Label6: TLabel;
    Code: TwwDBEdit;
    Label10: TLabel;
    wwDBEdit7: TwwDBEdit;
    Label1: TLabel;
    wwDBEdit1: TwwDBEdit;
    procedure FormCreate(Sender: TObject);
  private
    Stiles :TStiles;
  public
    { Public declarations }
  end;


implementation

uses FormFactory, CommonLib;
{$R *.dfm}

procedure Tfmdoorstiles.FormCreate(Sender: TObject);
begin
    Stiles := TStiles.create(Self);
    DBData := Stiles;
    inherited;
end;
initialization
    RegisterClassOnce(Tfmdoorstiles);
    with FormFact do begin
        RegisterMe(Tfmdoorstiles, 'TdoorstilesGUI_*=Globalref');
    End;
end.
