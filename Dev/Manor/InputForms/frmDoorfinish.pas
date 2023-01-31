unit frmDoorfinish;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputDoorLookups, ActnList, DNMAction, Menus, AdvMenus,
  DataState, DB, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, StdCtrls,
  wwcheckbox, DNMSpeedButton, Shader, ExtCtrls, DNMPanel, Mask, wwdbedit,
    BusobjDoorLookups;

type
  TfmDoorFinish = class(TBaseInputdoorLookupGUI)
    Label6: TLabel;
    wwDBEdit5: TwwDBEdit;
    Label10: TLabel;
    wwDBEdit7: TwwDBEdit;
    procedure FormCreate(Sender: TObject);
  private
    DoorFinish :TFinish;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, FormFactory;

{$R *.dfm}

procedure TfmDoorFinish.FormCreate(Sender: TObject);
begin
    DoorFinish  := TFinish.create(Self);
    DBData      := DoorFinish;
    inherited;
end;
initialization
    RegisterClassOnce(TfmDoorFinish);
    with FormFact do begin
        RegisterMe(TfmDoorFinish, 'TDoorFinishGUI_*=Globalref');
    End;

end.
