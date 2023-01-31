unit frmdoorVeneer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputDoorLookups, ActnList, DNMAction, Menus, AdvMenus,
  DataState, DB, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, StdCtrls,
  wwcheckbox, DNMSpeedButton, Shader, ExtCtrls, DNMPanel, BusobjDoorLookups,
  Mask, wwdbedit;

type
  TfmdoorVeneer = class(TBaseInputdoorLookupGUI)
    Label6: TLabel;
    Label10: TLabel;
    wwDBEdit5: TwwDBEdit;
    wwDBEdit7: TwwDBEdit;
    procedure FormCreate(Sender: TObject);
  private
    Veneer :TVeneer;
  public
    { Public declarations }
  end;


implementation

uses FormFactory, CommonLib;

{$R *.dfm}

procedure TfmdoorVeneer.FormCreate(Sender: TObject);
begin
    Veneer := TVeneer.create(Self);
    DBData := Veneer;
    inherited;
end;
initialization
    RegisterClassOnce(TfmdoorVeneer);
    with FormFact do begin
        RegisterMe(TfmdoorVeneer, 'TdoorVeneerGUI_*=Globalref');
    End;

end.
