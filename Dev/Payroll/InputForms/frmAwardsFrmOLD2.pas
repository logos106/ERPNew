unit frmAwardsFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, DB, ExtCtrls, DNMPanel,
  ComCtrls, StdCtrls, DBCtrls, Mask, dbcgrids, wwdblook,
  wwdbdatetimepicker, AppEvnts, DateUtils, StrUtils,
  Wwdbigrd, Grids, Wwdbgrid, wwdbedit, Wwdotdot, Wwdbcomb, Buttons, DNMSpeedButton,
  Wwdbspin, SelectionDialog,  kbmMemTable, MyAccess, DBAccess,
  wwcheckbox, DataState, Menus, AdvMenus, MemDS,BusObjAwards;

const
  AWARD_DEFAULT       = 'Default';
  AWARD_CLASS_DEFAULT = 'Standard';

type
  TfrmAwards = class(TBaseInputGUI)
    PageControl1: TPageControl;
    Standard: TTabSheet;
    AwardPayment: TTabSheet;
    Timesheet: TTabSheet;
    DNMPanel1: TDNMPanel;
    DNMPanel2: TDNMPanel;
    DNMPanel3: TDNMPanel;
    DBMemo1: TDBMemo;
    Label143: TLabel;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    DSAwards: TDataSource;
    qryDepartments: TMyQuery;
    AwardName: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    PayPeriod: TDBComboBox;
    Label3: TLabel;
    SuperType: TDBComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DSLeave: TDataSource;
    DSClassificationDetails: TDataSource;
    qryAwardAdvance: TMyQuery;
    DSAllowances: TDataSource;
    qryBasedOn: TMyQuery;
    qryPayRateType: TMyQuery;
    DSShifts: TDataSource;
    grdLeave: TwwDBGrid;
    wwDBGrid1IButton: TwwIButton;
    grdClassification: TwwDBGrid;
    wwDBGrid2IButton: TwwIButton;
    AccrueAfterPeriod: TwwDBComboBox;
    AccruePeriod: TwwDBComboBox;
    grdTimesheet: TwwDBGrid;
    wwDBGrid3IButton: TwwIButton;
    StartDay: TwwDBComboBox;
    EndDay: TwwDBComboBox;
    PayRate: TwwDBLookupCombo;
    qryPayRates: TMyQuery;
    qryPayRatesRateID: TAutoIncField;
    qryPayRatesDescription: TStringField;
    qryPayRatesMultiplier: TFloatField;
    PayRate1: TwwDBLookupCombo;
    PayRate2: TwwDBLookupCombo;
    qryAllowances: TMyQuery;
    EndTimePicker: TwwDBDateTimePicker;
    qryAwardLeave: TMyQuery;
    qryExtraPayRates: TMyQuery;
    btnNew: TDNMSpeedButton;
    edClassification: TwwDBEdit;
    qryAwardLeaveGlobalRef: TStringField;
    qryAwardLeaveLeaveID: TAutoIncField;
    qryAwardLeaveAwardID: TIntegerField;
    qryAwardLeaveType: TStringField;
    qryAwardLeaveAccrueAfterNo: TFloatField;
    qryAwardLeaveAccrueAfterPeriod: TStringField;
    qryAwardLeaveAccrueNo: TFloatField;
    qryAwardLeaveAccruePeriod: TStringField;
    qryAwardLeaveAccrueHours: TFloatField;
    qryAwardLeaveEditedFlag: TStringField;
    qryawardclassificationdetails: TMyQuery;
    qryawardclassificationdetailsGlobalRef: TStringField;
    qryawardclassificationdetailsClassificationID: TAutoIncField;
    qryawardclassificationdetailsAwardID: TIntegerField;
    qryawardclassificationdetailsClassification: TStringField;
    qryawardclassificationdetailsType: TStringField;
    qryawardclassificationdetailsFullTime: TFloatField;
    qryawardclassificationdetailsPartTime: TFloatField;
    qryawardclassificationdetailsCasual: TFloatField;
    qryawardclassificationdetailsCasualLoading: TFloatField;
    qryawardclassificationdetailsAdvanceID: TIntegerField;
    qryawardclassificationdetailsFTHourlyRate: TFloatField;
    qryawardclassificationdetailsPTHourlyRate: TFloatField;
    qryawardclassificationdetailsCHourlyRate: TFloatField;
    qryawardclassificationdetailsEditedFlag: TStringField;
    cboAdvanceID: TwwDBLookupCombo;
    qryAwardAdvanceAdvanceID: TAutoIncField;
    qryAwardAdvanceDescription: TStringField;
    qryAllowancesAllowanceID: TAutoIncField;
    qryAllowancesDescription: TStringField;
    qryAllowancesSuperInc: TStringField;
    qryAllowancesTaxExempt: TStringField;
    qryAllowancesPayrollTaxExempt: TStringField;
    qryAllowancesWorkcoverExempt: TStringField;
    qryAllowancesDisplayIn: TStringField;
    qryAllowancesAmount: TFloatField;
    qryAllowancesBasedOnID: TIntegerField;
    qryAllowancesActive: TStringField;
    qryLimitedPayRates: TMyQuery;
    qryPayRatesOnly: TMyQuery;
    cboDepartment: TwwDBLookupCombo;
    SuperValue: TwwDBEdit;
    Loading: TwwDBEdit;
    qryClassificationDeductions: TMyQuery;
    qryClassificationDeductionsGlobalRef: TStringField;
    qryClassificationDeductionsDeductionID: TIntegerField;
    qryClassificationDeductionsClassificationID: TIntegerField;
    qryClassificationDeductionsDeductID: TIntegerField;
    qryClassificationDeductionsAmount: TFloatField;
    qryClassificationDeductionsBasedOnID: TIntegerField;
    qryClassificationDeductionsEditedFlag: TStringField;
    qryClassificationDeductionsAwardID: TIntegerField;
    dsClassDeductions: TDataSource;
    qryDeductions: TMyQuery;
    qryDeductionsDescription: TStringField;
    qryDeductionsGlobalRef: TStringField;
    qryDeductionsDeductionID: TAutoIncField;
    qryDeductionsTaxExempt: TStringField;
    qryDeductionsUnionFees: TStringField;
    qryDeductionsEditedFlag: TStringField;
    qryDeductionsActive: TStringField;
    qryClassificationDeductionsDeductionLookup: TStringField;
    qryClassificationDeductionsBasedOnLookup: TStringField;
    qryDeductionsDisplayIn: TStringField;
    qryDeductionsAmount: TFloatField;
    qryDeductionsBasedOnID: TIntegerField;
    qryClassificationDeductionsCalcBy: TStringField;
    qryAllowancesCalcBy: TStringField;
    qryDeductionsCalcBy: TStringField;
    qryclassificationallowances: TMyQuery;
    qryclassificationallowancesGlobalRef: TStringField;
    qryclassificationallowancesAllowanceID: TAutoIncField;
    qryclassificationallowancesClassificationID: TIntegerField;
    qryclassificationallowancesAllowID: TIntegerField;
    qryclassificationallowancesAmount: TFloatField;
    qryclassificationallowancesCalcBy: TStringField;
    qryclassificationallowancesBasedOnID: TIntegerField;
    qryclassificationallowancesEditedFlag: TStringField;
    qryclassificationallowancesAwardID: TIntegerField;
    qryclassificationallowanceslookupAllowance: TStringField;
    qryclassificationallowanceslookupBasedOn: TStringField;
    ClassificationType: TwwDBLookupCombo;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label7: TLabel;
    wwDBEdit1: TwwDBEdit;
    Label8: TLabel;
    wwDBEdit2: TwwDBEdit;
    cboLeave: TwwDBLookupCombo;
    qryLeaveTypes: TMyQuery;
    tblAwards: TMyQuery;
    tblAwardsAwardID: TAutoIncField;
    tblAwardsAwardName: TStringField;
    tblAwardsClassID: TIntegerField;
    tblAwardsPayPeriod: TStringField;
    tblAwardsSuperType: TStringField;
    tblAwardsAnnualLeaveLoading: TFloatField;
    tblAwardsActive: TStringField;
    tblAwardsEditedFlag: TStringField;
    tblAwardsSuperValue: TFloatField;
    tblAwardsMealBreakHours: TFloatField;
    tblAwardsMealBreakThreshold: TFloatField;
    tblAwardShifts: TMyQuery;
    tblAwardShiftsShiftID: TAutoIncField;
    tblAwardShiftsAwardID: TIntegerField;
    tblAwardShiftsPayRateID: TIntegerField;
    tblAwardShiftsStartDay: TStringField;
    tblAwardShiftsEndDay: TStringField;
    tblAwardShiftsRate1AfterHours: TFloatField;
    tblAwardShiftsRate1PayRate: TIntegerField;
    tblAwardShiftsRate2AfterHours: TFloatField;
    tblAwardShiftsRate2PayRate: TIntegerField;
    tblAwardShiftsSuperInc: TStringField;
    tblAwardShiftsPayRate: TStringField;
    tblAwardShiftsPayRate1: TStringField;
    tblAwardShiftsPayRate2: TStringField;
    tblAwardShiftsStartTime: TTimeField;
    tblAwardShiftsEndTime: TDateTimeField;
    tblAwardShiftsEditedFlag: TStringField;
    qryawardclassificationdetailsAdvanceIDName: TStringField;
    chkActive: TwwCheckBox;
    DSExtraRates: TDataSource;
    PageControl2: TPageControl;
    tabClassificationAllowances: TTabSheet;
    tabClassificationDeductions: TTabSheet;
    tabClassificationExtraPayRates: TTabSheet;
    DNMPanel4: TDNMPanel;
    DNMPanel5: TDNMPanel;
    DNMPanel6: TDNMPanel;
    lblClassifications: TLabel;
    grdAllowances: TwwDBGrid;
    grdAllowncesIButton: TwwIButton;
    cboBasedOn: TwwDBLookupCombo;
    cboAllowance: TwwDBLookupCombo;
    cboAllowCalcBy: TwwDBComboBox;
    grdDeductions: TwwDBGrid;
    grdDeductionsIButton: TwwIButton;
    cboDeduction: TwwDBLookupCombo;
    cboBasedOnDeduct: TwwDBLookupCombo;
    cboDeductCalcBy: TwwDBComboBox;
    grdExtraPayRates: TwwDBGrid;
    wwDBGrid5IButton: TwwIButton;
    TypeID: TwwDBLookupCombo;
    ExtraPayRate: TwwDBLookupCombo;
    DNMPanel7: TDNMPanel;
    tblClassificationExtraPayRates: TMyQuery;
    tblClassificationExtraPayRatesRateID: TAutoIncField;
    tblClassificationExtraPayRatesClassificationID: TIntegerField;
    tblClassificationExtraPayRatesPayRate: TIntegerField;
    tblClassificationExtraPayRatesTypeID: TIntegerField;
    tblClassificationExtraPayRatesPayRateType: TStringField;
    tblClassificationExtraPayRatesWorked: TFloatField;
    tblClassificationExtraPayRatesAmount: TFloatField;
    tblClassificationExtraPayRatesSuperInc: TStringField;
    tblClassificationExtraPayRatesExtraPayRate: TStringField;
    tblClassificationExtraPayRatesAwardID: TIntegerField;
    tblClassificationExtraPayRatesEditedFlag: TStringField;
    qryawardclassificationdetailsAdvanceToClassification: TStringField;
    cboNextLevel: TwwDBLookupCombo;
    cboNextClassifications: TMyQuery;
    Label9: TLabel;
    tblAwardsPaySuperOnLeaveLoading: TStringField;
    Bevel5: TBevel;
    tblAwardsUseCompanySuperThreshold: TStringField;
    tblAwardsSuperThresholdAmount: TFloatField;
    Label10: TLabel;
    wwCheckBox2: TwwCheckBox;
    txtSuperThresholdAmount: TwwDBEdit;
    Label11: TLabel;
    qryAwardLeaveAwardStartDate: TDateField;
    qryAwardLeaveAwardEndDate: TDateField;
    dtpAwardStartDate: TwwDBDateTimePicker;
    dtpAwardEndDate: TwwDBDateTimePicker;
    qryAwardLeaveUseStartEndDates: TStringField;
    chkUseStartEndDates: TwwCheckBox;
    qryAwardLeaveLeaveLoading: TFloatField;
    wwCheckBox1: TwwCheckBox;
    Label12: TLabel;
    edSickDaysThreshold: TwwDBEdit;
    tblAwardsSickLeaveDaysThreshold: TIntegerField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure AwardNameExit(Sender: TObject);
    procedure wwDBGrid1IButtonClick(Sender: TObject);
    procedure wwDBGrid2IButtonClick(Sender: TObject);
    procedure grdAllowncesIButtonClick(Sender: TObject);
    procedure wwDBGrid3IButtonClick(Sender: TObject);
    procedure grdTimesheetCreateDateTimePicker(Sender: TObject; ADateTimePicker: TwwDBCustomDateTimePicker);
    procedure btnNewClick(Sender: TObject);
    procedure SuperTypeChange(Sender: TObject);
    procedure grdLeaveExit(Sender: TObject);
    procedure grdClassificationExit(Sender: TObject);
    procedure qryawardclassificationdetailsClassificationChange(Sender: TField);
    procedure qryAwardLeaveTypeChange(Sender: TField);
    procedure qryclassificationallowancesBeforePost(DataSet: TDataSet);
    procedure qryawardclassificationdetailsAfterScroll(DataSet: TDataSet);
    procedure cboAllowanceCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboAllowanceExit(Sender: TObject);
    procedure grdAllowancesExit(Sender: TObject);
    procedure cboDeductionCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure qryClassificationDeductionsBeforePost(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure edClassificationEnter(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure grdDeductionsIButtonClick(Sender: TObject);
    procedure cboLeaveNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure tblAwardShiftsBeforePost(DataSet: TDataSet);
    procedure cboAdvanceIDCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboAllowanceNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboDeductionNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
    procedure cboLeaveCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure tblClassificationExtraPayRatesBeforePost(DataSet: TDataSet);
    procedure grdDeductionsExit(Sender: TObject);
    procedure grdExtraPayRatesExit(Sender: TObject);
    procedure grdTimesheetExit(Sender: TObject);
    procedure grdTimesheetEnter(Sender: TObject);
    procedure wwDBGrid5IButtonClick(Sender: TObject);
    procedure qryclassificationallowancesBasedOnIDChange(Sender: TField);
    procedure qryClassificationDeductionsBasedOnIDChange(Sender: TField);
    procedure cboNextLevelEnter(Sender: TObject);
    procedure wwCheckBox2Click(Sender: TObject);
    procedure LoadingExit(Sender: TObject);
    procedure qryAwardLeaveLeaveLoadingChange(Sender: TField);

  private
    { Private declarations }
    fAward:Tawards;

    iClassificationID: integer;
    bAfterScrollAllowed: boolean;
    DeductionsBasedOnCalcByInProgress: boolean;
    AllowancesBasedOnCalcByInProgress: boolean;
    function ValidateData(): boolean;
    procedure PopulateLeaveGrid();
    procedure PopulateClassificationGrid;
    procedure PopulateShiftGrid(); 
    procedure CreateDefault();
    function IsDefaultAward(): boolean;
    procedure UpdateEmployees;
    function SaveData(): boolean;
    procedure PrepareQryBeforeOpenQueries;
    procedure PrepareQryAfterOpenQueries;
  public
    { Public declarations }
    fbCreateDefaultAward: boolean;
    iAwardID: integer;
    bNewAward: boolean;
    procedure SetupNew();
  end;

implementation

uses
  FormFactory, DnMExceptions,  
  frmAllowancesFrm, frmDeductionsFrm, CommonDbLib, PayCommon,
  PayFunctionObj,  DnMLib, CommonLib, 
  AppEnvironment, FastFuncs;

{$R *.dfm}

procedure TfrmAwards.SetupNew();
begin
  bNewAward := true;
  tblAwards.Insert;
  AwardName.Text := ' ';
  tblAwardsPayPeriod.AsString := 'Weekly';
  tblAwardsSuperType.AsString := 'Percentage';
  tblAwardsSuperValue.AsFloat := 9.0;
  tblAwardsAnnualLeaveLoading.AsFloat := 17.5;
  tblAwardsActive.AsString := 'T';
  tblAwardsSickLeaveDaysThreshold.AsInteger := Trunc(AppEnv.CompanyPrefs.SickLeaveDays);
  tblAwards.Post;
  tblAwards.Edit;
  iAwardID := tblAwards.FieldByName('AwardID').AsInteger;
  cboDepartment.LookupValue := AppEnv.DefaultClass.DefaultClassName;
  cboDepartment.Text := AppEnv.DefaultClass.DefaultClassName;
  tblAwardsClassID.AsInteger := AppEnv.DefaultClass.ClassID;
  tblAwardShifts.Close;
  tblAwardShifts.ParamByName('xAwardID').AsInteger := iAwardID;
  tblAwardShifts.Open;
  PopulateLeaveGrid();
  PopulateClassificationGrid();

  tblAwards.Edit;
  chkActive.Checked := true;
end;

procedure TfrmAwards.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
  
end;


procedure TfrmAwards.btnCancelClick(Sender: TObject);
begin
  RollbackTransaction;
  Self.Close;
end;

procedure TfrmAwards.btnSaveClick(Sender: TObject);  //Save
begin
  inherited;
  if SaveData() then begin
    Notify;
    Self.Close;
  end;
end;

procedure TfrmAwards.PrepareQryBeforeOpenQueries;
begin
//  tblAwards.ParamByName('xAwardID').asInteger := KeyID;
//  qryAwardLeave.ParamByName('xAwardID').asInteger := KeyID;
//  qryawardclassificationdetails.ParamByName('xAwardID').asInteger := KeyID;
//  tblAwardShifts.ParamByName('xAwardID').asInteger := KeyID;
end;

procedure TfrmAwards.PrepareQryAfterOpenQueries;
begin
 // qryclassificationallowances.ParamByName('xAwardID').asInteger := KeyID;
//  qryclassificationallowances.ParamByName('xClassificationID').AsInteger := qryawardclassificationdetails.FieldByName('ClassificationID').AsInteger;
//  qryclassificationDeductions.ParamByName('xAwardID').asInteger := KeyID;
//  qryclassificationDeductions.ParamByName('xClassificationID').AsInteger := qryawardclassificationdetails.FieldByName('ClassificationID').AsInteger;
//  tblClassificationExtraPayRates.ParamByName('xAwardID').asInteger := KeyID;
//  tblClassificationExtraPayRates.ParamByName('xClassificationID').AsInteger := qryawardclassificationdetails.FieldByName('ClassificationID').AsInteger;
  qryDepartments.ParamByName('xClassID').asInteger := KeyID;
end;



procedure TfrmAwards.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  lblClassifications.Tag := TAG_DO_NOT_CHANGE;
  grdClassification.Tag := TAG_DO_NOT_CHANGE;
  PageControl2.Tag := TAG_DO_NOT_CHANGE;
  try
    inherited;
    if tblAwards.Active then begin
      CloseQueries;
    end;
    BeginTransaction;

    PrepareQryBeforeOpenQueries;
    SetLength(QueryNamesNotToOpen, 8);
    QueryNamesNotToOpen[0] := 'qryclassificationallowances';
    QueryNamesNotToOpen[1] := 'qryclassificationDeductions';
    QueryNamesNotToOpen[2] := 'tblClassificationExtraPayRates';
    QueryNamesNotToOpen[3] := 'qryDepartments';

    QueryNamesNotToOpen[4] := 'tblAwards';
    QueryNamesNotToOpen[5] := 'qryAwardsLeave';
    QueryNamesNotToOpen[6] := 'tblAwardShifts';
    QueryNamesNotToOpen[7] := 'qryswardclassificationDetails';

    OpenQueries(QueryNamesNotToOpen);
    PrepareQryAfterOpenQueries;
    qryDepartments.Open;
 //   qryclassificationallowances.Open;
//    qryclassificationDeductions.Open;
//    tblClassificationExtraPayRates.Open;

    fAward.Dataset := tblAwards;
    fAward.AwardLeaves.Dataset := qryAwardLeave;
    fAward.AwardShifts.Dataset := tblAwardShifts;
    fAward.AwardClassifications.Dataset := qryawardclassificationdetails;

    fAward.AwardClassifications.ClassificationAllowances.Dataset := qryclassificationallowances;
    fAward.AwardClassifications.ClassificationDeductions.Dataset := qryclassificationdeductions;
    fAward.AwardClassifications.ClassificationExtraPayrates.Dataset := tblClassificationExtraPayrates;

    fAward.Load(Self.KeyID);




    if KeyID = 0 then begin
      bNewAward := true;
      AwardName.ReadOnly := false;
      SetupNew();
      if fbCreateDefaultAward then begin
        if not DefaultAwardExists() then begin
          CreateDefault();
          AwardName.ReadOnly := true;
        end;
      end;
    end else begin
      bNewAward := false;
      AwardName.ReadOnly := true;
      iAwardID := KeyID;
   //   if fAward.Supertype = 'Percentage' then begin
//        fAward.Supervalue.
//      end else begin
//
//      end;

 //     if tblAwards.FieldByName('SuperType').AsString = 'Percentage' then begin
//        tblAwardsSuperValue.DisplayFormat := '###0.00%';
//      end else begin
//        tblAwardsSuperValue.DisplayFormat := AppEnv.RegionalOptions.CurrencySymbol+'###0.00';
//      end;
//      EditNoAbort(tblAwards);
    end;
    //make sure annual leave in grid matches the text box
//    qryAwardLeave.Locate('Type', 'Annual Leave', [loCaseInsensitive]);
//    qryAwardLeave.Edit;
//    qryAwardLeave.FieldByName('LeaveLoading').AsFloat := tblAwards.FieldByName('AnnualLeaveLoading').AsFloat;
//    qryAwardLeave.Post;
//
//    bAfterScrollAllowed     := true;
//    chkActive.Enabled       := (AccessLevel <> 2) and (AccessLevel <> 3);
//    PageControl1.ActivePage := TTabSheet(Standard);
//    PageControl2.ActivePage := TTabSheet(tabClassificationAllowances);
//    SetControlFocus(AwardName);
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;

procedure TfrmAwards.AwardNameExit(Sender: TObject);
begin
  inherited;
  try
    if (FastFuncs.Trim(AwardName.Text) = '') and not (btnCancel.Focused ) then begin
      CommonLib.MessageDlgXP_Vista('Award Name cannot be blank !', mtWarning, [mbOK], 0);
      SetControlFocus(AwardName);
      exit;
    end;
    DBMemo1.Text := FastFuncs.Trim(DBMemo1.Text);
    DBMemo1.Text := AwardName.Text;
    tblAwards.Edit;
    tblAwards.Post;
    tblAwards.Edit;
    iAwardID := tblAwards.FieldByName('AwardID').AsInteger;
  except
    if not btnCancel.Focused then begin
      CommonLib.MessageDlgXP_Vista('You Have Created An Entry That Already Exists !' + #13#10#13#10 +
          'Please Ensure Your Entry Is Unique.', mtWarning, [mbOK], 0);
      AwardName.Text := '';
      SetControlFocus(AwardName);
    end;
  end;
end;

procedure TfrmAwards.wwDBGrid1IButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryAwardLeave);
end;

procedure TfrmAwards.wwDBGrid2IButtonClick(Sender: TObject);
var
  qryDelete: TMyQuery;
  sSQL: string;
  iClassificationID: integer;
begin
  inherited;
  qryDelete := TMyQuery.Create(nil);
  try
    if not (IsDefaultAward() and FastFuncs.SameText(qryawardclassificationdetailsClassification.AsString, AWARD_CLASS_DEFAULT)) then
    begin
      if CommonLib.MessageDlgXP_Vista('Are you sure you want to delete this record?', mtConfirmation, mbYesNoCancel, 0) = mrYes then begin
        try
          iClassificationID := qryawardclassificationdetails.FieldByName('ClassificationID').AsInteger;

          qryawardclassificationdetails.Delete;
          qryDelete.Connection := MyConnection;
          // Delete all Deductions that relate to this classification.
          qryDelete.SQL.Clear;
          sSQL := 'DELETE FROM tblclassificationallowances WHERE AwardID = ' + FastFuncs.IntToStr(iAwardID) +
            ' AND ClassificationID = ' + FastFuncs.IntToStr(iClassificationID);
          qryDelete.SQL.Add(sSQL);
          qryDelete.Execute;

          // Delete all Allowances that relate to this classification.
          qryDelete.SQL.Clear;
          sSQL := 'DELETE FROM tblclassificationallowances WHERE AwardID = ' + FastFuncs.IntToStr(iAwardID) +
            ' AND ClassificationID = ' + FastFuncs.IntToStr(iClassificationID);
          qryDelete.SQL.Add(sSQL);
          qryDelete.Execute;

          // Now delete all extra payrates that relate to this classification.
          qryDelete.SQL.Clear;
          sSQL := 'DELETE FROM tblclassificationextrapayrates WHERE AwardID = ' + FastFuncs.IntToStr(iAwardID) +
            ' AND ClassificationID = ' + FastFuncs.IntToStr(iClassificationID);
          qryDelete.SQL.Add(sSQL);
          qryDelete.Execute;

          PopulateClassificationGrid;

        except
        end;
      end;
    end;
  finally
    // Free our used objects.
    if Assigned(qryDelete) then qryDelete.Free;
  end;
end;

procedure TfrmAwards.grdAllowncesIButtonClick(Sender: TObject);     //classification Deductions
begin
  inherited;
  DeleteRecord(qryclassificationAllowances);
end;

procedure TfrmAwards.grdDeductionsIButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(qryclassificationDeductions);
end;

procedure TfrmAwards.wwDBGrid3IButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(tblAwardShifts);
end;

procedure TfrmAwards.grdTimesheetCreateDateTimePicker(Sender: TObject; ADateTimePicker: TwwDBCustomDateTimePicker);
begin
  inherited;
  ADateTimePicker.ShowButton := false;
  ADateTimePicker.DateTime := 0;
end;

procedure TfrmAwards.btnNewClick(Sender: TObject);
begin
  inherited;
  if SaveData() then begin
    KeyID := 0;
    FormShow(nil);
  end;
end;

procedure TfrmAwards.SuperTypeChange(Sender: TObject);
begin
  inherited;
  if SuperType.Text = 'Percentage' then begin
    tblAwardsSuperValue.DisplayFormat := '###0.00%';
  end else begin
    tblAwardsSuperValue.DisplayFormat := AppEnv.RegionalOptions.CurrencySymbol+'###0.00';
  end;
end;

procedure TfrmAwards.grdLeaveExit(Sender: TObject);
begin
  inherited;
  qryAwardLeave.Edit;
  qryAwardLeave.FieldByName('AwardID').AsInteger := iAwardID;
  qryAwardLeave.Post;
end;

procedure TfrmAwards.grdClassificationExit(Sender: TObject);
begin
  inherited;
  if qryawardclassificationdetails.State in [dsEdit, dsInsert] then begin
    qryawardclassificationdetails.Post;
  end;
  qryawardclassificationdetails.Edit;
end;

procedure TfrmAwards.qryawardclassificationdetailsClassificationChange(Sender: TField);
begin
  inherited;
  qryawardclassificationdetails.FieldByName('AwardID').AsInteger := iAwardID;
end;

procedure TfrmAwards.qryAwardLeaveTypeChange(Sender: TField);
begin
  inherited;
  qryAwardLeave.FieldByName('AwardID').AsInteger := iAwardID;
end;

procedure TfrmAwards.qryclassificationAllowancesBeforePost(DataSet: TDataSet);
begin
  inherited;
  qryclassificationAllowances.FieldByName('AwardID').AsInteger := iAwardID;
  qryclassificationAllowances.FieldByName('ClassificationID').AsInteger := iClassificationID;
end;

procedure TfrmAwards.qryawardclassificationdetailsAfterScroll(DataSet: TDataSet);
begin
  iClassificationID := qryawardclassificationdetails.FieldByName('ClassificationID').AsInteger;
  if bAfterScrollAllowed then begin
    qryclassificationDeductions.Close;
    qryclassificationDeductions.ParamByName('xClassificationID').AsInteger := iClassificationID;
    qryclassificationDeductions.ParamByName('xAwardID').AsInteger          := iAwardID;
    qryclassificationDeductions.Open;
    qryclassificationDeductions.Edit;

    qryclassificationAllowances.Close;
    qryclassificationAllowances.ParamByName('xClassificationID').AsInteger := iClassificationID;
    qryclassificationAllowances.ParamByName('xAwardID').AsInteger          := iAwardID;
    qryclassificationAllowances.Open;
    qryclassificationAllowances.Edit;

    tblClassificationExtraPayRates.Close;
    tblClassificationExtraPayRates.ParamByName('xClassificationID').AsInteger := iClassificationID;
    tblClassificationExtraPayRates.ParamByName('xAwardID').AsInteger          := iAwardID;
    tblClassificationExtraPayRates.Open;
    tblClassificationExtraPayRates.Edit;
  end;
end;

function TfrmAwards.ValidateData(): boolean;
var
  iRowCount: integer;
begin
  if not chkActive.Checked then begin
    Result := true;
    Exit;
  end;
  iRowCount := grdClassification.GetRowCount;
  if (iRowCount = 2) and (grdClassification.GetFieldValue(0) = '') then begin
    CommonLib.MessageDlgXP_Vista(
      'The award needs at least one classification.  Without a classification, the award system will not know what hourly rates to pay your employees.',
      mtError, [mbOK], 0);
    PageControl1.ActivePage := TTabSheet(AwardPayment);
    Result := false;
    Exit;
  end;
  Result := true;
end;

procedure TfrmAwards.cboAllowanceCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  qryClassificationAllowances.Edit;
  qryclassificationAllowances.FieldByName('ClassificationID').AsInteger := iClassificationID;
  qryClassificationAllowances.FieldByName('Amount').AsFloat := qryAllowances.FieldByName('Amount').AsFloat;
  qryClassificationAllowances.FieldByName('CalcBy').AsString := qryAllowances.FieldByName('CalcBy').AsString;
  qryClassificationAllowances.FieldByName('BasedOnID').AsInteger := qryAllowances.FieldByName('BasedOnID').AsInteger;
  grdAllowances.RefreshDisplay;
end;

procedure TfrmAwards.cboAllowanceExit(Sender: TObject);
begin
  inherited;
  If qryclassificationAllowances.Active AND (qryclassificationAllowances.State in [dsEdit, dsInsert]) then begin
    qryclassificationAllowances.FieldByName('ClassificationID').AsInteger := iClassificationID;
    qryclassificationAllowances.Post;
    qryclassificationAllowances.Edit;
  end;    
end;

procedure TfrmAwards.grdAllowancesExit(Sender: TObject);
begin
  inherited;
  qryclassificationallowances.First;
end;

procedure TfrmAwards.PopulateLeaveGrid;
begin
  // Annual Leave
  qryAwardLeave.Insert;
  qryAwardLeaveType.AsString := 'Annual Leave';
  qryAwardLeaveAccrueAfterNo.AsInteger := 0;
  qryAwardLeaveAccrueAfterPeriod.AsString := 'Pay';
  qryAwardLeaveAccrueNo.AsInteger := 1;
  qryAwardLeaveAccruePeriod.AsString := 'Pay';
  qryAwardLeaveAccrueHours.AsFloat := AppEnv.CompanyPrefs.ALeaveWeeks * (AppEnv.CompanyPrefs.HoursPerWeek / 52);
  qryAwardLeave.Post;

  // Sick Leave
  qryAwardLeave.Insert;
  qryAwardLeaveType.AsString := 'Sick Leave';
  qryAwardLeaveAccrueAfterNo.AsInteger := 0;
  qryAwardLeaveAccrueAfterPeriod.AsString := 'Pay';
  qryAwardLeaveAccrueNo.AsInteger := 1;
  qryAwardLeaveAccruePeriod.AsString := 'Pay';
  qryAwardLeaveAccrueHours.AsFloat := (AppEnv.CompanyPrefs.SickLeaveDays / 5) * (AppEnv.CompanyPrefs.HoursPerWeek / 52);
  qryAwardLeave.Post;

  // LS Leave
  qryAwardLeave.Insert;
  qryAwardLeaveType.AsString := 'Long Service';

  qryAwardLeaveAccrueAfterNo.AsInteger :=  0;  //System.Round(CompanyPref.LSLCommenceYears);
  qryAwardLeaveAccrueAfterPeriod.AsString := 'Year';
  qryAwardLeaveAccrueNo.AsInteger := 1;
  qryAwardLeaveAccruePeriod.AsString := 'Hour';
  qryAwardLeaveAccrueHours.AsFloat := AppEnv.CompanyPrefs.LSLWeeks  /(AppEnv.CompanyPrefs.LSLCommenceYears * 52) ;
  
  qryAwardLeave.Post;
end;

procedure TfrmAwards.PopulateClassificationGrid;
begin
  // Ensure that we only get one record of this.
  if (qryAwardclassificationDetails.RecordCount < 1) then begin
    qryAwardClassificationDetails.Insert;
    qryAwardClassificationDetailsClassification.AsString := 'Standard';
    qryawardclassificationdetailsType.AsString           := 'Hourly Rate';
    qryawardclassificationdetailsFullTime.AsCurrency     := 0.00;
    qryawardclassificationdetailsPartTime.AsCurrency     := 0.00;
    qryawardclassificationdetailsCasual.AsCurrency       := 0.00;
    qryawardclassificationdetailsCasualLoading.AsFloat   := 0.0;

    // Set the default advance ID to that of 'Manual'
    if qryAwardAdvance.Locate('Description', 'Manual', [loCaseInsensitive, loPartialKey]) then begin
      // if found, then set class in combo (may be a bit of an overkill here, but best to
      // .. be certain
      cboAdvanceID.LookupValue := qryAwardAdvance.FieldByName('AdvanceID').AsString;
      qryawardclassificationdetailsAdvanceID.AsInteger := qryAwardAdvance.FieldByName('AdvanceID').AsInteger;
      cboAdvanceID.Text := 'Manual';
    end;
    qryAwardClassificationDetails.Post;
    iClassificationID := qryawardclassificationdetailsClassificationID.AsInteger;
    qryAwardClassificationDetails.Edit;
  end;
end;


procedure TfrmAwards.PopulateShiftGrid;
begin
  // default for normal hours
  if tblAwardShifts.Active then begin
    tblAwardShifts.Insert;
    tblAwardShiftsAwardID.AsInteger := tblAwardsAwardID.AsInteger;

    if qryPayRates.Locate('Description', 'Normal Hours', [loCaseInsensitive]) then begin
      tblAwardShiftsPayRateID.AsInteger := qryPayRatesRateID.AsInteger;
    end else begin
      tblAwardShiftsPayRateID.AsInteger := 0;
    end;

    tblAwardShiftsStartDay.AsString    := 'Mon-Fri';
    tblAwardShiftsEndDay.AsString      := 'Mon-Fri';
    tblAwardShiftsStartTime.AsDateTime := StrToTime('08:00 am');
    tblAwardShiftsEndTime.AsDateTime   := StrToTime('05:00 pm');
    tblAwardShiftsSuperInc.AsString    := 'Yes';
    tblAwardShifts.Post;

    // Default meal break
    tblAwardShifts.Insert;
    tblAwardShiftsAwardID.AsInteger := tblAwardsAwardID.AsInteger;
    if qryPayRates.Locate('Description', 'Meal Break', [loCaseInsensitive]) then begin
      tblAwardShiftsPayRateID.AsInteger := qryPayRatesRateID.AsInteger;
    end else begin
      tblAwardShiftsPayRateID.AsInteger := 0;
    end;

    tblAwardShiftsStartDay.AsString    := 'Mon-Fri';
    tblAwardShiftsEndDay.AsString      := 'Mon-Fri';
    tblAwardShiftsStartTime.AsDateTime := StrToTime('12:00 pm');
    tblAwardShiftsEndTime.AsDateTime   := StrToTime('01:00 pm');
    tblAwardShiftsSuperInc.AsString    := 'No';
    tblAwardShifts.Post;
  end;
end;


procedure TfrmAwards.cboDeductionCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  qryClassificationDeductions.Edit;
  qryclassificationDeductions.FieldByName('ClassificationID').AsInteger := iClassificationID;
  qryClassificationDeductions.FieldByName('Amount').AsFloat := qryDeductions.FieldByName('Amount').AsFloat;
  qryClassificationDeductions.FieldByName('CalcBy').AsString := qryDeductions.FieldByName('CalcBy').AsString;
  qryClassificationDeductions.FieldByName('BasedOnID').AsInteger := qryDeductions.FieldByName('BasedOnID').AsInteger;
  grdDeductions.RefreshDisplay;
end;


procedure TfrmAwards.qryClassificationDeductionsBeforePost(DataSet: TDataSet);
begin
  inherited;
  qryclassificationDeductions.FieldByName('AwardID').AsInteger := iAwardID;
  qryclassificationDeductions.FieldByName('ClassificationID').AsInteger := iClassificationID;
end;

procedure TfrmAwards.CreateDefault;
begin
  tblAwardsAwardName.AsString := 'Default';
  CommonLib.MessageDlgXP_Vista('Make any changes to this Default Award and Save', mtInformation, [mbOK], 0);
end;

procedure TfrmAwards.FormCreate(Sender: TObject);
begin
  inherited;
  fbCreateDefaultAward := false;
  bAfterScrollAllowed := false;

  fAward := Tawards.Create(Self,MyConnection) ;


 // qryAllowances.Connection := CommonDbLib.GetSharedMyDacConnection;
//  qryDeductions.Connection := CommonDbLib.GetSharedMyDacConnection;
//  qryPayRateType.Connection := CommonDbLib.GetSharedMyDacConnection;
//  qryAwardAdvance.Connection := CommonDbLib.GetSharedMyDacConnection;
//  qryLeaveTypes.Connection := CommonDbLib.GetSharedMyDacConnection;


end;

function TfrmAwards.IsDefaultAward: boolean;
begin
  Result := false;
  if tblAwards.Active then begin
    if FastFuncs.SameText(tblAwardsAwardName.AsString, AWARD_DEFAULT) then begin
      Result := true;
    end;
  end;
end;

procedure TfrmAwards.edClassificationEnter(Sender: TObject);
begin
  inherited;
  if IsDefaultAward() and FastFuncs.SameText(qryawardclassificationdetailsClassification.AsString, AWARD_CLASS_DEFAULT) then begin
    edClassification.ReadOnly := true;
  end else begin
    edClassification.ReadOnly := false;
  end;
end;

procedure TfrmAwards.chkActiveClick(Sender: TObject);
var
  iResult: integer;
begin
  if tblAwards.Active and (tblAwards.State in [dsInsert, dsEdit]) then begin
    if not chkActive.Checked then begin
      iResult := AwardInUseByEmployees(tblAwards.FieldByName('AwardID').AsInteger);
      if iResult > 0 then begin
        chkActive.Checked := true;
        CommonLib.MessageDlgXP_Vista('This award cannot be deactivated because there is currently ' + FastFuncs.IntToStr(iResult) +
          ' employees who are using this award base.  You must give these employees a new award setting ' +
          ' before deactivating this one.', mtWarning, [mbOK], 0);
        Exit;
      end;
    end;
  end;
end;

procedure TfrmAwards.UpdateEmployees;
var
  qryEmp: TMyQuery;
  SavedCursor: TCursor;
  mrResult: integer;
  Employee: TDataset;
  EmployeePayRates: TDataset;
  EmployeeAllowances: TDataset;
  EmployeeDeductions: TDataset;
  EmployeeSuper: TDataset;
  EmployeeLeave: TDataset;
  tmpPayFunction: TPayFunctionObj;
begin
  SavedCursor := Screen.Cursor;
  qryEmp := TMyQuery.Create(nil);
  try
    qryEmp.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryEmp.Sql.Clear;
    qryEmp.Sql.Add('SELECT EmployeeID, Classification, EmployeeName,IsTerminated FROM tblemployees WHERE Award = ' +
      FastFuncs.IntToStr(iAwardID) + ' AND IsTerminated = "F";');
    qryEmp.Open;
    if (qryEmp.RecordCount = 0) then begin
      Exit;
    end;
    if chkActive.Checked then begin
      if CommonLib.MessageDlgXP_Vista('Do You Wish To Update Employees Who Have Been Assigned This Award?', mtConfirmation,
        [mbYes, mbNo], 0) = mrYes then begin
        mrResult := mrYes;
        with qryAwardClassificationDetails do begin
          First;
          while not Eof do begin
            qryEmp.First;
            while not qryEmp.Eof do begin
              if qryEmp.FieldByName('Classification').AsString = FieldByName('Classification').AsString then begin
                if mrResult <> mrYesToAll then begin
                  mrResult := CommonLib.MessageDlgXP_Vista('Do you wish to Update ' + qryEmp.FieldByName('EmployeeName').AsString +
                    ' with the New Award?', mtConfirmation, [mbYes, mbNo, mbNoToAll, mbYesToAll], 0);
                end;
                if mrResult = mrNoToAll then Break;
                if mrResult <> mrNo then begin
                  Application.ProcessMessages;
                  Screen.Cursor := crHourGlass;
                  Employee := RetrieveDataset('tblEmployees', 'EmployeeID', qryEmp.FieldByName('EmployeeID').AsInteger);
                  if (Employee.FieldByName('UseClassificationAdvance').AsString = 'T') then begin
                    Employee.Edit;
                    Employee.FieldByName('Classification').AsString :=
                      GetClassificationName(GetAdvanceClassificationID(Employee.FieldByName('Award').AsInteger, Employee));
                    Employee.Post;
                  end;
                  EmployeePayRates := RetrieveDataset('tblemployeepayrates', 'EmployeeID',
                    qryEmp.FieldByName('EmployeeID').AsInteger);
                  EmployeeAllowances := RetrieveDataset('tblemployeeallowances', 'EmployeeID',
                    qryEmp.FieldByName('EmployeeID').AsInteger);
                  EmployeeDeductions := RetrieveDataset('tblemployeedeductions', 'EmployeeID',
                    qryEmp.FieldByName('EmployeeID').AsInteger);
                  EmployeeSuper := RetrieveDataset('tblsuperannuation', 'EmployeeID',
                    qryEmp.FieldByName('EmployeeID').AsInteger);
                  EmployeeLeave := RetrieveDataset('tblleave', 'EmployeeID', qryEmp.FieldByName('EmployeeID').AsInteger);
                  tmpPayFunction := TPayFunctionObj.Create;
                  try
                    tmpPayFunction.UpdateEmployeeWithAward(tblAwards, qryAwardLeave, qryawardclassificationdetails,
                      qryclassificationallowances,
                      qryClassificationDeductions, tblClassificationExtraPayRates, Employee, EmployeeLeave,
                      EmployeePayRates, EmployeeAllowances, EmployeeDeductions, EmployeeSuper, true,qryEmp.FieldByName('EmployeeID').AsInteger);
                  finally
                    if Assigned(tmpPayFunction) then FreeAndNil(tmpPayFunction);
                    if Assigned(Employee) then FreeAndNil(Employee);
                    if Assigned(EmployeePayRates) then FreeAndNil(EmployeePayRates);
                    if Assigned(EmployeeAllowances) then FreeAndNil(EmployeeAllowances);
                    if Assigned(EmployeeDeductions) then FreeAndNil(EmployeeDeductions);
                    if Assigned(EmployeeSuper) then FreeAndNil(EmployeeSuper);
                    if Assigned(EmployeeLeave) then FreeAndNil(EmployeeLeave);
                  end;
                end;
              end;
              qryEmp.Next;
            end;
            if mrResult = mrNoToAll then begin
              Break;
            end;
            Next;
          end;
        end;
      end;
    end;
  finally
    qryEmp.Free;
    Screen.Cursor := SavedCursor;
  end;
end;

function TfrmAwards.SaveData: boolean;
var
  j: integer;
  CHours: double;
  NHours: double;
begin
  Result := false;
  if not ValidateData() then begin
    Exit;
  end;
  try
    if chkActive.Checked then begin
      NHours := 0;
      if not Empty(AwardName.Text) then begin
        if (tblAwards.State in [dsBrowse]) then begin
          tblAwards.Edit;
        end;
        tblAwards.Post;
        if not (tblAwardShifts.State in [dsBrowse]) then begin
          tblAwardShifts.FieldByName('AwardID').AsInteger := iAwardID;
          tblAwardShifts.Post;
        end;

        if tblAwardShifts.RecordCount <> 0 then begin
          for j := 0 to tblAwardShifts.RecordCount - 1 do begin
            CHours := HourSpan(tblAwardShifts.FieldByName('EndTime').AsDateTime,
              tblAwardShifts.FieldByName('StartTime').AsDateTime);
            if (tblAwardShifts.FieldByName('Rate1AfterHours').AsFloat = 0) then begin
              NHours := NHours + CHours;
            end;
            if tblAwardShifts.FieldByName('Rate1AfterHours').AsFloat <> 0 then begin
              NHours := NHours + tblAwardShifts.FieldByName('Rate1AfterHours').AsFloat;
            end;
            if PayPeriod.Text = 'Fortnightly' then NHours := NHours * 2;
            if PayPeriod.Text = 'Monthly' then NHours := NHours * 52 / 12;
            if PayPeriod.Text = 'Bi-Monthly' then NHours := NHours * 52 / 24;
            tblAwardShifts.Next;
          end;
          if tblAwardShifts.FieldByName('StartDay').AsString = 'Mon-Fri' then NHours := NHours * 5;
        end else begin
          NHours := 40;
        end;
        if NHours = 0 then;


        if (qryAwardLeave.State in [dsEdit]) then begin
          qryAwardLeave.Post;
        end;
        if (qryawardclassificationdetails.State in [dsEdit]) then begin
          qryawardclassificationdetails.Post;
        end;
        if (qryclassificationallowances.State in [dsEdit]) then begin
          qryclassificationallowances.Post;
        end;
        if (qryclassificationDeductions.State in [dsEdit]) then begin
          qryclassificationDeductions.Post;
        end;
        if (qryclassificationDeductions.State in [dsEdit]) then begin
          qryclassificationDeductions.Post;
        end;
        if (tblClassificationExtraPayRates.State in [dsEdit]) then begin
          tblClassificationExtraPayRates.Post;
        end;

        CommitTransaction;
        Result := true;
        if not bNewAward then begin
          UpdateEmployees;
        end;
      end else begin
        CommonLib.MessageDlgXP_Vista('Award name cannot be blank.', mtError, [mbOK], 0);
        PageControl1.ActivePage := Standard;
        SetControlFocus(AwardName);
      end;
    end else begin
      if (tblAwards.State in [dsBrowse]) then begin
        tblAwards.Edit;
      end;
      tblAwards.Post;
      CommitTransaction;
      Result := true;
    end;

  except
    on EAbort do HandleEAbortException;
    else raise;
  end;
end;

procedure TfrmAwards.cboLeaveNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
begin
  //  inherited;
  Accept := true;
  with LookupTable do begin
    Insert;
    FieldByName('LeaveType').AsString := cboLeave.Text;
    Post; 
  end;
end;

procedure TfrmAwards.tblAwardShiftsBeforePost(DataSet: TDataSet);
begin
  inherited;
  tblAwardShifts.FieldByName('AwardID').AsInteger := iAwardID;
end;

procedure TfrmAwards.cboAdvanceIDCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  FillTable.Edit;
  FillTable.FieldByName('AdvanceID').AsInteger := qryAwardAdvance.FieldByName('AdvanceID').AsInteger;
end;

procedure TfrmAwards.cboAllowanceNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
var
  AllowancesGUI: TComponent;
begin
  AllowancesGUI :=  GetComponentByClassName('TfrmAllowances');
  inherited;
  if CommonLib.MessageDlgXP_Vista('Selection not in list.  Create New?', mtInformation, [mbOK], 0) = mrOk then begin
    if not assigned(AllowancesGUI) then exit;
    with TfrmAllowances(AllowancesGUI) do begin
      NewName := NewValue;
      FormStyle := fsNormal;
      ShowModal;
    end;

    LookupTable.Close;
    LookupTable.Open;
    if LookupTable.Locate('Description', NewValue, [loCaseInsensitive]) then begin
      qryclassificationallowances.Edit;
      qryclassificationallowanceslookupallowance.AsInteger := qryAllowances.FieldByName('AllowanceID').AsInteger;
    end;

    Accept := true;
  end else begin
    Accept := false;
  end;
end;

procedure TfrmAwards.cboDeductionNotInList(Sender: TObject; LookupTable: TDataSet; NewValue: string; var Accept: boolean);
var
  DeductionsGUI: TComponent;
begin
  inherited;
  if CommonLib.MessageDlgXP_Vista('Selection not in list.  Create New?', mtInformation, [mbOK], 0) = mrOk then begin
    DeductionsGUI := GetComponentByClassName('TfrmDeductions');
    if not assigned(DeductionsGUI) then exit;
    with TfrmDeductions(DeductionsGUI) do begin
      NewDescription := NewValue;
      FormStyle := fsNormal;
      ShowModal;
    end;

    LookupTable.Close;
    LookupTable.Open;
    if LookupTable.Locate('Description', NewValue, [loCaseInsensitive]) then begin
      qryclassificationdeductions.Edit;
      qryclassificationdeductionsDeductionLookup.AsInteger := qryDeductions.FieldByName('DeductionID').AsInteger;
    end;

    Accept := true;
  end else begin
    Accept := false;
  end;
end;

procedure TfrmAwards.cboLeaveCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
var
  qry: TMyQuery;
begin
  if not Modified then Exit;
  inherited;
  qry := TMyQuery.Create(nil);
  try
    qry.Connection := MyConnection;
    qry.SQL.Clear;
    qry.SQL.Add('SELECT * FROM tblpayrates WHERE (Description = ' + QuotedStr(cboLeave.Text) + ');');
    qry.Open;

    // Does this leave type already exist?
    if qry.RecordCount < 1 then begin
      // No create new entry.
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add('INSERT HIGH_PRIORITY INTO tblpayrates (Description, Multiplier, IsLeave, Active, IsPayRate) VALUES (');
      qry.SQL.Add(QuotedStr(cboLeave.Text) + ', 1.0, "T", "T", "F");');
      qry.Execute;
    end;

  finally
    // Free our used objects.
    if Assigned(qry) then qry.Free;
  end;
end;


procedure TfrmAwards.tblClassificationExtraPayRatesBeforePost(DataSet: TDataSet);
begin
  inherited;
  tblClassificationExtraPayRates.FieldByName('AwardID').AsInteger := iAwardID;
  tblClassificationExtraPayRates.FieldByName('ClassificationID').AsInteger := iClassificationID;
end;

procedure TfrmAwards.grdDeductionsExit(Sender: TObject);
begin
  inherited;
  qryClassificationDeductions.First;
end;

procedure TfrmAwards.grdExtraPayRatesExit(Sender: TObject);
begin
  inherited;
  tblClassificationExtraPayRates.First;
end;

procedure TfrmAwards.grdTimesheetExit(Sender: TObject);
begin
  inherited;
  if tblAwardShifts.State in [dsEdit, dsInsert] then begin
    tblAwardShifts.Post;
  end;
  tblAwardShifts.Edit;
end;

procedure TfrmAwards.grdTimesheetEnter(Sender: TObject);
begin
  inherited;
  if tblAwardShifts.RecordCount = 0 then PopulateShiftGrid;
end;

procedure TfrmAwards.wwDBGrid5IButtonClick(Sender: TObject);
begin
  inherited;
  DeleteRecord(tblClassificationExtraPayRates);
end;

procedure TfrmAwards.qryclassificationallowancesBasedOnIDChange(Sender: TField);
begin
  inherited;
  if not AllowancesBasedOnCalcByInProgress then begin
    AllowancesBasedOnCalcByInProgress := true;
    if FindInSet(GetBasedOnName(qryclassificationallowancesBasedOnID.AsInteger), 'None,Km,Items') then begin
      qryclassificationallowancesCalcBy.AsString := '$';
    end;
    AllowancesBasedOnCalcByInProgress := false;
  end;
end;

procedure TfrmAwards.qryClassificationDeductionsBasedOnIDChange(Sender: TField);
begin
  inherited;
  if not DeductionsBasedOnCalcByInProgress then begin
    DeductionsBasedOnCalcByInProgress := true;
    if FindInSet(GetBasedOnName(qryClassificationDeductionsBasedOnID.AsInteger), 'None,Km,Items') then begin
      qryClassificationDeductionsCalcBy.AsString := '$';
    end;
    DeductionsBasedOnCalcByInProgress := false;
  end;
end;

procedure TfrmAwards.cboNextLevelEnter(Sender: TObject);
begin
  inherited;
  cboNextClassifications.Close;
  cboNextClassifications.ParamByName('xClassificationID').AsInteger := qryawardclassificationdetailsClassificationID.AsInteger;
  cboNextClassifications.ParamByName('xAwardID').AsInteger := qryawardclassificationdetailsAwardID.AsInteger;
  cboNextClassifications.Open;
end;

procedure TfrmAwards.wwCheckBox2Click(Sender: TObject);
begin
  inherited;
  txtSuperThresholdAmount.Enabled := not wwCheckBox2.Checked;
  if txtSuperThresholdAmount.Enabled and (tblAwardsSuperThresholdAmount.AsFloat = 0.00) then begin
    if tblAwards.Active then begin
      tblAwards.Edit;
      tblAwardsSuperThresholdAmount.AsFloat := AppEnv.PayPrefs.SuperOverGross;
    end;
  end;
end;

procedure TfrmAwards.LoadingExit(Sender: TObject);
begin
  inherited;
  qryAwardLeave.Locate('Type', 'Annual Leave', [loCaseInsensitive]);
  qryAwardLeave.Edit;
  qryAwardLeave.FieldByName('LeaveLoading').AsFloat := tblAwards.FieldByName('AnnualLeaveLoading').AsFloat;
  qryAwardLeave.Post;
end;

procedure TfrmAwards.qryAwardLeaveLeaveLoadingChange(Sender: TField);
begin
  inherited;
  if qryAwardleave.FieldByName('Type').AsString = 'Annual Leave' then begin
    tblAwards.Edit;
    tblAwards.FieldByName('AnnualLeaveLoading').AsFloat := qryAwardleave.FieldByName('LeaveLoading').AsFloat;
    tblAwards.Post;
  end;
end;

initialization
  RegisterClassOnce(TFrmAwards);
  FormFact.RegisterMe(TfrmAwards, 'TfrmAwardsList_*=AwardID');
  FormFact.RegisterControl(TfrmAllowances, '*_cboAllowance=AwardID');
  FormFact.RegisterControl(TfrmAwards, 'TfrmEmployee_cboAward=AwardID');
end.
