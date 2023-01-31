unit WorkflowObj;

interface
{$I ERP.inc}

uses
  BusObjBase, EMHelper,Windows, SysUtils, ExcMagic, Classes, IdMessage, IdSMTP, IdException, ExtCtrls, ERPDbLookupCombo, WwDBGrid  , BusobjWorkflow, controls , frmWorkflowEdit, Menus, Graphics,
  MenuEvents;

type


  TWorkflowStatus = (wfsRecording = 1, wfsPlaying=2, wfsNone =3);

  TWorkflowAction = class(TUserActionBase)
  private
    fbctrlDown  : Boolean;
    fbShiftDown : Boolean;
    fbAltDown   : Boolean;
    fbCapsLockOn: Boolean;
    fbNumLockOn : Boolean;
    fbKeyDown   : Boolean;
    PreviousFocusedForm: string;
    PreviousmenuName: string;
    PreviousFocusedControl: string;
    PreviousEventName :String;
    PreviousGridfieldName :String;
    EventName   : String;
    GridfieldName :String;
    fCheckWorkflowFiler :TTimer;
    fWorkflow :TWorkFlow;
    GridComboname:String;
    fWorkflowEditForm : TfmWorkflowEdit;
    fbNewworkflowcreated:Boolean;
    Procedure OnEvent(const UserEventType: TUserEventType; const wParam: Longint; const lParam: Longint; out SpecialKeyPressed :Boolean );
    function IsButtonSelected:Boolean;
    function IsAdvGlowButtonSelected:Boolean;
    Function ControlParent(control :TControl):string;
    Procedure CheckWorkflowwithDelay;
    Procedure CheckWorkflow(Sender :TObject);
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);
    procedure ShowWorkflowEdit;
    Function WorkflowEditForm :TfmWorkflowEdit;
    Function ERPformEventname(const thiseventname :String):String;
    procedure beforeshowWorkflowform(Sender: TObject);
    procedure OnNewWorkflowcreated(Sender: TObject);
    procedure OnMenuPopup(Sender: TObject);
    procedure OnMenuClick(Sender: TObject);
    //procedure OnActionExecute(Sender: TObject);
    function GetmenuEventRec(Comp:TComponent; var MenuEventRec: TMenuEventRec; Const Name: string; MenuEventType: TMenuEventType; const RemoveFromList: boolean = false): Boolean;
    function MenuEventList(Comp: TComponent): TList;
    procedure AddMenuWorkflowEntry(Sender: TObject);
    //function MenuEventTypetostr(MenuEventType: TMenuEventType): String;
    procedure MainformTimerMsg(const Value: String; Secondstoshow: Integer=5; msgColor:TColor = clred);
  Protected
    procedure GetActiveNames;Overload;Override;
    procedure GetActiveNames(Const menuName:String);Overload;
  Public
    constructor Create;Override;
    Destructor Destroy;Override;
    procedure AddWorkflowAction(const UserEventType: TUserEventType; const wParam: Longint; const lParam: Longint; SpecialKeyPressed :Boolean =False;Menuname:String ='';MenuClassname:String ='');
    function Workflow :TWorkFlow;
    Procedure initWorkflow;
    Procedure Stoprecording;
    Procedure Cancelrecording;
    function StartRecording:Boolean ;
    procedure CaptureMenuEvents(Comp: TComponent);
  end;

  var
    WorkflowActions : TWorkflowAction;
    WorkflowStatus  : TWorkflowStatus;
    MainFormMenu :TMainMenu;

  const
    LEFTMOUSEBTNCLICKED = 'Left mouse button';
    RIGHTMOUSEBTNCLICKED= 'Right mouse button';
    ONMOUSEMOVE         = 'Mouse Move';
    ONENTER             = 'ENTER';
    ONTAB               = 'TAB';

  Function Startrecording:Boolean;
  procedure Stoprecording;
  procedure Cancelrecording;
  Procedure ImportWorkFlows;

  function IsWorkFlowRecoding:Boolean;
  function IsWorkFlowPlaying:Boolean;


implementation

uses AdvGlowButton,Dialogs, ProgressDialog, ERPdbComponents, DNMAction, DNMSpeedButton  ,Messages , CommonLib , AppEnvironment, MAIN, TypInfo, dmMainGUI ,
      commonGuiLib, variants , BusObjConst, forms, BaseFormForm, db, CommonFormLib, frmWorkflow, tcConst,BaseListingForm, AdvMenus, frmBase, BaseGUIDatamodule, ActnList, LogLib,sndkey32,
  BaseInputForm, DbSharedObjectsObj, CommonDbLib, dbplanner;

constructor TWorkflowAction.Create;
begin
  inherited;
  fWorkflowEditForm := nil;
  EventName:= '';
  fbctrlDown  := False;
  fbShiftDown := False;
  fbAltDown   := False;
  fbCapsLockOn:= False;
  fbNumLockOn := False;
  fbKeyDown   := False;
  PreviousFocusedForm:= '';
  PreviousmenuName:= '';
  PreviousFocusedControl:= '';
  PreviousEventName := '';
  PreviousGridfieldName := '';
  GridfieldName := '';
  GridComboname := '';
  fCheckWorkflowFiler :=TTimer.Create(nil);
  fCheckWorkflowFiler.Enabled := False;
  fCheckWorkflowFiler.OnTimer :=  CheckWorkflow;
  fCheckWorkflowFiler.Interval := 1000;
  fWorkflow := nil;
end;


destructor TWorkflowAction.Destroy;
begin
  Freeandnil(fCheckWorkflowFiler);
  Freeandnil(fWorkflow);
  inherited;
end;

procedure TWorkflowAction.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  if (Eventtype = BusObjEvent_Dataset) and (Sender.IsdataIdchangeEvent(Value)) and (Sender is TWorkFlowLines) then begin
    ShowWorkflowEdit;
  end;
  WorkflowEditForm.DoBusinessObjectEvent(Sender,EventType, Value);
end;
function TWorkflowAction.ERPformEventname(const thiseventname: String): String;
var
  s:String;
begin
  result := '';
  try
    if  (sametext(thiseventname , LEFTMOUSEBTNCLICKED) or sametext(thiseventname , RIGHTMOUSEBTNCLICKED) or sametext(thiseventname , ONENTER)) then
      Try if Activeform is TBaseForm then result := TBaseForm(Activeform).CleanformCaption;                                 Except end;
      Try if (result='') and (ActiveForm is TForm) then result := TForm(ActiveForm).Caption;                                Except end;
      //Try if Activecontrol is TDNMSpeedbutton then Result :=result + TDNMSpeedbutton(Activecontrol).Caption;                Except end;
      s:= '';
      Try s := s +GetObjectProperty(Activecontrol , 'datafield');                                                 Except end;
      Try s := s +GetObjectProperty(Activecontrol , 'Caption');                                                   Except end;
      Try if Activecontrol is TwwDBGrid then s := s + TField(TwwDBGrid(Activecontrol).GetActiveField).Fieldname;  Except end;
      Try if Activecontrol is TDBPlanner then s := s + TDBPlanner(Activecontrol).name;  Except end;
      if s= '' then Try s := s +GetObjectProperty(Activecontrol , 'text');                                        Except end;
      if s<> '' then
        if result <> '' then
          result := result +'.' + s
        else result := s;
  finally
    if result = '' then
      result :=  thiseventname;
  end;

end;

Procedure TWorkflowAction.ShowWorkflowEdit;
begin
  //WorkflowEditForm.BringToFront;
end;
Procedure TWorkflowAction.OnNewWorkflowcreated(Sender:TObject);
begin
   if not (sender is  TfmWorkflow) then exit;
  if TfmWorkflow(Sender).workflowID <> 0 then begin
    Workflow.load(TfmWorkflow(Sender).workflowID );
    fbNewworkflowcreated := Workflow.count >0;
  end;
  (*s:=CustomInputString('WorkFlow' ,'Description' ,   formatDateTime(FormatSettings.ShortDateFormat +' hh:nn:ss' , now));
  if s= '' then exit;
  initWorkflow;
  Workflow.Load(0);
  Workflow.Connection.BeginTransaction;
  Workflow.New;
  Workflow.Active := true;
  Workflow.Description := s;
  Workflow.CreatedBy := Appenv.Employee.EmployeeID;
  Workflow.PostDB;*)

end;
Procedure TWorkflowAction.beforeshowWorkflowform(Sender:TObject);
begin
  if not (sender is  TfmWorkflow) then exit;
  TfmWorkflow(Sender).TransConnection := TERPConnection(Workflow.Connection.Connection);
  TfmWorkflow(Sender).ShowHeaderonly := true;
end;
function  TWorkflowAction.StartRecording:Boolean ;
begin
  fbNewworkflowcreated := False;
  try
    initWorkflow;
    Workflow.Connection.BeginTransaction;
    OpenERPFormModal('TfmWorkflow' , 0 , beforeshowWorkflowform , true, OnNewWorkflowcreated);
    Result := fbNewworkflowcreated;
  finally
    fbNewworkflowcreated := False;
  end;
end;

procedure TWorkflowAction.Stoprecording;
begin
  Workflow.Connection.CommitTransaction;
  WorkflowEditform.pnlDetails.visible := False;
  FreeandNil(fWorkflowEditform);
  FreeandNil(fWorkflow);
end;
procedure TWorkflowAction.cancelrecording;
begin
  Workflow.Connection.RollbackTransaction;
  WorkflowEditform.pnlDetails.visible := False;
  FreeandNil(fWorkflowEditform);
  FreeandNil(fWorkflow);
end;
procedure TWorkflowAction.GetActiveNames(Const menuName:String);
var
  comp :TComponent;
begin
  GetActiveNames;
  if menuname <> '' then
    if Assigned(Screen.ActiveForm) then begin
      comp:= Screen.ActiveForm.FindComponent(MenuName);
      if comp <> nil then begin
        if (Comp is TPopupMenu)    then begin
        end else if (Comp is TAdvPopupMenu) then begin
        end else if (Comp is TMenuItem)     then begin
            ActivecontrolPropnvalue := '.Caption = ' +Quotedstr(TMenuItem(comp).Caption);
            ActivecontrolValue :=TMenuItem(comp).Caption;
            ActivecontrolProp := 'Caption';
        end;
      end;
  end;
end;

procedure TWorkflowAction.GetActiveNames;
begin
  inherited;
  GridfieldName  :='';
  GridComboname:= '';
  if (ActiveControl<> nil) and (ActiveControl is TwwDBGrid) then GridfieldName  :=TwwDBGrid(Activecontrol).GetActiveField.FieldName;
end;

procedure TWorkflowAction.initWorkflow;
begin
  Freeandnil(fWorkflow);
  Workflow;
end;

function TWorkflowAction.IsButtonSelected: Boolean;
begin
  REsult:= False;
  if Activecontrol = nil then exit;
  result := (ActiveControl is TDNMSpeedButton);
end;
function TWorkflowAction.IsAdvGlowButtonSelected: Boolean;
begin
  REsult:= False;
  if Activecontrol = nil then exit;
  result := (ActiveControl is TAdvGlowButton);
end;

procedure TWorkflowAction.OnEvent(const UserEventType: TUserEventType; const wParam, lParam: Integer; out SpecialKeyPressed :Boolean );
var
  s:String;
  Procedure AddEventDetails(Const Value:String); begin if value <> '' then begin if s<> '' then s:= s+',' ; s:= s + value;end;end;
begin
  s:= '';
  try
    case UserEventType of
      uetMouse:
               if ((wParam = WM_LBUTTONDOWN) or (wParam = WM_LBUTTONUP)) and (IsButtonSelected) then  AddEventDetails(LEFTMOUSEBTNCLICKED)
          else if (wParam = WM_RBUTTONDOWN) or (wParam = WM_RBUTTONUP) then  AddEventDetails(RIGHTMOUSEBTNCLICKED)
          else if (wparam = WM_MOVE) (*or (wparam = WM_NCMOUSEMOVE) or (wparam = WM_MOUSEMOVE)*) then AddEventDetails(ONMOUSEMOVE)
          else if ((wParam = WM_LBUTTONDOWN) or (wParam = WM_LBUTTONUP)) and (IsAdvGlowButtonSelected) then  AddEventDetails(LEFTMOUSEBTNCLICKED);

      uetKeyboard:
      begin
        if not (wParam in [VK_CONTROL, VK_SHIFT, VK_MENU(*, VK_CAPITAL, VK_NUMLOCK*)]) and (SpecialKeyPressed=False) then begin
          if not(fbctrlDown   ) and ((GetKeyState(VK_CONTROL)   and $80)      <> 0) then begin fbctrlDown   := True; AddEventDetails('CTRL+' + chr(wParam));(*SpecialKeyPressed:= True;*) end;
          if not(fbShiftDown  ) and ((GetKeyState(VK_SHIFT)     and $80)      <> 0) then begin fbShiftDown  := True; AddEventDetails('SHIF+' + chr(wParam));(*SpecialKeyPressed:= True;*) end;
          if not(fbAltDown    ) and ((GetKeyState(VK_MENU)      and $80)      <> 0) then begin fbAltDown    := True; AddEventDetails('ALT+'  + chr(wParam));(*SpecialKeyPressed:= True;*) end;
        end;
        if wParam in  [VK_F1..VK_F24] then AddEventDetails('F' + SysUtils.IntToStr(wParam - VK_F1 + 1));

        if (wParam = VK_RETURN) and (IsButtonSelected)  then AddEventDetails(ONENTER);
        if (wParam = VK_TAB)    and (IsButtonSelected)  then AddEventDetails(ONTAB);

        if (wParam = VK_RETURN) and (IsAdvGlowButtonSelected)  then AddEventDetails(ONENTER);
        if (wParam = VK_TAB)    and (IsAdvGlowButtonSelected)  then AddEventDetails(ONTAB);
      end;
    end;
  finally
    if s<> '' then EventName := s;
  end;
end;
function TWorkflowAction.Workflow: TWorkFlow;
begin
  if fWorkflow = nil then begin
    fWorkflow := TWorkFlow.CreateWithNewConn(nil);
    fWorkflow.BusObjEvent := DoBusinessObjectEvent;
    //fWorkflow.Load(0);
    WorkflowEditForm;
  end;
  result :=fWorkflow;
end;

function TWorkflowAction.WorkflowEditForm: TfmWorkflowEdit;
begin
  if fWorkflowEditform = nil then begin
    fWorkflowEditform := TfmWorkflowEdit(GetComponentByClassName('TfmWorkflowEdit' , True , nil, false));
    fWorkflowEditform.WorkFlow  := Self.workflow;
(*    fWorkflowEditform.FormStyle := fsmdiChild;
    fWorkflowEditform.Top := 0;
    fWorkflowEditform.Left := (mainform.width - fWorkflowEditform.Width )-15;
    fWorkflowEditform.Parent := mainform;
    fWorkflowEditform.Anchors := [akTop,akRight];*)
    fWorkflowEditform.Show;
    fWorkflowEditform.(*pnlDetails.*)Parent := mainform;
    fWorkflowEditform.(*pnlDetails.*)Anchors := [akTop,akRight];
    fWorkflowEditform.(*pnlDetails.*)Visible := False;
  end;
  Result := fWorkflowEditform;
end;

procedure TWorkflowAction.AddWorkflowAction(const UserEventType: TUserEventType; const wParam: Longint; const lParam: Longint; SpecialKeyPressed :Boolean =False;Menuname:String ='';MenuClassname:String ='');
begin

  try
    if screen.activecontrol.owner.classnameIs(WorkflowEditform.classname) then exit;
  Except
    //ignore the exception if any
  end;
  GetActiveNames(MenuName);


  if Activeform = nil then exit; // when inside MessageDlg
  if screen.activecontrol = nil then exit; // when inside MessageDlg


  if sametext(Activeform.classname , 'TAdvMessageForm') then exit;
  if sametext(Activeform.classname , 'TfmWorkflowEdit') then exit;
  if sametext(Activeform.classname , 'TWorkflowsGUI') then exit;
  if sametext(Activeform.classname , 'TfrmProgress') then exit;
  if sametext(Activeform.classname , 'TfmCalculator') then exit;
  if sametext(Activeform.classname , 'TfmPdtPreview') then exit;
  if sametext(Activeform.classname , 'TfmPdtProgress') then exit;
  if sametext(Activeform.classname , 'TfmPdtMain') then exit;
  if sametext(Activeform.classname , 'TfmFormGuiPrefsEdit') then exit;
  if sametext(Activeform.classname , 'TfrmCustomiseMenu') then exit;
  if sametext(Activeform.classname , 'TppPrintPreview') then exit;
  if sametext(Activeform.classname , 'TppCancelDialog') then exit;
  if sametext(Activeform.classname , 'TCustomInputBox') then exit;
  if sametext(Activeform.classname , 'TMainSwitch2') and sametext(ActiveControlName , 'None') then exit;
  if fsModal in Activeform.FormState then exit;// its not possible to track workflow in the modal screen
  if (Activeform is TBaseListingGUI) then if TBaseListingGUI(Activeform).ComboDataSelect then exit;
  if (Activeform is TBaseInputGUI)   then if TBaseInputGUI(Activeform).ComboCreateMew    then exit;


  if Assigned(screen.activecontrol) then {skip if it is the start/stop/cancel recording}
    if screen.activecontrol is TDNMSpeedButton then begin
      if Sametext(TDNMSpeedButton(screen.activecontrol).name , 'btnWorkflow') then exit;
      if Assigned(TDNMSpeedButton(screen.activecontrol).action) and (TDNMSpeedButton(screen.activecontrol).action is TDNMAction) then
          if Sametext(TDNMAction(TDNMSpeedButton(screen.activecontrol).action).name , 'actStartRecording') or
             Sametext(TDNMAction(TDNMSpeedButton(screen.activecontrol).action).name , 'actStoprecording') or
             Sametext(TDNMAction(TDNMSpeedButton(screen.activecontrol).action).name , 'actCancelrecording') then exit;
    end;
//  actStartRecording

  if not SpecialKeyPressed then OnEvent(UserEventType,wParam,lParam, SpecialKeyPressed);

  if (EventName = '') or (sametext(Eventname , ONMOUSEMOVE)) then exit;

  if  SysUtils.SameText(ActiveFormName, PreviousFocusedForm)  and
      SysUtils.SameText(Menuname, PreviousmenuName)  and
      SysUtils.SameText(ActiveControlName, PreviousFocusedControl) and
      Sametext(PreviousGridfieldName  , GridfieldName) then exit;

  if screen.activecontrol is TDnmspeedbutton then
    if not(sametext(eventname, LEFTMOUSEBTNCLICKED)) and  not(sametext(eventname, ONENTER))  then exit; // button action should be recorded onluy if its clicked

  if screen.activecontrol is TAdvGlowButton then
    if not(sametext(eventname, LEFTMOUSEBTNCLICKED)) and  not(sametext(eventname, ONENTER))  then exit; // button action should be recorded onluy if its clicked


  if Workflow.Lines.count =0 then
    if not(Sametext(Activeform.classname , 'TMainSwitch2') and (POS('mainmenusidepanelbtn_', Activecontrolname)=1)) then begin
      MainformTimerMsg('Please start recording by selecting one of the module button on the mainmenu on the left side panel');
      Exit;
    end;
  Mainform.hideTimerMsg;
  PreviousFocusedForm    := ActiveFormName;
  PreviousmenuName       := MenuName;
  PreviousFocusedControl := ActiveControlName ;
  PreviousEventName      := EventName;
  PreviousGridfieldName  := GridfieldName;
  FEventList.Add(ControlParent(ActiveControl)+'.' + EventName + GridfieldName);

  {if the entry already exists , ie going back to the same component or field - shouldn't replicate the entry in the workflow}
  if  not(Workflow.Lines.locate('formName;formclassName;ControlName;buttonActionName;ControlParent;fieldname;GridComboname;Menuname;MenuClassname',
      vararrayof([ActiveformName,Activeform.classname,ActiveControlName,ReadActionName(ActiveControl),(*inttostr(ReadIntProp(ActiveControl , 'HelpContext')),*)ControlParent(ActiveControl),Gridfieldname,GridComboname,menuname,menuclassname]), [])) then begin
      Workflow.Lines.New;
      Workflow.Lines.formName         := ActiveformName;
      Workflow.Lines.formclassName    := Activeform.classname;
      Workflow.Lines.ControlName      := ActiveControlName;
      Workflow.Lines.MenuName         := MenuName;
      Workflow.Lines.MenuClassName    := MenuClassName;
      Workflow.Lines.ControlClassName := ActiveControlClassName;
      Workflow.Lines.buttonActionName := ReadActionName(ActiveControl);
      Workflow.Lines.HelpcontextID    := inttostr(ReadIntProp(ActiveControl , 'HelpContext'));
      Workflow.Lines.ControlParent    := ControlParent(ActiveControl);
      Workflow.Lines.fieldname        := Gridfieldname;
      Workflow.Lines.Gridcomboname    := GridComboname;
      Workflow.Lines.AssignedGridDataSelect :=   (Activeform is TBaseListingGUI ) and (Assigned(TBaseListingGUI(Activeform).OnGridDataSelect));
  end;
  Workflow.Lines.value            := ActivecontrolValue;
  Workflow.Lines.Propname         := ActivecontrolProp;
  if  (sametext(EventName , LEFTMOUSEBTNCLICKED) or sametext(EventName , RIGHTMOUSEBTNCLICKED) or sametext(EventName , ONENTER)) and
      (Workflow.Lines.eventname <> '') then  // this is if the entry allready added and descriptin already changed and the same event happens again
  else Workflow.Lines.eventname        := ERPformEventname(EventName);

  Workflow.Lines.PostDB;

  if SpecialKeyPressed then begin
    CheckWorkflowwithDelay;
    SpecialKeyPressed := False;
  end;
end;

procedure TWorkflowAction.CheckWorkflow(Sender: TObject);
begin
  fCheckWorkflowFiler.Enabled := False;
  AddWorkflowAction(uetKeyboard,0,0, true);
end;

procedure TWorkflowAction.CheckWorkflowwithDelay;
begin
  fCheckWorkflowFiler.Enabled := True;
end;

function TWorkflowAction.ControlParent(control :TControl): string;
begin
  result:= '';
  if control = nil then exit;
  if (control is  TERPDbLookupCombo) then begin
    GridComboname := Control.Name;
    control := GridwhenComboinGrid(TERPDbLookupCombo(control));
    ActiveControlName := TERPDbLookupCombo(Control).name;
    ActiveControlClassName := TERPDbLookupCombo(Control).Classname;
    if sametext(GridComboname , control.Name) then GridComboname := ''; // if not in the grid, set to blank
  end;
  if (Control is TwwDBGrid) then begin
          if (GridComboname <> '') and (Gridfieldname <> '') then
     else if Gridfieldname  <> '' then GridComboname  := ComboinGrid(Gridfieldname ,TwwDBGrid(control))
     else if GridComboname  <> '' then  Gridfieldname := ComboinGrid4fieldname(GridComboname ,TwwDBGrid(control));
  end;
  if Assigned(Control.Parent) then result := ControlParent(Control.Parent)+'.'+control.Name else result := control.Name;
  Result := replacestr(result, '..' , '.');
end;


Function Startrecording:Boolean;
begin
  Result := fALSE;
  if (IsWorkFlowRecoding) then exit;
  Result := WorkflowActions.StartRecording;
  if result then WorkflowStatus := wfsrecording;
  MainFormMenu := Mainform.menu;
  Mainform.Menu := nil;
end;
procedure Stoprecording;
begin
  if  (not(IsWorkFlowRecoding)) then exit;
  WorkflowActions.Stoprecording;
  WorkflowStatus := wfsNone;
  if MainFormMenu <> nil then begin
    Mainform.menu := MainFormMenu;
    MainFormMenu := nil;
    SendKeys('{F10}',True);
  end;
end;
procedure Cancelrecording;
begin
  if (not(IsWorkFlowRecoding)) then exit;
  WorkflowActions.Cancelrecording;
  WorkflowStatus := wfsNone;
  if MainFormMenu <> nil then begin
    Mainform.menu := MainFormMenu;
    MainFormMenu := nil;
    SendKeys('{F10}',True);
  end;
end;
Procedure ImportWorkflows;
var
  filename:String;
  files:TStringlist;
  ctr:Integer;
  fileImported:Integer;
  OpenDialog1: TOpenDialog;
  scr :TERPScript;
begin
  fileImported:=0;
  OpenDialog1:= TOpenDialog.create(nil);
  try
    OpenDialog1.DefaultExt  := 'wfs';
    OpenDialog1.Filter      := 'Workflow SQL file (*.wfs)|*.wfs|All Files (*.*)|*.*';
    OpenDialog1.Options     := [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing];
    OpenDialog1.Title       := 'Choose the Workflow File to be Imported';

    if OpenDialog1.Execute = False then exit;
    if Opendialog1.Files.count =0 then exit;
    files := TStringlist.create;
    try
      files.text := Opendialog1.Files.text;
      if MessageDlgXP_Vista('This will Create / Overwrite the workflows in the selected file(s) into the current database. Are you sure you want to Proceed?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
      DoShowProgressbar(files.count , WAITMSG);
      try
        for ctr:= 0 to files.count-1 do begin
          filename := files[ctr];
          if (filename = '') or not(FileExists(filename)) then continue;
          DoStepProgressbar(filename);
          //with SharedScript() do begin
          scr := DbSharedObj.GetScript(CommonDBLib.GetSharedMyDacConnection);
          try
              With scr do begin
                SQL.LoadFromFile(filename);
                if SQL.Count =0 then Continue;
                try
                  Execute;
                  fileImported:= fileImported +1;
                Except
                  on E:Exception do begin
                    if pos('Unknown column ''RegionID'' in ''field list''', E.message )>=0 then begin
                      MessageDlgXP_Vista('Importing workflow from file ' + quotedstr(filename)+' Failed as it was created with a version prior to 14.4.0.0.'+ NL+
                                            'Please update ERP and export it again.'+NL+E.Message, mtWarning, [mbOK], 0);
                    end else begin
                      MessageDlgXP_Vista('Importing workflow from file ' + quotedstr(filename)+' Failed.'+NL+E.Message, mtWarning, [mbOK], 0);
                    end;
                  end;
                end;
              end;
          finally
            DbSharedObj.ReleaseObj(scr);
          end;
        end;
      finally
        DoHideProgressbar;
      end;
      if fileImported >0 then MessageDlgXP_Vista('Workflows are imported from Selected file(s) into the current database.', mtWarning, [mbOK], 0);
    finally
      Freeandnil(files);
    end;
  finally
    Freeandnil(OpenDialog1);
  end;
end;
procedure TWorkflowAction.MainformTimerMsg(const Value: String; Secondstoshow: Integer=5; msgColor:TColor = clred);
begin
  Mainform.TimerMsg(Value ,SecondsToshow, msgColor);
end;

function TWorkflowAction.MenuEventList(Comp:TComponent):TList;
begin
  REsult:= nil;
  if comp = nil then exit;
  if (comp is TfrmBaseGUI) and (Assigned(TfrmBaseGUI(comp).menuEventList)) then begin
    Result :=TfrmBaseGUI(comp).menuEventList;
    Exit;
  end;
  if (comp is TdtmGUI) and (Assigned(TdtmGUI(comp).menuEventList)) then begin
    Result :=TdtmGUI(comp).menuEventList;
    Exit;
  end;
  if Assigned(comp.owner) and (comp.Owner is Tcomponent) then begin
      REsult :=  MenuEventList(Tcomponent(comp.Owner));
      Exit;
  end;
end;
procedure TWorkflowAction.CaptureMenuEvents(Comp:TComponent);
  var
    x: integer;
    MenuER: PMenuEventRec;
    fMenuEventList:TList;
    MenuEventRec: TMenuEventRec;
  begin
    fMenuEventList :=MenuEventList(comp);
    if fMenuEventList = nil then exit;
    for x := 0 to Comp.ComponentCount -1 do begin
      if Comp.Components[x] is TPopupMenu    then begin
        if Assigned(TPopupMenu(Comp.Components[x]).OnPopup) then begin
            System.New(MenuER);
            MenuER^.MenuEventType:= OnMenuPopuptype;
            MenuER^.Name:= TPopupMenu(Comp.Components[x]).Name;
            MenuER^.Data:= TMethod(TPopupMenu(Comp.Components[x]).OnPopup).Data;
            MenuER^.Code:= TMethod(TPopupMenu(Comp.Components[x]).OnPopup).Code;
            fMenuEventList.Add(MenuER);
        end;
        TPopupMenu(Comp.Components[x]).OnPopup:= OnMenuPopup;
      end else if Comp.Components[x] is TMenuItem     then begin

        if Assigned(TMenuItem(Comp.Components[x]).action) and Assigned(TMenuItem(Comp.Components[x]).action.OnExecute) then begin
            System.New(MenuER);
            //MenuER^.MenuEventType:= OnactionExecuteType;
            MenuER^.MenuEventType:= OnMenuClickType;
            MenuER^.Name:= TMenuItem(Comp.Components[x]).action.Name;
            //MenuER^.Name:= TMenuItem(Comp.Components[x]).Name;
            MenuER^.Data:= TMethod(TMenuItem(Comp.Components[x]).action.OnExecute).Data;
            MenuER^.Code:= TMethod(TMenuItem(Comp.Components[x]).action.OnExecute).Code;
            fMenuEventList.Add(MenuER);
            TMenuItem(Comp.Components[x]).action.OnExecute:= OnMenuClick;//OnActionExecute;
            MenuEventRec:= PMenuEventRec(fMenuEventList.Items[fMenuEventList.count-1])^;
        end else if Assigned(TMenuItem(Comp.Components[x]).Onclick) then begin
            System.New(MenuER);
            MenuER^.MenuEventType:= OnMenuClickType;
            MenuER^.Name:= TMenuItem(Comp.Components[x]).Name;
            MenuER^.Data:= TMethod(TMenuItem(Comp.Components[x]).Onclick).Data;
            MenuER^.Code:= TMethod(TMenuItem(Comp.Components[x]).Onclick).Code;
            fMenuEventList.Add(MenuER);
            TMenuItem(Comp.Components[x]).Onclick:= OnMenuClick;
        end else begin
          TMenuItem(Comp.Components[x]).Onclick:= OnMenuClick;
        end;

      end else if Comp.Components[x] is TAdvPopupMenu then begin
        if Assigned(TAdvPopupMenu(Comp.Components[x]).OnPopup) then begin
            System.New(MenuER);
            MenuER^.MenuEventType:= OnMenuPopuptype;
            MenuER^.Name:= TAdvPopupMenu(Comp.Components[x]).Name;
            MenuER^.Data:= TMethod(TAdvPopupMenu(Comp.Components[x]).OnPopup).Data;
            MenuER^.Code:= TMethod(TAdvPopupMenu(Comp.Components[x]).OnPopup).Code;
            fMenuEventList.Add(MenuER);
        end;
        TAdvPopupMenu(Comp.Components[x]).OnPopup:= OnMenuPopup;
      end;
    end;
    for x:=  0 to fMenuEventList.Count-1 do begin
        MenuEventRec:= PMenuEventRec(fMenuEventList.Items[x])^;
        //Logtext(Comp.ClassName+ ' - ' +MenuEventRec.Name + ',' + MenuEventTypetostr(MenuEventRec.MenuEventType));
    end;
end;
(*function TWorkflowAction.MenuEventTypetostr(MenuEventType :TMenuEventType):String;
begin
  if MenuEventType = OnMenuPopuptype then result :='OnMenuPopuptype'
  else if MenuEventType = OnMenuClickType then REsult := 'OnMenuClickType'
  else if MenuEventtype = OnActionExecutetype then REsult := 'OnActionExecuteType'
  else result := '';
end;*)
procedure TWorkflowAction.OnMenuPopup(Sender:TObject);
var
  MenuEventRec: TMenuEventRec;
  NotifyMenuEvent: TNotifyEvent;
  function MenuName:String;
  begin
         if (Sender is TPopupMenu)    then result := TPopupMenu(Sender).Name
    else if (Sender is TAdvPopupMenu) then result := TAdvPopupMenu(Sender).Name;
  end;
begin

  if not (Sender is TPopupMenu) and not (Sender is TAdvPopupMenu) then exit;
  try
    if GetMenuEventRec(TComponent(Sender), MenuEventRec, MenuName, OnMenuPopuptype, false) then
    begin
      TMethod(NotifyMenuEvent).Data:= MenuEventRec.Data;
      TMethod(NotifyMenuEvent).Code:= MenuEventRec.Code;
      NotifyMenuEvent(Sender);
    end;
  Except
    on E:Exception do begin
	  end;
  End;
  AddMenuWorkflowEntry(Sender);
end;
(*procedure TWorkflowAction.OnActionExecute(Sender:TObject);
var
  MenuEventRec: TMenuEventRec;
  NotifyMenuEvent: TNotifyEvent;
  function AcionName:String;
  begin
         Result := '';
              if (Sender is TAction)       then REsult:= TAction(Sender).Name
         else if (Sender is TDnMAction)    then REsult:= TDnMAction(Sender).Name;
  end;
begin
  if not(Sender is TAction) and not(Sender is TDnMAction)  then exit;
  try
    if Self.GetMenuEventRec(TComponent(Sender), MenuEventRec, AcionName, OnActionExecuteType, false) then
    begin
      TMethod(NotifyMenuEvent).Data:= MenuEventRec.Data;
      TMethod(NotifyMenuEvent).Code:= MenuEventRec.Code;
      NotifyMenuEvent(Sender);
    end;
  Except
    on E:Exception do begin
	  end;
  End;
  AddMenuWorkflowEntry(Sender);
end;*)
procedure TWorkflowAction.OnMenuClick(Sender:TObject);
var
  MenuEventRec: TMenuEventRec;
  NotifyMenuEvent: TNotifyEvent;
  function MenuName:String;
  begin
         Result := '';
         if (Sender is TMenuItem)    then REsult:= TMenuItem(Sender).Name
      else if (Sender is TAction)    then REsult:= TAction(Sender).Name
      else if (Sender is TDnMAction) then REsult:= TDnMAction(Sender).Name;
  end;
begin
  if not(Sender is TMenuItem) and not(Sender is TAction) and not(Sender is TDnMAction)   then exit;
  try
    if Self.GetMenuEventRec(TComponent(Sender), MenuEventRec, MenuName, OnMenuClickType, false) then
    begin
      TMethod(NotifyMenuEvent).Data:= MenuEventRec.Data;
      TMethod(NotifyMenuEvent).Code:= MenuEventRec.Code;
      NotifyMenuEvent(Sender);
    end;
  Except
    on E:Exception do begin
	  end;
  End;
  AddMenuWorkflowEntry(Sender);
end;
Procedure TWorkflowAction.AddMenuWorkflowEntry(Sender:TObject);
  function MenuName:String;
  begin
         if (Sender is TPopupMenu)    then result := TPopupMenu(Sender).Name
    else if (Sender is TAdvPopupMenu) then result := TAdvPopupMenu(Sender).Name
    else if (Sender is TMenuItem)     then result := TMenuItem(Sender).Name;
  end;
  function MenuCaption:String;
  begin
         if (Sender is TPopupMenu)    then result := TPopupMenu(Sender).Name
    else if (Sender is TAdvPopupMenu) then result := TAdvPopupMenu(Sender).Name
    else if (Sender is TMenuItem)     then result := TMenuItem(Sender).Caption;
  end;
  function MenuHelpcontextID:Integer;
  begin
    Result := 0;
         if (Sender is TPopupMenu)    then result := TPopupMenu(Sender).Helpcontext
    else if (Sender is TAdvPopupMenu) then result := TAdvPopupMenu(Sender).Helpcontext
    else if (Sender is TMenuItem)     then result := TMenuItem(Sender).Helpcontext;
  end;
begin
  try
    if appenv.appdb.connection.connected then
      if AppEnv.CompanyPrefs.UseWorkFlow then
        if IsWorkFlowRecoding then
            WorkflowActions.AddWorkflowAction(uetMouse, WM_LBUTTONDOWN , 0, False, MenuName, Sender.classname);
  Except
  end;
end;


function TWorkflowAction.GetmenuEventRec(Comp:TComponent; var MenuEventRec: TMenuEventRec; Const Name: string; MenuEventType: TMenuEventType; const RemoveFromList: boolean = false): Boolean;
var
  x: integer;
  fMenuEventList :TList;
begin
  result:= False;
  fMenuEventList :=MenuEventList(comp);
  if fMenuEventList = nil then exit;

  try
  for x:= 0 to fMenuEventList.Count -1 do begin
    if (PMenuEventRec(fMenuEventList.Items[x])^.MenuEventType = MenuEventType) and (PMenuEventRec(fMenuEventList.Items[x])^.Name = Name) then begin
      result:= true;
      MenuEventRec:= PMenuEventRec(fMenuEventList.Items[x])^;
      if RemoveFromList then begin
        Dispose(fMenuEventList.Items[x]);
        fMenuEventList.Delete(x);
      end;
      Break;
    end;
  end;
  except
      on E:Exception do begin
          //resultStatus.addItem(False, rssWarning, 0,E.message + chr(13) + Self.Classname );
      end;
  end;
end;
function IsWorkFlowRecoding:Boolean;
begin
  REsult := WorkflowStatus = wfsrecording  ;
end;
function IsWorkFlowPlaying:Boolean;
begin
  REsult := WorkflowStatus = wfsPlaying  ;
end;


initialization
  WorkflowStatus  := wfsNone;
  WorkflowActions := TWorkflowAction.Create;
finalization
  FreeAndNil(WorkflowActions);

end.

