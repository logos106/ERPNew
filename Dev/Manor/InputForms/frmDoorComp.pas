unit frmDoorComp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputDoorLookups, ActnList, DNMAction, Menus, AdvMenus,
  DataState, DB, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts,
  DNMSpeedButton, StdCtrls, Shader, ExtCtrls, DNMPanel, MemDS, wwdblook,
  wwcheckbox, Wwdotdot, Wwdbcomb, Mask, wwdbedit, BusobjDoorLookups;

type
  TfmDoorComp = class(TBaseInputdoorLookupGUI)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    qrycompRef: TERPQuery;
    cboFinish: TwwDBComboBox;
    edtHeightMats: TwwDBEdit;
    edtQuantity: TwwDBEdit;
    edtWidthMats: TwwDBEdit;
    cboPosition: TwwDBComboBox;
    qrycompRefCompRef: TStringField;
    qrydoortype: TERPQuery;
    qrydoortypeDoorType: TStringField;
    qrydoortypefinish: TStringField;
    wwDBLookupCombo1: TwwDBLookupCombo;
    wwDBLookupCombo2: TwwDBLookupCombo;
    procedure FormCreate(Sender: TObject);
  private
    DoorComp :TDoorComp;
  Protected
    Procedure LoadLookupTableParams; override;
    Procedure DoFieldOnChange(Const Propname :String); override;
  public
  end;


implementation

uses CommonLib, FormFactory, FastFuncs;

{$R *.dfm}
procedure TfmDoorComp.FormCreate(Sender: TObject);
begin
    DoorComp    := TDoorComp.create(Self);
    DBData      := DoorComp;
    inherited;
end;
Procedure TfmDoorComp.DoFieldOnChange(Const Propname :String);
begin
    if FastFuncs.SameText(propname , 'Doortype') then begin
        DoorComp.finish := qryDoortype.fieldByname('Finish').asString;
        cboFinish.Text :=DoorComp.finish ;
    end;
end;
Procedure TfmDoorComp.LoadLookupTableParams;
begin
    {for the existing records if usning a deleted lookupref}
    qrycompRef.Params.ParamByName('CompRef').asString   := DoorComp.CompRef;
    qrydoortype.Params.ParamByName('DoorType').asString := DoorComp.doorType;
end;
initialization
    RegisterClassOnce(TfmDoorComp);
    with FormFact do begin
        RegisterMe(TfmDoorComp, 'TdoorCompGUI_*=Globalref');
    End;
end.
