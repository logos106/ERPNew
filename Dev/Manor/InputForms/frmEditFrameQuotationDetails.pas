unit frmEditFrameQuotationDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseProcTreeEdit, AppEvnts, ExtCtrls, DNMSpeedButton, StdCtrls,
  Shader, DB, MemDS, DBAccess,
  MyAccess,ERPdbComponents, wwdblook, MessageConst, wwcheckbox, wwclearbuttongroup,
  wwradiogroup, AdvEdit, TypInfo;

type
  TfrmEditFrameQuotationDetailsGUI = class(TBaseProcTreeEditGUI)
    Bevel2: TBevel;
    Label1: TLabel;
    lblOrderNumber: TLabel;
    Label2: TLabel;
    cboFrameType: TwwDBLookupCombo;
    Label3: TLabel;
    cboStopType: TwwDBLookupCombo;
    qryFrameType: TERPQuery;
    Bevel3: TBevel;
    btnArchitrave: TDNMSpeedButton;
    btnFanLight: TDNMSpeedButton;
    btnThresholdStrip: TDNMSpeedButton;
    btnExtensionDetails: TDNMSpeedButton;
    rdgFrames: TwwRadioGroup;
    btnItumescentStrip: TDNMSpeedButton;
    Label4: TLabel;
    Label5: TLabel;
    edtTotalDoorWidth: TAdvEdit;
    Label6: TLabel;
    edtDoorHeight: TAdvEdit;
    Label7: TLabel;
    Label8: TLabel;
    Bevel4: TBevel;
    Label9: TLabel;
    edtDoorThickness: TAdvEdit;
    Label10: TLabel;
    Label11: TLabel;
    edtOverallHeight: TAdvEdit;
    Label12: TLabel;
    Label13: TLabel;
    Bevel5: TBevel;
    Label14: TLabel;
    edtMaterial: TAdvEdit;
    Label15: TLabel;
    Label16: TLabel;
    edtWebThicknessInches: TAdvEdit;
    Label17: TLabel;
    Label18: TLabel;
    edtTimberCost: TAdvEdit;
    Label20: TLabel;
    edtCostLinearMetre: TAdvEdit;
    Label22: TLabel;
    edtWidthInches: TAdvEdit;
    edtWidthMills: TAdvEdit;
    edtWebThicknessMills: TAdvEdit;
    Label19: TLabel;
    Label21: TLabel;
    chkUnassembled: TwwCheckBox;
    Label25: TLabel;
    Bevel6: TBevel;
    chkWrapped: TwwCheckBox;
    chkIdentified: TwwCheckBox;
    edtDeliveryCharge: TAdvEdit;
    Label30: TLabel;
    edtProfitAdded: TAdvEdit;
    Label31: TLabel;
    edtTotalCost: TAdvEdit;
    lblTotalcost: TLabel;
    qryStopType: TERPQuery;
    qryFinish: TERPQuery;
    btnLooseStopDetails: TDNMSpeedButton;
    Label33: TLabel;
    edtCost: TAdvEdit;
    Label34: TLabel;
    edtSpecialFinishcost: TAdvEdit;
    Label26: TLabel;
    edtCarpetGap: TAdvEdit;
    Label23: TLabel;
    edtTolerance: TAdvEdit;
    Label24: TLabel;
    chkDoorOverPanel: TwwCheckBox;
    Label27: TLabel;
    Label29: TLabel;
    memComments: TMemo;
    Label35: TLabel;
    edtBasicFramecost: TAdvEdit;
    Label28: TLabel;
    cboSpecialFinish: TwwDBLookupCombo;
    chkManualPrice: TwwCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnArchitraveClick(Sender: TObject);
    procedure btnFanLightClick(Sender: TObject);
    procedure btnThresholdStripClick(Sender: TObject);
    procedure btnExtensionDetailsClick(Sender: TObject);
    procedure btnItumescentStripClick(Sender: TObject);
    procedure btnFanLightEnter(Sender: TObject);
    procedure cboFrameTypeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboStopTypeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnLooseStopDetailsClick(Sender: TObject);
    procedure cboSpecialFinishCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormShow(Sender: TObject);
    procedure chkManualPriceClick(Sender: TObject);
    procedure cboSpecialFinishExit(Sender: TObject);
  private
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure CreateAndShowForm(const ClassStr, NodeStr: string);
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses
  CommonLib, CommonDbLib, NodePropertiesLink, EditFrameQuotationDetailsObj,
  RegPopupObj, FastFuncs;

procedure TfrmEditFrameQuotationDetailsGUI.CreateAndShowForm(const ClassStr, NodeStr: string);
var
  Form: TBaseProcTreeEditGUI;
begin
  inherited;
//  TEditFrameQuotationDetails(NodePropLink).SetDoorsProps;
  Form := TBaseProcTreeEditGUI(GetComponentByClassName(ClassStr));

  if Assigned(Form) and Assigned(NodePropLink) and Assigned(NodePropLink.BaseTreeNode) then begin
    try
      Form.NodePropLink := TNodePropertiesLink(GetObjectProp(NodePropLink, NodeStr));
      Form.NodePropLink.DisplayDialogs := True;
      SendMessage(Form.Handle, TX_PerformStartup, Handle, 0);

      if Form.ShowModal = mrOK then
        TEditFrameQuotationDetails(NodePropLink).SummaryCost.Value := FloatToStr(NodePropLink.CalcSummaryCost);
    finally
      Form.Release;
    end;
  end;
end;

procedure TfrmEditFrameQuotationDetailsGUI.FormCreate(Sender: TObject);
begin
  inherited;
  NodePropLink := TEditFrameQuotationDetails.Create(Self);
  NodePropLink.DisplayDialogs := True;
end;

procedure TfrmEditFrameQuotationDetailsGUI.PerformStartup(var Msg: TMessage);
begin
  lblOrderNumber.Caption := string((Ptr(Msg.lParam))^);
  qryFrameType.Connection := GetSharedMyDacConnection;
  qryFrameType.Open;
  qryFrameType.FieldByName('DoorType').DisplayWidth := 20;
  qryStopType.Connection := GetSharedMyDacConnection;
  qryStopType.Open;
  qryStopType.FieldByName('StopType').DisplayWidth := 20;
  qryFinish.Connection := GetSharedMyDacConnection;
  qryFinish.Open;
  qryFinish.FieldByName('FinishName').DisplayWidth := 20;
  inherited;
end;

procedure TfrmEditFrameQuotationDetailsGUI.btnArchitraveClick(Sender: TObject);
begin
  inherited;
  CreateAndShowForm('TfrmFrameArchitraveDetailsGUI', 'FrameArchitraveDetails');
end;

procedure TfrmEditFrameQuotationDetailsGUI.btnFanLightClick(Sender: TObject);
begin
  inherited;
  CreateAndShowForm('TfrmFrameFanLightDetailsGUI', 'FrameFanLightDetails');
end;

procedure TfrmEditFrameQuotationDetailsGUI.btnThresholdStripClick(Sender: TObject);
begin
  inherited;
  CreateAndShowForm('TfrmFrameThresholdDetailsGUI', 'FrameThresholdDetails');
end;

procedure TfrmEditFrameQuotationDetailsGUI.btnExtensionDetailsClick(Sender: TObject);
begin
  inherited;
  CreateAndShowForm('TfrmFrameExtensionDetailsGUI', 'FrameExtensionDetails');
end;

procedure TfrmEditFrameQuotationDetailsGUI.btnItumescentStripClick(Sender: TObject);
begin
  inherited;
  CreateAndShowForm('TfrmFrameIntumescentStripDetailsGUI', 'FrameIntumescentStripDetails');
end;

procedure TfrmEditFrameQuotationDetailsGUI.btnFanLightEnter(
  Sender: TObject);
begin
  inherited;
    if FastFuncs.PosEx('FRA1', cboFrameType.text) <> 0 then begin
        SetFocusedControl(btnThresholdStrip);
        cboFrameType.enabled := False;
    end;
end;

procedure TfrmEditFrameQuotationDetailsGUI.cboFrameTypeCloseUp(
  Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
    btnFanLight.Enabled := FastFuncs.PosEx('FRA1', cboFrameType.text) = 0  ; // moreen asked to disable this option when the door type is 'FRA1'
end;

procedure TfrmEditFrameQuotationDetailsGUI.cboStopTypeCloseUp(
  Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
    if not modified then exit;
    if FastFuncs.SameText(cboStopType.text , 'Loose Stop') then
        CreateAndShowForm('TfmFrameLoopStopDetail', 'FrameLooseStopDetails');
    btnLooseStopDetails.enabled :=SameText(cboStopType.text , 'Loose Stop') ;
end;
procedure TfrmEditFrameQuotationDetailsGUI.btnLooseStopDetailsClick(
  Sender: TObject);
begin
    inherited;
    if FastFuncs.SameText(cboStopType.text , 'Loose Stop') then
        CreateAndShowForm('TfmFrameLoopStopDetail', 'FrameLooseStopDetails')
end;

procedure TfrmEditFrameQuotationDetailsGUI.cboSpecialFinishCloseUp(
  Sender: TObject; LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
    if not (modified) then Exit;
    TEditFrameQuotationDetails(NodePropLink).specialfinishcost.Value := qryFinish.fieldByname('Cost').asString;
end;

procedure TfrmEditFrameQuotationDetailsGUI.FormShow(Sender: TObject);
begin
  inherited;
    cboFrameTypeCloseUp(cboFrameType ,  cboFrameType.LookupTable, nil,true);
end;

procedure TfrmEditFrameQuotationDetailsGUI.chkManualPriceClick(
  Sender: TObject);
begin
  inherited;
    edtTotalCost.enabled := chkManualPrice.checked;
    lblTotalcost.enabled := chkManualPrice.checked;
end;

procedure TfrmEditFrameQuotationDetailsGUI.cboSpecialFinishExit(
  Sender: TObject);
begin
  inherited;
    IF cboSpecialFinish.text = '' then edtSpecialFinishcost.TEXT := '0.00';
end;

initialization
    RegisterClassOnce(TfrmEditFrameQuotationDetailsGUI);
    RegPopup.Add('Edit Frame Quotation Details', 'TfrmEditFrameQuotationDetailsGUI');
finalization
    UnregisterClass(TfrmEditFrameQuotationDetailsGUI);
    if Assigned(RegPopup) then
        RegPopup.Remove('Edit Frame Quotation Details');
end.


