unit datHire;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseGUIDatamodule, Menus, AdvMenus, ActnList , frmReportSelectorFrm,
  DNMAction;

type
  TdtHire = class(TdtmGUI)
    MainMenu: TAdvMainMenu;
    Repairs: TMenuItem;
    NewRepair1: TMenuItem;
    N1: TMenuItem;
    RepairsList1: TMenuItem;
    N2: TMenuItem;
    actEmpCalendar1: TMenuItem;
    ActionList: TActionList;
    actHire: TDNMAction;
    actHireList: TDNMAction;
    actDurationList: TDNMAction;
    actDuration: TDNMAction;
    actHireEquipmentList: TDNMAction;
    actHireListDetails: TDNMAction;
    actSetupHire: TDNMAction;
    actHireItemDetails: TDNMAction;
    HireItemDetails1: TMenuItem;
    actHireHistory: TDNMAction;
    HireHistory1: TMenuItem;
    actHireAvailability: TDNMAction;
    HireAvailability1: TMenuItem;
    actHirePlanner: TDNMAction;
    actStockToAsset: TDNMAction;
    actStockToAssetList: TDNMAction;
  private
  Protected
    procedure DoAddReports(Const ReportSelector: TfrmReportSelectorGUI); Override;
  public

  end;

implementation

uses tcConst, GlobalEventsObj;


{$R *.dfm}

{ TdtHire }

procedure TdtHire.DoAddReports(const ReportSelector: TfrmReportSelectorGUI);
begin
  inherited;
    if Assigned(ReportSelector) then begin
//      ReportSelector.Add(REPORT_GROUP_HIRE, 'Hire Product List'     , 'THireProductListGUI'    , 0);
    end;
end;
end.
