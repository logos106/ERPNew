unit frmDoorGlazing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputDoorLookups, ActnList, DNMAction, Menus, AdvMenus,
  DataState, DB, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, StdCtrls,
  wwcheckbox, DNMSpeedButton, Shader, ExtCtrls, DNMPanel, BusobjDoorLookups,
  Mask, wwdbedit, Wwdotdot, Wwdbcomb;

type
  TfmDoorGlazing = class(TBaseInputdoorLookupGUI)
    Label6: TLabel;
    Label10: TLabel;
    wwDBEdit5: TwwDBEdit;
    wwDBEdit7: TwwDBEdit;
    Label1: TLabel;
    wwDBEdit1: TwwDBEdit;
    Label2: TLabel;
    wwDBEdit2: TwwDBEdit;
    Label7: TLabel;
    cboUnit: TwwDBComboBox;
    Label3: TLabel;
    wwDBComboBox1: TwwDBComboBox;
    Label4: TLabel;
    wwDBComboBox2: TwwDBComboBox;
    Label5: TLabel;
    wwDBComboBox3: TwwDBComboBox;
    procedure FormCreate(Sender: TObject);
  private
    Glazing :TGlazing;
  public
    { Public declarations }
  end;


implementation

uses FormFactory, CommonLib;

{$R *.dfm}

procedure TfmDoorGlazing.FormCreate(Sender: TObject);
begin
    Glazing := TGlazing.create(Self);
    DBData := Glazing;
    inherited;
end;
initialization
    RegisterClassOnce(TfmDoorGlazing);
    with FormFact do begin
        RegisterMe(TfmDoorGlazing, 'TDoorGlazingGUI_*=Globalref');
    End;

end.
