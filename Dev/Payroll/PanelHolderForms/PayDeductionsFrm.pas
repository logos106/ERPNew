unit PayDeductionsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,BusObjPaybase, ExtCtrls, DNMPanel, StdCtrls,
  wwcheckbox, Wwdotdot, Wwdbcomb, Mask, wwdbedit, wwdblook, Buttons,
  Wwdbigrd, Grids, Wwdbgrid, DB, MemDS, DBAccess, MyAccess,ERPdbComponents,BusObjBase,
  frmPayFormsBase, Menus, ProgressDialog, ImgList, AdvMenus, DataState,
  AppEvnts, SelectionDialog;

type
  TfrmPayDeductions = Class(TfmPayFormsBase)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    DSPayDeductions: TDataSource;
    qryBasedOn: TERPQuery;
    qryBasedOnBasedOn: TWideStringField;
    qryBasedOnBasedOnID: TAutoIncField;
    qryDeductions: TERPQuery;
    qryDepartment: TERPQuery;
    qryJobs: TERPQuery;
    grdDeductions: TwwDBGrid;
    btnDeductionDelete: TwwIButton;
    Deduction: TwwDBLookupCombo;
    Amount: TwwDBEdit;
    cboDeductCalcBy: TwwDBComboBox;
    DeductBasedOn: TwwDBLookupCombo;
    cboDeductDept: TwwDBLookupCombo;
    QryAreaCodes: TERPQuery;
    QryAreaCodesAreaCode: TWideStringField;
    QryAreaCodesAreaName: TWideStringField;
    cboAreaCode: TwwDBLookupCombo;
    procedure DeductionCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnDeductionDeleteClick(Sender: TObject);
    procedure SetSubPay(Const Value :Tpaybase );
  private
    fSubPay:Tpaybase;
    procedure HandlePayDeductionErrors;
    function getTaxExemptDisplayLabel: String;
  Protected
    Procedure InitForDefaultOptionsGrid;Override;
  public
    property SubPay:Tpaybase  read fSubPay write SetSubPay;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Property TaxExemptDisplayLabel:String read getTaxExemptDisplayLabel;

  end;

implementation

{$R *.dfm}
uses
  BusObjConst,CommonLib, GridLib;

procedure TfrmPayDeductions.SetSubPay(Const Value :Tpaybase);
begin
  fSubPay := Value;
end;

procedure TfrmPayDeductions.HandlePayDeductionErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  if not Assigned(SubPay) then exit;
  FatalStatusItem := SubPay.PayDeductions.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    SetControlFocus(grdDeductions);
    case FatalStatusItem.Code of
      BOR_PayDeductions_Err_NoDescription  : begin
                                               grdDeductions.SetActiveField('Deduction');
                                             end;
      BOR_PayDeductions_Err_NoAmount       : begin
                                               grdDeductions.SetActiveField('Amount');
                                             end;
      BOR_PayDeductions_Err_NoCalcBy       : begin
                                               grdDeductions.SetActiveField('CalcBy');
                                             end;
      BOR_PayDeductions_Err_NoBasedOnID    : begin
                                               grdDeductions.SetActiveField('BasedOn');
                                             end;
      BOR_PayDeductions_Err_NoDepartment   : begin
                                               grdDeductions.SetActiveField('ClassName');
                                             end;
      BOR_PayDeductions_Err_NoQty          : begin
                                               grdDeductions.SetActiveField('Qty');
                                             end;
    end;
  end;
end;


procedure TfrmPayDeductions.InitForDefaultOptionsGrid;
begin
  inherited;
  IncludeForDefaultOptions(grdDeductions);
end;

procedure TfrmPayDeductions.DeductionCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  if not Assigned(SubPay) then exit;
  Processingcursor(True);
  try
    SubPay.PayDeductions.AddDeductionDetails;
    SubPay.RecalcAll;
  finally
    Processingcursor(False);
  end;
end;

procedure TfrmPayDeductions.btnDeductionDeleteClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubPay) then exit;
      SubPay.PayDeductions.Delete;
      SubPay.RecalcAll;
    except

    end;
  end;
end;

procedure TfrmPayDeductions.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if Value = BusobjEventVal_FailedDeductionsValidateData then begin
    HandlePayDeductionErrors;
  end;
end;

function TfrmPayDeductions.getTaxExemptDisplayLabel: String;
begin
  result := GridDisplayLabel(grdDeductions , 'TaxExempt');
end;

initialization
RegisterClassOnce(TfrmPayDeductions);
end.
