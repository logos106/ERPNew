unit EmployeeTaxationFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,BusObjEmployeePay, StdCtrls, ExtCtrls, DNMPanel,
  wwclearbuttongroup, wwradiogroup, wwcheckbox, wwdblook, Mask, DBCtrls,
  DB, MemDS, DBAccess, MyAccess,ERPdbComponents, wwdbedit, frmBase, BusObjBase,
  Menus;

type
  TEmployeeTaxGUI = class(TfrmBaseGUI)
    DSEmployees: TDataSource;
    qryTaxScales: TERPQuery;
    qrySuppliers: TERPQuery;
    dsEmpPaySettings: TDataSource;
    qryTaxScale: TERPQuery;
    DNMPanel1: TDNMPanel;
    DNMPanel3: TDNMPanel;
    Label7: TLabel;
    Label99: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label65: TLabel;
    edTFN: TDBEdit;
    TaxScale: TwwDBLookupCombo;
    Workcover: TwwDBLookupCombo;
    chkHECS: TwwCheckBox;
    chkSFSS: TwwCheckBox;
    ABN: TDBEdit;
    DNMPanel5: TDNMPanel;
    Label1: TLabel;
    Label20: TLabel;
    ExtraTaxOptions: TwwRadioGroup;
    ExtraTax: TDBEdit;
    cboHECSTaxScales: TwwDBLookupCombo;
    cboStudentLoanTaxScales: TwwDBLookupCombo;
    qryHECSTaxScales: TERPQuery;
    qryStudentLoanTaxScales: TERPQuery;
    procedure SetSubEmpPay(Const Value :Temployeepay );
    procedure chkHECSClick(Sender: TObject);
    procedure chkSFSSClick(Sender: TObject);
    procedure qryTaxScaleBeforeOpen(DataSet: TDataSet);
  private
    fSubEmpPay:Temployeepay;
//    procedure HandleEmployeeTaxErrors;
  public
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
  end;

implementation
uses
  BusObjConst,CommonLib, AppEnvironment;
{$R *.dfm}

procedure TEmployeeTaxGUI.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
end;


procedure TEmployeeTaxGUI.chkHECSClick(Sender: TObject);
begin
//  if not SubEmpPay.EmployeeDetails.Hecsindicator then SubEmpPay.EmployeeDetails.HecsTaxScale := 0;
  if not chkHECS.Checked then SubEmpPay.EmployeeDetails.HecsTaxScale := 0;
end;

procedure TEmployeeTaxGUI.chkSFSSClick(Sender: TObject);
begin
  if not chkSFSS.Checked then SubEmpPay.EmployeeDetails.StudentloanTaxScale := 0;
end;

//procedure TEmployeeTaxGUI.HandleEmployeeTaxErrors;
//var
//  FatalStatusItem: TResultStatusItem;
//begin
//  if not Assigned(SubEmpPay) then exit;
//  FatalStatusItem := SubEmpPay.EmployeeDetails.ResultStatus.GetLastFatalStatusItem;
//  if Assigned(FatalStatusItem) then begin
//    case FatalStatusItem.Code of
//      BOR_Employee_Err_HECSTaxScale : begin
//                                        SubEmpPay.EmployeeDetails.HecsTaxScale := 0;
//                                        cboHECSTaxScales.RefreshDisplay;
//                                        SetControlFocus(chkHECS);
//                                        exit;
//                                      end;
//      BOR_Employee_Err_NoHECSTaxScale : begin
//                                        SetControlFocus(cboHECSTaxScales);
//                                        exit;
//                                      end;
//      BOR_Employee_Err_StudentLoanTaxScale : begin
//                                              SubEmpPay.EmployeeDetails.StudentloanTaxScale := 0;
//                                              cboStudentLoanTaxScales.RefreshDisplay;
//                                              SetControlFocus(chkSFSS);
//                                              exit;
//                                            end;
//      BOR_Employee_Err_NoStudentLoanTaxScale : begin
//                                                SetControlFocus(cboStudentLoanTaxScales);
//                                                exit;
//                                              end;
//
//
//   end;
//  end;
//end;


procedure TEmployeeTaxGUI.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
var
  ErrorCode: integer;
begin
  inherited ;
  if Value = BusobjEventVal_FailedTaxationValidateData then begin
//    HandleEmployeeTaxErrors;
    ErrorCode := StrToIntDef(EventType,0);
    case ErrorCode of
      BOR_Employee_Err_HECSTaxScale : begin
                                        SubEmpPay.EmployeeDetails.HecsTaxScale := 0;
                                        cboHECSTaxScales.RefreshDisplay;
                                        SetControlFocus(chkHECS);
                                        exit;
                                      end;
      BOR_Employee_Err_NoHECSTaxScale : begin
                                        SetControlFocus(cboHECSTaxScales);
                                        exit;
                                      end;
      BOR_Employee_Err_StudentLoanTaxScale : begin
                                              SubEmpPay.EmployeeDetails.StudentloanTaxScale := 0;
                                              cboStudentLoanTaxScales.RefreshDisplay;
                                              SetControlFocus(chkSFSS);
                                              exit;
                                            end;
      BOR_Employee_Err_NoStudentLoanTaxScale : begin
                                                SetControlFocus(edTFN);
                                                exit;
                                              end;
      BOR_Employee_Err_NoTaxScale: begin
                                    SetControlFocus(cboStudentLoanTaxScales);
                                    exit;
                                   end;


   end;
  end;
end;

procedure TEmployeeTaxGUI.qryTaxScaleBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryTaxScale.parambyname('RegionID').asInteger := AppEnv.RegionalOptions.ID;
end;

initialization
  RegisterClassOnce(TEmployeeTaxGUI);
end.
