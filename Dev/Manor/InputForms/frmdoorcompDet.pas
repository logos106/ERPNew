unit frmdoorcompDet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  ActnList, DNMAction, Menus, AdvMenus,
  DataState, DB, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts,
  DNMSpeedButton, StdCtrls, Shader, ExtCtrls, DNMPanel, Mask, wwdbedit, BusobjDoorLookups,
   BaseInputDoorLookups, wwdblook, DBCtrls, Wwdotdot, Wwdbcomb, wwcheckbox,
  MemDS;

type
  TfmDoorcompDet = class(TBaseInputdoorLookupGUI)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtcompRef: TwwDBEdit;
    edtHeight: TwwDBEdit;
    edtWidth: TwwDBEdit;
    edtsizeno: TwwDBEdit;
    edtthickness: TwwDBEdit;
    edtTolerance: TwwDBEdit;
    Label8: TLabel;
    edtcost: TwwDBEdit;
    cboUnit: TwwDBComboBox;
    procedure FormCreate(Sender: TObject);
    procedure actNewExecute(Sender: TObject);
  private
    DoorcompDet :TcompDet;
  public

  end;

implementation

uses CommonLib, FormFactory;

{$R *.dfm}

procedure TfmDoorcompDet.FormCreate(Sender: TObject);
begin
    DoorcompDet := TcompDet.create(Self);
    DBData      := DoorcompDet;
    inherited;
end;
procedure TfmDoorcompDet.actNewExecute(Sender: TObject);
begin
  inherited;
    SetFocusedControl(edtcompRef);
end;

initialization
    RegisterClassOnce(TfmDoorcompDet);
    with FormFact do begin
        RegisterMe(TfmDoorcompDet, 'TDoorCompDetGUI_*=Globalref');
    End;
end.
