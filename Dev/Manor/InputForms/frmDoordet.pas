unit frmDoordet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputDoorLookups, ActnList, DNMAction, Menus, AdvMenus,
  DataState, DB, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, StdCtrls,
  wwcheckbox, DNMSpeedButton, Shader, ExtCtrls, DNMPanel, BusobjDoorLookups,
  Wwdotdot, Wwdbcomb, Mask, wwdbedit, wwclearbuttongroup, wwradiogroup;

type
  TfmDoorDet = class(TBaseInputdoorLookupGUI)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;


    DNMPanel4: TDNMPanel;
    DNMPanel5: TDNMPanel;
    DNMPanel6: TDNMPanel;
    DNMPanel7: TDNMPanel;
    DNMPanel8: TDNMPanel;
    edtHeightMats: TwwDBEdit;
    cboUnit: TwwDBComboBox;

    wwDBEdit1: TwwDBEdit;
    wwDBEdit3: TwwDBEdit;
    wwDBEdit8: TwwDBEdit;
    wwDBEdit6: TwwDBEdit;
    wwDBEdit9: TwwDBEdit;
    wwDBEdit7: TwwDBEdit;
    wwDBEdit5: TwwDBEdit;
    wwDBEdit4: TwwDBEdit;
    wwDBEdit2: TwwDBEdit;
    wwDBEdit17: TwwDBEdit;
    wwDBEdit18: TwwDBEdit;
    wwDBEdit19: TwwDBEdit;
    wwDBEdit20: TwwDBEdit;
    wwDBEdit21: TwwDBEdit;
    wwDBEdit22: TwwDBEdit;
    wwDBEdit23: TwwDBEdit;
    wwDBEdit24: TwwDBEdit;
    wwDBEdit25: TwwDBEdit;
    wwDBEdit26: TwwDBEdit;
    wwDBEdit11: TwwDBEdit;
    wwDBEdit10: TwwDBEdit;
    wwDBEdit16: TwwDBEdit;
    DNMPanel9: TDNMPanel;
    Label15: TLabel;
    Label30: TLabel;
    Label17: TLabel;
    Label31: TLabel;
    wwDBEdit14: TwwDBEdit;
    wwDBEdit13: TwwDBEdit;
    wwDBEdit15: TwwDBEdit;
    wwDBEdit12: TwwDBEdit;
    wwRadioGroup1: TwwRadioGroup;
    Label16: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    DoorDetail :TDoorDetail;
  public

  end;

implementation

uses CommonLib, FormFactory;

{$R *.dfm}

procedure TfmDoorDet.FormCreate(Sender: TObject);
begin
    DoorDetail := TDoorDetail.create(Self);
    DBData      := DoorDetail;
    inherited;
end;
initialization
    RegisterClassOnce(TfmDoorDet);
    with FormFact do begin
        RegisterMe(TfmDoorDet, 'TDoorDetGUI_*=Globalref');
    End;

end.
