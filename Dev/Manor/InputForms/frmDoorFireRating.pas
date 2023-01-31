unit frmDoorFireRating;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputDoorLookups, ActnList, DNMAction, Menus, AdvMenus,
  DataState, DB, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, StdCtrls,
  wwcheckbox, DNMSpeedButton, Shader, ExtCtrls, DNMPanel, BusobjDoorLookups,
  Mask, wwdbedit;

type
  TfmDoorFireRating = class(TBaseInputdoorLookupGUI)
    Label6: TLabel;
    wwDBEdit5: TwwDBEdit;
    Label10: TLabel;
    wwDBEdit7: TwwDBEdit;
    Label1: TLabel;
    wwDBEdit1: TwwDBEdit;
    procedure FormCreate(Sender: TObject);
  private
    FireRating :TFireRating;
  public
    { Public declarations }
  end;


implementation

uses CommonLib, FormFactory;

{$R *.dfm}
procedure TfmDoorFireRating.FormCreate(Sender: TObject);
begin
    FireRating := TFireRating.create(Self);
    DBData := fireRating;
  inherited;

end;

initialization
    RegisterClassOnce(TfmDoorFireRating);
    with FormFact do begin
        RegisterMe(TfmDoorFireRating, 'TDoorFireRatingGUI_*=Globalref');
    End;


end.
