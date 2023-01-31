unit frmWorkflowPlay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ProgressDialog, DB, MemDS, DBAccess, MyAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, DNMPanel , BusobjWorkflow,
  DNMSpeedButton, DBCtrls , BusObjBase, BaseInputForm, frmBase, jpeg, pngimage, frmWorkflowhint, WwDBGrid, ImageScroll;

type
  TControlRec = record
    WorkflowID        :Integer ;
    Seqno             :Integer ;
    formName          :string  ;
    Formclassname     :string  ;
    ControlName       :string  ;
    HelpcontextID     :string  ;
    buttonActionName  :string  ;
    EventName         :string  ;
    ControlParent     :string  ;
    fieldname         :string  ;
    Propname          :string  ;
    Showhint          :Boolean ;
    ShowPoint         :Boolean ;
    Gridcomboname     :string  ;
    value             :string  ;
  end;
  TGridfieldrec = record
    WorkflowLineID:Integer;
    Grid :Integer;
    fieldname:String;
    fieldIndex :Integer;
  end;

  TcontrolEventRec = record
    Control :Tcontrol;
    CurrentControlExitEvent:TMethod;
    CurrentControlAfterOpenListEvent:TMethod;
    CurrentControlDoGridDataSelectEvent:TMethod;
    GridColEnterEvent:TMethod;
    GriddblclickEvent:TMethod;
    GridRowChangedEvent:TMethod;
    CurrentControlclickEvent :TMethod;
  end;

  TFormEventRec = record
    form :TForm;
    CurrentformcloseEvent :TCloseEvent ;
    CurrentformDeactivateEvent :TNotifyEvent;
  end;


  TfmWorkflowPlay = class(TBaseInputGUI)
    pnlMain: TDNMPanel;
    qryworkflow: TERPQuery;
    qryworkflowID: TIntegerField;
    qryworkflowDescription: TWideStringField;
    qryworkflowCompanyName: TWideStringField;
    qryworkflowActive: TWideStringField;
    qryworkflowIsERpWorkflow: TWideStringField;
    qryworkflowCreatedBy: TIntegerField;
    qryworkflowmstimestamp: TDateTimeField;
    qryworkflowmsupdateSitecode: TWideStringField;
    qryworkflowLines: TERPQuery;
    qryworkflowLinesSeqno: TIntegerField;
    qryworkflowLinesformName: TWideStringField;
    qryworkflowLinesControlname: TWideStringField;
    qryworkflowLinesfieldname: TWideStringField;
    qryworkflowLinesGridcomboname: TWideStringField;
    qryworkflowLinesPropname: TWideStringField;
    qryworkflowLinesvalue: TWideStringField;
    qryworkflowLinesshowhint: TWideStringField;
    qryworkflowLinesshowPoint: TWideStringField;
    qryworkflowLinesEventName: TWideStringField;
    qryworkflowLinesID: TIntegerField;
    qryworkflowLinesWorkflowID: TIntegerField;
    qryworkflowLinesControlParent: TWideStringField;
    qryworkflowLineseventtype: TWideStringField;
    qryworkflowLinesFormClassName: TWideStringField;
    qryworkflowLinesmstimestamp: TDateTimeField;
    qryworkflowLinesmsupdateSitecode: TWideStringField;
    dsworkflow: TDataSource;
    dsworkflowLines: TDataSource;
    DBText1: TDBText;
    Bevel1: TBevel;
    cmdCancel: TDNMSpeedButton;
    btnPreviousStep: TDNMSpeedButton;
    btnNextStep: TDNMSpeedButton;
    lblDetails: TLabel;
    qryworkflowLinesControlclassname: TWideStringField;
    qryworkflowLinesbuttonActionName: TWideStringField;
    qryworkflowLinesHelpcontextID: TWideStringField;
    qryworkflowLinesBaselistingGridDataSelectAssigned: TWideStringField;
    qryworkflowLinesMenuName: TWideStringField;
    qryworkflowLinesMenuClassname: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure cmdCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure btnNextStepClick(Sender: TObject);
    procedure btnPreviousStepClick(Sender: TObject);
    procedure qryworkflowLinesAfterScroll(DataSet: TDataSet);
  private
    Playingback:Boolean;
    fWorkFlow : TWorkFlow;
    fCurrentform :TForm ;
    (*fcurrentformwidht, fcurrentformheight :Integer;
    fCurrentformBorderStyle: TFormBorderStyle;*)
    fCurrentControl :TControl;
    ControlEventRec :TcontrolEventRec;
    FormEventRec :TFormEventRec;
    DoingControlEvent:boolean;
    DoingFormEvent:Boolean;
    Workflowhints :Array of TfmWorkflowhint;
    CurrentControlRec :TControlRec;
    Gridfieldrec : Array of TGridfieldrec;


    function WorkFlow : TWorkFlow;
    Procedure ShowIT(const WorkflowLine :TWorkflowLines);
    Procedure AssignWorkflowcontrolEvents(Const control:TControl);
    Procedure AssignWorkflowformEvents(Const form:TForm);

    Procedure AsignsourceformcontrolEvents(fControl:TComponent);
    Procedure AsignsourceformformEvents(fForm:TForm);
    procedure InitcontrolEventRec;
    procedure InitFormEventRec;

    procedure setCurrentControl(const Value: TControl);
    procedure setCurrentform(const Value: TForm);
    procedure SkipallofForm(FormName: String);
    Procedure ShowWorkFlowNextItem(const WorkflowLine :TWorkflowLines);
    procedure Clearallhint;
    procedure ShowWorkFlowItem(const WorkflowLine: TWorkflowLines);
    function controlchanged:boolean;
    procedure Nextfield(Grid :TwwDBGrid);
    procedure NextControl;
    function IsTaskbarAutoHideOn: boolean;
    procedure NotifyEventnNextControl(const Eventname:String; Sender: TObject; Method: TMethod; DoNextField:boolean;IsRowchangeEvent:Boolean =False);
(*    procedure REstoreBorderStyle;
    procedure storeBorderStyle;*)
  Protected
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
  public
    procedure Playworkflow(WorkflowID:Integer);
    Property  CurrentControl :TControl read fCurrentControl write setCurrentControl;
    Property  Currentform :TForm  read fCurrentform write setCurrentform;

  Published

    procedure OnERPComboAfterOpenList(Sender:TObject);
    procedure OnERPComboDataSelectOnList(Sender:TObject);
    procedure OnControlExit(Sender:TObject);
    procedure OnGridColEnter(Sender:TObject);
    procedure onDBLClick(Sender:TObject);
    procedure OnGridRowChanged(Sender:TObject);
    procedure OnButtonClick(Sender:TObject);
    Procedure OnWorkflowFormclose(Sender: TObject; var Action: TCloseAction);
    Procedure OnWorkflowFormDeactivate(Sender:TObject);
  end;

var
    fWorkflowPlayForm : TfmWorkflowPlay;

Function WorkflowPlayForm: TfmWorkflowPlay;

implementation

uses
  BusObjConst, CommonLib , ComCtrls, frmWorkflowPlayPointer, commonGuiLib,
  TypInfo, LogLib, WorkflowObj, MAIN , ShellAPI, AppEnvironment, tcConst,
  AppDatabase, ERPDbLookupCombo, ERPVersionConst,
  AdvGlowButton,AdvScrollBox, MainSwitchFrm2, dbplanner, ERPErrorEmailUtils,
  ImagesLib;



{$R *.dfm}
{ TfmWorkflowPlay }

function TfmWorkflowPlay.IsTaskbarAutoHideOn : boolean;
 var
   ABData : TAppBarData;
 begin
   ABData.cbSize := sizeof(ABData);
   Result := (SHAppBarMessage(ABM_GETSTATE, ABData)       and ABS_AUTOHIDE) > 0;
 end;

procedure TfmWorkflowPlay.AsignsourceformformEvents(fForm: Tform);
begin
  if formEventRec.form = fform then begin
    fForm.OnDeactivate :=formEventRec.CurrentformDeactivateEvent;
    //Logtext(fform.ClassName +'-> form Event = on deactivate');
    fForm.OnClose := formEventRec.CurrentformcloseEvent;
    //Logtext(fform.ClassName +'-> form Event  - on close');
  end;
  InitformEventRec;
end;
procedure TfmWorkflowPlay.AssignWorkflowcontrolEvents(const control: TControl);
var
  SourceformMethod : TMethod;
  WorkflowformMethod : TMethod;
begin
  InitcontrolEventRec;
  ControlEventRec.Control := Control;

  Try


  if  (control is TERPDBLookupCombo) then begin
      SourceformMethod := GetMethodProp(control, 'OnAfterOpenList');
      ControlEventRec.CurrentControlAfterOpenListEvent.Code := SourceformMethod.Code;
      ControlEventRec.CurrentControlAfterOpenListEvent.Data := SourceformMethod.Data;
      WorkflowformMethod.Code := MethodAddress('OnERPComboAfterOpenList');
      WorkflowformMethod.Data := Pointer(self);
      SetMethodProp(control, 'OnAfterOpenList', WorkflowformMethod);

      SourceformMethod := GetMethodProp(control, 'OnDoGridDataSelect');
      ControlEventRec.CurrentControlDoGridDataSelectEvent.Code := SourceformMethod.Code;
      ControlEventRec.CurrentControlDoGridDataSelectEvent.Data := SourceformMethod.Data;
      WorkflowformMethod.Code := MethodAddress('OnERPComboDataSelectOnList');
      WorkflowformMethod.Data := Pointer(self);
      SetMethodProp(control, 'OnDoGridDataSelect', WorkflowformMethod);

  end;

    if not (control is TTabSheet) then begin
      SourceformMethod := GetMethodProp(control, 'OnExit');
      ControlEventRec.CurrentControlExitEvent.Code := SourceformMethod.Code;
      ControlEventRec.CurrentControlExitEvent.Data := SourceformMethod.Data;
      WorkflowformMethod.Code := MethodAddress('OnControlExit');
      WorkflowformMethod.Data := Pointer(self);
      SetMethodProp(control, 'OnExit', WorkflowformMethod);
    end;

    if not (control is TDBPlanner) then begin
      SourceformMethod := GetMethodProp(control, 'OnExit');
      ControlEventRec.CurrentControlExitEvent.Code := SourceformMethod.Code;
      ControlEventRec.CurrentControlExitEvent.Data := SourceformMethod.Data;
      WorkflowformMethod.Code := MethodAddress('OnControlExit');
      WorkflowformMethod.Data := Pointer(self);
      SetMethodProp(control, 'OnExit', WorkflowformMethod);
    end;
    //Logtext(control.ClassName +'-> Wokflow - on Exit');
  Except
    on E:Exception do
      ShowExceptionMessageInDevmode(E, control.classname +'.OnExit ->' );
  End;


  Try
    if control is TwwDBGrid then begin
      SourceformMethod := GetMethodProp(control, 'OnColEnter');
      ControlEventRec.GridColEnterEvent.Code := SourceformMethod.Code;
      ControlEventRec.GridColEnterEvent.Data := SourceformMethod.Data;
      WorkflowformMethod.Code := MethodAddress('OnGridColEnter');
      WorkflowformMethod.Data := Pointer(self);
      SetMethodProp(control, 'OnColEnter', WorkflowformMethod);
      //Logtext(control.ClassName +'-> Wokflow - on col enter');
    end;
  Except
    on E:Exception do
      ShowExceptionMessageInDevmode(E, control.classname +'.OnColEnter ->' );
  End;

  Try
    if control is TwwDBGrid then begin
      SourceformMethod := GetMethodProp(control, 'onDBLClick');
      ControlEventRec.GriddblclickEvent.Code := SourceformMethod.Code;
      ControlEventRec.GriddblclickEvent.Data := SourceformMethod.Data;
      WorkflowformMethod.Code := MethodAddress('onDBLClick');
      WorkflowformMethod.Data := Pointer(self);
      SetMethodProp(control, 'onDBLClick', WorkflowformMethod);
      //Logtext(control.ClassName +'-> Wokflow - on col enter');
    end;
  Except
    on E:Exception do
      ShowExceptionMessageInDevmode(E, control.classname +'.OnColEnter ->' );
  End;

  Try
    if control is TwwDBGrid then begin
      SourceformMethod := GetMethodProp(control, 'Onrowchanged');
      ControlEventRec.GridRowChangedEvent.Code := SourceformMethod.Code;
      ControlEventRec.GridRowChangedEvent.Data := SourceformMethod.Data;
      WorkflowformMethod.Code := MethodAddress('OnGridRowChanged');
      WorkflowformMethod.Data := Pointer(self);
      SetMethodProp(control, 'OnRowChanged', WorkflowformMethod);
      //Logtext(control.ClassName +'-> Wokflow - on row change');
    end;
  Except
    on E:Exception do
      ShowExceptionMessageInDevmode(E, control.classname +'.OnRowchanged ->' );
  End;


  Try
    if (control is TDNMSpeedButton ) then begin
      SourceformMethod := GetMethodProp(control, 'onclick');
      ControlEventRec.CurrentControlclickEvent.Code := SourceformMethod.Code;
      ControlEventRec.CurrentControlclickEvent.Data := SourceformMethod.Data;
      WorkflowformMethod.Code := MethodAddress('OnButtonClick');
      WorkflowformMethod.Data := Pointer(self);
      SetMethodProp(control, 'onclick', WorkflowformMethod);
      //Logtext(control.ClassName +'-> Wokflow - on Click');
    end;
  Except
    on E:Exception do
      ShowExceptionMessageInDevmode(E, control.classname +'.onclick ->' );
  End;


  Try
    if (control is TAdvGlowButton ) then begin
      SourceformMethod := GetMethodProp(control, 'onclick');
      ControlEventRec.CurrentControlclickEvent.Code := SourceformMethod.Code;
      ControlEventRec.CurrentControlclickEvent.Data := SourceformMethod.Data;
      WorkflowformMethod.Code := MethodAddress('OnButtonClick');
      WorkflowformMethod.Data := Pointer(self);
      SetMethodProp(control, 'onclick', WorkflowformMethod);
      //Logtext(control.ClassName +'-> Wokflow - on Click');
    end;
  Except
    on E:Exception do
      ShowExceptionMessageInDevmode(E, control.classname +'.onclick ->' );
  End;
end;

procedure TfmWorkflowPlay.AsignsourceformcontrolEvents(fControl: TComponent);
var
  SourceformMethod : TMethod;
begin
  if ControlEventRec.Control = fControl then begin
    try
      SourceformMethod.Code := ControlEventRec.CurrentControlExitEvent.Code ;
      SourceformMethod.Data := ControlEventRec.CurrentControlExitEvent.Data ;
      SetMethodProp(fcontrol, 'OnExit', SourceformMethod);
      //Logtext(fcontrol.ClassName +'-> form Event - on Exit');
    Except
      on E:Exception do
        ShowExceptionMessageInDevmode(E, fcontrol.classname +'.OnExit ->' );
    End;
    Try
      if fcontrol is TERPDBLookupCombo then begin
        SourceformMethod.Code := ControlEventRec.CurrentControlAfterOpenListEvent.Code ;
        SourceformMethod.Data := ControlEventRec.CurrentControlAfterOpenListEvent.Data ;
        SetMethodProp(fcontrol, 'OnAfterOpenlist', SourceformMethod);
          //Logtext(fcontrol.ClassName +'-> form Event - on col enter');
        SourceformMethod.Code := ControlEventRec.CurrentControlDoGridDataSelectEvent.Code ;
        SourceformMethod.Data := ControlEventRec.CurrentControlDoGridDataSelectEvent.Data ;
        SetMethodProp(fcontrol, 'OnDoGridDataSelect', SourceformMethod);
          //Logtext(fcontrol.ClassName +'-> form Event - on col enter');
      end;
    Except
      on E:Exception do
        ShowExceptionMessageInDevmode(E, fcontrol.classname +'.OnColEnter ->' );
    End;

    Try
      if fcontrol is TwwDBGrid then begin
        SourceformMethod.Code := ControlEventRec.GridColEnterEvent.Code ;
        SourceformMethod.Data := ControlEventRec.GridColEnterEvent.Data ;
        SetMethodProp(fcontrol, 'OnColEnter', SourceformMethod);
        //Logtext(fcontrol.ClassName +'-> form Event - on col enter');
      end;
    Except
      on E:Exception do
        ShowExceptionMessageInDevmode(E, fcontrol.classname +'.OnColEnter ->' );
    End;

    Try
      if fcontrol is TwwDBGrid then begin
        SourceformMethod.Code := ControlEventRec.GriddblclickEvent.Code ;
        SourceformMethod.Data := ControlEventRec.GriddblclickEvent.Data ;
        SetMethodProp(fcontrol, 'onDBLClick', SourceformMethod);
        //Logtext(fcontrol.ClassName +'-> form Event - on col enter');
      end;
    Except
      on E:Exception do
        ShowExceptionMessageInDevmode(E, fcontrol.classname +'.OnColEnter ->' );
    End;

    Try
      if fcontrol is TwwDBGrid then begin
        SourceformMethod.Code := ControlEventRec.GridRowChangedEvent.Code ;
        SourceformMethod.Data := ControlEventRec.GridRowChangedEvent.Data ;
        SetMethodProp(fcontrol, 'Onrowchanged', SourceformMethod);
        //Logtext(fcontrol.ClassName +'-> form Event - on rowchange');
      end;
    Except
      on E:Exception do
        ShowExceptionMessageInDevmode(E, fcontrol.classname +'.Onrowchanged ->' );
    End;

    try
      if (fcontrol is TDNMSpeedButton ) then begin
        SourceformMethod.Code := ControlEventRec.CurrentControlclickEvent.Code ;
        SourceformMethod.Data := ControlEventRec.CurrentControlclickEvent.Data ;
        SetMethodProp(fcontrol, 'OnClick', SourceformMethod);
        //Logtext(fcontrol.ClassName +'-> form Event - on click');
      end;
    Except
      on E:Exception do
        ShowExceptionMessageInDevmode(E, fcontrol.classname +'.OnClick ->' );
    End;

    try
      if (fcontrol is TAdvGlowButton ) then begin
        SourceformMethod.Code := ControlEventRec.CurrentControlclickEvent.Code ;
        SourceformMethod.Data := ControlEventRec.CurrentControlclickEvent.Data ;
        SetMethodProp(fcontrol, 'OnClick', SourceformMethod);
        //Logtext(fcontrol.ClassName +'-> form Event - on click');
      end;
    Except
      on E:Exception do
        ShowExceptionMessageInDevmode(E, fcontrol.classname +'.OnClick ->' );
    End;
  end;
  InitcontrolEventRec;
end;

procedure TfmWorkflowPlay.InitcontrolEventRec;
begin
  ControlEventRec.Control := nil;

  ControlEventRec.CurrentControlExitEvent.Code:= nil;
  ControlEventRec.CurrentControlExitEvent.Data:= nil;

  ControlEventRec.CurrentControlAfterOpenListEvent.Code:= nil;
  ControlEventRec.CurrentControlAfterOpenListEvent.Data:= nil;

  ControlEventRec.CurrentControlDoGridDataSelectEvent.Code:= nil;
  ControlEventRec.CurrentControlDoGridDataSelectEvent.Data:= nil;

  ControlEventRec.GridColEnterEvent.Code:= nil;
  ControlEventRec.GridColEnterEvent.Data:= nil;

  ControlEventRec.GriddblclickEvent.Code:= nil;
  ControlEventRec.GriddblclickEvent.Data:= nil;

  ControlEventRec.GridRowChangedEvent.Code:= nil;
  ControlEventRec.GridRowChangedEvent.Data:= nil;

  ControlEventRec.CurrentControlclickEvent.Code:= nil;
  ControlEventRec.CurrentControlclickEvent.Data:= nil;
end;
procedure TfmWorkflowPlay.InitFormEventRec;
begin
  if FormEventRec.form <> nil then begin
    if FormEventRec.form.visible then
      if FormEventRec.form is TfrmBaseGUI then
        TfrmBaseGUI(FormEventRec.form).HideHighlightControl;
    FormEventRec.form.OnDeactivate :=formEventRec.CurrentformDeactivateEvent;
    //Logtext(FormEventRec.form.ClassName +'-> form Event - on deactivate');
    FormEventRec.form.OnClose := formEventRec.CurrentformcloseEvent;
    //Logtext(FormEventRec.form.ClassName +'-> form Event - on close');
  end;

  FormEventRec.form := nil;
  FormEventRec.CurrentFormcloseEvent := nil;
  FormEventRec.CurrentFormDeactivateEvent:= nil;
end;

Procedure TfmWorkflowPlay.AssignWorkflowformEvents(Const Form:TForm);
begin
  InitFormEventRec;
  InitcontrolEventRec;
  FormEventRec.Form := Form;

  Try
    FormEventRec.CurrentFormcloseEvent:= form.OnClose;
    form.OnClose :=OnWorkflowFormclose;
    //Logtext(form.ClassName +'-> WorkFlow formclose');
  Except
    on E:Exception do
      ShowExceptionMessageInDevmode(E, Form.classname +'.Onclose ->' );
  End;
  (*Try
    FormEventRec.CurrentFormDeactivateEvent:= form.OnDeactivate;
    form.OnDeactivate :=OnWorkflowFormDeactivate;
    //Logtext(form.ClassName +'-> WorkFlow Deactivate');
  Except
    on E:Exception do
      ShowExceptionMessageInDevmode(E, Form.classname +'.OnDeactivate ->' );
  End;*)

end;

procedure TfmWorkflowPlay.btnNextStepClick(Sender: TObject);
begin
  inherited;
  Processingcursor(True);
  try
        try
            if Assigned(ControlEventRec.Control)  then
              if ControlEventRec.Control is TDNMSpeedbutton then begin
                TDNMSpeedbutton(ControlEventRec.Control).click;
                Exit;
              end;
        Except
        end;

        try
            if Assigned(ControlEventRec.Control)  then
              if ControlEventRec.Control is TAdvGlowButton then begin
                TAdvGlowButton(ControlEventRec.Control).click;
                Exit;
              end;
        Except
        end;

    ShowWorkFlowNextItem(WorkFlow.Lines);
    application.ProcessMessages;
  finally
    Processingcursor(False);
  end;

end;
Procedure TfmWorkflowPlay.Clearallhint;
var
  ctr:Integer;
begin
  for ctr:= high(Workflowhints) downto low(Workflowhints) do begin
    Workflowhints[ctr].Close;
    Workflowhints[ctr]:= nil;
  end;
  SetLength(Workflowhints,0);
end;
Procedure TfmWorkflowPlay.ShowWorkFlowItem(const WorkflowLine :TWorkflowLines);
begin
    if WorkflowLine.Eof = False then
           ShowIt(WorkflowLine)
    else cmdCancel.Click;
end;
Procedure TfmWorkflowPlay.ShowWorkFlowNextItem(const WorkflowLine :TWorkflowLines);
begin
  Clearallhint;
  Repeat
     WorkflowLine.Next;
     ShowWorkFlowItem(WorkflowLine);
  Until (WorkflowLine.Eof ) or ( WorkflowLine.hintOnly =False);
end;
procedure TfmWorkflowPlay.SkipallofForm(FormName:String);
begin
  try
    while sametext(WorkFlow.Lines.formname ,FormName) and (WorkFlow.Lines.Eof=False) do
      WorkFlow.Lines.next;
  Except
  end;
  if not(WorkFlow.Lines.EOF) then
    ShowWorkFlowItem(WorkFlow.Lines)
  else cmdCancel.Click;
end;

procedure TfmWorkflowPlay.btnPreviousStepClick(Sender: TObject);
begin
  inherited;
  ProcessingCursor(True);
  try
    if WorkFlow.Lines.Bof then exit;
    WorkFlow.Lines.Prior;
    ShowWorkFlowItem(WorkFlow.Lines);
    application.ProcessMessages;
  finally
    Processingcursor(False);
  end;
end;

procedure TfmWorkflowPlay.cmdCancelClick(Sender: TObject);
begin
  inherited;
  InitFormEventRec;
  if ControlEventRec.Control <> nil then AsignsourceformcontrolEvents(ControlEventRec.Control);
  InitcontrolEventRec;
  WorkflowPlayPointerForm.visible := False;
  if Assigned(fWorkFlow) then begin
    Workflow.Lines.closedb;
    Workflow.Closedb;
    Freeandnil(fWorkFlow);
  end;
  Playingback := False;
  Self.Visible := False;
  fCurrentform :=nil;
  fCurrentControl :=nil;
  WorkflowStatus := wfsNone;
end;

function TfmWorkflowPlay.controlchanged: boolean;
begin
    result := (CurrentControlRec.formName          <> Workflow.lines.formName         ) or
              (CurrentControlRec.Formclassname     <> Workflow.lines.Formclassname    ) or
              (CurrentControlRec.ControlName       <> Workflow.lines.ControlName      ) or
              (CurrentControlRec.HelpcontextID     <> Workflow.lines.HelpcontextID    ) or
              (CurrentControlRec.buttonActionName  <> Workflow.lines.buttonActionName ) or
              (CurrentControlRec.ControlParent     <> Workflow.lines.ControlParent    );

end;

procedure TfmWorkflowPlay.DoBusinessObjectEvent(const Sender: TDatasetBusObj; const EventType, Value: string);
begin
  inherited ;
  if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
         if Sender is TWorkFlow       then TWorkFlow(Sender).Dataset      := qryworkflow
    else if sender is TWorkFlowLines  then TWorkFlowLines(Sender).dataset := qryworkflowLines;
  end;
end;

procedure TfmWorkflowPlay.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  action := caFree;
end;

procedure TfmWorkflowPlay.FormCreate(Sender: TObject);
begin
  DoingControlEvent:=False;
  DoingFormEvent:=False;
  inherited;
  Playingback:= False;
  fCurrentform :=nil;
  fCurrentControl :=nil;
  InitFormEventRec;
  InitcontrolEventRec;
  SetLength(Workflowhints , 0);
  SetLength(Gridfieldrec , 0);
end;


procedure TfmWorkflowPlay.NextControl;
var
  sFormName, sformClassname , sControlName :String;
begin
  try
    sFormName:=  Workflow.lines.formName  ;
    sformClassname:=  Workflow.lines.Formclassname;
    sControlName :=  Workflow.lines.ControlName ;
    While (Workflow.lines.EOF=False) do begin
        Workflow.lines.Next;
        IF (sFormName <> Workflow.lines.formName ) or (sformClassname <> Workflow.lines.Formclassname ) or (sControlName <> Workflow.lines.ControlName ) then  exit;
    end;
  finally
    ShowWorkFlowItem(Workflow.lines);
  end;

end;

Procedure TfmWorkflowPlay.Nextfield(Grid :TwwDBGrid);
var
  bm:TBookmark;
  sFormName, sformClassname , sControlName :String;
begin

  if not(controlchanged) then
    if Grid.ColumnByName(CurrentControlRec.fieldname).Index >= Grid.GetActiveCol -1 then exit;



  Clearallhint;

    sFormName:=  Workflow.lines.formName  ;
    sformClassname:=  Workflow.lines.Formclassname;
    sControlName :=  Workflow.lines.ControlName ;
    While (Workflow.lines.EOF=False) and (Grid.ColumnByName(Workflow.lines.fieldname).Index < Grid.GetActiveCol -1) do begin
       bm := Workflow.lines.getbookmark;
       try
        Workflow.lines.Next;
        // loop within the grid fields - exit if another control
        IF (sFormName <> Workflow.lines.formName ) or (sformClassname <> Workflow.lines.Formclassname ) or (sControlName <> Workflow.lines.ControlName ) then  begin
          Workflow.lines.gotobookmark(bm);
          exit;
        end;
       finally
          Workflow.lines.freebookmark(bm);
       end;
    end;
    ShowWorkFlowItem(Workflow.lines);
    if controlchanged and (fcurrentcontrol = Grid) then exit; {for the grids when field changed not control changed don't change the hint}
end;
procedure TfmWorkflowPlay.OnWorkflowFormclose(Sender: TObject; var Action: TCloseAction);
var
  formname:String;
begin
  Try
    if DoingformEvent then exit;
    DoingformEvent:= True;
    try
      if fcurrentform is TfrmBaseGUI then
          TfrmBaseGUI(fCurrentform).HideHighlightControl;

      (*formname :=Tform(Sender).name;
      try
        SkipallofForm(formname);
      Except
        // kiill the exception
      end;*)

      if (Sender is Tform) and (FormEventRec.form = TForm(Sender)) then begin
        if Assigned(FormEventRec.CurrentFormcloseEvent) then
          try
            FormEventRec.CurrentFormcloseEvent(sender , Action);
          Except
            on E:Exception do ShowExceptionMessageInDevmode(E, Tform(Sender).name + '.formclose' );
          end;
      end;
      InitcontrolEventRec;
      InitFormEventRec;

      formname :=Tform(Sender).name;
      if action = cafree then Tform(Sender).Release;
      try
        SkipallofForm(formname);
      Except
        // kiill the exception
      end;
    finally
      DoingformEvent:= False;
    end;
  Except
    on E:Exception do begin
      //Logtext('OnWorkflowFormclose : ' +E.message);
    end;
  end;
end;
procedure TfmWorkflowPlay.OnWorkflowFormDeactivate(Sender: TObject);
begin
  Try
    if DoingformEvent then exit;
    DoingformEvent:= True;
    try
      if screen.activeform is TfmWorkflowPlayPointer then exit;
      if screen.activeform is TfmWorkflowPlay then exit;
      if fcurrentform is TfrmBaseGUI then
          TfrmBaseGUI(fCurrentform).HideHighlightControl;
      if (Sender is Tform) and (FormEventRec.form = TForm(Sender)) then begin
        if Assigned(FormEventRec.CurrentFormDeactivateEvent) then
          try
            FormEventRec.CurrentFormDeactivateEvent(sender);
          Except
            on E:Exception do ShowExceptionMessageInDevmode(E, Tform(Sender).name + '.deactivate' );
          end;
      end;
      InitcontrolEventRec;
      //InitFormEventRec;
    finally
      DoingformEvent:= False;
    end;
  Except
    on E:Exception do begin
      //Logtext('OnWorkflowFormDeactivate : ' +E.message);
    end;
  end;
end;


procedure TfmWorkflowPlay.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE  then Key := 0;
  inherited;

end;

procedure TfmWorkflowPlay.FormPaint(Sender: TObject);
begin
  //inherited;

end;

procedure TfmWorkflowPlay.FormShow(Sender: TObject);
var
  Data: TAppBarData;
begin
  inherited;
    Left:= Application.MainForm.Left + Application.MainForm.Width  - Width-5;
    Top:= Application.MainForm.Top   + Application.MainForm.Height;
    top := top - Height;
    top := top - Mainform.StatusBar.height;
    if IsTaskbarAutoHideOn =false then
      if SHAppBarMessage(ABM_GETTASKBARPOS, Data) = 1 then
        Top := top- (Data.rc.Bottom - Data.rc.Top);
    top := top - 5;

    //Self.Color := clSilver;
    //Self.Repaint;
    Self.TransparentColorValue := Self.Color;
    btnPreviousStep.Color := $00A8FFA8;
    btnNextStep.Color     := $00A8FFA8;
    cmdCancel.Color       := $008C8CFF;
end;

procedure TfmWorkflowPlay.Playworkflow(WorkflowID: Integer);
begin
  if (WorkflowStatus <> wfsNone) then exit;
  try
  if Playingback then begin
    MessageDlgXP_vista('Another workflow is Playing. You cannot start this ', mtWarning, [mbOK], 0);
    Exit;
  end;
  if WorkflowID =0 then exit;

  Playingback := True;
  With Workflow do begin
    Load(WorkflowID);
    if count =0 then begin
      Playingback := False;
      exit;
    end;
    lines.Filter := 'EventName <> ' +quotedstr('');
    lines.Filtered := True;
    if lines.Count =0 then begin
      Playingback := False;
      exit;
    end;
    Lines.First;
    Self.Show;
    bringtofront;
    ShowIT(Lines);
  end;
  finally
    if Playingback then
      WorkflowStatus := wfsPlaying;
  end;

end;


procedure TfmWorkflowPlay.qryworkflowLinesAfterScroll(DataSet: TDataSet);
begin
  inherited;
  lblDetails.Caption := qryworkflowLinesEventName.AsString;
  lblDetails.REfresh;
end;

procedure TfmWorkflowPlay.setCurrentControl(const Value: TControl);
Procedure StoreGridfieldname;
var
  ctr:Integer;
begin
    for ctr:= low(Gridfieldrec) to high(Gridfieldrec) do
      if (Gridfieldrec[ctr].WorkflowLineID  = Workflow.lines.ID) and
         (Gridfieldrec[ctr].fieldname       = Workflow.lines.fieldname) and
         (Gridfieldrec[ctr].Grid            = integer(Value)) and
         (Gridfieldrec[ctr].fieldIndex      = twwDBGrid(Value).ColumnByName(Workflow.lines.fieldname).Index) then
          Exit; // this field name already exists for the grid

    SetLength(Gridfieldrec,Length(Gridfieldrec)+1);
    Gridfieldrec[high(Gridfieldrec)].WorkflowLineID := Workflow.lines.ID;
    Gridfieldrec[high(Gridfieldrec)].fieldname      := Workflow.lines.fieldname;
    Gridfieldrec[high(Gridfieldrec)].Grid           := integer(Value);
    Gridfieldrec[high(Gridfieldrec)].fieldIndex     := twwDBGrid(Value).ColumnByName(Workflow.lines.fieldname).Index;
end;
begin
if fCurrentControl <> value then begin
  if Assigned(fCurrentControl) then begin
    AsignsourceformcontrolEvents(fCurrentControl);
  end;

  if Value = nil then begin
    InitcontrolEventRec;
  end else begin
    AssignWorkflowcontrolEvents(value);
  end;
  SetLength(Gridfieldrec,0);
  if (Value is TwwDBGrid) and (Workflow.lines.fieldname <> '') then begin
    StoreGridfieldname;
  end;
  fCurrentControl := Value;
end else begin
  if (Value is TwwDBGrid) and (Workflow.lines.fieldname <> '') then begin
    StoreGridfieldname;
  end;
end;
end;
(*procedure TfmWorkflowPlay.storeBorderStyle;
begin
  if fcurrentform <> nil then begin
      fcurrentformwidht := fcurrentform.width;
      fcurrentformheight := fcurrentform.Height;
      fCurrentformBorderStyle:= fcurrentform.BorderStyle;
      fcurrentform.BorderStyle := bsNone;
      fcurrentform.width := fcurrentformwidht;
      fcurrentform.Height := fcurrentformheight;
  end;

end;
procedure TfmWorkflowPlay.REstoreBorderStyle;
begin

    if fcurrentform <> nil then begin
      fcurrentformwidht := fcurrentform.width;
      fcurrentformheight := fcurrentform.Height;
      fcurrentform.BorderStyle := fCurrentformBorderStyle;
      fcurrentform.width := fcurrentformwidht;
      fcurrentform.Height := fcurrentformheight;
    end;
    fCurrentformBorderStyle := bsSingle;
end;*)

procedure TfmWorkflowPlay.setCurrentform(const Value: TForm);
begin
try
  if fcurrentform <> value then begin
    //REstoreBorderStyle;
    try
      if Assigned(fCurrentControl) then
        AsignsourceformcontrolEvents(fCurrentControl);
    Except
      on E:Exception do begin
        //Logtext('1:' + E.Message);
      end;
    end;
    Try
      if Assigned(fcurrentform) then begin
        if fcurrentform is TfrmBaseGUI then
          TfrmBaseGUI(fCurrentform).HideHighlightControl;
        AsignsourceformformEvents(fCurrentform);
      end;
    Except
      on E:Exception do begin
        //Logtext('2:' + E.Message);
      end;
    end;
    if Value = nil then begin
      InitFormEventRec;
    end else begin
      AssignWorkflowformEvents(value);
    end;
    fCurrentform := Value;
    //storeBorderStyle;
  end;
Except
  on E:Exception do begin
        //Logtext('3:' + E.Message);
  end;
end;

end;

procedure TfmWorkflowPlay.ShowIT(const WorkflowLine: TWorkflowLines);
var
  form :Tcomponent;
  comp1, comp2 :TComponent;
  st:TStringlist;
  i:Integer;
  Focuscon :TControl;
  sERPReportingEmailText:String;
  //acontrol :TControl;
  s:String;

  function FindExistingComponent(Const RootComponent:TComponent; Const ComponentName: string; SearchSub :Boolean ;  aComponentClassName:String ;aHelpcontextID:string ; fsControlParent:String = ''): TComponent;
  var
    comp :Tcontrol;
  begin
    REsult :=  FindExistingComponentbyname(RootComponent,ComponentName,SearchSub, fsControlParent);
    if result = nil then begin
      sERPReportingEmailText := sERPReportingEmailText + WorkflowLine.ControlParent+',' +WorkflowLine.HelpcontextID +',' +WorkflowLine.fieldname+',' +WorkflowLine.Gridcomboname+',' + WorkflowLine.EventName;
      sERPReportingEmailText := sERPReportingEmailText + NL + 'conponent not found : ' + RootComponent.Classname +'.' + ComponentName;
      if (IsInteger(aHelpcontextID)) and (strtoint(aHelpcontextID) <> 0) and (RootComponent is TfrmBaseGUI) and (trim(aComponentClassName) <> '' ) then begin
        result := TfrmBaseGUI(RootComponent).GetComponentForHelpcontextID(aComponentClassName  , strtoint(aHelpcontextID) , sERPReportingEmailText);
        if Assigned(result) then begin
          sERPReportingEmailText := sERPReportingEmailText + NL + 'Conponent found for helpcontextID -> ' + RootComponent.Classname +'.' + REsult.Name;
          if Result is Tcontrol then begin
            comp := Tcontrol(Result).parent;
            while (comp <> RootComponent) or (Comp = nil) do begin
              if  (comp is TTabsheet) and Assigned(comp.parent) and (TTabsheet(comp).parent is TPageControl) then begin
                if TPageControl(comp.parent).activePage <> TTabsheet(comp) then begin
                  TPageControl(comp.parent).activePage := TTabsheet(comp);
                  comp :=TTabsheet(comp).parent;
                end;
              end else begin
                Comp := comp.Parent;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
  Procedure HandleScroboxParentPosition(cont:TControl);
  var
    ctr, ControlTop, ControlHeight, NewPosition:Integer;
    ImageScroll :TImageScroll;
    Image: TImage;
    Parentcont, parentParent:TControl;
  begin
    if not Assigned(cont) then exit;
    Parentcont    := cont.Parent       ; if not Assigned(Parentcont)   then exit;
    parentParent  := Parentcont.Parent ; if not Assigned(parentParent) then Exit;

    if (parentParent is TScrollbox) and (Parentcont is TDNMPanel) then begin

      ImageScroll:= nil;
      Image:= nil;

      for ctr := 0 to currentform.ComponentCount-1 do begin
        if currentform.Components[ctr] is TImageScroll then
          if TImageScroll(currentform.Components[ctr]).scrollbox = TScrollbox(parentParent) then begin
             ImageScroll :=TImageScroll(currentform.Components[ctr]);
             break;
          end;
      end;
      if ImageScroll = nil then exit;

      for ctr := 0 to currentform.ComponentCount-1 do begin
        if currentform.Components[ctr] is TImage then
          if TImage(currentform.Components[ctr]) = ImageScroll.Image then begin
             Image :=TImage(currentform.Components[ctr]);
             break;
          end;
      end;
      if Image = nil then exit;

      ImageScroll.PerformScroll(0);
      ControlTop := TDNMPanel(Parentcont).Top + cont.Top;
      ControlHeight := cont.Height;
      NewPosition := System.Round((ControlTop - ((TScrollbox(parentParent).ClientHeight - ControlHeight) / 2)) / ImageScrollHeightFactor(ImageScroll));

      if NewPosition > Image.ClientHeight then
        ImageScroll.PerformScroll(Image.ClientHeight)
      else if NewPosition > 0 then
        ImageScroll.PerformScroll(NewPosition);
    end;
    if Assigned(Parentparent.Parent) then HandleScroboxParentPosition(Parentcont(* , Parentparent, Parentparent.Parent*));

  end;
  Procedure showit(const WorkflowPlayPointerform : TfmWorkflowPlayPointer);
  begin
    CurrentControlRec.WorkflowID        := Workflowline.WorkflowID;
    CurrentControlRec.Seqno             := Workflowline.Seqno;
    CurrentControlRec.formName          := Workflowline.formName;
    CurrentControlRec.Formclassname     := Workflowline.Formclassname;
    CurrentControlRec.ControlName       := Workflowline.ControlName;
    CurrentControlRec.HelpcontextID     := Workflowline.HelpcontextID;
    CurrentControlRec.buttonActionName  := Workflowline.buttonActionName;
    CurrentControlRec.EventName         := Workflowline.EventName;
    CurrentControlRec.ControlParent     := Workflowline.ControlParent;
    CurrentControlRec.fieldname         := Workflowline.fieldname;
    CurrentControlRec.Propname          := Workflowline.Propname;
    CurrentControlRec.Showhint          := Workflowline.Showhint;
    CurrentControlRec.ShowPoint         := Workflowline.ShowPoint;
    CurrentControlRec.Gridcomboname     := Workflowline.Gridcomboname;
    CurrentControlRec.value             := Workflowline.value;
    with WorkflowPlayPointerform do begin
      WorkFlowcontrol := Focuscon;
      Visible := True;
      WorkflowMsg := WorkflowLine.EventName;
      (*if Assigned(Focuscon.Parent) and Assigned(Focuscon.Parent.Parent) then*)
        HandleScroboxParentPosition(Focuscon(*, Focuscon.Parent, Focuscon.Parent.Parent*));
      if assigned(Focuscon.parent) and (Focuscon.top > Focuscon.parent.height) then
        Visible := False
      else
      if Focuscon is twwDBGrid then begin
        WorkflowPosition[False] := GridMDIPosition(TwwDBGrid(Focuscon) ,WorkflowLine.fieldname, width, true);
      end else begin
        WorkflowPosition[True] := MDIPosition(Focuscon);
      end;
    end;
  end;

(*  Procedure ShowMenutree(MenuItem :TMenuItem);
  var
    MSG :TMessage;
  begin
    if Assigned(MenuItem.Parent) and (MenuItem.parent is TMenuItem) then
      ShowMenutree(TMenuItem(MenuItem.parent))
    else     SendKeys('{F10}',True);
    if MenuItem.count>0 then

    else MenuItem.click;
  end;*)


  Procedure showMenu;
  var
    Comp :Tcomponent;
    P:TPoint;
  begin
    if WorkflowLine.Menuname = '' then exit;
    comp := CurrentForm.findcomponent(WorkflowLine.Menuname);
(*    if comp = nil then
      if Currentform is TMainSwitch2 then
        comp := mainform.menu.owner.findcomponent(WorkflowLine.Menuname);*)
    if comp = nil then exit;
    P:= MDIPosition(CurrentControl);
    if comp is TPopupmenu then begin
        TPopupmenu(comp).Popup(P.X, P.Y);
        Exit;
    end;
    if comp is TAdvPopupMenu then begin
        TAdvPopupMenu(comp).Popup(P.X, P.Y);
        Exit;
    end;
    if comp is TMenuItem then begin
      TMenuItem(comp).click;
      (*if TMenuItem(comp).count >0 then
        ShowMenutree(TMenuItem(comp))
      else
        TMenuItem(comp).click;*)

        //TMenuItem(comp).DispatchPopup(TMenuItem(comp).handle);
        Exit;
    end;
  end;
begin
  //Logtext('3: ShowIt:'+WorkflowLine.ControlParent);
Processingcursor(True);
try
  sERPReportingEmailText := '';
  try
    //acontrol := ControlEventRec.Control;
    try
      try
        qryworkflowLinesAfterScroll(qryworkflowLines);
        if WorkflowLine.Formclassname = '' then exit;
        form := getComponentbyclassname(WorkflowLine.Formclassname , True , nil , true , false );
        if not(Assigned(Form)) then begin
          CurrentControl :=nil;
          sERPReportingEmailText := 'Form not found :' + WorkflowLine.Formclassname;
          exit;
        end;


        if WorkflowLine.AssignedGridDataSelect then
          if Form is TForm then
            if TForm(Form).Visible =False then begin
              if (CurrentControl is TwwDBGrid ) and (TwwDBGrid(CurrentControl).getactivefield.asString <>'') then else begin
                MessageDlgXP_vista('Please select ''Open List'' from the combo to open '+ quotedstr(TFOrm(form).caption)+'.', mtInformation, [mbOK], 0);
                exit;
              end;
            end;


        if not (Form is TForm) then begin
          CurrentControl :=nil;
          sERPReportingEmailText := WorkflowLine.Formclassname+' is not a form';
          exit;
        end;
        (*if Currentform <> form then *)Currentform :=TForm(Form);
        if CurrentForm.Visible then CurrentForm.bringtofront
        //else if WorkflowLine.AssignedGridDataSelect then Exit
        else CurrentForm.formstyle := fsMdichild;
        st:= tStringlist.Create;
        try
          s:= '';
          st.Delimiter :='.';
          St.DelimitedText :=  WorkflowLine.ControlParent;
          if sametext(st[0] , WorkflowLine.formName) then begin
            s:= st[0]+'.';
            St.Delete(0);
          end;

          {make the page active if the component is inside a pagecontrol's page}

          for i := 0 to st.Count-2 do begin
            try
              comp1 := FindExistingComponentbyname(CurrentForm , st[i], true, s+st[i]);
              comp2 := FindExistingComponentbyname(CurrentForm , st[i+1], true, s+st[i]+'.'+st[i+1]);
              if assigned(Comp1) and Assigned(Comp2) then
                if (Comp1 is TPageControl) and (Comp2 is TTabsheet) then
                  if TPageControl(Comp1).activePage <> TTabsheet(Comp2) then begin
                    //TPageControl(Comp1).activePage := TTabsheet(Comp2);
                    TPageControl(Comp1).activePageindex := TTabsheet(Comp2).pageindex;
                    TPageControl(Comp1).OnChange(TPageControl(Comp1));
                  end;
              s:= s+st[i]+'.';
            Except
              // kill the exception
            end;
          end;

          try

            comp1 := FindExistingComponent(CurrentForm , st[st.Count-1], true, WorkflowLine.Controlclassname , WorkflowLine.HelpcontextID,WorkflowLine.controlparent);

            if assigned(comp1) and (Comp1 is TControl) then begin
              CurrentControl :=TControl(comp1);
              Focuscon := TControl(comp1);
              TfrmBaseGUI(Form).HideHighlightControl;
              if not(Focuscon is TToolButton) and (form is TfrmBaseGUI) and not(Focuscon is TwwDBGrid) then begin
                TfrmBaseGUI(Form).HighlightControl(Focuscon);
                //Focuscon:=TfrmBaseGUI(Form).shapehint;
              end;
              if WorkflowLine.HintOnly then begin
                setLength(Workflowhints , length(Workflowhints)+1);
                Workflowhints[high(Workflowhints)] := TfmWorkflowhint.create(self);
                showit(Workflowhints[high(Workflowhints)]);
              end else begin
                showit(WorkflowPlayPointerForm);
              end;
              showMenu;
            end else begin
              CurrentControl :=nil;
            end;
          except
          end;
        finally
(*          if Screen.activeControl = btnNextStep then
            {when next button is clicked instead of clickng on the button on action , if its the main button on the mainswitch, the page is not changed,
            here forcing to click the button }
            if Assigned(Acontrol) and (acontrol <> ControlEventRec.Control ) then
              if acontrol is TDNMSpeedbutton then begin
                sERPReportingEmailText :='';
                TDNMSpeedbutton(acontrol).click;
                ShowWorkFlowItem(WorkFlow.Lines);
              end;*)
        end;

        CurrentForm.Setfocus;
        //if CurrentControl is TWincontrol then SetcontrolFocus(TWincontrol(comp1));
      finally
        freeandnil(st);
      end;
    Except
      on E:Exception do
        ShowExceptionMessageInDevmode(E, 'TfmWorkflowPlay.ShowIT->' );
    end;
  finally
    if (sERPReportingEmailText <> '') and (WorkflowLine.IgnoreOnError=False) then begin
      sERPReportingEmailText := 'User      : ' +appenv.Employee.EmployeeName +NL +
                                'Server   : ' + WorkflowLine.Connection.Connection.Server+NL +
                                'Database  : ' + WorkflowLine.Connection.Connection.Database+'.' + Appenv.CompanyInfo.CompanyName +NL +
                                'ERP Version : ' + TABLE_VERSION+NL +
                                'workflow #: ' + inttostr(WorkflowLine.WorkflowID) +NL + sERPReportingEmailText+NL+NL+
                                TWorkFlow.WorkflowRecSQL(WorkflowLine.WorkFlowID);
      SendEmailtoErp('Workflow - component Mismatch' ,sERPReportingEmailText);

      {goto the next one if not found the component}
      if CurrentControl = nil then  btnNextStep.click;
    end;
    Focuscon := nil;
  end;
finally
  Processingcursor(False);
end;
end;


function TfmWorkflowPlay.WorkFlow: TWorkFlow;
begin
  if fWorkFlow = nil then begin
    fWorkFlow := TWorkFlow.CreateWithNewConn(Self);
    fWorkFlow.BusObjEvent := DoBusinessObjectEvent;
  end;
  result :=fWorkFlow;
end;
Function WorkflowPlayForm: TfmWorkflowPlay;
begin
  if fWorkflowPlayForm  = nil then begin
    fWorkflowPlayForm :=  TfmWorkflowPlay.Create(Application);
    fWorkflowPlayForm.Left:= Application.MainForm.Left + Application.MainForm.Width  - fWorkflowPlayForm.Width;
    fWorkflowPlayForm.Top:= Application.MainForm.Top   + Application.MainForm.Height - fWorkflowPlayForm.Height  ;
    ShowWindow(fWorkflowPlayForm.Handle, SW_SHOWNOACTIVATE);
    fWorkflowPlayForm.Visible := False;
  end;
  Result := fWorkflowPlayForm ;
end;
procedure TfmWorkflowPlay.OnButtonClick             (Sender: TObject);begin  NotifyEventnNextControl('ButtonClick'              , Sender, ControlEventRec.CurrentControlClickEvent           , False               , False);end;
procedure TfmWorkflowPlay.OnERPComboAfterOpenList   (Sender: TObject);begin  NotifyEventnNextControl('ERPComboAfterOpenList'    , Sender, ControlEventRec.CurrentControlAfterOpenListEvent   , False               , False);end;
procedure TfmWorkflowPlay.OnERPComboDataSelectOnList(Sender: TObject);begin  NotifyEventnNextControl('ERPComboDataSelectOnList' , Sender, ControlEventRec.CurrentControlDoGridDataSelectEvent, False               , False);end;
procedure TfmWorkflowPlay.OnControlExit             (Sender: TObject);begin  NotifyEventnNextControl('ControlExit'              , Sender, ControlEventRec.CurrentControlExitEvent            , False               , False);end;
procedure TfmWorkflowPlay.OnGridColEnter            (Sender: TObject);begin  NotifyEventnNextControl('GridColEnter'             , Sender, ControlEventRec.GridColEnterEvent                  , Sender is TwwDBGrid , False);end;
procedure TfmWorkflowPlay.OnGridRowChanged          (Sender: TObject);begin  NotifyEventnNextControl('GridRowChanged'           , Sender, ControlEventRec.GridRowChangedEvent                , Sender is TwwDBGrid , True );end;
procedure TfmWorkflowPlay.onDBLClick                (Sender:TObject) ;begin  NotifyEventnNextControl('onDBLClick'               , Sender, ControlEventRec.GriddblclickEvent                  , False , False );end;

procedure TfmWorkflowPlay.NotifyEventnNextControl(const Eventname:String;Sender: TObject; Method: TMethod; DoNextField:boolean; IsrowchangeEvent :Boolean =False);
var
  NotifyEvent:TNotifyEvent;
  fiID:Integer;
begin
  try
    if DoingControlEvent then exit;

    DoingControlEvent:= True;
    try
      fiID:= Workflow.Lines.ID;
      try
      if (Sender is TControl) and (ControlEventRec.control = TControl(Sender)) then begin
          //Logtext('4:'+TControl(Sender).Name +'.Notifyevent - ' + Eventname);
          TMethod(NotifyEvent).Data:= Method.Data;
          TMethod(NotifyEvent).Code:= Method.Code;
          if (TMethod(NotifyEvent).Data<> nil) and (TMethod(NotifyEvent).Code<> nil) then
            try
              NotifyEvent(Sender);
            Except
              on E:Exception do
                ShowExceptionMessageInDevmode(E, 'Notifyevent - ' + Eventname + '->' );
            End;
      end;

      if IsrowchangeEvent then
        if Sender is TwwDBGrid then begin
          if length(Gridfieldrec) >0 then
            if Gridfieldrec[0].WorkflowLineID = Workflow.Lines.ID then exit; // field not changed, but row. this happens when new record is added, or up/down arrow
            if Workflow.Lines.Locate(Workflow.Lines.IDfieldname , Gridfieldrec[0].WorkflowLineID , [] ) then begin
              ShowWorkFlowItem(Workflow.Lines);
              exit;
            end;
        end;
      finally
      if  fiID= Workflow.Lines.ID then begin
        if DoNextField then
          Nextfield(TwwDBGrid(Sender))
        else
          Nextcontrol;
      end else begin
        ShowWorkFlowItem(Workflow.Lines);
      end;

      end;
    finally
      DoingControlEvent:= False;
    end;
  Except
    on E:Exception do begin
        //Logtext(Eventname +' : ' +E.message);
    end;
  end;
end;

initialization
  fWorkflowPlayForm := nil;
finalization


(*procedure TfmWorkflowPlay.OnButtonClick(Sender: TObject);
begin
var
  NotifyEvent:TNotifyEvent;
begin
  Try
    if DoingControlEvent then exit;
    DoingControlEvent:= True;
    try
      if (Sender is TControl) and (ControlEventRec.control = TControl(Sender)) then begin
          TMethod(NotifyEvent).Data:= ControlEventRec.CurrentControlClickEvent.Data;
          TMethod(NotifyEvent).Code:= ControlEventRec.CurrentControlclickEvent.Code;
          if (TMethod(NotifyEvent).Data<> nil) and (TMethod(NotifyEvent).Code<> nil) then
            try
              NotifyEvent(Sender);
            Except
              on E:Exception do
                ShowExceptionMessageInDevmode(E, 'NotifyEvent - onclick ->' );
            End;
      end;
      btnNextstep.Click;
    finally
      DoingControlEvent:= False;
    end;
  Except
    on E:Exception do begin
        Logtext('OnButtonClick : ' +E.message);
    end;
  end;*)
(*
procedure TfmWorkflowPlay.OnERPComboAfterOpenList(Sender: TObject);
begin
var
  NotifyEvent:TNotifyEvent;
begin
  try
    if DoingControlEvent then exit;
    DoingControlEvent:= True;
    try
      if (Sender is TControl) and (ControlEventRec.control = TControl(Sender)) then begin
          TMethod(NotifyEvent).Data:= ControlEventRec.CurrentControlAfterOpenListEvent.Data;
          TMethod(NotifyEvent).Code:= ControlEventRec.CurrentControlAfterOpenListEvent.Code;
          if (TMethod(NotifyEvent).Data<> nil) and (TMethod(NotifyEvent).Code<> nil) then
            try
              NotifyEvent(Sender);
            Except
              on E:Exception do
                ShowExceptionMessageInDevmode(E, 'Notifyevent - OnExit ->' );
            End;
      end;
      Nextcontrol;
    finally
      DoingControlEvent:= False;
    end;
  Except
    on E:Exception do begin
        Logtext('OnERPComboAfterOpenList : ' +E.message);
    end;
  end;*)
(*
procedure TfmWorkflowPlay.OnERPComboDataSelectOnList(Sender: TObject);
begin
var
  NotifyEvent:TNotifyEvent;
begin
  try
    if DoingControlEvent then exit;
    DoingControlEvent:= True;
    try
      if (Sender is TControl) and (ControlEventRec.control = TControl(Sender)) then begin
          TMethod(NotifyEvent).Data:= ControlEventRec.CurrentControlDoGridDataSelectEvent.Data;
          TMethod(NotifyEvent).Code:= ControlEventRec.CurrentControlDoGridDataSelectEvent.Code;
          if (TMethod(NotifyEvent).Data<> nil) and (TMethod(NotifyEvent).Code<> nil) then
            try
              NotifyEvent(Sender);
            Except
              on E:Exception do
                ShowExceptionMessageInDevmode(E, 'Notifyevent - OnExit ->' );
            End;
      end;
      Nextcontrol;
    finally
      DoingControlEvent:= False;
    end;
  Except
    on E:Exception do begin
        Logtext('OnERPComboDataSelectOnList : ' +E.message);
    end;
  end;*)
(*
procedure TfmWorkflowPlay.OnControlExit(Sender: TObject);
begin
var
  NotifyEvent:TNotifyEvent;
begin
  try
    if DoingControlEvent then exit;
    DoingControlEvent:= True;
    try
      if (Sender is TControl) and (ControlEventRec.control = TControl(Sender)) then begin
          TMethod(NotifyEvent).Data:= ControlEventRec.CurrentControlExitEvent.Data;
          TMethod(NotifyEvent).Code:= ControlEventRec.CurrentControlExitEvent.Code;
          if (TMethod(NotifyEvent).Data<> nil) and (TMethod(NotifyEvent).Code<> nil) then
            try
              NotifyEvent(Sender);
            Except
              on E:Exception do
                ShowExceptionMessageInDevmode(E, 'Notifyevent - OnExit ->' );
            End;
      end;
      //btnNext.Click;
      Nextcontrol;
    finally
      DoingControlEvent:= False;
    end;
  Except
    on E:Exception do begin
        Logtext('OnControlExit : ' +E.message);
    end;
  end;*)

(*procedure TfmWorkflowPlay.OnGridColEnter(Sender: TObject);
begin
var
  NotifyEvent:TNotifyEvent;
begin
  Try
    if DoingControlEvent then Exit;
    DoingControlEvent:= True;
    try
      if (Sender is TControl) and (ControlEventRec.control = TControl(Sender)) then begin
          TMethod(NotifyEvent).Data:= ControlEventRec.GridColEnterEvent.Data;
          TMethod(NotifyEvent).Code:= ControlEventRec.GridColEnterEvent.Code;
          if (TMethod(NotifyEvent).Data<> nil) and (TMethod(NotifyEvent).Code<> nil) then
            try
              NotifyEvent(Sender);
            Except
              on E:Exception do
                ShowExceptionMessageInDevmode(E, 'Notifyevent - OnColEnter ->' );
            End;
      end;
      if Sender is TwwDBGrid then
        Nextfield(TwwDBGrid(Sender));
    finally
      DoingControlEvent:= False;
    end;
  Except
    on E:Exception do begin
      Logtext('OnGridColEnter : ' +E.message);
    end;
  end;*)
(*
procedure TfmWorkflowPlay.OnGridRowChanged(Sender: TObject);
begin
var
  NotifyEvent:TNotifyEvent;
begin
  Try
    if DoingControlEvent then Exit;
    DoingControlEvent:= True;
    try
      if (Sender is TControl) and (ControlEventRec.control = TControl(Sender)) then begin
          TMethod(NotifyEvent).Data:= ControlEventRec.GridRowChangedEvent.Data;
          TMethod(NotifyEvent).Code:= ControlEventRec.GridRowChangedEvent.Code;
          if (TMethod(NotifyEvent).Data<> nil) and (TMethod(NotifyEvent).Code<> nil) then
            try
              NotifyEvent(Sender);
            Except
              on E:Exception do
                ShowExceptionMessageInDevmode(E, 'Notifyevent - Onrowchanged ->' );
            End;
      end;
      if Sender is TwwDBGrid then begin
        if length(Gridfieldrec) >0 then
          if Gridfieldrec[0].WorkflowLineID = Workflow.Lines.ID then exit; // field not changed, but row. this happens when new record is added, or up/down arrow
          if Workflow.Lines.Locate(Workflow.Lines.IDfieldname , Gridfieldrec[0].WorkflowLineID , [] ) then begin
            ShowWorkFlowItem(Workflow.Lines);
            exit;
          end;
        Nextfield(TwwDBGrid(Sender));
      end;
    finally
      DoingControlEvent:= False;
    end;
  Except
    on E:Exception do begin
      Logtext('OnGridRowChanged : ' +E.message);
    end;
  end;*)
  end.



