unit frmdoorIsDescription;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputDoorLookups, ActnList, DNMAction, Menus, AdvMenus,
  DataState, DB, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, StdCtrls,
  wwcheckbox, DNMSpeedButton, Shader, ExtCtrls, DNMPanel, Mask, wwdbedit, BusobjDoorLookups;

type
  TfmdoorIsDescription = class(TBaseInputdoorLookupGUI)
    Label6: TLabel;
    Label10: TLabel;
    wwDBEdit7: TwwDBEdit;
    wwDBEdit5: TwwDBEdit;
    procedure FormCreate(Sender: TObject);
  private
    ISDescription :TIsDescriptions;
  public
    { Public declarations }
  end;


implementation

uses FormFactory, CommonLib;



{$R *.dfm}

procedure TfmdoorIsDescription.FormCreate(Sender: TObject);
begin
    ISDescription := TIsDescriptions.create(Self);
    DBData := ISDescription;
    inherited;
end;

initialization
    RegisterClassOnce(TfmdoorIsDescription);
    with FormFact do begin
        RegisterMe(TfmdoorIsDescription, 'TDoorIsDescriptionsGUI_*=Globalref');
    End;
end.
