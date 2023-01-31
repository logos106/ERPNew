unit datDoorAddin;
{  ActionImageIndexes:
    (281,215,71,105,90,406,39,80,387,260,238,213,388,136,198,
            208,72,92,94,362,40,79,386,232,257,204,389,139,126)  ;
}
interface                     

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ImgList, Menus, AdvMenus,
  DNMAction, BaseGUIDatamodule, ActionsObj;

type
  TdtmDoorAddinClass = class of TdtmDoorAddin;
  TdtmDoorAddin = class(TdtmGUI)
    MainMenu: TAdvMainMenu;
    DoorsMenu: TMenuItem;
    ActionList: TActionList;
    actDoorcompDet: TDNMAction;
    actfmDoorComp: TDNMAction;
    actDoorCompDetGUI: TDNMAction;
    actdoorCompGUI: TDNMAction;
    compDet1: TMenuItem;
    compDetList1: TMenuItem;
    DoorDetailList1: TMenuItem;
    actDoorDetails: TDNMAction;
    actDoorDetGUI: TDNMAction;
    actDoorFinish: TDNMAction;
    actDoorFireRating: TDNMAction;
    actdoorIsDescription: TDNMAction;
    actdoorJoinery: TDNMAction;
    actdoorLipping: TDNMAction;
    actdoorstiles: TDNMAction;
    actdoorStoptype: TDNMAction;
    actdoorsundry: TDNMAction;
    actdoorVeneer: TDNMAction;
    actDoorfinishGUI: TDNMAction;
    actDoorFireRatingGUI: TDNMAction;
    actDoorIsDescriptionsGUI: TDNMAction;
    actDoorJoineryGUI: TDNMAction;
    actDoorLippingGUI: TDNMAction;
    actDoorStilesGUI: TDNMAction;
    actDoorStopTypeGUI: TDNMAction;
    actDoorSundryGUI: TDNMAction;
    actDoorVeneerGUI: TDNMAction;
    DoorVeneer2: TMenuItem;
    DoorSundry2: TMenuItem;
    DoorStopType2: TMenuItem;
    DoorStiles2: TMenuItem;
    DoorLipping2: TMenuItem;
    DoorJoinery2: TMenuItem;
    DoorIsdescriptions1: TMenuItem;
    DoorFireRating2: TMenuItem;
    DoorFinish2: TMenuItem;
    actDoorGlazing: TDNMAction;
    actDoorHandingDetails: TDNMAction;
    actDoorHandingDetailsGUI: TDNMAction;
    actDoorGlazingGUI: TDNMAction;
    DoorGlazingList1: TMenuItem;
    DoorHandingDetailsList1: TMenuItem;
    actDoorReports: TDNMAction;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure actDoorReportsExecute(Sender: TObject);
  private
    procedure GeneralHandler(const Sender: TObject; const Event: string; const Data: Pointer);
    procedure AddReports;
  Protected
  public
    procedure AssociateClassNamesWithActions; override;
  published
    function GetItem(const ActionName: string): TActionHelperItem;
  end;

implementation

uses
  FastFuncs, frmREportSelectorFrm, CommonLib, GlobalEventsObj,
  AddinPackageInfoObj, MainSwitchFrm2, tcConst, AppEnvironment;

{$R *.dfm}
{$M+}        {don't delete!}

{ TdtmDoorAddin }

procedure TdtmDoorAddin.DataModuleCreate(Sender: TObject);
begin
  LoadImagefromAppMainImageList := True;
  inherited;
  PopulateActionHelper(Self.ActionList);
  AssociateClassNamesWithActions;
  GlobalEvents.DeregisterHandlers(self);
  GlobalEvents.RegisterNameHandler(Self, 'TfrmReportSelectorGUI', '', GEVENT_AfterCreate, GeneralHandler);

end;

procedure TdtmDoorAddin.DataModuleDestroy(Sender: TObject);
begin
  GlobalEvents.DeregisterHandlers(self);
  inherited;
end;

procedure TdtmDoorAddin.AssociateClassNamesWithActions;
var
  i: integer;
  Action: TDNMAction;
begin
  for i := 0 to ActionList.Actioncount - 1 do begin
    Action := TDNMAction(ActionList.Actions[i]);
    ActionHelper.AssociateActionWithClassName(Action.Name, Action.ClassExecute, Action.Description);
  end;
end;

function TdtmDoorAddin.GetItem(
  const ActionName: string): TActionHelperItem;
var
  I: integer;
begin
  Result := nil;
  if ActionHelper.Count > 0 then for I := 0 to ActionHelper.ActionCount - 1 do
      if FastFuncs.SameText(ActionHelper.Items[I].ActionName, ActionName) then begin
        Result := ActionHelper.Items[I];
        Break;
      end;
end;

procedure TdtmDoorAddin.GeneralHandler(const Sender: TObject;
  const Event: string; const Data: Pointer);
var
  SenderName: string;
begin
  if Sender is TComponent then begin
    SenderName := TComponent(Sender).Name;
  end else begin
    SenderName := '';
  end;

  if (Event = GEVENT_AfterCreate) and (SenderName = 'frmReportSelectorGUI') then begin
    AddReports;
  end;
end;

procedure TdtmDoorAddin.AddReports;
var
  ReportSelector: TfrmReportSelectorGUI;
begin

  if (AppEnv.CompanyPrefs.UseDoors) then begin
    ReportSelector:= TfrmReportSelectorGUI(FindExistingComponent('TfrmReportSelectorGUI',0));
    if Assigned(ReportSelector) then begin
        ReportSelector.Add(REPORT_GROUP_DOORS, 'Item Tree List', 'TfmTreeItemList', 0);
    end;
  end;
end;

procedure TdtmDoorAddin.actDoorReportsExecute(Sender: TObject);
begin
  inherited;
  AssignActionBitmap(Sender, MainSwitch2.DoReportShow('', REPORT_GROUP_DOORS));
end;

initialization
  if Assigned(AddinInfo) then AddinInfo.GuiDataModuleClass:= TdtmDoorAddin;

end.
