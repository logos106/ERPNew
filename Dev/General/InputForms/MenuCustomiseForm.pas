unit MenuCustomiseForm;

interface
{$I ERP.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Types, Dialogs, Grids,
  StdCtrls, ImgList, ActnList, Buttons, DNMSpeedButton, BaseGrid, AdvGrid,
  DBCtrls, Db, Mask, ExtCtrls, BaseInputForm, ComCtrls,AdvOfficeStatusBar, PrefObj, tcTypes,
  DNMAction, wwdblook, MemDS, DBAccess, MyAccess,ERPdbComponents, DNMPanel, Shader, Menus,
  AdvMenus, DataState, SelectionDialog, AppEvnts, CheckLst, ProgressDialog, MenuCustomiseClasses,
  Wwdbigrd, Wwdbgrid, PageLayoutModifier, contnrs, DAScript, MyScript;

type

  TfrmCustomiseMenu = class(TBaseInputGUI)
    btnCancel: TDNMSpeedButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    cbCategories: TComboBox;
    lvAvailableButtons: TListView;
    btnAddButton: TDNMSpeedButton;
    btnAddAllButtons: TDNMSpeedButton;
    btnRemoveButton: TDNMSpeedButton;
    btnRemoveAllButtons: TDNMSpeedButton;
    Label2: TLabel;
    cbPages: TComboBox;
    lvSelectedButtons: TListView;
    btnMoveItemDown: TDNMSpeedButton;
    btnMoveItemUp: TDNMSpeedButton;
    btnDeletePage: TDNMSpeedButton;
    btnAddPage: TDNMSpeedButton;
    CopyTolbl: TLabel;
    Label3: TLabel;
    qryEmployeeCopyTo: TERPQuery;
    btnDefault: TDNMSpeedButton;
    btnOk: TDNMSpeedButton;
    qryPreferences: TERPQuery;
    qryPreferencesTo: TERPQuery;
    ImageListAll: TImageList;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    lstEmployees: TCheckListBox;
    lblMsg: TLabel;
    mem_Note: TMemo;
    qryTrainingButtons: TERPQuery;
    tsLayouts: TTabSheet;
    qryLayouts: TERPQuery;
    dsLayouts: TDataSource;
    grdPages: TwwDBGrid;
    qryLoads: TERPQuery;
    dsLoads: TDataSource;
    cbHistory: TCheckListBox;
    Image1: TImage;
    scrLayouts: TERPScript;
    popLayout: TPopupMenu;
    mnuDelete: TMenuItem;
    qryMaxId: TERPQuery;
    btnEditLayout: TDNMSpeedButton;
    btnExport: TDNMSpeedButton;
    btnImport: TDNMSpeedButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    btnIndustry: TDNMSpeedButton;
    cbIndustry: TCheckBox;
    tabMainswitch: TTabSheet;
    pnlMainswitch: TDNMPanel;
    lblIncrease: TLabel;
    lblDecrease: TLabel;
    lbldefault: TLabel;
    DNMPanel1: TDNMPanel;
    Shader1: TShader;
    Label4: TLabel;
    Shape1: TShape;
    procedure btnAddAllButtonsClick(Sender: TObject);
    procedure btnAddButtonClick(Sender: TObject);
    procedure btnAddPageClick(Sender: TObject);
    procedure btnDeletePageClick(Sender: TObject);
    procedure btnMoveItemDownClick(Sender: TObject);
    procedure btnMoveItemUpClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnRemoveAllButtonsClick(Sender: TObject);
    procedure btnRemoveButtonClick(Sender: TObject);
    procedure cbCategoriesSelect(Sender: TObject);
    procedure cbPagesDropDown(Sender: TObject);
    procedure cbPagesSelect(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure lvAvailableButtonsDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure lvAvailableButtonsDragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
    procedure lvSelectedButtonsDragDrop(Sender, Source: TObject; X, Y: integer);
    procedure lvSelectedButtonsDragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
    procedure lvSelectedButtonsKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure btnDefaultClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure lvAvailableButtonsDblClick(Sender: TObject);
    procedure qryLayoutsBeforeEdit(DataSet: TDataSet);
    procedure grdPagesRowChanged(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbHistoryClick(Sender: TObject);
    procedure cbHistoryClickCheck(Sender: TObject);
    procedure cbHistoryKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mnuDeleteClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure cbIndustryClick(Sender: TObject);
    procedure btnIndustryClick(Sender: TObject);
  private
    FLockedPage: string;
    FSettings: TMenuCustomiseRec;
    Prefs: TPrefCollection;
    PageConfig: TPageCollection;
    MaxSelect: Integer;
    ImagesOffset: array of Integer;
    fDefaultWasSet: boolean;
    fModList: TObjectList;
    fSelectedId: integer;
    fChangedPageList: TStringList;
    fPanelWidth: integer;
    fPanelHeight: integer;
    function ActiveMenuCategory: string;
    function ActiveSelectedPage: string;
    function CurrentButtonList: string;
    function IsSelectedAction(const ActionName: string): boolean;
    function IsSystemPage(const APageName: string): boolean;
    function LoadPreferences: boolean;
    function SavePreferences: boolean;
    procedure AddActionToListView(const ActionName: string; const ListView: TListView);
    Function IsSelectedButtons(const TestButton : TListItem):Boolean;
    procedure AddAvailableToSelected(const DoUpdate: boolean);
    procedure AddSelectedToAvailable(const DoUpdate: boolean);
    procedure DeleteSelectedButton;
    procedure PopulateSelectedView;
    procedure FillMenuCategoryCombo;
    procedure GetDefaultPreferences;
    procedure InternalPageConfigUpdate;
    procedure ListSelectedButtons;
    procedure LockPageControls;
    procedure MoveSelectedButtonDown;
    procedure MoveSelectedButtonUp;
    procedure UpdateAvailableButtonsView;
    procedure LoadAllPackageCategories;
    procedure DisplayAvailSelectedButtons;
//    procedure CopyPreferences(const UserID: integer; const CopyToID: integer; const PrefMenu: string);
    procedure CopyUserCustomisationPreferences;
    procedure AddMainImages;
    procedure RemoveDuplicateItems;
    Function lvSelectedButtonsNewItem: TListItem;
    Function lvAvailableButtonsNewItem : TListItem;
    procedure SaveTrainingButtons;
    procedure ClearLayouts;
    procedure LoadLayoutHistory(const AName : string);
    procedure SaveLayoutChanges;
    procedure PreviewImage(AItem : TPageModifier);
    procedure DeleteLayout;
    procedure SaveChangedPagesLayouts;

    procedure DoExport(AList : TStringList);
    procedure MainSwitchHeightOptions;

    property DefaultWasSet : boolean read fDefaultWasSet write fDefaultWasSet;
    property ModList : TObjectList read fModList Write fModList;
    property SelectedId : integer read fSelectedId write fSelectedId;
    property ChangedPageList : TStringList read fChangedPageList write fChangedPageList;
    procedure DoScriptAfterexecute(Sender: TObject; SQL: string);
  public
    function IsAvailableMenuAction(const ActionName: string): boolean;
    property LockedPage: string read FLockedPage;
    property PanelWidth : integer read fPanelWidth write fPanelWidth;
    property PanelHeight : integer read fPanelHeight write fPanelHeight;
  end;

function CustomiseToolbar: boolean;

function ShowMenuCustomiseForm(pWidth, pHeight : integer): integer;


implementation

uses
  dmMainGUI,  tcConst, Forms, PackageControl, CommonLib,
  DNMExceptions, AppEnvironment, AddinPackageInfoObj, FastFuncs, BusObjPreference, Menulib,
  StringUtils, CommonDbLib, AppDatabase, ERPErrorEmailUtils, MySQLConst, //, EnterNewName;
  ListSelector, CreateIndustry, ImageDLLLib, ButtonsLib, MainSwitchFrm2, DNMLib,
  ERPVersionConst;

{$R *.DFM}
const
  csExportFields  = 'PackageId, PageName,ActionName,EndActionName,TopLeft,Top,Width,Height,Nodetype,LineWidth,LineHeads,' +
                    'LineColor,SelectedColor,MarkColor,MarkSize,ArrowColor,LineStyle,Arrow1Kind,Arrow2Kind,IndustryId';

function ShowMenuCustomise(const AFormCaption, APanelCaption, ACustomisePage: string; const MCR: TMenuCustomiseRec; pWidth, pHeight : integer): integer;
var
  MenuForm: TfrmCustomiseMenu;
begin
//  Result := False;
  Result := mrCancel;
  MenuForm := TfrmCustomiseMenu(GetComponentByClassName('TfrmCustomiseMenu'));

  if Assigned(MenuForm) then
  begin
    try
      MenuForm.PanelWidth := pWidth;
      MenuForm.PanelHeight := pHeight;
      if AFormCaption <> '' then
        MenuForm.Caption := AFormCaption;
      if APanelCaption <> '' then begin
        MenuForm.TitleLabel.Caption := APanelCaption;
        MenuForm.Copytolbl.Caption  := COPY_TOOLBAR_LBL;
      end else begin
        MenuForm.Copytolbl.Caption := COPY_SWITCH_LBL;
      end;
      if ACustomisePage <> '' then begin
        MenuForm.FLockedPage := ACustomisePage;
        MenuForm.LockPageControls;
      end;

      MenuForm.FSettings := MCR;
  //    Result := (MenuForm.ShowModal <> mrCancel);
      Result := MenuForm.ShowModal;
    finally
      FreeandNil(MenuForm);
    end;
  end;
end;

function ShowMenuCustomiseForm(pWidth, pHeight : integer): integer;
begin
  Result := ShowMenuCustomise('', '', '', MainSwitchCustomiseRec, pWidth, pHeight);
end;

function CustomiseToolbar: boolean;
begin
  Result := ShowMenuCustomise('Customise Toolbar', 'Customise Toolbar', PAGE_NAME_TOOLBAR, ToolbarCustomiseRec, 0, 0) = mrOk;
end;

procedure TfrmCustomiseMenu.FillMenuCategoryCombo;
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

procedure TfrmCustomiseMenu.LoadAllPackageCategories;
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

procedure TfrmCustomiseMenu.LoadLayoutHistory(const AName: string);
var
  pm : TPageModifier;
  idx : integer;
begin
  // Check for changes in the selected id
  SaveLayoutChanges;


  cbHistory.Clear;
  ModList.Clear;
  if AName = '' then
  begin
    PreviewImage(nil);
    exit;
  end;
  qryLayouts.Close;
  qryLayouts.SQL.Text := 'SELECT Id, PageName, if(msTimeStamp=0, "1900-01-01 00:00:00", msTimeStamp) as msTimeStamp, Active from tblPageLayout where UserId=' + IntToStr(AppEnv.Employee.EmployeeID) +
          ' and PageName = "' + qryLoads.FieldByName('PageName').AsString + '"';

  qryLayouts.SQL.Text := 'select id, PageName, if(P.msTimeStamp=0, "1900-01-01 00:00:00", P.msTimeStamp), P.IndustryId, IndustryName';
  qryLayouts.SQL.Add('from tblPageLayout P');
  qryLayouts.SQL.Add('inner join tblIndustries I on I.IndustryId=P.IndustryId');
  qryLayouts.SQL.Add('where UserId=' + IntToStr(AppEnv.Employee.EmployeeID));
  qryLayouts.SQL.Add('and PageName = "' + qryLoads.FieldByName('PageName').AsString + '"');
  if not cbIndustry.Checked then
    qryLayouts.SQL.Add('and P.IndustryId=' + IntToStr(AppEnv.CompanyInfo.IndustryId));
  qryLayouts.SQL.Add('Group by ID Order by I.msTimeStamp desc');
  qryLayouts.Open;
  while not qryLayouts.eof do
  begin
    pm := TPageModifier.Create(ModList);
    pm.Id := qryLayouts.FieldByName('id').AsInteger;
    if cbIndustry.Checked then
      pm.Load(AName, 0)
    else
      pm.Load(AName, AppEnv.CompanyInfo.IndustryId);
//    pm.Load(AName);
    ModList.Add(pm);
    cbHistory.Items.AddObject(FormatDateTime(MySqlDateFormat, pm.TimeStamp) + ' ' + FormatDateTime(MySQLTimeFormat, pm.TimeSTamp) +
                              ' (' + pm.IndustryName + ')', pm);
    cbHistory.Checked[cbHistory.Items.Count - 1] := pm.Active;
    qryLayouts.Next;
  end;

  SelectedId := -1;

  if cbHistory.Items.Count = 0 then
    exit;

  for idx := 0 to cbHistory.Items.Count - 1 do
    if cbHistory.Checked[idx] then
    begin
      PreviewImage(TPageModifier(cbHistory.Items.Objects[idx]));
      SelectedId := TPageModifier(cbHistory.Items.Objects[idx]).id;
      exit;
    end;

  cbHistory.ItemIndex := 0;
  PreviewImage(TPageModifier(cbHistory.Items.Objects[0]));

end;

procedure TfrmCustomiseMenu.DisplayAvailSelectedButtons;
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
    PopulateSelectedView;
end;

procedure TfrmCustomiseMenu.DoExport(AList: TStringList);
var
  qry : TERPQuery;
  f : TextFile;
  sl : TStringList;
  s : string;
  idx : integer;
begin
  if not SaveDialog1.Execute then
    exit;
  if FileExists(SaveDialog1.FileName) then
    if MessageDlgXP_Vista('File Already Exists.'#13#10'Do You Want To Override It?', mtConfirmation, [mbYes, mbNo], 0)=mrNo then
      exit;

  sl := TStringList.Create;
  try
    sl.CommaText := csExportFields;
    qry := TERPQuery.Create(nil);
    try
      qry.Connection := GetSharedMyDacConnection;
      qry.SQL.Text := 'SELECT ' + csExportFields + ' from tblPageLayout where Active="T" and IndustryId=' + IntToStr(AppEnv.CompanyInfo.IndustryId);
      s := AList.CommaText;
      s := StringReplace(s, ',', '","', [rfReplaceAll]);
      s := StringReplace(s, ',""', ',"', [rfReplaceAll]);
      s := StringReplace(s, '"",', '",', [rfReplaceAll]);
      if s[1] <> '"' then
        s := '"' + s;
      if s[length(s)] <> '"' then
        s := s + '"';
      qry.SQL.Add('and PageName in (' + s + ')');
      qry.Sql.Add('order by LayoutId, Id');
      qry.Open;

      s := sl.CommaText;
      s := StringReplace(s, ',', '","', [rfReplaceAll]);
      s := '"' + s + '"';
      AssignFile(f, SaveDialog1.FileName);
      Rewrite(f);
      writeln(f, s);

      while not qry.Eof do
      begin
        for idx := 0 to sl.Count - 1 do
        begin
            case qry.FieldByName(sl[idx]).DataType of
             ftString, ftMemo, ftFixedChar, ftWideString,ftFixedWideChar, ftWideMemo:
               s := AnsiQuotedStr(qry.FieldByName(sl[idx]).AsString, '"');
             db.ftDate, db.ftDateTime, db.ftTime :
                s := '"' + FormatDateTime(MySQLDateTimeFormat, qry.FieldByName(sl[idx]).AsDateTime) + '"';
             else
               s := qry.FieldByName(sl[idx]).AsString;
            end;
          if idx = sl.Count - 1 then
            Write(f, s)
          else
            Write(f, s, ',');
        end;
        Writeln(f);
        qry.Next;
      end;
  finally
    qry.Free;
  end;
  finally
    CloseFile(f);
    sl.Free;
  end;
end;

procedure TfrmCustomiseMenu.cbCategoriesSelect(Sender: TObject);
begin
    inherited;
    UpdateAvailableButtonsView;
end;

procedure TfrmCustomiseMenu.cbHistoryClick(Sender: TObject);
var
  idx : integer;
begin
  for idx := 0 to cbHistory.Items.Count - 1 do
    if cbHistory.Selected[idx] then
      PreviewImage(TPageModifier(cbHistory.Items.Objects[idx]));

end;

procedure TfrmCustomiseMenu.cbHistoryClickCheck(Sender: TObject);
var
  idx : integer;
begin
  if cbHistory.Checked[cbHistory.ItemIndex] then
  begin
    for idx := 0 to cbHistory.Items.Count - 1 do
      if idx <> cbHistory.ItemIndex then
        cbHistory.Checked[idx] := false;
  end
  else
  begin
    if cbHistory.Items.Count = 1 then
    begin
      MessageDlgXP_Vista('At Least One Layout Is To Be Active.', mtWarning, [mbOk], 0);
      cbHistory.Checked[cbHistory.ItemIndex] := true;
    end;
  end;
end;

procedure TfrmCustomiseMenu.cbHistoryKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=VK_DELETE then
  begin
    DeleteLayout;
  end;
end;

procedure TfrmCustomiseMenu.cbIndustryClick(Sender: TObject);
begin
  inherited;
  LoadLayoutHistory(qryLoads.FieldByName('PageName').AsString);
end;

procedure TfrmCustomiseMenu.FormDestroy(Sender: TObject);
begin
    FreeandNil(PageConfig);
    FreeandNil(Prefs);
    ImagesOffset := nil;
    ModList.Free;
    ChangedPageList.Free;
    inherited;
end;

function TfrmCustomiseMenu.LoadPreferences: boolean;
begin
  Result := LoadPageConfigData(PageConfig, FSettings);
end;

procedure TfrmCustomiseMenu.GetDefaultPreferences;
begin
  if (FSettings.PrefName = PREF_NAME_MAIN_SWITCH_MENU) then
    GetMainMenuDefaultPreferences(PageConfig)
  else if (FSettings.PrefName = PREF_NAME_TOOLBAR_MENU) then
    GetToolbarDefaultPreferences(PageConfig)
  else
    try
      btnOk.Enabled := false;
    finally
      raise Exception.Create('Loading menu preferences for unknown type failed');
    end;
end;

procedure TfrmCustomiseMenu.grdPagesRowChanged(Sender: TObject);
begin
  inherited;
//
  LoadLayoutHistory(qryLoads.FieldByName('PageName').AsString);
end;

procedure TfrmCustomiseMenu.SaveChangedPagesLayouts;
var
  idx : integer;
  page : TPageItem;
  lTop, lLeft : integer;
  lName : string;
  sl : TStringList;
  nButtons : integer;
  btn : integer;
  id : integer;
  act : TAction;
begin
  if ChangedPageList.Count = 0 then Exit;
  if PanelWidth = 0 then Exit;

  sl := TStringList.Create;
  sl.CaseSensitive := false;

  try
    nButtons := PanelWidth div MENU_MIN_OFFSET_X;   // buttons in a row - number of columns

    qryMaxId.Close;
    qryMaxId.Open;
    if qryMaxId.RecordCount = 0 then
      id := 1
    else
      id := qryMaxId.FieldByName('id').AsInteger + 1;

    scrLayouts.SQL.Clear;
    try
      while ChangedPageList.Count > 0 do begin
        Page := PageConfig.PageByName[ChangedPageList[0]];
        if Assigned(Page) then
        begin
          scrLayouts.SQL.add('UPDATE tblPageLayout SET Active="F" WHERE PageName="' + Page.PageName + '" AND UserId=' + IntToStr(AppEnv.Employee.EmployeeID) +
            ' AND IndustryId=' + IntToStr(AppEnv.CompanyInfo.IndustryId) + ';');

          sl.CommaText := Page.ButtonList;
          btn := 0;
          for idx := 0 to sl.Count - 1 do begin
            act := dtmMainGUI.ActionHelper.ActionByName[sl[idx]];
            if Assigned(act) then
              if Not act.Enabled Or Not act.Visible then Continue;

            lName := sl[idx];
            lTop := (btn div nButtons) * MENU_MIN_OFFSET_Y + MENU_BUTTON_SPACE_Y;
            lLeft := (btn mod nButtons) * MENU_MIN_OFFSET_X + MENU_BUTTON_SPACE_X;

            scrLayouts.sql.Add('INSERT INTO tblPageLayout(UserId, PageName, Active, IsDefault, Id, ActionName, TopLeft, Top, Width, Height, NodeType, IndustryId) VALUES(');
            scrLayouts.SQL.Add(Format('%d, "%s", "T", "T", %d, "%s", %d, %d, %d, %d, 0, %d);',
              [AppEnv.Employee.EmployeeID, Page.PageName, id, lName, lLeft, lTop, MENU_BUTTON_WIDTH, MENU_BUTTON_HEIGHT, AppEnv.CompanyInfo.IndustryId]));
            Inc(btn);
          end;
          ChangedPageList.Delete(0);
          id := id + 1;
        end;
      end;
    finally
      if scrLayouts.SQL.Count > 0 then begin
        self.showProgressbar('Saving',scrLayouts.Statements.Count);
        scrLayouts.AfterExecute := DoScriptAfterexecute;
        scrLayouts.Execute;
        self.HideProgressbar;
      end;
    end;
  finally
    sl.Free;
  end;
end;

procedure TfrmCustomiseMenu.SaveLayoutChanges;
var
  newId : integer;
  idx : integer;
begin
  // Check for changes in the selected id
  if cbHistory.Items.Count > 0 then
  begin
    newId := -1;
    for idx := 0 to cbHistory.Items.Count - 1 do
      if cbHistory.Selected[idx] then
      begin
        newId := TPageModifier(cbHistory.Items.Objects[idx]).Id;
        break;
      end;
    if (newId >= 0) and (SelectedId >= 0) and (NewId <> SelectedId) then
    begin
      scrLayouts.SQL.Clear;
      scrLayouts.SQL.add('update tblPageLayout set Active="F" where id=' + IntToStr(SelectedId) + ';');
      scrLayouts.sql.add('update tblPageLayout set Active="T" where id=' + IntToStr(newId) + ';');
      scrLayouts.Execute;
    end;
  end;
end;

function TfrmCustomiseMenu.SavePreferences: boolean;
begin
  Result := SavePageConfigData(PageConfig, FSettings);
end;

procedure TfrmCustomiseMenu.SaveTrainingButtons;
const
  csAddTrainingButtons = 'INSERT INTO tblTrainingButtons (HowToId, EmployeeId, PageName)'#13#10 +
                      'VALUES (-1, %d, "")';
  csRemoveTrainingButtons = 'DELETE FROM tblTrainingButtons WHERE EmployeeId=%d';
begin
  if DefaultWasSet then
  begin
    qryTrainingButtons.SQL.Text := Format(csRemoveTrainingButtons, [AppEnv.Employee.EmployeeID]);
    qryTrainingButtons.ExecSQL;
    qryTrainingButtons.SQL.Text := Format(csAddTrainingButtons,  [AppEnv.Employee.EmployeeID]);
    qryTrainingButtons.ExecSQL;
  end;
end;

procedure TfrmCustomiseMenu.DoScriptAfterexecute(Sender: TObject; SQL: string);
begin
  self.stepProgressbar();
end;

procedure TfrmCustomiseMenu.ClearLayouts;
var
  idx : integer;
  Action : TAction;
begin
  if DefaultWasSet then begin
    for idx := 0 to PageConfig.Count - 1 do begin
      ChangedPageList.Add(PageConfig.Items[idx].PageName);
    end;

    SaveChangedPagesLayouts;
  end;
end;

procedure TfrmCustomiseMenu.CopyUserCustomisationPreferences;
var
  CopyToID, UserID: integer;
  msg: string;
  x: integer;
begin
  Processingcursor(True);
  try
    UserID := AppEnv.Employee.EmployeeID;
    for x := 0 to lstEmployees.Count -1 do begin
      if lstEmployees.Checked[x] then begin
        CopyToId := Integer(lstEmployees.Items.Objects[x]);
        if TitleLabel.Caption <> 'Customise Toolbar' then begin
          if not TPreference.CopyPreference(UserID,CopyToID,PREF_GROUP_MAIN_SWITCH,PREF_NAME_MAIN_SWITCH_MENU, msg) then begin
            CommonLib.MessageDlgXP_Vista('Error copying Preference: ' + msg, mtWarning,[mbOk],0);
          end;
        end else begin
          if not TPreference.CopyPreference(UserID,CopyToID,PREF_GROUP_MAIN,PREF_NAME_TOOLBAR_MENU, msg) then begin
            CommonLib.MessageDlgXP_Vista('Error copying Preference: ' + msg, mtWarning,[mbOk],0);
          end;
        end;
      end;
    end;
  finally
    Processingcursor(False);
  end;
end;

procedure TfrmCustomiseMenu.btnOkClick(Sender: TObject);
begin
  inherited;
  SavePreferences;
  SaveTrainingButtons;
  SaveChangedPagesLayouts;
  SaveLayoutChanges;
  ClearLayouts;
  CopyUserCustomisationPreferences;
  ModalResult := mrOk;
end;

function TfrmCustomiseMenu.CurrentButtonList: string;
var
  List: TStrings;
  I: integer;
begin
  List := TStringList.Create;
  try
    if lvSelectedButtons.Items.Count > 0 then
      for I := 0 to lvSelectedButtons.Items.Count - 1 do
        if Assigned(lvSelectedButtons.Items[I].Data) then
          List.Add(TAction(lvSelectedButtons.Items[I].Data).Name);
    Result := List.CommaText;
  finally
    FreeandNil(List);
  end;
end;

procedure TfrmCustomiseMenu.cbPagesDropDown(Sender: TObject);
begin
  inherited;
  InternalPageConfigUpdate;
end;

procedure TfrmCustomiseMenu.InternalPageConfigUpdate;
var
  PageName: string;
begin// Save the currently selected items
  PageName := ActiveSelectedPage;
  if PageName <> '' then
  begin
    if PageConfig.PageByName[PageName].ButtonList <> CurrentButtonList then
    begin
      PageConfig.UpdateButtonList(PageName, CurrentButtonList);
      ChangedPageList.Add(PageName);
    end;
  end;
end;

function TfrmCustomiseMenu.IsSelectedAction(const ActionName: string): boolean;
var
  I: integer;
begin
  Result := false;
  if lvSelectedButtons.Items.Count > 0 then
    for I := 0 to lvSelectedButtons.Items.Count - 1 do
      if TAction(lvSelectedButtons.Items[I].Data).Name = ActionName then begin
        Result := true;
        Break;
      end;
end;

procedure TfrmCustomiseMenu.cbPagesSelect(Sender: TObject);
begin
  inherited;
  ListSelectedButtons;
end;

procedure TfrmCustomiseMenu.ListSelectedButtons;
var
  ButtonList, ActionName: string;
  List: TStrings;
  I: integer;
  li: TListItem;
  Action: TAction;
  j: integer;
  SelAddinInfo: TAddinPackageInfo;
begin
  lvSelectedButtons.Clear;
  Try
    ButtonList := PageConfig.PageByName[ActiveSelectedPage].ButtonList;
  Except
    // kill the exception
  End;
  if ButtonList <> '' then begin
    List := TStringList.Create;
    try
      List.CommaText := ButtonList;
      if List.Count > 0 then
        for I := 0 to List.Count - 1 do begin
          ActionName := List[I];// find corresponding action
          Action := dtmMainGUI.ActionHelper.ActionByName[ActionName];
          if Assigned(Action) then begin
            li := lvSelectedButtonsNewItem;
            li.Caption := Action.Caption;
            li.ImageIndex := Action.ImageIndex-1;
            li.Data := Action;
          end else begin//now load from any packages
            for j := 0 to AddinPackageList.Count - 1 do begin
              SelAddinInfo := TAddinPackageInfo(AddinPackageList[j]);

              if Assigned(SelAddinInfo.GuiDataModule) then begin
                Action := SelAddinInfo.GuiDataModule.GetAction(ActionName);
                if Assigned(Action) then begin
                    li := lvSelectedButtonsNewItem;
                    li.Caption := Action.Caption;
                        li.ImageIndex := Action.ImageIndex-1;
                    li.Data := Action;
                    Break;{Assume the first actionname found can be the only one}

                end;
              end;{if}
            end;{for}
          end;{if}
        end;{for}
    finally
      FreeandNil(List);
    end;
  end;
end;

procedure TfrmCustomiseMenu.btnAddButtonClick(Sender: TObject);
begin
  inherited;

  If (lvSelectedButtons.Items.Count >= MaxSelect) then begin
    MessageDlgXP_Vista(cbPages.text+' Page already has ' + inttostr(lvSelectedButtons.Items.Count)+' items.  you can have only '+inttostr(MaxSelect)+' in a page.', mtWarning, [mbOK], 0);
    Exit;
  end;

  AddAvailableToSelected(true);
end;

procedure TfrmCustomiseMenu.btnAddAllButtonsClick(Sender: TObject);
begin
  inherited;
  if lvAvailableButtons.Items.Count > 0 then begin
    while lvAvailableButtons.Items.Count > 0 do begin
      lvAvailableButtons.Selected := lvAvailableButtons.Items[0];
      If (lvSelectedButtons.Items.Count>=MaxSelect) then Break;
      AddAvailableToSelected(false);
      lvAvailableButtons.DeleteSelected;
    end;
    InternalPageConfigUpdate;
  end;
end;

Function TfrmCustomiseMenu.IsSelectedButtons(const TestButton : TListItem):Boolean;
Var
  I :Integer;
Begin
  Result := False;
  for I := 0 to lvSelectedButtons.Items.Count-1 do
    If Sysutils.SameText(lvSelectedButtons.Items[I].Caption , TestButton.Caption) then Begin
      Result := True;
      Exit;
    end;
end;


procedure TfrmCustomiseMenu.AddAvailableToSelected(const DoUpdate: boolean);
var
  li, li2: TListItem;
begin
  li := lvAvailableButtons.Selected;
  if (not Assigned(li)) or IsSelectedButtons(li) then Exit;
  if Assigned(li) then begin// add button to selected buttons
    li2         := lvSelectedButtonsNewItem;
    li2.Caption := li.Caption;
    li2.Data    := li.Data;
    li2.ImageIndex := li.ImageIndex;
    if DoUpdate then begin// remove button from list of available buttons
      lvAvailableButtons.DeleteSelected;// update the page
      InternalPageConfigUpdate;
    end;
  end;
end;

procedure TfrmCustomiseMenu.PageControl1Change(Sender: TObject);
begin
  inherited;
    if PageControl1.ActivePage = tsLayouts then
    begin
      SaveChangedPagesLayouts;
      qryLoads.Close;
      qryLoads.Open;
      if qryLoads.RecordCount = 0 then
        LoadLayoutHistory('')
      else
        LoadLayoutHistory(qryLoads.FieldByName('PageName').AsString);
    end;
//
end;

procedure TfrmCustomiseMenu.PopulateSelectedView;
var
  I, j: integer;
  List: TStrings;
begin
  if PageConfig.Count > 0 then begin
    cbPages.Clear;
    for I := 0 to PageConfig.Count - 1 do
      cbPages.Items.Add(PageConfig.Items[I].PageName);
    cbPages.ItemIndex := 0;
    List := TStringList.Create;
    try
      List.CommaText := PageConfig.Items[0].ButtonList;
      if List.Count > 0 then begin
        lvSelectedButtons.Clear;
        for j := 0 to List.Count - 1 do
          AddActionToListView(List[j], lvSelectedButtons);
      end;
    finally
      FreeandNil(List);
    end;
  end;
end;

procedure TfrmCustomiseMenu.PreviewImage(AItem: TPageModifier);
var
  xR,
  yR : extended;
  idx : integer;
//  r : TRect;
  d : TPageItemDesc;
  pts : array [0..3] of TPoint;
begin
  Image1.Canvas.Brush.Color := clWhite;
  Image1.Canvas.FillRect(Image1.Canvas.ClipRect);
  if not Assigned(AItem) then
    exit;

  xr := Image1.Width / PanelWidth;
  yr := Image1.Height / PanelHeight;
  Image1.Canvas.Brush.Color := clGray;
  Image1.Canvas.Pen.Color := clBlack;

  for idx := 0 to AItem.Count - 1 do
  begin
    d := AItem.Items[idx];
    if d.NodeType = mtButton then
    begin
      pts[0] := Point(Trunc(d.Left * xR), Trunc(d.Top * yr));
      pts[1] := Point(Trunc((d.Left + d.Width) * xR), Trunc(d.Top * yr));
      pts[2] := Point(Trunc((d.Left + d.Width)* xR), Trunc((d.Top + d.Height) * yr));
      pts[3] := Point(Trunc(d.Left * xR), Trunc((d.Top+d.Height) * yr));
      Image1.Canvas.Polygon(pts);
    end
    else
    begin
      Image1.Canvas.MoveTo(Trunc(d.Left * xR), Trunc(d.Top * yr));
      Image1.Canvas.LineTo(Trunc(d.Width  * xR), Trunc(d.Height * yr));
    end;
  end;
end;

procedure TfrmCustomiseMenu.qryLayoutsBeforeEdit(DataSet: TDataSet);
begin
  inherited;
//
end;

procedure TfrmCustomiseMenu.AddActionToListView(Const ActionName: string; Const ListView: TListView);
var
  Action: TAction;
  li: TListItem;
  i: integer;
  SelAddinInfo: TAddinPackageInfo;
begin
  Action := dtmMainGUI.ActionHelper.ActionByName[ActionName];
  if Assigned(Action) then begin
    li := ListView.Items.Add;
    li.Caption := Action.Caption;
    li.ImageIndex := Action.ImageIndex-1;
    li.Data    := Action;
  end else begin//now load from any packages
    for i := 0 to AddinPackageList.Count - 1 do begin
      SelAddinInfo := TAddinPackageInfo(AddinPackageList[i]);
      {get the data module}

      if Assigned(SelAddinInfo.GuiDataModule) then begin
        Action := SelAddinInfo.GuiDataModule.GetAction(ActionName);
        if Assigned(Action) then begin
            li := ListView.Items.Add;
            li.Caption := Action.Caption;//   li.ImageIndex := Action.ImageIndex-1;
            li.ImageIndex := ImagesOffset[i] + Action.ImageIndex-1;
            li.Data := Action;
            Break;
        end;
      end;
    end;
  end;
end;

procedure TfrmCustomiseMenu.lvSelectedButtonsKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
begin
  inherited;
  if (Key = VK_DELETE) and Assigned(lvSelectedButtons.Selected) then
    DeleteSelectedButton;
end;

procedure TfrmCustomiseMenu.DeleteLayout;
var
  pm : TPageModifier;
begin
  if cbHistory.Checked[cbHistory.ItemIndex] then
  begin
    MessageDlgXP_Vista('Cannot Delete Layout When It Is Active.', mtWarning, [mbOk], 0);
    Exit;
  end;
  if cbHistory.Items.Count = 1 then
  begin
    MessageDlgXP_Vista('Cannot Delete The Only Layout In List.', mtWarning, [mbOk], 0);
    Exit;
  end;

  pm := TPageModifier(cbHistory.Items.Objects[cbHistory.ItemIndex]);
  if not assigned(pm) then
    exit;
  scrLayouts.SQL.Clear;
  scrLayouts.SQL.Text := 'delete from tblPageLayout where id=' + IntToStr(pm.Id);
  scrLayouts.Execute;
  modList.Delete(modList.IndexOf(pm));
  cbHistory.Items.Delete(cbHistory.ItemIndex);
  cbHistory.ItemIndex := 0;
end;

procedure TfrmCustomiseMenu.DeleteSelectedButton;
var
  li: TListItem;
  Category: string;
begin
  li := lvSelectedButtons.Selected;

  if Assigned(li) then begin
    Category := '';

    if Assigned(li.Data) then begin
      if (TAction(li.Data).Category = ActiveMenuCategory) or (ActiveMenuCategory = MENU_CATEGORY_ALL) then
        Category := ActiveMenuCategory;
    end;

    lvSelectedButtons.DeleteSelected;

    if Category <> '' then
      UpdateAvailableButtonsView;

    InternalPageConfigUpdate;
  end;
end;

function TfrmCustomiseMenu.ActiveMenuCategory: string;
begin
  Result := '';

  if cbCategories.ItemIndex <> -1 then
    Result := cbCategories.Items[cbCategories.ItemIndex];
end;

procedure TfrmCustomiseMenu.UpdateAvailableButtonsView;
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
      if not IsSelectedAction(Action.Name) then begin
        li := lvAvailableButtonsNewItem;
        li.Caption := Action.Caption;
        li.ImageIndex := Action.ImageIndex-1;
        li.Data := Action;
      end;
  end;
  //update any packages categories
  Setlength(ImagesOffset, AddinPackageList.Count);

  for i := 0 to AddinPackageList.Count - 1 do begin
    ImagesOffset[i] := ImageListAll.Count;
    SelAddinInfo := TAddinPackageInfo(AddinPackageList[i]);

    if Assigned(SelAddinInfo.GuiDataModule) then begin
        for k := 0 to  SelAddinInfo.GuiDataModule.ComponentCount-1 do begin
            if SelAddinInfo.GuiDataModule.Components[k] is TActionlist then begin
                for j := 0 to TActionList(SelAddinInfo.GuiDataModule.components[k]).ActionCount-1 do begin
                    Action := TAction(TActionList(SelAddinInfo.GuiDataModule.components[k]).Actions[j]);
                    if  Action.Visible and ((Action.Category = ActiveMenuCategory) or (ActiveMenuCategory = MENU_CATEGORY_ALL)) then
                        if not IsSelectedAction(Action.Name) then begin
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

procedure TfrmCustomiseMenu.btnMoveItemUpClick(Sender: TObject);
begin
  inherited;
  MoveSelectedButtonUp;
end;

procedure TfrmCustomiseMenu.MoveSelectedButtonDown;
var
  li, li2: TListItem;
  NewPos: integer;
begin
  if (lvSelectedButtons.ItemIndex <> -1) and (lvSelectedButtons.ItemIndex < (lvSelectedButtons.Items.Count - 1)) then begin
    NewPos      := lvSelectedButtons.ItemIndex + 2;
    li          := lvSelectedButtons.Selected;
    li2         := lvSelectedButtons.Items.Insert(NewPos);
    li2.Caption := li.Caption;
    li2.ImageIndex := li.ImageIndex;
    li2.Data    := li.Data;
    lvSelectedButtons.DeleteSelected;
    lvSelectedButtons.ItemIndex := NewPos - 1;
    InternalPageConfigUpdate;
  end;
end;

procedure TfrmCustomiseMenu.MoveSelectedButtonUp;
var
  li, li2: TListItem;
  NewPos: integer;
begin
  if lvSelectedButtons.ItemIndex > 0 then begin
    NewPos      := lvSelectedButtons.ItemIndex - 1;
    li          := lvSelectedButtons.Selected;
    li2         := lvSelectedButtons.Items.Insert(NewPos);
    li2.Caption := li.Caption;
    li2.ImageIndex := li.ImageIndex;
    li2.Data    := li.Data;
    lvSelectedButtons.DeleteSelected;
    lvSelectedButtons.ItemIndex := NewPos;
    InternalPageConfigUpdate;
  end;
end;

procedure TfrmCustomiseMenu.btnMoveItemDownClick(Sender: TObject);
begin
  inherited;
  MoveSelectedButtonDown;
end;

function TfrmCustomiseMenu.ActiveSelectedPage: string;
begin
  Result := '';
  if cbPages.ItemIndex <> -1 then
    Result := cbPages.Items[cbPages.ItemIndex];
end;

procedure TfrmCustomiseMenu.btnRemoveButtonClick(Sender: TObject);
begin
  inherited;
  DeleteSelectedButton;
end;

procedure TfrmCustomiseMenu.btnRemoveAllButtonsClick(Sender: TObject);
var
  I: integer;
begin
  inherited;
  if lvSelectedButtons.Items.Count > 0 then begin
    for I := 0 to lvSelectedButtons.Items.Count - 1 do begin
      lvSelectedButtons.Selected := lvSelectedButtons.Items[I];
      AddSelectedToAvailable(false);
    end;
    lvSelectedButtons.Clear;
    InternalPageConfigUpdate;
    UpdateAvailableButtonsView;
  end;
end;

procedure TfrmCustomiseMenu.AddSelectedToAvailable(const DoUpdate: boolean);
var
  li: TListItem;
begin
    try
        li := lvSelectedButtons.Selected;
        if Assigned(li) then begin
            lvSelectedButtons.DeleteSelected;
            if TAction(li.Data).Category = ActiveMenuCategory then
                if DoUpdate then
                    UpdateAvailableButtonsView;
        end;
    Except
        //kill the exception
    end;
end;

function TfrmCustomiseMenu.IsAvailableMenuAction(const ActionName: string): boolean;
var
  I: integer;
begin// this function returns true only for currently selected menu category
  Result := false;
  if lvAvailableButtons.Items.Count > 0 then
    for I := 0 to lvAvailableButtons.Items.Count - 1 do
      if (TAction(lvAvailableButtons.Items[I].Data).Name = ActionName) And TAction(lvAvailableButtons.Items[I].Data).Enabled AND
         TAction(lvAvailableButtons.Items[I].Data).Visible then begin
        Result := true;
        Break;
      end;
end;

procedure TfrmCustomiseMenu.lvSelectedButtonsDragDrop(Sender, Source: TObject; X, Y: integer);
var
  SourceItem, DestItem: TListItem;
  Index: integer;
begin
  SourceItem := (Source as TListView).GetNextItem(nil, sdAll, [isSelected]);
  DestItem := lvSelectedButtons.GetItemAt(X, Y);
  Index := -1;
  if Assigned(DestItem) then
    Index := DestItem.Index;
  if Index <> -1 then
    DestItem := lvSelectedButtons.Items.Insert(Index)
  else
    DestItem := lvSelectedButtonsNewItem;
  DestItem.Caption := SourceItem.Caption;
  DestItem.ImageIndex := SourceItem.ImageIndex;
  DestItem.Data := SourceItem.Data;
  lvSelectedButtons.ItemIndex := lvSelectedButtons.Items.Count - 1;
  SourceItem.Delete;
  InternalPageConfigUpdate;
end;

procedure TfrmCustomiseMenu.lvSelectedButtonsDragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
begin
  Accept := Source is TListView;
  if Accept then
    Accept := (TListView(Source).Name = 'lvAvailableButtons');
end;

procedure TfrmCustomiseMenu.btnAddPageClick(Sender: TObject);
var
  NewPageName: string;
begin
  inherited;
  NewPageName := InputBox('Enter page name', 'New page name', '');

  if NewPageName <> '' then
    if PageConfig.PageExists(NewPageName) then
      CommonLib.MessageDlgXP_Vista(Format('Page "%s" already exists', [NewPageName]), mtWarning, [mbOK], 0)
(*    else if Special and AppEnv.CompanyPrefs.AllowFlowPages then
    begin
      MessageDlgXP_Vista('Created Special Page ' + NewPageName +'.'#13#10'Page Cannot Be Edited Here.'#13#10+
       'To Edit It, Go To The Page In Main Screen', mtInformation, [mbOk], 0);
       PageConfig.AddSpecialPage(NewPageName);
    end *)
    else begin
      cbPages.Items.Add(NewPageName);
      cbPages.ItemIndex := cbPages.Items.IndexOf(NewPageName);
      PageConfig.AddPage(NewPageName);
      lvSelectedButtons.Clear;
    end;
end;

procedure TfrmCustomiseMenu.btnDeletePageClick(Sender: TObject);
var
  PageName: string;
begin
  inherited;
  PageName := ActiveSelectedPage;
  if IsSystemPage(PageName) then begin
    CommonLib.MessageDlgXP_Vista('This page cannot be deleted', mtWarning, [mbOK], 0);
    Exit;
  end;
  if PageConfig.PageHasButtons(PageName) then
    if CommonLib.MessageDlgXP_Vista('This page contains buttons. ' + 'Are you sure you still want to delete it?', mtWarning, [mbYes, mbNo], 0) <> mrYes then
      Exit;// 1. delete page from combo box
  //lvSelectedButtons.Clear;
  cbPages.DeleteSelected;
  if cbPages.Items.Count > 0 then
    cbPages.ItemIndex := cbPages.Items.Count - 1 // 2. delete buttons from selected list view
  else begin

    cbPages.Text := '';
    cbPages.Update;
  end;
  lvSelectedButtons.Clear;// 3. delete item from page config object
  PageConfig.DeletePage(PageName);
  if ActiveSelectedPage <> '' then
    ListSelectedButtons;
end;

procedure TfrmCustomiseMenu.btnExportClick(Sender: TObject);
var
  lRes : integer;
  lList : TStringList;
begin
  inherited;
  lList := nil;
  lRes := MessageDlgXP_Vista('Do You Want To Export Only Current Page (' + qryLoads.FieldByName('PageName').AsString +
      ')'#13#10'or Select Pages To Export?', mtConfirmation,
      [],  0, nil, '' , '' , False, nil, 'Export Current, Select, Cancel');
  if lRes = 102 then
    exit;

  try
    case lRes  of
      100 : begin
        lList := TStringList.Create;
        lList.Add(qryLoads.FieldByName('PageName').AsString);
        DoExport(lList);
        end;
      101 : begin
        lList := SelectFromList(QryLoads, 'PageName', 'Select Pages To Export');
        if assigned(lList) and (lList.Count > 0) then
          DoExport(lList)
        else
          MessageDlgXP_Vista('No Pages Has Been Selected; Nothing To Export', mtWarning, [mbOk], 0);
        end;
    end;
  finally
    lList.Free;
  end;
end;

procedure TfrmCustomiseMenu.btnImportClick(Sender: TObject);
var
  scr : TERPScript;
  f : TextFile;
  slFields,
  sl : TStringList;
  idx : integer;
  s : string;
  lFields : string;
  CurrentPage : string;
  CurrentId : integer;
  sCurrentId : string;
  sUserId : string;
  PageIdx : integer;


procedure SetPageIdx;
var
  i : integer;
begin
  for i := 0 to sl.Count - 1 do
    if SameText(sl[i], 'PageName') then
    begin
      PageIdx := i;
      exit;
    end;
  PageIdx := -1;
end;

function NextLine : boolean;
begin
  s := '';
  while (s = '') and not EOF(f) do
    Readln(f,s);
  Result := S <> '';
end;

function CheckValue(const AValue : string) : string;
begin
  if AValue = '' then
    Result := '""'
  else if CharInSet(AValue[1], ['0'..'9']) then
    Result := AValue
  else
    Result := '"' + AValue + '"';
end;

procedure SetDefaults;
var
  qry : TERPQuery;
begin
  qry := TERPQuery.Create(nil);
  try
    qry.Connection := GetSharedMyDacConnection;
    qry.SQL.Text := 'select max(id) from tblPageLayout';
    qry.Open;
    if qry.RecordCount = 0 then
    begin
      CurrentId := 1;
      sCurrentId := '1';
    end
    else
    begin
      CurrentId := qry.Fields[0].AsInteger + 1;
      sCurrentId := IntToStr(CurrentId);
    end;
    sUserId := IntToStr(AppEnv.Employee.EmployeeID);

  finally
    qry.Free;
  end;
end;

procedure NextId;
begin
  CurrentId := CurrentId + 1;
  sCurrentId := IntToStr(CurrentId);
end;

begin
  if not OpenDialog1.Execute then
    exit;

  try
    sl := TStringList.Create;
    try
      AssignFile(f, OpenDialog1.FileName);
      Reset(f);
      if not NextLine then
      begin
        MessageDlgXP_Vista('File ' + OpenDialog1.FileName + ' Does not Contain Any Data', mtError, [mbOk], 0);
        exit;
      end;

      lFields := '';
      // Should no be any spaces, otherwise CommaText works incorrectly
      for idx := 1 to length(s) do
        if s[idx] = ' ' then
          continue
        else
          lFields := lFields + s[idx];

      if lFields='' then
      begin
        MessageDlgXP_Vista('File ' + OpenDialog1.FileName + ' Does not Contain Field Names', mtError, [mbOk], 0);
        exit;
      end;

      sl.CommaText := lFields;
      lFields := '(' + StringReplace(lFields, '"', '', [rfReplaceAll]) + ',id,UserId)';
      SetPageIdx;
      if PageIdx = - 1 then
      begin
        MessageDlgXP_Vista('Field "PageName" MUST be Present in the file, but was not Found.'#13#10+
          'Bad File Format', mtWarning, [mbOk], 0);
        exit;
      end;
      CurrentPage := '';
      SetDefaults;

//      qry := TERPQuery.Create(nil);
      scr := TERPScript.Create(nil);
      try
        scr.Connection := GetSharedMyDacConnection;
        slFields := TStringList.Create;
        try
          while NextLine do
          begin
            slFields.Clear;
            slFields.CommaText := s;
            if slFields.Count <> sl.Count then
            begin
              MessageDlgXP_Vista('Line ' + slFields.CommaText + #13#10'Contains ' + IntToStr(slFields.Count) + 'Values, '+
                'Should Be ' + IntToStr(sl.Count) + ' Values.'#13#10'Line Skipped', mtWarning, [mbOk], 0);
              Continue;
            end;
            if CurrentPage = '' then
              CurrentPage := slFields[PageIdx]
            else
            begin
              if not (SameText(slFields[PageIdx], CurrentPage)) then
              begin
                NextId;
                CurrentPage := slFields[PageIdx];
              end;
            end;
            scr.SQL.Add('insert into tblPageLayout ');
            scr.SQL.Add(lFields + ' Values (');
            // in this table values we have only numbers and texts without spaces. Can work without deep value analysis
            s := '';
            for idx := 0 to slFields.Count - 1 do
              if s = '' then
                s := CheckValue(slFields[idx])
              else
                s := s + ',' + CheckValue(slFields[idx]);
            scr.SQL.Add(s + ',' + sCurrentId + ',' + sUserId + ');')
          end;
        finally
          slFields.Free;
        end;
      finally
        if scr.SQL.Count > 0 then
          scr.Execute;
        scr.Free;
      end;
    finally
      sl.Free;
    end;
  except
    on e:Exception do
      MessageDlgXP_Vista('Error Encountered While Importing'#13#10+e.Message, mtError, [mbOk], 0);
  end;

end;

procedure TfrmCustomiseMenu.btnIndustryClick(Sender: TObject);
var
  frm : TForm;
begin
  inherited;
//
  frm := TfrmCreateIndustry.Create(nil);
  try
    frm.ShowModal;
  finally
    frm.Free;
  end;

end;

procedure TfrmCustomiseMenu.lvAvailableButtonsDblClick(Sender: TObject);
var
  Item: TListItem;
begin
  inherited;
  ProcessingCursor(True);
  try
      Item := lvAvailableButtons.GetNextItem(nil, sdAll, [isSelected]);
      if Assigned(Item) then begin// work out if item belongs to currently selected menu category
        try
            SendEmailtoErp('Change Image Index', 'User :' + Appenv.Employee.EmployeeName +NL +
                                                  'Company     :' + Appenv.CompanyInfo.Companyname + NL +
                                                  'Server      :' + GetSharedMyDacConnection.Server + NL +
                                                  'Datase      :' + GetSharedMyDacConnection.Database + NL +
                                                  'Version     :' + TABLE_VERSION+NL+NL+NL+
                                                  'Name :' + ControlName(TDnmAction(Item.data)) + NL+
                                                  'Caption :' + Item.Caption+ NL+
                                                  'Image Index :' + inttostr(Item.ImageIndex),'WrongImage');
             if devmode then timerMsg(lblMsg ,'Email Sent to ERP for changing image');
        except
        end;
      end;
  finally
    Processingcursor(False);
  end;
end;

procedure TfrmCustomiseMenu.lvAvailableButtonsDragDrop(Sender, Source: TObject; X, Y: integer);
var
  SourceItem: TListItem;
  CategoryMember: boolean;
begin
  CategoryMember := false;
  SourceItem := (Source as TListView).GetNextItem(nil, sdAll, [isSelected]);
  if Assigned(SourceItem) then begin// work out if item belongs to currently selected menu category
    CategoryMember := (ActiveMenuCategory = MENU_CATEGORY_ALL);
    if not CategoryMember then
      if Assigned(SourceItem.Data) then
        CategoryMember := (TAction(SourceItem.Data).Category = ActiveMenuCategory);
  end;
  SourceItem.Delete;
  if CategoryMember then
    UpdateAvailableButtonsView;
end;

procedure TfrmCustomiseMenu.lvAvailableButtonsDragOver(Sender, Source: TObject; X, Y: integer; State: TDragState; var Accept: boolean);
begin
  inherited;
  Accept := Source is TListView;
  if Accept then
    Accept := (TListView(Source).Name = 'lvSelectedButtons');
end;

function TfrmCustomiseMenu.IsSystemPage(const APageName: string): boolean;
begin
  Result := Sysutils.SameText(APageName, PAGE_NAME_TOOLBAR);
end;

procedure TfrmCustomiseMenu.LockPageControls;
begin
  btnAddPage.Enabled := false;
  btnDeletePage.Enabled := false;
  cbPages.Enabled := false;
end;

procedure TfrmCustomiseMenu.btnDefaultClick(Sender: TObject);
begin
  inherited;
  if TitleLabel.Caption = 'Customise Toolbar' then begin
    GetToolbarDefaultPreferences(PageConfig);
  end else begin
    GetMainMenuDefaultPreferences(PageConfig);
    DefaultWasSet := true;  // Default was clicked for MainMenu
  end;
  DisplayAvailSelectedButtons;
end;

procedure TfrmCustomiseMenu.FormShow(Sender: TObject);
begin
  DisableForm;
  try
    try
      Prefs := TPrefCollection.Create;
      PageConfig := TPageCollection.Create;
      qryEmployeeCopyTo.Open;

      lstEmployees.Clear;
      qryEmployeeCopyTo.First;
      while not qryEmployeeCopyTo.eof do begin
        if qryEmployeeCopyTo.FieldByName('EmployeeID').AsInteger <> AppEnv.Employee.EmployeeID then
          lstEmployees.Items.AddObject(qryEmployeeCopyTo.FieldByName('EmployeeName').AsString, TObject(qryEmployeeCopyTo.FieldByName('EmployeeID').AsInteger));
        qryEmployeeCopyTo.Next;
      end;


      AddMainImages;
      lvAvailableButtons.SmallImages := ImageListAll;
      lvSelectedButtons.SmallImages := ImageListAll;

      if not LoadPreferences then
        GetDefaultPreferences;

      cbCategories.ItemIndex := cbCategories.Items.IndexOf(MENU_CATEGORY_ALL);
      if LockedPage <> '' then begin
        UpdateAvailableButtonsView;
        cbPages.Clear;
        cbPages.Sorted := true;
        cbPages.Items.Add(LockedPage);
        cbPages.ItemIndex := 0;
        cbPagesSelect(cbPages);
      end else begin
        DisplayAvailSelectedButtons;
      end;

      qryLoads.SQL.Text := 'select PageName from tblPageLayout where UserId=' + IntToStr(AppEnv.Employee.EmployeeID) +
                           ' and IndustryId=' + IntToStr(AppEnv.CompanyInfo.IndustryId) +
                           ' group by PageName order by PageName';
      qryLoads.Open;
      if qryLoads.RecordCount = 0 then
        LoadLayoutHistory('')
      else
        LoadLayoutHistory(qryLoads.FieldByName('PageName').AsString);
      (*
      if qryLoads.RecordCount > 0 then
        qryLayouts.SQL.Text := 'SELECT Id, PageName, if(msTimeStamp=0, "1900-01-01 00:00:00", msTimeStamp) as msTimeStamp, Active from tblPageLayout where UserId=' + IntToStr(AppEnv.Employee.EmployeeID) +
          ' and PageName = "' + qryLoads.FieldByName('PageName').AsString + '"'
      else
        qryLayouts.SQL.Text := 'SELECT Id, PageName, msTimeStamp, Active from tblPageLayout where UserId=' + IntToStr(AppEnv.Employee.EmployeeID) +
          ' and PageName = "___ZZZ___"';  // should return empty data set
      qryLayouts.SQL.Add('Group by ID Order by msTimeStamp desc');
      qryLayouts.Open;
      qryLayouts.FieldByName('msTimeStamp').ReadOnly := true;
      grdLayouts.ColumnByName('msTimeStamp').ReadOnly := true;
      *)
      inherited;
      PageControl1.ActivePage := TTabSheet(TabSheet1);

      if TitleLabel.Caption = 'Customise Toolbar' then begin
        MaxSelect := 13;
      end else if not Devmode then begin
        MaxSelect := 24;
      end else begin
        MaxSelect := 36;
      end;
      MainSwitchHeightOptions;
      RealignTabControl(PageControl1, 1);
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
    end;
  finally
    EnableForm;
  end;
end;
procedure TfrmCustomiseMenu.MainSwitchHeightOptions;
var
  btnDecrease, btnincrease, btndefault :  TERPMainSwitchButton;
begin
    tabMainswitch.tabvisible := LockedPage = '';
    if not tabMainswitch.tabvisible then exit;

    btnDecrease := TERPMainSwitchButton.create(Self);  With btnDecrease    do begin  Name := MakeName(Self,'btnDecrease') ; Parent := pnlMainswitch;width := 100;Height := 100;Left := btnleft(3, 75 ,1, pnlMainswitch);Top := 125;DnmAction := dtmMainGUI.actMainswitchHeightdecrease ;onclick := dtmMainGUI.actMainswitchHeightdecreaseExecute; Enabled := True;Anchors :=[]; end;
    btnDefault := TERPMainSwitchButton.create(Self);  With btnDefault    do begin  Name := MakeName(Self,'btnDefault') ; Parent := pnlMainswitch;width := 100;Height := 100;Left := btnleft(3, 75 ,2, pnlMainswitch);Top := 125;DnmAction := dtmMainGUI.actMainswitchHeightDefault  ;onclick := dtmMainGUI.actMainswitchHeightDefaultExecute; Enabled := True;Anchors :=[]; end;
    btnincrease:= TERPMainSwitchButton.create(Self);  With btnincrease   do begin  Name := MakeName(Self,'btnincrease'); Parent := pnlMainswitch;width := 100;Height := 100;Left := btnleft(3, 75 ,3, pnlMainswitch);Top := 125;DnmAction := dtmMainGUI.actMainswitchHeightIncrease ;onclick := dtmMainGUI.actMainswitchHeightIncreaseExecute; Enabled := True;Anchors :=[]; end;

    lblDecrease.left := btnDecrease.left  ;lblDecrease.Width := btnDecrease.width ; lblDecrease.top := btnDecrease.top  + btnDecrease.height + 2;Showcontrolhint(btnDecrease , lblDecrease.Caption);
    lblIncrease.left:= btnIncrease.left ;lblIncrease.Width:= btnIncrease.width; lblIncrease.top:= btnIncrease.top + btnIncrease.height+ 2;Showcontrolhint(btnIncrease, lblIncrease.Caption);
    lblDefault.left := btnDefault.left  ;lblDefault.Width := btnDefault.width ; lblDefault.top := btnDefault.top  + btnDefault.height + 2;Showcontrolhint(btnDefault , lblDefault.Caption);
end;

procedure TfrmCustomiseMenu.FormActivate(Sender: TObject);
begin
  inherited;
  cbCategories.ItemIndex := cbCategories.Items.IndexOf(MENU_CATEGORY_ALL);
end;

procedure TfrmCustomiseMenu.FormCreate(Sender: TObject);
begin
  inherited;
  ModList := TObjectList.Create;
  ChangedPageList := TStringList.Create;
  ChangedPageList.CaseSensitive := false;
  ChangedPageList.Sorted := true;
//  ChangedPageList.Duplicates := dupIgnore;
  PanelWidth := 786;
  PanelHeight := 630;
end;

procedure TfrmCustomiseMenu.AddMainImages;
begin
  ImageListAll.AddImages(dtmMainGUI.ImageList);
 // ImageListAll.AddImages(dtmMainGUI.ImageListSmlIcons);
end;

procedure TfrmCustomiseMenu.RemoveDuplicateItems;
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

procedure TfrmCustomiseMenu.FormPaint(Sender: TObject);
begin
  inherited;
  InvalidateComponents(Self,True);
end;
function TfrmCustomiseMenu.lvAvailableButtonsNewItem: TListItem;
begin
  Result := lvAvailableButtons.Items.Add;
end;
function TfrmCustomiseMenu.lvSelectedButtonsNewItem: TListItem;
begin
  Result := lvSelectedButtons.Items.Add;
end;


procedure TfrmCustomiseMenu.mnuDeleteClick(Sender: TObject);
begin
  inherited;
  DeleteLayout;
end;
initialization
  RegisterClassOnce(TfrmCustomiseMenu);
end.
