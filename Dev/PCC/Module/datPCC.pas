unit datPCC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseGUIDatamodule, Menus, AdvMenus, ActnList, ImgList, DNMAction, ActionsObj;

type
  TdmPCCAddin = class(TdtmGUI)
    ImageList1: TImageList;
    ActionList: TActionList;
    MainMenu: TAdvMainMenu;
    Grade1: TMenuItem;
    Grade2: TMenuItem;
    GradeList1: TMenuItem;
    N1: TMenuItem;
    PCCGrade: TDNMAction;
    PCCGradeList: TDNMAction;
    ank1: TMenuItem;
    ankList1: TMenuItem;
    PCCTank: TDNMAction;
    PCCTankList: TDNMAction;
    N2: TMenuItem;
    Hose1: TMenuItem;
    HoseList1: TMenuItem;
    PCCHose: TDNMAction;
    PCCHoseList: TDNMAction;
    N3: TMenuItem;
    Attendant1: TMenuItem;
    AttendantList1: TMenuItem;
    PCCAttendant: TDNMAction;
    PCCAttendantList: TDNMAction;
    PCCDelivery: TDNMAction;
    N4: TMenuItem;
    FuelDelivery1: TMenuItem;
    PCCDeliveryList: TDNMAction;
    FuelDeliveryList1: TMenuItem;
    PCCDipReading: TDNMAction;
    PCCDipReadingList: TDNMAction;
    N5: TMenuItem;
    DipReading1: TMenuItem;
    DipReadingList1: TMenuItem;
    PCCImport: TDNMAction;
    PCCImportRates: TDNMAction;
    N6: TMenuItem;
    Import1: TMenuItem;
    ImportRates1: TMenuItem;
    PCCStarCardReport: TDNMAction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AssociateClassNamesWithActions; override;
  published
    procedure GetAvailableCategories(var AList: TStrings; const StartFresh: boolean = true);
    function GetActionCategory(const ActionName: string; const ActionList: TActionList): string;
    procedure GetCategoriesActions(var AList: TStrings; var CategoryName: string);
    function GetAction(Const ItemName: string): TAction;
    function GetActionIndex(const i: integer): TAction;
    function GetItem(const ActionName: string): TActionHelperItem;
    function GetActionCount: integer;
  end;

var
  dmPCCAddin: TdmPCCAddin;

implementation

uses
  CommonLib, FastFuncs;

{$R *.dfm}

{$M+}        {don't delete!}

//get action category for action name.
function TdmPCCAddin.GetActionCategory(const ActionName: string; const ActionList: TActionList): string;
var
  I: integer;
  Action: TAction;
begin
  Result := '';
  if ActionList.ActionCount > 0 then for I := 0 to ActionList.ActionCount - 1 do begin
      Action := TAction(ActionList.Actions[I]);
      if FastFuncs.SameText(Action.Name, ActionName) then begin
        Result := Action.Category;
        Break;
      end;
    end;
end;

{return list of categories from action list.}

procedure TdmPCCAddin.GetAvailableCategories(var AList: TStrings; const StartFresh: boolean = true);
var
  I: integer;
  Action: TAction;
begin
  if StartFresh then AList.Clear;
  if ActionList.ActionCount > 0 then for I := 0 to ActionList.ActionCount - 1 do begin
      Action := TAction(ActionList.Actions[I]);
      if AList.IndexOf(Action.Category) = -1 then AList.Add(Action.Category);
    end;
end;
{return list of actions}

procedure TdmPCCAddin.GetCategoriesActions(var AList: TStrings; var CategoryName: string);
var
  I: integer;
  Action: TAction;
begin
  AList.Clear;
  if ActionList.ActionCount > 0 then for I := 0 to ActionList.ActionCount - 1 do begin
      Action := TAction(ActionList.Actions[I]);
      if FastFuncs.SameText(Action.Category, CategoryName) then {same, so continue}
        if AList.IndexOf(Action.Name) = -1 then AList.Add(Action.Name);
    end;
end;
{get Action by Name}

function TdmPCCAddin.GetAction(Const ItemName: string): TAction;
var
  I: integer;
  Action: TAction;
begin
  Result := nil;
  if ActionList.ActionCount > 0 then for I := 0 to ActionList.ActionCount - 1 do begin
      Action := TAction(ActionList.Actions[I]);
      if FastFuncs.SameText(Action.Name, ItemName) then begin
        Result := Action;
        Break;
      end;
    end;
end;
{get action count}

function TdmPCCAddin.GetActionCount: integer;
begin
  Result := ActionList.ActionCount;
end;

{get Action based on index}
function TdmPCCAddin.GetActionIndex(const i: integer): TAction;
var
  Action: TAction;
begin
  Result := nil;
  if ActionList.ActionCount > 0 then begin
    Action := TAction(ActionList.Actions[I]);
    Result := Action;
  end;
end;
{get Action by Action name}

function TdmPCCAddin.GetItem(const ActionName: string): TActionHelperItem;
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


{Add code to associate class with actions- This is a template}
procedure TdmPCCAddin.AssociateClassNamesWithActions;
var
  i: integer;
  Action: TDNMAction;
begin
  // here all actions need to be associated with its corresponding form class

  //Action names should be unique to differentiate between different packagages.
  //example
  for i := 0 to ActionList.Actioncount - 1 do begin
    Action := TDNMAction(ActionList.Actions[I]);
    ActionHelper.AssociateActionWithClassName(Action.Name, Action.ClassExecute, Action.Description);
  end;
end;
// ---------- Specific functionality -----------------------------------------------


procedure TdmPCCAddin.DataModuleCreate(Sender: TObject);
begin
  inherited;
  PopulateActionHelper(Self.ActionList);
  AssociateClassNamesWithActions;
end;

initialization
  //register class name below
  RegisterClassOnce(TdmPCCAddin);                       {<-here}
  //if Assigned(AddinInfo) then AddinInfo.dmGUIClassname := 'TdatPCCAddin';       {<-and here}

end.
