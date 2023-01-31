unit frmEmployeePayBASE;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, Menus, AdvMenus, DataState, DB, DBAccess, MyAccess,
  SelectionDialog, AppEvnts, ExtCtrls,StdCtrls, MemDS, Grids,
  Wwdbigrd, Wwdbgrid,  DNMSpeedButton, wwcheckbox, Mask, wwdbedit,
  wwdblook, BaseGrid, BusObjPayUtils,
  ComCtrls, DNMPanel, AdvPanel, DBCtrls, wwdbdatetimepicker, AdvPicture,BusObjPaybase,
  Buttons, Shader, Wwdotdot, Wwdbcomb;

type
  TfmEmployeePayBASE = class(TBaseInputGUI)
    qryPaysPayRates: TMyQuery;
    DSPaysPayRates: TDataSource;
    qryPaysPayRatesGlobalRef: TStringField;
    qryPaysPayRatesPaysPayRateID: TIntegerField;
    qryPaysPayRatesPayID: TIntegerField;
    qryPaysPayRatesPayRateID: TIntegerField;
    qryPaysPayRatesTypeID: TIntegerField;
    qryPaysPayRatesQty: TFloatField;
    qryPaysPayRatesAmount: TFloatField;
    qryPaysPayRatesLineTotal: TFloatField;
    qryPaysPayRatesSuperInc: TStringField;
    qryPaysPayRatesClientID: TIntegerField;
    qryPaysPayRatesClassID: TIntegerField;
    qryPaysPayRatesEditedFlag: TStringField;
    qryPaysPayRatesClassName: TStringField;
    qryPaysPayRatesTimeSheetId: TIntegerField;
    DSPayRate: TDataSource;
    qryJobs: TMyQuery;
    qryPayRateType: TMyQuery;
    qryPayRates: TMyQuery;
    qryDepartment: TMyQuery;
    qryPaysPayRatesPayType: TStringField;
    qryPaysPayRatesPayRate: TStringField;
    qryPaysPayRatesPayJob: TStringField;
    qryPays: TMyQuery;
    DSPays: TDataSource;
    qryPaysGlobalRef: TStringField;
    qryPaysPayID: TIntegerField;
    qryPaysEmployeeID: TIntegerField;
    qryPaysPayDate: TDateField;
    qryPaysDatePaid: TDateField;
    qryPaysPayPeriods: TWordField;
    qryPaysWages: TFloatField;
    qryPaysCommission: TFloatField;
    qryPaysDeductions: TFloatField;
    qryPaysAllowances: TFloatField;
    qryPaysAllowancesBeforeTax: TFloatField;
    qryPaysSundries: TFloatField;
    qryPaysSuperannuation: TFloatField;
    qryPaysGross: TFloatField;
    qryPaysGrossTaxable: TFloatField;
    qryPaysTax: TFloatField;
    qryPaysNet: TFloatField;
    qryPaysPay: TStringField;
    qryPaysPaid: TStringField;
    qryPaysEditedFlag: TStringField;
    qryPaysPrinted: TStringField;
    qryPaysEmpName: TStringField;
    qryPaysLeaveLoading: TFloatField;
    qryPaysClassID: TIntegerField;
    qryPaysClass: TStringField;
    qryPaysIsTimesheet: TStringField;
    qryPaysPayPeriod: TStringField;
    qryPaysAnnualLeaveRate: TFloatField;
    qryPaysCDEPGross: TFloatField;
    qryPaysLumpA: TFloatField;
    qryPaysLumpB: TFloatField;
    qryPaysLumpD: TFloatField;
    qryPaysLumpE: TFloatField;
    qryPaysETP: TFloatField;
    qryPaysManualTax: TStringField;
    qryPaysDeleted: TStringField;
    qryPaysIsNewTypePay: TStringField;
    qryPaysPaySuperOnLeaveLoading: TStringField;
    qryPaysPayVersion: TIntegerField;
    qryPaysPayNotes: TMemoField;
    qryPaysPayXMLData: TMemoField;
    qryPaysPrepared: TStringField;
    qryPaysPayRatesNICsInc: TStringField;
    qryLeavePayTypes: TMyQuery;
    qryLeaveTypes: TMyQuery;
    qryPaysLeave: TMyQuery;
    qryPaysLeaveDateTaken: TDateField;
    qryPaysLeaveQty: TFloatField;
    qryPaysLeaveLeavePayType: TStringField;
    qryPaysLeaveAmount: TFloatField;
    qryPaysLeavelookupJob: TStringField;
    qryPaysLeaveGlobalRef: TStringField;
    qryPaysLeavePayLeaveID: TAutoIncField;
    qryPaysLeavePayID: TIntegerField;
    qryPaysLeaveClientID: TIntegerField;
    qryPaysLeaveClassID: TIntegerField;
    qryPaysLeaveEditedFlag: TStringField;
    qryPaysLeaveClassName: TStringField;
    qryPaysLeaveSuperInc: TStringField;
    qryPaysLeaveIsCertified: TStringField;
    dsPaysLeave: TDataSource;
    DNMPanel2: TDNMPanel;
    Label37: TLabel;
    Label38: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    PayDate: TwwDBDateTimePicker;
    DatePaid: TwwDBDateTimePicker;
    PayPeriods: TDBEdit;
    chkManualTax: TwwCheckBox;
    edtName: TwwDBEdit;
    DNMPanel1: TDNMPanel;
    PageControl1: TPageControl;
    tabHours: TTabSheet;
    grdHours: TwwDBGrid;
    PayRate: TwwDBLookupCombo;
    PayType: TwwDBLookupCombo;
    edtQty: TwwDBEdit;
    PayJob: TwwDBLookupCombo;
    PayDepartment: TwwDBLookupCombo;
    tabLeaves: TTabSheet;
    grdLeave: TwwDBGrid;
    btnLeaveDelete: TwwIButton;
    btnHrsDelete: TwwIButton;
    cboLeaveType: TwwDBLookupCombo;
    cboLeaveDept: TwwDBLookupCombo;
    chkCertified: TwwCheckBox;
    DNMPanel4: TDNMPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label5: TLabel;
    lblSuper: TLabel;
    Label9: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Wages: TDBEdit;
    CommissionPay: TDBEdit;
    DeductionsPay: TDBEdit;
    AllowancesPay: TDBEdit;
    SundriesPay: TDBEdit;
    SuperPay: TDBEdit;
    GrossPay: TDBEdit;
    TaxPay: TDBEdit;
    NetPay: TDBEdit;
    DNMSpeedButton1: TDNMSpeedButton;
    btnProcessPay: TDNMSpeedButton;
    qryEmployeePaySettings: TMyQuery;
    lblTaxCode: TLabel;
    edTaxcodeUsed: TDBEdit;
    qryPaysUKTaxCodeUsed: TStringField;
    Label4: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    AdvPicture1: TAdvPicture;
    TabBenifits: TTabSheet;
    qryPaysBenefits: TMyQuery;
    DBpaysbenefits: TDataSource;
    qryPaysIsContractedOut: TStringField;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label14: TLabel;
    Label11: TLabel;
    ChkPrepared: TwwCheckBox;
    chkDeleted: TwwCheckBox;
    Bevel1: TBevel;
    Label10: TLabel;
    edPayID: TDBEdit;
    tabDeductions: TTabSheet;
    grdDeductions: TwwDBGrid;
    btnDeductionDelete: TwwIButton;
    Deduction: TwwDBLookupCombo;
    Amount: TwwDBEdit;
    cboDeductCalcBy: TwwDBComboBox;
    DeductBasedOn: TwwDBLookupCombo;
    chkTaxExemptDeduction: TwwCheckBox;
    chkUnionFeesDeduction: TwwCheckBox;
    cboDeductDept: TwwDBLookupCombo;
    qryPaydeductions: TMyQuery;
    qryPaydeductionsPayDeductionID: TAutoIncField;
    qryPaydeductionsPayID: TIntegerField;
    qryPaydeductionsDeductionID: TIntegerField;
    qryPaydeductionsNotes: TStringField;
    qryPaydeductionsQty: TFloatField;
    qryPaydeductionsAmount: TFloatField;
    qryPaydeductionsCalcBy: TStringField;
    qryPaydeductionsUnionFees: TStringField;
    qryPaydeductionsTaxExempt: TStringField;
    qryPaydeductionsDeduction: TStringField;
    qryPaydeductionsClassID: TIntegerField;
    qryPaydeductionsClassName: TStringField;
    qryPaydeductionsBasedOnID: TIntegerField;
    qryPaydeductionsBasedOn: TStringField;
    qryPaydeductionsMoneyAmount: TFloatField;
    DSPayDeductions: TDataSource;
    qryDeductions: TMyQuery;
    qryBasedOn: TMyQuery;
    qryBasedOnBasedOn: TStringField;
    qryBasedOnBasedOnID: TAutoIncField;
    qryPaysUKNICsClass1: TFloatField;
    qryPaysUKNICsOther: TFloatField;
    qryPaysUKEmployerNICsClass1: TFloatField;
    qryPaysUKEmployerNICsOther: TFloatField;
    pnlemployee: TDNMPanel;
    lblNICsOther: TLabel;
    edNICs: TDBEdit;
    edNICsOther: TDBEdit;
    Label12: TLabel;
    Label16: TLabel;
    Timer1: TTimer;
    Timer2: TTimer;
    btnEmployerNICs: TDNMSpeedButton;
    pnlemployer: TDNMPanel;
    Label13: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    edEmployerNICsClass1: TDBEdit;
    edEmployerNICsOther: TDBEdit;
    qryPaysBenefitsPayID: TIntegerField;
    qryPaysBenefitsDescription: TStringField;
    qryPaysBenefitsIsNICsPayable: TStringField;
    qryPaysBenefitsNICsClass: TStringField;
    qryPaysBenefitsAmount: TFloatField;
    qryPaysBenefitsEmployeeNICAmount: TFloatField;
    qryPaysBenefitsEmployerNICAmount: TFloatField;
    qryPaysBenefitsBenefitReceivedFrom: TStringField;
    qryPaysBenefitsBenefitOrExpense: TStringField;
    qryPaysLeaveLeaveType: TStringField;
    pnlNICs: TDNMPanel;
    grdBenefits: TwwDBGrid;
    btnDeleteBenefit: TwwIButton;
    cboNicClass: TwwDBComboBox;
    chkIsNicPayable: TwwCheckBox;
    cboBenefitOrExpense: TwwDBComboBox;
    pnlFringeBenefits: TDNMPanel;
    qryPaysRegion: TStringField;
    TabAllowances: TTabSheet;
    DSPayAllowances: TDataSource;
    qryPayAllowances: TMyQuery;
    qryPayAllowancesPayAllowanceID: TAutoIncField;
    qryPayAllowancesPayID: TIntegerField;
    qryPayAllowancesAllowanceID: TIntegerField;
    qryPayAllowancesQty: TFloatField;
    qryPayAllowancesAmount: TFloatField;
    qryPayAllowancesCalcBy: TStringField;
    qryPayAllowancesSuperInc: TStringField;
    qryPayAllowancesTaxExempt: TStringField;
    qryPayAllowancesClientID: TIntegerField;
    qryPayAllowancesClassID: TIntegerField;
    qryPayAllowancesAllowance: TStringField;
    qryPayAllowancesAllowanceJob: TStringField;
    qryPayAllowancesLineTotal: TFloatField;
    qryPayAllowancesClassName: TStringField;
    qryPayAllowancesBasedOn: TStringField;
    qryPayAllowancesBasedOnID: TIntegerField;
    qryPayAllowancesMoneyAmount: TFloatField;
    qryAllowances: TMyQuery;
    qryAllowancesDescription: TStringField;
    qryAllowancesAllowanceID: TAutoIncField;
    qryAllowancesSuperInc: TStringField;
    qryAllowancesTaxExempt: TStringField;
    qryAllowancesQty: TFloatField;
    qryAllowancesAmount: TFloatField;
    qryAllowancesBasedOnID: TIntegerField;
    qryAllowancesCalcBy: TStringField;
    grdAllowances: TwwDBGrid;
    btnAllowanceDelete: TwwIButton;
    cboAllowance: TwwDBLookupCombo;
    AllowQty: TwwDBEdit;
    AllowBasedOn: TwwDBLookupCombo;
    cboAllowCalcBy: TwwDBComboBox;
    chkAllowSuper: TwwCheckBox;
    chkAllowTaxExempt: TwwCheckBox;
    AllowJob: TwwDBLookupCombo;
    cboAllowDepart: TwwDBLookupCombo;
    AllowanceAmount: TwwDBEdit;
    procedure FormDestroy(Sender: TObject);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure grdLeaveExit(Sender: TObject);
    procedure PayDateCloseUp(Sender: TObject);
    procedure btnHrsDeleteClick(Sender: TObject);
    procedure btnLeaveDeleteClick(Sender: TObject);
    procedure grdHoursMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure grdHoursColEnter(Sender: TObject);
    procedure btnDeleteBenefitClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure chkDeletedClick(Sender: TObject);
    procedure chkManualTaxClick(Sender: TObject);
    procedure DeductionCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnDeductionDeleteClick(Sender: TObject);
    procedure grdBenefitsExit(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure btnEmployerNICsClick(Sender: TObject);
    procedure PayRateCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnProcessPayClick(Sender: TObject);
    procedure cboAllowanceCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure grdAllowancesExit(Sender: TObject);
    procedure grdAllowancesRowChanged(Sender: TObject);
  private
    PayUtils:TPayUtils;
    fPayID:integer;
    fOpenningForm: Boolean;
    fsToggleNICs:String;
    procedure EditLeaveFromLeaveGrid;
    procedure HandleAllowanceErrors;
  public
    property EmpPayID:integer read fPayID write fPayID;   

end;

var
  Pay:TPaybase;

implementation

{$R *.dfm}
uses
  BusObjBase, BusObjPaysPayRatesBASE,
  FormFactory,AppEnvironment,BusObjPaysLeave,PayCommon,
  tcTypes, CommonLib,BusObjConst; 


procedure TfmEmployeePayBASE.HandleAllowanceErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  FatalStatusItem := Pay.PayAllowances.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    case FatalStatusItem.Code of
      BOR_PayAllowance_Err_NoDescription  : begin
                                            //  PageControl1.ActivePage := tabAllowances;
                                              grdDeductions.SetActiveField('Allowance');
                                              SetControlFocus(cboAllowance);
                                            end;
      BOR_PayAllowance_Err_NoQty          : begin
                                            //  PageControl1.ActivePage := tabAllowances;
                                              grdDeductions.SetActiveField('Qty');
                                              SetControlFocus(AllowQty);
                                           end;
      BOR_PayAllowance_Err_NoBasedOnID    : begin
                                            //  PageControl1.ActivePage := tabAllowances;
                                              grdDeductions.SetActiveField('BasedOn');
                                              SetControlFocus(AllowBasedOn);
                                            end;
      BOR_PayAllowance_Err_NoAmount       : begin
                                            //  PageControl1.ActivePage := tabAllowances;
                                              grdDeductions.SetActiveField('Amount');
                                              SetControlFocus(AllowanceAmount);
                                            end;
      BOR_PayAllowance_Err_NoDepartment   : begin
                                            //  PageControl1.ActivePage := tabAllowances;
                                              grdDeductions.SetActiveField('ClassName');
                                              SetControlFocus(cboAllowance);
                                          end;
      BOR_PayAllowance_Err_NoCalcBy       : begin
                                            //  PageControl1.ActivePage := tabAllowances;
                                              grdDeductions.SetActiveField('CalcBy');
                                              SetControlFocus(cboAllowDepart);
                                          end;
    end;
  end;
end;

procedure TfmEmployeePayBASE.FormDestroy(Sender: TObject);
begin
  if Assigned(PayUtils) then FreeAndNil(PayUtils);
  if Assigned(Pay) then FreeAndNil(Pay);
  inherited;  
end;

procedure TfmEmployeePayBASE.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
 // //Pay.Recalc;
//  CommonLib.MessageDlgXP_Vista(
//      '------' + #13#10 +
//      'Employee Name: ' + Pay.Empname + #13#10 +
//      '------' + #13#10 +
//      'Wages' + #9#9#9 + '= ' + FloatToStrF(TPaysPayRates(Pay.PaysPayRates).Wages , ffCurrency, 15, 2) + #13#10 +
//      'Standard Hourly Rate = ' + FloatToStrF(TPaysPayRates(Pay.PaysPayRates).HourlyRate , ffCurrency, 15, 2) + #13#10 +
//      'Total Standard hrs ' + #9 + '= ' + FloatToStrF(TPaysPayRates(Pay.PaysPayRates).TotalStandardHours , ffGeneral, 15, 2) + #13#10 +
//      'Employee Standard hourly rate ' + #9 + '= ' + FloatToStrF(TEmployeePayRates(Pay.EmployeePayRates).HighestStandardHourlyRate , ffGeneral, 15, 2) + #13#10 +
//      '------' + #13#10
//
//
//
//
//
//
//      , mtInformation, [mbOK], 0);
end;

procedure TfmEmployeePayBASE.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Closequeries;
  Action := caFree;
end;

procedure TfmEmployeePayBASE.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  inherited;
    SetLength(QueryNamesNotToOpen, 4);
    QueryNamesNotToOpen[0] := 'qryPaysPayRates';
    QueryNamesNotToOpen[1] := 'qryPayRates';
    QueryNamesNotToOpen[2] := 'qryPayRateType';
    QueryNamesNotToOpen[3] := 'qryPayAllowances';
  //  QueryNamesNotToOpen[3] := 'qryJobs';
  //  QueryNamesNotToOpen[4] := 'qryDepartment';
 //   QueryNamesNotToOpen[5] := 'qryPays';
    OpenQueries(QueryNamesNotToOpen);


  Pay := Tpaybase.Create(Self,KeyID,Self.MyConnection);
 // Pay.Connection := TMyDacDataConnection.Create(Pay);
//  TMyDacDataConnection(Pay.Connection).MydacConnection  := MyConnection;
  Pay.PaysPayRates.Dataset := qryPaysPayRates;
  Pay.PaysLeave.Dataset := qryPaysLeave;
  Pay.Dataset := qryPays;
  Pay.PayDeductions.Dataset := qryPayDeductions;
  Pay.Benefits.Dataset := qryPaysBenefits;  // what about AUS
  Pay.PayAllowances.Dataset := qryPayAllowances;

  PayUtils := TPayUtils.Create(Self,MyConnection);
//  PayUtils.Connection :=  TMyDacDataConnection.Create(PayUtils);
//  TMyDacDataConnection(PayUtils.Connection).MydacConnection  := MyConnection;




    Pay.Load(KeyID);
    //EmployeePaySettings.Load(Pay.EmployeeID);
    OpenQueries;
    BeginTransaction;

    if Self.KeyID <> 0 then begin
      if Pay.Paid = True then begin
        grdHours.Enabled := false;
        grdLeave.Enabled := false;
    //    grdDeductions.Enabled := false;
     //   grdAllowances.Enabled := false;
     //   grdSundries.Enabled := false;
     //   grdCommission.Enabled := false;
        grdBenefits.Enabled := false;
        edtName.Enabled := false;
        PayDate.Enabled := false;
        DatePaid.Enabled := false;
        PayPeriods.Enabled := false;
        btnOk.Enabled := false;
        Label11.Enabled := true;
        chkDeleted.Enabled := true;
      end;
    end;



    if (Pay.Pay = True) and (Pay.Paid = False) then begin
      Label11.Visible := false;
      chkDeleted.Visible := false;
  //    PostMessage(Self.Handle, MSG_PayRecalc, 0, 0);
    end;

    If not chkDeleted.Visible then begin
      Label14.Visible := True;
      ChkPrepared.Visible := True;
    end;

    if Pay.Region = AppEnv.RegionalOptions.RegionTypeToRegionName(rAust) then begin
  //  if Pay.Region = 'AUS' then begin
//    if AppEnv.RegionalOptions.Region = rAust then begin
   //   AdvPicture1.Picture.LoadFromFile('C:\P1\australC_1xa.gif');
      SuperPay.Visible := True;
      lblSuper.Visible := True;

      PageControl1.Pages[TabBenifits.PageIndex].TabVisible := False;
      lblTaxCode.Visible := False;
      edTaxCodeUsed.Visible := False;
      pnlNICs.Visible := False;
      pnlFringeBenefits.Visible := True;
      pnlEmployee.Visible := False;
      pnlEmployer.Visible := False;
      btnEmployerNICs.Visible := False;
    //end else if AppEnv.RegionalOptions.Region = rUK then begin
    end else if Pay.Region = AppEnv.RegionalOptions.RegionTypeToRegionName(rUK) then begin
  //    AdvPicture1.Picture.LoadFromFile('C:\P1\greatbrE.gif');

      lblSuper.Visible := False;
      SuperPay.Visible := False;

      PageControl1.Pages[TabBenifits.PageIndex].TabVisible :=  True;
      lblTaxCode.Visible := True;
      edTaxCodeUsed.Visible := True;
      pnlNICs.Visible := True;
      pnlFringeBenefits.Visible := False;
      pnlEmployee.Visible := True;
      pnlEmployer.Visible := True;
      btnEmployerNICs.Visible := True;
    end;
    //else if AppEnv.RegionalOptions.Region = rNZ then AdvPicture1.Picture.LoadFromFile('C:\P1\new_zeaC3.gif')
    //else if AppEnv.RegionalOptions.Region = rRSA then AdvPicture1.Picture.LoadFromFile('C:\P1\south_aC.gif');

    fOpenningForm := False;
end;


procedure TfmEmployeePayBASE.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  //CanClose := False;
//  if  Pay.Dirty
//    or TPayspayrates(Pay.PaysPayRates).Dirty
//    or TPaysLeave(Pay.PaysLeave).Dirty
//
//    then begin
//    case CommonLib.MessageDlgXP_Vista('Save Changes?',mtWarning,[mbYes,mbNo,mbCancel],0)of
//      mrYes: begin
//      //if TPayspayrates(Pay.PaysPayRates).Save then begin  //USE THIS WHEN VALIDATION OK
//          Pay.PostDb;
//          Tpaysleave(Pay.PaysLeave).PostDb;
//          TPayspayrates(Pay.PaysPayRates).PostDB;
//          TPayUK(Pay).UKBenefits.PostDb;
//          CommitTransaction;
//          CanClose := True;
//        end;
//      mrNo: begin
//        RollbackTransaction;
//        CanClose := True;
//        end;
//      mrCancel:begin
//        CanClose := false;
//        btnClose.Enabled := True;
//      end;
//    end;
//  end else begin
//    CanClose := True;
//  end;
end;

procedure TfmEmployeePayBASE.FormCreate(Sender: TObject);
begin
   fsToggleNICs := 'Employee';
  //Lock Delete on Grids

    btnHrsDelete.Enabled    := (AccessLevel = 1);
    btnLeaveDelete.Enabled      := (AccessLevel = 1);
 //   btnDeductionDelete.Enabled  := (AccessLevel = 1);
//    btnAllowanceDelete.Enabled  := (AccessLevel = 1);
    btnDeleteBenefit.Enabled   := (AccessLevel = 1);
//    btnCommissionDelete.Enabled := (AccessLevel = 1);

  //Pay := Tpaybase.Create(Self,306);//   KeyID);
//  Pay.Connection := TMyDacDataConnection.Create(Pay);
//  TMyDacDataConnection(Pay.Connection).MydacConnection  := MyConnection;


  //if AppEnv.RegionalOptions.Region = rUK then begin
//    Pay := TPayUK.Create(Self);
//
//    Pay.Connection := TMyDacDataConnection.Create(Pay);
//    TMyDacDataConnection(Pay.Connection).MydacConnection  := MyConnection;
//
//    TPayUK(Pay).UKBenefits.Dataset := qryPaysBenefits;
//
//    Self.grdHours.ControlType.Add('NICsInc;CheckBox;T;F');
//    Self.grdHours.Selected.Add('NICsInc'#9'1'#9'NICs'#9'F');
//
//
//
//  end else if AppEnv.RegionalOptions.Region = rAust then begin
//    Pay := TPayAUS.Create(Self);
//    Pay.Connection := TMyDacDataConnection.Create(Pay);
//    TMyDacDataConnection(Pay.Connection).MydacConnection  := MyConnection;
//
//    Self.grdHours.ControlType.Add('Super;CheckBox;T;F');
//    Self.grdHours.Selected.Add('Super'#9'1'#9'Super'#9'F');
//
//  end;


  //Pay.PaysPayRates.Dataset := qryPaysPayRates;
//  Pay.PaysLeave.Dataset := qryPaysLeave;
//  Pay.Dataset := qryPays;
//  Pay.PaysDeductions.Dataset := qryPayDeductions;
//
//
//  PayUtils := TPayUtils.Create((Self));
//  PayUtils.Connection :=  TMyDacDataConnection.Create(PayUtils);
//  TMyDacDataConnection(PayUtils.Connection).MydacConnection  := MyConnection;

  //EmployeePaySettings := Temployeepaysettings.Create(Self) ;
//  EmployeePaySettings.Connection  := TMyDacDataConnection.Create(EmployeePaySettings);
//  TMyDacDataConnection(EmployeePaySettings.Connection).MydacConnection  := MyConnection;

  inherited;
end;

procedure TfmEmployeePayBASE.grdLeaveExit(Sender: TObject);
begin
  inherited;
  if Pay.PaysLeave.LeaveChanged then begin
    Pay.AddLeavesToPay;
    Pay.PaysLeave.LeaveChanged := False;
  end;

end;

procedure TfmEmployeePayBASE.PayDateCloseUp(Sender: TObject);
begin
  inherited;
//  Pay.PostDb;
end;

procedure TfmEmployeePayBASE.btnHrsDeleteClick(Sender: TObject);
begin
  inherited;
  if IsLeave(Pay.PaysPayRates.PayRateID) then begin
    CommonLib.MessageDlgXP_Vista('Change Leaves from Leaves tab.', mtInformation, [mbOK], 0);
    PageControl1.ActivePage := tabLeaves;
    exit;
  end;

  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      Pay.PaysPayRates.Delete;
      Pay.PaysPayRates.PostDb;
    except

    end;
  end;
end;

procedure TfmEmployeePayBASE.btnLeaveDeleteClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      Pay.PaysLeave.Delete;
      Pay.AddLeavesToPay;
    except

    end;
  end;
end;

procedure TfmEmployeePayBASE.EditLeaveFromLeaveGrid;
begin
  try
    if IsLeave(Pay.PaysPayRates.PayRateID) then begin
      //in case they started to add a leave in grdHours
      if Pay.PaysPayRates.Qty = 0 then begin
        Pay.PaysPayRates.Delete;
      end;

      CommonLib.MessageDlgXP_Vista('Change Leaves from Leaves tab.', mtInformation, [mbOK], 0);
      grdHours.SetActiveRow(0); //so they can't tab back and edit selected leave
      PageControl1.ActivePage := tabLeaves;
      grdLeave.SetFocus;
      exit;
    end;
  except
    on e: Exception do begin
      raise Exception.Create(e.message);
    end;
  end;
end;

procedure TfmEmployeePayBASE.grdHoursMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  EditLeaveFromLeaveGrid;
end;

procedure TfmEmployeePayBASE.grdHoursColEnter(Sender: TObject);
begin
  inherited;
  EditLeaveFromLeaveGrid;
end;

procedure TfmEmployeePayBASE.btnDeleteBenefitClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      TPaybase(Pay).Pension.Delete; // UKBenefits.Delete;
    finally
    end;
  end;
end;   


procedure TfmEmployeePayBASE.btnCancelClick(Sender: TObject);
begin
  inherited;
  RollbackTransaction;
  Close;
end;

procedure TfmEmployeePayBASE.btnOKClick(Sender: TObject);
begin
  inherited;
  if Pay.Deleted = True then begin
    if (CommonLib.MessageDlgXP_Vista('Are You Sure You Wish To DELETE This Pay ?', mtConfirmation, [mbYes, mbNo], 0) = mrNo) then begin
      Pay.Deleted := False;
    end;
  end;
  if not Tpaysleave(Pay.PaysLeave).ValidateData then exit;
  Pay.Save ;

//  Tpaysleave(Pay.PaysLeave).Save;

  //Tpaysleave(Pay.PaysLeave).PostDb;
//  TPayspayrates(Pay.PaysPayRates).PostDB;
//  TPaybase(Pay).UKBenefits.PostDb;
  CommitTransaction;
  Close;
 // if fsModal in FormState then
//    ModalResult := mrOK
//  else
//    Release;
//  end
end;

procedure TfmEmployeePayBASE.chkDeletedClick(Sender: TObject);
var
  bWasDeleted:boolean;
begin
  inherited;
  if not fOpenningForm then begin
    bWasDeleted := Pay.Deleted;
           //This is a work around to force the check box to behave as it should ///////////////////
    if not TwwCheckBox(Sender).DataSource.DataSet.Active then Exit;
    TwwCheckBox(Sender).DataSource.DataSet.Edit;
    if TwwCheckBox(Sender).Checked then TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'T'
    else TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'F';
    qryPays.edit;
       //////////////////////////////////////////////////////////////////////////////////////////

    if bWasDeleted = False then begin
      if (CommonLib.MessageDlgXP_Vista('Are You Sure You Wish To DELETE This Pay ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin

        Pay.DeletePay;
        Pay.Save;
        CommitTransaction;
        Close;
      end else begin
        Pay.Deleted := False;
      end;
    end;
  end;
end;

procedure TfmEmployeePayBASE.chkManualTaxClick(Sender: TObject);
begin
  inherited;
      //This is a work around to force the check box to behave as it should ///////////////////
  if not TwwCheckBox(Sender).DataSource.DataSet.Active then Exit;
  TwwCheckBox(Sender).DataSource.DataSet.Edit;
  if TwwCheckBox(Sender).Checked then TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'T'
  else TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'F';
  qryPays.edit;
     //////////////////////////////////////////////////////////////////////////////////////////

  if chkManualTax.Checked then begin
    TaxPay.ReadOnly := False;
    TaxPay.SetFocus;
  end else begin
    TaxPay.ReadOnly := True;
  end;
end;

procedure TfmEmployeePayBASE.DeductionCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  Pay.PayDeductions.AddDeductionDetails ;
end;

procedure TfmEmployeePayBASE.btnDeductionDeleteClick(Sender: TObject);
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this deduction?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
    try
      TPaybase(Pay).PayDeductions.Delete;
    finally
    end;
  end;
end;

procedure TfmEmployeePayBASE.grdBenefitsExit(Sender: TObject);
begin
  inherited;
  if AppEnv.RegionalOptions.Region = rUK then begin
    TPaybase(Pay).Pension.PostDb; //  UKBenefits.PostDb;
  end;
end;

procedure TfmEmployeePayBASE.Timer1Timer(Sender: TObject);
begin
  inherited;
  if (pnlEmployer.Top <= 9) or (pnlEmployee.Top <= 9)then begin
    Timer1.Enabled := False;
  end;
  if fsToggleNICs = 'Employee' then begin
    pnlEmployer.Hide;
    pnlEmployer.Top := pnlEmployer.Top - 2;
    pnlEmployer.Show;
  end else begin
    pnlEmployee.Hide;
    pnlEmployee.Top := pnlEmployee.Top - 2;
    pnlEmployee.Show;
  end;
end;

procedure TfmEmployeePayBASE.Timer2Timer(Sender: TObject);
begin
  inherited;
  if fsToggleNICs = 'Employee' then begin
    if pnlEmployer.Top >= 115 then begin
      Timer2.Enabled := False;
      Timer1.Enabled := True;
    end;
  end else begin
    if pnlEmployee.Top >= 115 then begin
      Timer2.Enabled := False;
      Timer1.Enabled := True;
    end;
  end;


  //if (pnlEmployer.Top >= 115) or (pnlEmployee.Top >= 115)then begin
//    Timer2.Enabled := False;
//
//  end;
  if fsToggleNICs = 'Employee' then begin
    pnlEmployer.Hide;
    pnlEmployer.Top := pnlEmployer.Top + 2;
    pnlEmployer.Show;
  end else begin
    pnlEmployee.Hide;
    pnlEmployee.Top := pnlEmployee.Top + 2;
    pnlEmployee.Show;
  end;

  //if pnlEmployer.Top >= 115 then begin
//    Timer2.Enabled := False;
//    PnlEmployee.Visible := True;
//    btnEmployerNICs.Caption := 'Employer NICs';
//  end;
//  if fsToggleNICs = 'Employee' then begin
//    pnlEmployee.Hide;
//    pnlEmployee.Top := pnlEmployer.Top + 2;
//    pnlEmployee.Show;
//  end else begin
//    pnlEmployer.Hide;
//    pnlEmployer.Top := pnlEmployer.Top + 2;
//    pnlEmployer.Show;
//  end;
end;

procedure TfmEmployeePayBASE.btnEmployerNICsClick(Sender: TObject);
begin
  inherited;
  if Timer1.Enabled then exit;
  if Timer2.Enabled then exit;
  pnlEmployee.Visible := False;
  pnlEmployee.Top := 115;
  pnlEmployer.Visible := False;
  pnlEmployer.Top := 115;
  pnlEmployee.Visible := True;
  pnlEmployer.Visible := True;

  if fsToggleNICs = 'Employee' then begin
      fsToggleNICs := 'Employer';
      btnEmployerNICs.Caption := 'Employer NICs';
  end else begin
    fsToggleNICs := 'Employee';
    btnEmployerNICs.Caption := 'Employee NICs';
  end;
  Timer1.Enabled := True;
end;

procedure TfmEmployeePayBASE.PayRateCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  Pay.PaysPayRates.SetPayRateAmount;
end;

procedure TfmEmployeePayBASE.btnProcessPayClick(Sender: TObject);
begin
  inherited;   
  PayUtils.PrintPaySlip(Pay,True,Pay.EmployeeDetails.Sendpayslipviaemail);
end;

procedure TfmEmployeePayBASE.cboAllowanceCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  Pay.PayAllowances.AddAllowanceDetails;
end;

procedure TfmEmployeePayBASE.grdAllowancesExit(Sender: TObject);
begin
  inherited;
 // if not Pay.PayAllowances.ValidateData then HandleAllowanceErrors; 
end;

procedure TfmEmployeePayBASE.grdAllowancesRowChanged(Sender: TObject);
begin
  inherited;
  HandleAllowanceErrors;
end;

initialization
RegisterClass(TfmEmployeePayBASE);
FormFact.RegisterMe(TfmEmployeePayBASE, 'TfrmPaySummary_*=PayID');
FormFact.RegisterMe(TfmEmployeePayBASE, 'TPayListingGUI_*=PayID');
FormFact.RegisterMe(TfmEmployeePayBASE, 'TLeaveListGUI_*=PayID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TfrmSuperFundListGUI_*=PayID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TPayJobListGUI_*=PayID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransAccountDetailsGUI_*_Payroll Superannuation=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransAccountDetailsGUI_*_Payroll Accrued Leave=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransAccountDetailsGUI_*_Payroll Leave Taken=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransAccountDetailsGUI_*_Payroll Deduction=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransAccountDetailsGUI_*_Payroll Sundry=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransAccountDetailsGUI_*_Payroll Allowance=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransAccountDetailsGUI_*_Payroll Pays=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransAccountDetailsGUI_*_Payroll PAYG=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransAccountDetailsGUI_*_Payroll Net Wages=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransAccountDetailsGUI_*_Payroll Gross Wages=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransactionListGUI_*_Payroll Superannuation=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransactionListGUI_*_Payroll Accrued Leave=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransactionListGUI_*_Payroll Leave Taken=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransactionListGUI_*_Payroll Deduction=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransactionListGUI_*_Payroll Sundry=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransactionListGUI_*_Payroll Allowance=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransactionListGUI_*_Payroll Pays=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransactionListGUI_*_Payroll PAYG=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransactionListGUI_*_Payroll Net Wages=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TTransactionListGUI_*_Payroll Gross Wages=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TBankAccountListGUI_Type_Payroll Net Wages=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TBalTransListGUI_*_Payroll Superannuation=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TBalTransListGUI_*_Payroll Accrued Leave=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TBalTransListGUI_*_Payroll Leave Taken=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TBalTransListGUI_*_Payroll Deduction=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TBalTransListGUI_*_Payroll Sundry=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TBalTransListGUI_*_Payroll Allowance=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TBalTransListGUI_*_Payroll Pays=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TBalTransListGUI_*_Payroll PAYG=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TBalTransListGUI_*_Payroll Net Wages=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TBalTransListGUI_*_Payroll Gross Wages=SaleID');
  FormFact.RegisterMe(TfmEmployeePayBASE, 'TLeaveAccruedDetailsListGUI_*=PayNo');

end.
