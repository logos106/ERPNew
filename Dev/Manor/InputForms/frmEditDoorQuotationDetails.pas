unit frmEditDoorQuotationDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseProcTreeEdit, ExtCtrls, AppEvnts, DNMSpeedButton, StdCtrls,
  Shader, wwclearbuttongroup, wwradiogroup, MessageConst,
  wwcheckbox, AdvEdit, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdblook, 
  TypInfo;

type
  TfrmEditDoorQuotationDetailsGUI = class(TBaseProcTreeEditGUI)
    Bevel2: TBevel;
    Label1: TLabel;
    lblOrderNumber: TLabel;
    Label2: TLabel;
    cboDoorType: TwwDBLookupCombo;
    Label3: TLabel;
    lblDoorNumber: TLabel;
    rdgDoorPairing: TwwRadioGroup;
    Bevel3: TBevel;
    btnFireRatingDetails: TDNMSpeedButton;
    Bevel4: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtDoorOneWidth: TAdvEdit;
    edtDoorOneHeight: TAdvEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    edtDoorTwoWidth: TAdvEdit;
    edtDoorTwoHeight: TAdvEdit;
    Label14: TLabel;
    edtDoorThickness: TAdvEdit;
    Label15: TLabel;
    btnOverPanels: TDNMSpeedButton;
    btnLippingsStiles: TDNMSpeedButton;
    btnLaminatedFaces: TDNMSpeedButton;
    btnVeneerDetails: TDNMSpeedButton;
    btnGlass: TDNMSpeedButton;
    btnJoinery: TDNMSpeedButton;
    lblfinish: TLabel;
    cboSpecialFinish: TwwDBLookupCombo;
    Label19: TLabel;
    edtPlysealCoatsNum: TAdvEdit;
    Label20: TLabel;
    cboFacing: TwwDBLookupCombo;
    chkFinishCostExtra: TwwCheckBox;
    Label21: TLabel;
    edtDeliveryCharge: TAdvEdit;
    Label22: TLabel;
    edtProfitAdded: TAdvEdit;
    lblTotalcost: TLabel;
    edtTotalCost: TAdvEdit;
    chkManualPrice: TwwCheckBox;
    Label24: TLabel;
    memDoorTypesRefs: TMemo;
    Label25: TLabel;
    edtThickerDoorsAddCost: TAdvEdit;
    Label26: TLabel;
    cboFireRating: TwwDBLookupCombo;
    Label27: TLabel;
    edtPlysealCoatsCost: TAdvEdit;
    Label28: TLabel;
    Bevel6: TBevel;
    Bevel8: TBevel;
    Label30: TLabel;
    qryFinish: TERPQuery;
    qryDoorType: TERPQuery;
    rdgDoorPlacement: TwwRadioGroup;
    qryFacing: TERPQuery;
    qryFireRating: TERPQuery;
    MyQuery1: TERPQuery;
    Label18: TLabel;
    edtspecialfinishcost: TAdvEdit;
    Label16: TLabel;
    edtDoorCost: TAdvEdit;
    Label8: TLabel;
    edtBasicDoorCost: TAdvEdit;
    Label31: TLabel;
    chkWrapDoors: TwwCheckBox;
    Label29: TLabel;
    edtWrapDoorsCost: TAdvEdit;
    Bevel7: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure btnFireRatingDetailsClick(Sender: TObject);
    procedure btnOverPanelsClick(Sender: TObject);
    procedure btnLaminatedFacesClick(Sender: TObject);
    procedure btnVeneerDetailsClick(Sender: TObject);
    procedure btnLippingsStilesClick(Sender: TObject);
    procedure btnGlassClick(Sender: TObject);
    procedure btnJoineryClick(Sender: TObject);
    procedure chkFinishCostExtraClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkManualPriceClick(Sender: TObject);
    procedure cboSpecialFinishCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboSpecialFinishExit(Sender: TObject);
  private
    procedure CreateAndShowForm(const ClassStr, NodeStr: string);
    procedure HandleDoorPairingClick(Sender: TObject);
    procedure HandleDoorTypeCloseUp(Sender: TObject);
    procedure HandleSpecialFinishCloseUp(Sender: TObject);
    procedure HandleDoorPlacementClick(Sender: TObject);
    procedure SetDoorTypeParams;
    procedure SetFacingParams;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
  protected
    procedure SetPropertyValue(Sender: TObject); override;
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonLib, CommonDbLib, NodePropertiesLink, EditDoorQuotationDetailsObj,
  FastFuncs, RegPopupObj;

const
  cDoorSingle = 0;
  cDoorPair = 1;
  cDoorEccentric = 2;

procedure TfrmEditDoorQuotationDetailsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  NodePropLink := TEditDoorQuotationDetails.Create(Self);
  NodePropLink.DisplayDialogs := True;
end;

procedure TfrmEditDoorQuotationDetailsGUI.PerformStartup(var Msg: TMessage);
begin
  lblOrderNumber.Caption := string((Ptr(Msg.lParam))^);
  qryFinish.Connection := GetSharedMyDacConnection;
  qryFinish.Open;
  qryFinish.FieldByName('FinishName').DisplayWidth := 20;
  qryDoorType.Connection := GetSharedMyDacConnection;
  qryDoorType.Open;
  qryDoorType.FieldByName('ShortType').DisplayWidth := 20;
  qryFacing.Connection := GetSharedMyDacConnection;
  qryFacing.Open;
  qryFacing.FieldByName('Finish').DisplayWidth := 20;
  qryFireRating.Connection := GetSharedMyDacConnection;
  qryFireRating.Open;
  qryFireRating.FieldByName('FireRating').DisplayWidth := 20;
  inherited;
end;

procedure TfrmEditDoorQuotationDetailsGUI.CreateAndShowForm(const ClassStr, NodeStr: string);
var
  Form: TBaseProcTreeEditGUI;
begin
  inherited;
  TEditDoorQuotationDetails(NodePropLink).SetDoorsProps;
  Form := TBaseProcTreeEditGUI(GetComponentByClassName(ClassStr));

  if Assigned(Form) and Assigned(NodePropLink) and Assigned(NodePropLink.BaseTreeNode) then begin
    try
      Form.NodePropLink := TNodePropertiesLink(GetObjectProp(NodePropLink, NodeStr));
      Form.NodePropLink.DisplayDialogs := True;
      SendMessage(Form.Handle, TX_PerformStartup, Handle, 0);

      if Form.ShowModal = mrOK then
        TEditDoorQuotationDetails(NodePropLink).SummaryCost.Value := FloatToStr(NodePropLink.CalcSummaryCost);
    finally
      Form.Release;
    end;
  end;
end;

procedure TfrmEditDoorQuotationDetailsGUI.btnFireRatingDetailsClick(Sender: TObject);
begin
  inherited;
  CreateAndShowForm('TfrmdooreditFireRatingDetailsGUI', 'FireRatingDetails');
end;

procedure TfrmEditDoorQuotationDetailsGUI.btnOverPanelsClick(Sender: TObject);
begin
  inherited;
  CreateAndShowForm('TfrmDoorEditOverPanelDetailsGUI', 'OverPanelDetails');
end;

procedure TfrmEditDoorQuotationDetailsGUI.btnLaminatedFacesClick(Sender: TObject);
begin
  inherited;
  CreateAndShowForm('TfrmdoorEditLaminatedFacesDetailsGUI', 'LaminatedFacesDetails');
end;

procedure TfrmEditDoorQuotationDetailsGUI.btnVeneerDetailsClick(Sender: TObject);
begin
  inherited;
  CreateAndShowForm('TfrmdoorEditVeneerDetailsGUI', 'VeneerDetails');
end;

procedure TfrmEditDoorQuotationDetailsGUI.btnLippingsStilesClick(Sender: TObject);
begin
  inherited;
  CreateAndShowForm('TfrmdooreditLippingsStilesDetailsGUI', 'LippingsStilesDetails');
end;

procedure TfrmEditDoorQuotationDetailsGUI.btnGlassClick(Sender: TObject);
begin
  inherited;
  CreateAndShowForm('TfrmdoorEditGlazingDetailsGUI', 'GlazingDetails');
end;

procedure TfrmEditDoorQuotationDetailsGUI.btnJoineryClick(Sender: TObject);
begin
  inherited;
  CreateAndShowForm('TfrmdooreditJoineryDetailsGUI', 'JoineryDetails');
end;

procedure TfrmEditDoorQuotationDetailsGUI.HandleDoorPairingClick(Sender: TObject);
begin
  inherited;

  case rdgDoorPairing.ItemIndex of
    cDoorSingle:
    begin
      with TEditDoorQuotationDetails(NodePropLink) do begin
        DoorTwoWidth.Value := '0';
        DoorTwoHeight.Value := '0';
      end;

      edtDoorTwoWidth.Enabled := False;
      edtDoorTwoHeight.Enabled := False;
    end;

    cDoorPair:
    begin
      with TEditDoorQuotationDetails(NodePropLink) do begin
        DoorTwoWidth.Value := DoorOneWidth.Value;
        DoorTwoHeight.Value := DoorOneHeight.Value;
      end;

      edtDoorTwoWidth.Enabled := True;
      edtDoorTwoHeight.Enabled := True;
    end;

    cDoorEccentric:
    begin
      with TEditDoorQuotationDetails(NodePropLink) do begin
        if not Loading then
          DoorTwoWidth.Value := '0';

        DoorTwoHeight.Value := DoorOneHeight.Value;
      end;

      edtDoorTwoWidth.Enabled := True;
      edtDoorTwoHeight.Enabled := True;
    end;
  end;
end;

procedure TfrmEditDoorQuotationDetailsGUI.HandleSpecialFinishCloseUp(Sender: TObject);
begin
  inherited;
    if FastFuncs.SameText(cboSpecialFinish.Text, 'Plyseal & G.O.') or
        FastFuncs.SameText(cboSpecialFinish.Text, 'Plyseal Plain Door') then begin
        edtPlysealCoatsNum.Enabled  := True;
        edtPlysealCoatsCost.Enabled := True;
        if EmptyNumber(TEditDoorQuotationDetails(NodePropLink).PlysealCoatsNum.Value) then
            TEditDoorQuotationDetails(NodePropLink).PlysealCoatsNum.Value := '1';
        if not(SameText(qryFinish.FieldByname('finishName').asString ,TEditDoorQuotationDetails(NodePropLink).specialfinish.value)) then
            qryFinish.Locate('finishname' ,TEditDoorQuotationDetails(NodePropLink).specialfinish.value , []);
        TEditDoorQuotationDetails(NodePropLink).PlysealCoatsCost.Value :=qryFinish.fieldByname('Cost').asString;
        TEditDoorQuotationDetails(NodePropLink).specialfinishcost.Value := '0';
    end else begin
        edtPlysealCoatsNum.Enabled  := False;
        edtPlysealCoatsCost.Enabled := False;
        TEditDoorQuotationDetails(NodePropLink).PlysealCoatsNum.Value := '0';
        TEditDoorQuotationDetails(NodePropLink).PlysealCoatsCost.Value :='0';
        if not(SameText(qryFinish.FieldByname('finishName').asString ,TEditDoorQuotationDetails(NodePropLink).specialfinish.value)) then
            qryFinish.Locate('finishname' ,TEditDoorQuotationDetails(NodePropLink).specialfinish.value , []);
        TEditDoorQuotationDetails(NodePropLink).specialfinishcost.Value := qryFinish.fieldByname('Cost').asString;
    end;
end;

procedure TfrmEditDoorQuotationDetailsGUI.SetPropertyValue(Sender: TObject);
begin
  inherited;

  if Sender is TwwRadioGroup then begin
    if FastFuncs.SameText(TwwRadioGroup(Sender).Name, 'rdgDoorPairing') then
      HandleDoorPairingClick(Sender)
    else if FastFuncs.SameText(TwwRadioGroup(Sender).Name, 'rdgDoorPlacement') then
      HandleDoorPlacementClick(Sender);
  end
  else if Sender is TwwDBLookupCombo then begin
    if FastFuncs.SameText(TwwDBLookupCombo(Sender).Name, 'cboDoorType') then
      HandleDoorTypeCloseUp(Sender)
    else if FastFuncs.SameText(TwwDBLookupCombo(Sender).Name, 'cboSpecialFinish') then
      HandleSpecialFinishCloseUp(Sender);
  end;
end;

procedure TfrmEditDoorQuotationDetailsGUI.HandleDoorPlacementClick(Sender: TObject);
begin
  SetDoorTypeParams;
  SetFacingParams;
end;

procedure TfrmEditDoorQuotationDetailsGUI.SetDoorTypeParams;
begin
  qryDoorType.Close;

  if TEditDoorQuotationDetails(NodePropLink).DoorPlacement.Value = '0' then
    qryDoorType.ParamByName('InternalExternal').AsString := 'Internal'
  else if TEditDoorQuotationDetails(NodePropLink).DoorPlacement.Value = '1' then
    qryDoorType.ParamByName('InternalExternal').AsString := 'External';

  qryDoorType.Open;
end;

procedure TfrmEditDoorQuotationDetailsGUI.SetFacingParams;
begin
  qryFacing.Close;
  qryFacing.ParamByName('DoorType').AsString := TEditDoorQuotationDetails(NodePropLink).DoorType.Value;

  if TEditDoorQuotationDetails(NodePropLink).DoorPlacement.Value = '0' then
    qryFacing.ParamByName('InternalExternal').AsString := 'Internal'
  else if TEditDoorQuotationDetails(NodePropLink).DoorPlacement.Value = '1' then
    qryFacing.ParamByName('InternalExternal').AsString := 'External';

  qryFacing.Open;
end;

procedure TfrmEditDoorQuotationDetailsGUI.HandleDoorTypeCloseUp(Sender: TObject);
begin
  SetFacingParams;
end;

procedure TfrmEditDoorQuotationDetailsGUI.chkFinishCostExtraClick(
  Sender: TObject);
begin
  inherited;
    cboSpecialFinish.enabled := chkFinishCostExtra.checked;
    lblfinish.enabled := chkFinishCostExtra.checked;
end;

procedure TfrmEditDoorQuotationDetailsGUI.FormShow(Sender: TObject);
begin
  inherited;
    cboSpecialFinish.enabled := chkFinishCostExtra.checked;
    lblfinish.enabled := chkFinishCostExtra.checked;
    edtTotalCost.enabled := chkManualPrice.checked;
    lblTotalcost.enabled := chkManualPrice.checked;
end;

procedure TfrmEditDoorQuotationDetailsGUI.chkManualPriceClick(
  Sender: TObject);
begin
  inherited;
    edtTotalCost.enabled := chkManualPrice.checked;
    lblTotalcost.enabled := chkManualPrice.checked;
end;

procedure TfrmEditDoorQuotationDetailsGUI.cboSpecialFinishCloseUp(
  Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
    if not (modified) then Exit;
    
end;

procedure TfrmEditDoorQuotationDetailsGUI.cboSpecialFinishExit(
  Sender: TObject);
begin
  inherited;
IF cboSpecialFinish.text = '' then edtspecialfinishcost.TEXT := '0.00';
end;

initialization
  RegisterClassOnce(TfrmEditDoorQuotationDetailsGUI);
  RegPopup.Add('Edit Door Quotation Details', 'TfrmEditDoorQuotationDetailsGUI');
  
finalization
  UnregisterClass(TfrmEditDoorQuotationDetailsGUI);

  if Assigned(RegPopup) then
    RegPopup.Remove('Edit Door Quotation Details');
end.
