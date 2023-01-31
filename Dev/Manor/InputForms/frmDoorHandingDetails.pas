unit frmDoorHandingDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputDoorLookups, ActnList, DNMAction, Menus, AdvMenus,
  DataState, DB, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, StdCtrls,
  wwcheckbox, DNMSpeedButton, Shader, ExtCtrls, DNMPanel, BusobjDoorLookups,
  Mask, wwdbedit;

type
  TfmDoorHandingDetails = class(TBaseInputdoorLookupGUI)
    Label6: TLabel;
    Label10: TLabel;
    wwDBEdit5: TwwDBEdit;
    wwDBEdit7: TwwDBEdit;
    procedure FormCreate(Sender: TObject);
  private
    HandingDetails : THandingDetails;
  public
    { Public declarations }
  end;


implementation

uses FormFactory, CommonLib;

{$R *.dfm}

procedure TfmDoorHandingDetails.FormCreate(Sender: TObject);
begin
    HandingDetails := THandingDetails.create(Self);
    DBData := HandingDetails;
    inherited;
end;
initialization
    RegisterClassOnce(TfmDoorHandingDetails);
    with FormFact do begin
        RegisterMe(TfmDoorHandingDetails, 'TDoorHandingDetailsGUI_*=Globalref');
    End;

end.
