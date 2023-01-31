unit PayLeavesFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DNMPanel, StdCtrls, wwcheckbox, wwdblook,
  Buttons, Wwdbigrd, Grids, Wwdbgrid, DB, MemDS, DBAccess, MyAccess,ERPdbComponents,BusObjPaybase,
  Mask, wwdbedit,BusObjBase, frmPayFormsBase, wwdbdatetimepicker,
  ProgressDialog, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog, Menus;

type
  TfrmPayLeaves = Class(TfmPayFormsBase)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    qryLeavePayTypes: TERPQuery;
    qryLeaveTypes: TERPQuery;
    dsPaysLeave: TDataSource;
    qryDepartment: TERPQuery;
    grdLeave: TwwDBGrid;
    btnLeaveDelete: TwwIButton;
    cboLeaveType: TwwDBLookupCombo;
    cboLeaveDept: TwwDBLookupCombo;
    chkCertified: TwwCheckBox;
    qryJobs: TERPQuery;
    edtQty: TwwDBEdit;
    dtFrom: TwwDBDateTimePicker;
    dtTo: TwwDBDateTimePicker;
    procedure btnLeaveDeleteClick(Sender: TObject);
    procedure grdLeaveExit(Sender: TObject);
    procedure SetSubPay(Const Value :Tpaybase );
  private
    fSubPay:Tpaybase;
    procedure HandlePayLeavesErrors;
  Protected
    Procedure InitForDefaultOptionsGrid;Override;
  public
    property SubPay:Tpaybase  read fSubPay write SetSubPay ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  end;

implementation

{$R *.dfm}
uses
  BusObjConst,CommonLib,PayCommon;

procedure TfrmPayLeaves.SetSubPay(Const Value :Tpaybase);
begin
  fSubPay := Value;
end;

procedure TfrmPayLeaves.HandlePayLeavesErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  if not Assigned(SubPay) then exit;
  FatalStatusItem := SubPay.PayLeaves.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    SetControlFocus(grdLeave);
    case FatalStatusItem.Code of
      BOR_PayLeaves_Err_NoType             : begin
                                               grdLeave.SetActiveField('LeaveType');
                                             end;
      BOR_PayLeaves_Err_NoDateTaken        : begin
                                               grdLeave.SetActiveField('DateTaken');
                                             end;
      BOR_PayLeaves_Err_NoQty              : begin
                                               grdLeave.SetActiveField('Qty');
                                             end;
      BOR_PayLeaves_Err_NoDepartment       : begin
                                               grdLeave.SetActiveField('ClassName');
                                             end;
      BOR_PayLeaves_Err_FromAfterTo  :  begin
                                            grdLeave.SetActiveField('TakenTo');  
                                          end;
    end;
  end;
end;     

procedure TfrmPayLeaves.InitForDefaultOptionsGrid;
begin
  inherited;
  IncludeForDefaultOptions(grdLeave);
end;

procedure TfrmPayLeaves.btnLeaveDeleteClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubPay) then exit;
      //first delete this leave type from hours.
      If SubPay.PaysPayRates.Dataset.Locate('PayrateID;Qty',
        VarArrayOf( [GetPayRateID(SubPay.PayLeaves.leavetype),SubPay.PayLeaves.Qty]), [loCaseInsensitive]) then begin
        SubPay.PaysPayRates.Delete;
      end;

      SubPay.PayLeaves.AdjustNormalHrsOnDeleteLeave(SubPay.PayLeaves.Qty);
      SubPay.PayLeaves.Delete;
      SubPay.PayLeaves.RefreshDB;
      SubPay.RecalcAll;
    except

    end;
  end;
end;

procedure TfrmPayLeaves.grdLeaveExit(Sender: TObject);
begin
  if not Assigned(SubPay) then exit;
  SubPay.PayLeaves.PostDB;
  if SubPay.PayLeaves.LeaveChanged then begin
    SubPay.AddLeavesToPay;
    SubPay.PayLeaves.LeaveChanged := False;
    SubPay.RecalcAll;
  end;
end;

procedure TfrmPayLeaves.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if Value = BusobjEventVal_FailedLeavesValidateData then begin
    HandlePayLeavesErrors;
  end;
end;

initialization
RegisterClassOnce(TfrmPayLeaves);

end.
