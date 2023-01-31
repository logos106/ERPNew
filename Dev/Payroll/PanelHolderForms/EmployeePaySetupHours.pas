unit EmployeePaySetupHours;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, ExtCtrls, DNMPanel, StdCtrls,
  Mask, wwdbedit, wwdblook, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  BusObjEmployeePay, BusObjBase, frmBase,BaseInputForm, ProgressDialog, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts;

type
  TEmpPaySetUpHours = Class(TBaseInputGUI)
    DNMPanel1: TDNMPanel;
    grdPayRate: TwwDBGrid;
    grdPayRateIButton: TwwIButton;
    cboPayRate: TwwDBLookupCombo;
    cboRateType: TwwDBLookupCombo;
    edQtyPayRates: TwwDBEdit;
    edHourlyRate: TwwDBEdit;
    PayAmount: TwwDBEdit;
    cboRateJob: TwwDBLookupCombo;
    cboRateDept: TwwDBLookupCombo;
    qryPayRates: TERPQuery;
    qryPayRatesDescription: TWideStringField;
    qryPayRatesRateID: TAutoIncField;
    qryPayRateType: TERPQuery;
    qryJobs: TERPQuery;
    DSEmployeepayrates: TDataSource;
    qryCustomers: TERPQuery;
    qryDepartment: TERPQuery;
    StringField1: TWideStringField;
    StringField2: TWideStringField;
    AutoIncField1: TAutoIncField;
    procedure grdPayRateIButtonClick(Sender: TObject);
    procedure SetSubEmpPay(Const Value :Temployeepay );
    procedure FormCreate(Sender: TObject);
  private
    fSubEmpPay:Temployeepay;
//    procedure HandleEmployeePayHoursErrors;
  public
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;

  end;



implementation

{$R *.dfm}
uses
  BusObjConst,CommonLib;

procedure TEmpPaySetUpHours.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
end;

//procedure TEmpPaySetUpHours.HandleEmployeePayHoursErrors;
//var
//  FatalStatusItem: TResultStatusItem;
//begin
//  if not Assigned(SubEmpPay) then exit;
//  FatalStatusItem := SubEmpPay.EmployeePayRates.ResultStatus.GetLastFatalStatusItem;
//  if Assigned(FatalStatusItem) then begin
//    case FatalStatusItem.Code of
//      BOR_EmployeePay_Err_NoDepartment       : begin
//                                               grdPayrate.SetActiveField('ClassName');
//                                             end;
//      BOR_EmployeePay_Err_HrsRateZeroValue : begin
//                                                grdPayrate.SetActiveField('HourlyRate');
//                                             end;
//      BOR_EmployeePay_Err_QtyZeroValue     : begin
//                                               grdPayrate.SetActiveField('Qty');
//                                             end;
//      BOR_EmployeePay_Err_NoType           : begin
//                                               grdPayrate.SetActiveField('RateType');
//                                             end;
//      BOR_EmployeePay_Err_NoRate           : begin
//                                               grdPayrate.SetActiveField('PayRate');
//                                             end;
//    end;
//  end;
//end;


procedure TEmpPaySetUpHours.FormCreate(Sender: TObject);
begin
  AllowCustomiseGrid := true;
  AllowGridSorting := True;
  inherited;
end;

procedure TEmpPaySetUpHours.grdPayRateIButtonClick(Sender: TObject);
begin
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      if not Assigned(SubEmpPay) then exit;
      SubEmpPay.EmployeePayRates.Delete;
      SubEmpPay.EmployeePayRates.Dirty := True;
    finally
    end;
  end;
end;

procedure TEmpPaySetUpHours.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
var
  ErrorCode: integer;
begin
  inherited ;
  if Value = BusobjEventVal_FailedHoursValidateData then begin
    ErrorCode := StrToIntDef(EventType,0);
    case ErrorCode of
      BOR_EmployeePay_Err_NoDepartment       : begin
                                               grdPayrate.SetActiveField('ClassName');
                                             end;
      BOR_EmployeePay_Err_HrsRateZeroValue : begin
                                                grdPayrate.SetActiveField('HourlyRate');
                                             end;
      BOR_EmployeePay_Err_QtyZeroValue     : begin
                                               grdPayrate.SetActiveField('Qty');
                                             end;
      BOR_EmployeePay_Err_NoType           : begin
                                               grdPayrate.SetActiveField('RateType');
                                             end;
      BOR_EmployeePay_Err_NoRate           : begin
                                               grdPayrate.SetActiveField('PayRate');
                                             end;
    end;
  end;
end;

initialization
RegisterClassOnce(TEmpPaySetUpHours);
end.
