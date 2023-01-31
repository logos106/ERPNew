unit BaseGUIDatamodule;

{

 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 29/11/05  1.00.01 DSP  Added AssignActionBitmap procedure.
 21/12/05  1.00.02 BJ   When the profit and loss report is called from Budget section
                        of the main menu, the report shoudl have a budget selected by default
                        Setting Appcontext variable when called from here and the form
                        checks for it in 'onshow'
}

interface

uses
  SysUtils, Classes, ImgList, Controls, ActionsObj, Forms,
  frmReportSelectorFrm,ActnList, Menus;

type
  TdtmGUIClass = class of TdtmGUI;

  TdtmGUI = class(TDataModule)
    procedure AnyActionExecute(Sender: TObject);
    procedure AnyERPDocActionExecute(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FActionHelper: TActionHelper;
    fMainImageList: TImageList;
    //fbLoadImagefromAppMainImageList :Boolean;
    function Actionslist :TActionList;
    procedure ApplyPreferenceNames;

  protected

    fbREgisterEvents:Boolean;
    fbRegister4ReportSelector : Boolean;

    procedure AssignActionBitmap(const Sender: TObject; const Form: TForm);
    function MainImageList: TImageList;
    function DoReportShow(const ReportName, Groupname: string): TfrmReportSelectorGUI;
    procedure AddReports(const Sender: TObject);
    procedure DoAddReports(const ReportSelector: TfrmReportSelectorGUI);virtual;
    procedure GeneralHandler(const Sender: TObject; const Event: string; const Data: Pointer);Virtual;
    Procedure initDM;virtual;
  public
    LcList                : TList;
    menuEventList : TList;
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure AssociateClassNamesWithActions(aActionList: TActionList); virtual; // override in descendants
    //    procedure DisableActionsByEmployee(ActionList: TActionList);
    procedure PopulateActionHelper(ActionList: TActionList);
    property ActionHelper: TActionHelper read FActionHelper write FActionHelper;
    procedure ShowGUI(const Sender: TObject; const AClassName: string; const SingleInstance: boolean);
    function GetAction(const ItemName: string): TAction;
    //Property LoadImagefromAppMainImageList :Boolean  Read fbLoadImagefromAppMainImageList Write fbLoadImagefromAppMainImageList;
//    function Translation(Value:String):String;Overload;
    (*Procedure doTransLate;*)
    Function ImageList: TImageList;
    Function ImageListSmlIcons: TImageList;
    Procedure AssignImageList;Virtual;
  end;

var
  dtmGUI: TdtmGUI;

implementation

{$R *.dfm}
{$M+}        {don't delete!}

uses FastFuncs, CommonLib, Graphics, AppContextObj, BaseFormForm, GlobalEventsObj, dialogs,
  AppEnvironment, LanguageTransLationObj, WorkflowObj, ImagesDatamodule, DNMAction,
  MenuEvents, DocReaderObj , TypInfo, tcTypes;


procedure TdtmGUI.GeneralHandler(const Sender: TObject; const Event: string;const Data: Pointer);
var
  SenderName: string;
begin
    SenderName := '';
    if Sender is TComponent then SenderName  := TComponent(Sender).Name;

    if (Event = GEVENT_AfterCreate) and (SenderName = 'frmReportSelectorGUI') then begin
        AddReports(Sender);
        Exit;
    end;

end;

function TdtmGUI.GetAction(const ItemName: string): TAction;
var
    comp :TComponent;
begin
    Result  := nil;
    comp    := Self.FindComponent(ItemName) ;
    if not (Assigned(comp)) then Exit;
    if comp is TAction Then
        REsult := TAction(comp);
end;
function TdtmGUI.ImageList: TImageList;
begin
  REsult := ImgDatamodule.ImageList;
end;

function TdtmGUI.ImageListSmlIcons: TImageList;
begin
  REsult := ImgDatamodule.ImageListSmlIcons;
end;

procedure TdtmGUI.initDM;
begin
  fbREgisterEvents:= true;
  fbRegister4ReportSelector := true;

end;

procedure TdtmGUI.ShowGUI(const Sender: TObject; const AClassName: string; const SingleInstance: boolean);
var
  comp: TComponent;
  Cls: TPersistentClass;
begin

  if (SameText(AClassName, 'TPurchaseGUI')) and (not EmployeeHasAccess('FnCreatePurchaseOrder')) then
  begin
    CommonLib.MessageDlgXP_Vista('You Do Not Have Rights To Create New Purchase Orders', mtWarning, [mbOK], 0);
    Exit;
  end;

  Cls := GetClass(AClassName);

  if Cls <> nil then begin
    comp := GetComponentByClassName(AClassName, SingleInstance);

    if comp is TForm then // handle the form
    begin
      with comp as TForm do begin

        if Assigned(GetPropInfo(comp,'CallingActionName')) then
            SetPropValue(comp, 'CallingActionName', tAction(Sender).name);
        if Assigned(GetPropInfo(comp,'CallingAction')) then
            SetObjectProp(comp, 'CallingAction', Sender);

        AssignActionBitmap(Sender, TForm(comp));
        if uppercase(tAction(Sender).name)  = uppercase('actBudgetProfitAndLossReport') then
            AppContext['ProfitAndLoss'].VarByname['Budget'] := 'T';
        if uppercase(tAction(Sender).name)  = uppercase('actBudgetAccountList') then
            AppContext['AccountList'].VarByname['Budget'] := 'T';
        // register window in main menu
        try
        if TForm(Comp).visible then begin
          if (TForm(Comp).Parent =nil) then TForm(Comp).BringTofront;
        end else begin
          //WindowState := wsNormal;
          WindowState:= TForm(Comp).WindowState;
          FormStyle := fsMDIChild;
        end;
        except
          //For Abtract Error When Form is Close In Show Event
        end;
        If CommonLib.FormStillOpen(AClassName, TForm(comp)) then BringToFront;
      end;
    end;
    // here any other type of components
  end;
end;


{ TdtmGUI }

function TdtmGUI.Actionslist: TActionList;
var
  ctr:Integer;
  comp:Tcomponent;
begin
  Result := nil;
  comp := FindComponent('ActionList');
  if Assigned(comp) and (comp is TActionlist) then begin
    Result := TActionList(Comp);
    Exit;
  end;

  for ctr := 0 to componentcount-1 do begin
    if components[ctr] is TActionlist then begin
      REsult := TActionlist(components[ctr]);
      Exit;
    end;
  end;
end;

procedure TdtmGUI.AddReports(const Sender: TObject);
var
  ReportSelector:TfrmReportSelectorGUI;
begin
  if Sender is TfrmReportSelectorGUI then ReportSelector := TfrmReportSelectorGUI(Sender)
  else ReportSelector:= TfrmReportSelectorGUI(FindExistingComponent('TfrmReportSelectorGUI',0));
  if Assigned(ReportSelector) then
    try
      DoAddReports(ReportSelector);
    Except
      // kill Exception
    end;

end;

procedure TdtmGUI.DoAddReports(const ReportSelector: TfrmReportSelectorGUI);
begin

end;

procedure TdtmGUI.AnyActionExecute(Sender: TObject);
var
  AClassName: string;
begin
ProcessingCursor;
try
  GlobalEvents.Notify(Self, GEVENT_AnyActionExecuting);
  try
    AClassName := ActionHelper.ActionNameToClassName(TAction(Sender).Name);
    if (AClassName <> '') then begin
      Application.ProcessMessages;
      if (AClassName = 'TfrmDeductions') and (Appenv.RegionalOptions.RegionType = rUSA) then
        ShowGUI(Sender, 'TfrmDeductionsUSA', true)
      else
        ShowGUI(Sender, AClassName, true);
    end;
  finally
    GlobalEvents.Notify(Self, GEVENT_AnyActionExecuted);
  end;
finally
  ProcessingCursor(False);
end;
end;

procedure TdtmGUI.AnyERPDocActionExecute(Sender: TObject);
var
  AClassName:String;
begin
  AClassName := ActionHelper.ActionNameToClassName(TAction(Sender).Name);
  if AClassName <> '' then
    TDocReaderObj.ShowERPHelp(nil, Self, true, AClassNAme);
end;

destructor TdtmGUI.Destroy;
var
  idx : integer;
  lc : pLc;
begin
  FreeMenuEventList(MenuEventList);
  FreeandNil(MenuEventList);
  FreeAndNil(fActionHelper);
//  FreeLcList;
//  if assigned(lcList) and (TLanguageTranslationObj.SafeInst <> nil) then
//    TLanguageTranslationObj.Inst.FreeLcList(Self);
  if Assigned(lcList) and (lcList.Count > 0) then
  begin
    for idx := 0 to lcList.Count - 1 do
    begin
      lc := pLc(LcList[idx]);
      if not assigned(lc) then
        Continue;
      LcList[idx] := nil;
      lc.LCName := '';
      lc.LCType := '';
      lc.LChint := '';
      lc.LCCaption := '';
      lc.LcfontName := '';
//      Dispose(pLc(LcList[idx]));
      Dispose(lc);
    end;
    lcList.Clear;
  end;

  try
    FreeAndNil(lcList);
    inherited;
  except

  end;
end;

procedure TdtmGUI.DataModuleCreate(Sender: TObject);
var
  fActionsList:TActionList;
begin
  FActionHelper := TActionHelper.Create;

  WorkflowActions.CaptureMenuEvents(Self);
  fActionsList := ActionsList;

  if Assigned(fActionsList) then begin
    PopulateActionHelper(fActionsList);
    AssociateClassNamesWithActions(fActionsList);
  end;
  initDM;
  if fbREgisterEvents then
    GlobalEvents.DeregisterHandlers(self);
  if fbRegister4ReportSelector then
    GlobalEvents.RegisterNameHandler(Self, 'TfrmReportSelectorGUI', '', GEVENT_AfterCreate, GeneralHandler);
end;
procedure TdtmGUI.PopulateActionHelper(ActionList: TActionList);
var
  I: integer;
  AI: TActionHelperItem;
  Action: TAction;
begin
  if ActionList.ActionCount > 0 then
    for I := 0 to ActionList.ActionCount - 1 do
    begin
      Action := TAction(ActionList.Actions[I]);
      AI := ActionHelper.Add;
      AI.Action := Action;
      AI.ActionName := Action.Name;
      //      AI.Active := True;
    end;
end;

procedure TdtmGUI.AssignActionBitmap(const Sender: TObject; const Form: TForm);
//var
//  Bitmap: TBitmap;
begin
(*  if (Sender is TAction) and (Form is TBaseForm) then begin
    Bitmap := TBitmap.Create;

    try
      if TAction(Sender).ImageIndex >= 0 then begin
        TAction(Sender).ActionList.Images.GetBitmap(TAction(Sender).ImageIndex, Bitmap);
        TBaseForm(Form).ActionBitmap.Assign(Bitmap);
      end;
    finally
      FreeandNil(Bitmap);
    end;
  end;*)
end;

procedure TdtmGUI.AssignImageList;
var
  x:Integer;
begin
//    ActionList.Images := ImageList;
    for x := 0 to ComponentCount-1 do
        if Components[x] is TActionlist then
            TActionList(Components[x]).Images := ImageList;

end;

procedure TdtmGUI.AssociateClassNamesWithActions(aActionList: TActionList);
var
  i: integer;
  Action: TDNMAction;
begin
  for i := 0 to aActionList.Actioncount - 1 do begin
    Action := TDNMAction(aActionList.Actions[i]);
    ActionHelper.AssociateActionWithClassName(Action.Name, Action.ClassExecute, Action.Description);
  end;

end;

constructor TdtmGUI.Create(AOwner: TComponent);
begin
  MenuEventList:= TList.Create;
  inherited;
  ApplyPreferenceNames;
end;
Procedure TdtmGUI.ApplyPreferenceNames;
var
  index:Integer;
begin
  try
      for index := 0 to ComponentCount-1 do begin
        if components[index] is TDnmAction then begin
            if AppEnv.DefaultClass.EquipmentName <> '' then
                if pos('Equipment' , TDnmAction(components[index] ).caption)> 0 then TDnmAction(components[index] ).caption:= replaceStr(TDnmAction(components[index] ).caption , 'Equipment' , AppEnv.DefaultClass.equipmentName);
            if AppEnv.DefaultClass.HireName <> '' then
                if pos('Hire' , TDnmAction(components[index] ).caption)> 0 then TDnmAction(components[index] ).caption:= replaceStr(TDnmAction(components[index] ).caption , 'Hire' , AppEnv.DefaultClass.HireName);
        end;
      end;
  Except

  end;
end;
function TdtmGUI.MainImageList: TImageList;
var
  x, y: integer;
begin
  { find the applications main datamodule (owned by application) and get its image list }

  if not Assigned(fMAinImageList) then begin
    for x:= 0 to Application.ComponentCount -1 do begin
      if Application.Components[x].Name = 'dtmMainGUI' then begin
        for y:= 0 to Application.Components[x].ComponentCount-1 do begin
          if Application.Components[x].Components[y].Name = 'ImageListNew' then begin
            fMainImageList:= TImageList(Application.Components[x].Components[y]);
            break;
          end;
        end;
        break;
      end;
    end;
  end;
  result:= fMainImageList;
end;

function TdtmGUI.DoReportShow(const ReportName, Groupname: string): TfrmReportSelectorGUI;
var
  frmReportSelectorGUI:TfrmReportSelectorGUI;
begin
  Result := Nil;
  if FormStillOpen('TfrmReportSelectorGUI') then TForm(FindExistingComponent('TfrmReportSelectorGUI')).Close;
  Application.ProcessMessages;
  frmReportSelectorGUI := TfrmReportSelectorGUI(GetComponentByClassName('TfrmReportSelectorGUI', true));
  if Assigned(frmReportSelectorGUI) then begin //if has acess
    GlobalEvents.Notify(frmReportSelectorGUI, GEVENT_AfterCreate);
    Result := frmReportSelectorGUI;
    with frmReportSelectorGUI do begin
      defaultGroup  := GroupName;
      defaultReport := ReportName;
      FormStyle     := fsMDIChild;
      BringToFront;
    end;
  end;
end;


(*procedure TdtmGUI.doTransLate;
begin
  appenv.LanguageTranslationObj.DoTranslate(Self, appenv.LanguageTranslationObj.UseRegionalLanguage);
end;*)

//function TdtmGUI.Translation(Value: String): String;
//begin
//  result := TLanguageTranslationObj.Inst.Translation(Value, appenv.RegionalOptions.LanguageId);
//end;

end.





