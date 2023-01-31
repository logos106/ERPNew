unit AwardLeavesFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, ExtCtrls, DNMPanel,BusObjAwards, StdCtrls,
  wwcheckbox, wwdbdatetimepicker, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  wwdblook, Buttons, Wwdbigrd, Grids, Wwdbgrid, DB, MemDS, DBAccess,
  MyAccess,ERPdbComponents, Forms, frmBase, Menus;

type
  TfrmAwardLeaves = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    DSLeave: TDataSource;
    qryLeaveTypes: TERPQuery;
    grdLeave: TwwDBGrid;
    btnLeave: TwwIButton;
    cboLeave: TwwDBLookupCombo;
    AccrueAfterPeriod: TwwDBComboBox;
    dtpAwardStartDate: TwwDBDateTimePicker;
    dtpAwardEndDate: TwwDBDateTimePicker;
    AccruePeriod: TwwDBComboBox;
    chkUseStartEndDates: TwwCheckBox;
    edAccrueAfterNo: TwwDBEdit;
    edAccrueNo: TwwDBEdit;
    edAccrueHours: TwwDBEdit;
    procedure btnLeaveClick(Sender: TObject);
    procedure SetSubAward(Const Value :TAward);
  private
    fSubAward:TAward;
  public
    property SubAward:TAward read fSubaward write SetSubAward ;
    procedure HandleAwardLeaveErrors;
  end;       


implementation

uses
  BusObjConst,BusObjBase,CommonLib;

procedure TfrmAwardLeaves.SetSubAward(Const Value :TAward);
begin
  fSubAward := Value;
end;
{$R *.dfm}



procedure TfrmAwardLeaves.HandleAwardLeaveErrors ;
var
  FatalStatusItem: TResultStatusItem;
begin
  try
    if not Assigned(SubAward) then exit;
    FatalStatusItem :=  SubAward.AwardLeaves.ResultStatus.GetLastFatalStatusItem;
    if Assigned(FatalStatusItem) then begin
      case FatalStatusItem.Code of
        BOR_AwardLeaves_Err_NoLeave        : begin
                                               grdLeave.SetActiveField('Type');
                                               SetControlFocus(cboLeave);
                                               exit;
                                             end;
        BOR_AwardLeaves_Err_NoAccrueAfterNo : begin
                                               grdLeave.SetActiveField('AccrueAfterNo');
                                               SetControlFocus(edAccrueAfterNo);
                                               exit;
                                             end;
        BOR_AwardLeaves_Err_NoAfterPeriod   : begin
                                               grdLeave.SetActiveField('AccrueAfterPeriod');
                                               SetControlFocus(AccrueAfterPeriod);
                                               exit;
                                             end;
        BOR_AwardLeaves_Err_NoAccrueNo      : begin
                                               grdLeave.SetActiveField('AccrueNo');
                                               SetControlFocus(edAccrueNo);
                                               exit;
                                             end;
        BOR_AwardLeaves_Err_NoAccruePeriod  : begin
                                               grdLeave.SetActiveField('AccruePeriod');
                                               SetControlFocus(AccruePeriod);
                                               exit;
                                             end;
        BOR_AwardLeaves_Err_NoAccrueHours   : begin
                                               grdLeave.SetActiveField('AccrueHours');
                                               SetControlFocus(edAccrueHours);
                                               exit;
                                             end;
        BOR_AwardLeaves_Err_NoStartDate     : begin
                                               grdLeave.SetActiveField('AwardStartDate');
                                               SetControlFocus(dtpAwardStartDate);
                                               exit;
                                              end;
        BOR_AwardLeaves_Err_NoEndDate       : begin
                                               grdLeave.SetActiveField('AwardEndDate');
                                               SetControlFocus(dtpAwardEndDate);
                                               exit;
                                              end;

      end;
    end;
  except
    
  end;
end;


    
procedure TfrmAwardLeaves.btnLeaveClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      SubAward.AwardLeaves.Delete;
    finally
    end;
  end;
end;

initialization
RegisterClassOnce(TfrmAwardLeaves);
end.
