unit frmDoorEditVeneerDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseProcTreeEdit, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls,
  Shader, wwcheckbox, wwclearbuttongroup, wwradiogroup, AdvEdit, DB,
  DBAccess, MyAccess,ERPdbComponents, MessageConst,
  MemDS, wwdblook;

type
  TfrmDoorEditVeneerDetailsGUI = class(TBaseProcTreeEditGUI)
    chkVeneerRequired: TwwCheckBox;
    chkVeneeredOver: TwwCheckBox;
    rdgCutDescription: TwwRadioGroup;
    Label1: TLabel;
    Bevel2: TBevel;
    Label2: TLabel;
    Label3: TLabel;
    edtVeneerOneCost: TAdvEdit;
    cboVeneerOne: TwwDBLookupCombo;
    Label4: TLabel;
    Bevel3: TBevel;
    Label5: TLabel;
    cboVeneerTwo: TwwDBLookupCombo;
    Label6: TLabel;
    edtVeneerTwoCost: TAdvEdit;
    Label7: TLabel;
    edtTotalVeneerCost: TAdvEdit;
    qryVeneerFaceOne: TERPQuery;
    qryVeneerFaceTwo: TERPQuery;
  protected
    procedure SetPropertyValue(Sender: TObject); override;  
  private
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonDbLib, FastFuncs, CommonLib;

procedure TfrmDoorEditVeneerDetailsGUI.PerformStartup(var Msg: TMessage);
begin
  qryVeneerFaceOne.Connection := GetSharedMyDacConnection;
  qryVeneerFaceOne.Open;
  qryVeneerFaceOne.FieldByName('VeneerName').DisplayWidth := 20;
  qryVeneerFaceTwo.Connection := GetSharedMyDacConnection;
  qryVeneerFaceTwo.Open;
  qryVeneerFaceTwo.FieldByName('VeneerName').DisplayWidth := 20;
  inherited;
(*    if (Assigned(Nodeproplink.owner)) and (nodePropLink.owner is TEditDoorQuotationDetails) then
        if TEditDoorQuotationDetails(NodeProplink.owner).DoorPair = 0 then begin
            Label4.enabled := false;
            Label5.enabled := false;
            cboVeneerTwo.enabled := false;
            Label6.enabled := false;
            edtVeneerTwoCost.enabled := false;
        end else begin
            Label4.enabled := true;
            Label5.enabled := true;
            cboVeneerTwo.enabled := true;
            Label6.enabled := true;
            edtVeneerTwoCost.enabled := true;
        end;*)
end;

procedure TfrmDoorEditVeneerDetailsGUI.SetPropertyValue(Sender: TObject);
begin
  inherited;

  if Sender is TwwCheckBox then begin
    if FastFuncs.SameText(TwwCheckBox(Sender).Name, 'chkVeneerRequired') then begin
      cboVeneerOne.Enabled := TwwCheckBox(Sender).Checked;
      cboVeneerTwo.Enabled := (TwwCheckBox(Sender).Checked) ;//and (TEditDoorQuotationDetails(NodeProplink.owner).DoorPair <> 0);
      edtVeneerOneCost.Enabled := TwwCheckBox(Sender).Checked;
      edtVeneerTwoCost.Enabled := (TwwCheckBox(Sender).Checked);// and (TEditDoorQuotationDetails(NodeProplink.owner).DoorPair <> 0);
    end;
  end;
end;

initialization
  RegisterClassOnce(TfrmDoorEditVeneerDetailsGUI);
finalization
  UnregisterClass(TfrmDoorEditVeneerDetailsGUI);
end.
