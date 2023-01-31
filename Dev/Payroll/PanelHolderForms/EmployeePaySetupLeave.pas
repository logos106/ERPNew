unit EmployeePaySetupLeave;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, ExtCtrls, DNMPanel,
  wwcheckbox, wwdbdatetimepicker, wwdbedit, Mask, Wwdotdot, Wwdbcomb,
  wwdblook, Grids, Wwdbigrd, Wwdbgrid,BusObjEmployeePay,
  Buttons,BusObjBase, frmBase, DNMSpeedButton,BusObjPayUtils,BaseInputForm, ProgressDialog, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts;

type
  TEmpPaySetupLeave = Class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    grdLeave: TwwDBGrid;
    grdLeaveIButton: TwwIButton;
    cboLeaveType: TwwDBLookupCombo;
    AccrueAfter: TwwDBComboBox;
    AccruePeriod: TwwDBComboBox;
    StartPicker: TwwDBDateTimePicker;
    cboLeaveDepartment: TwwDBLookupCombo;
    chkUseDates: TwwCheckBox;
    EndPicker: TwwDBDateTimePicker;
    DSLeave: TDataSource;
    qryLeaveTypes: TERPQuery;
    lblSuper: TLabel;
    chkNICsOnLoading: TwwCheckBox;
    qryemployeepayrates: TERPQuery;
    qryemployeepayratesPayRate: TWideStringField;
    qryemployeepayratesRateType: TWideStringField;
    qryemployeepayratesQty: TFloatField;
    qryemployeepayratesHourlyRate: TFloatField;
    qryemployeepayratesAmount: TFloatField;
    qryemployeepayratesRateJob: TWideStringField;
    qryemployeepayratesClassName: TWideStringField;
    qryemployeepayratesSuper: TWideStringField;
    qryemployeepayratesLineTotal: TFloatField;
    qryemployeepayratesClientID: TIntegerField;
    qryemployeepayratesClassID: TIntegerField;
    qryemployeepayratesEmployeeRateID: TAutoIncField;
    qryemployeepayratesEmployeeID: TIntegerField;
    qryemployeepayratesPayRateID: TIntegerField;
    qryemployeepayratesTypeID: TIntegerField;
    qryemployeepayratesNICs: TWideStringField;
    qryPayRates: TERPQuery;
    qryPayRatesDescription: TWideStringField;
    qryPayRatesRateID: TAutoIncField;
    qryPayRateType: TERPQuery;
    qryJobs: TERPQuery;
    qryDepartment: TERPQuery;
    DSEmployee: TDataSource;
    dpAccruedDate: TwwDBDateTimePicker;
    btnFixAccruals: TDNMSpeedButton;
    procedure SetSubEmpPay(Const Value :Temployeepay );
    procedure SetSubPayUtils(Const Value :TpayUtils );
    procedure grdLeaveIButtonClick(Sender: TObject);
    procedure chkUseDatesClick(Sender: TObject);
    procedure btnFixAccrualsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SetDefaultDates(Sender: TObject);
    procedure cboLeaveTypeChange(Sender: TObject);
  private
    fSubEmpPay:Temployeepay;
    fSubPayUtils:TPayUtils;
//    procedure HandleEmployeeLeaveErrors;
    procedure CreateNewLeaveTypeDialog;
  public
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
    property SubPayUtils:TPayUtils  read fSubPayUtils write SetSubPayUtils ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  end;

implementation

{$R *.dfm}

uses
  BusObjConst,CommonLib,frmPayRatesFrm,BusObjPayBase, BusObjAudit;

procedure TEmpPaySetupLeave.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
end;

procedure TEmpPaySetupLeave.SetSubPayUtils(Const Value :TpayUtils);
begin
  fSubPayUtils := Value;
end;

procedure TEmpPaySetupLeave.CreateNewLeaveTypeDialog;
begin
  case CommonLib.MessageDlgXP_Vista('This leave type does not exist. Do you wish to create it?',mtConfirmation,[mbYes,mbNo],0)of
    mrYes: begin
             fSubEmpPay.EmployeeLeaves.AutoCreateNewLeaveType := True;
             CommonLib.MessageDlgXP_Vista('leave type created. A corresponding payrate will now be created.',mtInformation, [mbOK], 0);
           end;
     mrNo: begin
             fSubEmpPay.EmployeeLeaves.AutoCreateNewLeaveType := False;
             grdLeave.SetActiveField('Type');
             SetControlFocus(cboLeaveType);
           end;
  end;
end;  


//procedure TEmpPaySetupLeave.HandleEmployeeLeaveErrors;
//var
//  FatalStatusItem: TResultStatusItem;
//begin
//  if not Assigned(SubEmpPay) then exit;
//  FatalStatusItem := SubEmpPay.EmployeePayRates.ResultStatus.GetLastFatalStatusItem;
//  if Assigned(FatalStatusItem) then begin
//    case FatalStatusItem.Code of
//      BOR_EmployeeLeave_Err_NoType              : begin
//                                                    grdLeave.SetActiveField('Type');
//                                                    SetControlFocus(cboLeaveType);
//                                                  end;
//      BOR_EmployeeLeave_Err_NoAccrueAfterNo     : begin
//                                                    SetControlFocus(grdLeave);
//                                                    grdLeave.SetActiveField('AccrueAfterNo');
//                                                  end;
//      BOR_EmployeeLeave_Err_NoAccrueAfterPeriod : begin
//                                                    grdLeave.SetActiveField('AccrueAfterPeriod');
//                                                    SetControlFocus(AccrueAfter);
//                                                  end;
//      BOR_EmployeeLeave_Err_NoAccrueHrs         : begin
//                                                    SetControlFocus(grdLeave);
//                                                    grdLeave.SetActiveField('AccrueHours');
//                                                  end;
//      BOR_EmployeeLeave_Err_AccruePeriod        : begin
//                                                    SetControlFocus(AccruePeriod);
//                                                    grdLeave.SetActiveField('AccruePeriod');
//                                                   end;
//      BOR_EmployeeLeave_Err_NoDepartment        : begin
//                                                    grdLeave.SetActiveField('ClassName');
//                                                    SetControlFocus(cboLeaveDepartment);
//                                                  end;
//      BOR_EmployeeLeave_Err_NoAccrueNo          : begin
//                                                    SetControlFocus(grdLeave);
//                                                    grdLeave.SetActiveField('AccrueNo');
//                                                  end;
//    end;
//  end;
//end;


procedure TEmpPaySetupLeave.grdLeaveIButtonClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubEmpPay) then exit;
      SubEmpPay.EmployeeLeaves.Delete;
      SubEmpPay.EmployeeLeaves.Dirty := True;
    finally
    end;
  end;
end;


procedure TEmpPaySetupLeave.SetDefaultDates(Sender: TObject);
begin
   inherited;



//   cboLeaveType.DataSource.DataSet.Edit;
//   AccrueAfter.DataSource.DataSet.Edit;
//   StartPicker.DataSource.DataSet.Edit;
   chkUseDates.DataSource.DataSet.Edit;

   chkUseDates.Checked := True;

   if AccrueAfter.DataSource.DataSet.FieldByName('OpenningBalanceDate').IsNull then
   begin

      cboLeaveType.DataSource.DataSet.Edit;
      AccrueAfter.DataSource.DataSet.Edit;
      StartPicker.DataSource.DataSet.Edit;

      StartPicker.DataSource.DataSet.FieldByName('StartDate').AsDateTime := Now;
      AccrueAfter.DataSource.DataSet.FieldByName('OpenningBalanceDate').AsDateTime := Now;
   end
   else
   begin

      cboLeaveType.DataSource.DataSet.Edit;
      AccrueAfter.DataSource.DataSet.Edit;
      StartPicker.DataSource.DataSet.Edit;

      StartPicker.DataSource.DataSet.FieldByName('StartDate').AsDateTime :=
        AccrueAfter.DataSource.DataSet.FieldByName('OpenningBalanceDate').AsDateTime + 1;
      // EndPicker.DataSource.DataSet.FieldByName('EndDate').AsDateTime := Now;
   end;

   // cboLeaveType.DataSource.DataSet.Post;
   // AccrueAfter.DataSource.DataSet.Post;
   // StartPicker.DataSource.DataSet.Post;

end;


procedure TEmpPaySetupLeave.cboLeaveTypeChange(Sender: TObject);
begin
   inherited;

   if DSLeave.State = dsInsert then
   begin

      DSLeave.DataSet.FieldByName('UseStartEndDates').AsBoolean := true;

      if DSLeave.DataSet.FieldByName('OpenningBalanceDate').IsNull then
      begin

         DSLeave.DataSet.FieldByName('StartDate').AsDateTime := Now;
         DSLeave.DataSet.FieldByName('OpenningBalanceDate').AsDateTime := Now;
      end
      else
      begin

         DSLeave.DataSet.FieldByName('StartDate').AsDateTime :=
           DSLeave.DataSet.FieldByName('OpenningBalanceDate').AsDateTime + 1;
      end;

      DSLeave.DataSet.Post;

   end;

end;



procedure TEmpPaySetupLeave.chkUseDatesClick(Sender: TObject);
begin

     chkUseDates.DataSource.DataSet.Edit;


   if chkUseDates.Checked then
   begin

      if not AccrueAfter.DataSource.DataSet.FieldByName('OpenningBalanceDate').IsNull then
      begin
         StartPicker.DataSource.DataSet.FieldByName('StartDate').AsDateTime := Now;
         dpAccruedDate.DataSource.DataSet.FieldByName('OpenningBalanceDate').AsDateTime := Now;
      end
      else
      begin
         StartPicker.DataSource.DataSet.FieldByName('StartDate').AsDateTime :=
           dpAccruedDate.DataSource.DataSet.FieldByName('OpenningBalanceDate').AsDateTime + 1;
         // EndPicker.DataSource.DataSet.FieldByName('EndDate').AsDateTime := Now;
      end;

   end
   else
   begin
      StartPicker.DataSource.DataSet.FieldByName('StartDate').Clear;
      EndPicker.DataSource.DataSet.FieldByName('EndDate').Clear;
   end;

   SendMessage(StartPicker.Handle, WM_SYSKEYDOWN, VK_DOWN, 0);

   if not TwwCheckBox(Sender).DataSource.DataSet.Active then
      exit;

   TwwCheckBox(Sender).DataSource.DataSet.Edit;

   if TwwCheckBox(Sender).Checked then
      TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField)
        .AsString := 'T'
   else
      TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField)
        .AsString := 'F';
   // qryPays.edit;
end;


procedure TEmpPaySetupLeave.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
var
  Frm:TComponent;
  ErrorCode: integer;
begin
  inherited ;
  if Eventtype = BusobjEventVal_FailedLeavesValidateData then begin
//    HandleEmployeeLeaveErrors;
    ErrorCode := StrToIntDef(EventType,0);
    case ErrorCode of
      BOR_EmployeeLeave_Err_NoType              : begin
                                                    grdLeave.SetActiveField('Type');
                                                    SetControlFocus(cboLeaveType);
                                                  end;
      BOR_EmployeeLeave_Err_NoAccrueAfterNo     : begin
                                                    SetControlFocus(grdLeave);
                                                    grdLeave.SetActiveField('AccrueAfterNo');
                                                  end;
      BOR_EmployeeLeave_Err_NoAccrueAfterPeriod : begin
                                                    grdLeave.SetActiveField('AccrueAfterPeriod');
                                                    SetControlFocus(AccrueAfter);
                                                  end;
      BOR_EmployeeLeave_Err_NoAccrueHrs         : begin
                                                    SetControlFocus(grdLeave);
                                                    grdLeave.SetActiveField('AccrueHours');
                                                  end;
      BOR_EmployeeLeave_Err_AccruePeriod        : begin
                                                    SetControlFocus(AccruePeriod);
                                                    grdLeave.SetActiveField('AccruePeriod');
                                                   end;
      BOR_EmployeeLeave_Err_NoDepartment        : begin
                                                    grdLeave.SetActiveField('ClassName');
                                                    SetControlFocus(cboLeaveDepartment);
                                                  end;
      BOR_EmployeeLeave_Err_NoAccrueNo          : begin
                                                    SetControlFocus(grdLeave);
                                                    grdLeave.SetActiveField('AccrueNo');
                                                  end;
    end;
  end;
  if Eventtype = BusobjEventVal_HandleNewLeaveType then begin
    CreateNewLeaveTypeDialog;
  end;
  if Eventtype = BusobjEventVal_HandleNewPayRate then begin
    if FormStillOpen('TfrmPayRates') then TForm(FindExistingComponent('TfrmPayRates')).Destroy;
      frm := GetComponentByClassName('TfrmPayRates');
      with TfrmPayRates(frm) do begin
        NewDescription := SubEmpPay.EmployeeLeaves.LeaveType;
        IsLeave := 'T';
        FormStyle := fsNormal;
        edtDescription.Enabled := False;
        ShowModal;
      end;  //maybe tie this to the same connection later
      qryLeaveTypes.Refresh;
  end;
end;


procedure TEmpPaySetupLeave.FormCreate(Sender: TObject);
begin
   AllowCustomiseGrid := True;
   AllowGridSorting := True;
   inherited;

end;



procedure TEmpPaySetupLeave.btnFixAccrualsClick(Sender: TObject);
var
  Audit:  TAudit;
begin
  inherited;
  if commonlib.MessageDlgXP_Vista('This process will recalculate accruals using ' +
    'this employees current settings (Award etc), so if any of these settings ' +
    'have changed during the course of the employee''s employment, the accruals '+
    'will use the new rates and the resulting accruals may differ from current ' +
    'values, ie this employee''s history will be adjusted.' +
    #13#10 + #13#10 + 'Do you wish to continue?',
    mtWarning,[mbYes,mbNo],0) = mrNo then
    exit;

  Processingcursor(True);
  try
    try
      subPayUtils.VerifyAndFixAccruedLeave(fSubEmpPay.EmployeeDetails.ID);
    finally
    end;

    { record in audit trail that user ran this function }
    Audit:= TAudit.Create(nil);
    try
      Audit.Load(0);
      Audit.New;
      Audit.TransType:= 'EmployeeDetails';
      Audit.DataDescription:= 'Main';
      Audit.AuditDate:= now;
      Audit.TransGlobalref := fSubEmpPay.EmployeeDetails.GlobalRef;
      Audit.ChangeDescription:= 'User ran "Confirm Accruals" for employee ' + fSubEmpPay.EmployeeDetails.EmployeeName;
      //Audit.LogDetails(sl);
      try
          Audit.Save;
      Except
          // kill the exception when ChangeDescription is more than 255 chars
      end;
    finally
      FreeandNil(Audit);
    end;



    SubEmpPay.Save;
    grdLeave.DataSource.DataSet.Refresh;
    grdLeave.Invalidate;
  finally
    Processingcursor(False);
  end;    
end;

initialization
RegisterClassOnce(TEmpPaySetupLeave);
end.
