unit datRepairs;

interface

uses
  SysUtils, Classes, ActnList, DNMAction, ImgList, Controls, Menus,
  AdvMenus, BaseGUIDatamodule, ActionsObj, frmReportSelectorFrm;

type
  TdtRepairs = class(TdtmGUI)
    MainMenu: TAdvMainMenu;
    Repairs: TMenuItem;
    ActionList: TActionList;
    NewRepair1: TMenuItem;
    N1: TMenuItem;
    RepairsList1: TMenuItem;
    actNewRepair: TDNMAction;
    actRepairsLsit: TDNMAction;
    actRepairsExpressLsit: TDNMAction;
    actRepairListInvocie: TDNMAction;
    actRepairfaults: TDNMAction;
    actNewRepairfault: TDNMAction;
    actmanufacture: TDNMAction;
    actManufactureList: TDNMAction;
    actRepairStatusChoice: TDNMAction;
    RepairStatusChoice1: TMenuItem;
    actEmpCalendar: TDNMAction;
    N2: TMenuItem;
    actEmpCalendar1: TMenuItem;
    actRepairSummary: TDNMAction;
    RepairSummary2: TMenuItem;
    actCustomFieldValuesListReapirs: TDNMAction;
    actCustomFieldValuesReapirs: TDNMAction;

    procedure actRepairStatusChoiceExecute(Sender: TObject);
  private
  Protected
    procedure DoAddReports(Const ReportSelector: TfrmReportSelectorGUI); Override;
  public
  Published
    function GetItem(const ActionName: string): TActionHelperItem;
  end;


implementation

uses CommonLib, GlobalEventsObj, FastFuncs,
  frmSimpleTypeActions, BusObjConst, tcconst ;

{$R *.dfm}

{ TDataModule1 }

procedure TdtRepairs.DoAddReports(Const ReportSelector: TfrmReportSelectorGUI);
begin
    if Assigned(ReportSelector) then begin
      ReportSelector.Add(REPORT_GROUP_WORKSHOP, 'Equipment List'     , 'TEquipmentListGUI'    , 0);
      ReportSelector.Add(REPORT_GROUP_WORKSHOP, 'Fixed Asset Repair List', 'TfmFixedAssetRepairList', 0);
      ReportSelector.Add(REPORT_GROUP_WORKSHOP, 'Repairs KPI List', 'TfmRepairsKPIList', 0);
      ReportSelector.Add(REPORT_GROUP_WORKSHOP, 'Repairs List'       , 'TRepairsList'     , 0);
      ReportSelector.Add(REPORT_GROUP_WORKSHOP, 'Repairs List (Invoice)'       , 'TRepairInvoiceListGUI'     , 0);
      ReportSelector.Add(REPORT_GROUP_WORKSHOP, 'Repair Profitability', 'TRepairProfitabilityGUI', 0);
      ReportSelector.Add(REPORT_GROUP_WORKSHOP, 'Repairs Summary', 'TRepairSummaryGUI', 0);


      ReportSelector.Add(REPORT_GROUP_WORKSHOP, 'Product List'       , 'TProductListExpressGUI'     , 0);
    end;
end;

function TdtRepairs.GetItem(const ActionName: string): TActionHelperItem;
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

procedure TdtRepairs.actRepairStatusChoiceExecute(Sender: TObject);
begin
  inherited;
  TfmSimpleTypeActions.ListSimpleTypeActions(SimpleTypes_StatusType);
end;

end.
