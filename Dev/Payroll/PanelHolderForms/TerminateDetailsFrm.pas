unit TerminateDetailsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, wwdbdatetimepicker, wwdblook, DB, MemDS, DBAccess,
  MyAccess,ERPdbComponents, ExtCtrls, DNMPanel,BusObjTermination, Mask,
  wwdbedit, Wwdotdot, Wwdbcomb, wwcheckbox, frmBase;

type
  TfrmTerminateDetails = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    qryEmp: TERPQuery;
    Label21: TLabel;
    cboName: TwwDBLookupCombo;
    Label56: TLabel;
    Label8: TLabel;
    lblDeath: TLabel;
    dtpTerminationDate: TwwDBDateTimePicker;
    DSEmpTerminate: TDataSource;
    cboReason: TwwDBComboBox;
    cboDeathPaidTo: TwwDBComboBox;
    chkTFN: TwwCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure cboNameCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure cboReasonCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure SetSubTerminate(Const Value :Temployeeterminations   );
    procedure cboReasonDropDown(Sender: TObject);
    procedure dtpTerminationDateCloseUp(Sender: TObject);
  private
    fOldReason:String;
    fSubTerminate:Temployeeterminations;
    procedure ResetReason;
  public
   // SubTerminate:Temployeeterminations;
    property SubTerminate:Temployeeterminations  read fSubTerminate write SetSubTerminate ;
    procedure HandleTerminateDetailErrors;
  end;

implementation

uses
  DnMLib,PayCommon,BusObjConst,CommonLib, BusObjBase,BusObjPayUtils,FastFuncs;
  
procedure TfrmTerminateDetails.SetSubTerminate(Const Value :Temployeeterminations);
begin
  fSubTerminate := Value;
end;
{$R *.dfm}


procedure TfrmTerminateDetails.cboNameCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
var
//  PayUtils      :TPayUtils;
  strsql        :String;
begin           
  if not modified then Exit;
  SubTerminate.Employeename := cboName.Text;
  SubTerminate.Employeeid := DnMLib.GetEmployeeID(SubTerminate.employeename);
  SubTerminate.Startdate  := PayCommon.GetEmployeeStartDate(SubTerminate.Employeeid);
  
  if SubTerminate.Employeeid <> 0 then begin
        //if emp doesn't have an upnprocessed pay create one.
//    if GetUnprocessedPayID(SubTerminate.Employeeid) = 0 then begin


    //  PayUtils := TPayUtils.Create(nil,TERPConnection(TMyDacDataConnection(SubTerminate.Connection).MyDacConnection ));
//      try
//        PayUtils.CreateNewPay(SubTerminate.Employeeid,False,True);
//      finally
//        PayUtils.Free;;
//      end;
//    end;  
  end;

  strsql := 'SELECT PayID,EmployeeID,Paid,Deleted FROM tblPays WHERE EmployeeID = ' +
      IntToStr(SubTerminate.EmployeeID)+' AND Paid = "F"  AND Deleted = "F";';

  With SubTerminate.GetNewDataSet(strsql, True) do try
    SubTerminate.PayID := fieldByname('PayID').asInteger;
  finally
    if active then close;
    Free;
  end;

  SubTerminate.Pay.Load(SubTerminate.PayID);
  SubTerminate.Pay.RecalcAll;
end;

procedure TfrmTerminateDetails.HandleTerminateDetailErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  try
    if not Assigned(SubTerminate) then exit;
    FatalStatusItem := SubTerminate.ResultStatus.GetLastFatalStatusItem;
    if Assigned(FatalStatusItem) then begin
      case FatalStatusItem.Code of
        BOR_Termination_Err_NoName         : begin
                                              // grdBanking.SetActiveField('Type');
                                               SetControlFocus(cboName);
                                               exit;
                                             end;
        BOR_Termination_Err_NoDate         : begin
                                             //  grdBanking.SetActiveField('Split');
                                               SetControlFocus(dtpTerminationDate);
                                               exit;
                                             end;
        BOR_Termination_Err_NoReason       : begin
                                            //   grdBanking.SetActiveField('Branch');
                                               SetControlFocus(cboReason);
                                               exit;
                                             end;
      end;
    end;
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;
end;

procedure TfrmTerminateDetails.cboReasonCloseUp(Sender: TwwDBComboBox;
  Select: Boolean);
begin
  if cboReason.Text = fOldReason then exit;

  if cboReason.Text = 'Death' then begin
    lblDeath.Enabled            := True;
    cboDeathPaidTo.Enabled      := True;
    chkTFN.Enabled              := True;
    lblDeath.Visible            := True;
    cboDeathPaidTo.Visible      := True;
    chkTFN.Visible              := True;
  end else begin
    lblDeath.Enabled            := False;
    cboDeathPaidTo.Enabled      := False;
    chkTFN.Enabled              := False;
    lblDeath.Visible            := False;
    cboDeathPaidTo.Visible      := False;
    chkTFN.Visible              := False;
  end;
  SubTerminate.Reasonleft       := cboReason.Text;
  ResetReason;
end;

procedure TfrmTerminateDetails.ResetReason;
begin
  SubTerminate.ETPEarlyRetirement := 0;
  SubTerminate.ETPRedundancy      := 0;
  SubTerminate.ETPInvalidity      := 0;
end;


procedure TfrmTerminateDetails.cboReasonDropDown(Sender: TObject);
begin
  fOldReason := cboReason.Text;
end;

procedure TfrmTerminateDetails.dtpTerminationDateCloseUp(Sender: TObject);
begin
  SubTerminate.PostDb;
  SubTerminate.CalcLongService;
  SubTerminate.CalcOwedAnnual;
end;

initialization
RegisterClassOnce(TfrmTerminateDetails);
end.
