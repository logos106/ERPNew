unit frmdoorEditLippingsStilesDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseProcTreeEdit, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls,
  Shader, wwclearbuttongroup, wwradiogroup, wwcheckbox, AdvEdit, DB,
  DBAccess, MyAccess,ERPdbComponents, MemDS,
  wwdblook, MessageConst;

type
  TfrmDoorEditLippingsStilesDetailsGUI = class(TBaseProcTreeEditGUI)
    rdgEdgeNumber: TwwRadioGroup;
    rdgStileType: TwwRadioGroup;
    Label1: TLabel;
    cboLippingThickness: TwwDBLookupCombo;
    Label2: TLabel;
    cboLippingType: TwwDBLookupCombo;
    Label3: TLabel;
    edtLippingCost: TAdvEdit;
    Label4: TLabel;
    cboHanding: TwwDBLookupCombo;
    Label5: TLabel;
    memSpecialLippingInstructions: TMemo;
    Label6: TLabel;
    edtLippingMaterialCost: TAdvEdit;
    Label7: TLabel;
    edtMaterialLabourCost: TAdvEdit;
    Label8: TLabel;
    edtTotalLippingStileCost: TAdvEdit;
    Label9: TLabel;
    edtRebateSize: TAdvEdit;
    Label10: TLabel;
    cboStileLippingThickness: TwwDBLookupCombo;
    Label11: TLabel;
    cboStileLippingType: TwwDBLookupCombo;
    Label12: TLabel;
    edtStileLippingCost: TAdvEdit;
    Label13: TLabel;
    chkAllStiles: TwwCheckBox;
    qryLippingThickness: TERPQuery;
    qryLippingType: TERPQuery;
    qryStileLippingThickness: TERPQuery;
    qryStileLippingType: TERPQuery;
    qryHanding: TERPQuery;
    Label14: TLabel;
  private
    procedure SetLippingParams;
    procedure HandleLippingTypeChange(Sender: Tobject);
    procedure SetStileLippingParams;
    procedure HandleStileLippingTypeChange(Sender: Tobject);
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
  protected
    procedure SetPropertyValue(Sender: TObject); override;
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

uses
  CommonDbLib, FastFuncs, DoorEditLippingsStilesDetailsObj, NodePropertiesLink,
  CommonLib;

procedure TfrmDoorEditLippingsStilesDetailsGUI.HandleLippingTypeChange(Sender: Tobject);
begin
  SetLippingParams;
end;

procedure TfrmDoorEditLippingsStilesDetailsGUI.HandleStileLippingTypeChange(Sender: Tobject);
begin
  SetStileLippingParams;
end;

procedure TfrmDoorEditLippingsStilesDetailsGUI.PerformStartup(var Msg: TMessage);
begin
  qryLippingThickness.Connection := GetSharedMyDacConnection;
  qryLippingThickness.Open;
  qryLippingThickness.FieldByName('LipSize').DisplayWidth := 20;
  qryLippingType.Connection := GetSharedMyDacConnection;
  qryLippingType.Open;
  qryLippingType.FieldByName('LipType').DisplayWidth := 20;
  qryStileLippingThickness.Connection := GetSharedMyDacConnection;
  qryStileLippingThickness.Open;
  qryStileLippingThickness.FieldByName('LipSize').DisplayWidth := 20;
  qryStileLippingType.Connection := GetSharedMyDacConnection;
  qryStileLippingType.Open;
  qryStileLippingType.FieldByName('LipType').DisplayWidth := 20;
  qryHanding.Connection := GetSharedMyDacConnection;
  qryHanding.Open;
  qryHanding.FieldByName('HandingAbbrev').DisplayWidth := 20;
  inherited;
end;

procedure TfrmDoorEditLippingsStilesDetailsGUI.SetLippingParams;
begin
  qryLippingType.Close;
  qryLippingType.ParamByName('LipSize').AsString := TLippingsStilesDetails(NodePropLink).LippingThickness.Value;
  qryLippingType.Open;
end;

procedure TfrmDoorEditLippingsStilesDetailsGUI.SetPropertyValue(Sender: TObject);
begin
  inherited;

  if Sender is TwwDBLookupCombo then begin
    if FastFuncs.SameText(TwwDBLookupCombo(Sender).Name, 'cboLippingThickness') then
      HandleLippingTypeChange(Sender)
    else if FastFuncs.SameText(TwwDBLookupCombo(Sender).Name, 'cboStileLippingThickness') then
      HandleStileLippingTypeChange(Sender);
  end;
end;

procedure TfrmDoorEditLippingsStilesDetailsGUI.SetStileLippingParams;
begin
  qryStileLippingType.Close;
  qryStileLippingType.ParamByName('LipSize').AsString := TLippingsStilesDetails(NodePropLink).StileLippingThickness.Value;
  qryStileLippingType.Open;
end;

initialization
  RegisterClassOnce(TfrmDoorEditLippingsStilesDetailsGUI);
finalization
  UnregisterClass(TfrmDoorEditLippingsStilesDetailsGUI);
end.
