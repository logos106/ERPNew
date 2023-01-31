unit datRollaBlindAddin;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 10/05/06  1.00.01 DSP  Initial version.
 13/06/06  1.00.01 DSP  Changed GroupIndex property values in MainMenu to move
                        menu items from 'File' to 'Sales'.

}
 
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, 
  Dialogs, BaseGUIDatamodule, ActnList, DNMAction, Menus, AdvMenus, ImgList, ActionsObj;

type
  TdmRollaBlindAddin = class(TdtmGUI)
    ActionList: TActionList;
    ImageList: TImageList;
    actViewDatabase: TDNMAction;
    actGuideData: TDNMAction;
    actAddNewSheet: TDNMAction;
    actProfileTypes: TDNMAction;
    actColourData: TDNMAction;
    actDropData: TDNMAction;
    actInstallationTypes: TDNMAction;
    actItemData: TDNMAction;
    actHolePlugData: TDNMAction;
    actItemPriceList: TDNMAction;
    actTechData: TDNMAction;
    MainMenu: TAdvMainMenu;
    RollaBlinds1: TMenuItem;
    AddNewSheet1: TMenuItem;
    ViewDatabase1: TMenuItem;
    GuideData1: TMenuItem;
    ProfileTypes1: TMenuItem;
    DropData1: TMenuItem;
    Colourdata1: TMenuItem;
    InstallationTypes1: TMenuItem;
    HolePlugdata1: TMenuItem;
    echnicalData1: TMenuItem;
    ItemPriceList1: TMenuItem;
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

implementation

uses
  AddinPackageInfoObj, FastFuncs;

{$R *.dfm}
{$M+}        {don't delete!}

function TdmRollaBlindAddin.GetActionCategory(const ActionName: string; const ActionList: TActionList): string;
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

procedure TdmRollaBlindAddin.GetAvailableCategories(var AList: TStrings; const StartFresh: boolean = true);
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

procedure TdmRollaBlindAddin.GetCategoriesActions(var AList: TStrings; var CategoryName: string);
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

function TdmRollaBlindAddin.GetAction(Const ItemName: string): TAction;
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

function TdmRollaBlindAddin.GetActionCount: integer;
begin
  Result := ActionList.ActionCount;
end;

function TdmRollaBlindAddin.GetActionIndex(const i: integer): TAction;
var
  Action: TAction;
begin
  Result := nil;
  if ActionList.ActionCount > 0 then begin
    Action := TAction(ActionList.Actions[I]);
    Result := Action;
  end;
end;

function TdmRollaBlindAddin.GetItem(const ActionName: string): TActionHelperItem;
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

procedure TdmRollaBlindAddin.AssociateClassNamesWithActions;
var
  i: integer;
  Action: TDNMAction;
begin
  for i := 0 to ActionList.Actioncount - 1 do begin
    Action := TDNMAction(ActionList.Actions[i]);
    ActionHelper.AssociateActionWithClassName(Action.Name, Action.ClassExecute, Action.Description);
  end;
end;

procedure TdmRollaBlindAddin.DataModuleCreate(Sender: TObject);
begin
  inherited;
  PopulateActionHelper(Self.ActionList);
  AssociateClassNamesWithActions;
end;

initialization
  if Assigned(AddinInfo) then AddinInfo.GuiDataModuleClass := TdmRollaBlindAddin;

end.
