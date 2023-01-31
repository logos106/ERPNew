unit TerminateSimpleFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmPayFormsBase,ExtCtrls, StdCtrls, DB, Mask, wwdbedit, DNMPanel,
  BusObjPayBase, Menus, wwcheckbox, MessageConst, ProgressDialog, MemDS,
  DBAccess, MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog, DBCtrls;

type
  TfmTerminationSimple = Class(TfmPayFormsBase)
    dsTerminate: TDataSource;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    edtLumpSumD: TwwDBEdit;
    dsPays: TDataSource;
    chkTerminated: TwwCheckBox;
    edtAnualLeaveHours: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtRDOHours: TEdit;
    Label4: TLabel;
    cboETPCode: TDBComboBox;
    Label5: TLabel;
    lblETPCode: TLabel;
    procedure edtLumpSumDEnter(Sender: TObject);
    procedure edtLumpSumDExit(Sender: TObject);
    procedure chkTerminatedClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboETPCodeChange(Sender: TObject);
  private
    fSubPay: Tpaybase;
    fTermDateDone: boolean;
    { Private declarations }
    procedure CalcTermination;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
  public
    property SubPay: Tpaybase  read fSubPay write fSubPay ;
    procedure ShowETPCodeLabel;
  end;

implementation

{$R *.dfm}

uses
  frmDateInputBox, CommonLib;


procedure TfmTerminationSimple.FormCreate(Sender: TObject);
begin
  inherited;
  fTermDateDone := false;
end;

procedure TfmTerminationSimple.CalcTermination;
var
  dt: TDateTime;
//  AnnualLeaveTotalHours: double;
begin
  if chkTerminated.Checked then begin
    if SubPay.Termination.Count = 0 then begin
      SubPay.Termination.New;
      SubPay.PostDb;
    end;
    if not fTermDateDone then begin
      SubPay.Termination.Deleted := false;
      if SubPay.EmployeeDetails.DateFinished > 0 then
        dt := SubPay.EmployeeDetails.DateFinished
      else
        dt := Trunc(Now);
      if TfmDateInputBox.InputValue('Termination Date','Enter the employees termination date',dt, Parentformcolor(edtLumpSumD)) then begin
        SubPay.EmployeeDetails.IsTerminated := true;
        SubPay.EmployeeDetails.DateFinished := dt;
        SubPay.EmployeeDetails.PostDb;
      end
      else begin
        CommonLib.MessageDlgXP_Vista('Please use this the Employee Card to set this employees termination date',mtInformation,[mbOk],0);
      end;
      fTermDateDone := true;
    end;

    SubPay.Termination.CalcTermination;

//    { pay out all anual leave }
//    AnnualLeaveTotalHours := SubPay.LeaveAccruals.GetAccruedHrs('Annual Leave',SubPay.Paydate) + SubPay.PayLeaves.GetThisPayLeaveHrsEntitlement('Annual Leave');
//    if SubPay.EmployeeLeave.Dataset.Locate('Type','Anual Leave',[]) then
//      AnnualLeaveTotalHours := AnnualLeaveTotalHours + SubPay.EmployeeLeave.Openningbalancehrs;
//    if AnnualLeaveTotalHours <> 0 then begin
//      SubPay.PayLeaves.New;
//      SubPay.PayLeaves.Leavetype := 'Annual Leave';
//      SubPay.PayLeaves.Datetaken := dt;
//      SubPay.PayLeaves.Qty := AnnualLeaveTotalHours;
//      SubPay.PayLeaves.PostDb;
//    end;



  end
  else begin
    { not terminated }
    if SubPay.Termination.Count <> 0 then begin
      SubPay.Termination.Deleted := true;
    end;
    SubPay.EmployeeDetails.IsTerminated := false;
    SubPay.EmployeeDetails.DateFinished := 0;
    SubPay.EmployeeDetails.PostDb;
    SubPay.Termination.CalcTermination;

  end;
  edtAnualLeaveHours.Text := FormatFloat('#0.0##;(#0.0##)',SubPay.Termination.DataObj.F['AnnualLeaveHours']);
  edtRDOHours.Text := FormatFloat('#0.0##;(#0.0##)',SubPay.Termination.DataObj.F['RDOHours']);
end;

procedure TfmTerminationSimple.cboETPCodeChange(Sender: TObject);
begin
  inherited;
  ShowETPCodeLabel;
end;

procedure TfmTerminationSimple.chkTerminatedClick(Sender: TObject);
begin
  inherited;
  if chkTerminated.Focused then begin
    SubPay.IsTermination := chkTerminated.Checked;
    CalcTermination;
  end;

  if chkTerminated.Checked then begin
    CommonLib.MessageDlgXP_Vista('You need to specify termination code.', mtInformation, [mbOK], 0);
    dsTerminate.Dataset.FieldByName('ETPCode').AsString := 'B';
  end;

end;

procedure TfmTerminationSimple.edtLumpSumDEnter(Sender: TObject);
begin
  inherited;
  { force the business object to open the query }
//  if not edtLumpSumD.DataSource.DataSet.Active then
//    SubPay.Termination;
//  if SubPay.Termination.Count = 0 then begin
//    SubPay.Termination.New;
//    SubPay.PostDb;
//  end;

end;

procedure TfmTerminationSimple.edtLumpSumDExit(Sender: TObject);
(*var
  dt: TDAteTime;*)
begin
  inherited;
  if SubPay.Termination.LumpSumD <> 0 then begin
    if not SubPay.EmployeeDetails.IsTerminated then begin
//      if SubPay.EmployeeDetails.DateFinished > 0 then
//        dt := SubPay.EmployeeDetails.DateFinished
//      else
//        dt := Trunc(Now);
//      if TfmDateInputBox.InputValue('Termination Date','Enter the employees termination date',dt, Parentformcolor(edtLumpSumD)) then begin
//        SubPay.EmployeeDetails.IsTerminated := true;
//        SubPay.EmployeeDetails.DateFinished := dt;
//        SubPay.EmployeeDetails.PostDb;
//      end
//      else begin
//        CommonLib.MessageDlgXP_Vista('Please use this the Employee Card to set this employees termination date',mtInformation,[mbOk],0);
//      end;

    end;
  end;

end;

procedure TfmTerminationSimple.PerformStartup(var Msg: TMessage);
begin
  edtAnualLeaveHours.Text := FormatFloat('#0.0##;(#0.0##)',SubPay.Termination.DataObj.F['AnnualLeaveHours']);
  edtRDOHours.Text := FormatFloat('#0.0##;(#0.0##)',SubPay.Termination.DataObj.F['RDOHours']);
end;

procedure TfmTerminationSimple.ShowETPCodeLabel;
begin
  if cboETPCode.Text = 'B' then
    lblETPCode.Caption :=
      'Death benefit ETP paid to a non-dependant of the deceased and a ' +
      'termination payment was made to the non-dependant in a previous income ' +
      'year for the same termination.'
  else if cboETPCode.Text = 'D' then
    lblETPCode.Caption :=
      'Death benefit ETP paid to a dependant of the deceased.'
  else if cboETPCode.Text = 'N' then
    lblETPCode.Caption :=
      'Death benefit ETP paid to a non-dependant of the deceased.'
  else if cboETPCode.Text = 'O' then
    lblETPCode.Caption :=
      'Other ETP not described by R (for example: golden handshake, gratuity, ' +
      'payment in lieu of notice, payment for unused sick leave, or payment ' +
      'for unused rostered days off).'
  else if cboETPCode.Text = 'P' then
    lblETPCode.Caption :=
      'ETP code O payment received in the current year and received another ' +
      'ETP (code R or code O), or a transitional termination payment, in an ' +
      'earlier income year for the same termination of employment.'
  else if cboETPCode.Text = 'R' then
    lblETPCode.Caption :=
      'ETP made because of one of the following: early retirement scheme, ' +
      'genuine redundancy, invalidity, or compensation for personal injury, ' +
      'unfair dismissal, harassment, or discrimination.'
  else if cboETPCode.Text = 'S' then
    lblETPCode.Caption :=
      'ETP code R payment received in the current year and received another ' +
      'ETP (code R or code O), or a transitional termination payment, in an '+
      'earlier income year for the same termination of employment.'
  else if cboETPCode.Text = 'T' then
    lblETPCode.Caption :=
      'Death benefit ETP paid to a trustee of the deceased estate.';


end;

initialization
  RegisterClass(TfmTerminationSimple);


end.
