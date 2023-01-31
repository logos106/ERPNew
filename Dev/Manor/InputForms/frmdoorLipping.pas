unit frmdoorLipping;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputDoorLookups, ActnList, DNMAction, Menus, AdvMenus,
  DataState, DB, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, StdCtrls,
  wwcheckbox, DNMSpeedButton, Shader, ExtCtrls, DNMPanel, BusobjDoorLookups,
  Wwdotdot, Wwdbcomb, Mask, wwdbedit;

type
  TfmdoorLipping = class(TBaseInputdoorLookupGUI)
    Label6: TLabel;
    wwDBEdit5: TwwDBEdit;
    Label10: TLabel;
    wwDBEdit7: TwwDBEdit;
    Label1: TLabel;
    cboUnit: TwwDBComboBox;
    procedure FormCreate(Sender: TObject);
  private
    Lipping :TLippings;
  public
    { Public declarations }
  end;


implementation

uses FormFactory, CommonLib;

{$R *.dfm}

procedure TfmdoorLipping.FormCreate(Sender: TObject);
begin
    Lipping := TLippings.create(Self);
    DBData := Lipping;
    inherited;
end;
initialization
    RegisterClassOnce(TfmdoorLipping);
    with FormFact do begin
        RegisterMe(TfmdoorLipping, 'TdoorLippingGUI_*=Globalref');
    End;
end.
