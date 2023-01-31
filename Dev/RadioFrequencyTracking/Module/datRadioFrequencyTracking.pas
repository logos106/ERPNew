unit datRadioFrequencyTracking;

{
   Date     Version  Who  What
   -------- -------- ---  ------------------------------------------------------
   21/03/05  1.00.00 IJB  Initial template verson.
   18/11/05  1.00.01  AL  Initial version

}
interface

uses
  
  SysUtils, Classes, ActnList, DNMAction, Menus, AdvMenus, DB, DBAccess, MyAccess,
  BaseGUIDatamodule, ActionsObj, wwDbGrid, ImgList, Controls;

type
  TdmRadioFrequencyTrackingAddin = class(TdtmGUI)
    MainMenu: TAdvMainMenu;
    ActionList: TActionList;
    ImageList1: TImageList;
    RadioFrequencyTracking: TDNMAction;
    mnuRadioFrequencyTracking: TMenuItem;
    RadioFrequencyTracking1: TMenuItem;
    RadioFrequencyTrackingList1: TMenuItem;
    RadioFrequencyTrackingList: TDNMAction;
    procedure DataModuleCreate(Sender: TObject);
  private

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
  dmRadioFrequencyTrackingAddin: TdmRadioFrequencyTrackingAddin;

implementation

uses FastFuncs, AddinPackageInfoObj;

{$R *.dfm}

{$M+}        {don't delete!}


//get action category for action name.
function TdmRadioFrequencyTrackingAddin.GetActionCategory(const ActionName: string; const ActionList: TActionList): string;
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

procedure TdmRadioFrequencyTrackingAddin.GetAvailableCategories(var AList: TStrings; const StartFresh: boolean = true);
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

procedure TdmRadioFrequencyTrackingAddin.GetCategoriesActions(var AList: TStrings; var CategoryName: string);
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

function TdmRadioFrequencyTrackingAddin.GetAction(Const ItemName: string): TAction;
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

function TdmRadioFrequencyTrackingAddin.GetActionCount: integer;
begin
  Result := ActionList.ActionCount;
end;

{get Action based on index}
function TdmRadioFrequencyTrackingAddin.GetActionIndex(const i: integer): TAction;
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

function TdmRadioFrequencyTrackingAddin.GetItem(const ActionName: string): TActionHelperItem;
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
procedure TdmRadioFrequencyTrackingAddin.AssociateClassNamesWithActions;
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



//---------------------------------------------------------------------------------

procedure TdmRadioFrequencyTrackingAddin.DataModuleCreate(Sender: TObject);
begin
  inherited;
  PopulateActionHelper(Self.ActionList);
  AssociateClassNamesWithActions;
end;


initialization
  if Assigned(AddinInfo) then AddinInfo.GuiDataModuleClass := TdmRadioFrequencyTrackingAddin;       {<-and here}
end.
