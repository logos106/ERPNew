unit PayAllowancesFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,BusObjPaybase, ExtCtrls, DNMPanel, StdCtrls,
  wwcheckbox, Wwdotdot, Wwdbcomb, Mask, wwdbedit, wwdblook, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, BusObjBase,
  frmPayFormsBase, Menus, ProgressDialog, ImgList, AdvMenus, DataState,
  AppEvnts, SelectionDialog, DBCtrls;

type
  TfrmPayAllowances = Class(TfmPayFormsBase)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    DSPayAllowances: TDataSource;
    qryAllowances: TERPQuery;
    qryAllowancesDescription: TWideStringField;
    qryAllowancesAllowanceID: TAutoIncField;
    qryAllowancesSuperInc: TWideStringField;
    qryAllowancesTaxExempt: TWideStringField;
    qryAllowancesQty: TFloatField;
    qryAllowancesAmount: TFloatField;
    qryAllowancesBasedOnID: TIntegerField;
    qryAllowancesCalcBy: TWideStringField;
    qryJobs: TERPQuery;
    qryDepartment: TERPQuery;
    grdAllowances: TwwDBGrid;
    btnAllowanceDelete: TwwIButton;
    cboAllowance: TwwDBLookupCombo;
    AllowQty: TwwDBEdit;
    AllowBasedOn: TwwDBLookupCombo;
    AllowanceAmount: TwwDBEdit;
    cboAllowCalcBy: TwwDBComboBox;
    chkAllowSuper: TwwCheckBox;
    chkAllowTaxExempt: TwwCheckBox;
    AllowJob: TwwDBLookupCombo;
    cboAllowDepart: TwwDBLookupCombo;
    qryBasedOn: TERPQuery;
    qryBasedOnBasedOn: TWideStringField;
    qryBasedOnBasedOnID: TAutoIncField;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    cboAreaCode: TwwDBLookupCombo;
    pnlJobKeepersTopup: TPanel;
    Label1: TLabel;
    edRegion: TDBEdit;
    DSPays: TDataSource;
    procedure cboAllowanceCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnAllowanceDeleteClick(Sender: TObject);
    procedure SetSubPay(Const Value :Tpaybase );
    procedure grdAllowancesEnter(Sender: TObject);
  private
    fSubPay:Tpaybase;
    fNoAllowancesExist:Boolean;
    procedure HandlePayAllowanceErrors;
    function getTaxExemptDisplayLabel: String;
  Protected
    Procedure InitForDefaultOptionsGrid;Override;
  public
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    property SubPay:Tpaybase  read fSubPay write SetSubPay ;
    property NoAllowancesExist:Boolean read fNoAllowancesExist write fNoAllowancesExist;
    Property TaxExemptDisplayLabel:String read getTaxExemptDisplayLabel;
  end;


implementation

{$R *.dfm}
uses
  CommonLib,BusObjConst,BusObjPaysAllowances,PayCommon, GridLib;

procedure TfrmPayAllowances.SetSubPay(Const Value :Tpaybase);
begin
  fSubPay := Value;
end;

procedure TfrmPayAllowances.HandlePayAllowanceErrors ;
var
  FatalStatusItem: TResultStatusItem;
begin
  if not Assigned(SubPay) then exit;
  FatalStatusItem := SubPay.PayAllowances.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    SetControlFocus(grdAllowances);
    case FatalStatusItem.Code of
      BOR_PayAllowance_Err_NoDescription  : begin
                                             grdAllowances.SetActiveField('Allowance');
                                           end;
      BOR_PayAllowance_Err_NoQty         : begin
                                             grdAllowances.SetActiveField('Qty');
                                           end;
      BOR_PayAllowance_Err_NoBasedOnID   : begin
                                             grdAllowances.SetActiveField('BasedOn');
                                           end;
      BOR_PayAllowance_Err_NoAmount      : begin
                                             grdAllowances.SetActiveField('Amount');
                                           end;
      BOR_PayAllowance_Err_NoDepartment  : begin
                                             grdAllowances.SetActiveField('ClassName');
                                           end;

    end;
  end;
end;


procedure TfrmPayAllowances.InitForDefaultOptionsGrid;
begin
  inherited;
  IncludeForDefaultOptions(grdAllowances);
end;

procedure TfrmPayAllowances.cboAllowanceCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  if not Assigned(SubPay) then exit;
  Processingcursor(True);
  try
    SubPay.PayAllowances.AddAllowanceDetails;
    SubPay.RecalcAll;
  finally
    Processingcursor(False);
  end;  
end;

procedure TfrmPayAllowances.btnAllowanceDeleteClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubPay) then exit;
      SubPay.PayAllowances.Delete;
      SubPay.RecalcAll;
    finally
    end;
  end;
end;

function TfrmPayAllowances.getTaxExemptDisplayLabel: String;
begin
  result := GridDisplayLabel(grdAllowances , 'TaxExempt');
end;

procedure TfrmPayAllowances.grdAllowancesEnter(Sender: TObject);
begin 
  if fNoAllowancesExist then begin
    grdAllowances.Enabled := False;
    CommonLib.MessageDlgXP_Vista('No allowances exist.', mtWarning, [mbOK], 0);
    exit;
  end;
  inherited;
end;

procedure TfrmPayAllowances.DoBusinessObjectEvent( const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if Eventtype = BusobjEventVal_HandleCalcByConflict then begin
    CommonLib.MessageDlgXP_Vista('When using %, Based On cannot be ' + GetBasedOnName(Tpaysallowances(SubPay.PayAllowances).basedOnID) + '.', mtWarning, [mbOK], 0);
  end;

  if Value = BusobjEventVal_FailedAllowancesValidateData then begin
    HandlePayAllowanceErrors;
  end;
end;

initialization
  RegisterClassOnce(TfrmPayAllowances);
end.

