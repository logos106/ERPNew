unit frmProjectInstallationRoster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, wwdbdatetimepicker, DNMSpeedButton, StdCtrls,
  wwdblook, Shader, ExtCtrls, DNMPanel, DB, ProgressDialog, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  Planner, SelectionDialog, Menus, frmProjectInstallation, Spin;

type
  TProcIterateMonths = Procedure (Value : TfmProjectInstallation; var Abort :Boolean) of object;

  TfmProjectInstallationRoster = class(TBaseInputGUI)
    qryClasses: TERPQuery;
    qryClassesClassID: TIntegerField;
    qryClassesClassName: TWideStringField;
    DNMPanel3: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    pnlClass: TDNMPanel;
    chkClasses: TCheckBox;
    cboClass: TwwDBLookupCombo;
    pnldate: TDNMPanel;
    btnPrevMonth: TDNMSpeedButton;
    dtpMonth: TwwDBDateTimePicker;
    btnNextMonth: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    btnSave: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    btnDay: TDNMSpeedButton;
    btnWeek: TDNMSpeedButton;
    btnMonth: TDNMSpeedButton;
    pnlhints: TPanel;
    Shader2: TShader;
    pnlAptcolor: TLabel;
    Shader3: TShader;
    pnlWeekend: TLabel;
    Shader4: TShader;
    pnlLeave: TLabel;
    Shader5: TShader;
    pnlHoliday: TLabel;
    Shader6: TShader;
    pnlGrpAptcolor: TLabel;
    Shader1: TShader;
    pnlSelected: TLabel;
    Shader7: TShader;
    pnltoday: TLabel;
    Scrollbox: TScrollBox;
    lblMsg: TLabel;
    qryEmployees: TERPQuery;
    qryEmployeesemployeeId: TIntegerField;
    qryEmployeesemployeeName: TWideStringField;
    btnRequery: TDNMSpeedButton;
    Memo1: TMemo;
    report2n3: TSplitter;
    pnlRowHeight: TDNMPanel;
    Label2: TLabel;
    shpRowHeight: TShape;
    btnDecRowHeight: TDNMSpeedButton;
    btnIncRowHeight: TDNMSpeedButton;
    pnlResize: TDNMPanel;
    Label3: TLabel;
    shpResize: TShape;
    btnDecHeight: TDNMSpeedButton;
    btnIncHeight: TDNMSpeedButton;
    pnlMonths: TDNMPanel;
    Label1: TLabel;
    edtMonths: TSpinEdit;
    shpMonths: TShape;
    shpdate: TShape;
    shpClass: TShape;
    procedure btnPrevMonthClick(Sender: TObject);
    procedure btnNextMonthClick(Sender: TObject);
    procedure dtpMonthChange(Sender: TObject);
    procedure chkClassesClick(Sender: TObject);
    procedure cboClassCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet;
      modified: Boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDayClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure btnRequeryClick(Sender: TObject);
    procedure edtMonthsChange(Sender: TObject);
    procedure btnIncRowHeightClick(Sender: TObject);
    procedure btnDecRowHeightClick(Sender: TObject);
    procedure btnIncHeightClick(Sender: TObject);
    procedure btnDecHeightClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    ProjectInstallationMonths : Array [1..6] of TfmProjectInstallation;
    DayFocused :Boolean;
    WeekFocused :Boolean;
    MonthFocused :Boolean;
    fbIsDirty:Boolean;
    fFocusedPanel:TPanel;
    fiEmpIDForAppt:Integer;
    FirstSelectedItem: TPlannerItem;
    itemsingroup:Integer;
    fbOKToSelect :Boolean;
    aItem: TPlannerItem;
    fiMonths: Integer;
    fdStartDate: TDateTime;
    Procedure RefreshQuery;
    procedure OnClasschange;
    procedure CalendarAfterShow(Sender: TObject);
    procedure InitCalendar(Sender: TObject);
    Procedure InitPlanners;
    Procedure IterateMonths(ProcIterateMonths:TProcIterateMonths; ApplyIfvisible:Boolean);
    Procedure ReadGuipref(Plannerform: TfmProjectInstallation;var Abort :Boolean);
    Procedure WriteGuipref(Plannerform: TfmProjectInstallation;var Abort :Boolean);
    procedure Printplanner(Plannerform: TfmProjectInstallation;var Abort :Boolean);
    procedure dateChange(Plannerform: TfmProjectInstallation;var Abort :Boolean);
    procedure ISOKToSelectCallback(Plannerform: TfmProjectInstallation;var Abort :Boolean);
    procedure DecHeights(Plannerform: TfmProjectInstallation;var Abort :Boolean);
    procedure IncHeights(Plannerform: TfmProjectInstallation;var Abort :Boolean);
    procedure DecRowHeights(Plannerform: TfmProjectInstallation;var Abort :Boolean);
    procedure IncRowHeights(Plannerform: TfmProjectInstallation;var Abort :Boolean);


    procedure CheckIsDirty(Plannerform: TfmProjectInstallation;var Abort :Boolean);
    procedure WriteIsDirty(Plannerform: TfmProjectInstallation;var Abort :Boolean);
    procedure SelectmainAptCallback(Plannerform: TfmProjectInstallation;var Abort :Boolean);

    procedure Refreshmonth(Plannerform: TfmProjectInstallation;var Abort :Boolean);
    procedure checkFocusedItem(Plannerform: TfmProjectInstallation;var Abort :Boolean);
    procedure UnselectAllCallback(Plannerform: TfmProjectInstallation;var Abort :Boolean);

    procedure ShowForm(Plannerform: TfmProjectInstallation;var Abort :Boolean);
    procedure DatesSelectedCallback(Plannerform: TfmProjectInstallation;var Abort :Boolean);
    //procedure MakeLeavesCallback(Plannerform: TfmProjectInstallation;var Abort :Boolean);
    procedure FindFirstSelectedItem(Plannerform: TfmProjectInstallation;var Abort :Boolean);
    procedure SelectAllintheGroupCallback(Plannerform: TfmProjectInstallation;var Abort :Boolean);

    Procedure ReadGuiprefs;
    Procedure WriteGuiprefs;
    procedure SetISDirty(const Value: Boolean);
    function getIsDirty: Boolean;
    procedure Showforms;
    procedure DatesSelected(Item: TPlannerItem);
    //procedure MakeLeave(Item: TPlannerItem);

    procedure InitApptGroupAptdates(Sender: TObject);
    procedure SelectItemintheGroup(Item: TPlannerItem);
    procedure ReScheduleAppt(ApptID:Integer; iDaysToreschedule :Integer; iEmployeeID:Integer; UpdateLinkedAppointmentsonReschedule:Boolean);
    procedure setMonths(const Value: Integer);
    procedure setStartDate(const Value: TDateTime);
    procedure SetPanelsSize;
    Property IsDirty:Boolean read getIsDirty write SetISDirty;
    Function FocusedPanel:TPanel;
    function WeekEmployeeID(Item: TPlannerItem): Integer;
    function EmpOnLeave(const iEmployeeID:Integer; fDate:TDateTime):Boolean;
    function Userconfimdates(const ActionMsg:String) :Boolean;
  public
    fDatesSelected:Array of TDateTime;
    CreateIfWorkingDay :Boolean;
    curGroupId:Integer;
    Procedure TimerMsg(const Value:String);Overload;
    Procedure MakeAppointments;
    //Procedure MakeLeaves;
    Procedure SelectAllIntheGroup;
    Procedure UnselectAll;
    Procedure RescheduleAppointment(Item: TPlannerItem);
    Procedure SelectmainApt;
    function ISOKToSelect(Item: TPlannerItem): Boolean;
    Procedure ItemSelected(Plannerform: TfmProjectInstallation;Item: TPlannerItem; Selected :Boolean);
    Property Months :Integer read fiMonths write setMonths;
    Property StartDate :TDateTime read fdStartDate write setStartDate;
  end;


implementation

uses CommonLib, frmCalendar , DateUtils, CommonFormLib, PlannerLib,
  ManufactureLib, frmAppointments, DbSharedObjectsObj, MySQLConst, tcDataUtils,dbplanner,
  BusObjEmployeeLeaveRequests, frmSelectedDates, tcConst, frmDateSelectDialog,
  BusObjAppointments;

{$R *.dfm}

procedure TfmProjectInstallationRoster.btnCancelClick(Sender: TObject);
begin
  inherited;
  if fsModal in FormState then begin
    ModalResult := mrCancel;
  end else begin
    Close;
  end;

end;

procedure TfmProjectInstallationRoster.btnDayClick(Sender: TObject);
begin
  inherited;
  DayFocused := btnDay.Focused;
  WeekFocused := btnWeek.Focused;
  MonthFocused := btnMonth.Focused;
  if openERPform('TCalendarGUI' , 0 , CalendarAfterShow, InitCalendar) then
    Self.Close;

end;



procedure TfmProjectInstallationRoster.btnNextMonthClick(Sender: TObject);
begin
  inherited;
  Processingcursor(True);
  try
  dtpMonth.Date := incMonth(dtpMonth.Date , +1);
  RefreshQuery;
  finally
    ProcessingCursor(False);
  end;
end;

procedure TfmProjectInstallationRoster.btnPrevMonthClick(Sender: TObject);
begin
  inherited;
  Processingcursor(True);
  try
    dtpMonth.Date := incMonth(dtpMonth.Date , -1);
    RefreshQuery;
  finally
    ProcessingCursor(False);
  end;
end;
procedure TfmProjectInstallationRoster.Printplanner(Plannerform :TfmProjectInstallation;var Abort :Boolean);
begin
    Plannerform.Planner1.Printoptions.SidebarWidth :=Plannerform.Planner1.Sidebar.Width;
    if devmode then begin
      Plannerform.Planner1.Printoptions.header.clear;
      Plannerform.Planner1.Printoptions.Header.add(TitleLabel.caption);
      Plannerform.Planner1.Printoptions.Header.add('For the month of ' +  FormatDateTime('mmmm yyyy', Plannerform.startDate)) ;
      Plannerform.Planner1.Printoptions.LineWidth := 0;//CustomInputInteger('Line Width' , '' , inttostr(Plannerform.Planner1.Printoptions.LineWidth));
      Plannerform.Planner1.Printoptions.HeaderSize :=400;{main header at the top}
      Plannerform.Planner1.Printoptions.Sidebarwidth :=200;{header height}
      Plannerform.Planner1.Printoptions.Cellheight :=Plannerform.MaxItemPerCell*70; {each line height}
    end;
    Plannerform.Planner1.Print;
end;
procedure TfmProjectInstallationRoster.btnPrintClick(Sender: TObject);
begin
  inherited;
    IterateMonths(Printplanner, true);
end;

procedure TfmProjectInstallationRoster.btnRequeryClick(Sender: TObject);
begin
  inherited;
  RefreshQuery;
end;

procedure TfmProjectInstallationRoster.btnSaveClick(Sender: TObject);
begin
  inherited;
  CommitTransaction;
  IsDirty := False;
  Self.Close;

end;

procedure TfmProjectInstallationRoster.CalendarAfterShow(Sender: TObject);
begin
  if not(Sender is TCalendarGUI) then exit;
       if DayFocused then begin TCalendarGUI(sender).Pagecontrol1.ActivePage := TCalendarGUI(sender).tabsheet1;
  end else if WeekFocused then begin TCalendarGUI(sender).Pagecontrol1.ActivePage := TCalendarGUI(sender).tabsheet2;
  end else if MonthFocused then begin TCalendarGUI(sender).Pagecontrol1.ActivePage := TCalendarGUI(sender).tabsheet3;
  end else begin
    exit;
  end;
  TCalendarGUI(sender).PageControl1Change(TCalendarGUI(sender).PageControl1);
end;

procedure TfmProjectInstallationRoster.cboClassCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  OnClassChange;
end;

procedure TfmProjectInstallationRoster.CheckIsDirty(Plannerform: TfmProjectInstallation;var Abort :Boolean);
begin
  if Plannerform.IsDirty then fbIsdirty := True;
end;

procedure TfmProjectInstallationRoster.chkClassesClick(Sender: TObject);
begin
  inherited;
  OnClassChange;
end;

procedure TfmProjectInstallationRoster.dateChange(Plannerform: TfmProjectInstallation;var Abort :Boolean);
begin
  Plannerform.BaseDate := dtpMonth.Date;
  Plannerform.Allclasses := chkclasses.Checked;
  Plannerform.ClassId := qryClassesClassID.AsInteger;
end;

(*Function TfmProjectInstallation.DateFrom:TDateTime;
begin
  result := incday(Dateof(StartOfTheMonth(dtpMonth.Date)),-7);
  //result := Dateof(StartOfTheMonth(dtpMonth.Date));
end;
Function TfmProjectInstallation.DateTo:TDateTime;
begin
    //result := incSecond(incday(DateOf(EndOfTheMonth(dtpMonth.Date)),(Planner1.display.displayend-28)),-1);
    result :=  incSecond(incday(DateFrom , DAYS_IN_PLANNER +1), -1);
end;*)


procedure TfmProjectInstallationRoster.dtpMonthChange(Sender: TObject);
begin
  inherited;
  (*WeekSource.Month := MonthOfTheYear(dtpMonth.Date);
  WeekSource.Year := YearOf(dtpMonth.Date);
  WeekSource.UpdatePlanner;
  Planner1.Display.DisplayEnd := DAYS_IN_PLANNER;*)
  //IterateMonths(dateChange,true);
  RefreshQuery;
end;
procedure TfmProjectInstallationRoster.edtMonthsChange(Sender: TObject);
begin
  inherited;
  Months := edtMonths.Value;
end;

function TfmProjectInstallationRoster.EmpOnLeave(const iEmployeeID: Integer;  fDate: TDateTime): Boolean;
var
  Qry:TERpQuery;
begin
  Qry := DbSharedObj.GetQuery(Myconnection);
  try
    Qry.SQL.Text := 'Select * from tblemployeeleaverequests where EmployeeId = ' + inttostr(iEmployeeID) +' and LeaveDate = '+QuotedStr(formatdateTime(MysqlDateFormat , fDate))+' and Active ="T"';
    Qry.Open;
    REsult := Qry.fieldByname('ID').AsInteger <>0;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;

end;

procedure TfmProjectInstallationRoster.checkFocusedItem(Plannerform: TfmProjectInstallation;var Abort :Boolean);
begin
  if (Screen.activecontrol = Plannerform.Planner1) or (Screen.activecontrol.Owner = Plannerform.Planner1) then begin
    fFocusedPanel := Plannerform.pnlMain;
    Abort := True;
  end;
end;
function TfmProjectInstallationRoster.FocusedPanel: TPanel;
begin
  fFocusedPanel := nil;
  iterateMonths(checkFocusedItem,true);
  Result := fFocusedPanel;
end;

procedure TfmProjectInstallationRoster.FormActivate(Sender: TObject);
begin
  inherited;
  Windowstate := wsMaximized;
end;

procedure TfmProjectInstallationRoster.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  WriteGuiprefs;
  inherited;
  action := caFree;
end;

procedure TfmProjectInstallationRoster.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if IsDirty then begin
      case CommonLib.MessageDlgXP_Vista('Do You Wish To Keep These Changes You Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
      mrYes:
        begin
            CommitAndNotify;
            CanClose := true;
            IsDirty := false;
        end;
      mrNo:
        begin
          // Cancel edits and Rollback changes
          RollbackTransaction;
          IsDirty:= false;
          CanClose := true;
        end;
      mrCancel:
        begin
          CanClose := false;
        end;
    end;
  end;
  inherited;

end;

procedure TfmProjectInstallationRoster.FormCreate(Sender: TObject);
var
  Index:Integer;
begin
  inherited;

    pnlAptcolor.color     := CL_Appointment;
    pnlGrpAptcolor.color  := CL_GRPAppointment;
    pnlWeekend.color      := CL_Weekend;
    pnlHoliday.color      := CL_Holiday;
    pnlLeave.color        := CL_Leave;
    pnlSelected.color     := CL_Select;
    pnltoday.color        := CL_Today;

    pnlAptcolor.Parentcolor     := False;
    pnlGrpAptcolor.Parentcolor  := False;
    pnlWeekend.Parentcolor      := False;
    pnlHoliday.Parentcolor      := False;
    pnlLeave.Parentcolor        := False;
    pnlSelected.Parentcolor     := False;
    pnltoday.Parentcolor        := False;


    pnlAptcolor.Transparent     := False;
    pnlGrpAptcolor.Transparent  := False;
    pnlWeekend.Transparent      := False;
    pnlHoliday.Transparent      := False;
    pnlLeave.Transparent        := False;
    pnlSelected.Transparent     := False;
    pnltoday.Transparent        := False;
    pnlhints.Top := 0;

    for Index := 0 to ComponentCount - 1 do begin
      if (Components[Index] is TShader) and not(Components[Index].Name='TitleShader') then Begin
        TShader(Components[Index]).FromColor := CL_Border;
        TShader(Components[Index]).ToColorMirror := CL_Border;
        TShader(Components[Index]).ToColor := CL_Border;
        TShader(Components[Index]).FromColorMirror := CL_Border;
      end;
    end;
    SetPanelsSize;
    Memo1.Visible := Devmode;
end;
Procedure TfmProjectInstallationRoster.SetPanelsSize;
Procedure SizePanel(const Shape:TShape);
begin
  Shape.top := 0;
  Shape.left := 0;
  Shape.width := Shape.parent.width;
  Shape.height := Shape.parent.height;
end;
begin
  dtpMonth.top := btnPrevMonth.Top;
  dtpMonth.height := btnPrevMonth.height;
  dtpMonth.left := btnPrevMonth.left+btnPrevMonth.width+1;
  dtpMonth.Width := (btnNextMonth.left-1) -( btnPrevMonth.left+btnPrevMonth.width+1);

  SizePanel(shpResize);
  SizePanel(shpRowHeight);
  SizePanel(shpMonths);
  SizePanel(shpdate);
  SizePanel(shpClass);
end;
procedure TfmProjectInstallationRoster.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
    if FocusedPanel = nil then exit;
    if (ssShift in shift) and (ssAlt in shift) and (ssCtrl in Shift) then begin
           if key = VK_DOWN then fFocusedPanel.height := fFocusedPanel.height +1
      else if key = VK_UP   then fFocusedPanel.height := fFocusedPanel.height -1;
    end;
end;

procedure TfmProjectInstallationRoster.FormResize(Sender: TObject);
begin
  inherited;
  pnlTitle.left := trunc(pnlTitle.Parent.Width/2) -trunc(pnlTitle.Width/2);
  if pnlTitle.left > pnlMonths.Left - (pnlTitle.Width +10) then pnlTitle.left :=  pnlMonths.Left - (pnlTitle.Width +10);
  if pnlTitle.left <0 then pnlTitle.left := 0;
end;

procedure TfmProjectInstallationRoster.FormShow(Sender: TObject);
var
  ctr(*, iTop*):Integer;
begin
  inherited;
  //iTop := 0;
  OpenQueries;
  for ctr:=  high(ProjectInstallationMonths) downto low(ProjectInstallationMonths) do begin
    ProjectInstallationMonths[ctr] :=TfmProjectInstallation.ProjectInstallationInst(Self, ctr , IIF(CTR=low(ProjectInstallationMonths),True,False));
  end;
  ReadGuiprefs;
  InitPlanners;
  BeginTransaction;
  if startdate =0 then dtpMonth.Date := Date else dtpMonth.Date := Startdate;
  Showforms;
  unselectAll;
  //RefreshQuery;
end;
procedure TfmProjectInstallationRoster.ShowForm(Plannerform: TfmProjectInstallation;
  var Abort: Boolean);
begin
  Plannerform.Planner1.visible := True;
end;

procedure TfmProjectInstallationRoster.Showforms;
begin
  IterateMonths(Showform, true);
end;
procedure TfmProjectInstallationRoster.InitCalendar(Sender: TObject);
begin
  if not(Sender is TCalendarGUI) then exit;
  TCalendarGUI(sender).DatePicker1.Date := date;//StartOfTheMonth(dtpMonth.Date);
  TCalendarGUI(sender).dtpFromDate.Date := date;//StartOfTheMonth(dtpMonth.Date);
end;

procedure TfmProjectInstallationRoster.InitPlanners;
begin
  if (qryEmployees.RecordCount = 0) then begin
    CommonLib.MessageDlgXP_Vista('No Employee''s have been assigned to the Project Manager Roster.' + #13 + #10 + '' + #13 + #10 +
                                 'Please use Employee Screen To Add Each Employee To Project Manager Roster.', mtInformation, [mbOK], 0);
    Self.Close;
  end;
  //iterate planners
end;


function TfmProjectInstallationRoster.getIsDirty: Boolean;
begin
  fbIsDirty:=False;
  IterateMonths(CheckIsDirty, true);
  Result :=fbIsDirty;
end;

procedure TfmProjectInstallationRoster.ItemSelected(Plannerform: TfmProjectInstallation;Item: TPlannerItem;Selected: Boolean);
var
  s:String;
begin
  s:= FormatdateTime((*'dd-mm-yyyy'*)FormatSettings.ShortDateformat , TRosterItemProperties(item.ItemObject).Date)+'-'+ inttostr(Plannerform.Monthno) + '-' +TRosterItemProperties(item.ItemObject).TypeName +'-' +inttostr(integer(item));
  if Selected then begin
    if memo1.Lines.IndexOf(s) <0 then memo1.Lines.Add(s);
  end else begin
    if memo1.Lines.IndexOf(s) >=0 then memo1.Lines.delete(memo1.Lines.IndexOf(s));
  end;
end;

procedure TfmProjectInstallationRoster.IterateMonths(ProcIterateMonths:TProcIterateMonths; ApplyIfvisible:Boolean);
var
  ctr:Integer;
  Abort :Boolean;
begin
  Abort := false;
  for ctr := low(ProjectInstallationMonths) to high(ProjectInstallationMonths) do begin
    if not(ApplyIfvisible) or (ProjectInstallationMonths[ctr].pnlMain.Visible) then begin
      ProcIterateMonths(ProjectInstallationMonths[ctr] , abort );
      if Abort then Break;
    end;

  end;
end;
Procedure TfmProjectInstallationRoster.DatesSelected(Item: TPlannerItem);
begin
  if not(CreateIfWorkingDay) or (isworkingday(Dateof(item.ItemStartTime)) and Not(EmpOnLeave(WeekEmployeeID(Item), Dateof(item.ItemStartTime)) )) then begin
    if (fiEmpIDForAppt=0) or ( WeekEmployeeID(Item) = fiEmpIDForAppt) then begin
      SetLength(fDatesSelected , length(fDatesSelected)+1);
      fDatesSelected[high(fDatesSelected)] := Dateof(item.ItemStartTime);
      if fiEmpIDForAppt =0 then fiEmpIDForAppt := WeekEmployeeID(Item);
    end;
  end;
end;

procedure TfmProjectInstallationRoster.DatesSelectedCallback(Plannerform: TfmProjectInstallation;var Abort :Boolean);
begin
  IterateOnSelectedCells(Plannerform.Planner1 ,DatesSelected ,Plannerform.NewItemProperty);
end;


(*procedure TfmProjectInstallation.MakeLeaves;
begin
  try
    CreateIfWorkingDay :=  MessageDlgXP_Vista('Do you wish to exclude the Holidays and Weekend Days?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
    IterateMonths(MakeLeavesCallback, true);
    RefreshQuery;
  Except
    on E:Exception do begin
      MessageDlgXP_vista('e.message', mtWarning, [mbOK], 0);
    end;
  end;
end;
procedure TfmProjectInstallation.MakeLeavesCallback(Plannerform: TfmProjectInstallation; var Abort: Boolean);
begin
  IterateOnSelectedCells(Plannerform.Planner1 ,MakeLeave ,Plannerform.NewItemProperty);
end;

procedure TfmProjectInstallation.MakeLeave(Item: TPlannerItem);
var
  EmpLeaveRequests :TEmpLeaveRequests;
begin

  if (CreateIfWorkingDay) and (not(isworkingday(Dateof(item.ItemStartTime)))) then Exit;

  EmpLeaveRequests := TEmpLeaveRequests.CreateWithNewConn(Self);
  try
    EmpLeaveRequests.Connection.Connection := Self.MyConnection;
    EmpLeaveRequests.LoadSelect('employeeID =' + inttostr(WeekEmployeeID(Item))+' and LeaveDate =' + quotedstr(FormatdateTime(MysqlDateFormat ,Dateof(item.ItemStartTime))));
    if EmpLeaveRequests.count =0 then begin
      EmpLeaveRequests.Connection.BeginNestedTransaction;
      try
        EmpLeaveRequests.New;
        EmpLeaveRequests.EmployeeId := WeekEmployeeID(Item);
        EmpLeaveRequests.LeaveDate := Dateof(item.ItemStartTime);
        EmpLeaveRequests.Active := TRue;
        EmpLeaveRequests.PostDB;
        EmpLeaveRequests.Connection.CommitNestedTransaction;
      Except
        on E:Exception do begin
          EmpLeaveRequests.Connection.RollbackNestedTransaction;
        end;
      end;
    end;
  finally
    FreeandNil(EmpLeaveRequests);
  end;
end;*)



procedure TfmProjectInstallationRoster.InitApptGroupAptdates(Sender:TObject);
begin
   if not(Sender is TAppointmentGUI) then exit;
   TAppointmentGUI(Sender).TransConnection := MyConnection;
   TAppointmentGUI(Sender).InitialEmployeeID :=fiEmpIDForAppt;
   TAppointmentGUI(Sender).GroupAptdates(fDatesSelected);
end;

procedure TfmProjectInstallationRoster.MakeAppointments;
begin
  try
    fiEmpIDForAppt:= 0;
    SetLength(fDatesSelected , 0);
    try
      CreateIfWorkingDay :=  MessageDlgXP_Vista('Do you wish to exclude the Holidays and Weekend Days?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
      IterateMonths(DatesSelectedCallback, true);
      if Length(fDatesSelected)>0 then begin
          if Userconfimdates('Create Appointments for ' + Quotedstr(tcdatautils.getemployeeName(fiEmpIDForAppt))) =False then begin
            UnselectAll;
            exit;
          end;
          OpenERPFormModal('TAppointmentGUI' , 0, InitApptGroupAptdates);
          Application.ProcessMessages;
      end;
    finally
        RefreshQuery;
        SetLength(fDatesSelected , 0);
    end;
  Except
    on E:Exception do begin
      MessageDlgXP_vista('e.message', mtWarning, [mbOK], 0);
    end;
  end;
end;

procedure TfmProjectInstallationRoster.ReadGuipref(Plannerform: TfmProjectInstallation;var Abort :Boolean);
begin
  Plannerform.ReadGuiprefs(GuiPrefs);
end;

procedure TfmProjectInstallationRoster.ReadGuiprefs;
begin
  IterateMonths(ReadGuipref, true);
  if GuiPrefs.Node.Exists('Options.MemoWidth') then memo1.width:= GuiPrefs.Node['Options.MemoWidth'].asInteger;
  if GuiPrefs.Node.Exists('Options.Months') then Months:= GuiPrefs.Node['Options.Months'].asInteger else Months:= 6;
end;

procedure TfmProjectInstallationRoster.Refreshmonth(Plannerform: TfmProjectInstallation;var Abort :Boolean);
begin
    dateChange(Plannerform, abort);
    Plannerform.RefreshQuery;
end;
procedure TfmProjectInstallationRoster.ReScheduleAppt(ApptID:Integer; iDaysToreschedule :Integer; iEmployeeID:Integer; UpdateLinkedAppointmentsonReschedule:Boolean);
var
  Appt:TAppointment;
begin
  if (iDaysToreschedule =0) and (iEmployeeID = 0) then exit;

  Appt := TAppointment.CreateWithNewConn(Self);
  try
    Appt.UserLock := UserLock;
    Appt.Connection.Connection := MyConnection;
    Appt.Load(ApptID);
    if Appt.count =0 then begin
      MessageDlgXP_Vista('Appointment cannot be located to reschedule.' , mtWarning, [mbOK], 0);
      exit;
    end;
    if not(Appt.Lock) then begin
      MessageDlgXP_Vista(ReplaceStr(Appt.UserLock.LockMessage  , 'Unable to update data.' ,'Appointemnt #' + inttostr(Appt.ID)+' cannot be Rescheduled.') , mtWarning, [mbOK], 0);
      exit;
    end;
    Appt.connection.BeginNestedTransaction;
    try
      if iDaysToreschedule <> 0 then begin
        Appt.Reschedulled := True;
        Appt.RescheduledDate := incday(Appt.StartTime , iDaysToreschedule);
      end;
      if iEmployeeID <> 0 then
        Appt.trainerId := iEmployeeID;
      Appt.PostDB;
      Appt.UpdateLinkedAppointmentsonReschedule := UpdateLinkedAppointmentsonReschedule;
      if Appt.Save then
        Appt.Connection.CommitNestedTransaction
      else Appt.Connection.RollbackNestedTransaction;
      TimerMsg( 'Appointemnt #' + inttostr(Appt.ID)+' is Reschdeuled.');
    Except
      On E:Exception do begin
        Appt.Connection.RollbackNestedTransaction;
      end;
    end;
    IsDirty := True;
  finally
    FreeandNil(Appt);
  end;

end;
procedure TfmProjectInstallationRoster.RefreshQuery;
begin
  IterateMonths(Refreshmonth, true);
end;
procedure TfmProjectInstallationRoster.RescheduleAppointment(Item: TPlannerItem);
var
  ApptID:Integer;
  dt1, dt2 : TDatetime;
  iDaysToreschedule:Integer;
begin
  UnselectAll;
  firstSelecteditem := item;
  //IterateMonths(SelectAllintheGroupCallback, true);
  if TRosterItemProperties(item.ItemObject).GroupID=0 then ApptID:= TRosterItemProperties(item.ItemObject).ID
  else ApptID:= TRosterItemProperties(item.ItemObject).groupID;
  if ApptID =0 then exit;
  CurGroupID :=ApptID;
  try
    SelectmainApt;
  finally
    CurGroupID :=0;
  end;
  dt1:= AppointmentDate(ApptID);
  dt2:= dt1;
  if TfmDateSelectDialog.SelectDateAtCursor('Choose the date to Move to',dt1,self,  Self.Color ) =False then exit;
  if dt1 = dt2 then exit;
  iDaysToreschedule := DaysBetween(dt1, dt2);
  if iDaysToreschedule =0 then exit;
  if (dt1<dt2) and (iDaysToreschedule >0) then iDaysToreschedule := 0-iDaysToreschedule;
  ReScheduleAppt(ApptID,iDaysToreschedule , 0 , True);
  RefreshQuery;
  UnselectAll;
  CurGroupID :=ApptID;
  try
    SelectmainApt;
  finally
    CurGroupID :=0;
  end;

 (* dt1:= AppointmentDate(ApptID);

  dt2:= dt1;

  if TfmDateSelectDialog.SelectDateAtCursor('Choose the date to Move to',dt1,self,  Self.Color ) then begin
    if dt1 = dt2 then exit;
    ///IterateOnSelectedItems(Planner1,DeleteItem);
    iDaysToreschedule := DaysBetween(dt1, dt2);
    try
      if (dt1<dt2) and (iDaysToreschedule >0) then iDaysToreschedule := 0-iDaysToreschedule;
      IterateOnSelectedItems(Planner1 ,ResceduleItem);
      RefreshQuery;
    finally
      iDaysToreschedule :=0;
    end;
  end;*)

end;

procedure TfmProjectInstallationRoster.SelectAllIntheGroup;
begin
  FirstSelectedItem :=nil;
  IterateMonths(FindFirstSelectedItem, true);
  try
    if not(Assigned(FirstSelectedItem)) then  begin
      MessageDlgXP_Vista('Please select an item', mtWarning, [mbOK], 0);
      exit;
    end;
    //if TRosterItemProperties(FirstSelectedItem.ItemObject).GroupID=0 then exit;
    itemsingroup := 0;
    IterateMonths(SelectAllintheGroupCallback, true);
    //IterateOnAllItems(Planner1,SelectAllintheGroup);
    if ItemsInGroup >0 then TimerMsg( inttostr(itemsingroup) +' appointments in the group.');

  finally
    FirstSelectedItem := nil;
  end;
end;
procedure TfmProjectInstallationRoster.FindFirstSelectedItem(Plannerform: TfmProjectInstallation;var Abort :Boolean);
begin
  FirstSelectedItem := GetFirstItemSelected(Plannerform.Planner1);
  if FirstSelectedItem <> nil then Abort := True;
end;
procedure TfmProjectInstallationRoster.SelectAllintheGroupCallback(Plannerform: TfmProjectInstallation;var Abort :Boolean);
begin
  if not(Assigned(FirstSelectedItem)) then exit;
  IterateOnAllItems(Plannerform.Planner1,SelectItemintheGroup);
  Plannerform.Planner1.Update;
end;
procedure TfmProjectInstallationRoster.SelectItemintheGroup(Item: TPlannerItem);
begin
  if not(Assigned(FirstSelectedItem)) then exit;
  Item.selected := (Item = FirstSelectedItem) or
                ((TRosterItemProperties(FirstSelectedItem.ItemObject).GroupID<>0) and (TRosterItemProperties(Item.ItemObject).GroupID = TRosterItemProperties(FirstSelectedItem.ItemObject).GroupID)) or
                ((TRosterItemProperties(FirstSelectedItem.ItemObject).GroupID=0) and (TRosterItemProperties(Item.ItemObject).GroupID = TRosterItemProperties(FirstSelectedItem.ItemObject).ID));
  if Item.selected  then begin
    Item.Color :=CL_Select;
    Item.ColorTo :=CL_Select;
    itemsingroup := itemsingroup+1;
  end;
end;
procedure TfmProjectInstallationRoster.SelectmainApt;
begin
  IterateMonths(SelectmainAptCallback, true);
end;
procedure TfmProjectInstallationRoster.SelectmainAptCallback(Plannerform: TfmProjectInstallation;var Abort :Boolean);
begin
  if Plannerform.SelectmainApt(CurgroupID) then Abort := True;;
end;
procedure TfmProjectInstallationRoster.SetISDirty(const Value: Boolean);
begin
  fbIsDirty:=Value;
  IterateMonths(WriteIsDirty, true);
end;

procedure TfmProjectInstallationRoster.setMonths(const Value: Integer);
(*var
  ctr:Integer;
begin
  fiMonths := Value;
  for ctr := low(ProjectInstallationMonths) to high(ProjectInstallationMonths) do begin
    ProjectInstallationMonths[ctr].pnlMain.Visible := ctr<= Value;
    ProjectInstallationMonths[ctr].Planner1.visible := ctr<= Value;
  end;
  if edtMonths.Value <> value then edtMonths.Value := value;*)
var
  ctr:Integer;
  abort:Boolean;
//  itop:Integer;
begin
  for ctr :=  high(ProjectInstallationMonths) downto low(ProjectInstallationMonths)  do begin
    if ProjectInstallationMonths[ctr].pnlMain.visible <> (ctr<= Value) then begin
      ProjectInstallationMonths[ctr].pnlMain.Visible := ctr<= Value;
      ProjectInstallationMonths[ctr].Planner1.visible := ctr<= Value;
      if ctr<= Value then Refreshmonth(ProjectInstallationMonths[ctr] , abort);  //ProjectInstallationMonths[ctr].RefreshQuery;
    end;
    if ProjectInstallationMonths[ctr].pnlMain.Visible then begin
      ProjectInstallationMonths[ctr].pnlMain.top :=0;
    end;
  end;
(*  itop :=0;
  for ctr :=  high(ProjectInstallationMonths) downto low(ProjectInstallationMonths)  do begin
    if ProjectInstallationMonths[ctr].pnlMain.Visible then begin
       ProjectInstallationMonths[ctr].pnlMain.top := itop;
       itop := itop + ProjectInstallationMonths[ctr].pnlMain.height;
    end;
  end;*)
  if edtMonths.Value <> value then edtMonths.Value := value;
  fiMonths := Value;
end;

procedure TfmProjectInstallationRoster.setStartDate(const Value: TDateTime);
begin
  fdStartDate := Value;
  if isformshown then dtpMonth.Date := Value;
end;

procedure TfmProjectInstallationRoster.TimerMsg(const Value: String);
begin
  TimerMsg(lblMsg , value);
end;

procedure TfmProjectInstallationRoster.UnselectAll;
begin
  IterateMonths(UnselectAllCallback, False);
end;
procedure TfmProjectInstallationRoster.UnselectAllCallback(Plannerform: TfmProjectInstallation;var Abort :Boolean);
begin
  Plannerlib.UnselectAll(Plannerform.Planner1, true);
  Plannerform.Planner1.Update;
end;
function TfmProjectInstallationRoster.Userconfimdates(const ActionMsg:String): Boolean;
begin
  REsult := True;
  if Length(fDatesSelected)<=1 then exit;
  REsult := TfmSelectedDates.CondirmDates(self, fDatesSelected , 'The following Dates are selected in different Months.'+ NL+'Are you sure you want to ' +ActionMsg +' for all these dates?');

end;

function TfmProjectInstallationRoster.WeekEmployeeID(Item: TPlannerItem): Integer;
begin
  REsult := GetEmployeeID(TDBPlanner(Item.owner).Header.Captions.Strings[Item.ItemPos + 1]);
end;

procedure TfmProjectInstallationRoster.WriteGuipref(Plannerform: TfmProjectInstallation;var Abort :Boolean);
begin
  Plannerform.WriteGuiprefs(GuiPrefs);
end;

procedure TfmProjectInstallationRoster.WriteGuiprefs;
begin
  IterateMonths(WriteGuipref, true);
  GuiPrefs.Node['Options.MemoWidth'].asInteger := memo1.width;
  GuiPrefs.Node['Options.Months'].asInteger := Months;
end;

procedure TfmProjectInstallationRoster.WriteIsDirty(Plannerform: TfmProjectInstallation;var Abort :Boolean);
begin
  Plannerform.IsDirty := fbIsdirty ;
end;

procedure TfmProjectInstallationRoster.OnClasschange;
begin
  if chkclasses.Checked = True then begin
    cboClass.Enabled := False;
  end else begin
    cboClass.Enabled := True;
    if chkclasses.Focused then cboClass.DropDown;
  end;
  IterateMonths(dateChange,true);
  RefreshQuery;
end;
Function TfmProjectInstallationRoster.ISOKToSelect( Item: TPlannerItem):Boolean;
begin
  fbOKToSelect := False;
  aItem := Item;
  try
    IterateMonths(ISOKToSelectCallback , True);
  finally
    aItem := nil;
    result := fbOKToSelect;
  end;
end;
procedure TfmProjectInstallationRoster.ISOKToSelectCallback(Plannerform: TfmProjectInstallation;var Abort :Boolean);
begin
  fbOKToSelect := Plannerform.ISOKToSelect(aItem);
  if not(fbOKToSelect) then abort := TRue;
end;
procedure TfmProjectInstallationRoster.btnDecHeightClick    (Sender: TObject);begin  inherited;  IterateMonths(DecHeights   , False);end;
procedure TfmProjectInstallationRoster.btnIncHeightClick    (Sender: TObject);begin  inherited;  IterateMonths(IncHeights   , False);end;
procedure TfmProjectInstallationRoster.btnDecRowHeightClick (Sender: TObject);begin  inherited;  IterateMonths(DecRowHeights, False);end;
procedure TfmProjectInstallationRoster.btnIncRowHeightClick (Sender: TObject);begin  inherited;  IterateMonths(IncRowHeights, False);end;
procedure TfmProjectInstallationRoster.DecHeights   (Plannerform: TfmProjectInstallation;var Abort :Boolean);begin Plannerform.btndecheight.click   ; end;
procedure TfmProjectInstallationRoster.IncHeights   (Plannerform: TfmProjectInstallation;var Abort :Boolean);begin Plannerform.btnincheight.click   ; end;
procedure TfmProjectInstallationRoster.DecRowHeights(Plannerform: TfmProjectInstallation;var Abort :Boolean);begin Plannerform.btndecRowheight.click; end;
procedure TfmProjectInstallationRoster.IncRowHeights(Plannerform: TfmProjectInstallation;var Abort :Boolean);begin Plannerform.btnIncRowheight.click; end;

initialization
 RegisterClassOnce(TfmProjectInstallationRoster);

end.
