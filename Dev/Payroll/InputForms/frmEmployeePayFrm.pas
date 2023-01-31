unit frmEmployeePayfrm;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 19/07/06  1.00.01 RM  First version.
 Note: if you need to alter the layout of any of the subform grids, temperarily
       copy the relevant qry from this form to the subform so that the Datasource
       has a dataset in design time
}

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ImageScroll, ExtCtrls, DNMPanel, Menus, AdvMenus,
  DataState, DBAccess, MyAccess,ERPdbComponents, SelectionDialog, AppEvnts, DB, 
  DNMSpeedButton, StdCtrls, wwcheckbox, DataSourcePrefs, MessageConst,
  wwradiogroup, Mask, wwdbedit, Wwdotdot, Wwdbcomb, jpeg, GraphUtil, Shader,
  BusObjPayUtils,BusObjPaybase, MemDS,
  wwdbdatetimepicker, DBCtrls, AdvPicture,BusObjBase, ImgList, ProgressDialog,
  Grids, Wwdbigrd, Wwdbgrid;

type
  TfrmEmployeePay = class(TBaseInputGUI)
    sbButtons: TScrollBox;
    pnlButtons: TDNMPanel;
    sbPrefs: TScrollBox;
    ImageScroll: TImageScroll;
    btnOK: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    Label1: TLabel;
    Bevel1: TBevel;
    cboSearch: TwwDBComboBox;
    Label2: TLabel;
    imgPrefs: TImage;
    Shader1: TShader;
    pnlActiveForm: TLabel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    qryPays: TERPQuery;
    pnlsum: TDNMPanel;
    pnlemployee: TDNMPanel;
    lblNICsOther: TLabel;
    Label12: TLabel;
    Label16: TLabel;
    edNICs: TDBEdit;
    edNICsOther: TDBEdit;
    pnlemployer: TDNMPanel;
    Label13: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    edEmployerNICsClass1: TDBEdit;
    edEmployerNICsOther: TDBEdit;
    DNMPanel2: TDNMPanel;
    Label38: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    lblTaxCode: TLabel;
    Bevel2: TBevel;
    Label11: TLabel;
    Label14: TLabel;
    PayDate: TwwDBDateTimePicker;
    DatePaid: TwwDBDateTimePicker;
    PayPeriods: TDBEdit;
    edTaxcodeUsed: TDBEdit;
    chkManualTax: TwwCheckBox;
    edPayID: TDBEdit;
    DSPays: TDataSource;
    Timer1: TTimer;
    Timer2: TTimer;
    btnEmployerNICs: TDNMSpeedButton;
    btnPrintPayslip: TDNMSpeedButton;
    AdvPicture1: TAdvPicture;
    Label20: TLabel;
    edRegion: TDBEdit;
    qryPaysPayID: TIntegerField;
    qryPaysEmployeeID: TIntegerField;
    qryPaysPayDate: TDateField;
    qryPaysPayPeriods: TWordField;
    qryPaysWages: TFloatField;
    qryPaysCommission: TFloatField;
    qryPaysworkplacegiving: TFloatField;
    qryPaysAllowances: TFloatField;
    qryPaysAllowancesBeforeTax: TFloatField;
    qryPaysSundries: TFloatField;
    qryPaysSuperannuation: TFloatField;
    qryPaysGross: TFloatField;
    qryPaysGrossTaxable: TFloatField;
    qryPaysTax: TFloatField;
    qryPaysNet: TFloatField;
    qryPaysPay: TWideStringField;
    qryPaysPaid: TWideStringField;
    qryPaysEditedFlag: TWideStringField;
    qryPaysPrinted: TWideStringField;
    qryPaysEmpName: TWideStringField;
    qryPaysLeaveLoading: TFloatField;
    qryPaysClassID: TIntegerField;
    qryPaysClass: TWideStringField;
    qryPaysIsTimesheet: TWideStringField;
    qryPaysPayPeriod: TWideStringField;
    qryPaysAnnualLeaveRate: TFloatField;
    qryPaysCDEPGross: TFloatField;
    qryPaysLumpA: TFloatField;
    qryPaysLumpB: TFloatField;
    qryPaysLumpD: TFloatField;
    qryPaysLumpE: TFloatField;
    qryPaysETP: TFloatField;
    qryPaysManualTax: TWideStringField;
    qryPaysDeleted: TWideStringField;
    qryPaysIsNewTypePay: TWideStringField;
    qryPaysmsTimeStamp: TDateTimeField;
    qryPaysPaySuperOnLeaveLoading: TWideStringField;
    qryPaysPayVersion: TIntegerField;
    qryPaysPayNotes: TWideMemoField;
    qryPaysUKTaxCodeUsed: TWideStringField;
    qryPaysPrepared: TWideStringField;
    qryPaysUKNICsClass1: TFloatField;
    qryPaysIsContractedOut: TWideStringField;
    qryPaysUKNICsOther: TFloatField;
    qryPaysUKEmployerNICsClass1: TFloatField;
    qryPaysUKEmployerNICsOther: TFloatField;
    qryPaysRegion: TWideStringField;
    qryPaysIsContractedOut2: TWideStringField;
    qryPayAllowances: TERPQuery;
    qryPayAllowancesPayAllowanceID: TAutoIncField;
    qryPayAllowancesPayID: TIntegerField;
    qryPayAllowancesAllowanceID: TIntegerField;
    qryPayAllowancesQty: TFloatField;
    qryPayAllowancesAmount: TFloatField;
    qryPayAllowancesCalcBy: TWideStringField;
    qryPayAllowancesSuperInc: TWideStringField;
    qryPayAllowancesTaxExempt: TWideStringField;
    qryPayAllowancesClientID: TIntegerField;
    qryPayAllowancesClassID: TIntegerField;
    qryPayAllowancesAllowance: TWideStringField;
    qryPayAllowancesAllowanceJob: TWideStringField;
    qryPayAllowancesLineTotal: TFloatField;
    qryPayAllowancesClassName: TWideStringField;
    qryPayAllowancesBasedOn: TWideStringField;
    qryPayAllowancesBasedOnID: TIntegerField;
    qryPayAllowancesMoneyAmount: TFloatField;
    qryAllowances: TERPQuery;
    qryAllowancesDescription: TWideStringField;
    qryAllowancesAllowanceID: TAutoIncField;
    qryAllowancesSuperInc: TWideStringField;
    qryAllowancesTaxExempt: TWideStringField;
    qryAllowancesQty: TFloatField;
    qryAllowancesAmount: TFloatField;
    qryAllowancesBasedOnID: TIntegerField;
    qryAllowancesCalcBy: TWideStringField;
    qryJobs: TERPQuery;
    qryBasedOn: TERPQuery;
    qryBasedOnBasedOn: TWideStringField;
    qryBasedOnBasedOnID: TAutoIncField;
    qryPayPaySplits: TERPQuery;
    qryPayPaySplitsBank: TWideStringField;
    qryPayPaySplitsSplit: TWideStringField;
    qryPayPaySplitsBranch: TWideStringField;
    qryPayPaySplitsBSB: TWideStringField;
    qryPayPaySplitsAccountName: TWideStringField;
    qryPayPaySplitsAccountNo: TWideStringField;
    qryPayPaySplitsAmount: TFloatField;
    qryPayPaySplitsType: TWideStringField;
    qryPayPaySplitsPayID: TIntegerField;
    qryPayPaySplitsPaySplitID: TIntegerField;
    qryPayPaySplitsBankID: TIntegerField;
    qryBankCodes: TERPQuery;
    qrypayssuper: TERPQuery;
    qrypayssuperSuperType: TWideStringField;
    qrypayssuperSuperFund: TWideStringField;
    qrypayssuperAccountNo: TWideStringField;
    qrypayssuperDateJoined: TDateField;
    qrypayssuperAmount: TFloatField;
    qrypayssuperCalcBy: TWideStringField;
    qrypayssuperArea: TWideStringField;
    qrypayssuperAmountPaid: TFloatField;
    qrypayssuperClassName: TWideStringField;
    qrypayssuperPaySuperID: TAutoIncField;
    qrypayssuperPayID: TIntegerField;
    qrypayssuperSuperID: TIntegerField;
    qrypayssuperSuperTypeID: TIntegerField;
    qrypayssuperClientID: TIntegerField;
    qrypayssuperClassID: TIntegerField;
    qrySuperType: TERPQuery;
    qrySuppliers: TERPQuery;
    qryPayBenefits: TERPQuery;
    qryPayBenefitsPayID: TIntegerField;
    qryPayBenefitsDescription: TWideStringField;
    qryPayBenefitsIsNICsPayable: TWideStringField;
    qryPayBenefitsNICsClass: TWideStringField;
    qryPayBenefitsAmount: TFloatField;
    qryPayBenefitsEmployeeNICAmount: TFloatField;
    qryPayBenefitsEmployerNICAmount: TFloatField;
    qryPayBenefitsBenefitReceivedFrom: TWideStringField;
    qryPayBenefitsBenefitOrExpense: TWideStringField;
    qryPayBenefitsClassID: TIntegerField;
    qryPayBenefitsClassName: TWideStringField;
    qryPayCommissions: TERPQuery;
    qryPayCommissionsPayCommissionID: TIntegerField;
    qryPayCommissionsPayID: TIntegerField;
    qryPayCommissionsCommissionID: TIntegerField;
    qryPayCommissionsGross: TFloatField;
    qryPayCommissionsCommissionPercent: TFloatField;
    qryPayCommissionsNet: TFloatField;
    qryPayCommissionsPeriodID: TIntegerField;
    qryPayCommissionsSuperInc: TWideStringField;
    qryPayCommissionsTaxExempt: TWideStringField;
    qryPayCommissionsCommPeriod: TWideStringField;
    qryPayCommissionsEmployeeID: TIntegerField;
    qryPayCommissionsClassID: TIntegerField;
    qryPayCommissionsClassName: TWideStringField;
    qryCommissionPeriod: TERPQuery;
    qryPaydeductions: TERPQuery;
    qryPaydeductionsPayDeductionID: TAutoIncField;
    qryPaydeductionsPayID: TIntegerField;
    qryPaydeductionsDeductionID: TIntegerField;
    qryPaydeductionsNotes: TWideStringField;
    qryPaydeductionsQty: TFloatField;
    qryPaydeductionsAmount: TFloatField;
    qryPaydeductionsCalcBy: TWideStringField;
    qryPaydeductionsUnionFees: TWideStringField;
    qryPaydeductionsTaxExempt: TWideStringField;
    qryPaydeductionsIsWorkPlacegiving: TWideStringField;
    qryPaydeductionsDeduction: TWideStringField;
    qryPaydeductionsClassID: TIntegerField;
    qryPaydeductionsClassName: TWideStringField;
    qryPaydeductionsBasedOnID: TIntegerField;
    qryPaydeductionsBasedOn: TWideStringField;
    qryPaydeductionsMoneyAmount: TFloatField;
    qryDeductions: TERPQuery;
    qryPaysPayRates: TERPQuery;
    qryPaysPayRatesPayID: TIntegerField;
    qryPaysPayRatesPayRate: TWideStringField;
    qryPaysPayRatesPayType: TWideStringField;
    qryPaysPayRatesQty: TFloatField;
    qryPaysPayRatesAmount: TFloatField;
    qryPaysPayRatesSuperInc: TWideStringField;
    qryPaysPayRatesPayJob: TWideStringField;
    qryPaysPayRatesLineTotal: TFloatField;
    qryPaysPayRatesClassName: TWideStringField;
    qryPaysPayRatesPayRateID: TIntegerField;
    qryPaysPayRatesTypeID: TIntegerField;
    qryPaysPayRatesGlobalRef: TWideStringField;
    qryPaysPayRatesClientID: TIntegerField;
    qryPaysPayRatesClassID: TIntegerField;
    qryPaysPayRatesEditedFlag: TWideStringField;
    qryPaysPayRatesTimeSheetId: TIntegerField;
    qryPaysPayRatesPaysPayRateID: TIntegerField;
    qryPaysPayRatesNICsInc: TWideStringField;
    qryPayRates: TERPQuery;
    qryPayRateType: TERPQuery;
    qryLeaveTypes: TERPQuery;
    qryLeavePayTypes: TERPQuery;
    qryPaysLeave: TERPQuery;
    qryPaysLeaveDateTaken: TDateField;
    qryPaysLeaveLeaveType: TWideStringField;
    qryPaysLeaveQty: TFloatField;
    qryPaysLeaveLeavePayType: TWideStringField;
    qryPaysLeaveAmount: TFloatField;
    qryPaysLeavelookupJob: TWideStringField;
    qryPaysLeaveGlobalRef: TWideStringField;
    qryPaysLeavePayLeaveID: TAutoIncField;
    qryPaysLeavePayID: TIntegerField;
    qryPaysLeaveClientID: TIntegerField;
    qryPaysLeaveClassID: TIntegerField;
    qryPaysLeaveEditedFlag: TWideStringField;
    qryPaysLeaveClassName: TWideStringField;
    qryPaysLeaveSuperInc: TWideStringField;
    qryPaysLeaveIsCertified: TWideStringField;
    qryPaySundries: TERPQuery;
    qryPaySundriesSundry: TWideStringField;
    qryPaySundriesAmount: TFloatField;
    qryPaySundriesGST: TFloatField;
    qryPaySundriesSuperInc: TWideStringField;
    qryPaySundriesTaxExempt: TWideStringField;
    qryPaySundriesAdjustment: TWideStringField;
    qryPaySundriesAdjJob: TWideStringField;
    qryPaySundriesAdjDept: TWideStringField;
    qryPaySundriesClientID: TIntegerField;
    qryPaySundriesClassID: TIntegerField;
    qryPaySundriesPaySundryID: TIntegerField;
    qryPaySundriesPayID: TIntegerField;
    qryPaySundriesSundryID: TIntegerField;
    qryPaySundriesClassName: TWideStringField;
    qryEmployeeSundries: TERPQuery;
    qrySundryDesc: TERPQuery;
    qryDepartment: TERPQuery;
    btnABA: TDNMSpeedButton;
    btnLoadTimesheet: TDNMSpeedButton;
    qryPaysGlobalRef: TWideStringField;
    qrypayssuperThisPaysProportion: TFloatField;
    qrypayssuperNonCatchUpAmount: TFloatField;
    qrypayssuperBelowThreshold: TWideStringField;
    qryPaysLeaveTakenFrom: TDateTimeField;
    qryPaysLeaveTakenTo: TDateTimeField;
    qryPayCommissionscDetails: TWideStringField;
    qryPayCommissionLines: TERPQuery;
    qryPayCommissionLinesGlobalRef: TWideStringField;
    qryPayCommissionLinesPayCommissionLineID: TIntegerField;
    qryPayCommissionLinesPaycommissionID: TIntegerField;
    qryPayCommissionLinesSalesCommissionId: TIntegerField;
    qryPayCommissionLinesCommissionamount: TFloatField;
    qryPayCommissionLinesDescription: TWideStringField;
    qryPayCommissionLinesmsTimestamp: TDateTimeField;
    qryPayCommissionsCommissionDesc: TWideMemoField;
    btnUpdateBatch: TDNMSpeedButton;
    qryPayCommissionsIsManual: TWideStringField;
    pnlTotalsUS: TDNMPanel;
    Label21: TLabel;
    edtUSWages: TDBEdit;
    Label22: TLabel;
    edtUSCommission: TDBEdit;
    Label23: TLabel;
    edtUSDeductions: TDBEdit;
    Label25: TLabel;
    edtUSSundries: TDBEdit;
    Label26: TLabel;
    edtUSGross: TDBEdit;
    Label27: TLabel;
    edtUSTax: TDBEdit;
    Label28: TLabel;
    edUSNet: TDBEdit;
    qryTermination: TERPQuery;
    qryPaysPayXMLData: TWideMemoField;
    qryPaysIsTermination: TWideStringField;
    qryPaysmsUpdateSiteCode: TWideStringField;
    pnlPrepared: TDNMPanel;
    Label18: TLabel;
    ChkPrepared: TwwCheckBox;
    pnlDeleted: TDNMPanel;
    Label19: TLabel;
    chkDeleted: TwwCheckBox;
    Label24: TLabel;
    DBEdit1: TDBEdit;
    Label29: TLabel;
    edtCompanyTax: TDBEdit;
    qryPaysCompanyTax: TFloatField;
    qryPaysDeductions: TFloatField;
    qryPaysPayRunID: TIntegerField;
    qryPayAllowancesAllowanceType: TWideStringField;
    qryPayAllowancesDisplayIn: TWideStringField;
    qryPaysGrossExcludeAllowances: TFloatField;
    qryPaysTopUptoJobKeepersAllowance: TFloatField;
    pnlsum1: TDNMPanel;
    lblWages: TLabel;
    Wages: TDBEdit;
    lblCommission: TLabel;
    CommissionPay: TDBEdit;
    lblDeductions: TLabel;
    DeductionsPay: TDBEdit;
    pnlsum2: TDNMPanel;
    lblAllowances: TLabel;
    AllowancesPay: TDBEdit;
    lblSundries: TLabel;
    lblSuper: TLabel;
    SuperPay: TDBEdit;
    SundriesPay: TDBEdit;
    pnlsum3: TDNMPanel;
    lblGross: TLabel;
    lblTax: TLabel;
    lblNet: TLabel;
    NetPay: TDBEdit;
    TaxPay: TDBEdit;
    GrossPay: TDBEdit;
    qryPaydeductionsBox12CodeID: TIntegerField;
    qryPaysDatePaid: TDateTimeField;
    qryPaydeductionsTaxExemptFederal: TWideStringField;
    qryPaydeductionsTaxExemptState: TWideStringField;
    qryPaydeductionsTaxExemptSocial: TWideStringField;
    qryPaydeductionsTaxExemptMedicare: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnOKClick(Sender: TObject);
    procedure cboSearchCloseUp(Sender: TwwDBComboBox; Select: Boolean);
    procedure btnEmployerNICsClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure chkDeletedClick(Sender: TObject);
    procedure btnPrintPayslipClick(Sender: TObject);
    procedure PayDateCloseUp(Sender: TObject);
    procedure btnABAClick(Sender: TObject);
    procedure chkManualTaxClick(Sender: TObject);
    procedure btnLoadTimesheetClick(Sender: TObject);
    procedure btnUpdateBatchClick(Sender: TObject);
    procedure qryPayCommissionsAfterPost(DataSet: TDataSet);
    procedure qryBankCodesBeforeOpen(DataSet: TDataSet);
    procedure TaxPayEnter(Sender: TObject);
    procedure qryTerminationAfterOpen(DataSet: TDataSet);
    procedure TaxPayChange(Sender: TObject);
  private
    fProcessedPay: Boolean;
    ms:TMemoryStream;
    fsToggleNICs:String;
    fSingleButtonCaption: string;
    fTextSearch: string;
    fFocusControlName: string;
    fPreventFinish: Boolean;
    fPanelColor: TColor;
    fEFTDone :boolean;
    fbPayChangeOccured:boolean;
    fbSalesCommenabled :Boolean;
    ButtonCtr:Integer;
    Selectedbutton:TObject;
    Function batchUpdateDetails :String;
    procedure PostIfDirty;
    procedure ShowSubForm(const ButtonName:String;const FormIndex:integer);
    procedure HandleActiveFormChange(Sender: TObject);
    procedure AddButton(const ButtonCaption: string; const ButtonTop: Integer);
    procedure AddMainButtons;
    procedure LoadPanels;
    procedure MainButtonClick(Sender: TObject);
    function GetFormClassName(const ButtonCaption: string): string;
    procedure ClearScrollBox;
    procedure SetScrollBarIncrement;
    procedure SetupConnections;
    procedure BuildSearchList;
    procedure SetFormLayoutToAust;
    function FindMainButton(const Caption: string): TDNMSpeedButton;
    procedure CancelFinish(var Msg: TMessage); message TX_CancelFinish;
    procedure PerformTextSearch(var Msg: TMessage); message TX_PerformTextSearch;
    function IsPanelShown(const Panel: TDNMPanel): Boolean;
    function ValidateCurrentSubForm:Boolean;
    procedure HandleEmpPayFormErrors;
    function IsAccessAllowed(const sFnName: string; const iEmployeeID: integer = 0): boolean;
  Protected
    Pay:Tpaybase;
    PayUtils:Tpayutils;
    fSourceForm: TForm;
    function GetReportTypeID: integer;Override;
    procedure DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    Procedure AddSubforms;Virtual;
    procedure Newsubform(const formdesc, formname: String);
    procedure SetupActiveFrmBusObjs;Virtual;
    procedure ShowSubFormOnMainbuttonclick(Sender: TObject; sFormClassName:String);Virtual;
    function PopupSubform(sFormClassName:String):boolean; virtual;
  public
    Procedure AfterTranslate; Override;
    procedure SearchForText(const SearchStr: string; const FocusControlName: string = '');
    property SingleButtonCaption: string read fSingleButtonCaption write fSingleButtonCaption;
    property TextSearch: string read fTextSearch write fTextSearch;
    property FocusControlName: string read fFocusControlName write fFocusControlName;
    procedure DoPanelBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
  end;

implementation

uses
  CommonLib, StrUtils,FormFactory,tcTypes,BusObjConst,
  CommonDBLib, AppEnvironment,PaySupersFrm,
  PayHoursFrm,PayLeavesFrm,PayAllowancesFrm,PayDeductionsFrm,
  PayCommissionsFrm,PaySundriesFrm,PayNotesFrm,PayBankingFrm,
  BusObjPayCommissionsBASE,ABAObj,
  PayCommon,TerminatePayFrm,frmTimeSheetGUI,
  FastFuncs, frmActionApproved,BusObjPaysSuperannuation,
  BaseFormForm, tcDataUtils, GlobalEventsObj, frmSalesCommission, BusObjPayLine,
  BusObjTerminationSimple, TerminateSimpleFrm, PayAccounts,
  PayTaxFrm, BusObjPayRun, ImagesLib;

const
  cMainButtonWidth = 148;
  cMainButtonHeight = 28;
  cMainButtonGap = 1;
  cMainButtonLeft = 14;
  cMainButtonTopStart = 5;
  cMaxRange = 6000;
  ACCESS_ALLOWED = 1;
var
  cButtonCaptions: array of string;
  cFormClassNames: array of string;
  cFormCount: integer;
{$R *.dfm}

procedure TfrmEmployeePay.SetFormLayoutToAust;
(*var
  Offset1,Offset2,Offset3: integer;*)
//  Offset4:integer;
begin
(*  Offset1 := 56;
  Offset2 := 80;
  Offset3 := - 104;*)
  //Offset4 := - 100;
  //Top Panel
  lblTaxCode.Visible := False;
  edTaxCodeUsed.Visible := False;
//  Label14.Left := 560 + Offset4;
//  edPayID.Left := 560 + Offset4;
//  Bevel2.Left := 653 + Offset4;
//  chkManualTax.Left := 669 + Offset4;
//  Label11.Left := 686 + Offset4;

  //Bottom Panel
//  Label3.Left   := 35 + Offset1;
//  Label4.Left   := 4 + Offset1;
//  Label5.Left   := 11 + Offset1;
//  Label6.Left   := 219 + Offset2;
//  Label7.Left   := 231 + Offset2;
//  LblSuper.Left := 245 + Offset2;
//  Label9.Left   := 637 + Offset3;
//  Label8.Left   := 637 + Offset3;
//  Label10.Left  := 637 + Offset3;
(*  Wages.Left            := 89 + Offset1;
  lblWages.Left := Wages.Left - lblWages.Width -10;

  CommissionPay.Left    := 89 + Offset1;
  lblCommission.Left := CommissionPay.Left - lblCommission.Width -10;

  DeductionsPay.Left    := 89 + Offset1;
  lblDeductions.Left := DeductionsPay.Left - lblDeductions.Width -10;

  AllowancesPay.Left    := 288 + Offset2;
  lblAllowances.Left := AllowancesPay.Left - lblAllowances.Width -10;

  SundriesPay.Left      := 288 + Offset2;
  lblSundries.Left := SundriesPay.Left - lblSundries.Width -10;

  SuperPay.Left         := 288 + Offset2;
  lblSuper.Left := SuperPay.Left - lblSuper.Width -10;

  GrossPay.Left         := 678 + Offset3;
  lblGross.Left := GrossPay.Left - lblGross.Width -10;

  TaxPay.left           := 678 + Offset3;
  lblTax.left := TaxPay.Left - lblTax.Width -10;

  NetPay.left           := 678 + Offset3;
  lblNet.left := NetPay.Left - lblNet.Width -10;*)

  if pnlemployee.visible then begin
    pnlsum1.Width := 208;
    pnlsum2.Width :=207;
    pnlsum3.Width := 174;
  end else begin
    pnlsum1.Width := trunc(pnlsum.Width/3);
    pnlsum2.Width := trunc(pnlsum.Width/3);
    pnlsum3.Width := trunc(pnlsum.Width/3);
  end;
end;

procedure TfrmEmployeePay.FormCreate(Sender: TObject);
begin
  inherited;
  Selectedbutton:=nil;
  ButtonCtr:= 0;
  fbTabSettingEnabled := False;
  fTextSearch := '';
  fFocusControlName := '';
  fSingleButtonCaption := '';
  fSourceForm := nil;
  fPreventFinish := False;
  (*sbPrefs.DoubleBuffered := True;*)
  fPanelColor := Self.color; //ColorAdjustLuma(GetGradientColor(Self.ClassName).Color, GetGradientColor(Self.ClassName).AdjLuma div 2, False);
  pnlButtons.Color := fPanelColor;
  (*Shader1.FromColor := GetGradientColor(Self.ClassName).Color;
  Shader1.ToColorMirror := Shader1.FromColor;
  Self.Color := fPanelColor;*)

  PayUtils := TPayUtils.Create(Self,Self.MyConnection);

end;


procedure TfrmEmployeePay.SetupActiveFrmBusObjs;
begin
  if fSourceform.ClassName = 'TfrmPayBanking' then begin
    with TfrmPayBanking(fSourceForm) do begin
      SubPay := Pay;
      DSPayPaySplits.DataSet := SubPay.PayPaysplits.Dataset;
      qryBankCodes.Open;
      if fProcessedPay then begin
        grdBanking.Options := grdBanking.Options - [dgEditing];
      end;
    end;
  end

  else if fSourceform.ClassName = 'TfrmPayNotes' then begin
    with TfrmPayNotes(fSourceForm) do begin
      SubPay := Pay;
      DSPayNotes.DataSet := SubPay.Dataset;

      if fProcessedPay then begin
        PayMemo.ReadOnly := False;
      end;
    end;
  end

  else if fSourceform.ClassName = 'TfrmPayHours' then begin
    with TfrmPayHours(fSourceForm) do begin
      SubPay := Pay;
      DSPaysPayRates.DataSet := SubPay.PaysPayRates.Dataset;
      qryPayRates.Open;
      qryPayRateType.Open;
      qryJobs.Open;
      qryDepartment.Open;

      if AppEnv.RegionalOptions.RegionType <> rAUST then begin
        grdHours.ColumnByName('SuperInc').Visible := false;
      end;

      if fProcessedPay then begin
        grdHours.Options := grdHours.Options - [dgEditing];
      end;
    end;
  end

  else if fSourceform.ClassName = 'TfrmPayLeaves' then begin
    with TfrmPayLeaves(fSourceForm) do begin
      SubPay := Pay;
      DSPaysLeave.DataSet := SubPay.PayLeaves.Dataset;
      qryLeavePayTypes.Open;
      qryLeaveTypes.Open;
      qryDepartment.Open;
      qryJobs.Open;

      if fProcessedPay then begin
        grdLeave.Options := grdLeave.Options - [dgEditing];
      end;
    end;
  end

  else if fSourceform.ClassName = 'TfrmPayAllowances' then begin
    with TfrmPayAllowances(fSourceForm) do begin
      Showcontrolhint(grdAllowances,(*'Pre-taxed:'*) TaxExemptDisplayLabel +chr(13)+
                            '   When True : Allowance is Added To Gross Pay(Pay Before Tax:'+GrossPay.text+').'    + #10#13+
                            '   When False: Allowance is Added To Net Pay  (Pay After Tax:'+NetPay.text+')');
      SubPay := Pay;
      DSPayAllowances.DataSet := SubPay.PayAllowances.Dataset;
      DSPays.DataSet := Self.DSPays.Dataset;
      pnlJobKeepersTopup.Visible := Appenv.CompanyPrefs.EnableJobKeepersAllowance[Pay.Paydate];
      qryDepartment.Open;
      qryAllowances.Open;
      QryAreaCodes.Open;
      if qryAllowances.RecordCount = 0 then NoAllowancesExist := True;
      qryJobs.Open;
      qryBasedOn.Open;
      if fProcessedPay then begin
        grdAllowances.Options := grdAllowances.Options - [dgEditing];
      end;
    end;
  end

  else if fSourceform.ClassName = 'TfrmPayDeductions' then begin
(*    Application.ShowHint := true;
    Application.HintPause := 100;
    Application.HintHidePause := 5000;*)
    with TfrmPayDeductions(fSourceForm) do begin
      Showcontrolhint(grdDeductions,(*'Pre-taxed:'*)TaxExemptDisplayLabel+chr(13)+
                            '   When True : Deduction is Taken from Gross Pay(Pay Before Tax:'+GrossPay.text+').'    + #10#13+
                            '   When False: Deduction is Taken from Net Pay  (Pay After Tax:'+NetPay.text+')');
      SubPay := Pay;
      DSPayDeductions.DataSet := SubPay.PayDeductions.Dataset;
      qryDeductions.Open;
      qryDepartment.Open;
      qryBasedOn.Open;
      qryJobs.Open;
      QryAreaCodes.Open;

      if fProcessedPay then begin
        grdDeductions.Options := grdDeductions.Options - [dgEditing];
      end;
    end;
  end


  else if fSourceform.ClassName = 'TfrmPayCommissions' then begin
    with TfrmPayCommissions(fSourceForm) do begin
      SubPay := Pay;
      DSPaysCommission.DataSet := SubPay.PayCommissions.Dataset;
(*      qryPayCommissionLines.Mastersource :=DSPaysCommission;
      DSPaysCommissionLines.DataSet := qryPayCommissionLines;*)
      qryEmployeeCommission.Open;
      qryCommDesc.Open;
      qryDepartment.Open;
      qryCommissionPeriod.Open;

      if fProcessedPay  then begin
        grdCommission.Options := grdCommission.Options - [dgEditing];
        btnCommission.enabled := False;
      end;
      USeSalesCommission:= fbSalesCommenabled;
    end;
  end

  else if fSourceform.ClassName = 'TfrmPaySundries' then begin
    with TfrmPaySundries(fSourceForm) do begin
      SubPay := Pay;
      DSPaySundries.DataSet := SubPay.PaySundries.Dataset;
      qryDepartment.Open;
      qryJobs.Open;
      qryEmployeeSundries.Open;
      qrySundryDesc.Open;

      if fProcessedPay then begin
        grdSundries.Options := grdSundries.Options - [dgEditing];
      end;
    end;
  end

  else if fSourceform.ClassName = 'TfrmPaySupers' then begin
    with TfrmPaySupers(fSourceForm) do begin
      SubPay := Pay;
      DSPaySuper.DataSet := SubPay.PayBenefits.Dataset;
      qryDepartment.Open;
      qrySuppliers.Open;
      qrySuperType.Open;
      QryAreaCodes.Open;
      if fProcessedPay then begin
        grdSuperannuation.Options := grdSuperannuation.Options - [dgEditing];
      end;
    end;
  end

  else if fSourceform is TfmTerminationSimple then begin
    TfmTerminationSimple(fSourceform).SubPay := Pay;
    TfmTerminationSimple(fSourceform).dsTerminate.DataSet := qryTermination;
    TfmTerminationSimple(fSourceform).dsPays.DataSet := qryPays;
    TfmTerminationSimple(fSourceform).ShowETPCodeLabel;
    if fProcessedPay then
      TfmTerminationSimple(fSourceform).edtLumpSumD.ReadOnly := true;
  end

  else if fSourceform is TfrmPayTax then begin
    with TfrmPayTax(fSourceForm) do begin
      SubPay := Pay;
    end;
  end;

end;
Procedure TfrmEmployeePay.Newsubform(const formdesc , formname:String);
begin
     cFormCount := cFormCount +1;
     Setlength(cButtonCaptions, cFormCount);
     Setlength( cFormClassNames,cFormCount);
     cButtonCaptions[cFormCount-1] :=  formdesc;
     cFormClassNames[cFormCount-1] :=  formname;
end;

procedure TfrmEmployeePay.FormShow(Sender: TObject);


begin
  DisableForm;
  try
    inherited;
    ms := TMemoryStream.Create;
    Pay := Tpaybase.Create(Self,Self.KeyID,Self.MyConnection) ;
    Pay.confirmFromGUI := self.ConfirmFromGUI;
    Pay.BusObjEvent                := DoBusinessObjectEvent;

    qryAllowances.Open;   //Lookup queries for lookup fields in queries below
    qryJobs.Open;
    qryBasedOn.Open;
    qryBankCodes.Open;
    qryCommissionPeriod.Open;
    qryDeductions.Open;
    qryPayRates.Open;
    qryPayRateType.Open;
    qryLeavePayTypes.Open;
    qryLeaveTypes.Open;
    qryDepartment.Open;
    qryEmployeeSundries.Params.ParamByName('EmpID').asInteger := Self.KeyID;
    qryEmployeeSundries.Open;
    qrySundryDesc.Open;
    qrySuperType.Open;
    qrySuppliers.Open;

    Pay.Dataset                    := qryPays;
    Pay.PayAllowances.Dataset      := qryPayAllowances;
    Pay.PayPaysplits.Dataset       := qryPayPaySplits;
    Pay.PayCommissions.Dataset     := qryPayCommissions;
    Pay.PayCommissions.PaysCommissionLines.Dataset     := qryPayCommissionLines;

    Pay.PayDeductions.Dataset      := qryPayDeductions;
    Pay.PaysPayRates.Dataset       := qryPaysPayRates;
    Pay.PayLeaves.Dataset          := qryPaysLeave;
    Pay.PaySundries.Dataset        := qryPaySundries;

    qrySuperType.Open;
    qrySuppliers.Open;
    { not assigned for USA }
    if Assigned(Pay.PayBenefits) then
      Pay.PayBenefits.Dataset := qrypayssuper;

    Pay.Load(Self.KeyID);

    if not (Pay.paid) then
     Pay.RecalcAll;
    if (Pay.Deleted = False) and (AccessLevel = 1) and (Pay.Paid = True) then btnABA.Enabled else btnABA.Enabled := False;

    if Pay.Paid = True then begin
      fProcessedPay := True;
      btnOk.Enabled := false;
      Label19.Enabled := true;
      chkDeleted.Enabled := true;
      PayDate.Enabled := False;
      chkManualTax.Enabled := False;
      TaxPay.Enabled := False;
      edTaxCodeUsed.Enabled := False;
      PayPeriods.Enabled := False;
      DatePaid.Enabled := False;
    end;

    AppEnv.RegionalOptions.LoadFlagPicture(AdvPicture1.Picture);

    AddSubforms;

    SuperPay.Visible := True;
    lblSuper.Visible := True;
    lblTaxCode.Visible := False;
    edTaxCodeUsed.Visible := False;
    pnlEmployee.Visible := False;
    pnlEmployer.Visible := False;
    btnEmployerNICs.Visible := False;

    //if (AppEnv.RegionalOptions.RegionType <> rAUST) and (AppEnv.RegionalOptions.RegionType <> rNZ) then begin
    if not (AppEnv.RegionalOptions.RegionType in [rAUST,rNZ]) then begin
      SetFormLayoutToAust;
      pnlsum.Visible := false;
      pnlTotalsUS.Left := pnlsum.Left;
      pnlTotalsUS.Top := pnlsum.Top - (pnlTotalsUS.Height - pnlsum.Height);
      pnlTotalsUS.Visible := true;

      { no manual tax for USA }
      { 14 dec 17 Removed at Maureene / Dene request }
      //chkManualTax.Visible := false;
      //Bevel2.Visible := false;
      //Label11.Visible := false;

    end
    else begin

      SetFormLayoutToAust;
    end;

    BuildSearchList;

    if (SingleButtonCaption <> '') and (AccessLevel <> 1) then begin
      AddButton(SingleButtonCaption, cMainButtonTopStart);
      fSourceForm := TForm(GetComponentByClassName(GetFormClassName(SingleButtonCaption)));
      pnlActiveForm.Caption := Pay.Empname + ': ' + SingleButtonCaption;
    end else begin
      AddMainButtons;

      fSourceForm := TForm(GetComponentByClassName(cFormClassNames[4]));
      pnlActiveForm.Caption := Pay.Empname + ': ' + cButtonCaptions[4];
    end;

    BeginTransaction;

    if Assigned(fSourceForm) then begin
      //SetClassLabels(fSourceForm);
      AppEnv.RegionalOptions.ChangeForm(fSourceForm);
      SetupConnections;

      SetupActiveFrmBusObjs;

      LoadPanels;
      PostMessage(fSourceForm.Handle, TX_PerformStartup, Handle, 0);

    end;

    Screen.OnActiveFormChange := HandleActiveFormChange;


    if (Pay.Pay = True) and (Pay.Paid = False) then begin
      (*Label19.Visible := false;
      chkDeleted.Visible := false;*)
      pnlDeleted.Visible := false;
    end;
    If not pnlDeleted.Visible then begin
      (*Label18.Visible := True;
      ChkPrepared.Visible := True;*)
      pnlPrepared.Visible := True;
    end;

    if Pay.Deleted then begin
      Label19.Enabled := false;
      chkDeleted.Enabled := false;
    end;
    if not Pay.paid then
      Pay.DatePaid := PayDate.Date + 2; //DatePaid.Date := PayDate.Date + 2; //arbitary value by Dene cause everyone is taking this as when they will actually see the money.

    if Pay.Paid then btnLoadTimesheet.Enabled := False;
    Self.Caption := 'Employee Pay    -    '+batchUpdateDetails;
    btnUpdateBatch.enabled :=fbSalesCommenabled;
  finally
    EnableForm;
  end;
end;

procedure TfrmEmployeePay.HandleActiveFormChange(Sender: TObject);
begin
  if (Screen.ActiveForm = Self) and (ImageScroll.Enabled = False) then begin
    Update;
    ImageScroll.Image := imgPrefs;
    ImageScroll.ScrollBox := sbPrefs;
    ImageScroll.Enabled := True;
    SetScrollBarIncrement;

    if TextSearch <> '' then begin
      SearchForText(TextSearch, FocusControlName);
      TextSearch := '';
    end;
  end;
end;

procedure TfrmEmployeePay.FormDestroy(Sender: TObject);
begin
  Screen.OnActiveFormChange := nil;
  ClearScrollBox;
  PayUtils.Free;
  if Assigned(ms) then FreeAndNil(ms);
  inherited;  
end;

procedure TfrmEmployeePay.btnCancelClick(Sender: TObject);
begin
  inherited;
  RollbackTransaction;
  Close;
end;

procedure TfrmEmployeePay.FormMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
var
  Increment: Integer;
begin
  inherited;
  Handled := True;
  Increment := sbPrefs.VertScrollBar.Increment;

  if WheelDelta < 0 then begin
    if (ImageScroll.ImagePosition + Increment) > imgPrefs.ClientHeight then
      ImageScroll.PerformScroll(imgPrefs.ClientHeight)
    else
      ImageScroll.PerformScroll(ImageScroll.ImagePosition + Increment);
  end
  else begin
    if (ImageScroll.ImagePosition - Increment) < 0 then
      ImageScroll.PerformScroll(0)
    else
      ImageScroll.PerformScroll(ImageScroll.ImagePosition - Increment)
  end;
end;

procedure TfrmEmployeePay.AddMainButtons;
var
  ButtonTop: Integer;
  ButtonIndex: Integer;
begin
  ButtonTop := cMainButtonTopStart;

  for ButtonIndex := 0 to cFormCount -1 do begin
    AddButton(cButtonCaptions[ButtonIndex], ButtonTop);
    ButtonTop := ButtonTop + cMainButtonHeight + cMainButtonGap;
  end;
end;

procedure TfrmEmployeePay.AddSubforms;
begin
    cFormCount := 0;
    Newsubform('Allowances'     ,'TfrmPayAllowances'  );
    Newsubform('Banking'        ,'TfrmPayBanking'     );
    fbSalesCommenabled:= SalesCommenabled;
    if fbSalesCommenabled then begin
        Appenv.CompanyPrefs.SalesCommissionCalcInProgress := True;
        Appenv.CompanyPrefs.SalesCommissionCalcEmployeeID := appenv.Employee.EmployeeID;
    end;
    Newsubform('Commissions'    ,'TfrmPayCommissions');
    Newsubform('Deductions'     ,'TfrmPayDeductions'  );
    Newsubform('Hours'          ,'TfrmPayHours'       );
    Newsubform('Leave Taken'    ,'TfrmPayLeaves'      );
    Newsubform('Notes'          ,'TfrmPayNotes'       );
    Newsubform('Sundries'       ,'TfrmPaySundries'    );
    Newsubform('Taxation'       ,'TfrmPayTax'    );
    if AppEnv.RegionalOptions.RegionType = rAUST then begin
      Newsubform('Superannuation' ,'TfrmPaySupers'      );
      Newsubform('Termination' ,'TfmTerminationSimple');
    end;
end;

procedure TfrmEmployeePay.AfterTranslate;
begin
  inherited;
  if assigned(Selectedbutton) then
    if Selectedbutton is TDNMSpeedButton then
      pnlActiveForm.caption := TDNMSpeedButton(Selectedbutton).caption;

end;

procedure TfrmEmployeePay.LoadPanels;
var
  TmpPanel: TDNMPanel;
  CurrentTop: Integer;
  PanelIndex: Integer;
  PanelList: TList;
  Bitmap: TBitmap;
  BitmapName: string;

  function GetPanel(Order: Integer): TDNMPanel;
  var
    Index: Integer;
  begin
    Result := nil;
    Index := 0;

    while (Index < fSourceForm.ControlCount) and (Result = nil) do begin
      if (fSourceForm.Controls[Index] is TDNMPanel) and
         (TDNMPanel(fSourceForm.Controls[Index]).TabOrder = Order) then
        Result := TDNMPanel(fSourceForm.Controls[Index])
      else
        Inc(Index);
    end;
  end;
(*  function GetScrillBox: TScrillBox;
  var
    Index: Integer;
  begin
    Result := nil;
    Index := 0;

    while (Index < fSourceForm.ControlCount) and (Result = nil) do begin
      if (fSourceForm.Controls[Index] is ScrillBox)  then begin
        Result := TcrillBox(fSourceForm.Controls[Index]);
        Exit;
      end;
    end;
  end;*)

  procedure SetPanelProperties(const Panel: TDNMPanel);
  begin
    Panel.BevelOuter := bvNone;
    Panel.Transparent := False;
    Panel.Color := fPanelColor;
    Panel.Left := 0;
    Panel.Top := CurrentTop;
    (*Panel.DoubleBuffered := True;*)
    Panel.Parent := sbPrefs;
    Panel.Align := alClient;
  end;
begin
  PanelList := TList.Create;
  Bitmap := TBitmap.Create;

  try
    if FileExists(BitmapName) then
      Bitmap.LoadFromFile(BitmapName);

    PanelIndex := 0;
    TmpPanel := GetPanel(PanelIndex);

    while Assigned(TmpPanel) do begin
      if (IsPanelShown(TmpPanel)) and (TmpPanel.Category = '') then
        PanelList.Add(TmpPanel);


      if (IsPanelShown(TmpPanel)) and (TmpPanel.Category = 'AustPayroll') then
        PanelList.Add(TmpPanel);

      Inc(PanelIndex);
      TmpPanel := GetPanel(PanelIndex);
    end;

    PanelIndex := 0;
    CurrentTop := 0;

    while PanelIndex < PanelList.Count do begin
      TmpPanel := TDNMPanel(PanelList[PanelIndex]);
      SetPanelProperties(TmpPanel);
      CurrentTop := CurrentTop + TmpPanel.Height;
      Inc(PanelIndex);
    end;
  finally
    FreeAndNil(PanelList);
    FreeAndNil(Bitmap);
  end;
end;

function TfrmEmployeePay.PopupSubform(sFormClassName: String): boolean;
begin
  REsult := false;
end;

procedure TfrmEmployeePay.PostIfDirty;
begin
  if Pay.Dirty then begin
    Pay.PostDb;
  end;
  if Pay.PayAllowances.Dirty then begin
    fbPayChangeOccured := True;
    Pay.PayAllowances.PostDb;
  end;  
  if Pay.PayPaysplits.Dirty then Pay.PayPaysplits.PostDb;

  if Assigned(Pay.PayBenefits) then begin
    if Pay.PayBenefits.Dirty then begin
      Pay.PayBenefits.PostDb;
      fbPayChangeOccured := True;
    end;
  end;

  if Pay.EmployeePaySettings.Dirty then Pay.EmployeePaySettings.PostDb;

  if Pay.PaySundries.Dirty then begin
    Pay.PaySundries.PostDb;
    fbPayChangeOccured := True;
  end;

  if Pay.PaysPayRates.Dirty then begin
    Pay.PaysPayRates.PostDb;
    fbPayChangeOccured := True;
  end;

  if Pay.PayDeductions.Dirty then begin
    Pay.PayDeductions.PostDb;
    fbPayChangeOccured := True;
  end;   

  if Pay.PayLeaves.Dirty then begin
    Pay.PayLeaves.PostDb;
    fbPayChangeOccured := True;
  end;

  if Pay.LeaveAccruals.Dirty then begin
    Pay.LeaveAccruals.PostDb;
    fbPayChangeOccured := True;
  end;

  if Pay.PayCommissions.Dirty then begin
    Pay.PayCommissions.Dataset.First;
    while not Pay.PayCommissions.Dataset.Eof do begin
      if not Pay.CommissionTypes.Dataset.Locate('CommissionDesc',Pay.PayCommissions.Commissiondesc,[loCaseInsensitive]) then begin
        Pay.CommissionTypes.New;
        Pay.CommissionTypes.Commissiondesc := Pay.PayCommissions.Commissiondesc;
        Pay.CommissionTypes.PostDb;
      end;
      Pay.PayCommissions.Commissionid := Pay.CommissionTypes.Id;
      Pay.PayCommissions.Dataset.Next;
    end;
    Pay.PayCommissions.PostDb;
    fbPayChangeOccured := True;
  end;  
end;

function TfrmEmployeePay.ValidateCurrentSubForm:boolean;
begin
  //VALIDATE FIELDS ON INDIVIDUAL FORMS so can force data entry before form change or Save
//Result := False;

//  if fSourceform.ClassName = 'TfrmPayBanking' then begin
//    with TfrmPayBanking(fSourceform).SubPay.PayPaySplits do begin
//      if TfrmPayBanking(fSourceform).SubPay.PayPaySplits.Dataset.RecordCount > 0 then
//        if not TfrmPayBanking(fSourceform).SubPay.PayPaySplits.ValidateSplits then exit;
//      DataSet.First;
//      while not Dataset.Eof do begin
//        if not TfrmPayBanking(fSourceform).SubPay.PayPaySplits.ValidateData then begin
//          TfrmPayBanking(fSourceform).HandlePayBankingErrors;
//          exit;
//        end;
//        Dataset.Next;
//      end;
//    end;
//  end;
//
//  if fSourceform.ClassName = 'TfrmPayAllowances' then begin
//    with TfrmPayAllowances(fSourceform).SubPay.PayAllowances do begin
//      DataSet.First;
//      while not Dataset.Eof do begin
//        if not ValidateData then begin
//          TfrmPayAllowances(fSourceform).HandlePayAllowanceErrors;
//          exit;
//        end;
//        Dataset.Next;
//      end;
//    end;
//  end;
//  if fSourceform.ClassName = 'TfrmPaySupers' then begin
//    with TfrmPaySupers(fSourceform).SubPay.PayBenefits do begin
//      Dataset.First;
//      while not Dataset.Eof do begin
//        if not ValidateData then begin
//          TfrmPayBenefits(fSourceform).HandleBenefitErrors;
//          exit;
//        end;
//        DataSet.Next;
//      end;
//    end;  
//  end;
//  if fSourceform.ClassName = 'TfrmPayHours' then begin
//    with TfrmPayHours(fSourceform).SubPay.PaysPayRates do begin
//      Dataset.First;
//      while not Dataset.Eof do begin
//        if not ValidateData then begin
//          TfrmPayHours(fSourceform).HandlePayHoursErrors;
//          exit;
//        end;
//        DataSet.Next;
//      end;
//    end;  
//  end;
//  if fSourceform.ClassName = 'TfrmPayDeductions' then begin
//    with TfrmPayDeductions(fSourceform).SubPay.PayDeductions do begin
//      Dataset.First;
//      while not Dataset.Eof do begin
//        if not ValidateData then begin
//          TfrmPayDeductions(fSourceform).HandlePayDeductionErrors;
//          exit;
//        end;
//        DataSet.Next;
//      end;
//    end;  
//  end;
//  if fSourceform.ClassName = 'TfrmPayLeaves' then begin
//    with TfrmPayLeaves(fSourceform).SubPay.PayLeaves do begin
//      Dataset.First;
//      while not Dataset.Eof do begin
//        if not ValidateData then begin
//          TfrmPayLeaves(fSourceform).HandlePayLeavesErrors;
//          exit;
//        end;
//        DataSet.Next;
//      end;
//    end;
//  end;
//  if fSourceform.ClassName = 'TfrmPayCommissions' then begin
//    with TfrmPayCommissions(fSourceform).SubPay.PayCommissions do begin
//      Dataset.First;
//      while not Dataset.Eof do begin
//        if not ValidateData then begin
//          TfrmPayCommissions(fSourceform).HandlePayCommissionErrors;
//          exit;
//        end;
//        DataSet.Next;
//      end;
//    end;
//  end;
//
//  if fSourceform.ClassName = 'TfrmPaySundries' then begin
//    with TfrmPaySundries(fSourceform).SubPay.PaySundries do begin
//      Dataset.First;
//      while not Dataset.Eof do begin
//        if not ValidateData then begin
//          TfrmPaySundries(fSourceform).HandlePaySundriesErrors;
//          exit;
//        end;
//        DataSet.Next;
//      end;
//    end;
//  end;

  Result := True;
end;
Procedure TfrmEmployeePay.ShowSubFormOnMainbuttonclick(Sender: TObject; sFormClassName:String);
begin
        sbPrefs.VertScrollBar.Visible := True;

        fSourceForm := TForm(GetComponentByClassName(sFormClassName));

        AppEnv.RegionalOptions.ChangeForm(fSourceForm);
        SetupConnections;

        SetupActiveFrmBusObjs;

        pnlActiveForm.Caption :=  Pay.Empname + ': ' + EnglishCaption(TDNMSpeedButton(Sender));
        LoadPanels;
        sbPrefs.Refresh;
        ImageScroll.Enabled := False;
        imgPrefs.Picture.Graphic := nil;
        ImageScroll.Enabled := True;
        SetScrollBarIncrement;
        PostMessage(fSourceForm.Handle, TX_PerformStartup, Handle, 0);
end;
procedure TfrmEmployeePay.MainButtonClick(Sender: TObject);
var
  s:String;
begin
  if Sender is TDNMSpeedButton then begin
    if not Sysutils.SameText( Pay.Empname + ': ' + EnglishCaption(TDNMSpeedButton(Sender)), pnlActiveForm.Caption) then begin
      Selectedbutton:= sender;
      PostIfDirty;
      if not ValidateCurrentSubForm then exit;

      s:= GetFormClassName(EnglishCaption(TDNMSpeedButton(Sender)));

      if not(PopupSubform(s)) then ClearScrollBox;

      if not fPreventFinish then begin
        ShowSubformOnMainbuttonclick(Sender , s);
      end
      else
        fPreventFinish := False;
    end;
  end;
end;

function TfrmEmployeePay.GetFormClassName(const ButtonCaption: string): string;
var
  Index: Integer;
begin
//  Index := 1;
  Index := 0;
  Result := '';

  while (Index <= cFormCount) and (Result = '') do begin
    if cButtonCaptions[Index] = ButtonCaption then
      Result := cFormClassNames[Index]
    else
      Inc(Index);
  end;
end;

procedure TfrmEmployeePay.ClearScrollBox;
var
  Index: Integer;
begin
  if Assigned(fSourceForm) then begin
     if not fPreventFinish then begin
      for Index := sbPrefs.ControlCount - 1 downto 0 do
        sbPrefs.Controls[Index].Parent := fSourceForm;

      fSourceForm.Release;
      fSourceForm := nil;
    end;
  end;
end;

procedure TfrmEmployeePay.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult in [mrNone, mrCancel] then begin
    inherited;
    ClearScrollBox;

    if fPreventFinish then begin
      fPreventFinish := False;
      Action := caNone;
    end
    else begin
      RollbackTransaction;

    if fsModal in FormState then
      ModalResult := mrCancel
    else
      Action := caFree;
    end;
  end;
  if Appenv.CompanyPrefs.USeSalesCommission then begin
    Appenv.CompanyPrefs.SalesCommissionCalcInProgress := False;
    Appenv.CompanyPrefs.SalesCommissionCalcEmployeeID :=0;
  end;
end;

procedure TfrmEmployeePay.btnOKClick(Sender: TObject);
begin
  inherited;
  If not Pay.Save then Exit;
  if not Pay.VerifyBanking then Exit;
  ClearScrollBox;

  if not fPreventFinish then begin
    CommitTransaction;
    Notify;
    if fsModal in FormState then
      ModalResult := mrOK
    else
      Release;
  end
  else
    fPreventFinish := False;
end;

procedure TfrmEmployeePay.ShowSubForm(const ButtonName:String; const FormIndex:integer);
var
  iFormIndex:Integer;
  i:Integer;
begin
  iFormIndex:= -1;
  if Assigned(fSourceForm) then
    for i := low(cButtonCaptions) to high(cButtonCaptions) do
      if Sysutils.SameText(cButtonCaptions[i] , ButtonName) then begin
         iFormIndex :=i;
         break;
      end;
    If cFormClassNames[iFormIndex]=fSourceForm.classname then Exit;

    ClearScrollBox;

    SetControlFocus(FindMainButton(ButtonName));

    if not fPreventFinish then begin
      sbPrefs.VertScrollBar.Visible := True;
      fSourceForm := TForm(GetComponentByClassName(cFormClassNames[iFormIndex]));

      if Assigned(fSourceForm) then begin
        AppEnv.RegionalOptions.ChangeForm(fSourceForm);
        SetupConnections;
        SetupActiveFrmBusObjs;

        pnlActiveForm.Caption := Pay.Empname + ': ' + ButtonName;
        LoadPanels;
        sbPrefs.Refresh;
        ImageScroll.Enabled := False;
        imgPrefs.Picture.Graphic := nil;
        ImageScroll.Enabled := True;
        SetScrollBarIncrement;
        PostMessage(fSourceForm.Handle, TX_PerformStartup, Handle, 0);
      end;
    end else  fPreventFinish := False;
end;

procedure TfrmEmployeePay.SetScrollBarIncrement;
begin
  if (sbPrefs.VertScrollBar.Range > 0) and (sbPrefs.VertScrollBar.Range < cMaxRange) then
    sbPrefs.VertScrollBar.Increment := cMaxRange div sbPrefs.VertScrollBar.Range
  else
    sbPrefs.VertScrollBar.Increment := 1;
end;

procedure TfrmEmployeePay.SetupConnections;
var
  Index: Integer;
begin
  if Assigned(fSourceForm) then begin
    for Index := 0 to fSourceForm.ComponentCount - 1 do begin
      if fSourceForm.Components[Index] is TERPQuery then begin
        TERPQuery(fSourceForm.Components[Index]).Connection := Self.MyConnection;
    //    TERPQuery(fSourceForm.Components[Index]).Open;
      end;
    end;
  end;
end;

procedure TfrmEmployeePay.BuildSearchList;
var
  Form: TForm;
  FormIndex: Integer;

  procedure AddCaptionsForForm(const Form: TForm; const FormID: string);
  var
    Index: Integer;
  begin
    for Index := 0 to Form.ComponentCount - 1 do begin
      if (Form.Components[Index] is TLabel) and (TLabel(Form.Components[Index]).Name <> 'lblWidth') and
         (not Sysutils.SameText(Copy(TLabel(Form.Components[Index]).Name, 1, 9), 'lblIgnore')) and
         IsPanelShown(TDNMPanel(TLabel(Form.Components[Index]).Parent)) then
        cboSearch.Items.Add(Trim(TLabel(Form.Components[Index]).Caption) + ' | ' + FormID)
      else if (Form.Components[Index] is TwwRadioGroup) and (Trim(TwwRadioGroup(Form.Components[Index]).Caption) <> '') and
              IsPanelShown(TDNMPanel(TwwRadioGroup(Form.Components[Index]).Parent)) then
        cboSearch.Items.Add(Trim(TwwRadioGroup(Form.Components[Index]).Caption) + ' | ' + FormID)
      else if (Form.Components[Index] is TDNMSpeedButton) and (Trim(TDNMSpeedButton(Form.Components[Index]).Caption) <> '') and
              IsPanelShown(TDNMPanel(TDNMSpeedButton(Form.Components[Index]).Parent)) then
        cboSearch.Items.Add(Trim(TDNMSpeedButton(Form.Components[Index]).Caption) + ' | ' + FormID);
    end;
  end;
begin
  cboSearch.Clear;

  if (SingleButtonCaption = '') or (AccessLevel = 1) then begin
    for FormIndex := 0 to cFormCount - 1 do begin
      Form := TForm(GetComponentByClassName(cFormClassNames[FormIndex]));

      try
        if Assigned(Form) then begin
        //  SetClassLabels(Form);
          AppEnv.RegionalOptions.ChangeForm(Form);
          AddCaptionsForForm(Form, cButtonCaptions[FormIndex]);
        end;
      finally
        FreeAndNil(Form);
      end;
    end;
  end
  else begin
    Form := TForm(GetComponentByClassName(GetFormClassName(SingleButtonCaption)));

    try
      if Assigned(Form) then begin
        //SetClassLabels(Form);
        AppEnv.RegionalOptions.ChangeForm(Form);
        AddCaptionsForForm(Form, SingleButtonCaption);
      end;
    finally
      FreeAndNil(Form);
    end;
  end;
end;

function TfrmEmployeePay.FindMainButton(const Caption: string): TDNMSpeedButton;
var
  Index: Integer;
  FoundButton: Boolean;
begin
  Index := 0;
  Result := nil;
  FoundButton := False;

  while (Index < ComponentCount) and (not FoundButton) do begin
    if (Components[Index] is TDNMSpeedButton) and (TDNMSpeedButton(Components[Index]).Caption = Caption) then begin
      Result := TDNMSpeedButton(Components[Index]);
      FoundButton := True;
    end
    else
      Inc(Index);
  end;
end;

procedure TfrmEmployeePay.cboSearchCloseUp(Sender: TwwDBComboBox; Select: Boolean);
begin
  inherited;
  Update;

  if not fPreventFinish then
    SearchForText(cboSearch.Text);
end;

procedure TfrmEmployeePay.AddButton(const ButtonCaption: string; const ButtonTop: Integer);
var
  Button: TDNMSpeedButton;
begin
  Button := TDNMSpeedButton.Create(Self);

  with Button do begin
    Left := cMainButtonLeft;
    Top := ButtonTop;
    Width := cMainButtonWidth;
    Height := cMainButtonHeight;
    Caption := ButtonCaption;
    Parent := pnlButtons;
    Alignment := taCenter;
    Color := clWhite;
    HotTrackColor := clBtnShadow;
    SlowDecease := True;
    Style := bsModern;
    OnClick := MainButtonClick;
    inc(ButtonCtr);
    name := 'mainbutton'+inttostr(ButtonCtr);
  end;
end;

procedure TfrmEmployeePay.SearchForText(const SearchStr: string; const FocusControlName: string = '');
var
  ControlIndex: Integer;
  PanelIndex: Integer;
  FoundControl: Boolean;
  Panel: TPanel;
  ControlTop: Integer;
  ControlHeight: Integer;
  MainButton: TDNMSpeedButton;
  NewPosition: Integer;
  IndexOfText: Integer;
  ControlCaption: string;
  SearchText: string;
  DelimiterPos: Integer;
  TmpControl: TWinControl;
begin
  IndexOfText := cboSearch.Items.IndexOf(SearchStr);

  if IndexOfText >= 0 then begin
    DelimiterPos := FastFuncs.PosEx('|', SearchStr);
    SearchText := Copy(SearchStr, 1, DelimiterPos - 2);

    with cboSearch do
      MainButton := FindMainButton(Copy(SearchStr, DelimiterPos + 2, char_length(SearchStr) - DelimiterPos - 1));

    if Assigned(MainButton) then
      MainButton.Click;

    PanelIndex := 0;
    FoundControl := False;
    ImageScroll.PerformScroll(0);

    while (PanelIndex < sbPrefs.ControlCount) and (not FoundControl) do begin
      Panel := TPanel(sbPrefs.Controls[PanelIndex]);
      ControlIndex := 0;

      while (ControlIndex < Panel.ControlCount) and (not FoundControl) do begin
        if Panel.Controls[ControlIndex] is TLabel then
          ControlCaption := Trim(TLabel(Panel.Controls[ControlIndex]).Caption)
        else if Panel.Controls[ControlIndex] is TwwRadioGroup then
          ControlCaption := Trim(TwwRadioGroup(Panel.Controls[ControlIndex]).Caption)
        else if Panel.Controls[ControlIndex] is TDNMSpeedButton then
          ControlCaption := Trim(TDNMSpeedButton(Panel.Controls[ControlIndex]).Caption)
        else
          ControlCaption := '';

        if ControlCaption <> '' then begin
          if Sysutils.SameText(ControlCaption, SearchText) then begin
            ControlTop := Panel.Top + Panel.Controls[ControlIndex].Top;
            ControlHeight := Panel.Controls[ControlIndex].Height;
            NewPosition := System.Round((ControlTop - ((sbPrefs.ClientHeight - ControlHeight) / 2)) / ImageScrollHeightFactor(ImageScroll));

            if NewPosition > imgPrefs.ClientHeight then
              ImageScroll.PerformScroll(imgPrefs.ClientHeight)
            else if NewPosition > 0 then
              ImageScroll.PerformScroll(NewPosition);

            FoundControl := True;
          end
          else
            Inc(ControlIndex);
        end
        else
          Inc(ControlIndex);
      end;

      Inc(PanelIndex);
    end;

    if FoundControl and (FocusControlName <> '') then begin
      TmpControl := TWinControl(fSourceForm.FindComponent(FocusControlName));

      if Assigned(TmpControl) then
        SetControlFocus(TmpControl);
    end;
  end;
end;

procedure TfrmEmployeePay.PerformTextSearch(var Msg: TMessage);
begin
  SearchForText('Default Accounts Receivables Account | Sales', 'cboDefaultSales');
end;

procedure TfrmEmployeePay.CancelFinish(var Msg: TMessage);
begin
  fPreventFinish := True;
end;

function TfrmEmployeePay.IsPanelShown(const Panel: TDNMPanel): Boolean;
begin
  Result := True;
end;

procedure TfrmEmployeePay.btnEmployerNICsClick(Sender: TObject);
begin
  inherited;
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

procedure TfrmEmployeePay.TaxPayChange(Sender: TObject);
begin
  inherited;
  if TDBEdit(Sender).ReadOnly then
    exit;
  if Assigned(fSourceForm) and (fSourceForm is TfrmPayTax) then
    TfrmPayTax(fSourceForm).qryTaxList.Refresh;
end;

procedure TfrmEmployeePay.TaxPayEnter(Sender: TObject);
begin
  inherited;
  TaxPay.readonly :=
  TwwCheckBox(chkManualTax).DataSource.DataSet.FieldByName(TwwCheckBox(chkManualTax).DataField).AsString ='F';
end;

procedure TfrmEmployeePay.Timer1Timer(Sender: TObject);
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

procedure TfrmEmployeePay.Timer2Timer(Sender: TObject);
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

  if fsToggleNICs = 'Employee' then begin
    pnlEmployer.Hide;
    pnlEmployer.Top := pnlEmployer.Top + 2;
    pnlEmployer.Show;
  end else begin
    pnlEmployee.Hide;
    pnlEmployee.Top := pnlEmployee.Top + 2;
    pnlEmployee.Show;
  end;

end;

procedure TfrmEmployeePay.chkDeletedClick(Sender: TObject);
var
  bWasDeleted,bWasFirstPay:boolean;
  FatalStatusItem: TResultStatusItem;
  msg: string;
  aID: integer;
begin
  if self.ActiveControl <> Sender then
    exit;
  inherited;
    bWasDeleted := Pay.Deleted;
    if Pay.Paydate = Pay.EmployeePaySettings.FirstPayDate then bWasFirstPay := True else bWasFirstPay := False;

    //This is a work around to force the check box to behave as it should ///////////////////
    if not TwwCheckBox(Sender).DataSource.DataSet.Active then Exit;
    TwwCheckBox(Sender).DataSource.DataSet.Edit;
    if TwwCheckBox(Sender).Checked then TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'T'
    else TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'F';
    qryPays.edit;
       //////////////////////////////////////////////////////////////////////////////////////////

    aID := Pay.PayRunID;
    if bWasDeleted = False then begin
      if (CommonLib.MessageDlgXP_Vista('Are You Sure You Wish To DELETE This Pay ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
        Pay.DeletePay;
        Pay.Save;
        if BusObjPayRun.TPayRun.DeletePayInRun(aID,Pay.Connection.Connection,msg) then begin
          CommitTransaction;  //because if user click 'Cancel' there is a rollback
        end
        else begin
          CommonLib.MessageDlgXP_Vista('Unable to remove deleted pay from PayRun: ' + msg, mtInformation, [mbOk], 0);
          self.RollbackTransaction;
          BeginTransaction;
          Pay.Load(Pay.ID);
          exit;
        end;

        if bWasFirstPay then begin
          PayUtils.CreateNewPay(Pay.EmployeeDetails.Id,True,False, FatalStatusItem);
        end;
        Close;
      end else begin
        Pay.Deleted := False;
      end;
    end else
      if (CommonLib.MessageDlgXP_Vista('Are You Sure You Wish To UNDelete This Pay ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes) then begin
        Pay.UnDeletePay;
        Pay.Save;
        if BusObjPayRun.TPayRun.AddPayToRun(aID,Pay.Connection.Connection,msg) then begin
          CommitTransaction;  //because if user click 'Cancel' there is a rollback
          BeginTransaction;
        end
        else begin
          CommonLib.MessageDlgXP_Vista('Unable to add pay from PayRun: ' + msg, mtInformation, [mbOk], 0);
          self.RollbackTransaction;
          BeginTransaction;
          Pay.Load(Pay.ID);
          exit;
        end;
      end;
end;
function TfrmEmployeePay.GetReportTypeID: integer;
begin
  Result := 68;
end;

procedure TfrmEmployeePay.btnPrintPayslipClick(Sender: TObject);
var
// bDebug:Boolean;
  saveNotes: string;
  sSQL:String;
const
  UNPROCESSED_PAY_WARN = 'UNPROCESSED PAY: PREVIEW PAY SLIP ONLY';
begin
  DisableForm;
  saveNotes:= Pay.Paynotes;
  try
    inherited;
    if not Pay.Paid  then begin
      if Pos(UNPROCESSED_PAY_WARN,Pay.Paynotes) < 1 then begin
        if Pay.Paynotes <> '' then Pay.Paynotes:= Pay.Paynotes + '  ';
        Pay.Paynotes:= Pay.Paynotes + 'UNPROCESSED PAY:PREVIEW PAY SLIP ONLY';
      end;
    end;
    Pay.Save;

    sSQL:= PayUtils.PrintPaySlipSQL(Pay);
    if devmode then begin
      LoadReportTypes;
      if dlgReportSelect.Execute then
        ReportToPrint := trim(dlgReportSelect.SelectedItems.Text);
    end else begin
      ReportToPrint := tcdatautils.GetDefaultReport(68);
    end;

    fbReportSQLSupplied := True;
    if (Pay.EmployeeDetails.Sendpayslipviaemail = 'F')
       or (Pay.EmployeeDetails.SendPaySlipViaEmail = 'B') then begin
        PrintTemplateReport(ReportToPrint, sSQL, not(AppEnv.Employee.ShowPreview), 1 , );
    end;
    if (Pay.EmployeeDetails.Sendpayslipviaemail = 'T')
       or (Pay.EmployeeDetails.SendPaySlipViaEmail = 'B') then begin
        if (not empty(Pay.EmployeeDetails.Email)) then begin
          EmailReport(Pay.Id,Pay.EmployeeDetails.Employeename ,Pay.EmployeeDetails.Email , ReportToPrint , ReportToPrint , sSQL , True , False);
        end;
    end;
  finally
    if Pay.Paynotes <> saveNotes then
      Pay.Paynotes:= saveNotes;
    EnableForm;
  end;  
end;

procedure TfrmEmployeePay.PayDateCloseUp(Sender: TObject);
begin
  inherited;
  DatePaid.Date := PayDate.Date + 2; //arbitary value by Dene cause everyone is taking this as when they will actually see the money.

  //if redoing an old pay reset LastPay
  Pay.EmployeePaySettings.LastPaid := PayDate.Date; {will use this when modifying pay from employee card}
  Pay.EmployeePaySettings.Save;
end;
procedure TfrmEmployeePay.btnABAClick(Sender: TObject);
var
  ABAObj: TABAObj;
begin
  DisableForm;
  try
    inherited;
    if fEFTDone then begin
      CommonLib.MessageDlgXP_Vista('EFT payment has already been created for this Pay.', mtInformation, [mbOK], 0);
      exit;
    end;

    ABAObj := TABAObj.Create;
    try
      if Pay.PayPaysplits.Dataset.RecordCount < 1 then begin
        CommonLib.MessageDlgXP_Vista('There was no Bank set up for this Pay.', mtInformation, [mbOK], 0);
      end else begin
        if ABAObj.HasValidEFTEmployeeAccountInfo(Pay.PayID) then begin
          ABAObj.AddABADetailsRecord(Pay.EmployeeDetails.Id,Pay.PayPaysplits.DataSet,
            PayAccounts.BankAccountID(PAy.Employeeid),Pay.Net,Pay.PayID,'Pay');

          CommonLib.MessageDlgXP_Vista('EFT Payment Created for this Pay.', mtInformation, [mbOK], 0);
        end else begin
          CommonLib.MessageDlgXP_Vista('EFT ERROR: Employee has Invalid Bank Details.',
            mtWarning, [mbOK], 0);
        end;
      end;
    finally
      ABAObj.Free;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TfrmEmployeePay.chkManualTaxClick(Sender: TObject);
begin
  inherited;
  if not TwwCheckBox(Sender).DataSource.DataSet.Active then Exit;
  TwwCheckBox(Sender).DataSource.DataSet.Edit;
  if TwwCheckBox(Sender).Checked then
    TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'T'
  else
    TwwCheckBox(Sender).DataSource.DataSet.FieldByName(TwwCheckBox(Sender).DataField).AsString := 'F';
end;

procedure TfrmEmployeePay.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited;
  if (Eventtype = BusObjEvent_Change) then begin
    if (Value = BusObjEventVal_Pay_ManualTax) then begin
      if Sender is Tpaybase then
        If Tpaybase(Sender)=Self.Pay then
          TaxPay.ReadOnly := not Self.Pay.ManualTax;
      exit;
    end
    else if (Value = BusObjEventVal_BankSplitsError) then begin
      CommonLib.MessageDlgXP_Vista('The Banking split amounts are greater than the net pay.', mtWarning, [mbOK], 0);
    end
    else if (Value = BusobjEventVal_HandleNoAllowanceBasedOn) then begin
      if fSourceForm is TfrmPayAllowances then begin
        CommonLib.MessageDlgXP_Vista('There are no pay rates of this type, in this pay to base the percentage on.', mtWarning, [mbOK], 0);
        SetControlFocus(TfrmPayAllowances(fSourceForm).AllowBasedOn);
      end;
    end
    else if Value  = BusObjEventVal_Pay_TaxAllowanceQty then begin

    end;
  end;

  If (Value = BusobjEventVal_FailedAllowancesValidateData) then Begin
    ShowSubForm('Allowances',0);
    TfrmPayAllowances(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedBankingValidateData) then Begin
    ShowSubForm('Banking',1);
    TfrmPayBanking(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedCommissionValidateData) or (Value = BusObjEvent_TotalsChanged)  then Begin
    ShowSubForm('Commissions',2);
    TfrmPayCommissions(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedDeductionsValidateData) then Begin
    ShowSubForm('Deductions',3);
    TfrmPayDeductions(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedHoursValidateData) then Begin
    ShowSubForm('Hours',4);
    TfrmPayHours(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedLeavesValidateData) then Begin
    ShowSubForm('Leave Taken',5);
    TfrmPayLeaves(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedPay_NotesValidateData) then Begin
    ShowSubForm('Notes',6);
    TfrmPayNotes(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedSundriesValidateData) then Begin
    ShowSubForm('Sundries',7);
    TfrmPaySundries(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedSuperannuationValidateData) then Begin
    ShowSubForm('Superannuation',8);
    TfrmPaySupers(fSourceForm).DoBusinessObjectEvent(Sender,EventType,Value);
  end else If (Value = BusobjEventVal_FailedEmployeePayValidateData) then Begin
    Self.DoBusinessObjectEvent(Sender,EventType,Value);
  end
  else if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
    if Sender is TTerminationSimple then
      TTerminationSimple(Sender).DataSet:= qryTermination;
  end


end;

procedure TfrmEmployeePay.DoPanelBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  if Value = BusobjEventVal_FailedEmployeePayValidateData then begin
    HandleEmpPayFormErrors;
  end;
end;

procedure TfrmEmployeePay.HandleEmpPayFormErrors;
var
  FatalStatusItem: TResultStatusItem;
begin
  if not Assigned(Pay) then exit;
  FatalStatusItem := Pay.ResultStatus.GetLastFatalStatusItem;
  if Assigned(FatalStatusItem) then begin
    case FatalStatusItem.Code of
      BOR_EmployeePay_Err_NoPaydate :  begin
                                        SetControlFocus(PayDate);
                                       end;
      BOR_EmployeePay_Err_NoPayPeriods :  begin
                                            SetControlFocus(PayPeriods);
                                          end;     

    end;
  end;
end;

procedure TfrmEmployeePay.btnLoadTimesheetClick(Sender: TObject);
var
  iResult:integer;
  frmApprovedPopUp,tmpComponent:TComponent;
  i:integer;
begin
  DisableForm;
  try
    inherited;

    if Pay.TimeSheet.Count < 1 then begin
      CommonLib.MessageDlgXP_Vista('This employee has no timesheet entries for this pay.', mtInformation, [mbOK], 0);
      exit;
    end;

    iResult := CommonLib.MessageDlgXP_Vista('Would you like to verify the timesheet entries now before loading into pay?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
    if iResult = mrCancel then
      Exit;
    if (iResult = mrYes) or (iResult = mrNo) then begin
      if FormStillOpen('TfrmActionApproved') then begin
        TForm(FindExistingComponent('TfrmActionApproved')).BringToFront;
      end else begin
        frmApprovedPopUp := GetComponentByClassName('TfrmActionApproved');
        if Assigned(frmApprovedPopUp) then begin
          with TfrmActionApproved(frmApprovedPopUp) do begin
            lblAction.Caption := 'Load Timesheet.';
            ActionType := 'Load Timesheet';
            if ShowModal = mrOk then begin
              if not IsAccessAllowed('TfrmTimeSheet', AuthorisingEmpID) then begin
                CommonLib.MessageDlgXP_Vista('You do not have access permission for the Timesheet.', mtInformation, [mbOK], 0);
                Exit;
              end;

              if iResult = mrYes then begin
                Pay.TimeSheet.First;
                for i := 0 to Pay.TimeSheet.Count - 1 do begin
                  tmpComponent := GetComponentByClassName('TfrmTimeSheet');
                  if Assigned(tmpComponent) then begin
                    with TfrmTimeSheet(tmpComponent) do begin
                      Position := poDefault;
                      FormStyle := fsNormal;
                      CallingClassName := 'TfrmEmployeePay';
                      KeyID := Pay.TimeSheet.TimesheetEntryID;
                      if ShowModal = mrCancel then
                        Exit;
                    end;
                  end;
                  Pay.TimeSheet.Next;
                end;
              end;
              Processingcursor(True);
              try
                PayUtils.LoadTimeSheet(Pay);
              finally
                Processingcursor(False);
              end;

              try
                frmApprovedPopUp := GetComponentByClassName('TfrmActionApproved');
                if Assigned(frmApprovedPopUp) then begin
                  TfrmActionApproved(frmApprovedPopUp).SetActionSuccess('T');
                end;
              finally
                TfrmActionApproved(frmApprovedPopUp).Release;
              end;
              CommonLib.MessageDlgXP_Vista('Timesheet loaded.', mtInformation, [mbOK], 0);
            end;
          end;
        end;
      end;
    end;
    /////////
  //  Processingcursor(True);
  //  try
  //    PayUtils.LoadTimeSheet(Pay);
  //    CommonLib.MessageDlgXP_Vista('Timesheet loaded.', mtInformation, [mbOK], 0);
  //  finally
  //    Processingcursor(False);
  //  end;
  finally
    EnableForm;
  end;
end;

function TfrmEmployeePay.IsAccessAllowed(const sFnName: string; const iEmployeeID: integer = 0): boolean;
begin
  if AppEnv.AccessLevels.GetEmployeeAccessLevel(sFnName, iEmployeeID) <> ACCESS_ALLOWED then begin
    Result := false;
  end else
    Result := true;
end;

function TfrmEmployeePay.batchUpdateDetails: String;
begin
  result := SalesCommissionbatchUpdateDetails;
(*var
  strSQL:String;
begin
  strSQL:= 'select  SC.CommissionCalculatedOn ,' +
      ' concat_ws(" " , `E`.`FirstName`,`E`.`MiddleName`,`E`.`LastName`) as EmployeeName  '+
      ' from tblsalescommissionupdates SC '+
      ' inner join tblEmployees e on E.employeeId = SC.EmployeeId ' +
      ' Order by CommissionCalculatedOn desc Limit 1';
  With TempMyQuery do try
    SQL.add(StrSQL);
    open;
    result := '     -     Sales Commission Last Updated on '  +
            FieldByname('CommissionCalculatedOn').asString  +
            ' by ' +fieldbyname('EmployeeName').asString;
  finally
      if active then close;
      Free;
  end;*)
end;

procedure TfrmEmployeePay.btnUpdateBatchClick(Sender: TObject);
begin
  inherited;
  if Appenv.CompanyPrefs.UseSalesCommission then begin
      TfmSalesCommission.Updatesalescommission(0,0,true);
      Self.Caption := 'Employee Pay    -    '+batchUpdateDetails;
  end;
end;

procedure TfrmEmployeePay.qryBankCodesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
   TERPQuery(Dataset).Params.ParamByName('XRegionID').AsInteger := AppEnv.RegionalOptions.ID;
end;

procedure TfrmEmployeePay.qryPayCommissionsAfterPost(DataSet: TDataSet);
begin
  inherited;
  if Trim(qryPayCommissionsCommissionDesc.AsString) = '' then
    Dataset.Delete;

end;

procedure TfrmEmployeePay.qryTerminationAfterOpen(DataSet: TDataSet);
begin
  inherited;
  TFloatField(qryTermination.FieldByName('LumpSumD')).currency := true;
end;

initialization
  RegisterClassOnce(TfrmEmployeePay);

  FormFact.RegisterMe(TfrmEmployeePay, 'TfrmPaySummary_*=PayID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TPayListingGUI_*=PayID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TRateandLeaveAccrualsGUI_*=PayID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TWagesJournalReportGUI_*=PayID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TLeaveListGUI_*=PayID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TfrmSuperFundListGUI_*=PayID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TPayJobListGUI_*=PayID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TTransAccountDetailsGUI_*_Payroll Superannuation=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TTransAccountDetailsGUI_*_Payroll Accrued Leave=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TTransAccountDetailsGUI_*_Payroll Leave Taken=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TTransAccountDetailsGUI_*_Payroll Deduction=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TTransAccountDetailsGUI_*_Payroll Sundry=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TTransAccountDetailsGUI_*_Payroll Allowance=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TTransAccountDetailsGUI_*_Payroll Pays=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TTransAccountDetailsGUI_*_Payroll PAYG=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TTransAccountDetailsGUI_*_Payroll PAYG Tax=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TTransAccountDetailsGUI_*_Payroll Net Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TTransAccountDetailsGUI_*_Payroll Gross Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TTransAccountDetailsGUI_*_Payroll Nett Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TTransactionListGUI_*_Payroll Superannuation=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBASTransReturnListGUI_*_Payroll Superannuation=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TNZTransReturnListGUI_*_Payroll Superannuation=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TVATTransReturnListGUI_*_Payroll Superannuation=SaleID');

  FormFact.RegisterMe(TfrmEmployeePay, 'TTransactionListGUI_*_Payroll Accrued Leave=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBASTransReturnListGUI_*_Payroll Accrued Leave=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TNZTransReturnListGUI_*_Payroll Accrued Leave=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TVATTransReturnListGUI_*_Payroll Accrued Leave=SaleID');

  FormFact.RegisterMe(TfrmEmployeePay, 'TTransactionListGUI_*_Payroll Leave Taken=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBASTransReturnListGUI_*_Payroll Leave Taken=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TNZTransReturnListGUI_*_Payroll Leave Taken=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TVATTransReturnListGUI_*_Payroll Leave Taken=SaleID');

  FormFact.RegisterMe(TfrmEmployeePay, 'TTransactionListGUI_*_Payroll Deduction=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBASTransReturnListGUI_*_Payroll Deduction=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TNZTransReturnListGUI_*_Payroll Deduction=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TVATTransReturnListGUI_*_Payroll Deduction=SaleID');

  FormFact.RegisterMe(TfrmEmployeePay, 'TTransactionListGUI_*_Payroll Sundry=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBASTransReturnListGUI_*_Payroll Sundry=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TNZTransReturnListGUI_*_Payroll Sundry=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TVATTransReturnListGUI_*_Payroll Sundry=SaleID');

  FormFact.RegisterMe(TfrmEmployeePay, 'TTransactionListGUI_*_Payroll Allowance=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBASTransReturnListGUI_*_Payroll Allowance=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TNZTransReturnListGUI_*_Payroll Allowance=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TVATTransReturnListGUI_*_Payroll Allowance=SaleID');

  FormFact.RegisterMe(TfrmEmployeePay, 'TTransactionListGUI_*_Payroll Pays=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBASTransReturnListGUI_*_Payroll Pays=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TNZTransReturnListGUI_*_Payroll Pays=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TVATTransReturnListGUI_*_Payroll Pays=SaleID');

  FormFact.RegisterMe(TfrmEmployeePay, 'TTransactionListGUI_*_Payroll PAYG=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBASTransReturnListGUI_*_Payroll PAYG=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TNZTransReturnListGUI_*_Payroll PAYG=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TVATTransReturnListGUI_*_Payroll PAYG=SaleID');

  FormFact.RegisterMe(TfrmEmployeePay, 'TTransactionListGUI_*_Payroll Net Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBASTransReturnListGUI_*_Payroll Net Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TNZTransReturnListGUI_*_Payroll Net Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TVATTransReturnListGUI_*_Payroll Net Wages=SaleID');

  FormFact.RegisterMe(TfrmEmployeePay, 'TTransactionListGUI_*_Payroll Gross Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBASTransReturnListGUI_*_Payroll Gross Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TNZTransReturnListGUI_*_Payroll Gross Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TVATTransReturnListGUI_*_Payroll Gross Wages=SaleID');

  FormFact.RegisterMe(TfrmEmployeePay, 'TGlobalsearchGUI_*_Payroll Superannuation=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TGlobalsearchGUI_*_Payroll Accrued Leave=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TGlobalsearchGUI_*_Payroll Leave Taken=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TGlobalsearchGUI_*_Payroll Deduction=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TGlobalsearchGUI_*_Payroll Sundry=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TGlobalsearchGUI_*_Payroll Allowance=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TGlobalsearchGUI_*_Payroll Pays=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TGlobalsearchGUI_*_Payroll PAYG=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TGlobalsearchGUI_*_Payroll Net Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TGlobalsearchGUI_*_Payroll Gross Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBankAccountListGUI_Type_Payroll Net Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBankAccountListGUI_Type_Payroll Gross Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBankAccountListGUI_Type_Payroll PAYG=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBalTransListGUI_*_Payroll Superannuation=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBalTransListGUI_*_Payroll Accrued Leave=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBalTransListGUI_*_Payroll Leave Taken=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBalTransListGUI_*_Payroll Deduction=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBalTransListGUI_*_Payroll Sundry=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBalTransListGUI_*_Payroll Allowance=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBalTransListGUI_*_Payroll Pays=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBalTransListGUI_*_Payroll PAYG=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBalTransListGUI_*_Payroll Net Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBalTransListGUI_*_Payroll Gross Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TToBeReconciledGUI_*_Payroll Superannuation=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TToBeReconciledGUI_*_Payroll Accrued Leave=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TToBeReconciledGUI_*_Payroll Leave Taken=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TToBeReconciledGUI_*_Payroll Deduction=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TToBeReconciledGUI_*_Payroll Sundry=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TToBeReconciledGUI_*_Payroll Allowance=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TToBeReconciledGUI_*_Payroll Pays=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TToBeReconciledGUI_*_Payroll PAYG=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TToBeReconciledGUI_*_Payroll Net Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TToBeReconciledGUI_*_Payroll Gross Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TReconListDetailFormGUI_*_Payroll Superannuation=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TReconListDetailFormGUI_*_Payroll Accrued Leave=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TReconListDetailFormGUI_*_Payroll Leave Taken=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TReconListDetailFormGUI_*_Payroll Deduction=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TReconListDetailFormGUI_*_Payroll Sundry=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TReconListDetailFormGUI_*_Payroll Allowance=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TReconListDetailFormGUI_*_Payroll Pays=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TReconListDetailFormGUI_*_Payroll PAYG=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TReconListDetailFormGUI_*_Payroll Net Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TReconListDetailFormGUI_*_Payroll Gross Wages=SaleID');
  FormFact.RegisterMe(TfrmEmployeePay, 'TLeaveAccruedDetailsListGUI_*=PayNo');
  FormFact.RegisterMe(TfrmEmployeePay, 'TBankAccountListGUI_*_Payroll Nett Wages=SaleID');


finalization
  UnregisterClass(TfrmEmployeePay);
end.




