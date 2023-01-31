unit FuncBookingsCalForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  Planner,
  DBPlanner, ComCtrls, StdCtrls, Buttons, DNMSpeedButton, Grids, BaseGrid, AdvGrid,
  wwdbdatetimepicker, ExtCtrls, DNMPanel, wwdblook, DBCtrls, Mask,
  wwdbedit, Wwdotdot, Wwdbcomb, DBAccess, MyAccess, DataState, Menus, AdvMenus, MemDS,
  Shader;

type
  TFuncBookingsCalGUI = class(TBaseInputGUI)
    PageControl1: TPageControl;
    tabDaily: TTabSheet;
    tabWeekly: TTabSheet;
    tabMonthly: TTabSheet;
    plannerDay: TDBPlanner;
    DaySource: TDBDaySource;
    qryFuncRoomAllocations: TMyQuery;
    dsDaySource: TDataSource;
    qryFuncRooms: TMyQuery;
    btnSave: TDNMSpeedButton;
    btnPrint: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    lstColorBox: TListBox;
    lstFontColor: TListBox;
    qryFuncBookings: TMyQuery;
    dsWeekSource: TDataSource;
    WeekSource: TDBHalfDayPeriodSource;
    plannerWeek: TDBPlanner;
    dtpDate: TwwDBDateTimePicker;
    dsMonthSource: TDataSource;
    plannerMonth: TDBPlanner;
    MonthSource: TDBWeekSource;
    btnClose: TDNMSpeedButton;
    tabResources: TTabSheet;
    qryFuncRes: TMyQuery;
    PageControlRes: TPageControl;
    tabResByRoom: TTabSheet;
    tabResByHr: TTabSheet;
    DNMPanel2: TDNMPanel;
    Label1: TLabel;
    grdRes: TAdvStringGrid;
    cboFuncRes: TwwDBLookupCombo;
    DNMPanel3: TDNMPanel;
    grdResByRoom: TAdvStringGrid;
    cboRoom: TwwDBLookupCombo;
    Label2: TLabel;
    lblResAvailableLabel: TLabel;
    lblResAvailable: TLabel;
    cboTimeInc: TwwDBComboBox;
    Label3: TLabel;
    lblNone: TLabel;
    qryFuncRoomPositions: TMyQuery;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DaySourceResetFilter(Sender: TObject);
    procedure DaySourceResourceToPosition(Sender: TObject; Field: TField; var Position: integer; var Accept: boolean);
    procedure btnSaveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure DaySourceItemToFields(Sender: TObject; Fields: TFields; Item: TPlannerItem);
    procedure btnCancelClick(Sender: TObject);
    procedure DaySourceFieldsToItem(Sender: TObject; Fields: TFields; Item: TPlannerItem);
    procedure DaySourcePositionToResource(Sender: TObject; Field: TField; Position: integer);
    procedure plannerDayItemDblClick(Sender: TObject; Item: TPlannerItem);
    procedure plannerDayPlannerDblClick(Sender: TObject; Position, FromSel, FromSelPrecise, ToSel, ToSelPrecise: integer);
    procedure WeekSourceResetFilter(Sender: TObject);
    procedure dtpDateChange(Sender: TObject);
    procedure MonthSourceResetFilter(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure cboFuncResCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboRoomCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
    procedure cboTimeIncCloseUp(Sender: TwwDBComboBox; Select: boolean);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: boolean);

  private
    { Private declarations }
    bIsSaved: boolean;
    bIsModified: boolean;
    procedure InitPlanners;
    procedure UpdateHeaders(planner: TDBPlanner);
    procedure SetItemColour(Item: TPlannerItem; iFuncTypeID: integer; bNoText: boolean = false);
    procedure InitResGrid;
    procedure InitResByRoomGrid;
    procedure LoadFuncResources;
    procedure LoadResByRoom;
  public
    { Public declarations }
    procedure UpdateMe; override;
    

  end;

//var
//  FuncBookingsCalGUI: TFuncBookingsCalGUI;

implementation

{$R *.dfm}
uses
  DNMExceptions, CommonDbLib, DNMLib, DateUtils,  
  FuncBookingForm,  CommonLib, AppEnvironment, FastFuncs;

procedure TFuncBookingsCalGUI.FormShow(Sender: TObject);
var
  iTimeInc: integer;
begin
  // If you enter this form via the main switch (say), then KeyID will be Set
  // .. to 0 and, if ReadOnly access, then the AccessLevel logic will kick the user out.
  // .. So, Set KeyId to 1 to trick AccessLevel logic and allow readonly access.
  KeyID := 1;  // set keyID even though it's not used

  try

    // All or Read Only or None
    if AccessLevel <> 6 then begin
      if AccessLevel <> 1 then begin
        AccessLevel := 5;
      end;
    end;
    inherited;

    //BeginTransaction;
    OpenQueries;

    if (qryFuncRooms.RecordCount = 0) then begin
      CommonLib.MessageDlgXP_Vista('No Rooms''s to Assign to the Roster.', mtInformation, [mbOK], 0);
      Self.Close;
      Exit;
    end;

    iTimeInc        := GetCalendarTimeInc(CAL_FUNCS, AppEnv.Employee.EmployeeID);
    cboTimeInc.Text := FastFuncs.IntToStr(iTimeInc);

    PageControlRes.ActivePage := tabResByRoom;
    PageControl1.ActivePage   := tabDaily;
    PageControl1Change(Sender);
    InitPlanners;
    InitResGrid;
    InitResByRoomGrid;
  except
    on EAbort do HandleEAbortException;
    on e: ENoAccess do HandleNoAccessException(e);
    else raise;
  end;
end;

procedure TFuncBookingsCalGUI.InitPlanners;
var
  iGridLeftCol: integer;
begin
  //  PopulateClassGrids;

  DaySource.DateFormat := 'dddd  dd mmm yyyy';
  DaySource.Day := Now;
  DaySource.AutoHeaderUpdate := true;
  PlannerDay.StreamPersistentTime := true;
  PlannerDay.Header.AutoSize := true;
  plannerDay.PositionWidth := 100;
  plannerDay.Caption.Visible := false;
  plannerDay.DefaultItem.ReadOnly := true;
  plannerDay.HintPause := 7000;
  plannerDay.Display.DisplayUnit := FastFuncs.StrToInt(cboTimeInc.Text);
  plannerDay.Header.Height := 45;
  plannerDay.Header.ItemHeight := 45;
  plannerDay.Header.TextHeight := 45;

  //DaySource.DateFormat:='dddd  dd mmm yyyy';
  //WeekSource.StartDate := IncDay(Now(), -5);
  WeekSource.AutoHeaderUpdate := true;
  PlannerWeek.StreamPersistentTime := true;
  PlannerWeek.Header.AutoSize := true;
  PlannerWeek.Sidebar.Width := 80;
  plannerWeek.PositionWidth := 100;
  plannerWeek.Caption.Visible := false;
  plannerWeek.Display.ShowCurrent := true;
  plannerWeek.DefaultItem.ReadOnly := true;
  plannerWeek.HintPause := 7000;

  MonthSource.AutoHeaderUpdate := true;
  plannerMonth.MultiSelect := true;
  plannerMonth.Display.DisplayEnd := 40;
  plannerMonth.Caption.Title := 'Bookings By Month';
  plannerMonth.Display.ShowCurrent := true;
  PlannerMonth.StreamPersistentTime := true;
  PlannerMonth.Header.AutoSize := true;
  PlannerMonth.Sidebar.Width := 45;
  plannerMonth.PositionWidth := 50;
  plannerMonth.Header.Height := 100;
  plannerMonth.Header.TextHeight := 100;
  plannerMonth.Caption.Visible := false;
  plannerMonth.DefaultItem.ReadOnly := true;
  plannerMonth.HintPause := 7000;

  iGridLeftCol := DayOfTheMonth(Date()) - 5;
  if iGridLeftCol < 0 then begin
    plannerMonth.GridLeftCol := 0;
  end else begin
    plannerMonth.GridLeftCol := iGridLeftCol;
  end;

  if qryFuncRooms.RecordCount > 9 then begin
    WeekSource.NumberOfResources  := qryFuncRooms.RecordCount;
    MonthSource.NumberOfResources := qryFuncRooms.RecordCount;
    DaySource.NumberOfResources   := qryFuncRooms.RecordCount;
  end else begin
    MonthSource.NumberOfResources := 9;
    WeekSource.NumberOfResources  := 9;
    DaySource.NumberOfResources   := 9;
  end;


  dtpDate.Date := Date;  // Planner dates is set via the dtp's OnChange event

  UpdateHeaders(plannerDay);
  UpdateHeaders(plannerWeek);
  UpdateHeaders(plannerMonth);
end;

procedure TFuncBookingsCalGUI.UpdateHeaders(planner: TDBPlanner);
begin
  planner.Header.Color := $00FFDDC6;
  planner.Header.Captions.Clear;
  planner.Header.Captions.Add('');

  if qryFuncRooms.Active then begin
    with qryFuncRooms do begin
      First;
      while not Eof do begin
        planner.Header.Captions.Add(FieldByName('Name').AsString);
        Next;
      end;
    end;
  end;
end;

procedure TFuncBookingsCalGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  Action := caFree;
end;

procedure TFuncBookingsCalGUI.FormCreate(Sender: TObject);
begin
  inherited;
  fbIgnoreAccessLevels := true;
  bIsSaved := false;
  bIsModified := false;
end;

procedure TFuncBookingsCalGUI.DaySourceResetFilter(Sender: TObject);
begin
  inherited;
  UpdateHeaders(plannerDay);
end;

procedure TFuncBookingsCalGUI.DaySourceResourceToPosition(Sender: TObject; Field: TField;
  var Position: integer; var Accept: boolean);
begin
  if qryFuncRoomPositions.Locate('RoomID', Field.AsInteger, [loCaseInsensitive]) then begin
    Position := qryFuncRoomPositions.RecNo - 1;
  end else begin
    Position := Field.AsInteger - 1;  // not a great default!!!!
  end;
end;

procedure TFuncBookingsCalGUI.btnSaveClick(Sender: TObject);
begin
  inherited;
  //CommitTransaction;
  bIsSaved := true;
  Close;
end;

procedure TFuncBookingsCalGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
  //var
  //  iResult: integer;
begin
  inherited;
(*
  if not bIsSaved then begin
    if bIsModified then begin
      iResult := CommonLib.MessageDlgXP_Vista('Do you wish to keep any Changes you have made ?', mtConfirmation,[mbYes, mbNo, mbCancel], 0);
      Case iResult of
        mrYes: begin
          CanClose := false;
          btnSave.Click;
        end;
        mrNo: RollbackTransaction;
        mrCancel: CanClose := false;
      end;
    end;
  end;
*)
end;

procedure TFuncBookingsCalGUI.DaySourceItemToFields(Sender: TObject; Fields: TFields; Item: TPlannerItem);
begin
  inherited;
  Fields.FieldByName('RoomAllocDate').AsDateTime := DateOf(Fields.FieldByName('Start').AsDateTime);
  // update dummy text times for display in booking form
  Fields.FieldByName('StartDummy').AsString := FormatDateTime('hh:nn', Item.ItemStartTime);
  Fields.FieldByName('EndDummy').AsString := FormatDateTime('hh:nn', Item.ItemEndTime);

  bIsModified := true;
end;

procedure TFuncBookingsCalGUI.btnCancelClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFuncBookingsCalGUI.SetItemColour(Item: TPlannerItem; iFuncTypeID: integer; bNoText: boolean = false);
var
  i: integer;
begin
  i := iFuncTypeID mod lstColorBox.Count;
  Item.Color := StringToColor(lstColorBox.Items[i]);
  if bNoText then begin
    Item.Font.Color := Item.Color;
  end else begin
    if i <= lstFontColor.Count then begin
      Item.Font.Color := StringToColor(lstFontColor.Items[i]);
    end else begin
      Item.Font.Color := clRed;
    end;
  end;
  Item.CaptionFont.Color := Item.Font.Color;
end;

procedure TFuncBookingsCalGUI.DaySourcePositionToResource(Sender: TObject; Field: TField; Position: integer);
begin
  inherited;
  qryFuncRoomPositions.RecNo := Position + 1;
  Field.AsInteger := qryFuncRoomPositions.FieldByName('RoomID').AsInteger;
end;

procedure TFuncBookingsCalGUI.UpdateMe;
begin
  inherited;
  // after return from booking form we need to refresh
  DaySource.Active := false;
  MonthSource.Active := false;
  WeekSource.Active := false;
  plannerDay.Refresh;
  qryFuncBookings.Close;
  qryFuncBookings.Open;
  qryFuncRoomAllocations.Close;
  qryFuncRoomAllocations.Open;
  PageControl1Change(nil);

  // plannerDay.Update;
  // plannerWeek.Update;
  // plannerMonth.Update;
end;

procedure TFuncBookingsCalGUI.WeekSourceResetFilter(Sender: TObject);
begin
  inherited;
  UpdateHeaders(plannerWeek);
end;

procedure TFuncBookingsCalGUI.dtpDateChange(Sender: TObject);
begin
  inherited;

  MonthSource.Month := MonthOfTheYear(dtpDate.Date);
  MonthSource.Year := YearOf(dtpDate.Date);
  WeekSource.EndDate := 50000;
  WeekSource.StartDate := IncDay(dtpDate.Date, - 10);
  WeekSource.EndDate := IncDay(WeekSource.StartDate, 30);
  WeekSource.DataSource := nil;  // just to give it a kcik - could probably remove
  WeekSource.DataSource := dsWeekSource;
  DaySource.Day := dtpDate.Date;
  if PageControl1.ActivePage = tabResources then begin
    LoadFuncResources;
    LoadResByRoom;
  end;
end;

procedure TFuncBookingsCalGUI.MonthSourceResetFilter(Sender: TObject);
begin
  inherited;
  UpdateHeaders(plannerMonth);
end;

procedure TFuncBookingsCalGUI.DaySourceFieldsToItem(Sender: TObject; Fields: TFields; Item: TPlannerItem);
begin
  inherited;

  if TItemSource(Sender) = MonthSource then begin
    Item.Shape := psRounded;
  end else begin
    Item.CaptionType := ctTime;
    Item.WordWrap    := true;
    qryFuncBookings.Open; // just in case its closed
  end;

  Item.Text.Clear;
  if qryFuncBookings.Locate('FuncBookingID', Fields.FieldByName('FuncBookingID').AsInteger, [loCaseInsensitive]) then begin
    // Add these text labels.
    Item.Text.Add(qryFuncBookings.FieldByName('FuncTypeName').AsString);
    Item.Text.Add(qryFuncBookings.FieldByName('Company').AsString);
    Item.Text.Add('--------------------------');
    Item.Text.Add(qryFuncBookings.FieldByName('BookingDescription').AsString);
    Item.Text.Add('--------------------------');
    Item.Text.Add('Reset: ' + FormatDateTime('hh:nn', Fields.FieldByName('ResetTime').AsDateTime));
    SetItemColour(Item, qryFuncBookings.FieldByName('FuncTypeID').AsInteger, (TItemSource(Sender) = MonthSource));
  end else begin
    Item.Text.Add('Unknown');
    SetItemColour(Item, 0);
  end;


  // Set item so that its level of control reflects the AccessLevel of the user

  if (TItemSource(Sender) = WeekSource) or (TItemSource(Sender) = MonthSource) then begin
    Item.FixedSize := true;  // freeze size for these items
  end else begin
    Item.FixedSize := (AccessLevel <> 1);
  end;

  if (TItemSource(Sender) = WeekSource) then begin
    Item.FixedPos := true;  // freeze item position for 1/2 day planner cuz it doesn't work
  end else begin
    Item.FixedPos := (AccessLevel <> 1);
  end;
end;


procedure TFuncBookingsCalGUI.plannerDayItemDblClick(Sender: TObject; Item: TPlannerItem);
var
  frm: TFuncBookingGUI;
begin
  inherited;
  plannerDay.Items.UnSelectAll; //if I don't do these unselects then I get an access vioaltions
  plannerWeek.Items.UnSelectAll;
  plannerMonth.Items.UnSelectAll;
  plannerDay.Refresh;
  plannerWeek.Refresh;
  plannerMonth.Refresh;
  Application.ProcessMessages;
  if qryFuncRoomAllocations.FieldByName('FuncBookingID').AsInteger <> 0 then begin
    frm := TFuncBookingGUI(GetComponentByClassName('TFuncBookingGUI'));
    if Assigned(frm) then begin //if has acess
      frm.AttachObserver(Self);
      frm.KeyID     := qryFuncRoomAllocations.FieldByName('FuncBookingID').AsInteger;
      frm.FormStyle := fsMDIChild;
      frm.BringToFront;
    end;
  end;
end;

procedure TFuncBookingsCalGUI.plannerDayPlannerDblClick(Sender: TObject;
  Position, FromSel, FromSelPrecise, ToSel, ToSelPrecise: integer);
var
  frm: TFuncBookingGUI;
begin
  inherited;

  // if they double click the planner then they want to create a new booking
  // .. so open the booking form

  frm := TFuncBookingGUI(GetComponentByClassName('TFuncBookingGUI'));
  if Assigned(frm) then begin //if has acess
    frm.AttachObserver(Self);
    frm.KeyID := 0;
    frm.fdtDate := Date;
    frm.fiRoomID := Position + 1;
    frm.fdtStartBooking := TDBPlanner(Sender).CellToTime(1, TDBPlanner(Sender).SelItemBegin);

    // i think that this will always be the same cell for a dbl click
    // .. (ie SelItemBegin = SelItemEnd)

    frm.fdtEndBooking := TDBPlanner(Sender).CellToTime(1, TDBPlanner(Sender).SelItemEnd);

    frm.FormStyle := fsMDIChild;
    frm.BringToFront;
  end;  
end;

procedure TFuncBookingsCalGUI.PageControl1Change(Sender: TObject);
begin
  inherited;
  // the planners aren't hooked up till we need them...
  if PageControl1.ActivePage = tabDaily then begin
    if not DaySource.Active then begin
      DaySource.Active := true;
    end;
    plannerDay.Items.UnSelectAll;
  end else if PageControl1.ActivePage = tabWeekly then begin
    if not WeekSource.Active then begin
      WeekSource.Active := true;
    end;
    plannerWeek.Items.UnSelectAll;
  end else if PageControl1.ActivePage = tabMonthly then begin
    if not MonthSource.Active then begin
      MonthSource.Active := true;
    end;
    plannerMonth.Items.UnSelectAll;
  end else if PageControl1.ActivePage = tabResources then begin
    LoadFuncResources;
    LoadResByRoom;
  end;
end;

procedure TFuncBookingsCalGUI.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TFuncBookingsCalGUI.LoadFuncResources;
var
  qry: TMyQuery;
  i: integer;
  iTotal: integer;
  iHr: integer;
  dtHr: TDateTime;
begin
  lblResAvailableLabel.Visible := not Empty(cboFuncRes.Text);
  lblResAvailable.Visible := not Empty(cboFuncRes.Text);
  lblResAvailable.Caption := qryFuncRes.FieldByName('Qty').AsString;
  grdRes.ClearNormalCells;
  if Empty(cboFuncRes.Text) then begin
    Exit;
  end;

  qry := TMyQuery.Create(Self);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT FuncResourceAllocationID,FuncResourceID, ' +
      ' R.FuncBookingID, R.RoomAllocationID,  ResourceName, RoomID, ' +
      '	Start, End, MAX(Qty) as Qty ' +
      'FROM tblFuncResourceAllocation as R ' +
      '	INNER JOIN tblFuncRoomAllocation as A using (RoomAllocationID) ' +
      'WHERE :xHourOfDay BETWEEN A.Start AND A.End ' +
      ' AND FuncResourceID = :xFuncResourceID ' +
      'GROUP BY A.RoomID ');

    for iHr := 0 to 23 do begin
      dtHr := IncHour(dtpDate.Date, iHr);
      dtHr := IncMinute(dtHr);
      qry.Close;
      qry.ParamByName('xFuncResourceID').AsInteger := qryFuncRes.FieldByName('FuncResourceID').AsInteger;
      qry.ParamByName('xHourOfDay').asDateTime :=  dtHr;
      qry.Open;

      // for each room....
      iTotal := 0;
      for i := 1 to grdRes.RowCount - 2 do begin // first row is header & last row is footer
        if qry.Locate('RoomID', FastFuncs.StrToInt(grdRes.Cells[25, i]), [loCaseInsensitive]) then begin
          grdRes.Cells[iHr + 1, i] := qry.FieldByName('Qty').AsString;
          iTotal := iTotal + qry.FieldByName('Qty').AsInteger;
        end;
      end;

      // show totals for each hour in footer
      //grdRes.ClearRows(grdRes.RowCount-1, 1);
      if iTotal > 0 then begin
        grdRes.Cells[iHr + 1, grdRes.RowCount - 1] := FastFuncs.IntToStr(iTotal);
      end else begin
        grdRes.Cells[iHr + 1, grdRes.RowCount - 1] := '';
      end;
    end; // for iHr := 0 to 23
  finally
    FreeAndNil(qry);
  end;
end;

procedure TFuncBookingsCalGUI.InitResGrid;
  // note that by resources here we mean tables chairs etc - not the calendar resourses which for us are rooms
  // All we do here is initialize the string grid
var
  i: integer;
  dtHr: TDateTime;
begin
  i := 0;
  grdRes.RowCount := qryFuncRooms.RecordCount + 2;

  // rooms
  qryFuncRooms.First;
  while not qryFuncRooms.Eof do begin
    grdRes.Cells[0, i + 1]  := qryFuncRooms.FieldByName('Name').AsString;
    grdRes.Cells[25, i + 1] := qryFuncRooms.FieldByName('RoomID').AsString;  // this is hidden later
    Inc(i);
    qryFuncRooms.Next;
  end;

  // hours
  dtHr := TimeOf(0);
  for i := 0 to 23 do begin
    grdRes.Cells[i + 1, 0] := FormatDateTime('hh:nn', dtHr);
    dtHr := IncHour(dtHr);
  end;

  grdRes.HideColumn(25);
  grdRes.ScrollInView(24, 1);
end;

procedure TFuncBookingsCalGUI.InitResByRoomGrid;
begin
  grdResByRoom.ColWidths[5] := 150;
end;


procedure TFuncBookingsCalGUI.cboFuncResCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  LoadFuncResources;
end;

procedure TFuncBookingsCalGUI.LoadResByRoom;
const
  COL_BOOKING  = 0;
  COL_RES      = 1;
  COL_QTY      = 2;
  COL_FROM     = 3;
  COL_TO       = 4;
  COL_FUNCTYPE = 5;
var
  qry: TMyQuery;
  i: integer;
  iRoomAllocationID: integer;
begin
  lblNone.Visible := true;
  grdResByRoom.RemoveRows(1, grdResByRoom.RowCount - 1);

  if Empty(cboRoom.Text) then begin
    Exit;
  end;

  qry := TMyQuery.Create(Self);
  qry.Connection := CommonDbLib.GetSharedMyDacConnection;
  try
    qry.SQL.Clear;
    qry.SQL.Add('SELECT FuncResourceAllocationID,FuncResourceID, ' +
      ' R.FuncBookingID, R.RoomAllocationID,  ResourceName, A.RoomID, ' +
      '	Start, End, R.Qty, C.Company, T.FuncTypeName ' +
      'FROM tblFuncResourceAllocation AS R ' +
      ' INNER JOIN tblFuncRoomAllocation AS A USING (RoomAllocationID) ' +
      ' INNER JOIN tblFuncBookings AS B USING (FuncBookingID) ' +
      ' INNER JOIN tblClients as C USING (ClientID) ' +
      ' LEFT JOIN tblFuncTypes as T ON B.FuncTypeID = T.FuncTypeID ' +
      ' WHERE (:xStartOfDay < A.End) AND ' +
      '       (:xEndOfDay > A.Start) ' +
      ' AND A.RoomID = :xRoomID' +
      ' ORDER BY R.RoomAllocationID, ResourceName');


    qry.Close;
    qry.ParamByName('xStartOfDay').asDate := StartOfTheDay(dtpDate.Date);
    qry.ParamByName('xEndOfDay').asDate   := EndOfTheDay(dtpDate.Date);
    qry.ParamByName('xRoomID').AsInteger     := qryFuncRooms.FieldByName('RoomID').AsInteger;
    qry.Open;
    qry.First;
    qry.SQL.Text; // remove this

    // populate the grid
    iRoomAllocationID := 0;
    i := 0;
    while not qry.Eof do begin
      lblNone.Visible := false;
      Inc(i);  // grid row
      grdResByRoom.RowCount := i + 1;
      if iRoomAllocationID <> qry.FieldByName('RoomAllocationID').AsInteger then begin
        // get here when change of Booking for this room - file in header details
        iRoomAllocationID := qry.FieldByName('RoomAllocationID').AsInteger;
        grdResByRoom.Cells[COL_BOOKING, i] := qry.FieldByName('Company').AsString;
        grdResByRoom.Cells[COL_FROM, i] := FormatDateTime('hh:nn', qry.FieldByName('Start').AsDateTime);
        grdResByRoom.Cells[COL_TO, i] := FormatDateTime('hh:nn', qry.FieldByName('End').AsDateTime);
        grdResByRoom.Cells[COL_FUNCTYPE, i] := qry.FieldByName('FuncTypeName').AsString;
        grdResByRoom.Cells[COL_RES, i] := '';
        grdResByRoom.Cells[COL_QTY, i] := '';
      end else begin
        grdResByRoom.Cells[COL_BOOKING, i] := '';
        grdResByRoom.Cells[COL_FROM, i] := '';
        grdResByRoom.Cells[COL_TO, i] := '';
        grdResByRoom.Cells[COL_FUNCTYPE, i] := '';
        grdResByRoom.Cells[COL_RES, i] := qry.FieldByName('ResourceName').AsString;
        grdResByRoom.Cells[COL_QTY, i] := qry.FieldByName('Qty').AsString;
        qry.Next;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TFuncBookingsCalGUI.cboRoomCloseUp(Sender: TObject; LookupTable, FillTable: TDataSet; Modified: boolean);
begin
  if not Modified then Exit;
  inherited;
  LoadResByRoom;
end;

procedure TFuncBookingsCalGUI.cboTimeIncCloseUp(Sender: TwwDBComboBox; Select: boolean);
begin
  inherited;
  plannerDay.Display.DisplayUnit := FastFuncs.StrToInt(cboTimeInc.Text);
  plannerDay.UpdateControlState;
  SetCalendarTimeInc(CAL_FUNCS, AppEnv.Employee.EmployeeID, FastFuncs.StrToInt(cboTimeInc.Text));
end;


procedure TFuncBookingsCalGUI.PageControl1Changing(Sender: TObject; var AllowChange: boolean);
begin
  inherited;
  if PageControl1.ActivePage = tabDaily then begin
    dtpDate.Date := DaySource.Day;
  end;
end;

initialization
  RegisterClassOnce(TFuncBookingsCalGUI);
end.
