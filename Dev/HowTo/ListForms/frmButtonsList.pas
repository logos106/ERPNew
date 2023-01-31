unit frmButtonsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, ProgressDialog, DB, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts, SelectionDialog,
  Menus, ExtCtrls, StdCtrls, DNMSpeedButton, ComCtrls, ActnList, Shader,
  DNMPanel;

type
  TfmButtonsListFrm = class(TBaseInputGUI)
    lvAvailableButtons: TListView;
    cbCategories: TComboBox;
    btnOk: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    ImageListAll: TImageList;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    Image1: TImage;
    procedure cbCategoriesSelect(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvAvailableButtonsDblClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lvAvailableButtonsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    ImagesOffset: array of Integer;
    fOnSelected: TNotifyEvent;
    function ActiveMenuCategory: string;
    function GetText: string;
    function GetActionCaption: string;
    function GetActionGlyph: TBitmap;
    function GetGlyphIndex: integer;
  protected
    procedure UpdateAvailableButtonsView;
    Function lvAvailableButtonsNewItem : TListItem;
    procedure AddMainImages;
    procedure FillMenuCategoryCombo;
    procedure DisplayAvailSelectedButtons;
    procedure LoadAllPackageCategories;
    procedure RemoveDuplicateItems;
  public
    { Public declarations }
    property Text : string read GetText;
    property ActionCaption : string read GetActionCaption;
    property ActionGlyph : TBitmap Read GetActionGlyph;
    property GlyphIndex : integer read GetGlyphIndex;
    property OnSelected : TNotifyEvent read fOnSelected write fOnSelected;
  end;

implementation

{$R *.dfm}
uses
  dmMainGUI,  tcConst, PackageControl, CommonLib,
  DNMExceptions, AppEnvironment, AddinPackageInfoObj, FastFuncs, BusObjPreference, Menulib,
  StringUtils, CommonDbLib, AppDatabase;

const
  MENU_CATEGORY_ALL = 'All Categories';

function TfmButtonsListFrm.ActiveMenuCategory: string;
begin
  if cbCategories.ItemIndex <> -1 then
    Result := cbCategories.Items[cbCategories.ItemIndex]
  else
    Result := '';
end;

procedure TfmButtonsListFrm.AddMainImages;
begin
  ImageListAll.AddImages(dtmMainGUI.ImageList);
end;

procedure TfmButtonsListFrm.btnCancelClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then
    ModalResult := mrCancel
  else
    Close;
end;

procedure TfmButtonsListFrm.btnOkClick(Sender: TObject);
begin
  if fsModal in FormSTate then
    ModalResult := mrOk
  else
    Close;
end;

procedure TfmButtonsListFrm.cbCategoriesSelect(Sender: TObject);
begin
  inherited;
  UpdateAvailableButtonsView;
end;

procedure TfmButtonsListFrm.DisplayAvailSelectedButtons;
var
    i     : integer;
    li    : TListItem;
    Action: TAction;
begin
    FillMenuCategoryCombo;
    lvAvailableButtons.Clear;
    if dtmMainGUI.ActionList.ActionCount > 0 then begin
        for I := 0 to dtmMainGUI.ActionList.ActionCount - 1 do begin
            Action := TAction(dtmMainGUI.ActionList.Actions[I]);
            if Action.Enabled And Action.Visible then begin
                li := lvAvailableButtonsNewItem;
                li.Caption := Action.Caption;
                li.ImageIndex := Action.ImageIndex-1;
                li.Data := Action;
            end;
        end;
    end;
    LoadAllPackageCategories;
    RemoveDuplicateItems;
//    PopulateSelectedView;
end;

procedure TfmButtonsListFrm.FillMenuCategoryCombo;
var
  i, kk, jj: integer;
  SelAddinInfo: TAddinPackageInfo;
  Action :TAction;
begin
    cbCategories.Clear;
    cbCategories.Sorted := true;
    cbCategories.items.add(MENU_CATEGORY_ALL);
    if dtmMainGUI.ActionList.ActionCount > 0 then begin
        for I := 0 to dtmMainGUI.ActionList.ActionCount - 1 do begin
            Action := TAction(dtmMainGUI.ActionList.Actions[I]);
            if cbCategories.items.IndexOf(Action.Category) = -1 then cbCategories.items.Add(Action.Category);
        end;
    end;
    for i := 0 to AddinPackageList.Count - 1 do begin
        SelAddinInfo := TAddinPackageInfo(AddinPackageList[i]);
        for kk := 0 to  SelAddinInfo.GuiDataModule.ComponentCount-1 do begin
            if SelAddinInfo.GuiDataModule.Components[kk] is TActionlist then begin
                for jj := 0 to TActionList(SelAddinInfo.GuiDataModule.components[kk]).ActionCount-1 do begin
                    Action := TAction(TActionList(SelAddinInfo.GuiDataModule.components[kk]).Actions[jj]);
                    if cbCategories.items.IndexOf(Action.Category) = -1 then cbCategories.items.Add(Action.Category);
                end;
            end;
        end;
    end;

end;

procedure TfmButtonsListFrm.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
//
end;

procedure TfmButtonsListFrm.FormShow(Sender: TObject);
var
  lLeft : integer;
begin
  DisableForm;
  lLeft := Left;
  try
    try
      AddMainImages;
      lvAvailableButtons.SmallImages := ImageListAll;

      cbCategories.ItemIndex := cbCategories.Items.IndexOf(MENU_CATEGORY_ALL);
      UpdateAvailableButtonsView;
      DisplayAvailSelectedButtons;
      inherited;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
    end;
  finally
    EnableForm;
    Left := lLeft;
  end;
end;

function TfmButtonsListFrm.GetActionCaption: string;
begin
  Result := TAction(lvAvailableButtons.Selected.Data).Name;
end;

function TfmButtonsListFrm.GetActionGlyph: TBitmap;
begin
//  Result := TAction(lvAvailableButtons.Selected.Data).ImageIndex
  Result := TBitmap.Create;
  dtmMainGUI.ImageListSmlIcons.GetBitmap(TAction(lvAvailableButtons.Selected.Data).ImageIndex - 1, Result);
end;

function TfmButtonsListFrm.GetGlyphIndex: integer;
begin
  Result := TAction(lvAvailableButtons.Selected.Data).ImageIndex - 1;
end;

function TfmButtonsListFrm.GetText: string;
begin
  Result := lvAvailableButtons.Selected.Caption;
end;

procedure TfmButtonsListFrm.LoadAllPackageCategories;
var
  I,k           : integer;
  li            : TListItem ;
  Action        : TAction;
  j             : integer;
  SelAddinInfo  : TAddinPackageInfo;
begin
    Setlength(ImagesOffset, AddinPackageList.Count);

    for i := 0 to AddinPackageList.Count - 1 do begin
        SelAddinInfo := TAddinPackageInfo(AddinPackageList[i]);
        for k := 0 to  SelAddinInfo.GuiDataModule.ComponentCount-1 do begin
            if SelAddinInfo.GuiDataModule.Components[k] is TActionlist then begin
                for j := 0 to TActionList(SelAddinInfo.GuiDataModule.components[k]).ActionCount-1 do begin
                    Action := TAction(TActionList(SelAddinInfo.GuiDataModule.components[k]).Actions[j]);
                    if Action.Enabled And Action.Visible then begin
                        li := lvAvailableButtonsNewItem;
                        li.Caption := Action.Caption;
                        li.ImageIndex := Action.ImageIndex-1;
                        li.Data := Action;

                    end;
                end;
            end;
        end;
    end;
end;

procedure TfmButtonsListFrm.lvAvailableButtonsDblClick(Sender: TObject);
begin
  btnOkClick(Sender);
end;

procedure TfmButtonsListFrm.lvAvailableButtonsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if assigned(OnSelected) and (lvAvailableButtons.Selected <> nil) then
    OnSelected(Self);

end;

function TfmButtonsListFrm.lvAvailableButtonsNewItem: TListItem;
begin
  Result := lvAvailableButtons.Items.Add;
end;

procedure TfmButtonsListFrm.RemoveDuplicateItems;
var
  Index: Integer;
  ItemCaption: string;
begin
  Index := lvAvailableButtons.Items.Count - 1;
  ItemCaption := '';

  while Index > 0 do begin
    if lvAvailableButtons.Items[Index].Caption = ItemCaption then
      lvAvailableButtons.Items.Delete(Index)
    else
      ItemCaption := lvAvailableButtons.Items[Index].Caption;

    Dec(Index);
  end;
end;

procedure TfmButtonsListFrm.UpdateAvailableButtonsView;
var
  I,k: integer;
  Action: TAction;
  li: TListItem;
  j: integer;
  SelAddinInfo: TAddinPackageInfo;
begin
  lvAvailableButtons.Clear;
  for I := 0 to dtmMainGUI.ActionList.ActionCount - 1 do begin
    Action := TAction(dtmMainGUI.ActionList.Actions[I]);
    if  Action.Visible and ((Action.Category = ActiveMenuCategory) or (ActiveMenuCategory = MENU_CATEGORY_ALL)) then
    begin
        li := lvAvailableButtonsNewItem;
        li.Caption := Action.Caption;
        li.ImageIndex := Action.ImageIndex-1;
        li.Data := Action;
    end;
  end;
  Setlength(ImagesOffset, AddinPackageList.Count);

  for i := 0 to AddinPackageList.Count - 1 do
  begin
    ImagesOffset[i] := ImageListAll.Count;
    SelAddinInfo := TAddinPackageInfo(AddinPackageList[i]);

    if Assigned(SelAddinInfo.GuiDataModule) then
    begin
        for k := 0 to  SelAddinInfo.GuiDataModule.ComponentCount-1 do
        begin
            if SelAddinInfo.GuiDataModule.Components[k] is TActionlist then
            begin
                for j := 0 to TActionList(SelAddinInfo.GuiDataModule.components[k]).ActionCount-1 do
                begin
                    Action := TAction(TActionList(SelAddinInfo.GuiDataModule.components[k]).Actions[j]);
                    if  Action.Visible and ((Action.Category = ActiveMenuCategory) or (ActiveMenuCategory = MENU_CATEGORY_ALL)) then
                    begin
                      li := lvAvailableButtonsNewItem;
                      li.Caption := Action.Caption;
                      li.ImageIndex := Action.ImageIndex-1;
                      li.Data := Action;
                    end;
                end;
            end;
        end;
    end;
  end;
end;

end.
