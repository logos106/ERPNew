unit datEmbroideryAddin;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 09/11/06  1.00.01 DSP  Initial version.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, BaseGUIDatamodule, ActnList, DNMAction, Menus, AdvMenus, ImgList, ActionsObj;

type
  TdmEmbroideryAddin = class(TdtmGUI)
    MainMenu: TAdvMainMenu;
    ActionList: TActionList;
    ImageList: TImageList;
    actEmbroideryPriceList: TDNMAction;
    Embroidery1: TMenuItem;
    EmbroideryPriceList1: TMenuItem;
    EmbroideryPositionList1: TMenuItem;
    actEmbroideryPositionList: TDNMAction;
    actBarcodeProcess: TDNMAction;
    BarcodeProcess1: TMenuItem;
    actWorkOrderStatus: TDNMAction;
    WorkOrderStatus1: TMenuItem;
    actDeliveryDocketList: TDNMAction;
    DeliveryDocketList1: TMenuItem;
    procedure DataModuleCreate(Sender: TObject);
    procedure BarcodeProcessExecute(Sender: TObject);
  private
    { Private declarations }
  public
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
  AddinPackageInfoObj, CommonLib, BarcodeProcessObj, FastFuncs;

{$R *.dfm}

{$M+}        {don't delete!}

procedure TdmEmbroideryAddin.AssociateClassNamesWithActions;
var
  i: integer;
  Action: TDNMAction;
begin
  for i := 0 to ActionList.Actioncount - 1 do begin
    Action := TDNMAction(ActionList.Actions[i]);
    ActionHelper.AssociateActionWithClassName(Action.Name, Action.ClassExecute, Action.Description);
  end;
end;

procedure TdmEmbroideryAddin.DataModuleCreate(Sender: TObject);
begin
  inherited;
  PopulateActionHelper(ActionList);
  AssociateClassNamesWithActions;
end;

function TdmEmbroideryAddin.GetAction(Const ItemName: string): TAction;
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

function TdmEmbroideryAddin.GetActionCategory(const ActionName: string; const ActionList: TActionList): string;
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

function TdmEmbroideryAddin.GetActionCount: integer;
begin
  Result := ActionList.ActionCount;
end;

function TdmEmbroideryAddin.GetActionIndex(const i: integer): TAction;
var
  Action: TAction;
begin
  Result := nil;
  if ActionList.ActionCount > 0 then begin
    Action := TAction(ActionList.Actions[I]);
    Result := Action;
  end;
end;

procedure TdmEmbroideryAddin.GetAvailableCategories(var AList: TStrings; const StartFresh: boolean);
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

procedure TdmEmbroideryAddin.GetCategoriesActions(var AList: TStrings; var CategoryName: string);
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

function TdmEmbroideryAddin.GetItem(const ActionName: string): TActionHelperItem;
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

procedure TdmEmbroideryAddin.BarcodeProcessExecute(Sender: TObject);
var
  BarcodeProcess: TBarcodeProcess;
begin
  inherited;
  BarcodeProcess := TBarcodeProcess(FindExistingComponent('TBarcodeProcess'));

  if Assigned(BarcodeProcess) then
    BarcodeProcess.BringToFront
  else begin
    BarcodeProcess := TBarcodeProcess(GetComponentByClassName('TBarcodeProcess'));
    BarcodeProcess.CreateForm;
    BarcodeProcess.SetupDisplay;
  end;
end;

initialization
  if Assigned(AddinInfo) then AddinInfo.GuiDataModuleClass := TdmEmbroideryAddin;

end.
