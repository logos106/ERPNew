unit RosterWithManProcess;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RosterCalForm, DB, DBPlanner, MemDS, DBAccess, MyAccess,
  ERPdbComponents, ImgList, Menus, AdvMenus, DataState, SelectionDialog,
  AppEvnts, Wwdbigrd, Wwdbgrid, wwdbdatetimepicker, Shader, ExtCtrls, DNMPanel,
  StdCtrls, wwdblook, Grids, AdvObj, BaseGrid, AdvGrid, Planner, ComCtrls,
  DNMSpeedButton, ProgressDialog;

type
  TManufactureRosterItem = class(TItemProperties)
  private
    fiProcesstimeId: Integer;
  public
    Property ProcesstimeId:Integer read fiProcesstimeId write fiProcesstimeId;
  end;

  TfmRosterWithManProcess = class(TRosterCalGUI)
    qryProcesses: TERPQuery;
    dsProcesses: TDataSource;
    qryEmployeeProcessStep: TERPQuery;
    popProcesses: TAdvPopupMenu;
    qryWeekRosterProcesstimeID: TIntegerField;
    qryEmployeeProcessStepctr: TLargeintField;
    qryEmployees: TERPQuery;
    qryEmployeesEmployeeID: TIntegerField;
    qryEmployeesEmployeeName: TWideStringField;
    qryProcessesClassId: TIntegerField;
    qryProcessesProducTName: TWideStringField;
    qryProcessescustomerName: TWideStringField;
    qryProcessessAleId: TIntegerField;
    qryProcessesSaleLineID: TIntegerField;
    qryProcessesSAleDate: TDateField;
    qryProcessesCaption: TWideStringfield;
    qryProcessesStatus: TWideMemoField;
    qryProcessesResource: TWideStringField;
    qryProcessesProcesstep: TWideStringField;
    qryProcessesTimeStart: TDateTimeField;
    qryProcessesTimeEnd: TDateTimeField;
    qryProcessesDuration: TTimeField;
    qryProcessesrostered: TTimeField;
    qryProcessesProcessStepID: TIntegerField;
    qryProcessesDurationinSeconds: TFloatField;
    qryProcessesPtCaption: TWideStringField;
    qryProcessesProcessTimeId: TIntegerField;
    qryProcessesScheduledDate: TDateField;
    qryProcessesrosteredinseconds: TFloatField;
    QryProcessTime: TERPQuery;
    QryProcesstimeroster: TERPQuery;
    QryProcesstimerosterstartTime: TDateTimeField;
    QryProcesstimerosterendtime: TDateTimeField;
    QryProcesstimerosterhours: TFloatField;
    Horizontal1: TSplitter;
    pnlBottom: TDNMPanel;
    lblHideNonMan: TLabel;
    Label2: TLabel;
    grdProcesses: TwwDBGrid;
    chkHideNonMan: TCheckBox;
    lblTmrMsg: TLabel;
    qryProcessessDuration: TWideMemoField;
    qryProcessessrostered: TWideMemoField;
    qryProcessesProcResourceId: TIntegerField;
    procedure qryProcessesBeforeOpen(DataSet: TDataSet);
    procedure qryResourcesAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure popProcessesPopup(Sender: TObject);
    procedure plannerWeekItemMoving(Sender: TObject; Item: TPlannerItem;
      DeltaBegin, DeltaPos: Integer; var Allow: Boolean);
    procedure plannerWeekItemDblClick(Sender: TObject; Item: TPlannerItem);
    procedure qryProcessesCalcFields(DataSet: TDataSet);
    procedure qryWeekRosterBeforeOpen(DataSet: TDataSet);
    procedure chkHideNonManClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SourceItemToFields(Sender: TObject; Fields: TFields;
      Item: TPlannerItem);
    procedure grdProcessesCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure qryProcessesAfterOpen(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PopupMenuPlannerItemPopup(Sender: TObject);
    procedure Horizontal1Moved(Sender: TObject);
  private
    procedure DoAllocate(EmployeeID: Integer);
    function EmployeeCanDoProcessStep(EmployeeID,ProcessStepId: Integer): boolean;
    procedure OnSelectemployee(Sender: TObject);
    procedure SelectDate(Procesdate: TDateTime);
    procedure Populateemployeemenu(ProcesStepID: Integer=0);
    function ProcessItem(const item: TPlannerItem): boolean;
    function LockCapacityplanner: boolean;
    function ProcessTime(const ProcesstimeID:Integer):TERPQuery;
    function Processtimefordate(ProcessPartID: Integer; const Dt: TDate): Boolean;
    Procedure ReadGuipref;
    Procedure WriteGuiPref;
    procedure updateProcesstime(const ProcessTimeID:Integer);
    function TimeAvailableforemp(EmployeeID:Integer; dt:TDate; var Scheduledto :Tdatetime):Integer;
    procedure LoadEmployees(Sender: TObject);
    procedure LoadResourceProcesses(ParentMenuItem: TMenuItem);
    procedure OnSelectProcess(Sender: TObject);
    procedure RefreshPocessItemonmenu;
    procedure LoadResources;


    { Private declarations }
  Protected
    function NewItemProperty: TItemProperties;Override;
    procedure InitItemProperties(ItemProperties: TItemProperties;Fields: TFields);override;
    procedure DeleteRoster(planner: TDBPlanner; Item: TPlannerItem);Override;
    procedure PopulateClassGrids;Override;
    procedure ResetRoster;Override;

  public
    procedure TimerMsg(lbl:TLabel; const Value: String; Secondstoshow: Integer=5; msgColor:TColor = clred);Override;
  end;


implementation

uses Commonlib,systemlib, AppEnvironment,Math, StoredProcedures, tcDataUtils,dateutils,
  tcConst, MySQLConst, CommonDbLib,  ManufactureLib;

{$R *.dfm}
function TfmRosterWithManProcess.EmployeeCanDoProcessStep(EmployeeID,ProcessStepId:Integer):boolean;
begin

  CloseDB(qryEmployeeProcessStep);
  qryEmployeeProcessStep.PArambyname('EmployeeID').asInteger := employeeID;
  qryEmployeeProcessStep.PArambyname('processstepId').asInteger := ProcessStepId;
  qryEmployeeProcessStep.Open;
  result := qryEmployeeProcessStep.fieldbyname('ctr').asInteger >0;
end;

procedure TfmRosterWithManProcess.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  WriteGuiPref;
  inherited;
end;

procedure TfmRosterWithManProcess.FormCreate(Sender: TObject);
begin
  inherited;
  CreateSP('ProcessPartStatusToUserStr');
end;

procedure TfmRosterWithManProcess.FormShow(Sender: TObject);
begin
  inherited;
  try
  if (qryResources.RecordCount = 0) then Exit;
  ReadGuiPref;
  ChkHideNonMan.Visible := Devmode;
  lblHideNonMan.Visible := Devmode;
  finally

  end;
end;

procedure TfmRosterWithManProcess.grdProcessesCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if qryProcessesrosteredinseconds.asinteger > qryProcessesDurationinSeconds.AsInteger then AFont.Color := clred;
end;

procedure TfmRosterWithManProcess.Horizontal1Moved(Sender: TObject);
begin
  inherited;
  grdProcesses.top := 20;
  grdProcesses.Height := pnlbottom.height -20;
end;

procedure TfmRosterWithManProcess.InitItemProperties(ItemProperties: TItemProperties; Fields: TFields);
begin
  inherited;
  TManufactureRosterItem(ItemProperties).ProcesstimeId :=Fields.FieldByName('ProcesstimeId').AsInteger;
end;

function TfmRosterWithManProcess.NewItemProperty: TItemProperties;
begin
  REsult := TManufactureRosterItem.Create;
end;

procedure TfmRosterWithManProcess.qryProcessesAfterOpen(DataSet: TDataSet);
begin
  inherited;
  qryProcessesTimeStart.DisplayFormat := 'hh:nn:ss am/pm';
  qryProcessesTimeEnd.DisplayFormat   := 'hh:nn:ss am/pm';
end;

procedure TfmRosterWithManProcess.qryProcessesBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryProcessesTimeStart.DisplayFormat:= FormatSettings.ShortDateformat;
  qryProcessesTimeEnd.DisplayFormat:= FormatSettings.ShortDateformat;
end;
procedure TfmRosterWithManProcess.qryProcessesCalcFields(DataSet: TDataSet);
begin
  inherited;
  qryProcessesScheduledDate.AsDateTime := Dateof(qryProcessesTimeStart.AsDateTime);
end;

procedure TfmRosterWithManProcess.OnSelectemployee(Sender:TObject);
var
  EmployeeID:Integer;
  ProcessStepID:Integer;
begin
  if not(Sender is  TMenuItem) then exit;
  EmployeeID:= TMenuItem(Sender).Tag;
  ProcessStepId :=    qryProcessesProcessStepID.asInteger;
  if (EmployeeId =0) or (ProcessStepId =0) then exit;
  if not EmployeeCanDoProcessStep(EmployeeID,ProcessStepId) then begin
    MessageDlgXP_Vista(TMenuItem(Sender).Caption +' Cannot do ' +qryProcessesProcesstep.asString  , mtWarning, [mbOK], 0);
    Exit;
  end;
  if not qryResources.Locate('EmployeeID' , EmployeeId , []) then begin
    MessageDlgXP_Vista(' Employee ' +qryResources.fieldbyname('employeeId').asString+' is not in roster'  , mtWarning, [mbOK], 0);
    Exit;
  end;
  SelectDate(qryProcessesTimeStart.asDateTime);
  DoAllocate(employeeID);
  RefreshPocessItemonmenu;
end;
Procedure TfmRosterWithManProcess.RefreshPocessItemonmenu;
var
    x,y:Integer;
begin
  for x:= 0 to popupmenu.items.count-1 do
    if sametext(replacestr(popupmenu.items[x].caption,'&' , ''), QryprocessesResource.asString ) then
        for y:= 0 to popupmenu.items[x].count -1 do
          if popupmenu.items[x].Items[y].Tag = qryprocessesProcessTimeId.AsInteger then begin
              popupmenu.items[x].Items[y].checked :=qryprocessessrostered.AsString <> '';
              exit;
          end;
end;
procedure TfmRosterWithManProcess.plannerWeekItemDblClick(Sender: TObject;  Item: TPlannerItem);
begin
  inherited;
  if Item.Id <> 0 then
    if qryWeekRoster.Locate('RosterID' , Item.ID , []) then
      qryProcesses.Locate('ProcessTimeId' , qryWeekRosterProcessTimeId.asInteger ,[]);
end;
Function TfmRosterWithManProcess.LockCapacityplanner:boolean;
begin
  result := true;
  if not ManufactureLib.LockCapacityplanner(Userlock, titleLabel.Caption , 'Reschedule the task') then begin
        AccessLevel := 5;
        result:= False;
  end else begin
        self.BeginTransaction;
  end;
end;
procedure TfmRosterWithManProcess.plannerWeekItemMoving(Sender: TObject;
  Item: TPlannerItem; DeltaBegin, DeltaPos: Integer; var Allow: Boolean);
begin
  if not(ProcessItem(Item) ) then begin
    inherited;
    exit;
  end;
  if not bAllowMove then begin
    If not(LockCapacityplanner) then begin
        Allow:= False;
       exit;
    end;
    if ProcessItem(Item) then


    inherited;
  end;
end;
function TfmRosterWithManProcess.ProcessItem(Const item: TPlannerItem): boolean;
begin
   result:= False;
   if qryWeekRoster.Locate('RosterID' , Item.ID , []) then
    Result := Sametext(qryWeekRosterTypeCatagory.asString , 'ProcessStep');
end;

procedure TfmRosterWithManProcess.popProcessesPopup(Sender: TObject);
begin
  inherited;
  Populateemployeemenu(qryProcessesProcessStepID.asInteger);
end;

procedure TfmRosterWithManProcess.chkHideNonManClick(Sender: TObject);
begin
  inherited;
  if screen.ActiveControl <> chkHideNonMan then exit;
  if qryWeekRoster.active then qryWeekRoster.Close;
  qryWeekRoster.open;
  WeekSource.UpdatePlanner;
end;

procedure TfmRosterWithManProcess.Deleteroster(planner: TDBPlanner;Item: TPlannerItem);
var
  ProcessTimeID:Integer;
begin
  ProcessTimeID :=TManufactureRosterItem(Item.ItemObject).ProcesstimeId;
  inherited;
  if ProcessTimeID <> 0 then
    updateProcesstime(ProcessTimeID);
end;

Procedure TfmRosterWithManProcess.DoAllocate(EmployeeID:Integer);
  var
    pItem: PItemRec;
    planner: TDBPlanner;
    fiSecs:integer;
    Scheduledto, dt:TDateTime;
begin
  if qryWeekRoster.Active = False then qryWeekRoster.Open; // just in case

  if qryWeekRoster.locate('EmployeeId;ProcesstimeID' , vararrayof([EmployeeID , qryProcessesProcessTimeId.AsInteger]) , []) then begin
    MessageDlgXP_Vista('Already Rostered for '+ getEmployeeName(EmployeeID) , mtInformation, [mbOK], 0);
    Exit;
  end;

  fiSecs := TimeAvailableforemp(EmployeeID , Dateof(qryProcessesTimeStart.asDateTime),Scheduledto);
  if fiSecs <=0 then begin
    MessageDlgXP_Vista(getEmployeeName(EmployeeID)  +' doesn''t have any time available for ' + formatdatetime(FormatSettings.shortdateformat ,qryProcessesTimeStart.asDateTime) +'.' , mtInformation, [mbOK], 0);
    Exit;
  end;

      Randomize;
      planner := GetPlanner;
      planner.Items.BeginUpdate;

            New(pItem);
            pItem^.EmployeeID := EmployeeID;
            pItem^.ItemType :=  'Sale#' +inttostr(qryProcessesSAleID.asInteger) +
                                  qryProcessesProducTName.asSTring +'->' +
                                  qryProcessesPtCaption.asString+'.' +
                                  qryProcessesProcesstep.asString;
            pItem^.ItemTypeCatagory := 'ProcessStep';
            dt:= Dateof(qryProcessesTimeStart.asDateTime) + TimeOf(AppEnv.CompanyPrefs.StartOfDay);

            if Scheduledto =0 then Scheduledto :=dt else
            if IncSecond(Scheduledto,1)< dt then Scheduledto :=dt else Scheduledto := IncSecond(Scheduledto,1);

            pItem^.StartTime := Scheduledto;

            if  qryProcessesDurationinSeconds.asInteger < fiSecs then
              pItem.EndTime := IncSecond(pItem^.StartTime , qryProcessesDurationinSeconds.asInteger)
            else
              pItem.EndTime := IncSecond(pItem^.StartTime , fisecs);
            pItem^.PlannerID := AppEnv.DefaultClass.DefaultClassName + FormatDateTime('yy:m:d:h:n:s:z:', Now()) ;
            pItem^.IsClocked := 'F';
            pItem^.ClockedOff := 'F';
            pItem^.ClassID := qryProcessesClassId.asInteger ;


        qryWeekRoster.Insert;
        with qryWeekRoster do begin
          FieldByName('EmployeeID').AsInteger     := pItem^.EmployeeID;
          FieldByName('PlannerID').AsString       := pItem^.PlannerID;
          FieldByName('Type').AsString            := pItem^.ItemType;
          FieldByName('TypeCatagory').AsString    := pItem^.ItemTypeCatagory;
          FieldByName('ClockedOff').AsString      := pItem^.ClockedOff;
          FieldByName('ClassID').AsInteger        := pItem^.ClassID;
          FieldByName('IsClocked').AsString       := pItem^.IsClocked;
          FieldByName('StartTime').AsDateTime     := pItem^.StartTime;
          FieldByName('EndTime').AsDateTime       := pItem^.EndTime;
          FieldByName('Hours').AsFloat            := HourSpan(FieldByName('EndTime').AsDateTime, FieldByName('StartTime').AsDateTime);
          FieldByName('Hours').AsFloat            := RoundTo(FieldByName('Hours').AsFloat, - 3);
          FieldByName('ProcesstimeID').AsInteger  := qryProcessesProcessTimeId.AsInteger;
          FieldByName('Date').AsDateTime          := Trunc(FieldByName('StartTime').AsDateTime);
          Post;
        end;
      planner.Items.EndUpdate;
      planner.Items.UnSelectAll;
      DaySource.SynchDBItems;
      WeekSource.SynchDBItems;
      if qryProcesses.Active then  qryProcesses.Close;
      qryProcesses.Open;
end;
Function TfmRosterWithManProcess.TimeAvailableforemp(EmployeeID:Integer; dt:TDate; var Scheduledto :Tdatetime):Integer;
begin
  with TempMyQuery(TERPConnection(Qryweekroster.connection)) do try
    SQL.add('select sum(TIME_TO_SEC(TIMEDIFF(Endtime, starttime))) secs , Max(Endtime) Endtime from tblroster where employeeId = ' +inttostr(employeeID) +' and Date = '+ Quotedstr(formatdateTime(MysqlDateFormat , dt)));
    open;
    result:= fieldbyname('Secs').AsInteger;
    ScheduledTo:= fieldbyname('Endtime').AsDateTime;
  finally
    closenFree;
  end;
       if result >= trunc(Appenv.CompanyPrefs.HoursinaDay*60*60) then result := 0
  else result:= trunc(Appenv.CompanyPrefs.HoursinaDay*60*60)- result;
end;

procedure TfmRosterWithManProcess.SelectDate(Procesdate:TDateTime);
var
  planner: TDBPlanner;
begin
  planner := GetPlanner;
  if dateof(dtpMonth.Date) = Dateof(Procesdate) then exit;
  if (planner = plannerWeek) then
    if (Dateof(Procesdate) >= dateof(dtpMonth.Date)) and  (Dateof(Procesdate) <= dateof(incday(dtpMonth.Date,6)))  then exit;
  dtpMonth.date :=Dateof(Procesdate);
end;
function TfmRosterWithManProcess.Processtimefordate(ProcessPartID:Integer;const Dt:TDate):Boolean;
var
  ProctimeID:Integer;
begin
  REsult:= False;
  With TempMyquery do try
    connection := QryWeekroster.connection;
    SQL.add('Select ProcessTimeID from tblprocesstime Where processpartID = ' +inttostr(ProcessPartID) +' and  DATE(Timestart) = ' +Quotedstr(formatDateTime(MySQLDateFormat , dt)));
    open;
    if recordcount =0 then exit;
    ProctimeID := FieldByname('ProcessTimeID').asInteger;
  finally
    closenFree;
  end;
  ProcessTime(ProctimeID);
  result:= QryProcessTime.recordcount>0;
end;
function TfmRosterWithManProcess.ProcessTime(const ProcesstimeID:Integer):TERPQuery;
begin
  try
      closedb(QryProcessTime);
      QryProcessTime.Parambyname('ProcesstimeID').AsInteger := ProcesstimeID;
      QryProcessTime.Connection := qryWeekRoster.Connection;
      QryProcessTime.Open;
  finally
    result:= QryProcessTime;
  end;
end;

procedure TfmRosterWithManProcess.SourceItemToFields(Sender: TObject; Fields: TFields; Item: TPlannerItem);
var
  ProcesspartID:Integer;
  OldProcessTimeID:Integer;
begin
try
  inherited;
  OldProcessTimeID:=0;
  if Processitem(Item) then begin
    ProcessTime(qryWeekRosterProcessTimeId.AsInteger);
      if QryProcessTime.recordcount=0 then exit;// this shouldn't happen
      ProcesspartID := QryProcessTime.Fieldbyname('ProcesspartID').AsInteger;

      if Dateof(QryProcessTime.fieldbyname('timestart').AsDateTime) <> dateof(qryWeekRosterStartTime.AsDateTime) then begin   // moved the date
        if not(Processtimefordate(ProcesspartID , Dateof(qryWeekRosterStartTime.AsDateTime))) then begin
          OldProcessTimeID:=qryWeekRosterProcessTimeId.AsInteger;
          QryProcessTime.Append;
          QryProcessTime.Fieldbyname('ProcesspartID').AsInteger:= ProcesspartID;
          QryProcessTime.Post;
        end;
        editDb(qryWeekRoster);
        qryWeekRosterProcesstimeID.asInteger := QryProcessTime.fieldbyname('ProcesstimeID').asInteger;
        PostDb(qryWeekRoster);
        ProcessTime(qryWeekRosterProcessTimeId.AsInteger);
      end;
      updateProcesstime(QryProcessTime.fieldbyname('ProcesstimeID').asInteger);
      if OldProcessTimeID <> 0 then updateProcesstime(OldProcessTimeID);
  end;
finally
  EditDB(qryWeekRoster);
end;
end;
procedure TfmRosterWithManProcess.TimerMsg(lbl: TLabel; const Value: String;  Secondstoshow: Integer; msgColor: TColor);
begin
  lbl.Top := Self.Height - lbl.Height;
  inherited TimerMsg(lbl,Value,Secondstoshow,msgColor);
end;

procedure TfmRosterWithManProcess.updateProcesstime(const ProcessTimeID:Integer);
var
  bm:TBookmark;
begin
  inherited;

  bm:= Qryprocesses.GetBookmark;
  try
    if Qryprocesses.active then Qryprocesses.close;
    Qryprocesses.open;
    if ProcessTimeID <> 0 then begin
      if Qryprocesses.Locate('ProcessTimeID' , ProcessTimeID , []) then
        RefreshPocessItemonmenu;
    end;
  finally
    Qryprocesses.gotobookmark(bm);
    Qryprocesses.FreeBookmark(bm);
  end;
end;

procedure TfmRosterWithManProcess.WriteGuiPref;
begin
  GuiPrefs.Node['Options.pnlbottomheight'].asInteger      := pnlBottom.height ;
  GuiPrefs.Node['Options.ImageStrech'].AsString        := BooleanToStr(chkHideNonMan.Checked );
  GuiPrefs.Node['Options.Maximised'].AsString        := BooleanToStr(WindowState=wsMaximized );
end;
procedure TfmRosterWithManProcess.ReadGuipref;
begin
  if GUIPrefs.Active =False then GUIPrefs.Active:= true;
  if StrToBoolean(GuiPrefs.Node['Options.Maximised'].AsString)  then WindowState := wsMaximized;
  if GuiPrefs.Node['Options.pnlbottomheight'].asInteger > 0     then pnlBottom.Height  := GuiPrefs.Node['Options.pnlbottomheight'].asInteger;
  chkHideNonMan.Checked  := StrToBoolean(GuiPrefs.Node['Options.HideNonMan'].AsString);
  grdProcesses.top := 20;
  grdProcesses.Height := pnlbottom.height -20;
end;

procedure TfmRosterWithManProcess.qryResourcesAfterOpen(DataSet: TDataSet);
begin
  Populateemployeemenu;
end;
procedure TfmRosterWithManProcess.qryWeekRosterBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  qryWeekRoster.Parambyname('hidenonManroster').asString := BooleanToStr(chkHideNonMan.Checked);
end;
procedure TfmRosterWithManProcess.ResetRoster;

begin
  with qryWeekRoster do begin
    Close;

    DaySource.Active := False;
    WeekSource.Active := False;

    SQL.Clear;
    SQL.Add('Select RosterID, tblroster.GlobalRef, PlannerID, tblroster.Type, tblroster.EmployeeID,tblroster.Date,');
    SQL.Add('tblroster.ClassID, tblroster.Notes,tblroster.Hours,');
    SQL.Add('StartTime, EndTime, tblroster.EditedFlag, ClockedOff,TypeCatagory,IsClocked, ProcesstimeID');
    SQL.Add('FROM tblroster');
    SQL.Add('INNER JOIN tblEmployees using (EmployeeID)');
    SQL.Add('WHERE IsOnTheRoster = "T" and  Active="T" ');
    SQL.Add('and  (Type <> "Clocked" or (Type = "Clocked" and ClockedOff = "T"))');
    if chkClasses.Checked <> True then
      SQL.Add(' and ClassID = ' + IntToStr(qryClasses.FieldByName('ClassID').AsInteger));
    SQL.Add('and (ifnull(ProcesstimeID,0) <> 0 or :hidenonManroster="F")');
    Open;

    DaySource.Active := True;
    WeekSource.Active := True;
    plannerweek.Refresh;
  end;
end;

procedure TfmRosterWithManProcess.Populateemployeemenu(ProcesStepID:Integer =0);
var
  mnu :TmenuItem;
begin
  inherited;
   popProcesses.Items.Clear;
   CloseDB(qryEmployees);
   qryEmployees.Parambyname('ProcessStepID').asInteger :=ProcesStepID;
   OpenDB(qryEmployees);
   if qryEmployees.recordcount =0 then begin
    TimerMsg(lblTmrMsg , Quotedstr(getProcessStep(ProcesStepID)) +' has no employees.  Please add employees for this process step to roster it');
    exit;
   end;
   qryEmployees.first;
   while qryEmployees.eof = False do begin
    mnu := TMenuItem.Create(self);
    mnu.Caption :=qryEmployees.FieldByname('EmployeeName').asString;
    mnu.Tag:=qryEmployees.FieldByname('EmployeeID').asInteger;
    mnu.OnClick := OnSelectemployee;
    mnu.Enabled := Accesslevel =1 ;
    popProcesses.Items.Add(mnu);
    qryEmployees.Next;
   end;
end;

procedure TfmRosterWithManProcess.PopupMenuPlannerItemPopup(Sender: TObject);
var
  i: integer;
begin
  inherited;
  if Assigned(SelectedItem) then
      for i := 3 to PopupMenuPlannerItem.Items.count-1 do
        PopupMenuPlannerItem.Items[i].Enabled := not(ProcessItem(SelectedItem));
end;

procedure TfmRosterWithManProcess.PopulateClassGrids;
begin
  inherited;
  LoadResources;
end;
procedure TfmRosterWithManProcess.LoadResources;
var
  MenuItem         : TMenuItem;
  st: TStringlist;
  ctr:Integer;
  s:String;
begin
  if qryProcesses.RecordCount > 0 then begin

    MenuItem         := TMenuItem.Create(self);
    MenuItem.Caption := '-';
    PopupMenu.Items.Add(MenuItem);

    st:= TStringlist.Create;
    try
      st.QuoteChar:= '''';
      s := qryProcesses.GroupConcat('Resource' , '' , False, ',', '','',true, True);
      st.DelimitedText:= s;
      for ctr:= 0 to st.Count-1 do begin
        if st[ctr]<> '' then begin
          MenuItem         := TMenuItem.Create(self);
          MenuItem.Caption := st[ctr];
          MenuItem.OnClick :=nil;
          PopupMenu.Items.Add(MenuItem);
          LoadResourceProcesses(MenuItem);
        end;
      end;
    finally
      Freeandnil(st);
    end;
  end;
end;

procedure TfmRosterWithManProcess.LoadResourceProcesses(ParentMenuItem : TMenuItem);
var
  MenuItem         : TMenuItem;
  fsFilter:String;
  bm:TBookmark;
begin
  ParentMenuItem.Clear;
  if Qryprocesses.recordcount =0 then exit;
  fsFilter:= Qryprocesses.Filter;
  Qryprocesses.DisableControls;
  try
    bm:= Qryprocesses.GetBookmark;
    try
      if Qryprocesses.filter <> '' then Qryprocesses.filter := '(' +Qryprocesses.Filter +') and ';
      Qryprocesses.Filter := Qryprocesses.filter +'(Resource = ' +quotedstr(ParentMenuItem.Caption)+')';
      Qryprocesses.filtered := Qryprocesses.filter <> '';
      if Qryprocesses.recordcount > 0 then begin
        Qryprocesses.first;
        while Qryprocesses.EOF =False do begin
          MenuItem         := TMenuItem.Create(self);
          MenuItem.Caption := inttostr(QryprocessesSaleID.AsInteger) +'->' + qryprocessesProductname.AsString +'.' + QryprocessesptCaption.AsString +' : ' + QryprocessessDuration.AsString;
          MenuItem.checked := Qryprocessessrostered.asString <> '';
          MenuItem.Tag     := QryprocessesProcessTimeId.AsInteger;
          MenuItem.OnClick := OnSelectProcess;
          ParentMenuItem.Add(MenuItem);
          LoadEmployees(MenuItem);
          Qryprocesses.Next;
        end;
      end;
    finally
      Qryprocesses.Filter := fsFilter;
      Qryprocesses.filtered := fsFilter <> '';
      Qryprocesses.GotoBookmark(bm);
      Qryprocesses.FreeBookmark(bm);
    end;
  finally
    Qryprocesses.EnableControls;
  end;
end;

procedure TfmRosterWithManProcess.OnSelectProcess(Sender :TObject);
begin
  Qryprocesses.Locate('ProcessTimeId' , TmenuItem(Sender).tag , []);
end;

procedure TfmRosterWithManProcess.LoadEmployees(Sender:TObject);
var
  mnu :TmenuItem;
begin
  inherited;
  if not(Sender is TmenuItem) then exit;
   TmenuItem(Sender).Clear;
    CloseDB(qryEmployees);
    qryEmployees.Parambyname('ProcessStepID').asInteger :=qryProcessesProcessStepID.asInteger;
    OpenDB(qryEmployees);
    if qryEmployees.recordcount =0 then
    else begin
       qryEmployees.first;

       while qryEmployees.eof = False do begin
        mnu := TMenuItem.Create(self);
        mnu.Caption :=qryEmployees.FieldByname('EmployeeName').asString;
        mnu.Tag:=qryEmployees.FieldByname('EmployeeID').asInteger;
        mnu.OnClick := OnSelectemployee;
        mnu.Enabled := Accesslevel =1 ;
        TmenuItem(Sender).Add(mnu);
        qryEmployees.Next;
       end;
  end;
end;
initialization
  RegisterClassOnce(TfmRosterWithManProcess);

end.

