unit frmCalendar;

{
 Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 27/07/05  1.00.01 DSP  Changed the DatePicker1 and dtpFromDate components from
                        TDBPlannerDatePicker and TDateTimePicker respectively to
                        the TPlannerDatePicker component type.

 19/10/05  1.00.02 DLS  Added RegisterClass
 15/11/05  1.00.03 MV   Modified AddService to support changes made to appointment
                        form redesign.
 05/01/06  1.00.04 BJ   option added for holiday entry.
                        The calender shows the holiday description along with the date
                        in the Caption
 10/07/06  1.00.05 AL   Put all from show code to SilentFormShow as it is called from two places
}

interface
uses
  Windows, BaseInputForm, DB, DBPlanner, Controls, StdCtrls, MessageInterface,
  DBCtrls, Grids, BaseGrid, AdvGrid, Planner, ComCtrls,AdvOfficeStatusBar, EditBtn,
  DBPlannerDatePicker, Classes, Forms, Dialogs, Graphics, SysUtils, AppEvnts,
  DBAccess, MyAccess,ERPdbComponents, MemDS, SelectionDialog, DataState, AdvEdit, AdvEdBtn,
  Mask, wwdbedit, Wwdbspin, PlannerDatePicker, PlannerDBDatePicker,
  wwdbdatetimepicker, Menus, AdvMenus, ExtCtrls, DNMSpeedButton,
  PlannerMonthView, DBPlannerMonthView, wwdblook, IdBaseComponent,
  wwcheckbox, Wwdotdot, Wwdbcomb, ImgList, AdvObj, ProgressDialog, DNMPanel;

type

  TCalenderSelectEvent = procedure (var EmployeeId: integer; var SelectedDate: TDateTime) of object;

  TCalendarGUI = class(TBaseInputGUI)
    lblDatePicker1: TLabel;
    cmdClose: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    cmdMedia: TDNMSpeedButton;
    AppointmentsDS: TDataSource;
    DBDaySource1: TDBDaySource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBPlanner1: TDBPlanner;
    DBPlanner2: TDBPlanner;
    DBDaySource2: TDBDaySource;
    qryDeleteResources: TERPQuery;
    qryCreateResources: TERPQuery;
    qryAddResources: TERPQuery;
    qryResources: TERPQuery;
    qryChkResources: TERPQuery;
    lblTimeIncrement: TLabel;
    cbTimeIncs: TDBComboBox;
    grdResources: TAdvStringGrid;
    lstColorBox: TListBox;
    btnCustomize: TDNMSpeedButton;
    qryCalPrefs: TERPQuery;
    Button1: TDNMSpeedButton;
    lblFromDate: TLabel;
    qryAppointments: TERPQuery;
    qryAppointmentsCusID: TIntegerField;
    qryAppointmentsAppointID: TIntegerField;
    qryAppointmentsAppDate: TDateField;
    qryAppointmentsENDTIME: TDateTimeField;
    qryAppointmentsSTARTTIME: TDateTimeField;
    qryAppointmentsResourceID: TWordField;
    qryAppointmentsTrainerID: TIntegerField;
    qryAppointmentsCancellation: TWideStringField;
    qryAppointmentsTrainerToResourceCalc: TIntegerField;
    qryAppointmentsUnavailable: TWideStringField;
    qryServices: TERPQuery;
    qryNotes: TERPQuery;
    DSTimeInc: TDataSource;
    qryAppointmentsNotes: TWideMemoField;
    qryAppointmentsStart_Time: TWideStringField;
    qryAppointmentsEnd_Time: TWideStringField;
    Label3: TLabel;
    Label5: TLabel;
    txtwidthDay: TwwDBSpinEdit;
    txtwidthWeek: TwwDBSpinEdit;
    DatePicker1: TwwDBDateTimePicker;
    dtpFromDate: TwwDBDateTimePicker;
    tbTimeInc: TMyTable;
    qryAppointmentsServiceDesc: TWideStringField;
    qryPublicHolidays: TERPQuery;
    qryPublicHolidaysDay: TDateField;
    qryPublicHolidaysDescription: TWideStringField;
    btnHolidays: TDNMSpeedButton;
    TabSheet3: TTabSheet;
    DBPlannerMonthView: TDBPlannerMonthView;
    qryAppointmentsRepairId: TIntegerField;
    qryAppointmentsCompany: TWideStringField;
    qryAppointmentsSuburb: TWideStringField;
    qryAppointmentsStreet: TWideStringField;
    qryAppointmentsStreet2: TWideStringField;
    qryAppointmentsState: TWideStringField;
    qryAppointmentsPostcode: TWideStringField;
    tmrProgress: TTimer;
    lblAppointmentStatus: TLabel;
    qryStatusType: TERPQuery;
    cboFollowUpResult: TwwDBLookupCombo;
    btnRequery: TDNMSpeedButton;
    lblfilter: TLabel;
    qryAppointmentsStatus: TWideStringField;
    qryAppointmentsStreet3: TWideStringField;
    qryAppointmentsCountry: TWideStringField;
    qryAppointmentsCustomerDetails: TWideStringField;
    pnlMain: TDNMPanel;
    DNMPanel1: TDNMPanel;
    Label48: TLabel;
    cboEmployee: TwwDBLookupCombo;
    Label4: TLabel;
    chkAllReps: TwwCheckBox;
    qryAppointmentsGoogleId: TWideStringField;
    qryAppointmentsSynchWithGoogle: TWideStringField;
    DNMSpeedButton1: TDNMSpeedButton;
    procedure cmdCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    procedure DatePicker1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBDaySource1ResetFilter(Sender: TObject);
    procedure DBPlanner1PlannerDblClick(Sender: TObject; Position, FromSel, FromSelPrecise, ToSel, ToSelPrecise: integer);
    procedure DBPlanner1ItemDblClick(Sender: TObject; Item: TPlannerItem);
    procedure PageControl1Change(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure cbTimeIncsChange(Sender: TObject);
    procedure grdResourcesClick(Sender: TObject);
    procedure DBDaySource1FieldsToItem(Sender: TObject; Fields: TFields; Item: TPlannerItem);
    procedure bbCancelClick(Sender: TObject);
    procedure grdResourcesGetCellColor(Sender: TObject; ARow, ACol: integer; AState: TGridDrawState;
      ABrush: TBrush; AFont: TFont);
    procedure cmdPrintClick(Sender: TObject);
    procedure cmdMediaClick(Sender: TObject);
    procedure qryAppointmentsCalcFields(DataSet: TDataSet);
    procedure btnCustomizeClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure grdResourcesDblClickCell(Sender: TObject; ARow, ACol: integer);
    procedure Button1Click(Sender: TObject);
    procedure ApplicationEvents1ShowHint(var HintStr: string; var CanShow: boolean; var HintInfo: THintInfo);
    procedure dtpFromDateChange(Sender: TObject);
    procedure DatePicker1Enter(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure txtwidthDayChange(Sender: TObject);
    procedure txtwidthWeekChange(Sender: TObject);
    procedure qryAppointmentsAfterOpen(DataSet: TDataSet);
    procedure DBPlanner1PlannerNext(Sender: TObject);
    procedure DBPlanner1PlannerPrev(Sender: TObject);
    procedure DBPlanner2PlannerPrev(Sender: TObject);
    procedure DBPlanner2PlannerNext(Sender: TObject);
    procedure btnHolidaysClick(Sender: TObject);
    procedure DBPlannerMonthViewGetDayProp(Sender: TObject;
      Date: TDateTime; var Caption: String; CaptionBrush: TBrush;
      AFont: TFont; var BKColor, BKColorTo: TColor);
    procedure DBPlanner2PlannerBkgDraw(Sender: TObject; Canvas: TCanvas;
      Rect: TRect; Index, Position: Integer);
    procedure cboEmployeeCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure DBDaySource1CreateKey(Sender: TObject;
      APlannerItem: TPlannerItem; var Key: String);
    procedure DBPlannerMonthViewDblClick(Sender: TObject;
      SelDate: TDateTime);
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure chkAllRepsClick(Sender: TObject);
    procedure DBPlanner1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DBPlanner1DragDropCell(Sender, Source: TObject; X,
      Y: Integer);
    procedure DBPlanner1DragDropHeader(Sender, Source: TObject;
      Position: Integer);
    procedure DBPlanner1DragDropItem(Sender, Source: TObject; X,
      Y: Integer; PlannerItem: TPlannerItem);
    procedure DBPlanner1EndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure DBDaySource1ItemToFields(Sender: TObject; Fields: TFields;
      Item: TPlannerItem);
    procedure DBPlannerMonthViewDateChange(Sender: TObject; origDate,
      newDate: TDateTime);
    procedure qryAppointmentsAfterScroll(DataSet: TDataSet);
    procedure DatePicker1CloseUp(Sender: TObject);
    procedure tmrProgressTimer(Sender: TObject);
    procedure cboFollowUpResultCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure btnRequeryClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure qryAppointmentsBeforePost(DataSet: TDataSet);
    procedure DBPlanner1ItemHint(Sender: TObject; Item: TPlannerItem;
      var Hint: string);
    procedure DBPlanner2ItemHint(Sender: TObject; Item: TPlannerItem;
      var Hint: string);
    procedure DBPlannerMonthViewItemHint(Sender: TObject; Item: TPlannerItem;
      var Hint: string);
    procedure DBDaySource2ItemToFields(Sender: TObject; Fields: TFields;
      Item: TPlannerItem);
    procedure DBPlannerMonthViewItemToFields(Sender: TObject; Fields: TFields;
      Item: TPlannerItem);
    procedure DBPlanner1ItemMove(Sender: TObject; Item: TPlannerItem; FromBegin,
      FromEnd, FromPos, ToBegin, ToEnd, ToPos: Integer);
    procedure DBPlanner2ItemMove(Sender: TObject; Item: TPlannerItem; FromBegin,
      FromEnd, FromPos, ToBegin, ToEnd, ToPos: Integer);
    procedure DBPlanner2PlannerSideDrawAfter(Sender: TObject; Canvas: TCanvas;
      Rect: TRect; Index: Integer);
    procedure DNMSpeedButton1Click(Sender: TObject);
  private
    fColumn:integer;
    fMsgHandler: TMsgHandler;
    fNewAppointmentObjectName: string;
    fbPlacingAppointmentMode: Boolean;
    fbEnsureAppointmentIsMade: Boolean;
    fbAppointmentMade: boolean;
    lstRepIDs: TStringList;
    dt:TDatetime;
    sTblName: string; // tbresource's temporary name
    fiTrainerID:integer;
    HeaderStr1, HeaderStr2: string;
    DatePickerProcessing: boolean;
    CloseWhenFinished: boolean;
    fOnCalenderSelect: TCalenderSelectEvent;
    DBPlanner1SidebarWidth,
    DBPlanner2SidebarWidth: integer;
    procedure UpdateHeaders;
    procedure UpdateHeaders2;
    function  GetEmployeeFromResource(ID: integer): integer; //Overload ;
//    function  GetEmployeeFromResource(Name: String): integer;overload;
    function  GetResourceFromEmployee(ID: integer): integer;
    function  ShowThisRep(iEmployeeID: integer): boolean;
    procedure MakeTblResourcesUnique;
    Function  getholiday(Value :TDatetime):String;
    Procedure DisplayifHoliday;
    Procedure SetPositionToCurrentTime;
    Procedure SilentFormShow(Sender: TObject);
    function GetEmployeeFromPosition(Const iPosition: integer): integer;
    Function RepairExists(Const repairID:Integer):boolean;
    (*Procedure RefreshCalender;*)
    Procedure Removedatasources;
    Procedure DoBeforeClose;
    procedure ShownHideDates;
    procedure LoadAppointmentForm(Sender: TObject; AID, iPosition: integer);
    procedure RefreshCalendar;
    procedure DoOnRosterOk(Sender: TObject);
    procedure AdjustSideBarWidths;
    procedure initdateinProjectInstallations(Sender: TObject);
  Protected
    function formWindowstate: TWindowState; virtual;
    procedure SetQueryDateRange;virtual;
    Procedure MakeResourceQry;virtual;
    procedure CenterHeader;
  public
    procedure UpdateMe; override;
    property OnCalenderSelect: TCalenderSelectEvent read fOnCalenderSelect write fOnCalenderSelect;
  published
    procedure PlaceNewAppointment(MsgObj: TMsgObj);
    function IsPlacingAppointment(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
  end;

  function OpenCalenderAndSelectDate(var SelectedEmployeeId: integer; var SelectedDate: TDateTime): boolean;

implementation

uses
  frmAppointments,  SourceListForm, DNMExceptions,
  CommonLib, CommonDbLib, CustomizeCalForm, DNMLib, DateUtils,
  AppEnvironment, {FastFuncs,} tcConst, CommonFormLib,
  AppContextObj, StrUtils, EmployeeAccesses, BusObjAppointments, DateTimeUtils,
  JsonObject, frmProjectInstallationRoster;

{$R *.DFM}
type

  TCalenderSelectEventObj = class
  public
    EmpId: integer;
    SelDate: TDateTime;
    procedure DoOnCalenderSelect(var aEmployeeId: integer; var aSelectedDate: TDateTime);
  end;

procedure TCalenderSelectEventObj.DoOnCalenderSelect(var aEmployeeId: integer; var aSelectedDate: TDateTime);
begin
  EmpId := aEmployeeId;
  SelDate := aSelectedDate;
end;

function OpenCalenderAndSelectDate(var SelectedEmployeeId: integer; var SelectedDate: TDateTime): boolean;
var
  CalForm: TCalendarGUI;
  CalenderSelectEventObj: TCalenderSelectEventObj;
begin
  result := false;
  CalenderSelectEventObj := TCalenderSelectEventObj.Create;
  CalForm := TCalendarGUI.Create(nil);
  try
    CalForm.OnCalenderSelect := CalenderSelectEventObj.DoOnCalenderSelect;
    if CalForm.ShowModal = mrOk then begin
      result := true;
      SelectedEmployeeId := CalenderSelectEventObj.EmpId;
      SelectedDate := CalenderSelectEventObj.SelDate;
    end;
  finally
    CalForm.Free;
    CalenderSelectEventObj.Free;
  end;
end;


Function  TCalendarGUI.formWindowstate:  TWindowState;
begin
  result:= wsMaximized;
end;
procedure TCalendarGUI.cmdCloseClick(Sender: TObject);
begin
  if DatePickerProcessing then begin
    CloseWhenFinished:= true;
    exit;
  end;
  Removedatasources;
  if qryAppointments.recordcount >0 then begin
    qryAppointments.Edit;
    qryAppointments.Post;
  end;
  dobeforeclose;
  Close;
end;

procedure TCalendarGUI.FormCreate(Sender: TObject);
var
  dtTemp: TDateTime;
  iDay, iMonth, iYear: word;
begin
  DatePickerProcessing := false;
  CloseWhenFinished := false;
  dt:= 0;
  fMsgHandler := TMsgHandler.Create(Self);
  inherited;
  fbPlacingAppointmentMode := false;
  fbAppointmentMade := false;
  tbTimeInc.Connection := MyConnection;
  lstRepIds := TStringList.Create;
  DBDaySource1.DateFormat := AppEnv.RegionalOptions.ShortDateformat;
  DBDaySource2.DateFormat := AppEnv.RegionalOptions.ShortDateformat;
  DBDaySource1.Day := Now;
  DBPlanner1.StreamPersistentTime := true;
  FormatSettings.TimeAMString := 'AM';
  FormatSettings.TimePMString := 'PM';
  DBDaySource2.Day := Now;
  DBPlanner2.StreamPersistentTime := true;
  MakeTblResourcesUnique;
  dtTemp := Now;
  dtTemp := dtTemp - AppEnv.Employee.ListDaysPast;
  DecodeDate(dtTemp, iYear, iMonth, iDay);
  dtpFromDate.DateTime := dtTemp;
  DatePicker1.DateTime := Now;
  DBPlannerMonthView.Date := Now;
  Removedatasources;
  DBPlanner1SidebarWidth := DBPlanner1.SideBar.Width;
  DBPlanner2SidebarWidth := DBPlanner2.SideBar.Width;
  AdjustSideBarWidths;
end;

procedure TCalendarGUI.UpdateHeaders;
begin
  DBPlanner1.Header.Captions.Clear;
  DBPlanner1.Header.Captions.Add('');
  with qryResources do begin
    First;
    while not Eof do begin
      DBPlanner1.Header.Captions.Add(FieldValues['FirstName'] + ' ' + FieldValues['LastName']);
      Next;
    end;
  end;
  HeaderStr1:= DBPlanner1.Header.Captions.Text;
end;

procedure TCalendarGUI.UpdateHeaders2;
var
  i: integer;
  j: integer;
begin
  if not qryResources.Active then exit;

  DBPlanner2.Header.Captions.Clear;
  DBPlanner2.Header.Captions.Add('');
  for j := 1 to 7 do begin
    qryResources.First;
    for i := 1 to qryResources.RecordCount do begin
      DBPlanner2.Header.Captions.Add(IntToStr(i));
      qryResources.Next;
    end;
  end;

  qryResources.First;
  grdResources.RowCount := qryResources.RecordCount;

  for i := 1 to qryResources.RecordCount do begin
    grdResources.Cells[0, i - 1] := IntToStr(i);
    grdResources.Cells[1, i - 1] := qryResources.FieldValues['FirstName'] + ' ' + qryResources.FieldValues['LastName'];
    qryResources.Next;
  end;
  HeaderStr2:= DBPlanner2.Header.Captions.Text;
end;


procedure TCalendarGUI.DatePicker1Change(Sender: TObject);
var
  qryActive: boolean;
begin
  if DatePicker1.DroppedDown then exit;
  if not qryResources.Active then Exit;
  qryActive:= qryAppointments.Active;
  SetQueryDateRange;
  qryAppointments.Active:= qryActive;

  DBDaySource1.Day := DatePicker1.DateTime;
  DBDaySource2.Day := DatePicker1.DateTime;
  DBPlannerMonthView.Date := DatePicker1.DateTime;
  UpdateHeaders;
  UpdateHeaders2;
  DisplayifHoliday;
  SetControlFocus(Self);
end;

procedure TCalendarGUI.DatePicker1CloseUp(Sender: TObject);
var
  qryActive: boolean;
begin
  DatePickerProcessing:= true;
  try
    inherited;
    if not qryResources.Active then Exit;
    try
      qryActive:= qryAppointments.Active;
      SetQueryDateRange;
      qryAppointments.Active:= qryActive;

      DBDaySource1.Day := DatePicker1.DateTime;
      DBDaySource2.Day := DatePicker1.DateTime;
      DBPlannerMonthView.Date := DatePicker1.DateTime;
      UpdateHeaders;
      UpdateHeaders2;
      DisplayifHoliday;
    except
      on e: exception do begin
        { this is to prevent exception when Date picker calander is visible
          and user closes the form }
      end;
    end;
  finally
    DatePickerProcessing:= false;
    if CloseWhenFinished then begin
      CloseWhenFinished:= false;
      cmdClose.Click;
    end;
  end;
end;

procedure TCalendarGUI.FormShow(Sender: TObject);
Begin
    WindowState := FormwindowState;
  try
    DisableForm;
    try
      lblfilter.visible := devmode;
      DBDaySource1.datasource:= AppointmentsDS;
      Pagecontrol1.ActivePage := tabsheet1; // to open in day mode
      //Self.SetFocus;
      //Setcontrolfocus(DBPlanner1);
      Application.Processmessages;
      SilentFormShow(Sender); //Put all from show code to SilentFormShow as it is called from two places
    finally
      EnableForm;
      Appcontext['Calenderform'].Varbyname['showing'] := 'F';
      Appcontext['Calenderform'].DeleteVar('showing');
    end;
  finally
      tmrProgress.enabled := True;
  end;
  ShownHideDates;
  opendb(qryStatusType);
end;

procedure TCalendarGUI.FormActivate(Sender: TObject);
begin
  inherited;
    WindowState := FormwindowState;
end;

procedure TCalendarGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qryDeleteResources.Execute;
  inherited;
  Action := caFree;
end;

procedure TCalendarGUI.DBDaySource1ResetFilter(Sender: TObject);
begin
  UpdateHeaders;
  UpdateHeaders2;
  DisplayifHoliday;
end;

procedure TCalendarGUI.DBDaySource2ItemToFields(Sender: TObject;  Fields: TFields; Item: TPlannerItem);
begin
  inherited;

//  qryAppointments.FieldByName('TrainerID').AsInteger := GetEmployeeFromResource(item.ItemPos);
  if DBPlanner2.Header.Captions[1] = '' then
    self.UpdateHeaders2;
  qryAppointments.FieldByName('TrainerID').AsInteger := GetEmployeeFromResource(StrToInt(DBPlanner2.Header.Captions[Item.ItemPos+1])-1);
  DBPlanner2.Items.Selected.Update;
  qryAppointments.Post;
  if qryAppointmentsSynchWithGoogle.AsBoolean then
    AppEnv.GoogleUpdater.UpdateCalendar(self.qryAppointmentsAppointID.AsInteger, AppEnv.ServerID);
  qryAppointments.Edit;
end;

procedure TCalendarGUI.DBPlanner1PlannerDblClick(Sender: TObject;
  Position, FromSel, FromSelPrecise, ToSel, ToSelPrecise: integer);
var
  empId: integer;
  selDate: TDateTime;
begin
  if Assigned(fOnCalenderSelect) then begin
    if Sysutils.SameText(TDBPlanner(Sender).Name,'DBPlanner1') then
      empId := GetEmployeeFromResource(Position)
    else
      empId := GetEmployeeFromResource(StrToInt(TDBPlanner(Sender).Header.Captions[Position+1])-1);
    selDate := TDBPlanner(Sender).CellToTime(TDBPlanner(Sender).SelPosition,TDBPlanner(Sender).SelItemBegin);
    fOnCalenderSelect(empId,selDate);
    ModalResult := mrOk;
  end
  else begin
    if Sysutils.SameText(TDBPlanner(Sender).Name,'DBPlanner1') then
      LoadAppointmentForm(Sender, 0, Position)
    else
      LoadAppointmentForm(Sender, 0, StrToIntDef(TDBPlanner(Sender).Header.Captions[Position+1],0)-1);
  end;
end;

function TCalendarGUI.GetEmployeeFromResource(ID: integer): integer;
var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(Self);
  with qry do try
      Options.FlatBuffers := True;
      Connection := CommonDbLib.GetSharedMyDacConnection;
      sql.add('select EmployeeID from ' + sTblName + ' where');
      sql.add(Format('ResourceID=''%d''', [ID + 1]));
      Open;
      if Eof then begin
        CommonLib.MessageDlgXP_Vista('GetEmployeeFromResource: Could not match Trainer with Resource ID', mtWarning, [mbOK], 0);
        Result := -1;
      end else begin
        Result := FieldByName('EmployeeID').AsInteger;
      end;
    finally
      FreeAndNil(qry);
    end;
end;

procedure TCalendarGUI.LoadAppointmentForm(Sender: TObject; AID, iPosition: integer);
var
  AppointmentGUI: TBaseInputGUI;
  MsgObj: TMsgObj;
begin
  if fbPlacingAppointmentMode and (AID = 0) then begin
    MsgObj := TMsgObj.Create;
    try
      MsgObj.SetAddress('TNewAppointment', 'EmployeeID', fNewAppointmentObjectName);
      MsgObj.IntValue := GetEmployeeFromResource(iPosition);
      fMsgHandler.Send(MsgObj, MsgObj);

      MsgObj.MethodStr := 'StartTime';
      (*MsgObj.DateTime := DateOf(TDBPlanner(Sender).PosToDay(iPosition))
        + TimeOf(TDBPlanner(Sender).CellToTime(DBPlanner1.SelItemBegin, TDBPlanner(Sender).SelItemEnd - 1));*)
      MsgObj.DateTime:= TDBPlanner(Sender).CellToTime(TDBPlanner(Sender).SelPosition,TDBPlanner(Sender).SelItemBegin);
      fMsgHandler.Send(MsgObj, MsgObj);

      MsgObj.MethodStr := 'AppointmentPlaced';
      fMsgHandler.Send(MsgObj, MsgObj);
    Finally
      FreeAndNil(MsgObj);
    end;
    fbPlacingAppointmentMode := False;
    fNewAppointmentObjectName := '';
    DoBeforeClose;
    Close;
  end else begin
    AppointmentGUI := TBaseInputGUI(GetComponentByClassName('TAppointmentGUI'));
    if Assigned(AppointmentGUI) then begin
      AppointmentGUI.AttachObserver(Self);
      if AID <> 0 then
        AppointmentGUI.KeyID := AID
      else begin
        MsgObj := TMsgObj.Create;
        try
          MsgObj.SetAddress('TAppointmentGUI', 'InitEmployeeID');
          MsgObj.IntValue := GetEmployeeFromResource(iPosition);
          fMsgHandler.Send(MsgObj, MsgObj);
          MsgObj.MethodStr := 'InitStartTime';
//          MsgObj.DateTime := DateOf(TDBPlanner(Sender).PosToDay(iPosition))
//            + TimeOf(TDBPlanner(Sender).CellToTime(DBPlanner1.SelItemBegin, TDBPlanner(Sender).SelItemEnd - 1));
          MsgObj.DateTime:= TDBPlanner(Sender).CellToTime(TDBPlanner(Sender).SelPosition,TDBPlanner(Sender).SelItemBegin);
          fMsgHandler.Send(MsgObj, MsgObj);
        Finally
          FreeAndNil(MsgObj);
        end;
      end;
      WindowState := wsnormal;
      AppointmentGUI.FormStyle := fsMDIChild;
      AppointmentGUI.BringToFrontSoon;
   end;
 end;
end;

procedure TCalendarGUI.DBPlanner1ItemDblClick(Sender: TObject; Item: TPlannerItem);
var
  MsgOption :Word;
begin
  MsgOption := 101;
  if (qryAppointmentsRepairId.asinteger <> 0) and (RepairExists(qryAppointmentsRepairId.asinteger)) then
    MsgOption := CommonLib.MessageDlgXP_Vista('Do You Wish To Open the Appointment # ' +IntToStr(qryAppointments.FieldByName('AppointID').AsInteger ) +
                                    chr(13) +' Or The Repair # ' + IntToStr(qryAppointmentsRepairId.asinteger) +' Associated With It?' , mtconfirmation ,
                                    [] , 0 , nil, '', '', False , nil , 'Open Repair # '+IntToStr(qryAppointmentsRepairId.asinteger) +
                                    ',Open Appointment # '+IntToStr(qryAppointments.FieldByName('AppointID').AsInteger )+',Cancel');
    if MsgOption = 100 then
      OpenERPForm('TRepairsGUI' , qryAppointmentsRepairId.asInteger , nil, nil)
    else if MsgOption = 101 then begin
      if qryAppointments.FieldByName('Unavailable').AsBoolean then begin
        { this is an "Unavailable" appointment created from roster .. }
        CommonFormLib.OpenERPFormModal('TRosterCalGUI',0,nil,false,DoOnRosterOk);
      end
      else begin
        { open the appointment }
        LoadAppointmentForm(Sender, qryAppointments.FieldByName('AppointID').AsInteger,
            qryAppointments.FieldByName('ResourceID').AsInteger);
      end;
    end;
end;
procedure TCalendarGUI.DBPlanner1ItemHint(Sender: TObject; Item: TPlannerItem;
  var Hint: string);
begin
  inherited;
  if StrUtils.RightStr(Hint,2) <> #13#10 then
    Hint := Hint + #13#10;
end;


Procedure TCalendarGUI.ShownHideDates;
begin
  lblFromDate.visible :=Pagecontrol1.ActivePage = TabSheet3;
  dtpFromDate.visible :=Pagecontrol1.ActivePage = TabSheet3;
  lblDatePicker1.visible :=Pagecontrol1.ActivePage <> TabSheet3;
  DatePicker1.visible :=Pagecontrol1.ActivePage <> TabSheet3;
  if Dt<> 0 then
    if Pagecontrol1.ActivePage = TabSheet3 then dtpFromDate.Date :=Dt
    else DatePicker1.Date := dt;

end;
procedure TCalendarGUI.PageControl1Change(Sender: TObject);
begin
  Removedatasources;
  ShownHideDates;

  if (Pagecontrol1.ActivePage = TabSheet3) then begin
    If qryResources.Locate('EmployeeID', AppEnv.Employee.EmployeeID,[]) then begin
      cboEmployee.Text :=  AppEnv.Employee.EmployeeName;
      cboEmployee.PerformSearch;
    end;

    SetQueryDateRange;
    OpenDB(qryAppointments);
  end else begin
    SetQueryDateRange;
    OpenDB(qryAppointments);
    if Trim(DBPlanner2.Header.Captions.Text) = '' then
      UpdateHeaders2;
  end;

  CenterHeader;
end;

Procedure TCalendarGUI.DisplayifHoliday;
var
    strHoliday:String;
    i :Integer;
    CaptionDay :TDatetime;
begin
  if Pagecontrol1.ActivePage = tabsheet1 then begin
      DBPlanner1.Header.TextHeight := 40;
      DBPlanner1.Header.Height := 40;
      strHoliday := getholiday(DateOf(DBDaySource1.Day));
      if strHoliday = '' then begin
          DBPlanner1.Header.GroupCaptions.clear;
          DBPlanner1.Header.GroupCaptions.Add(formatDatetime('dddd    ' + FormatSettings.ShortDateformat ,  DBDaySource1.Day));
      end else begin
          DBPlanner1.Header.GroupCaptions.clear;
          DBPlanner1.Header.GroupCaptions.Add(formatDatetime('dddd    ' + FormatSettings.ShortDateformat ,  DBDaySource1.Day) + '     [' +strHoliday+']');
      end;
  end else if Pagecontrol1.ActivePage = tabsheet2 then begin
      CaptionDay :=DBDaySource2.Day;
      DBPlanner2.Header.GroupCaptions.clear;
      DBPlanner2.Header.TextHeight := 40;
      DBPlanner2.Header.Height := 40;

      For I := 1 to DBDaySource2.NumberOfDays do begin
          strHoliday := getholiday(DateOf(CaptionDay));
          if strHoliday = '' then
              DBPlanner2.Header.GroupCaptions.Add(formatDatetime('ddd ' + FormatSettings.ShortDateformat ,  CaptionDay))
          else begin
              DBPlanner2.Header.GroupCaptions.Add(formatDatetime('ddd ' + FormatSettings.ShortDateformat ,  CaptionDay) + chr(13) + '[' +strHoliday +']');
              DBPlanner2.Header.TextHeight := 75;
              DBPlanner2.Header.Height := 60;
          end;
          CaptionDay := IncDay(CaptionDay);
      end;
  end;
end;

procedure TCalendarGUI.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  if openERPform('TfmProjectInstallationRoster' , 0 , nil, initdateinProjectInstallations) then
    Self.Close;
end;
procedure TCalendarGUI.initdateinProjectInstallations(Sender:TObject);
begin
  if not(Sender is TfmProjectInstallationRoster) then exit;
  TfmProjectInstallationRoster(Sender).StartDate := iif(PageControl1.ActivePageIndex=2, dtpFromDate.Date , DatePicker1.Date);
end;
procedure TCalendarGUI.DoBeforeClose;
begin
  WindowState := wsnormal;
end;

procedure TCalendarGUI.DoOnRosterOk(Sender: TObject);
begin
  RefreshCalendar;
end;

Function TCalendarGUI.getholiday(Value :TDatetime):String;
begin
    Result := '';
    if not qryPublicHolidays.Active then
      qryPublicHolidays.Open;
    if qryPublicHolidays.Locate('Day' , Value , []) then
        Result := qryPublicHolidaysDescription.asString;
end;

procedure TCalendarGUI.FormResize(Sender: TObject);
begin
  RealignTabControl(PageControl1, 1);
  CenterHeader;
end;

procedure TCalendarGUI.cbTimeIncsChange(Sender: TObject);
begin
  try
    tbTimeInc.Edit;
    tbTimeInc.FieldByName('TimeInc').AsString := cbTimeIncs.Text;
    DBPlanner1.Display.DisplayUnit := StrToInt(cbTimeIncs.Text);
    DBPlanner2.Display.DisplayUnit := StrToInt(cbTimeIncs.Text);
    DBPlanner1.UpdateControlState;
    DBPlanner2.UpdateControlState;
    tbTimeInc.Post;
    tbTimeInc.Edit;
  except
    CommonLib.MessageDlgXP_Vista('Invalid Value', mtWarning, [mbOK], 0);
  end;
end;

procedure TCalendarGUI.CenterHeader;
var
  lShift : integer;
  lWidth : integer;
begin
//  lShift :=   dtpFromDate.Left + dtpFromdate.Width - lblTimeIncrement.Left;  // real width
  if Pagecontrol1.ActivePage = TabSheet3 then
  begin
    lWidth := lblTimeIncrement.Width + cbTimeIncs.Width + {lblDatePicker1.Width +  DatePicker1.Width +}
              lblAppointmentStatus.Width + cboFollowUpResult.Width + lblFromDate.Width + dtpFromDate.Width +
              44;  //4x1+3x2, one blank=13
    lShift := (self.ClientRect.Right - Self.ClientRect.Left - lWidth) div 2;
    lblTimeIncrement.Left := lShift;
    cbTimeIncs.Left := lblTimeIncrement.Left + lblTimeIncrement.Width + 6;
    lblAppointmentStatus.Left := cbTimeIncs.Left + cbTimeIncs.Width + 13;
    cboFollowUpResult.Left := lblAppointmentStatus.Left + lblAppointmentStatus.Width + 6;
    lblFromDate.Left := cboFollowUpResult.Left + cboFollowUpResult.Width + 13;
    dtpFromDate.Left := lblFromDate.Left + lblFromDate.Width + 6;
  end
  else
  begin
    lWidth := lblTimeIncrement.Width + cbTimeIncs.Width + lblDatePicker1.Width +  DatePicker1.Width +
              lblAppointmentStatus.Width + cboFollowUpResult.Width + {lblFromDate.Width + dtpFromDate.Width +}
              44;  //4x1+3x2, one blank=13
    lShift := (self.ClientRect.Right - Self.ClientRect.Left - lWidth) div 2;
    lblTimeIncrement.Left := lShift;
    cbTimeIncs.Left := lblTimeIncrement.Left + lblTimeIncrement.Width + 6;
    lblDatePicker1.Left := cbTimeIncs.Left + cbTimeIncs.Width + 13;
    DatePicker1.Left := lblDatePicker1.Left + lblDatePicker1.Width + 6;
    lblAppointmentStatus.Left := DatePicker1.Left + DatePicker1.Width + 13;
    cboFollowUpResult.Left := lblAppointmentStatus.Left + lblAppointmentStatus.Width + 6;
  end;
end;

procedure TCalendarGUI.grdResourcesClick(Sender: TObject);
begin
  grdResources.SelectionTextColor := grdResources.FontColors[grdResources.Col, grdResources.Row];
end;

procedure TCalendarGUI.bbCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TCalendarGUI.DBDaySource1FieldsToItem(Sender: TObject; Fields: TFields; Item: TPlannerItem);
var
  qry: TERPQuery;
  ColourCount: integer;
begin
  if Trim(DBPlanner1.Header.Captions.Text) = '' then begin
    if HeaderStr1 = '' then
      UpdateHeaders;
    DBPlanner1.Header.Captions.Text:= HeaderStr1;
  end;

  if Item.Text.Text <> '' then exit;

//  if qryAppointments.FieldByName('AppDate').AsDateTime <> Trunc(qryAppointments.FieldByName('StartTime').AsDateTime) then begin
//    EditDb(qryAppointments);
//    qryAppointments.FieldByName('AppDate').AsDateTime:= Trunc(qryAppointments.FieldByName('StartTime').AsDateTime);
//    PostDb(qryAppointments);
//  end;

  qry := qryAppointments;

  if not ShowThisRep(qryAppointmentsTrainerID.AsInteger) then begin
    Item.Visible:= False;
    exit;
  end;
  if qry.FieldByName('Unavailable').AsString <> 'T' then begin
    if qryAppointmentsCustomerDetails.asString <> '' then begin
      if pos(#13#10+Qry.FieldByName('Company').AsString+#13#10 ,Qry.fieldByname('CustomerDetails').asString) = 0 then
        Item.Text.Add(Qry.FieldByName('Company').AsString);
      Item.Text.Add(Qry.fieldByname('CustomerDetails').asString);
    end else begin
      Item.Text.Add(Qry.FieldByName('Company').AsString);
      if Qry.FieldByName('Street').AsString <> '' then Item.Text.Add(Qry.FieldByName('Street').AsString);
      if Qry.FieldByName('Street2').AsString <> '' then Item.Text.Add(Qry.FieldByName('Street2').AsString);
      if Qry.FieldByName('Street3').AsString <> '' then Item.Text.Add(Qry.FieldByName('Street3').AsString);
      if (Qry.FieldByName('Suburb').AsString <> '') or (Qry.FieldByName('State').AsString<>'') or (Qry.FieldByName('Postcode').AsString <> '') then
        Item.Text.Add(Qry.FieldByName('Suburb').AsString + ' ' +
                      Qry.FieldByName('State').AsString + ' ' +
                      Qry.FieldByName('Postcode').AsString);
      if Qry.FieldByName('Country').AsString <> '' then Item.Text.Add(Qry.FieldByName('Country').AsString);
    end;

    if assigned(Item.ItemObject) then
      qry.FieldByName('TrainerID').AsInteger := StringToInt(cboEmployee.LookupValue);
  end else begin
    Item.Text.Add('Unavailable');
  end;

  if qry.FieldByName('ServiceDesc').AsString <> '' then Item.Text.Add(qry.FieldByName('ServiceDesc').AsString);

  {display the repair no in the calender if any}
  if Qry.fieldbyname('RepairId').asInteger <> 0 then begin
      Item.Text.Add('');
      Item.Text.Add('Repair # ' + IntToStr(Qry.fieldbyname('RepairId').asInteger));
  end;

  if qry.fieldbyname('Status').asString <> '' then Item.Text.Add('Status :' +qry.fieldbyname('Status').asString);

  ColourCount := Fields.FieldByName('TrainerToResourceCalc').AsInteger;

  while not (ColourCount < 24) do begin
    ColourCount := ColourCount - 24;
  end;

  if Fields.FieldByName('TrainerToResourceCalc').AsInteger <= lstColorBox.Items.Count then begin
    Item.Color      := StringToColor(lstColorBox.Items[ColourCount]);
    Item.Font.Color := clWhite;
    Item.Font.Style := [fsBold];
  end else begin
    Item.Color      := clBlue;
    Item.Font.Color := clWhite;
    Item.Font.Style := [fsBold];
  end;

  if Fields.FieldByName('Unavailable').AsString = 'T' then begin
    Item.Color      := $00C8F0FD;
    Item.Font.Color := clBlack;
    Item.Background := true;
  end;

  // Set item so that its level of control reflects the AccessLevel of the user
  // NOTE: See note in DBDaySource1FieldsToItem
  Item.FixedPos := (AccessLevel >= 5);
  Item.FixedSize := (AccessLevel >= 5);

  if Sender = DBPlannerMonthView then
     Item.CaptionText := FormatDateTime('H:nn am/pm', Item.ItemRealStartTime ) + ' - '+ FormatDateTime('H:nn am/pm', Item.ItemRealEndTime);
end;

procedure TCalendarGUI.grdResourcesGetCellColor(Sender: TObject; ARow, ACol: integer;
  AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  ColourCount: integer;
begin
  ColourCount := ARow;

  while not (ColourCount < 24) do begin
    ColourCount := ColourCount - 24;
  end;

  AFont.Color := StringToColor(lstColorBox.Items[ColourCount]);
end;

procedure TCalendarGUI.UpdateMe;
begin
  qryAppointments.Close;
  OpenDB(qryAppointments);
  UpdateHeaders;
  UpdateHeaders2;
end;

procedure TCalendarGUI.cmdPrintClick(Sender: TObject);
begin
  DisableForm;
  try
    if PageControl1.ActivePage = TabSheet1 then begin
      DBPlanner1.Print;
    end else if PageControl1.ActivePage = TabSheet2 then begin
      DBPlanner2.Print;
    end else if PageControl1.ActivePage = TabSheet3 then begin
      DBPlannerMonthView.Print;
    end;
  finally
    EnableForm;
  end;
end;

procedure TCalendarGUI.cmdMediaClick(Sender: TObject);
begin
  DisableForm;
  try
    with TSourceListGUI.Create(Application) do begin
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  finally
    EnableForm;
  end;
end;

procedure TCalendarGUI.qryAppointmentsCalcFields(DataSet: TDataSet);
begin
  inherited;
  DataSet.FieldByName('TrainerToResourceCalc').AsInteger :=
    GetResourceFromEmployee(DataSet.FieldByName('TrainerID').AsInteger);
end;

function TCalendarGUI.GetResourceFromEmployee(ID: integer): integer;
begin
  if qryResources.Locate('EmployeeID', ID, [loCaseInsensitive]) then begin
    Result := qryResources.RecNo - 1; // why not get the resourceID ?
  end else begin
//    CommonLib.MessageDlgXP_Vista('GetResourceFromEmployee: Could not match Trainer with Resource ID', mtWarning, [mbOK], 0);
    Result := 0;
  end;
end;

procedure TCalendarGUI.btnCustomizeClick(Sender: TObject);
begin
  if not(CanCustomiseCalendar) then begin
    CommonLib.MessageDlgXP_Vista(Format('You don''t have access to %s.',
      [AppEnv.AccessLevels.GetFormDescription('FnCustomiseCalendar')]), mtInformation, [mbOK], 0);
    Exit;
  end;
  with TCustomizeCalGUI.Create(self) do begin
    if ShowModal = mrOk then begin
      ///////self.FormShow(Sender);
      SilentFormShow(Sender); //Put all from show code to SilentFormShow as it is called from two places
      ShownHideDates;
      opendb(qryStatusType);
      AdjustSideBarWidths;
    end;
  end;
end;

function TCalendarGUI.ShowThisRep(iEmployeeID: integer): boolean;
var
  iDummy: integer;
begin
  if lstRepIDs.Count = 0 then begin
    Result := true;
  end else begin
    Result := lstRepIDs.Find(IntToStr(iEmployeeID), iDummy);
  end;
end;

procedure TCalendarGUI.FormDestroy(Sender: TObject);
begin
  hideProgressbar;
  FreeAndNil(fMsgHandler);
  if Assigned(lstRepIds) then
    FreeandNil(lstRepIds);
  inherited;
end;


procedure TCalendarGUI.MakeResourceQry;
begin
    qryResources.Close;
    //qryResources.Prepared := true;
    qryResources.Open;
end;

procedure TCalendarGUI.MakeTblResourcesUnique;
{ replace the string "tblResources" in resource querries with a name which is
  specific to the users computer }
begin
  sTblName := GetUserTemporaryTableName('tblresources');
  qryDeleteResources.SQL.Text := StringReplace(qryDeleteResources.SQL.Text, 'tblResources', sTblName, [rfReplaceAll, rfIgnoreCase]);
  qryCreateResources.SQL.Text := StringReplace(qryCreateResources.SQL.Text, 'tblResources', sTblName, [rfReplaceAll, rfIgnoreCase]);
  qryResources.SQL.Text := StringReplace(qryResources.SQL.Text, 'tblResources', sTblName, [rfReplaceAll, rfIgnoreCase]);
  qryChkResources.SQL.Text := StringReplace(qryChkResources.SQL.Text, 'tblResources', sTblName, [rfReplaceAll, rfIgnoreCase]);
end;

procedure TCalendarGUI.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_ESCAPE then Begin
      WindowState := wsnormal;
    end;
  inherited;

end;

procedure TCalendarGUI.FormKeyUp(Sender: TObject; var Key: word; Shift: TShiftState);
var
  cThisKey: char;
begin
  inherited;
  if Shift = [ssCtrl] then begin
    cThisKey := Chr(Key);
    Key      := 0;
    if cThisKey = 'D' then begin
      Pagecontrol1.ActivePageIndex := 0;
      PageControl1Change(Sender);
      Exit;
    end;

    if cThisKey = 'W' then begin
      Pagecontrol1.ActivePageIndex := 1;
      PageControl1Change(Sender);
      Exit;
    end;
  end;
end;

procedure TCalendarGUI.grdResourcesDblClickCell(Sender: TObject; ARow, ACol: integer);
begin
  inherited;
  lstRepIDs.Clear;
  lstRepIDs.Add(Trim(IntToStr(GetEmployeeID(grdResources.Cells[1, ARow]))));
  //FormShow(Sender); used to put form behind others changed to SilentFormShow
  SilentFormShow(Sender);
end;

procedure TCalendarGUI.Button1Click(Sender: TObject);
begin
  inherited;
  //////FormShow(Self);
  SilentFormShow(Sender); //Put all from show code to SilentFormShow as it is called from two places
end;

procedure TCalendarGUI.AdjustSideBarWidths;
var
  ZoneCount: integer;
begin
  ZoneCount := AppEnv.Employee.CalendarTimeZones.A['Zones'].Count;
  if ZoneCount > 0 then begin
    DBPlanner1.Sidebar.Width := DBPlanner1SidebarWidth * (ZoneCount + 1);
    DBPlanner2.Sidebar.Width := DBPlanner2SidebarWidth * (ZoneCount + 1);
    DBPlanner1.Sidebar.Alignment := taRightJustify;
    DBPlanner2.Sidebar.Alignment := taRightJustify;
  end
  else begin
    DBPlanner1.Sidebar.Width := DBPlanner1SidebarWidth;
    DBPlanner1.Sidebar.Alignment := taCenter;
    DBPlanner2.Sidebar.Width := DBPlanner2SidebarWidth;
    DBPlanner2.Sidebar.Alignment := taCenter;
  end;

end;

procedure TCalendarGUI.ApplicationEvents1ShowHint(var HintStr: string; var CanShow: boolean; var HintInfo: THintInfo);
begin
  inherited;
  if CanShow then begin
    HintInfo.HideTimeout  := 10000;
    Application.HintPause := 3000;
  end;
end;

procedure TCalendarGUI.dtpFromDateChange(Sender: TObject);
begin
  inherited;
  if not qryResources.Active then Exit;
  DatePicker1.DateTime := DBDaySource1.Day;
  self.SetQueryDateRange;
  opendb(qryAppointments);
  SetControlFocus(Self);
end;

procedure TCalendarGUI.DatePicker1Enter(Sender: TObject);
begin
  inherited;
//  DatePicker1Change(DatePicker1);
end;

procedure TCalendarGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
//  if DatePickerProcessing then begin
//    CloseWhenFinished:= true;
//    CanClose:= false;
//    exit;
//  end;
  inherited;

  if Appcontext['Calenderform'].VarExists('showing')  then
    if Appcontext['Calenderform'].Varbyname['showing'] = 'T' then begin
      CanClose:= false;
      Exit;
    end;

  if (fbPlacingAppointmentMode) and (fbEnsureAppointmentIsMade) then begin
    CommonLib.MessageDlgXP_Vista('You cannot close the Calendar at this time!' + #13#10#13#10 +
      'You must set and place an appointment time for a Representitive first.',
      mtWarning, [mbOK], 0);

    CanClose := false;
  end;
end;

procedure TCalendarGUI.txtwidthDayChange(Sender: TObject);
begin
  inherited;
  try
    if Empty(txtwidthDay.Text) then Exit;
    if EditNoAbort(tbTimeInc) then begin
      tbTimeInc.FieldByName('DayWidth').AsString := txtwidthDay.Text;
      DBPlanner1.PositionWidth := StrToInt(txtwidthDay.Text);
      DBPlanner1.UpdateControlState;
      tbTimeInc.Post;
      tbTimeInc.Edit;
    end;
  except
    CommonLib.MessageDlgXP_Vista('Invalid Value', mtWarning, [mbOK], 0);
  end;
end;

procedure TCalendarGUI.txtwidthWeekChange(Sender: TObject);
begin
  inherited;
  try
    if Empty(txtwidthWeek.Text) then Exit;
    if EditNoAbort(tbTimeInc) then begin
      tbTimeInc.FieldByName('WeekWidth').AsString := txtwidthWeek.Text;
      DBPlanner2.PositionWidth := StrToInt(txtwidthWeek.Text);
      DBPlanner2.UpdateControlState;
      tbTimeInc.Post;
      tbTimeInc.Edit;
    end;
  except
    CommonLib.MessageDlgXP_Vista('Invalid Value', mtWarning, [mbOK], 0);
  end;
end;

procedure TCalendarGUI.qryAppointmentsAfterOpen(DataSet: TDataSet);
begin
  inherited;
  showProgressbar('Please Wait...Processing '+IntToStr(qryAppointments.RecordCount) +' Appointments', qryAppointments.RecordCount, False );
  try
    if (Pagecontrol1.ActivePage = TabSheet1) then begin
      DBDaySource1.datasource:= AppointmentsDS;
      //RefreshCalender;
    end else if (Pagecontrol1.ActivePage = TabSheet2) then begin
      DBDaySource2.datasource:= AppointmentsDS;
      //RefreshCalender;
    end else if (Pagecontrol1.ActivePage = TabSheet3) then begin
          DBPlannerMonthView.datasource:= AppointmentsDS;
    end;
  finally
        HideProgressbarform;
  end;

  application.ProcessMessages;
  if not tbTimeInc.Active then Exit;
  DBPlanner1.Display.DisplayUnit := tbTimeInc.FieldByName('TimeInc').AsInteger;
  DBPlanner1.PositionWidth := tbTimeInc.FieldByName('DayWidth').AsInteger;
  DBPlanner2.Display.DisplayUnit := DBPlanner1.Display.DisplayUnit;
  DBPlanner2.PositionWidth := tbTimeInc.FieldByName('WeekWidth').AsInteger;
  DBPlanner1.UpdateControlState;
  DBPlanner2.UpdateControlState;
end;

procedure TCalendarGUI.DBPlanner1PlannerNext(Sender: TObject);
begin
  inherited;
  DatePicker1.DateTime := DBDaySource1.Day;
end;

procedure TCalendarGUI.DBPlanner1PlannerPrev(Sender: TObject);
begin
  inherited;
  DatePicker1.DateTime := DBDaySource1.Day;
end;

procedure TCalendarGUI.DBPlanner2PlannerPrev(Sender: TObject);
begin
  inherited;
  DatePicker1.DateTime := DBDaySource2.Day;
end;

procedure TCalendarGUI.DBPlanner2PlannerSideDrawAfter(Sender: TObject;
  Canvas: TCanvas; Rect: TRect; Index: Integer);
var
  dt, dtTo, dtZone: TDateTime;
  row, RowHeight: integer;
  oldSize: integer;
  hr,min,sec,msec: word;
  hrLocal,minLocal,secLocal,msecLocal: word;
  HoursWidth: integer;
  minStr, hrStr: string;
  PlannerGrid: TPlannerGrid;
  ZoneCount: integer;
  Zone: integer;
  o: TJsonObject;
  SideWidth: integer;
  SavePenColour: TColor;
const
  OneMin = 1/24/60;
  OneHour = 1/24;
begin
  inherited;
  ZoneCount := AppEnv.Employee.CalendarTimeZones.A['Zones'].Count;
  if ZoneCount = 0 then exit;

  Canvas.Font.Style := [];
  PlannerGrid := TPlannerGrid(Sender);
  SideWidth := TDBPlanner(PlannerGrid.Owner).Sidebar.Width div (ZoneCount + 1);
  RowHeight := TDBPlanner(PlannerGrid.Owner).Display.DisplayScale;
  oldSize := Canvas.Font.Size;
  Canvas.Font.Size := System.Round(Canvas.Font.Size * TDBPlanner(PlannerGrid.Owner).Sidebar.HourFontRatio);
  HoursWidth := Canvas.TextWidth('12');
  for Zone := 0 to ZoneCount -1 do begin
    o := AppEnv.Employee.CalendarTimeZones.A['Zones'].Items[Zone].AsObject;
    dt := DatePicker1.Date;
    dtTo := dt + 1;
    row := 0;
    while dt < dtTo do begin
      { clear the canvas }
      Canvas.Font.Style := [];
      SavePenColour := Canvas.Pen.Color;
      Canvas.Pen.Color := TDBPlanner(PlannerGrid.Owner).Sidebar.Background;
      Canvas.Brush.Color := TDBPlanner(PlannerGrid.Owner).Sidebar.Background;
      Canvas.Rectangle(Zone * SideWidth,((row - PlannerGrid.TopRow) * RowHeight) +2,Zone * SideWidth,(((row - PlannerGrid.TopRow) * RowHeight) + RowHeight) -2);

      Canvas.Pen.Color := SavePenColour;
      if row = PlannerGrid.TopRow then begin
        Canvas.Font.Size := oldSize + 1;
        if o.B['DST'] then
          Canvas.Font.Style := [fsUnderline];
        Canvas.TextOut((Zone * SideWidth) + (SideWidth - Canvas.TextWidth(o.S['ShortName'])),((row - PlannerGrid.TopRow) * RowHeight) + 2, o.S['ShortName']);
      end
      else if row > PlannerGrid.TopRow then begin
        if o.B['DST'] then
          dtZone := LocalToUTC(dt) + ((o.F['Offset'] + 1) * OneHour)
        else
          dtZone := LocalToUTC(dt) + (o.F['Offset'] * OneHour);
        DecodeTime(dtZone,hr,min,sec,msec);
        DecodeTime(dt,hrLocal,minLocal,secLocal,msecLocal);
        minStr := IntToStr(min);
//        if hr > 12 then
//          hr := hr - 12;
        hrStr := IntToStr(hr);
        while Length(minStr) < 2 do
          minStr := '0' + minStr;
        if minLocal = 0 then begin
          Canvas.Font.Size := System.Round(oldSize * TDBPlanner(PlannerGrid.Owner).Sidebar.HourFontRatio);
          Canvas.TextOut(3 + (Zone * SideWidth) + (HoursWidth - Canvas.TextWidth(hrStr)),((row - PlannerGrid.TopRow) * RowHeight) + 2, hrStr);
          Canvas.Font.Size := oldSize;
          Canvas.TextOut(3 + (Zone * SideWidth) +HoursWidth + 3,((row - PlannerGrid.TopRow) * RowHeight) + 2, minStr);
        end
        else begin
          Canvas.Font.Size := oldSize;
          Canvas.TextOut(3 + (Zone * SideWidth) + HoursWidth + 3,((row - PlannerGrid.TopRow) * RowHeight) + 2, minStr);
        end;

      end;
      Inc(row);
      dt := dt + (OneMin * TDBPlanner(PlannerGrid.Owner).Display.DisplayUnit);
    end;
  end;

end;

procedure TCalendarGUI.DBPlanner2PlannerNext(Sender: TObject);
begin
  inherited;
  DatePicker1.DateTime := DBDaySource2.Day;
end;

procedure TCalendarGUI.btnHolidaysClick(Sender: TObject);
Var Form : TComponent;
begin
  inherited;
    Form := GetComponentByClassName('TfrmPublicHolidaysGUI');
    if Assigned(Form) then begin
      With TBaseInputGUI(Form) do try
          showmodal;
          qryPublicHolidays.close;
          qryPublicHolidays.Open;
          DisplayifHoliday;
      finally
          Free;
      end;
    end;

end;

procedure TCalendarGUI.btnRequeryClick(Sender: TObject);
begin
  inherited;
  RefreshCalendar;
end;

procedure TCalendarGUI.SetPositionToCurrentTime;
var
    {RowsPerHour,}iNow: integer;
begin
  with DBPlanner1.Display do begin
     { RowsPerHour := (60 div DisplayUnit);}
     // DBPlanner1.GridTopRow :=  8 * RowsPerHour; // 8 am
     iNow := DBPlanner1.AbsTimeToCell(Now);
     DBPlanner1.GridTopRow := iNow;
  end;

   with DBPlanner2.Display do begin
     iNow := DBPlanner2.AbsTimeToCell(Now);
     DBPlanner2.GridTopRow := iNow;
  end;
end;

procedure TCalendarGUI.SilentFormShow(Sender : TObject);
var
  qry: TERPQuery;
  Count, iCnt: integer;
begin
  try
    // If you enter this form via the main switch (say), then KeyID will be Set
    // .. to 0 and if ReadOnly access the AccessLevel logic will kick the user out.
    // .. So, Set KeyId to 1 to trick AccessLevel logic and allow readonly access.
    KeyID := 1;
    inherited;
    try
      qryDeleteResources.Execute;
    except
    end;

    // Populate list of employees we want to show
    qryCalPrefs.Close;
    qryCalPrefs.ParamByName('xEmployeeID').asInteger := AppEnv.Employee.EmployeeID;
    qryCalPrefs.Open;

    if not (Sender.ClassName = 'TAdvStringGrid') then begin {DblClicked from grdResources AdvStringGrid}
      lstRepIDs.Clear;
      lstRepIDs.CommaText := qryCalPrefs.FieldByName('CalendarReps').AsString;
    end;

    lstRepIDs.Sort;

    //qryCreateResources.Prepared := true;
    qryCreateResources.Execute;

    qryAddResources.Close;
    //qryAddResources.Prepared := true;
    qryAddResources.Open;
    iCnt := 1;
    qry  := TERPQuery.Create(Self);
    with qry do try
        Connection := MyConnection;
        while not qryAddResources.Eof do begin
          if ShowThisRep(qryAddResources.FieldByName('EmployeeID').AsInteger) then begin
            qryChkResources.Close;
            qryChkResources.ParamByName('ID').asInteger := qryAddResources.FieldByName('EmployeeID').asInteger;
            qryChkResources.Open;
            if (qryChkResources.Eof and qryChkResources.bof) then begin
              Close;
              sql.Clear;
              sql.add('INSERT HIGH_PRIORITY INTO ' + sTblName + ' (ResourceID, EmployeeID, FirstName, LastName) values(');
              sql.add(Format('%d, %d, %s, %s)', [iCnt,

                qryAddResources.FieldByName('EmployeeID').AsInteger,
                QuotedStr(qryAddResources.FieldByName('FirstName').AsString),
                QuotedStr(qryAddResources.FieldByName('LastName').AsString)]));


              Execute;
              Inc(iCnt);
            end;
          end;
          qryAddResources.Next;
        end;
      finally
        // Release our used objects.
        if Assigned(qry) then FreeAndNil(qry);
      end;

    qryChkResources.Close;

    MakeResourceQry;

    try
      SetQueryDateRange;
      OpenDB(qryAppointments);
    except
      on EAbort do HandleEAbortException
      else raise;
    end;
    Count := qryResources.RecordCount;
    DBDaySource1.NumberOfResources := Count;
    DBDaySource2.NumberOfResources := Count;
    UpdateHeaders;
    UpdateHeaders2;
    DisplayifHoliday;
    //qryDeleteResources.Prepared := false;
    qryDeleteResources.Close;
    //qryCreateResources.Prepared := false;
    qryCreateResources.Close;
    tbTimeInc.Filter := 'EmployeeID = ' + IntToStr(AppEnv.Employee.EmployeeID);
    tbTimeInc.Open;
    tbTimeInc.Filtered := true;
    if tbTimeInc.RecordCount = 0 then begin
      tbTimeInc.Append;
      tbTimeInc.FieldByName('EmployeeID').AsInteger := AppEnv.Employee.EmployeeID;
      tbTimeInc.FieldByName('TimeInc').AsString := '30';
      tbTimeInc.Post;
      tbTimeInc.Close;
      tbTimeInc.Filtered := false;
      tbTimeInc.Filter := 'EmployeeID = ' + IntToStr(AppEnv.Employee.EmployeeID);
      tbTimeInc.Open;
      tbTimeInc.Filtered := true;
    end;
    DBPlanner1.Display.DisplayUnit := tbTimeInc.FieldByName('TimeInc').AsInteger;
    DBPlanner2.Display.DisplayUnit := tbTimeInc.FieldByName('TimeInc').AsInteger;
    DBPlanner1.PositionWidth := tbTimeInc.FieldByName('DayWidth').AsInteger;
    DBPlanner2.PositionWidth := tbTimeInc.FieldByName('WeekWidth').AsInteger;
    grdResources.ColWidths[0] := 20;
    grdResources.ColWidths[1] := 130;
    dtpFromDate.Text := FormatDateTime('dd/mm/yyyy', dtpFromDate.DateTime);
    /////////PageControl1.ActivePage := TTabSheet(TabSheet1);
    Displayifholiday;
    if AppEnv.Employee.Calender24hr then begin
      DBPlanner1.HourType := ht24hrs;
    end else begin
      DBPlanner1.HourType := ht12hrs;
    end;
    cboEmployee.LookupTable.First;
    cboEmployee.LookupValue := cboEmployee.LookupTable.FieldbyName(cboEmployee.LookupField).asString;
    SetPositionToCurrentTime;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;

end;

procedure TCalendarGUI.PlaceNewAppointment(MsgObj: TMsgObj);
begin
  fbPlacingAppointmentMode  := True;
  fNewAppointmentObjectName := MsgObj.SenderStr;
  fbEnsureAppointmentIsMade := MsgObj.BoolValue;
  FreeAndNil(MsgObj);
end;

function TCalendarGUI.IsPlacingAppointment(MsgObj: TMsgObj; out MsgRet: TMsgObj): Boolean;
begin
  Result := fbPlacingAppointmentMode;
  if Result then
    BringToFrontSoon;
  MsgRet := MsgObj;
end;

procedure TCalendarGUI.DBPlannerMonthViewGetDayProp(Sender: TObject; Date: TDateTime; var Caption: String; CaptionBrush: TBrush; AFont: TFont;
  var BKColor, BKColorTo: TColor);
var
  strHoliday:String;
begin
  inherited;
  strHoliday := GetHoliday(DateOf(Date));
  if strHoliday <> '' then begin
    BKColor := clInfoBk;
    BKColorTo := $00D6D6D6;
    Caption := strHoliday;
  end;
end;

procedure TCalendarGUI.DBPlannerMonthViewItemHint(Sender: TObject;
  Item: TPlannerItem; var Hint: string);
begin
  inherited;
  if StrUtils.RightStr(Hint,2) <> #13#10 then
    Hint := Hint + #13#10;
end;

procedure TCalendarGUI.DBPlanner2ItemHint(Sender: TObject; Item: TPlannerItem;
  var Hint: string);
begin
  inherited;
  if StrUtils.RightStr(Hint,2) <> #13#10 then
    Hint := Hint + #13#10;
end;

procedure TCalendarGUI.DBPlanner2PlannerBkgDraw(Sender: TObject;
  Canvas: TCanvas; Rect: TRect; Index, Position: Integer);
var
  strHoliday:String;
begin
  inherited;
  Rect.Left := Rect.Left +2;
  Rect.Top := Rect.Top +2;
  Rect.Right := Rect.Right -2;
  Rect.Bottom := Rect.Bottom -2;
  strHoliday := GetHoliday(DateOf(TDBPlanner(Sender).PosToDay(Position)));
  if strHoliday <> '' then begin
    Canvas.Brush.Color := $00F2F2F2;
    Canvas.FillRect(Rect);
  end;
  if DBPlanner2.Header.Captions[1] = '' then
    self.UpdateHeaders2;
end;

procedure TCalendarGUI.cboEmployeeCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  If not modified then Exit;
  inherited;
  SetQueryDateRange;
  OpenDB(qryAppointments);
end;

procedure TCalendarGUI.cboFollowUpResultCloseUp(Sender: TObject; LookupTable,
  FillTable: TDataSet; modified: Boolean);
begin
  inherited;
  self.SetQueryDateRange;
  opendb(qryAppointments);
  SetControlFocus(Self);
end;

procedure TCalendarGUI.DBDaySource1CreateKey(Sender: TObject;
  APlannerItem: TPlannerItem; var Key: String);
  function GetMax: integer;
  var
    qry: TERPQuery;
  begin
    qry := TERPQuery.Create(Self);
    with qry do try
        Options.FlatBuffers := True;
        Connection := CommonDbLib.GetSharedMyDacConnection;
        Sql.add('select max(AppointID) as Max from qryAppointments;');
        Open;
        Result := FieldByName('Max').AsInteger + 1;
      finally
        if Assigned(qry) then FreeAndNil(qry);
      end;
  end;
begin
  inherited;
  Key := IntToStr(GetMax);
end;

procedure TCalendarGUI.DBPlannerMonthViewDblClick(Sender: TObject; SelDate: TDateTime);
var
  AppointmentGUI: TBaseInputGUI;
  MsgObj: TMsgObj;
begin
  inherited;

    if fbPlacingAppointmentMode  then begin

    MsgObj := TMsgObj.Create;
    try
      MsgObj.SetAddress('TNewAppointment', 'EmployeeID', fNewAppointmentObjectName);
      if cboEmployee.LookupValue <> '' then begin
        MsgObj.IntValue := StrToInt(cboEmployee.LookupValue);
        fMsgHandler.Send(MsgObj, MsgObj);
      end;

      MsgObj.MethodStr := 'StartTime';
      MsgObj.DateTime := SelDate;
      fMsgHandler.Send(MsgObj, MsgObj);

      MsgObj.MethodStr := 'AppointmentPlaced';
      fMsgHandler.Send(MsgObj, MsgObj);
    Finally
      FreeAndNil(MsgObj);
    end;
    fbPlacingAppointmentMode := False;
    fNewAppointmentObjectName := '';
    DoBeforeClose;
    Close;
  end else begin
    AppointmentGUI := TBaseInputGUI(GetComponentByClassName('TAppointmentGUI'));
    if Assigned(AppointmentGUI) then begin
      AppointmentGUI.AttachObserver(Self);
        MsgObj := TMsgObj.Create;
        try
          MsgObj.SetAddress('TAppointmentGUI', 'InitEmployeeID');
          if cboEmployee.LookupValue <> '' then begin
            MsgObj.IntValue := StrToInt(cboEmployee.LookupValue);
            fMsgHandler.Send(MsgObj, MsgObj);
          end;

          MsgObj.MethodStr := 'InitStartTime';
          MsgObj.DateTime:= SelDate;
          fMsgHandler.Send(MsgObj, MsgObj);
        Finally
          FreeAndNil(MsgObj);
        end;
      end;
      WindowState := wsnormal;
      AppointmentGUI.FormStyle := fsMDIChild;
      AppointmentGUI.BringToFrontSoon;
 end;


 (*
  If MonthOf(SelDate) <> MonthOf(DBPlannerMonthView.Date) then exit;
  AppointmentGUI := TBaseInputGUI(GetComponentByClassName('TAppointmentGUI'));
  if Assigned(AppointmentGUI) then begin
    AppointmentGUI.AttachObserver(Self);
      MsgObj := TMsgObj.Create;
      try
        MsgObj.SetAddress('TAppointmentGUI', 'InitEmployeeID');
        MsgObj.IntValue := StrToInt(cboEmployee.LookupValue);
        fMsgHandler.Send(MsgObj, MsgObj);
        MsgObj.MethodStr := 'InitStartTime';
        MsgObj.DateTime := SelDate;
        fMsgHandler.Send(MsgObj, MsgObj);
      Finally
        FreeAndNil(MsgObj);
      end;
    AppointmentGUI.FormStyle := fsMDIChild;
    AppointmentGUI.BringToFrontSoon;
  end;*)
end;

procedure TCalendarGUI.PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
begin
  inherited;
  AllowChange :=True;
  if Pagecontrol1.ActivePage = TabSheet1 then dt:= DBPlanner1.CellToTime(DBPlanner1.SelPosition,DBPlanner1.SelItemBegin)
  else if Pagecontrol1.ActivePage = TabSheet2 then dt:= DBPlanner2.CellToTime(DBPlanner2.SelPosition,DBPlanner2.SelItemBegin)
  else if Pagecontrol1.ActivePage = TabSheet3 then dt:= DBPlannerMonthView.Date;
end;

procedure TCalendarGUI.chkAllRepsClick(Sender: TObject);
begin
  inherited;
  if chkAllReps.Checked then begin
    cboEmployee.Enabled := false;
  end else begin
    cboEmployee.Enabled := true;
  end;
  SetQueryDateRange;
  OpenDB(qryAppointments);
end;

procedure TCalendarGUI.SetQueryDateRange;
begin
  Removedatasources;
  CloseDb(qryAppointments);
  lblfilter.caption := '';
  if (Pagecontrol1.ActivePage = TabSheet1) then begin
    qryAppointments.ParamByName('xDateFrom').AsDateTime:= DatePicker1.Date;
    qryAppointments.ParamByName('xDateTo').AsDateTime:= DatePicker1.Date;
    qryAppointments.ParamByName('xTrainerID').asInteger := 0;
    lblfilter.caption := 'Appointment Date = ' +FormatDatetime(FormatSettings.shortdateformat ,DatePicker1.Date);
  end else if (Pagecontrol1.ActivePage = TabSheet2) then begin
    qryAppointments.ParamByName('xDateFrom').AsDateTime:= DatePicker1.Date;
    qryAppointments.ParamByName('xDateTo').AsDateTime:= DatePicker1.Date + 7;
    qryAppointments.ParamByName('xTrainerID').asInteger := 0;
    lblfilter.caption := 'Appointment Date Between ' +FormatDatetime(FormatSettings.shortdateformat ,DatePicker1.Date) + ' and ' + FormatDatetime(FormatSettings.shortdateformat ,DatePicker1.Date+6);
  end else begin
    qryAppointments.ParamByName('xDateFrom').AsDateTime:= dtpFromDate.Date;
    qryAppointments.ParamByName('xDateTo').AsDateTime:= (*DatePicker1.*)dtpFromDate.Date + 45;
    lblfilter.caption := 'Appointment Date Between ' +FormatDatetime(FormatSettings.shortdateformat ,(*DatePicker1.*)dtpFromDate.Date) + ' and ' + FormatDatetime(FormatSettings.shortdateformat ,(*DatePicker1.*)dtpFromDate.Date+44);
    If cboEmployee.Enabled then Begin
      qryAppointments.ParamByName('xTrainerID').asInteger := qryResources.fieldbyname('EmployeeID').asInteger;
      lblfilter.caption := lblfilter.caption + ' and Trainer = ' +qryResources.fieldbyname('FullName').asString;
    end else begin
      qryAppointments.ParamByName('xTrainerID').asInteger := 0;
    end;
  end;
  qryAppointments.ParamByName('xStatus').asString:= cboFollowUpResult.text;
  if cboFollowUpResult.text <> '' then begin
      lblfilter.caption := lblfilter.caption + ' and  Status = ' +cboFollowUpResult.text;
  end;
end;



procedure TCalendarGUI.DBPlanner1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  inherited;
  fiTrainerID := GetEmployeeFromResource(StrToInt(TDBPlanner(Sender).Header.Captions[X+1])-1);
  DBPlanner1.UpdateItem(TDBPlanner(Sender).Items.Items[0]);
  fColumn := x;
end;

procedure TCalendarGUI.DBPlanner1DragDropCell(Sender, Source: TObject; X,
  Y: Integer);
begin
  inherited;
  fiTrainerID := GetEmployeeFromResource(StrToInt(TDBPlanner(Sender).Header.Captions[X+1])-1);
end;

procedure TCalendarGUI.DBPlanner1DragDropHeader(Sender, Source: TObject;
  Position: Integer);
begin
  inherited;
  fiTrainerID := GetEmployeeFromResource(StrToInt(TDBPlanner(Sender).Header.Captions[Position+1])-1);
end;

procedure TCalendarGUI.DBPlanner1DragDropItem(Sender, Source: TObject; X,
  Y: Integer; PlannerItem: TPlannerItem);
begin
  inherited;
  fiTrainerID := GetEmployeeFromResource(StrToInt(TDBPlanner(Sender).Header.Captions[X+1])-1);

  fiTrainerID := GetEmployeeFromPosition(X);
  PlannerItem.Update;
end;

procedure TCalendarGUI.DBPlanner1EndDrag(Sender, Target: TObject; X,
  Y: Integer);
begin
  inherited;
  fiTrainerID := GetEmployeeFromResource(StrToInt(TDBPlanner(Sender).Header.Captions[X+1])-1);
  TDBPlanner(Sender).ItemSource.Refresh;
end;

procedure TCalendarGUI.DBPlanner1ItemMove(Sender: TObject; Item: TPlannerItem;
  FromBegin, FromEnd, FromPos, ToBegin, ToEnd, ToPos: Integer);
var
  AppSource, AppDest: TAppointment;
begin
  inherited;
  if qryAppointments.FieldByName('TrainerID').AsInteger <> GetEmployeeFromResource(item.ItemPos) then begin
    { if we are synching with google we need to keep a copy of the appointment for old trainer so that can be deleted }
    if qryAppointments.FieldByName('SynchWithGoogle').AsBoolean and
      (qryAppointments.FieldByName('GoogleId').AsString <> '') and
      (AppEnv.CompanyPrefs.GoogleCalendarConfig.SynchWithGoogleCalendar and
       (AppEnv.CompanyPrefs.GoogleCalendarConfig.LastServerId = AppEnv.ServerID)) then begin
      { make a copy of the old appointment }
      AppSource := TAppointment.CreateWithSharedConn(nil);
      AppDest := TAppointment.CreateWithSharedConn(nil);
      try
        AppSource.Load(qryAppointments.FieldByName('AppointID').AsInteger);
        AppDest.Load(0);
        AppDest.New;
        AppDest.XML := AppSource.XML;
        AppDest.Active := false;
        AppDest.PostDb;
        AppEnv.GoogleUpdater.UpdateCalendar(AppDest.ID, AppEnv.ServerID);

      finally
        AppSource.Free;
        AppDest.Free;
      end;
      { now for a different employee's calender so clear old calenderId }
      EditDb(qryAppointments);
      qryAppointments.FieldByName('GoogleId').AsString := '';
    end;
  end;
end;

procedure TCalendarGUI.DBPlanner2ItemMove(Sender: TObject; Item: TPlannerItem;
  FromBegin, FromEnd, FromPos, ToBegin, ToEnd, ToPos: Integer);
var
  AppSource, AppDest: TAppointment;
begin
  inherited;
  if DBPlanner2.Header.Captions[1] = '' then
    self.UpdateHeaders2;
  if qryAppointments.FieldByName('TrainerID').AsInteger <> GetEmployeeFromResource(StrToInt(DBPlanner2.Header.Captions[Item.ItemPos+1])-1) then begin
    { if we are synching with google we need to keep a copy of the appointment for old trainer so that can be deleted }
    if qryAppointments.FieldByName('SynchWithGoogle').AsBoolean and
      (qryAppointments.FieldByName('GoogleId').AsString <> '') and
      (AppEnv.CompanyPrefs.GoogleCalendarConfig.SynchWithGoogleCalendar and
       (AppEnv.CompanyPrefs.GoogleCalendarConfig.LastServerId = AppEnv.ServerID)) then begin
      { make a copy of the old appointment }
      AppSource := TAppointment.CreateWithSharedConn(nil);
      AppDest := TAppointment.CreateWithSharedConn(nil);
      try
        AppSource.Load(qryAppointments.FieldByName('AppointID').AsInteger);
        AppDest.Load(0);
        AppDest.New;
        AppDest.XML := AppSource.XML;
        AppDest.Active := false;
        AppDest.PostDb;
        AppEnv.GoogleUpdater.UpdateCalendar(AppDest.ID, AppEnv.ServerID);

      finally
        AppSource.Free;
        AppDest.Free;
      end;
      { now for a different employee's calender so clear old calenderId }
      EditDb(qryAppointments);
      qryAppointments.FieldByName('GoogleId').AsString := '';
    end;
  end;
end;

procedure TCalendarGUI.DBDaySource1ItemToFields(Sender: TObject;
  Fields: TFields; Item: TPlannerItem);
begin
  inherited;
  qryAppointments.FieldByName('TrainerID').AsInteger := GetEmployeeFromResource(item.ItemPos);
  DBPlanner1.Items.Selected.Update;
  qryAppointments.Post;
  if qryAppointmentsSynchWithGoogle.AsBoolean then
    AppEnv.GoogleUpdater.UpdateCalendar(self.qryAppointmentsAppointID.AsInteger, AppEnv.ServerID);
  qryAppointments.Edit;
end;

procedure TCalendarGUI.DBPlannerMonthViewItemToFields(Sender: TObject;
  Fields: TFields; Item: TPlannerItem);
begin
  inherited;
//  qryAppointments.FieldByName('TrainerID').AsInteger := GetEmployeeFromResource(item.ItemPos);
  if not Assigned(DBPlannerMonthView.Items.Selected) then exit;

  DBPlannerMonthView.Items.Selected.Update;
  PostDb(qryAppointments);
  if qryAppointmentsSynchWithGoogle.AsBoolean then
    AppEnv.GoogleUpdater.UpdateCalendar(self.qryAppointmentsAppointID.AsInteger, AppEnv.ServerID);
  qryAppointments.Edit;
end;



//function TCalendarGUI.GetEmployeeFromResource(Name: String): integer;
//begin
//  result:= GetEmployeeFromResource(getemployeeID(Name));
//end;

function TCalendarGUI.GetEmployeeFromPosition(Const iPosition: integer): integer;
begin
  if qryResources.Locate('ResourceID', iPosition, [loCaseInsensitive]) then begin
    Result := qryResources.FieldByName('EmployeeID').AsInteger;
  end else begin
    //CommonLib.MessageDlgXP_Vista('GetEmployeeFromPosition: Could not Match Employee with Position', mtWarning, [mbOK], 0);
    Result := 0;
  end;
end;

procedure TCalendarGUI.DBPlannerMonthViewDateChange(Sender: TObject;
  origDate, newDate: TDateTime);
begin
  inherited;
  dtpFromDate.DateTime:= DBPlannerMonthView.FirstDate;
  //DatePicker1.DateTime:= DBPlannerMonthView.FirstDate;
end;

function TCalendarGUI.RepairExists(const repairID: Integer): boolean;
begin
  with CommonDbLib.TempMyQuery do try
    SQL.add('Select repairID from tblRepairs where repairId = ' +IntToStr(repairID));
    open;
    result := recordcount >0;
    if not result then
      CommonLib.MessageDlgXP_Vista('Appointment #' +IntToStr(qryAppointments.FieldByName('AppointID').AsInteger)+' is linked to Deleted Repair #' +IntToStr(RepairID)+'.' +chr(13) +
              'We would Recommend that You Delete the Appointment and Recreate it.' , mtInformation, [mbok],0);
  finally
      if active then close;
      Free;
  end;
end;

procedure TCalendarGUI.RefreshCalendar;
begin
  self.SetQueryDateRange;
  opendb(qryAppointments);
  SetControlFocus(Self);
end;

procedure TCalendarGUI.Removedatasources;
begin
  DBDaySource1.datasource:= nil;
  DBDaySource2.datasource:= nil;
  DBPlannerMonthView.datasource:= nil;
end;

procedure TCalendarGUI.qryAppointmentsAfterScroll(DataSet: TDataSet);
begin
  inherited;
  stepProgressbar;
end;

procedure TCalendarGUI.qryAppointmentsBeforePost(DataSet: TDataSet);
begin
  inherited;
  if qryAppointmentsAppDate.asDateTime <> dateof(qryAppointmentsSTARTTIME.asDAtetime) then
    qryAppointmentsAppDate.asDateTime:=dateof(qryAppointmentsSTARTTIME.asDAtetime);
end;

procedure TCalendarGUI.tmrProgressTimer(Sender: TObject);
begin
  inherited;
  HideProgressbar;
  tmrProgress.enabled := False;
end;

initialization
  RegisterClassOnce(TCalendarGUI);
end.



