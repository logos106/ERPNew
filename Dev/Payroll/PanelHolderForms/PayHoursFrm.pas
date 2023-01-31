unit PayHoursFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, wwdbedit, StdCtrls, wwdblook, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, ExtCtrls, DNMPanel,
  BusObjPaybase, BusObjBase, frmPayFormsBase, wwcheckbox, ProgressDialog,
  ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog, Menus;

type
  TfrmPayHours = Class(TfmPayFormsBase)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    DSPaysPayRates: TDataSource;
    DSPayRate: TDataSource;
    qryPayRates: TERPQuery;
    qryPayRateType: TERPQuery;
    grdHours: TwwDBGrid;
    btnHrsDelete: TwwIButton;
    PayRate: TwwDBLookupCombo;
    PayType: TwwDBLookupCombo;
    edtQty: TwwDBEdit;
    PayJob: TwwDBLookupCombo;
    PayDepartment: TwwDBLookupCombo;
    qryJobs: TERPQuery;
    qryDepartment: TERPQuery;
    chkSuper: TwwCheckBox;
    procedure btnHrsDeleteClick(Sender: TObject);
    procedure grdHoursMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SetSubPay(Const Value :Tpaybase );
    procedure chkSuperClick(Sender: TObject);
  private
    fSubPay:Tpaybase;
    procedure EditLeaveFromLeaveGrid;
    procedure HandlePayHoursErrors;
  Protected
    Procedure InitForDefaultOptionsGrid;Override;
  public
    property SubPay:Tpaybase  read fSubPay write SetSubPay ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  end;

implementation

{$R *.dfm}

uses
  BusObjConst,CommonLib,PayCommon, AppEnvironment, tctypes;

procedure TfrmPayHours.SetSubPay(Const Value :Tpaybase);
begin
  fSubPay := Value;
end;

procedure TfrmPayHours.EditLeaveFromLeaveGrid;
begin
  try
    if not Assigned(SubPay) then exit;
    if IsLeave(SubPay.PaysPayRates.PayRateID) then begin
      //in case they started to add a leave in grdHours
      if SubPay.PaysPayRates.Qty = 0 then begin
        SubPay.PaysPayRates.Delete;
      end;

      CommonLib.MessageDlgXP_Vista('Change Leaves from Leaves tab.', mtInformation, [mbOK], 0);
      grdHours.SetActiveRow(0); //so they can't tab back and edit selected leave
      exit;
    end;
  except

  end;
end;

procedure TfrmPayHours.HandlePayHoursErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  if not Assigned(SubPay) then exit;
  FatalStatusItem := SubPay.PaysPayRates.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    SetControlFocus(grdHours);
    case FatalStatusItem.Code of
      BOR_PayPayrates_Err_NoDepartment       : begin
                                               grdHours.SetActiveField('ClassName');
                                             end;
      BOR_PayPayrates_Err_NoQty            : begin
                                               grdHours.SetActiveField('Qty');
                                             end;
      BOR_PayPayrates_Err_NoType           : begin
                                               grdHours.SetActiveField('RateType');
                                             end;
      BOR_PayPayrates_Err_NoRate           : begin
                                               grdHours.SetActiveField('PayRate');
                                             end;
    end;
  end;
end;

  
procedure TfrmPayHours.InitForDefaultOptionsGrid;
begin
  inherited;
  IncludeForDefaultOptions(grdHours);
end;

procedure TfrmPayHours.btnHrsDeleteClick(Sender: TObject);
begin
  if not Assigned(SubPay) then exit;
  if IsLeave(SubPay.PaysPayRates.PayRateID) then begin
    CommonLib.MessageDlgXP_Vista('Change Leaves from Leaves tab.', mtInformation, [mbOK], 0);
    exit;
  end;

  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      SubPay.PaysPayRates.Delete;
      SubPay.RecalcAll;
    except

    end;
  end;
end;

procedure TfrmPayHours.grdHoursMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  EditLeaveFromLeaveGrid;
end;

procedure TfrmPayHours.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if Value = BusobjEventVal_FailedHoursValidateData then begin
    HandlePayHoursErrors;
  end;
end;

procedure TfrmPayHours.chkSuperClick(Sender: TObject);
begin
  inherited;
  if grdHours.DataSource.DataSet.FieldByName('SuperInc').AsBoolean <> chkSuper.Checked then
    grdHours.DataSource.DataSet.FieldByName('SuperInc').AsBoolean:= chkSuper.Checked;
end;

initialization
RegisterClassOnce(TfrmPayHours);
end.
