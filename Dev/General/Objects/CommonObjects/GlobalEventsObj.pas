// Date     Version  Who  What
  // -------- -------- ---  ------------------------------------------------------
  // 11/04/05  1.00.01 BJ  a new constant added for notinlist of combo - GEVENT_ComboNotInList
  // 25/05/05  1.00.02 BJ  a new constant added for the report form's after
  //                       Create - GEVENT_AfterCreate
  // 30/05/05  1.00.03 BJ  a new constant added for the report form's
  //                       'updatebatchbuttonclick' -GEVENT_ReportUpateBatch
  //                       Event handler defined in datReprots. 



unit GlobalEventsObj;

interface

uses Classes, Controls, Forms;

type

  TGlobalHandler = procedure(const Sender: TObject; const EventName: string; const Data: Pointer = nil) of object;
  //TGlobalHandler = procedure(Sender: TObject; EventName: string; Data: pointer = nil);

  { Record to store information for each registered event handler }
  PEventHandlerRecord = ^TEventHandlerRecord;
  TEventHandlerRecord = record
    HandlerOwner: TObject;
    FormClassName: string;
    ClassName: String;
    ComponentName: string;
    EventName: string;
    Handler: TGlobalHandler;
  end;

  { The Global Events object, only create a single instance of this
    use the GlobalEvents function below to create/return reference to instance }
  TGlobalEvents = class(TObject)
  private
    List: TList;
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure RegisterHandler(const Sender: TObject; const FormClassName, ClassName, ComponentName, EventName: string;
      const Handler: TGlobalHandler);
    procedure RegisterNameHandler(const Sender: TObject; const FormClassName, ComponentName, EventName: string;
      const Handler: TGlobalHandler);
    procedure RegisterFormHandler(const Sender: TObject; const FormClassName: string; const Handler: TGlobalHandler);

    //procedure RegisterClassHandler(Sender: TObject; FormClassName, ClassName, EventName: string; Handler: TGlobalHandler);
    //procedure DeregisterClassHandler(Sender: TObject; FormClassName, ClassName, EventName: string);
    //procedure DeregisterNameHandler(Sender: TObject; FormClassName, ComponentName, EventName: string);
    procedure DeregisterHandlers(const Sender: TObject);
    procedure Notify(const Sender: TObject; const EventName: string; const Data: Pointer = nil);
  end;

  TConverSaleType = (cstQuote, cstSalesOrder, cstInvoice );

  PConvertSaleRec = ^TConvertSaleRec;
  TConvertSaleRec = record
    OldId,
    NewId: integer;
    ConvertFrom,
    ConvertTo: TConverSaleType;
  end;

function GlobalEvents: TGlobalEvents;

function GetControlsOwnerForm(const control: TControl): TForm;
function GetControlsOwnerFormClassName(const control: TControl): string;

const
  { Global event types }
  { NOTE:
    EventName_After - denotes a global event notify call after existing form event handler code
    EventName_Before - denotes a notify call before form existing event handler code }

  // form events
  GEVENT_FormCreate        = 'GEVENT_FormCreate';
  GEVENT_FormCreate_Before = 'GEVENT_FormCreate_Before';
  GEVENT_FormCreate_After  = 'GEVENT_FormCreate_After';
  GEVENT_FormShow          = 'GEVENT_FormShow';
  GEVENT_FormShow_Before   = 'GEVENT_FormShow_Before';
  GEVENT_FormClose         = 'GEVENT_FormClose';
  GEVENT_FormCloseQuery    = 'GEVENT_FormCloseQuery';

  // Combo box
  GEVENT_ComboCloseUp   = 'GEVENT_ComboCloseUp';
  GEVENT_ComboNotInList = 'GEVENT_ComboNotInList';

  // General component events
  GEVENT_OnChange_Before = 'GEVENT_OnChange_Before';
  GEVENT_OnChange        = 'GEVENT_OnChange';
  GEVENT_OnChange_After  = 'GEVENT_OnChange_After';
  GEVENT_OnExecute       = 'GEVENT_OnExecute';  // eg TAction.Execute
  GEVENT_OnClick         = 'GEVENT_OnClick';
  GEVENT_OnClick_Before  = 'GEVENT_OnClick_Before';
  GEVENT_OnClick_After   = 'GEVENT_OnClick_After';
  GEVENT_OnDblClick      = 'GEVENT_OnDblClick';
  GEVENT_OnCloseUp_After = 'GEVENT_OnCloseUp_After';

  // Menu or Popup Menu Events
  GEVENT_OnMenuPopup = 'GEVENT_OnMenuPopup';

  // DataSet events
  GEVENT_BeforeDelete = 'GEVENT_BeforeDelete';
  GEVENT_BeforeInsert = 'GEVENT_BeforeInsert';
  GEVENT_BeforeEdit   = 'GEVENT_BeforeEdit';
  GEVENT_BeforePost   = 'GEVENT_BeforePost';
  GEVENT_BeforeCancel = 'GEVENT_BeforeCancel';
  GEVENT_AfterDelete  = 'GEVENT_AfterDelete';
  GEVENT_AfterInsert  = 'GEVENT_AfterInsert';
  GEVENT_AfterEdit    = 'GEVENT_AfterEdit';
  GEVENT_AfterPost    = 'GEVENT_AfterPost';

  // Databse transaction events
  GEVENT_AfterCommit   = 'GEVENT_AfterCommit';
  GEVENT_AfterRollback = 'GEVENT_AfterRollback';

  // General Events
  GEVENT_DataChanged = 'GEVENT_DataChanged';
  GEVENT_ConvertSale = 'GEVENT_ConvertSale';
  GEVENT_ListClosed = 'GEVENT_ListClosed';
  GEVENT_AnyActionExecuting = 'GEVENT_AnyActionExecuting';
  GEVENT_AnyActionExecuted = 'GEVENT_AnyActionExecuted';
  GEVENT_TransConvertedtoInvoice = 'GEVENT_TransConvertedtoInvoice'; 
  //Reports -
  //GEVENT_ShowMarketingReports = 'GEVENT_ShowMarketingReports';
  GEVENT_AfterCreate      = 'GEVENT_AfterCreate';
  GEVENT_ReportUpateBatch = 'GEVENT_ReportUpateBatch';
  GEVENT_SalesCommissionUpateBatch = 'GEVENT_SalesCommissionUpateBatch';


  // Business object events
  GEVENT_OnSelectProduct        = 'GEVENT_OnSelectProduct';
  GEVENT_LEAD_CREATEQUOTE       = 'GEVENT_LEAD_CREATEQUOTE';
  GEVENT_LEAD_CREATEINVOICE     = 'GEVENT_LEAD_CREATEINVOICE';
  GEVENT_LEAD_CREATEAPPOINTMENT = 'GEVENT_LEAD_CREATEAPPOINTMENT';
  GEVENT_LEAD_CREATETODO        = 'GEVENT_LEAD_CREATETODO';
  GEVENT_REPAIR_CREATEAPPOINTMENT='GEVENT_REPAIR_CREATEAPPOINTMENT';
  GEVENT_LEAD_CREATESALESORDER  = 'GEVENT_LEAD_CREATESALESORDER';
  GEVENT_LEAD_REFRESH           = 'GEVENT_LEAD_REFRESH';

  // POS
  GEVENT_POS_AfterSaleListPriceChange   = 'GEVENT_POS_AfterSaleListPriceChange';
  GEVENT_POS_AfterSaleListLineDelete    = 'GEVENT_POS_AfterSaleListLineDelete';
  GEVENT_POS_CheckForListRedisplay      = 'GEVENT_POS_CheckForListRedisplay';
  GEVENT_POS_DoRebuildGrid              = 'GEVENT_POS_DoRebuildGrid';

  GEVENT_EXTENDER_PARENT_AFTERSAVE = 'GEVENT_EXTENDER_PARENT_AFTERSAVE';

  GEVENT_MESSAGEDLGXP_VISTA = 'GEVENT_MESSAGEDLGXP_VISTA';

implementation

uses
  SysUtils;

var
  GlobalEventsInst: TGlobalEvents;

function GLobalEvents: TGlobalEvents;
begin
  if not Assigned(GlobalEventsInst) then begin
    GlobalEventsInst := TGlobalEvents.Create;
  end;
  Result := GlobalEventsInst;
end;


constructor TGlobalEvents.Create;
begin
  inherited;
  List := TList.Create;
end;

destructor TGlobalEvents.Destroy;
begin
  while List.Count > 0 do begin
    Dispose(PEventHandlerRecord(List[0]));
    List.Delete(0);
  end;
  FreeAndNil(List);
  inherited;
end;


procedure TGlobalEvents.Notify(const Sender: TObject; const EventName: string; const Data: Pointer = nil);
var
  x: integer;
  Rec: TEventHandlerRecord;
  FormClassName: string;
begin
  //CompOwner:= nil;
  if Sender is TComponent then FormClassName := GetControlsOwnerFormClassName(TControl(Sender))
  else FormClassName := '';

  for x := 0 to List.Count - 1 do begin
    Rec := PEventHandlerRecord(List[x])^;
    if ((Rec.FormClassName = '') or (Rec.FormClassName = FormClassName)) and
      ((Rec.ClassName = '') or (Rec.ClassName = Sender.ClassName)) and
      ((Rec.ComponentName = '') or ((Sender is TComponent) and (TComponent(Sender).Name = Rec.ComponentName))) and
      ((Rec.EventName = '') or (Rec.EventName = EventName)) then // call the handler
      Rec.Handler(Sender, EventName, Data);
  end;
end;

procedure TGlobalEvents.RegisterHandler(const Sender: TObject;
  const FormClassName, ClassName, ComponentName, EventName: string; const Handler: TGlobalHandler);
var
  PRec: PEventHandlerRecord;
  Rec: TEventHandlerRecord;
  x:Integer;
begin
  for x:= 0 to List.Count -1 do begin
    Rec := PEventHandlerRecord(List[x])^;
    if (Rec.HandlerOwner  = Sender) and
       (Rec.HandlerOwner  = Sender) and
       (Rec.FormClassName = FormClassName) and
       (Rec.ClassName     = ClassName) and
       (Rec.ComponentName = ComponentName) and
       (Rec.EventName     = EventName) then Exit;
  end;
  New(PRec);
  PRec^.HandlerOwner := Sender;
  PRec^.FormClassName := FormClassName;
  PRec^.ClassName := ClassName;
  PRec^.ComponentName := ComponentName;
  PRec^.EventName := EventName;
  PRec^.Handler := Handler;
  List.Add(PRec);
end;

procedure TGlobalEvents.RegisterNameHandler(const Sender: TObject; const FormClassName, ComponentName, EventName: string;
  const Handler: TGlobalHandler);
begin
  RegisterHandler(Sender, FormClassName, '', ComponentName, EventName, Handler);
end;

procedure TGlobalEvents.RegisterFormHandler(const Sender: TObject; const FormClassName: string;
  const Handler: TGlobalHandler);
begin
  RegisterHandler(Sender, FormClassName, '', '', '', Handler);
end;  


procedure TGlobalEvents.DeregisterHandlers(const Sender: TObject);
var 
  x: integer;
begin
  x := 0;
  while x < List.Count do begin
    if PEventHandlerRecord(List[x])^.HandlerOwner = Sender then begin
      Dispose(PEventHandlerRecord(List[x]));
      List.Delete(x);
    end else Inc(x);
  end;
end;

function GetControlsOwnerForm(const control: TControl): TForm;
var
  ctrl: TComponent;
begin
  ctrl := control;
  while Assigned(ctrl) and (not (ctrl is TForm)) do ctrl := ctrl.Owner;

  if Assigned(ctrl) and (ctrl is TForm) then Result := TForm(ctrl)
  else Result := nil;
end;

function GetControlsOwnerFormClassName(const control: TControl): string;
var 
  Form: TForm;
begin
  Form := GetControlsOwnerForm(control);
  if Assigned(Form) then Result := Form.ClassName
  else Result := '';
end;

// -----------------------------------------------------------------------------

initialization

finalization
  if Assigned(GlobalEventsInst) then
    FreeAndNil(GlobalEventsInst);
end.
