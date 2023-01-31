unit MenuCustomiseClasses;

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Dialogs, Grids,
  StdCtrls, ImgList, ActnList, Buttons, DNMSpeedButton, BaseGrid, AdvGrid,
  DBCtrls, Db, Mask, ExtCtrls, BaseInputForm, ComCtrls,AdvOfficeStatusBar, PrefObj, tcTypes,
  DNMAction, wwdblook, MemDS, DBAccess, MyAccess,ERPdbComponents, DNMPanel, Shader, Menus,
  AdvMenus, DataState, SelectionDialog, AppEvnts, CheckLst, ProgressDialog, ERPDrawUtils,
  PageLayoutModifier;

type


  TPageItem = class(TCollectionItem)
  private
    FButtonList: string;
    FPageName: string;
    FSpecial: boolean;
    fPageModifier: TPageModifier;
    procedure SetButtonList(const Value: string);
  public
    destructor Destroy;override;
    procedure Save(APanel : TPanel);
    property ButtonList: string read FButtonList write SetButtonList;
    property PageName: string read FPageName write FPageName;
    property Special : boolean read FSpecial write FSpecial;
    property PageModifier : TPageModifier read fPageModifier write fPageModifier;
  end;

  TPageCollection = class(TCollection)
  private
    function GetItems(const Index: integer): TPageItem;
    procedure SetItems(const Index: integer; const Value: TPageItem);
    procedure SetPageByName(const APageName: string; const Value: TPageItem);
  protected
    function GetPageByName(const APageName: string): TPageItem;
  public
    constructor Create;
    function Add: TPageItem;
    function AddPage(const APageName: string; const AButtonList: string = ''): integer; overload;
    function AddPage(const APageName: string; const ActionList: TActionList): integer; overload;
    function AddSpecialPage(const APageName : String) : integer;
    function DeletePage(const APageName: string): boolean;
    function GetButtonList(const APageName: string; var AButtonList: string): boolean; overload;
    function GetButtonList(const APageName: string): string; overload;
    function GetButtoncount(const APageName: string): Integer;
    function PageExists(const APageName: string): boolean;
    function PageHasButtons(const APageName: string): boolean;
    procedure UpdateButtonList(const APageName, AButtonList: string);
    property Items[const Index: integer]: TPageItem read GetItems write SetItems;
    property PageByName[const APageName: string]: TPageItem read GetPageByName write SetPageByName;
  end;

const
  MENU_CATEGORY_ALL = 'All Categories';
  COPY_SWITCH_LBL   = 'Copy Main Switch Customisation to:';
  COPY_TOOLBAR_LBL  = 'Copy ToolBar Customisation to:';

var
  OrigCategories, SortedCategories, OrigAction, SortedAction: TStringList;

//function CustomiseToolbar: boolean;
function LoadPageConfigData(Const APageConfig: TPageCollection; const MCR: TMenuCustomiseRec): boolean;
function SavePageConfigData(const APageConfig: TPageCollection; const MCR: TMenuCustomiseRec): boolean;
//function ShowMenuCustomiseForm: boolean;
procedure GetMainMenuDefaultPreferences(Const APageConfig: TPageCollection);
//procedure SorttheCategories;
procedure GetToolbarDefaultPreferences(Const APageConfig: TPageCollection);
function MainSwitchCustomiseRec: TMenuCustomiseRec;
function ToolbarCustomiseRec: TMenuCustomiseRec;

implementation

uses
  dmMainGUI,  tcConst, Forms, PackageControl, CommonLib,
  DNMExceptions, AppEnvironment, AddinPackageInfoObj, FastFuncs, BusObjPreference, Menulib,
  StringUtils, CommonDbLib, AppDatabase, ImageDllLib, ERPLine;

function LoadPageConfigData(Const APageConfig: TPageCollection; const MCR: TMenuCustomiseRec): boolean;
var
  Prefs: TPrefCollection;
  List: TStrings;
  I: integer;
  PageName: string;
begin
  Result := false;
  Prefs := TPrefCollection.Create(0, MCR.UserID, MCR.PrefGroup, MCR.IndustryId);

  try
    if Prefs.Count > 0 then begin
      List := TStringList.Create;

      try
        for I := 0 to Prefs.Count - 1 do begin
          if (Prefs.Items[I].PrefName = MCR.PrefName) then begin
            List.Text := Prefs.Items[I].AsString;

            if List.Count > 0 then begin
              Result := true;
              Break;
            end;
          end;
        end;
      finally
        if Result then begin
          APageConfig.Clear;

          for I := 0 to List.Count - 1 do begin
            PageName := List.Names[I];
            APageConfig.AddPage(PageName, List.Values[PageName]);
          end;
        end;
        FreeandNil(List);
      end;
    end;
  finally
    FreeandNil(Prefs);
  end;
end;

function SavePageConfigData(const APageConfig: TPageCollection; const MCR: TMenuCustomiseRec): boolean;
var
  List: TStrings;
  I: integer;
  Pi: TPageItem;
  Prefs: TPrefCollection;
begin
  Prefs := TPrefCollection.Create;
  List := TStringList.Create;

  try
    if APageConfig.Count > 0 then
      for I := 0 to APageConfig.Count - 1 do begin
        Pi := APageConfig.Items[I];
        List.Add(Pi.PageName + '=' + Pi.ButtonList);
      end;
  finally
    with Prefs.Add do begin
      PrefName := MCR.PrefName;
      PrefGroup := MCR.PrefGroup;
      PackageID := MCR.PackageID;
      UserID := MCR.UserID;
      IndustryId := MCR.IndustryId;
      AsString := List.Text;
    end;

    Prefs.Save;
    FreeandNil(Prefs);
    FreeandNil(List);
  end;
  Result := true;
end;

function MainSwitchCustomiseRec: TMenuCustomiseRec;
begin
  Result.PrefGroup := PREF_GROUP_MAIN_SWITCH;
  Result.PrefName := PREF_NAME_MAIN_SWITCH_MENU;
  Result.PackageID := 0;
  Result.UserID := AppEnv.Employee.EmployeeID;
  Result.IndustryId := AppEnv.CompanyInfo.IndustryId;
end;

function ToolbarCustomiseRec: TMenuCustomiseRec;
begin
  Result.PrefGroup := PREF_GROUP_MAIN;
  Result.PrefName := PREF_NAME_TOOLBAR_MENU;
  Result.PackageID := 0;
  Result.UserID := AppEnv.Employee.EmployeeID;
  Result.IndustryId := AppEnv.CompanyInfo.IndustryId;
end;

procedure GetMainMenuDefaultPreferences(Const APageConfig: TPageCollection);{var for packages}
var
  i: integer;
begin
    OrigCategories  := TStringList.Create;
    SortedCategories:= TStringList.Create;
    OrigAction      := TStringList.Create;
    SortedAction    := TStringList.Create;
    try
      APageConfig.Clear;
      Menulib.DefaultCategories(OrigCategories, OrigAction , SortedCategories, SortedAction);
      for i := 0 to SortedCategories.Count - 1 do
          APageConfig.AddPage(SortedCategories.strings[i], OrigAction.strings[FastFuncs.StrToInt(SortedAction.strings[i])]);
    Finally
      OrigCategories.Free;
      SortedCategories.Free;
      OrigAction.Free;
      SortedAction.Free;
    end;
end;

procedure GetToolbarDefaultPreferences(Const APageConfig: TPageCollection);
begin
    APageConfig.Clear;
    APageConfig.AddPage(PAGE_NAME_TOOLBAR, DEFAULT_ACTIONS_TOOLBAR);
end;


function TPageCollection.Add: TPageItem;
begin
    Result := TPageItem(inherited Add);
end;

function TPageCollection.AddPage(const APageName, AButtonList: string): integer;
begin// call PageExists method first if you want to have page names unique
    with Self.Add do begin
        PageName   := APageName;
        ButtonList := AButtonList;
        Result     := Index;
    end;
end;

function TPageCollection.AddPage(const APageName: string; const ActionList: TActionList): integer;
var
  ActionIndex: integer;
  BtnList: string;
begin
  BtnList := '';
  for ActionIndex := 0 to ActionList.ActionCount - 1 do begin
    if TDNMAction(ActionList.Actions[ActionIndex]).DefaultPage = APageName then
      BtnList := BtnList + ActionList.Actions[ActionIndex].Name + ',';
  end;
  if char_length(BtnList) > 0 then
    Setlength(BtnList, char_length(BtnList) - 1);
  with Self.Add do begin
    PageName   := APageName;
    ButtonList := BtnList;
    Result     := Index;
  end;
end;

function TPageCollection.AddSpecialPage(const APageName: String): integer;
begin
    with Self.Add do begin
        PageName   := APageName;
        ButtonList := '[Special]';
        Special := true;
        Result     := Index;
    end;
end;

constructor TPageCollection.Create;
begin
  inherited Create(TPageItem);
end;

function TPageCollection.DeletePage(const APageName: string): boolean;
var
  Page: TPageItem;
begin
  Result := false;
  Page := PageByName[APageName];
  if Assigned(Page) then begin
    Self.Delete(Page.Index);
    Result := true;
  end;
end;
function TPageCollection.GetButtoncount(const APageName: string): Integer;
begin
  result := StrCount(',' , PageByName[APageName].ButtonList);
end;
function TPageCollection.GetButtonList(const APageName: string): string;
var
  Page: TPageItem;
begin
  Result := '';
  Page := PageByName[APageName];
  if Assigned(Page) then
    Result := Page.ButtonList;
end;

function TPageCollection.GetButtonList(const APageName: string; var AButtonList: string): boolean;
begin
  AButtonList := GetButtonList(APageName);
  Result := AButtonList <> '';
end;

function TPageCollection.GetItems(Const Index: integer): TPageItem;
begin
  Result := TPageItem(inherited Items[Index]);
end;

function TPageCollection.GetPageByName(Const APageName: string): TPageItem;
var
  I: integer;
begin
  Result := nil;
  if Self.Count > 0 then
    for I := 0 to Self.Count - 1 do
      if Sysutils.SameText(Items[I].PageName, APageName) then begin
        Result := Items[I];
        Break;
      end;
end;

function TPageCollection.PageExists(const APageName: string): boolean;
begin
  Result := Assigned(PageByName[APageName]);
end;

function TPageCollection.PageHasButtons(const APageName: string): boolean;
var
  Page: TPageItem;
begin
  Page := PageByName[APageName];
  Result := Assigned(Page) and (Page.ButtonList <> '');
end;

procedure TPageCollection.SetItems(Const Index: integer; const Value: TPageItem);
begin
  TPageItem(inherited Items[Index]).Assign(Value);
end;

procedure TPageCollection.SetPageByName(Const APageName: string; const Value: TPageItem);
var
  Page: TPageItem;
begin
  Page := PageByName[APageName];
  if Assigned(Page) then
    Items[Page.Index] := Value;
end;

procedure TPageCollection.UpdateButtonList(const APageName, AButtonList: string);
var
  Page: TPageItem;
begin
  Page := PageByName[APageName];
  if Assigned(Page) then
    Page.ButtonList := AButtonList;
end;


{ TPageItem }

destructor TPageItem.Destroy;
begin
  PageModifier.Free;
  inherited;
end;

procedure TPageItem.Save(APanel: TPanel);
var
  idx : integer;
  btn : TERPMainSwitchMovingButton;
  desc : TPageItemDesc;
  l : TLine;
  i : integer;

begin
  if assigned(PageModifier) then
    PageModifier.Free;
  PageModifier := TPageModifier.Create(self);
  PageModifier.PageName := PageName;

  for idx := 0 to APanel.ComponentCount - 1 do
    if APanel.Components[idx] is TERPMainSwitchMovingButton then
    begin
      btn := APanel.Components[idx] as TERPMainSwitchMovingButton;
      Desc := TPageItemDesc.Create;
      Desc.ActionName := btn.Action.Name;
      Desc.Top := btn.Top;
      Desc.Left := btn.Left;
      Desc.Width := btn.Width;
      Desc.Height := btn.Height;
      Desc.NodeType := mtButton;
      PageModifier.ButtonDescriptor[btn.Action.Name] := Desc;
    end
    else if APanel.Components[idx] is TLine then
    begin
      l := APanel.Components[idx] as TLine;
      Desc := TPageItemDesc.Create;
      Desc.NodeType := mtLink;
      Desc.Left := l.StartPoint.X;
      Desc.Top := l.StartPoint.Y;
      Desc.Width := l.EndPoint.X;
      Desc.Height := l.EndPoint.Y;
      if Assigned(l.ActionFrom) then
        Desc.ActionName := TERPMainSwitchMovingButton(l.ActionFrom).Action.Name
      else
        Desc.ActionName := '';
      if assigned(l.ActionTo) then
        Desc.EndActionName := TERPMainSwitchMovingButton(l.ActionTo).Action.Name
      else
        Desc.EndActionName := '';
      Desc.LineWidth := l.LineWidth;
      Desc.LineColor := l.LineColor;
      Desc.SelectedColor := l.SelectedColor;
      Desc.ArrowColor := l.ArrowColor;
      Desc.LineStyle := l.LineStyle;
      Desc.MarkColor := l.MarkColor;
      Desc.MarkSize := l.MarkSize;
      Desc.Arrow1Kind := l.Arrow1Kind;
      Desc.Arrow2Kind := l.Arrow2Kind;
      if l.Arrow1 then
        i := 1
      else
        i := 0;
      if l.Arrow2  then
        i := i OR 2;
      Desc.LineHeads := i;
      PageModifier.AddLinkDescriptor(Desc);
    end;
  PageModifier.Save(*(ButtonList)*);
end;

procedure TPageItem.SetButtonList(const Value: string);
begin
  FButtonList := Value;
end;

end.

