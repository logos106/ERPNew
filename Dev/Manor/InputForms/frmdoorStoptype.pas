unit frmdoorStoptype;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputDoorLookups, ActnList, DNMAction, Menus, AdvMenus,
  DataState, DB, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, StdCtrls,
  wwcheckbox, DNMSpeedButton, Shader, ExtCtrls, DNMPanel, BusobjDoorLookups,
  Mask, wwdbedit;

type
  TfmdoorStoptype = class(TBaseInputdoorLookupGUI)
    Label10: TLabel;
    wwDBEdit7: TwwDBEdit;
    procedure FormCreate(Sender: TObject);
  private
        StopType :TStopType;
  public
    { Public declarations }
  end;


implementation

uses FormFactory, CommonLib;

{$R *.dfm}

procedure TfmdoorStoptype.FormCreate(Sender: TObject);
begin
    StopType := TStopType.create(Self);
    DBData := StopType;
    inherited;
end;
initialization
    RegisterClassOnce(TfmdoorStoptype);
    with FormFact do begin
        RegisterMe(TfmdoorStoptype, 'TdoorStoptypeGUI_*=Globalref');
    End;

end.
