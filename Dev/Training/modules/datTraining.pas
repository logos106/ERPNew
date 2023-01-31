unit datTraining;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ActionsObj, Dialogs, BaseGUIDatamodule, ImgList, ActnList, DNMAction, Menus, AdvMenus, frmReportSelectorFrm;

type
  TdtTraining = class(TdtmGUI)
    ActionList: TActionList;
    MainMenu: TAdvMainMenu;
    rainingAssignment1: TMenuItem;
    actTrainingAssignment: TDNMAction;
    actTrainingRoster: TDNMAction;
    actTrainingProgresschart: TDNMAction;
    actTrainingStatus: TDNMAction;
    actTrainingModule: TDNMAction;
    rainingAssignment2: TMenuItem;
    rainingRoster1: TMenuItem;
    rainingProgressChart1: TMenuItem;
    rainingStatus1: TMenuItem;
    rainingModules1: TMenuItem;
    actSetupTraining: TDNMAction;
    actVideos: TDNMAction;
    actCustomisetraining: TDNMAction;
    actSetupcompany: TDNMAction;
    actTrainingList: TDNMAction;
    actGoLive: TDNMAction;
    GoLive1: TMenuItem;
    actHowToList: TDNMAction;
    actTrainingDocs: TDNMAction;
    trainingDocs1: TMenuItem;
    actHRForm: TDNMAction;
    actHRForms: TDNMAction;
    HRForm1: TMenuItem;
    HRForm2: TMenuItem;
    HRForm3: TMenuItem;
    procedure actCustomisetrainingExecute(Sender: TObject);
  private
  Protected
    procedure DoAddReports(Const ReportSelector: TfrmReportSelectorGUI); Override;

  public
  Published
    function GetItem(const ActionName: string): TActionHelperItem;
  end;

implementation

uses CommonLib, GlobalEventsObj, FastFuncs,
  MainSwitchFrm2;

{$R *.dfm}

procedure TdtTraining.DoAddReports(Const ReportSelector: TfrmReportSelectorGUI);
begin
    if Assigned(ReportSelector) then begin
      //ReportSelector.Add(REPORT_GROUP_BUDGET, 'Account List For Budget', 'TChartOfAccountsListGUI', 0);
    end;

end;

function TdtTraining.GetItem(const ActionName: string): TActionHelperItem;
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
procedure TdtTraining.actCustomisetrainingExecute(Sender: TObject);
begin
  inherited;
  if FormStillOpen('TMainSwitch2') then begin
    with TMainSwitch2(GetComponentByClassName('TMainSwitch2')) do begin
      Docustomise(Sender);
    end
  end;
end;

end.
