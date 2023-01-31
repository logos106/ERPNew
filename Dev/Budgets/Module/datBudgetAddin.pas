unit datBudgetAddin;
  { This is a template for the addition of "Addin" functionality to ERP using
   dynamically loaded packages.

   One of thes Addin units should be created for each Addin package.
   This DataModule is created when the Addin package is loaded and its job is
   to add the required user funcionality contained in the package to the main
   ERP core application.

   Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   18/11/05  1.00.01 DLS  Initial version
   22/12/05  1.00.02 BJ   New option for the Profit and loss report}
{  ActionImageIndexes: (169,345,346,347,348,350,351,326,327,302,70)  }
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  BaseGUIDatamodule, ActionsObj, ImgList, ActnList, DNMAction, Menus, AdvMenus , frmReportSelectorFrm;

type 
  TdmBudgetAddin = class(TdtmGUI)
    MainMenu: TAdvMainMenu;
    Budgets1: TMenuItem;
    BudgetDefinition1: TMenuItem;
    BudgetDefinitionList1: TMenuItem;
    Budgets2: TMenuItem;
    BudgetList1: TMenuItem;
    N1: TMenuItem;
    BudgetVariation1: TMenuItem;
    BudgetVsActualREport1: TMenuItem;
    N3: TMenuItem;
    ActionList: TActionList;
    actBudgetDefinition: TDNMAction;
    actBudgetDefinitionList: TDNMAction;
    actBudget: TDNMAction;
    actBudgetList: TDNMAction;
    actBudgetVariation: TDNMAction;
    actBudgetvsActual: TDNMAction;
    ProfitandLossReport1: TMenuItem;
    N4: TMenuItem;
    actBudgetProfitAndLossReport: TDNMAction;
    actReportsBudget: TDNMAction;
    AccountList1: TMenuItem;
    actBudgetAccountList: TDNMAction;
    JobBudgetVsActual1: TMenuItem;
    actJobBudgetVsActual: TDNMAction;
    N2: TMenuItem;
    procedure actReportsBudgetExecute(Sender: TObject);

  private
    { Private declarations }
  Protected
    procedure DoAddReports(Const ReportSelector: TfrmReportSelectorGUI); Override;
  public
  published
    function GetItem(const ActionName: string): TActionHelperItem;
  end;

implementation

uses
  AddinPackageInfoObj,  FastFuncs, CommonLib,
  GlobalEventsObj, tcConst, MainSwitchFrm2, dmMainGUI;


{$R *.dfm}
{$M+}        {don't delete!}

function TdmBudgetAddin.GetItem(const ActionName: string): TActionHelperItem;
var
  I: integer;
begin
  Result := nil;
  if ActionHelper.Count > 0 then for I := 0 to ActionHelper.ActionCount - 1 do
      if Sysutils.SameText(ActionHelper.Items[I].ActionName, ActionName) then begin
        Result := ActionHelper.Items[I];
        Break;
      end;
end;

procedure TdmBudgetAddin.DoAddReports(Const ReportSelector: TfrmReportSelectorGUI);
begin
    if Assigned(ReportSelector) then begin
      ReportSelector.Add(REPORT_GROUP_BUDGET, 'Account List For Budget', 'TChartOfAccountsListGUI', 0);
      ReportSelector.Add(REPORT_GROUP_BUDGET, 'Balance Sheet', 'TBalanceSheetGUI', 0);
      ReportSelector.Add(REPORT_GROUP_BUDGET, 'Budget List', 'TBudgetGUI', 0);
      ReportSelector.Add(REPORT_GROUP_BUDGET, 'Budget Vs Actual', 'TBudVsActListGUI', 0);
      ReportSelector.Add(REPORT_GROUP_BUDGET, 'Budget Vs Actual(Job)', 'TJobBudgetVsActual', 0);
      ReportSelector.Add(REPORT_GROUP_BUDGET, 'Budget Definition List', 'TBudgetDefGUI', 0);
      //ReportSelector.Add(REPORT_GROUP_BUDGET, 'Budget Variation', 'TfmBudgetVariation', 0);
      ReportSelector.Add(REPORT_GROUP_BUDGET, 'Budget Profit and Loss Report', 'TProfitandLossByPeriodGUI', 0);
    end;
end;

procedure TdmBudgetAddin.actReportsBudgetExecute(Sender: TObject);
begin
  inherited;
  //AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_BUDGET));
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_BUDGET));
end;

initialization
  if Assigned(AddinInfo) then AddinInfo.GuiDataModuleClass := TdmBudgetAddin;       {<-and here}
end.




