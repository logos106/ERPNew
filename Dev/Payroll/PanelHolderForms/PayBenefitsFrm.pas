unit PayBenefitsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,BusObjPaybase, ExtCtrls, DNMPanel, StdCtrls,
  wwcheckbox, Mask, wwdbedit, Wwdotdot, Wwdbcomb, Buttons, Wwdbigrd, Grids,
  Wwdbgrid, DB, MemDS, DBAccess, MyAccess, wwdblook, BusObjBase, frmBase;

type
  TfrmPayBenefits = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    Bevel1: TBevel;
    DNMPanel2: TDNMPanel;
    Bevel2: TBevel;
    DSpaysbenefits: TDataSource;
    grdBenefits: TwwDBGrid;
    btnDeleteBenefit: TwwIButton;
    cboNicClass: TwwDBComboBox;
    cboBenefitOrExpense: TwwDBComboBox;
    chkIsNicPayable: TwwCheckBox;
    qryDepartment: TMyQuery;
    DSPaySuper: TDataSource;
    qrySuperType: TMyQuery;
    qrySuppliers: TMyQuery;
    grdSuper: TwwDBGrid;
    btnSuperDelete: TwwIButton;
    SuperType: TwwDBLookupCombo;
    SuperFund: TwwDBLookupCombo;
    edAmountSuper: TwwDBEdit;
    SuperCalcBy: TwwDBComboBox;
    cboBenefitDept: TwwDBLookupCombo;
    cboSuperDepartment: TwwDBLookupCombo;
    procedure SetSubPay(Const Value :Tpaybase );
    procedure btnSuperDeleteClick(Sender: TObject);
    procedure btnDeleteBenefitClick(Sender: TObject);
  private
    fSubPay:Tpaybase;
  public
    procedure DoPaySuperBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string); 
    property SubPay:Tpaybase  read fSubPay write SetSubPay ;
    procedure HandleBenefitErrors ;
  end;

implementation

{$R *.dfm}
uses
  BusObjConst,CommonLib;

procedure TfrmPayBenefits.DoPaySuperBusinessObjectEvent(
  const Sender: TDatasetBusObj; const EventType, Value: string);
  begin
  if Eventtype = BusobjEventVal_HandleIncompleteRecord then begin
    HandleBenefitErrors;
  end;
end;

procedure TfrmPayBenefits.SetSubPay(Const Value :Tpaybase);
begin
  fSubPay := Value;
end;

procedure TfrmPayBenefits.HandleBenefitErrors ;
var
  FatalStatusItem: TResultStatusItem;
begin
  try
    if not Assigned(SubPay) then exit;
    FatalStatusItem := SubPay.PayBenefits.ResultStatus.GetLastFatalStatusItem;
    if Assigned(FatalStatusItem) then begin
      case FatalStatusItem.Code of            //UK
        BOR_PayBenefit_Err_NoDescription   : begin
                                               grdBenefits.SetActiveField('Description');
                                               SetControlFocus(grdBenefits);
                                               exit;
                                             end;
        BOR_PayBenefit_Err_NoNICsClass     : begin
                                               grdBenefits.SetActiveField('NICsClass');
                                               SetControlFocus(grdBenefits);
                                               exit;
                                             end;
        BOR_PayBenefit_Err_NoNIEmployeeAmount : begin
                                                  grdBenefits.SetActiveField('EmployeeNICAmount');
                                                  SetControlFocus(grdBenefits);
                                                  exit;
                                                end;
        BOR_PayBenefit_Err_NoNIEmployerAmount : begin
                                                  grdBenefits.SetActiveField('EmployerNICAmount');
                                                  SetControlFocus(grdBenefits);
                                                  exit;
                                                end;
        BOR_PayBenefit_Err_NoDepartmentUK : begin
                                              grdBenefits.SetActiveField('ClassName');
                                              SetControlFocus(grdBenefits);
                                              exit;
                                            end;
                                            //Aust

        BOR_PayBenefit_Err_NoSuperType    : begin
                                              grdSuper.SetActiveField('SuperType');
                                              SetControlFocus(grdSuper);
                                              exit;
                                            end;
        BOR_PayBenefit_Err_NoDateJoined   : begin
                                              grdSuper.SetActiveField('DateJoined');
                                              SetControlFocus(grdSuper);
                                              exit;
                                            end;
        BOR_PayBenefit_Err_NoAmount       : begin
                                              grdSuper.SetActiveField('Amount');
                                              SetControlFocus(grdSuper);
                                              exit;
                                            end;
        BOR_PayBenefit_Err_NoAmountPaid    : begin
                                              grdSuper.SetActiveField('AmountPaid');
                                              SetControlFocus(grdSuper);
                                              exit;
                                            end;
        BOR_PayBenefit_Err_NoDepartmentAust: begin
                                              grdSuper.SetActiveField('ClassName');
                                              SetControlFocus(grdSuper);
                                              exit;
                                            end;
        BOR_PayBenefit_Err_NoFund          : begin
                                              grdSuper.SetActiveField('SuperFund');
                                              SetControlFocus(grdSuper);
                                              exit;
                                            end;

      end;
    end;
  except

  end;
end;


procedure TfrmPayBenefits.btnSuperDeleteClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubPay) then exit;
      SubPay.PayBenefits.Delete;
    finally
    end;
  end;
end;

procedure TfrmPayBenefits.btnDeleteBenefitClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      SubPay.PayBenefits.Delete;
    finally
    end;
  end;
end;

initialization
RegisterClassOnce(TfrmPayBenefits);
end.
