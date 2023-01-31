unit frmdoorsundry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputDoorLookups, ActnList, DNMAction, Menus, AdvMenus,
  DataState, DB, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, StdCtrls,
  wwcheckbox, DNMSpeedButton, Shader, ExtCtrls, DNMPanel, BusobjDoorLookups,
  Mask, wwdbedit;

type
  Tfmdoorsundry = class(TBaseInputdoorLookupGUI)
    Code: TwwDBEdit;
    Label6: TLabel;
    Label10: TLabel;
    wwDBEdit7: TwwDBEdit;
    Label1: TLabel;
    wwDBEdit1: TwwDBEdit;
    procedure FormCreate(Sender: TObject);
  private
        Sundry :TSundry;
  public
    { Public declarations }
  end;


implementation

uses FormFactory, CommonLib;

{$R *.dfm}

procedure   Tfmdoorsundry.FormCreate(Sender: TObject);
begin
    Sundry := TSundry.create(Self);
    DBData := Sundry;
    inherited;

end;
initialization
    RegisterClassOnce(Tfmdoorsundry);
    with FormFact do begin
        RegisterMe(Tfmdoorsundry, 'TdoorsundryGUI_*=Globalref');
    End;

end.
