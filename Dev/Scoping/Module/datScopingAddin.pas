unit datScopingAddin;
  // This is a template for the addition of "Addin" functionality to Platinum1 using
  // dynamically loaded packages.
  //
  // One of thes Addin units should be created for each Addin package.
  // This DataModule is created when the Addin package is loaded and its job is
  // to add the required user funcionality contained in the package to the main
  // Platinum1 core application.

  // Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 18/11/05  1.00.01 DLS

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  BaseGUIDatamodule, ActionsObj, ActnList, Menus, AdvMenus, DNMAction, ImgList;

type 
  TdmScopingAddin = class(TdtmGUI)
    MainMenu: TAdvMainMenu;
    ActionList: TActionList;
    ImageList1: TImageList;
    actDefinitionEditor: TDNMAction;
    actScopeReport: TDNMAction;
    actScopeList: TDNMAction;
    Scoping1: TMenuItem;
    ScopingReport1: TMenuItem;
    ScopeReportList1: TMenuItem;
    N1: TMenuItem;
    ScopeDefinitionEditor1: TMenuItem;
    ScopeDefinitionEditor2: TMenuItem;
    actScopeDefList: TDNMAction;
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

{var
  dmScopingAddin: TdmScopingAddin;}

implementation

uses
   AddinPackageInfoObj, FastFuncs;//, frmScopeList, frmScopingDefinitionEditor, frmScopingInputForm;

const
  //SCOPE = 'Scoping';
  SCOPE = '';

  {$R *.dfm}
  {$M+}        {don't delete!}


  //get action category for action name.
function TdmScopingAddin.GetActionCategory(const ActionName: string; const ActionList: TActionList): string;
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

procedure TdmScopingAddin.GetAvailableCategories(var AList: TStrings; const StartFresh: boolean = true);
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

procedure TdmScopingAddin.GetCategoriesActions(var AList: TStrings; var CategoryName: string);
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

function TdmScopingAddin.GetAction(Const ItemName: string): TAction;
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

function TdmScopingAddin.GetActionCount: integer;
begin
  Result := ActionList.ActionCount;
end;

{get Action based on index}
function TdmScopingAddin.GetActionIndex(const i: integer): TAction;
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

function TdmScopingAddin.GetItem(const ActionName: string): TActionHelperItem;
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

{Add code to associate class with actions- This is a template procedure}
procedure TdmScopingAddin.AssociateClassNamesWithActions;
var
  i: integer;
  Action: TDNMAction;
begin
  for i := 0 to ActionList.Actioncount - 1 do begin
    Action := TDNMAction(ActionList.Actions[I]);
    ActionHelper.AssociateActionWithClassName(Action.Name, Action.ClassExecute, Action.Description);
  end; 
end;

procedure TdmScopingAddin.DataModuleCreate(Sender: TObject);
begin
  inherited;
  PopulateActionHelper(Self.ActionList);
  AssociateClassNamesWithActions;
end;

initialization
  if Assigned(AddinInfo) then AddinInfo.GuiDataModuleClass := TdmScopingAddin;
end.
