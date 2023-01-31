unit EmployeePaySetupDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DNMPanel, DB, MemDS, DBAccess, MyAccess,ERPdbComponents,
  BusObjEmployeePay,wwclearbuttongroup, wwradiogroup, wwdblook,
  wwcheckbox, wwdbdatetimepicker, Mask, wwdbedit, Wwdotdot, Wwdbcomb,
  DBCtrls,BusObjBase, frmBase, Menus, DNMSpeedButton;

type
  TEmpPaySetupDetails = class(TfrmBaseGUI)
    DNMPanel1: TDNMPanel;
    dsEmpPaySettings: TDataSource;
    DNMPanel3: TDNMPanel;
    Label3: TLabel;
    Label16: TLabel;
    PayPeriod: TwwDBComboBox;
    dtFirstPayDate: TwwDBDateTimePicker;
    DNMPanel4: TDNMPanel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    chkIsOnRoster: TwwCheckBox;
    chkLoadHoursFromRoster: TwwCheckBox;
    chkLoadLeaveFromRoster: TwwCheckBox;
    DNMPanel2: TDNMPanel;
    DNMPanel7: TDNMPanel;
    Label2: TLabel;
    rgPaySlipSendVia: TwwRadioGroup;
    Label19: TLabel;
    wwDBEdit1: TwwDBEdit;
    DSEmployees: TDataSource;
    DNMPanel5: TDNMPanel;
    qryAward: TERPQuery;
    qryAwardClfn: TERPQuery;
    qryAwardClfnClassification: TWideStringField;
    qryAwardClfnClassificationID: TAutoIncField;
    qryDepartment: TERPQuery;
    StringField1: TWideStringField;
    StringField2: TWideStringField;
    AutoIncField1: TAutoIncField;
    ReportsTo: TwwDBLookupCombo;
    Department: TwwDBLookupCombo;
    Classification: TwwDBLookupCombo;
    cboAward: TwwDBLookupCombo;
    Label38: TLabel;
    Label37: TLabel;
    Label32: TLabel;
    Label36: TLabel;
    Bevel2: TBevel;
    Label21: TLabel;
    chkUseClassificationAdvance: TwwCheckBox;
    qryEmpNames: TERPQuery;
    qryEmpNamesEmployeeName: TWideStringField;
    qryEmpNamesEmployeeID: TAutoIncField;
    qryEmpNamesLastPaid: TDateField;
    DNMPanel8: TDNMPanel;
    edMealThreshold: TwwDBEdit;
    edMealBreak: TwwDBEdit;
    Label15: TLabel;
    Label8: TLabel;
    rgBasisOfEmployment: TwwRadioGroup;
    Label1: TLabel;
    wwDBEdit2: TwwDBEdit;
    pnlSTPJobKeepersDetails: TDNMPanel;
    Label5: TLabel;
    Label9: TLabel;
    cboSTPJobkeeperStartFN: TwwDBLookupCombo;
    qrySTPJobkeeperstartFNList: TERPQuery;
    cboSTPTier: TwwDBComboBox;
    Label10: TLabel;
    Label11: TLabel;
    cboSTPJobkeeperFinishFN: TwwDBLookupCombo;
    qrySTPJobkeeperFinishFNList: TERPQuery;
    MyConnection: TERPConnection;
    DNMSpeedButton1: TDNMSpeedButton;
    DNMSpeedButton2: TDNMSpeedButton;
    DNMSpeedButton3: TDNMSpeedButton;
    qrySTPJobkeeperstartFNListID: TIntegerField;
    qrySTPJobkeeperstartFNListFN: TWideStringField;
    qrySTPJobkeeperstartFNListDateFrom: TDateField;
    qrySTPJobkeeperstartFNListDateto: TDateField;
    qrySTPJobkeeperstartFNListOtherAllowanceStartDescription: TWideStringField;
    qrySTPJobkeeperstartFNListOtherAllowanceFinishDescription: TWideStringField;
    qrySTPJobkeeperstartFNListmstimestamp: TDateTimeField;
    qrySTPJobkeeperstartFNListmsUpdateSitecode: TWideStringField;
    qrySTPJobkeeperFinishFNListID: TIntegerField;
    qrySTPJobkeeperFinishFNListFN: TWideStringField;
    qrySTPJobkeeperFinishFNListDateFrom: TDateField;
    qrySTPJobkeeperFinishFNListDateto: TDateField;
    qrySTPJobkeeperFinishFNListOtherAllowanceStartDescription: TWideStringField;
    qrySTPJobkeeperFinishFNListOtherAllowanceFinishDescription: TWideStringField;
    qrySTPJobkeeperFinishFNListmstimestamp: TDateTimeField;
    qrySTPJobkeeperFinishFNListmsUpdateSitecode: TWideStringField;
    procedure cboAwardCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure DepartmentCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure SetSubEmpPay(Const Value :Temployeepay );
    procedure dtFirstPayDateCloseUp(Sender: TObject);
    procedure ClassificationCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure DNMSpeedButton2Click(Sender: TObject);
    procedure DNMSpeedButton3Click(Sender: TObject);
  private
    fSubEmpPay:Temployeepay;
//    procedure HandleEmployeePayErrors;
    procedure HandleReemployee;
  public
    property SubEmpPay:Temployeepay  read fSubEmpPay write SetSubEmpPay ;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  end;

implementation

{$R *.dfm}
uses
  AppEnvironment,BusObjConst,CommonLib,BusObjAwards,
  tcDataUtils,tcTypes,PayCommon,BusObjSuperannuation, ShellAPI, tcConst,
  BusObjEmployeePaySettings;

procedure TEmpPaySetupDetails.SetSubEmpPay(Const Value :Temployeepay);
begin
  fSubEmpPay := Value;
end;

procedure TEmpPaySetupDetails.HandleReemployee;
begin  
  SubEmpPay.EmployeePaySettings.FirstPayDate := StrToDateTime('30/12/1899');
  CommonLib.MessageDlgXP_Vista('Please select the first pay date for this re-employment?', mtInformation, [mbOK], 0);
  SetControlFocus(dtFirstPayDate);
end;

//procedure TEmpPaySetupDetails.HandleEmployeePayErrors;
//var
//  FatalStatusItem: TResultStatusItem;
//begin
//  if not Assigned(SubEmpPay) then exit;
//  FatalStatusItem := SubEmpPay.EmployeePaySettings.ResultStatus.GetLastFatalStatusItem;
//  if Assigned(FatalStatusItem) then begin
//    case FatalStatusItem.Code of
//      BOR_EmployeePay_Err_NoPayPeriod    :  begin
//                                              SetControlFocus(PayPeriod);
//                                              exit;
//                                            end;
//      BOR_Employee_Err_NoBasisOfPayment  :  begin
//                                              SetControlFocus(rgBasisOfEmployment);
//                                              exit;
//                                           end;
//      BOR_EmployeePay_Err_EmpNoFirstPayDate : begin
//                                                SetControlFocus(dtFirstPayDate);
//                                                exit;
//                                              end;
//    end;
//  end;
//end;

procedure TEmpPaySetupDetails.cboAwardCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);

begin
  if not modified then Exit;
  inherited;

  qryAwardClfn.Close;
  qryAwardClfn.Params.ParamByName('AwardID').AsInteger := LookupTable.FieldByName('AwardID').AsInteger;
  qryAwardClfn.Open;

  if cboAward.Text = '' then
    { user cleared combo }
    exit;

  if CommonLib.MessageDlgXP_Vista('This will reset all pay details for this employee to the ' + #13 + #10 +
    'specified award including Hours. Continue?' , mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

  SubEmpPay.Award.Load(LookupTable.FieldByName('AwardID').AsInteger);
  SubEmpPay.EmployeeDetails.Classification := SubEmpPay.Award.AwardClassifications.Classification;
  SubEmpPay.EmployeeDetails.Payperiod:= SubEmpPay.EmployeePaySettings.Payperiod;
  SubEmpPay.UpdateEmployeeWithAward;

  Department.Text := SubEmpPay.EmployeeDetails.Defaultclassname;
end;

procedure TEmpPaySetupDetails.DepartmentCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  if CommonLib.MessageDlgXP_Vista('This will reset departments relating to pay for this employee. Continue?' , mtConfirmation, [mbYes, mbNo], 0) = mrNo then exit;

  try
    SubEmpPay.EmployeeDetails.Defaultclassname := Department.Text;

    with SubEmpPay.EmployeePayRates do begin
      DataSet.First;
      while not DataSet.Eof do begin
        Classid  := GetDeptID(Department.Text);
        DepartmentName := Department.Text;
        DataSet.Next;
      end;
    end;
    with SubEmpPay.EmployeeDeductions do begin
      DataSet.First;
      while not DataSet.Eof do begin
        Classid  := GetDeptID(Department.Text);
        DepartmentName := Department.Text;
        DataSet.Next;
      end;
    end;
    with SubEmpPay.EmployeeAllowances do begin
      DataSet.First;
      while not DataSet.Eof do begin
        Classid  := GetDeptID(Department.Text);
        DepartmentName := Department.Text;
        DataSet.Next;
      end;
    end;
    with SubEmpPay.EmployeeLeaves do begin
      DataSet.First;
      while not DataSet.Eof do begin
        Classid  := GetDeptID(Department.Text);
        DepartmentName := Department.Text;
        DataSet.Next;
      end;
    end;

    with fSubEmpPay.FringeBenefits do begin
      Dataset.First;
      while not Dataset.EOF do begin
        Classid  := GetDeptID(Department.Text);
        DepartmentName := Department.Text;
        Dataset.Next;
      end;
    end;

    with fSubEmpPay.WorkersCompensation do begin
      Dataset.First;
      while not Dataset.EOF do begin
        Classid  := GetDeptID(Department.Text);
        DepartmentName := Department.Text;
        Dataset.Next;
      end;
    end;

    with Tsuperannuation(SubEmpPay.Superannuation) do begin
      Dataset.First;
      while not Dataset.Eof do begin
        Classid  := GetDeptID(Department.Text);
        DepartmentName := Department.Text;
        Dataset.Next;
      end;
    end;
  except
    
  end;

end;

procedure TEmpPaySetupDetails.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  ShellExecute(0, 'open', 'https://www.ato.gov.au/General/JobKeeper-Payment/In-detail/Reporting-eligible-employees-and-JobKeeper-top-up-payments-via-STP/#BK_4Stoppingemployeesnolongereligiblefor', nil, nil, sw_shownormal);
end;

procedure TEmpPaySetupDetails.DNMSpeedButton2Click(Sender: TObject);
begin
  inherited;
  if trim(cboSTPJobkeeperStartFN.hint) <> '' then
    MessageDlgXP_Vista(trim(cboSTPJobkeeperStartFN.hint), mtInformation, [mbOK], 0);
end;

procedure TEmpPaySetupDetails.DNMSpeedButton3Click(Sender: TObject);
begin
  inherited;
  if trim(cboSTPJobkeeperFinishFN.hint) <> '' then
    MessageDlgXP_Vista(trim(cboSTPJobkeeperFinishFN.hint), mtInformation, [mbOK], 0);
end;

procedure TEmpPaySetupDetails.dtFirstPayDateCloseUp(Sender: TObject);
begin
  if dtFirstPayDate.Date < GetLastTerminationEndDate(SubEmpPay.EmployeeDetails.Id) then begin
    CommonLib.MessageDlgXP_Vista('The Selected first pay date is inside a previous employment period?', mtWarning, [mbOK], 0);
    HandleReemployee;
  end;
end;

procedure TEmpPaySetupDetails.FormCreate(Sender: TObject);
begin
  inherited;
  Showcontrolhint(cboSTPJobkeeperFinishFN, 'The First Full Fortnight The Employee Became Ineligible for JobKeeper payments' +NL+NL+
                    'For example, if The Employee''s Last JobKeeper Payment was on 13 May 2020 (pay date 13 May 2020),'+NL+
                    'the Last Payment was Made in FN04 (because the payment was made during '+ TSTPJobKeeperFNList.FinishDateDescForFn(Self, '04')+'), '+NL+NL+
                    'Meaning The Employee is No Longer Eligible for JobKeeper from FN05.');

  Showcontrolhint(cboSTPJobkeeperStartFN, 'This is When an Eligible Employee Started Being Paid JobKeeper payments.' +NL+NL+
                    'For example, if the Employee''s First JobKeeper payment was on 2 April 2020 (pay date 2 April 2020),'+NL+
                    'The First payment was made in FN01 (because the payment was made during '+ TSTPJobKeeperFNList.StartDateDescForFn(Self, '01')+')');

  pnlSTPJobKeepersDetails.Visible := (  AppEnv.RegionalOptions.RegionType = rAUST);
end;

procedure TEmpPaySetupDetails.ClassificationCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not modified then Exit;
  SubEmpPay.EmployeeDetails.Classification := Classification.Text;
  SubEmpPay.UpdateEmployeeWithAward;
end;

procedure TEmpPaySetupDetails.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
var
  ErrorCode: integer;
begin
  inherited ;
  if Value = BusobjEventVal_FailedPay_DetailsValidateData then begin
//    HandleEmployeePayErrors;
    ErrorCode := StrToIntDef(EventType,0);
    case ErrorCode of
      BOR_EmployeePay_Err_NoPayPeriod    :  begin
                                              SetControlFocus(PayPeriod);
                                              exit;
                                            end;
      BOR_Employee_Err_NoBasisOfPayment  :  begin
                                              SetControlFocus(rgBasisOfEmployment);
                                              exit;
                                           end;
      BOR_EmployeePay_Err_EmpNoFirstPayDate : begin
                                                SetControlFocus(dtFirstPayDate);
                                                exit;
                                              end;
    end;
  end;
  if Eventtype = BusobjEventVal_HandleEmployeeReEmploy then begin
    HandleReemployee;
  end;  
end;

initialization
RegisterClassOnce(TEmpPaySetupDetails);

end.

