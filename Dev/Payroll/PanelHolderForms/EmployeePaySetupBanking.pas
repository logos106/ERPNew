unit EmployeePaySetupBanking;

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, AdvMenus, DataState, DB, DBAccess, MyAccess,ERPdbComponents,
  SelectionDialog, AppEvnts, ExtCtrls, MemDS, wwdblook, StdCtrls, Mask,
  wwdbedit, Wwdotdot, Wwdbcomb, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  DNMPanel,BusObjEmployeePay,BusObjBase, frmBase,BaseInputForm, ProgressDialog, ImgList;

type
  TEmpPaySetUpBanking = class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    lblWidth: TLabel;
    grdBanking: TwwDBGrid;
    grdBankingIButton: TwwIButton;
    cboPaySplit: TwwDBComboBox;
    cboSplitBank: TwwDBLookupCombo;
    cboSplitType: TwwDBComboBox;
    DSPaysplit: TDataSource;
    qryBankCodes: TERPQuery;
    wwAmount: TwwDBEdit;
    procedure grdBankingIButtonClick(Sender: TObject);
    procedure SetSubEmpPay(Const Value :Temployeepay );
    procedure wwAmountCheckValue(Sender: TObject;
      PassesPictureTest: Boolean);
    procedure qryBankCodesBeforeOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    fSubEmpPay:Temployeepay;
//    procedure HandleEmployeePaySplitsErrors;Overload;
  public
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
    procedure HandleEmployeePaySplitsErrors(FatalStatusItem: TResultStatusItem);
  end;

implementation

{$R *.dfm}
uses
  BusObjConst,CommonLib, AppEnvironment, tcTypes, GridFieldsObj;

procedure TEmpPaySetUpBanking.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
end;



procedure TEmpPaySetUpBanking.HandleEmployeePaySplitsErrors(FatalStatusItem: TResultStatusItem);
begin
  if not Assigned(SubEmpPay) then exit;
  FatalStatusItem := SubEmpPay.EmployeePayRates.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    DoBusinessObjectEvent(nil,IntToStr(FatalStatusItem.Code),BusobjEventVal_FailedBankingValidateData)
  end;
end;

procedure TEmpPaySetUpBanking.qryBankCodesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  TERPQuery(Dataset).Params.ParamByName('XRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TEmpPaySetUpBanking.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := true;
  AllowGridSorting := True;
  inherited;
end;

procedure TEmpPaySetUpBanking.grdBankingIButtonClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubEmpPay) then exit;
      SubEmpPay.EmployeePaySplit.Delete;
      SubEmpPay.EmployeePaySplit.Dirty := True;
    finally
    end;
  end;
end;

//procedure TEmpPaySetUpBanking.HandleEmployeePaySplitsErrors(
//  FatalStatusItem: TResultStatusItem);
//begin
//    SetControlFocus(grdBanking);
//    case FatalStatusItem.Code of
//      BOR_PaySplits_Err_NoBranch :begin
//                                  grdBanking.SetActiveField('branch');
//                                end;
//      BOR_EmployeePay_Err_NoAccountName    : begin
//                                               grdBanking.SetActiveField('AccountName');
//                                             end;
//      BOR_EmployeePay_Err_NoBank           : begin
//                                                grdBanking.SetActiveField('Bank');
//                                             end;
//      BOR_EmployeePay_Err_NoBSBNumber      : begin
//                                                grdBanking.SetActiveField('BSB');
//                                              end;
//      BOR_EmployeePay_Err_NoAccountNumber  : begin
//                                                grdBanking.SetActiveField('AccountNo');
//                                              end;
//      BOR_EmployeePay_Err_NoBankAmount     : begin
//                                                grdBanking.SetActiveField('Amount');
//                                              end;
//      BOR_EmployeePay_Err_NoSplit          : begin
//                                               grdBanking.SetActiveField('Split');
//                                             end;
//      BOR_EmployeePay_Err_RemainderWithOneRec : begin
//                                                  grdBanking.SetActiveField('Type');
//                                                end;
//    end;
//end;

procedure TEmpPaySetUpBanking.wwAmountCheckValue(Sender: TObject;
  PassesPictureTest: Boolean);
begin
  inherited;
  If (wwAmount.Text = '') OR not PassesPictureTest then begin
    wwAmount.Text := '0';
  end;

end;

procedure TEmpPaySetUpBanking.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
var
  ErrorCode: integer;
begin
  inherited ;
  if Value = BusobjEventVal_FailedBankingValidateData then begin
//    HandleEmployeePaySplitsErrors;
    ErrorCode := StrToIntDef(EventType,0);
    case ErrorCode of
      BOR_PaySplits_Err_NoBranch :begin
                                  grdBanking.SetActiveField('branch');
                                end;
      BOR_EmployeePay_Err_NoAccountName    : begin
                                               grdBanking.SetActiveField('AccountName');
                                             end;
      BOR_EmployeePay_Err_NoBank           : begin
                                                grdBanking.SetActiveField('Bank');
                                             end;
      BOR_EmployeePay_Err_NoBSBNumber      : begin
                                                grdBanking.SetActiveField('BSB');
                                              end;
      BOR_EmployeePay_Err_NoAccountNumber  : begin
                                                grdBanking.SetActiveField('AccountNo');
                                              end;
      BOR_EmployeePay_Err_NoBankAmount     : begin
                                                grdBanking.SetActiveField('Amount');
                                              end;
      BOR_EmployeePay_Err_NoSplit          : begin
                                               grdBanking.SetActiveField('Split');
                                             end;
      BOR_EmployeePay_Err_RemainderWithOneRec : begin
                                                  grdBanking.SetActiveField('Type');
                                                end;
    end;
  end;
end;

initialization
RegisterClassOnce(TEmpPaySetUpBanking);
end.
