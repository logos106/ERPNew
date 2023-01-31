unit ProcessPrefs;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, MemDS, DBAccess, MyAccess,ERPdbComponents, StdCtrls, wwcheckbox,
  wwclearbuttongroup, wwradiogroup, ExtCtrls, DNMPanel, DataSourcePrefs,
  MessageConst, Mask, wwdbedit, AdvEdit, MoneyEdit, AdvSpin, BusObjProcPrefs,
  AdvGroupBox, AdvOfficeButtons, frmBase, BasePrefs, Wwdotdot, Wwdbcomb,
  DNMSpeedButton, AdvTrackBar, AdvGlowButton, AdvOfficeSelectors, Menus,
  wwdblook, MaskEdEx, AdvScrollBox, Grids, Wwdbigrd, Wwdbgrid;

type
  TProcessPrefsGUI = class(TBasePrefsGUI)
    lblWidth: TLabel;
    qryDefaultBOMWastageAccount: TERPQuery;
    qryDefaultBOMWastageAccountAccountName: TWideStringField;
    qryDefaultBOMWastageAccountType: TWideStringField;
    qryProcessSteps: TERPQuery;
    MyConnection1: TERPConnection;
    qryProcessStepsId: TIntegerField;
    qryProcessStepsDescription: TWideStringField;
    qryProcessStepsActive: TWideStringField;
    qryProcessStepsDefaultDuration: TFloatField;
    qryProcessStepsHourlyOverheadRate: TFloatField;
    qryProcessStepsHourlyLabourRate: TFloatField;
    qryProcessStepsBreakdownHoursDay: TFloatField;
    qryProcessStepsSetupHoursDay: TFloatField;
    PnlPlanning: TDNMPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
    edtCapacityPlanningWeeks: TAdvSpinEdit;
    chkResourceAvailableForHolidays: TwwCheckBox;
    chkProductionOnSaturdays: TwwCheckBox;
    chkProdPlanConfirmSave: TwwCheckBox;
    chkShowAllEmployeesinProductionScheduler: TwwCheckBox;
    pnlStockRequirement: TDNMPanel;
    Bevel3: TBevel;
    Label5: TLabel;
    Label4: TLabel;
    edtAllocationWarningDays: TAdvSpinEdit;
    chkAutoCreateSmartOrderFromSalesOrderTree: TwwCheckBox;
    chkOpenTreeOnSmartOrdercreation: TwwCheckBox;
    chkWarnTemplateOptionDefaultNotDefined: TwwCheckBox;
    chkWarnTemplateProcessesNotDefined: TwwCheckBox;
    pnlautoScheduling: TDNMPanel;
    Bevel2: TBevel;
    Label2: TLabel;
    edtAutoSchedGraceDays: TAdvSpinEdit;
    rgAutoSchedType: TAdvOfficeRadioGroup;
    chkAutoScheduleBasedonBOMEmpRoster: TwwCheckBox;
    pnlcolours: TDNMPanel;
    Bevel6: TBevel;
    Label6: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    ProductStatusPartQtyColour: TAdvOfficeColorSelector;
    ProductStatusPartQtyColourIntensity: TAdvTrackBar;
    ProductStatusTransQtyColour: TAdvOfficeColorSelector;
    ProductStatusTransQtyColourIntensity: TAdvTrackBar;
    ProductStatusOrderQtyColour: TAdvOfficeColorSelector;
    ProductStatusETAWithinPeriodColour: TAdvOfficeColorSelector;
    ProductStatusOrderQtyColourIntensity: TAdvTrackBar;
    ProductStatusETAWithinPeriodColourIntensity: TAdvTrackBar;
    ProductStatusETAExceededColour: TAdvOfficeColorSelector;
    ProductStatusETAExceededColourIntensity: TAdvTrackBar;
    pnlGanttchart: TDNMPanel;
    Bevel7: TBevel;
    Label15: TLabel;
    Label16: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    edtBarHeight: TAdvSpinEdit;
    cboGanttChartDrawStyle: TwwDBComboBox;
    GanttChartGFStartColourColorselector: TAdvOfficeColorSelector;
    GanttChartGFStartColourIntensity: TAdvTrackBar;
    GanttChartGFEndcolourColorSelector: TAdvOfficeColorSelector;
    GanttChartGFEndcolourIntensity: TAdvTrackBar;
    DNMPanel1: TDNMPanel;
    Bevel4: TBevel;
    Label17: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    btnSetupReportProgressBuild: TDNMSpeedButton;
    btnSetupReportProgressBuildWastage: TDNMSpeedButton;
    btnSetupReportProductionprogress: TDNMSpeedButton;
    chkPrintOnItemcompletion: TwwCheckBox;
    chkPrintOnItemProgress: TwwCheckBox;
    Panel1: TPanel;
    lblHint1: TLabel;
    Panel2: TPanel;
    lblHint2: TLabel;
    pnlGeneral: TDNMPanel;
    Bevel8: TBevel;
    Label10: TLabel;
    Label18: TLabel;
    Label22: TLabel;
    lblResetSaleDateWhenBuilthint: TLabel;
    Label23: TLabel;
    chkManufacturePartSourceStockconfirm: TwwCheckBox;
    chkManufacturePartSourceStock: TwwCheckBox;
    chkOpenTreeFromSalesOrder: TwwCheckBox;
    chkCapacityplannerSelectionOptionBeforeLoad: TwwCheckBox;
    chkOnlyshowScheduledJobsForBarCodeMan: TwwCheckBox;
    chkHideSelectedSubnodesinReport: TwwCheckBox;
    chkAutoclockOnemployeeOnjob: TwwCheckBox;
    chkCompleteBOMOrderOnSave: TwwCheckBox;
    edtCostDecimalPlacesinTree: TEdit;
    chkDefaultCoupenTimeinWOTimesheet: TwwCheckBox;
    cboDefaultBOMWastageAccount: TwwDBLookupCombo;
    cboBoMNonProductsubnodePostingAccount: TwwDBLookupCombo;
    chkResetSaleDateWhenBuilt: TwwCheckBox;
    chkUseSteelWeight: TwwCheckBox;
    chkRoundBatchQtyinProgressBatchCreator: TwwCheckBox;
    chkUpdateProductDescriptionFromTreeInfo: TwwCheckBox;
    optCopyInfotoSalesDesc: TAdvOfficeRadioGroup;
    chkAutoAllocateProcessForTreeRoot: TwwCheckBox;
    cboDefaultProcessforTree: TwwDBLookupCombo;
    edtDefaultTreeProcessDuration: TMaskEditEx;
    DNMPanel3: TDNMPanel;
    Bevel5: TBevel;
    Label25: TLabel;
    lblUseCurrentCostforProgressBuildhint: TLabel;
    chkUseCurrentCostforProgressBuild: TwwCheckBox;
    chkConfirmQtysOnfinalise: TwwCheckBox;
    chkOnPPGErrorSendEmail: TwwCheckBox;
    cboEmployeeLookup: TERPQuery;
    cboPPErrorEmailTo: TwwDBLookupCombo;
    Label24: TLabel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    optBomSalesPriceOptions: TAdvOfficeRadioGroup;
    optBuildDetailsUpdateOption: TAdvOfficeRadioGroup;
    QryBoMNonProductsubnodePostingAccount: TERPQuery;
    QryBoMNonProductsubnodePostingAccountAccountName: TWideStringField;
    QryBoMNonProductsubnodePostingAccountType: TWideStringField;
    Label26: TLabel;
    Label27: TLabel;
    Bevel11: TBevel;
    DNMPanel2: TDNMPanel;
    Bevel12: TBevel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    edtPPGBalanceAdjAccount: TwwDBEdit;
    edtPPGBalanceAdjEmployee: TwwDBEdit;
    btnPPGBalanceAdjAccount: TDNMSpeedButton;
    btnPPGBalanceAdjEmployee: TDNMSpeedButton;

    procedure FormCreate(Sender: TObject);
    procedure chkResourceAvailableForHolidaysClick(Sender: TObject);
    procedure edtAllocationWarningDaysChange(Sender: TObject);
    procedure chkWarnTemplateOptionDefaultNotDefinedClick(Sender: TObject);
    procedure chkWarnTemplateProcessesNotDefinedClick(Sender: TObject);
    (*procedure chkProductionOnSaturdaysClick(Sender: TObject);*)
    procedure edtCapacityPlanningWeeksChange(Sender: TObject);
    procedure edtAutoSchedGraceDaysChange(Sender: TObject);
    procedure rgAutoSchedTypeClick(Sender: TObject);
    procedure chkProdPlanConfirmSaveClick(Sender: TObject);
    procedure chkManufacturePartSourceStockconfirmClick(Sender: TObject);
    procedure chkManufacturePartSourceStockClick(Sender: TObject);
    procedure chkProductionOnSaturdaysClick(Sender: TObject);
    procedure chkAutoCreateSmartOrderFromSalesOrderTreeClick(Sender: TObject);
    procedure chkOpenTreeOnSmartOrdercreationClick(Sender: TObject);
    procedure cboGanttChartDrawStyleChange(Sender: TObject);
    procedure edtBarHeightChange(Sender: TObject);
    procedure chkOpenTreeFromSalesOrderClick(Sender: TObject);
    procedure chkCapacityplannerSelectionOptionBeforeLoadClick(Sender: TObject);
    procedure chkHideSelectedSubnodesinReportClick(Sender: TObject);
    procedure chkAutoclockOnemployeeOnjobClick(Sender: TObject);
    procedure chkCompleteBOMOrderOnSaveClick(Sender: TObject);
    procedure chkAutoScheduleBasedonBOMEmpRosterClick(Sender: TObject);
	  procedure chkOnlyshowScheduledJobsForBarCodeManClick(Sender: TObject);
    procedure edtCostDecimalPlacesinTreeChange(Sender: TObject);
    procedure cboDefaultBOMWastageAccountChange(Sender: TObject);
    procedure cboBoMNonProductsubnodePostingAccountChange(Sender: TObject);
    procedure chkShowAllEmployeesinProductionSchedulerClick(Sender: TObject);
    procedure chkResetSaleDateWhenBuiltClick(Sender: TObject);
    procedure chkDefaultCoupenTimeinWOTimesheetClick(Sender: TObject);
    procedure DoReportOptionsforProgressbuild(Sender: TObject);
    //procedure BeforeReportsShow(Sender : TObject);
    procedure DoReportOptionsforProgressbuildWastage(Sender: TObject);
    procedure chkUseSteelWeightClick(Sender: TObject);
    procedure btnSetupReportProductionprogressClick(Sender: TObject);
    procedure chkPrintOnItemProgressClick(Sender: TObject);
    procedure chkPrintOnItemcompletionClick(Sender: TObject);
    procedure lblHint1MouseDown(Sender: TObject; Button: TMouseButton;      Shift: TShiftState; X, Y: Integer);
    procedure chkUpdateProductDescriptionFromTreeInfoClick(Sender: TObject);
    procedure optCopyInfotoSalesDescClick(Sender: TObject);
    procedure chkRoundBatchQtyinProgressBatchCreatorClick(Sender: TObject);
    procedure chkUseCurrentCostforProgressBuildClick(Sender: TObject);
    procedure chkAutoAllocateProcessForTreeRootClick(Sender: TObject);
    procedure chkConfirmQtysOnfinaliseClick(Sender: TObject);
    procedure cboDefaultProcessforTreeChange(Sender: TObject);
    procedure edtDefaultTreeProcessDurationChange(Sender: TObject);
    procedure chkOnPPGErrorSendEmailClick(Sender: TObject);
    procedure cboPPErrorEmailToChange(Sender: TObject);
    procedure optBomSalesPriceOptionsClick(Sender: TObject);
    procedure optBuildDetailsUpdateOptionClick(Sender: TObject);
    procedure btnPPGBalanceAdjAccountClick(Sender: TObject);
    procedure btnPPGBalanceAdjEmployeeClick(Sender: TObject);
  private
    Prefs: TBusObjProcPrefs;
    DoingStartUp: boolean;
    //fiReporttypeIDforreportOptions:Integer;
    procedure PerformStartup(var Msg: TMessage); message TX_PerformStartup;
    procedure PerformFinish(var Msg: TMessage); message TX_PerformFinish;
    procedure SetcolorComp(TrackBar: TAdvTrackBar;colorSelector: TAdvOfficeColorSelector; colour, Intensity: Integer);
    procedure DoOnChangeData(const aPropName, acleanValue, aNewValue: String);
    procedure ChooseAccount(Sender: TwwDbGrid);
    procedure ChooseEmployee(Sender: TwwDbGrid);
  Protected
      procedure StartupProcess(var Msg: TMessage); Override;
      procedure FinishProcess(var Msg: TMessage); Override;

  public
    { Public declarations }
  end;

implementation

uses
  CommonLib, CommonFormLib, AppEnvironment, GraphUtil, tcConst,
  frmPrintRepots, CommonDbLib, ProcessUtils, Preferences, BusObjGLAccount,
  BusObjEmployee;


{$R *.dfm}

{ TProcessPrefsGUI }
procedure TProcessPrefsGUI.DoOnChangeData(const aPropName, acleanValue, aNewValue: String);
begin
    if  Preferenceform <> nil then
    if Preferenceform  is TPreferencesGUI then
      TPreferencesGUI(Preferenceform).DoOnchangedDataSave('TBusObjProcPrefs', aPropName, acleanValue, aNewValue);
end;
procedure TProcessPrefsGUI.FormCreate(Sender: TObject);
begin
  //fiReporttypeIDforreportOptions := 0;
  inherited;
  { NOTE: Prefs object is created here with form as owner so that Preferences
          unit can assign its in-transaction db connection which will ultimatly
          commit or rollback anything saved on this form. }
  Prefs:= TBusObjProcPrefs.Create(self);
  Prefs.OnChangeData := DoOnChangeData;
  Prefs.IgnoreAccesslevel:= true;
  Prefs.Load;
  DoingStartUp:= false;
  chkProductionOnSaturdays.Enabled:= Appenv.companyprefs.NoofWeekendDays >=2;
  qryDefaultBOMWastageAccount.connection := GetSharedMyDacConnection;
  qryBoMNonProductsubnodePostingAccount.connection := GetSharedMyDacConnection;
  qryProcessSteps.connection := GetSharedMyDacConnection;
  cboEmployeeLookup.connection := GetSharedMyDacConnection;
  lblHint1.caption := 'These Reports are Printed from'+NL+'"Progress Build"';
  lblHint2.caption := 'These Reports are Printed from'+NL+'"Production Order Report"';
end;

procedure TProcessPrefsGUI.lblHint1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if ssCtrl in Shift then
     if Button = mbLeft then
      OpenERPForm('TfmProcProgress' , 0);
end;


procedure TProcessPrefsGUI.SetcolorComp(TrackBar:TAdvTrackBar;colorSelector :TAdvOfficeColorSelector; colour, Intensity:Integer);
begin
  colorSelector.SelectedColor  := TColor(colour);
  TrackBar.Position            := Intensity;
  TrackBar.Color               := colorSelector.SelectedColor;
  TrackBar.ColorTo             := ColorAdjustLuma(TrackBar.Color,TrackBar.Position, False);
end;
procedure TProcessPrefsGUI.chkResourceAvailableForHolidaysClick             (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.ResourceNotAvailableForHolidays          := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkShowAllEmployeesinProductionSchedulerClick    (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.ShowAllEmployeesinProductionScheduler    := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkUseCurrentCostforProgressBuildClick           (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.UseCurrentCostforProgressBuild           := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkAutoAllocateProcessForTreeRootClick           (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.AutoAllocateProcessForTreeRoot           := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkOnPPGErrorSendEmailClick                      (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.OnPPGErrorSendEmail                      := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkConfirmQtysOnfinaliseClick                    (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.ConfirmQtysOnfinalise                    := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkUseSteelWeightClick                           (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.UseFld7AsSteelWeight                     := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkRoundBatchQtyinProgressBatchCreatorClick      (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.RoundBatchQtyinProgressBatchCreator      := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkUpdateProductDescriptionFromTreeInfoClick     (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.UpdateProductDescriptionFromTreeInfo     := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkWarnTemplateProcessesNotDefinedClick          (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.WarnTemplateProcessesNotDefined          := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkAutoScheduleBasedonBOMEmpRosterClick          (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.AutoScheduleBasedonBOMEmpRoster          := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkWarnTemplateOptionDefaultNotDefinedClick      (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  prefs.WarnTemplateOptionDefaultNotDefined      := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkProdPlanConfirmSaveClick                      (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.ProdPlanConfirmSave                      := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkProductionOnSaturdaysClick                    (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.ScheduleProductionOnWeekendDays          := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkOpenTreeFromSalesOrderClick                   (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  prefs.OpenTreeFromSalesOrder                   := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkOpenTreeOnSmartOrdercreationClick             (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  prefs.OpenTreeOnSmartOrdercreation             := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkAutoCreateSmartOrderFromSalesOrderTreeClick   (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  prefs.AutoCreateSmartOrderFromSalesOrderTree   := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkPrintOnItemProgressClick                      (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  prefs.PrintOnItemProgress                      := TwwCheckBox(Sender).Checked; chkPrintOnItemcompletion.checked := not( chkPrintOnItemProgress.checked); end;
procedure TProcessPrefsGUI.chkPrintOnItemcompletionClick                    (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  prefs.PrintOnItemcompletion                    := TwwCheckBox(Sender).Checked; chkPrintOnItemProgress.checked   := not( chkPrintOnItemcompletion.checked);end;
procedure TProcessPrefsGUI.chkCapacityplannerSelectionOptionBeforeLoadClick (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  prefs.CapacityplannerSelectionOptionBeforeLoad := TwwCheckBox(Sender).Checked;ShowHintmsg(Screen.activecontrol ,chkCapacityplannerSelectionOptionBeforeLoad);end;
procedure TProcessPrefsGUI.chkHideSelectedSubnodesinReportClick             (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  prefs.HideSelectedSubnodesinReport          := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.edtAllocationWarningDaysChange                   (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.AllocationWarningDays                 := TAdvSpinEdit(Sender).Value;end;
procedure TProcessPrefsGUI.edtCapacityPlanningWeeksChange                   (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.CapacityPlanningWeeksToShow           := TAdvSpinEdit(Sender).Value;end;
procedure TProcessPrefsGUI.edtAutoSchedGraceDaysChange                      (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.AutoProdPlanSchedGraceDays            := TAdvSpinEdit(Sender).Value;end;
procedure TProcessPrefsGUI.edtBarHeightChange                               (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.GanttChartBarHeight                   := TAdvSpinEdit(Sender).Value;end;
procedure TProcessPrefsGUI.edtDefaultTreeProcessDurationChange              (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.DefaultTreeProcessDuration            := StrToProcTime(StringReplace(edtDefaultTreeProcessDuration.text,' ','0',[rfReplaceAll]));end;
procedure TProcessPrefsGUI.rgAutoSchedTypeClick                             (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.AutoProdPlanSchedType                 := TAutoProdPlanSchedType(TAdvOfficeRadioGroup(Sender).ItemIndex);end;
procedure TProcessPrefsGUI.cboGanttChartDrawStyleChange                     (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  Prefs.GanttChartDrawStyle                   := strtoInt(cboGanttChartDrawStyle.Value);end;
procedure TProcessPrefsGUI.chkAutoclockOnemployeeOnjobClick                 (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  prefs.AutoclockOnemployeeOnjob              := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkCompleteBOMOrderOnSaveClick                   (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  prefs.CompleteBOMOrderOnSave                := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkDefaultCoupenTimeinWOTimesheetClick           (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  prefs.DefaultCoupenTimeinWOTimesheet        := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkResetSaleDateWhenBuiltClick                   (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  prefs.ResetSaleDateWhenBuilt                := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.chkOnlyshowScheduledJobsForBarCodeManClick       (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  prefs.OnlyshowScheduledJobsForBarCodeMan    := TwwCheckBox(Sender).Checked;end;
procedure TProcessPrefsGUI.edtCostDecimalPlacesinTreeChange                 (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  try    prefs.CostDecimalPlacesinTree        := strToint(edtCostDecimalPlacesinTree.text);  except  end;end;
procedure TProcessPrefsGUI.cboDefaultBOMWastageAccountChange                (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  prefs.DefaultBOMWastageAccount              := cboDefaultBOMWastageAccount.text;  end;
procedure TProcessPrefsGUI.cboBoMNonProductsubnodePostingAccountChange      (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  prefs.BoMNonProductsubnodePostingAccount    := cboBoMNonProductsubnodePostingAccount.text;  end;
procedure TProcessPrefsGUI.cboDefaultProcessforTreeChange                   (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  prefs.DefaultProcessforTree                 := cboDefaultProcessforTree.text;  end;
procedure TProcessPrefsGUI.cboPPErrorEmailToChange                          (Sender: TObject);begin  if (not Assigned(Prefs)) or DoingStartUp then exit;  prefs.PPErrorEmailTo                        := cboPPErrorEmailTo.text;  end;
procedure TProcessPrefsGUI.chkManufacturePartSourceStockconfirmClick        (Sender: TObject);
begin
  inherited;
  if (not Assigned(Prefs)) or DoingStartUp then exit;
  if chkManufacturePartSourceStockconfirm.checked then
    chkManufacturePartSourceStock.checked := False;
  Prefs.ManufacturePartSourceStockConfirm:= chkManufacturePartSourceStockconfirm.Checked;
  Prefs.ManufacturePartSourceStock:= chkManufacturePartSourceStock.Checked;
  ShowHintmsg(Screen.activecontrol ,chkManufacturePartSourceStockconfirm);
end;



procedure TProcessPrefsGUI.chkManufacturePartSourceStockClick(Sender: TObject);
begin
  inherited;
  if (not Assigned(Prefs)) or DoingStartUp then exit;
  if chkManufacturePartSourceStock.checked then
    chkManufacturePartSourceStockconfirm.checked := False;
  Prefs.ManufacturePartSourceStock:= chkManufacturePartSourceStock.Checked;
  Prefs.ManufacturePartSourceStockConfirm:= chkManufacturePartSourceStockconfirm.Checked;
  ShowHintmsg(Screen.activecontrol ,chkManufacturePartSourceStock);
end;

procedure TProcessPrefsGUI.optCopyInfotoSalesDescClick(Sender: TObject);
begin
  inherited;
    if (not Assigned(Prefs)) or DoingStartUp then exit;
    prefs.CopyTreeInfotoSalesDesc                  := (optCopyInfotoSalesDesc.itemindex =0);
    Prefs.UpdateSalesDescriptionFromTreeInfo       := (optCopyInfotoSalesDesc.itemindex =1);
end;

procedure TProcessPrefsGUI.optBomSalesPriceOptionsClick(Sender: TObject);
begin
  inherited;
    if (not Assigned(Prefs)) or DoingStartUp then exit;
    prefs.IgnoreBOMCalcPriceOnSale            := (optBomSalesPriceOptions.itemindex =0);
    prefs.BOMPriceOverridesAllOtherPrice      := (optBomSalesPriceOptions.itemindex =1);
    prefs.CSPOverridesRawMaterialPrices      := (optBomSalesPriceOptions.itemindex =2);
end;

procedure TProcessPrefsGUI.optBuildDetailsUpdateOptionClick(Sender: TObject);
begin
  inherited;
    if (not Assigned(Prefs)) or DoingStartUp then exit;
    if optBuildDetailsUpdateOption.itemindex =0 then prefs.BuildDetailsUpdateOption := 'R'
    else if optBuildDetailsUpdateOption.itemindex =1 then prefs.BuildDetailsUpdateOption := 'A'
    else prefs.BuildDetailsUpdateOption := 'N';
end;

procedure TProcessPrefsGUI.btnPPGBalanceAdjAccountClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TChartOfAccountsListExpressGUI', ChooseAccount);
end;
procedure TProcessPrefsGUI.ChooseAccount(Sender: TwwDbGrid);
begin
   prefs.PPGBalanceAdjAccountID := Sender.Datasource.Dataset.fieldbyname('AccountId').asInteger;
   edtPPGBalanceAdjAccount.Text:= TAccount.IDToggle(Prefs.PPGBalanceAdjAccountID);
end;

procedure TProcessPrefsGUI.btnPPGBalanceAdjEmployeeClick(Sender: TObject);
begin
  inherited;
  OpenERPListFormSingleselectModal('TEmployeeExpresslistGUI', ChooseEmployee);
end;
procedure TProcessPrefsGUI.ChooseEmployee(Sender: TwwDbGrid);
begin
   prefs.PPGBalanceAdjEmployeeID := Sender.Datasource.Dataset.fieldbyname('EmployeeId').asInteger;
   edtPPGBalanceAdjEmployee.text := TEmployee.IDToggle(Prefs.PPGBalanceAdjEmployeeID);
end;

procedure TProcessPrefsGUI.btnSetupReportProductionprogressClick (Sender: TObject);begin  inherited;  TfmPrintRepots.DoPrintTemplateReport(self, 'ProductionProgressBuild', '' ,nil);end;
procedure TProcessPrefsGUI.DoReportOptionsforProgressbuild       (Sender: TObject);begin  inherited;  TfmPrintRepots.DoPrintTemplateReport(self, 'Progress Build'      , '' ,nil);end;
procedure TProcessPrefsGUI.DoReportOptionsforProgressbuildWastage(Sender: TObject);begin  inherited;  TfmPrintRepots.DoPrintTemplateReport(self, 'ProcProgressBuildWastae', '' ,nil);end;
procedure TProcessPrefsGUI.PerformStartup(var Msg: TMessage);
begin
  DoPerformStartup(Msg);
end;

procedure TProcessPrefsGUI.StartupProcess(var Msg: TMessage);
begin
  inherited;
  DoingStartUp:= true;
  try
    opendb(qryDefaultBOMWastageAccount);
    opendb(qryBoMNonProductsubnodePostingAccount);
    opendb(qryProcessSteps);
    opendb(cboEmployeeLookup);
    chkResourceAvailableForHolidays.Checked:= Prefs.ResourceNotAvailableForHolidays;
    edtAllocationWarningDays.Value:= Prefs.AllocationWarningDays;
    chkWarnTemplateProcessesNotDefined.Checked:= Prefs.WarnTemplateProcessesNotDefined;
    chkUseCurrentCostforProgressBuild.Checked:= Prefs.UseCurrentCostforProgressBuild;
    chkAutoAllocateProcessForTreeRoot.Checked:= Prefs.AutoAllocateProcessForTreeRoot;
    chkOnPPGErrorSendEmail.Checked:= Prefs.OnPPGErrorSendEmail;
    chkConfirmQtysOnfinalise.Checked:= Prefs.ConfirmQtysOnfinalise;
    chkAutoScheduleBasedonBOMEmpRoster.Checked:= Prefs.AutoScheduleBasedonBOMEmpRoster;
    chkWarnTemplateOptionDefaultNotDefined.Checked:= Prefs.WarnTemplateOptionDefaultNotDefined;
    chkProductionOnSaturdays.Checked:= Prefs.ScheduleProductionOnWeekendDays;
    edtCapacityPlanningWeeks.Value:= Prefs.CapacityPlanningWeeksToShow;
    edtAutoSchedGraceDays.Value:= Prefs.AutoProdPlanSchedGraceDays;
    rgAutoSchedType.ItemIndex:= Integer(Prefs.AutoProdPlanSchedType);
    chkProdPlanConfirmSave.Checked:= Prefs.ProdPlanConfirmSave;
    chkShowAllEmployeesinProductionScheduler.Checked:= Prefs.ShowAllEmployeesinProductionScheduler;
    chkManufacturePartSourceStock.Checked:= Prefs.ManufacturePartSourceStock;
    chkManufacturePartSourceStockConfirm.Checked:= Prefs.ManufacturePartSourceStockConfirm;
    chkAutoCreateSmartOrderFromSalesOrderTree.Checked := Prefs.AutoCreateSmartOrderFromSalesOrderTree;
    chkPrintOnItemProgress.Checked := Prefs.PrintOnItemProgress;
    chkPrintOnItemcompletion.Checked := Prefs.PrintOnItemcompletion;
    chkOpenTreeOnSmartOrdercreation.Checked :=Prefs.OpenTreeOnSmartOrdercreation;
    chkResetSaleDateWhenBuilt.Checked :=Prefs.ResetSaleDateWhenBuilt;
    chkDefaultCoupenTimeinWOTimesheet.Checked :=Prefs.DefaultCoupenTimeinWOTimesheet;
    chkOpenTreeFromSalesOrder.Checked :=Prefs.OpenTreeFromSalesOrder;
    chkCapacityplannerSelectionOptionBeforeLoad.Checked :=prefs.CapacityplannerSelectionOptionBeforeLoad;
    chkHideSelectedSubnodesinReport.Checked :=prefs.HideSelectedSubnodesinReport;
    edtCostDecimalPlacesinTree.text := Inttostr(Prefs.CostDecimalPlacesinTree);
    edtPPGBalanceAdjAccount.text := TAccount.IDToggle(Prefs.PPGBalanceAdjAccountID);
    edtPPGBalanceAdjEmployee.text := TEmployee.IDToggle(Prefs.PPGBalanceAdjEmployeeID);
    cboDefaultBOMWastageAccount.text := Prefs.DefaultBOMWastageAccount;
    cboBoMNonProductsubnodePostingAccount.text := Prefs.BoMNonProductsubnodePostingAccount;
    cboDefaultProcessforTree.text := Prefs.DefaultProcessforTree;
    cboPPErrorEmailTo.text := Prefs.PPErrorEmailTo;
    chkAutoclockOnemployeeOnjob.Checked :=prefs.AutoclockOnemployeeOnjob;
    chkCompleteBOMOrderOnSave.Checked :=prefs.CompleteBOMOrderOnSave;
    chkOnlyshowScheduledJobsForBarCodeMan.Checked :=prefs.OnlyshowScheduledJobsForBarCodeMan;
    chkManufacturePartSourceStockconfirm.Checked :=Prefs.ManufacturePartSourceStockconfirm;
    chkUseSteelWeight.Checked := Prefs.UseFld7AsSteelWeight;
    chkRoundBatchQtyinProgressBatchCreator.Checked := Prefs.RoundBatchQtyinProgressBatchCreator;
    chkUpdateProductDescriptionFromTreeInfo.Checked := Prefs.UpdateProductDescriptionFromTreeInfo;

         if prefs.CopyTreeInfotoSalesDesc then optCopyInfotoSalesDesc.itemindex := 0
    else if Prefs.UpdateSalesDescriptionFromTreeInfo then optCopyInfotoSalesDesc.itemindex := 1
    else optCopyInfotoSalesDesc.itemindex := 2;

    if prefs.IgnoreBOMCalcPriceOnSale            then  optBomSalesPriceOptions.itemindex :=0
    else if prefs.BOMPriceOverridesAllOtherPrice then  optBomSalesPriceOptions.itemindex :=1
    else if prefs.CSPOverridesRawMaterialPrices  then  optBomSalesPriceOptions.itemindex :=2
    else optBomSalesPriceOptions.itemindex :=3;

         if prefs.BuildDetailsUpdateOption ='R' then optBuildDetailsUpdateOption.itemindex := 0
    else if prefs.BuildDetailsUpdateOption ='A' then optBuildDetailsUpdateOption.itemindex := 1
    else optBuildDetailsUpdateOption.itemindex := 2;

    SetcolorComp(GanttChartGFStartColourIntensity           ,GanttChartGFStartColourColorselector ,Prefs.GanttChartGFStartColour            ,Prefs.GanttChartGFStartColourIntensity);
    SetcolorComp(GanttChartGFEndcolourIntensity             ,GanttChartGFEndcolourColorSelector   ,Prefs.GanttChartGFEndcolour              ,Prefs.GanttChartGFEndColourIntensity);
    SetcolorComp(ProductStatusPartQtyColourIntensity        ,ProductStatusPartQtyColour           ,PRefs.ProductStatusPartQtyColour         ,Prefs.ProductStatusPartQtyColourIntensity);
    SetcolorComp(ProductStatusTransQtyColourIntensity       ,ProductStatusTransQtyColour          ,Prefs.ProductStatusTransQtyColour        ,PRefs.ProductStatusTransQtyColourIntensity );
    SetcolorComp(ProductStatusOrderQtyColourIntensity       ,ProductStatusOrderQtyColour          ,Prefs.ProductStatusOrderQtyColour        ,Prefs.ProductStatusOrderQtyColourIntensity);
    SetcolorComp(ProductStatusETAWithinPeriodColourIntensity,ProductStatusETAWithinPeriodColour   ,PRefs.ProductStatusETAWithinPeriodColour ,Prefs.ProductStatusETAWithinPeriodColourIntensity);
    SetcolorComp(ProductStatusETAExceededColourIntensity    ,ProductStatusETAExceededColour       ,Prefs.ProductStatusETAExceededColour     ,Prefs.ProductStatusETAExceededColourIntensity);
    cboGanttChartDrawStyle.Value := inttostr(Prefs.GanttChartDrawStyle);
    edtBarHeight.Value := Prefs.GanttChartBarHeight;
    edtDefaultTreeProcessDuration.text  := ProcTimeToStr(Prefs.DefaultTreeProcessDuration);


    ShowcontrolHint(GanttChartGFStartColourIntensity, 'Defines the colour of the Graph Bars in'+NL+' ''Capacity Planning (Gantt Chart)'''+NL);
    ShowcontrolHint(GanttChartGFStartColourColorselector , GanttChartGFStartColourIntensity.Hint);
    ShowcontrolHint(GanttChartGFEndcolourIntensity, 'Defines the colour of the Graph Bars in'+NL+'''Capacity Planning (Gantt Chart)'''+NL);
    ShowcontrolHint(GanttChartGFEndcolourColorSelector , GanttChartGFEndcolourIntensity.Hint);
    ShowcontrolHint(ProductStatusPartQtyColourIntensity, 'Defines the colour of the Product Quantity Columns '+NL+'- ''Available'' , ''Instock'' , ''On Order'' - '+NL+'in ''BOM Product Status'' Report'+NL);
    ShowcontrolHint(ProductStatusPartQtyColour , ProductStatusPartQtyColourIntensity.Hint);
    ShowcontrolHint(ProductStatusTransQtyColourIntensity, 'Defines the colour of the Transaction Quantity Columns '+NL+'- ''From Stock'' , ''To Build'' , ''On Order'' - '+NL+'in ''BOM Product Status'' Report'+NL);
    ShowcontrolHint(ProductStatusTransQtyColour,ProductStatusTransQtyColourIntensity.Hint);
    ShowcontrolHint(ProductStatusOrderQtyColourIntensity, 'Defines the colour of the Order Quantity Columns '+NL+'- ''Ordered'' , ''Received'' , ''Back Order'' - '+NL+'in ''BOM Product Status'' Report'+NL);
    ShowcontrolHint(ProductStatusOrderQtyColour , ProductStatusOrderQtyColourIntensity.Hint);
    ShowcontrolHint(ProductStatusETAWithinPeriodColourIntensity, 'Defines the colour of the line in report when expected to arrive in future.'+NL+
                                                              'Date has not Exceeded if the Purchase ''ETA Date'' - ''Employee Preference.Backorders to Receive'' >= current Date.'+NL+
                                                              'Make Sure you turn on the ''Employee Preference.Backorders to Receive'' for this to work'+NL);
    ShowcontrolHint(ProductStatusETAWithinPeriodColour , ProductStatusETAWithinPeriodColourIntensity.Hint);
    ShowcontrolHint(ProductStatusETAExceededColourIntensity, 'Defines the colour of the line in report where the ''ETA Date'' has exceeded.'+NL+
                                                              'Date has Exceeded if the Purchase ''ETA Date'' - ''Employee Preference.Backorders to Receive'' < current Date.'+NL+
                                                              'Make Sure you turn on the ''Employee Preference.Backorders to Receive'' for this to work'+NL);
    ShowcontrolHint(ProductStatusETAExceededColour , ProductStatusETAExceededColourIntensity.Hint);
    ShowcontrolHint(chkCapacityplannerSelectionOptionBeforeLoad , 'When checked' +NL +char(VK_TAB)+'Will provide an option to select to filter the data for  ''Capacity planner'' and ''Capacity Planning (Gantt Chart)''.' +NL +
                                                                                      char(VK_TAB)+'The Employee Preference will let you Enable / Disable this feature for the currently logged in Employee.'+NL);
    ShowcontrolHint(chkOpenTreeFromSalesOrder , 'When checked' +NL +char(VK_TAB)+'Adding a Manufature Product to Sales order will Load and open the tree.' +NL +
                                                                    char(VK_TAB)+'The Employee Preference will let you Enable / Disable this feature for the currently logged in Employee.'+NL);
    ShowcontrolHint(chkManufacturePartSourceStockconfirm , 'When checked' +NL +char(VK_TAB)+'Adding a Manufature Product to Sales order will Confirm the product Source.' +NL +
                                                                    char(VK_TAB)+'The Employee Preference will let you Enable / Disable this feature for the currently logged in Employee.'+NL);
    ShowcontrolHint(chkManufacturePartSourceStock , 'When checked' +NL +char(VK_TAB)+'Adding a Manufature Product to Sales order will automatically Assign it from Stock.' +NL +
                                                                    char(VK_TAB)+'The Employee Preference will let you Enable / Disable this feature for the currently logged in Employee.'+NL);
    lblResetSaleDateWhenBuilthint.caption := ' In Sales Orders with Serialised Products, When Progress Built Date is Prior to Sales Order Date, ' + NL+
                                                '       When Checked : Reset Order Date to be Prior to the Build Date(To Track Serial Number Availability)'+NL+
                                                ' When Not Checked : Progress Build Will only Allow to Choose Orders With Date Prior to the Build Date'+NL;
    lblResetSaleDateWhenBuilthint.Refresh;
    lblResetSaleDateWhenBuilthint.Width := Bevel8.Width - lblResetSaleDateWhenBuilthint.Left;

    lblUseCurrentCostforProgressBuildhint.caption := 'When checked, '+NL+
                                                     '     Raw Matrial''s Current Avg. Cost (Avg. Cost of the Product at the Time of Transaction)'+NL+
                                                     '     will be used. ie: For a BOM Sales Order, the Cost at the time of ''Progress Build'' will be '+NL+
                                                     '     used, not the Cost at the time of ''Sales Order''. '+NL+NL+
                                                     '     Note: Changing this Preference will not fix the Cost of any Existing Transactions.';

    Showcontrolhint( optBomSalesPriceOptions ,'Ignore Price Calculation from BOM Price and Use Main Price :-> Price Calculated Based on Product Card Main Price and all Discounts Applied to it' +NL+
                                              'Calculate Price from Sales BOM :-> Price is Calculated based on the Sales BOM Price and all Discounts Applied to it.' +NL+
                                              'Customer''s Special Price Overrides Calculated Price (If Provided) :-> Customer''s Special Price is used and NO Other Discount Applied.' +NL+
                                              'Standard Pricing :-> The lowest price is used');
    ShowcontrolHint(optBuildDetailsUpdateOption , 'Update Product_Description_Memo Field will be updated with the Tree Details.'+NL+
                                               'Tree Details includes the Products in the Tree and its Quantities');
  finally
    DoingStartUp:= false;
  end;
end;
procedure TProcessPrefsGUI.PerformFinish(var Msg: TMessage);
begin
  DoPrefformFinish(Msg);
end;
procedure TProcessPrefsGUI.FinishProcess(var Msg: TMessage);
begin
  Prefs.GanttChartGFStartColour           := Integer(GanttChartGFStartColourColorselector.SelectedColor);
  Prefs.ProductStatusPartQtyColour        := Integer(ProductStatusPartQtyColour.SelectedColor);
  Prefs.ProductStatusTransQtyColour       := Integer(ProductStatusTransQtyColour.SelectedColor);
  Prefs.ProductStatusOrderQtyColour       := Integer(ProductStatusOrderQtyColour.SelectedColor);
  Prefs.ProductStatusETAWithinPeriodColour:= Integer(ProductStatusETAWithinPeriodColour.SelectedColor);
  Prefs.ProductStatusETAExceededColour    := Integer(ProductStatusETAExceededColour.SelectedColor);
  Prefs.GanttChartGFEndColour             := Integer(GanttChartGFEndColourColorselector.SelectedColor);

  Prefs.GanttChartGFStartColourIntensity            := GanttChartGFStartColourIntensity.Position;
  Prefs.GanttChartGFEndColourIntensity              := GanttChartGFEndColourIntensity.Position;
  Prefs.ProductStatusPartQtyColourIntensity         := ProductStatusPartQtyColourIntensity.Position;
  Prefs.ProductStatusTransQtyColourIntensity        := ProductStatusTransQtyColourIntensity.Position;
  Prefs.ProductStatusOrderQtyColourIntensity        := ProductStatusOrderQtyColourIntensity.Position;
  Prefs.ProductStatusETAWithinPeriodColourIntensity := ProductStatusETAWithinPeriodColourIntensity.Position;
  Prefs.ProductStatusETAExceededColourIntensity     := ProductStatusETAExceededColourIntensity.Position;
  Prefs.Save;
end;

initialization
  RegisterClassOnce(TProcessPrefsGUI);
finalization
  UnRegisterClass(TProcessPrefsGUI);
end.
