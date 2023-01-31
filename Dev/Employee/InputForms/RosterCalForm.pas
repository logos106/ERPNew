unit RosterCalForm;

{

Date     Version  Who  What
 -------- -------- ---  ------------------------------------------------------
 15/12/05  1.00.01 RM   Added ClassLeaveList. As the classes, 'available','unavailable
                        and leaves are added the names and color for each are stored in
                        the list which is global to this unit. It is referenced throughout.
                        Makes the possible leaves dynamic up to 20 colours, then everything is fuchia.
 03/02/06  1.00.03 DSP  Added PrintDialog component.
 31/03/06  1.00.04 BJ   Total colours used are 20 and the colors repeats if there are nore than
                        20 classes.

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseInputForm, SelectionDialog, AppEvnts, DB,  DBPlanner,
  Planner, Grids, BaseGrid, AdvGrid, StdCtrls, Menus, AdvMenus, ExtCtrls,
  wwdbdatetimepicker, Buttons, DNMSpeedButton, DNMPanel, Printers, ComCtrls,AdvOfficeStatusBar, DBAccess,
  MyAccess,ERPdbComponents, DataState, Math, MemDS, wwdblook, Mask, wwdbedit, Wwdotdot,
  Shader, dmGUIStylers, ImgList, AdvObj, ProgressDialog, IntegerListObj , BusObjAppointments;

const
    CL_MANUFACTURE =   $00FFFFEC;
type
  PItemRec = ^TItemRec;
  TItemRec = record
    EmployeeID: integer;
    ItemType: string;
    ItemTypeCatagory:string;
    StartTime: TDateTime;
    EndTime: TDateTime;
    PlannerID: string;
    ClockedOff: string;
    ClassID: integer;
    IsClocked:string
  end;

type
  TListRec = class(TObject)
  private

  public
    sClassLeaveName: string;
    iColor: longint;
    sTypeCatagory: string;
  end;

type
  TItemProperties = class(TObject)  //used to add extra properties to a planner item
  private
    fsDeptID: integer;
    fsTypeName: string;
    fbIsClocked: Boolean;
    fbTypeCatagory:string;
  public
    property DepartmentID:integer read fsDeptID write fsDeptID;
    property TypeName:String read fsTypeName write fsTypeName;
    property IsClocked:Boolean read fbIsClocked write fbIsClocked;
    property TypeCatagory : string read fbTypeCatagory write fbTypeCatagory;
  end;

type
  TRosterCalGUI = class(TBaseInputGUI)
    lstColorBox: TListBox;
    WeekSource: TDBWeekSource;
    dsWeekRoster: TDataSource;
    dsDayRoster: TDataSource;
    DaySource: TDBDaySource;
    PopupMenuPlannerItem: TAdvPopupMenu;
    PopupMenu: TAdvPopupMenu;
    qryWeekRoster: TERPQuery;
    qryWeekRosterRosterID: TIntegerField;
    qryWeekRosterGlobalRef: TWideStringField;
    qryWeekRosterPlannerID: TWideStringField;
    qryWeekRosterType: TWideStringField;
    qryWeekRosterEmployeeID: TIntegerField;
    qryWeekRosterClassID: TIntegerField;
    qryWeekRosterNotes: TWideStringField;
    qryWeekRosterStartTime: TDateTimeField;
    qryWeekRosterEndTime: TDateTimeField;
    qryWeekRosterEditedFlag: TWideStringField;
    qryWeekRosterClockedOff: TWideStringField;
    qryResources: TERPQuery;
    qryChkAppoints: TERPQuery;
    qryWeekRosterResourceIDLookup: TIntegerField;
    qryWeekRosterTypeCatagory: TWideStringField;
    qryWeekRosterHours: TFloatField;
    qryWeekRosterDate: TDateField;
    PrintDialog: TPrintDialog;
    qryClasses: TERPQuery;
    DSClass: TDataSource;
    qryClassesClassID: TIntegerField;
    qryClassesClassName: TWideStringField;
    qryWeekRosterIsClocked: TWideStringField;
    lstLeaveColors: TListBox;
    DNMPanel1: TDNMPanel;
    Label1: TLabel;
    btnPrint: TDNMSpeedButton;
    grdClass: TAdvStringGrid;
    cboClass: TwwDBLookupCombo;
    chkClasses: TCheckBox;
    btnSave: TDNMSpeedButton;
    btnCancel: TDNMSpeedButton;
    DNMPanel2: TDNMPanel;
    pnlTitle: TDNMPanel;
    TitleShader: TShader;
    TitleLabel: TLabel;
    DNMPanel3: TDNMPanel;
    pnlmain: TDNMPanel;
    PageControl1: TPageControl;
    tabWeekly: TTabSheet;
    plannerWeek: TDBPlanner;
    tabDaily: TTabSheet;
    plannerDay: TDBPlanner;
    dtpMonth: TwwDBDateTimePicker;
    btnPrev: TDNMSpeedButton;
    btnNext: TDNMSpeedButton;
    btnReport: TDNMSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdClassGetCellColor(Sender: TObject; ARow, ACol: integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
    procedure SourceFieldsToItem(Sender: TObject; Fields: TFields; Item: TPlannerItem);
    procedure SourceItemToFields(Sender: TObject; Fields: TFields; Item: TPlannerItem);
    procedure plannerWeekPlannerKeyDown(Sender: TObject; var Key: word; Shift: TShiftState; Position, FromSel, FromSelPrecis, ToSel, ToSelPrecis: integer);
    procedure dtpMonthChange(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure PageControl1Change(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure plannerWeekItemRightClick(Sender: TObject; Item: TPlannerItem);
    procedure plannerWeekPlannerRightClick(Sender: TObject; Position, FromSel, FromSelPrecise, ToSel, ToSelPrecise: integer);
    procedure plannerWeekItemSelect(Sender: TObject; Item: TPlannerItem);
    procedure plannerWeekItemMoving(Sender: TObject; Item: TPlannerItem; DeltaBegin, DeltaPos: integer; var Allow: boolean);
    procedure plannerDayItemSizing(Sender: TObject; Item: TPlannerItem; DeltaBegin, DeltaEnd: integer; var Allow: boolean);
    procedure FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
    procedure cboClassCloseUp(Sender: TObject; LookupTable,
      FillTable: TDataSet; modified: Boolean);
    procedure chkClassesClick(Sender: TObject);
    procedure plannerDayItemUnSelect(Sender: TObject; Item: TPlannerItem);
    procedure btnPrevClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnReportClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    ClassLeaveList: TList;
    fdiTotalClasses: integer;
    sTblName: string;
    bIsModified: boolean;
    bSaved: boolean;
    bIsPlannersReady: boolean;
    iRightClickedObject: integer;
    dtSavedStart: TDateTime;
    dtSavedEnd: TDateTime;
    iSavedPos: integer;
    fiClasscolors :Integer;
    fiClassIndex  :Integer;
    iSelectedItemClassID:integer;
    dtFrom, dtTo:TDate;
    AppointmentList: TIntegerList;
    procedure CreateResourceTable;
    procedure DeleteResourceTable;
    function ShowThisRep(const iEmployeeID: integer): boolean;
    procedure UpdateHeaders(const planner: TDBPlanner);
    Function InitPlanners:Boolean;
    procedure PopupMenuHandler(Sender: TObject);
    procedure PopupMenuDeleteClick(Sender: TObject);
    procedure PopupMenuRepeatClick(Sender: TObject);
    procedure PopupMenuEditClick(Sender: TObject);
    procedure PopupMenuClockedClick(Sender: TObject);
    procedure PopupMenuAppointmentsClick(Sender: TObject);
    function GetTypeCatagory(const sText:string):string;
    function ClassToColour(const iClassID: integer): TColor;
    function GetColor(const sDescription:string): TColor;

    function OkToCreate(Const iBegin, iEnd, iPos: integer): boolean;
    function GetDateFromWeeklyPlanner: TDateTime;
    procedure SetWeeklySelect(Const dtDate: TDateTime);
    procedure ChangeItemsToClocked;
    procedure RepeatItems;
    procedure EditItems;
    procedure Appointments;
    function GetCaption(Const item: TPlannerItem): string;
    procedure GetAppointments(Const dtStart, dtEnd: TDateTime; Const iPos: integer);
    function SetToSameDay(Const dtDate,dtTime: TDateTime): TDateTime;
    function IsAllocation(Const item: TPlannerItem): boolean;
    function AnyAppointments(Const item: TPlannerItem): boolean; overload;
    function AnyAppointments: boolean; overload;
    procedure EditUnavailableAppointment(Const item: TPlannerItem);
    procedure DeleteUnavailableAppointment(Const item: TPlannerItem);
    function GetTypeName(Const i: longint): string;
    procedure CreateUnavailableAppointment(Const item: TPlannerItem);
    procedure DeleteItems;
    procedure beforeshowrosterReport(Sender: TObject);


  Protected
    bAllowMove:Boolean;
    SelectedItem: TPlannerItem;
    procedure DeleteRoster(planner: TDBPlanner; Item: TPlannerItem);virtual;
    procedure DeleteRosterRelatedEntries(Item: TPlannerItem);virtual;
    function GetPlanner: TDBPlanner;
    function GetEmployeeFromPosition(const iPosition: integer): integer;
    procedure SetItemColor(Const item: TPlannerItem; Const colour: TColor);
    function NewItemProperty: TItemProperties;Virtual;
    procedure InitItemProperties(ItemProperties: TItemProperties;Fields: TFields);Virtual;
    procedure PopulateClassGrids;virtual;
    procedure ResetRoster;virtual;
  public
    { Public declarations }
    fdtStartDate: TDateTime;
    
  end;

implementation

uses
  DNMExceptions, CommonDbLib, DateUtils,  DNMLib,
  frmRepeat, RosterEditFrm, frmCalendar,  CommonLib
  ,FastFuncs, AppEnvironment, MySQLConst, tcDataUtils,  CommonFormLib,
  rosterReport, BusObjBase, RosterLib, tcConst,
  BusObjClient, DbSharedObjectsObj, LogLib;

const
  CL_AVAILABLE     = $00D2FFD2;
  CL_UNAVAILABLE   = $00B7EDFB;
  CL_ANNUAL_LEAVE  = clLime;
  CL_SICK_LEAVE    = clYellow;
  CL_SPECIAL_LEAVE = clAqua;
  CL_OTHER_LEAVES  = clFuchsia;

  BRUSH_CLOCKED = bsFDiagonal;


{$R *.dfm}

{ TRosterCalGUI }

procedure TRosterCalGUI.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  CloseQueries;
  DeleteResourceTable;
  while ClassLeaveList.Count > 0 do begin
    TListRec(ClassLeaveList[0]).Free;
    ClassLeaveList.Delete(0);
  end;
  if not (fsModal in FormState) then
    Action := caFree;
  Userlock.Unlock('Roster');
end;

procedure TRosterCalGUI.FormShow(Sender: TObject);
var
  QueryNamesNotToOpen: array of string;
begin
  DisableForm;
  try
    // If you enter this form via the main switch (say), then KeyID will be Set
    // .. to 0 and if ReadOnly access the AccessLevel logic will kick the user out.
    // .. So, Set KeyId to 1 to trick AccessLevel logic and allow readonly access.
    KeyID := 1;

    try
      Userlock.Enabled:= true;
      if not Userlock.Lock(TitleLabel.Caption , 0 , TitleLabel.Caption) then begin
        AccessLevel := 5;
      end else begin
        self.BeginTransaction;
      end;

      // All or Read Only or None
      if AccessLevel <> 6 then begin
        if AccessLevel <> 1 then begin
          AccessLevel := 5;
        end;
      end;

      inherited;

      BeginTransaction;

      PageControl1.ActivePage := tabWeekly;
      Setlength(QueryNamesNotToOpen, 1);
      qryChkAppoints.Connection := CommonDbLib.GetSharedMyDacConnection;
      QueryNamesNotToOpen[0]    := 'qryChkAppoints';
      OpenQueries(QueryNamesNotToOpen);


      if not InitPlanners then exit;
      PageControl1Change(Sender);

      if AppEnv.Employee.Calender24hr then begin
        plannerDay.HourType := ht24hrs;
      end else begin
        plannerDay.HourType := ht12hrs;
      end;
    except
      on EAbort do HandleEAbortException;
      on e: ENoAccess do HandleNoAccessException(e);
      else raise;
    end;
  finally
    EnableForm;
  end;  
end;

function TRosterCalGUI.GetTypeName(Const i: longint): string;
var
  x: integer;
begin
  for x := 0 to ClassLeaveList.Count - 1 do begin
    if i = TListRec(ClassLeaveList[x]).iColor then begin
      Result := TListRec(ClassLeaveList[x]).sClassLeaveName;
    end;
  end;
end;

procedure TRosterCalGUI.CreateResourceTable;
var
  cmd :TERPCommand;
  iCnt: integer;
begin
  cmd := DbSharedObj.Getcommand(commondblib.GetSharedMyDacConnection);
  try

    cmd.SQL.Clear;
    cmd.sql.add('DROP TABLE IF EXISTS ' +      sTblName + ' ;');

    cmd.sql.add('CREATE TABLE ' + sTblName + ' ( '+
                    ' ID INT(11) NOT NULL AUTO_INCREMENT, '+
                    ' 	ResourceID INT(11) NOT NULL, '+
                    ' 	EmployeeID INT(11) NOT NULL, '+
                    ' 	EmployeeName VARCHAR(255) NULL DEFAULT NULL, '+
                    ' 	INDEX ResourceID (ResourceID), '+
                    ' 	PRIMARY KEY (ID) ) ENGINE=Myisam ;');

    cmd.sql.add('INSERT IGNORE INTO ' + sTblName + '  ' +
                    ' ( ResourceID , EmployeeID ,EmployeeName )   ' +
                    ' select @rownum:=@rownum+1 No, EmployeeID, EmployeeName   ' +
                    ' FROM tblEmployees  , (SELECT @rownum:=0) r  ' +
                    ' WHERE Active="T" and IsOnTheRoster="T"  ORDER BY EmployeeName;');
    cmd.sql.add('update  ' + sTblName + ' set ResourceID = ResourceID-1; '); // resource Id is sequence no from 1, grid's row number is from 0. keep it the same as the employeeId is searched by locating the resouceId
    clog(cmd.SQL.text);
    cmd.Execute;

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(cmd);
  end;
end;

procedure TRosterCalGUI.FormCreate(Sender: TObject);
begin
  inherited;
  dtFrom:= 0;
  DtTo:= 0;
  ClassLeaveList := TList.Create;
  fdtStartDate := 0;
  bAllowMove := false;
  dtSavedStart := 0;
  dtSavedEnd := 0;
  iSavedPos := 0;
  bIsModified := false;
  bSaved := false;
  bIsPlannersReady := false;
  iRightClickedObject := IS_NONE;

  sTblName := commondblib.GetUserTemporaryTableName('rosterresources');

  // point qryResources to new temp table
  qryResources.SQL.Text := ReplaceStr(qryResources.SQL.Text, 'tblResources', sTblName);

  CreateResourceTable;
  fiClasscolors := lstColorBox.Items.count;

  lstColorBox.Items.Add(cOLORTOsTRING(CL_AVAILABLE));
  lstColorBox.Items.Add(cOLORTOsTRING(CL_UNAVAILABLE));
  lstColorBox.Items.Add(cOLORTOsTRING(CL_ANNUAL_LEAVE));
  lstColorBox.Items.Add(cOLORTOsTRING(CL_SICK_LEAVE));
  lstColorBox.Items.Add(cOLORTOsTRING(CL_SPECIAL_LEAVE));
  lstColorBox.Items.Add(cOLORTOsTRING(CL_OTHER_LEAVES));
  SelectedItem:=nil;
  AppointmentList := TIntegerList.Create;
end;

procedure TRosterCalGUI.FormDestroy(Sender: TObject);
begin
  inherited;
  AppointmentList.Free;
end;

function TRosterCalGUI.ShowThisRep(Const iEmployeeID: integer): boolean;
begin
  Result := true;
end;

procedure TRosterCalGUI.DeleteResourceTable;
begin
  DestroyUserTemporaryTable (sTblName);
(*var
  qry: TERPQuery;
begin
  qry := TERPQuery.Create(Self);
  try
    qry.Connection := CommonDbLib.GetSharedMyDacConnection;
    qry.SQL.Clear;
    qry.sql.Add('DROP TABLE IF EXISTS ' + sTblName);
    qry.Execute;
  finally
    FreeAndNil(qry);
  end;*)
end;

procedure TRosterCalGUI.UpdateHeaders(Const planner: TDBPlanner);
begin
  planner.Header.Height := 100;
  planner.Header.TextHeight := 100;
  planner.Header.Color := $00FFDDC6;
  planner.Header.Captions.Clear;
  planner.Header.Captions.Add('');
  planner.ItemGap := 0;

  with qryResources do begin
    First;
    while not Eof do begin
      planner.Header.Captions.Add(FieldByName('EmployeeName').AsString);
      Next;
    end;
  end;
end;

Function  TRosterCalGUI.InitPlanners:boolean;
begin
  result := TRue;
  PopulateClassGrids;

  WeekSource.NumberOfResources := qryResources.RecordCount;
  DaySource.NumberOfResources := qryResources.RecordCount;
  plannerWeek.PositionWidth := 30;

  plannerDay.PositionWidth := 30;
  plannerDay.GridLeftCol := 14;

  plannerWeek.MultiSelect := true;
  plannerWeek.Display.DisplayEnd := 40;
  plannerWeek.Caption.Title := 'Roster By Week';
  plannerWeek.Display.ShowCurrent := true;

  plannerDay.MultiSelect := true;
  plannerDay.Caption.Title := 'Day Roster';

  if fdtStartDate = 0 then begin
    dtpMonth.Date := Date;  // Week Source date is set via the dtp's OnChange event
  end else begin
    dtpMonth.Date := fdtStartDate;  // Week Source date is set via the dtp's OnChange event
  end;

  // Show selected cell at todays day
  SetWeeklySelect(dtpMonth.Date);

  UpdateHeaders(plannerDay);
  UpdateHeaders(plannerWeek);


  bIsPlannersReady := true;

  // Do we have any employee's to show on the roster?
  if (qryResources.RecordCount = 0) then begin
    // No report error to user.
    CommonLib.MessageDlgXP_Vista('No Employee''s have been assigned to the Roster.' + #13 + #10 + '' + #13 + #10 + 'Please use Employee Screen To Add Each Employee To Roster.', mtInformation, [mbOK], 0);
    Result := False;
    RollbackTransaction;
    CloseWait;
  end;
end;

procedure TRosterCalGUI.grdClassGetCellColor(Sender: TObject; ARow, ACol: integer; AState: TGridDrawState; ABrush: TBrush; AFont: TFont);
var
  iColorRow:integer;
  dNoOfColorSets:double;
  iNoOfLeaveRows,iNoOfColorSets:integer;
begin
  inherited;

  if Sysutils.SameText(grdClass.Cells[1, ARow], AVAILABLE) then begin
    AFont.Color  := CL_AVAILABLE;
    ABrush.Color := clSilver;
  end else if Sysutils.SameText(grdClass.Cells[1, ARow], UNAVAILABLE) then begin
    AFont.Color  := CL_UNAVAILABLE;
    ABrush.Color := clSilver;
  end else if Sysutils.SameText(grdClass.Cells[1, ARow], 'Annual Leave') then begin
    AFont.Color  := CL_ANNUAL_LEAVE;
    ABrush.Color := clSilver;
  //end else if Sysutils.SameText(grdClass.Cells[1, ARow], 'Sick Leave') then begin
  end else if Sysutils.SameText(grdClass.Cells[1, ARow], Appenv.RegionalOptions.SLName ) then begin
    AFont.Color  := CL_SICK_LEAVE;
    ABrush.Color := clSilver;
  end else if Sysutils.SameText(grdClass.Cells[1, ARow], 'Special Leave') then begin
    AFont.Color  := CL_SPECIAL_LEAVE;
    ABrush.Color := clSilver;
  end else if ARow <= (fdiTotalClasses-1) then begin
    if ARow > 20 then begin
      dNoOfColorSets := fdiTotalClasses/20;
      iNoOfColorSets := Trunc(dNoOfColorSets);
      iColorRow := ARow - (iNoOfColorSets * 20);
    end else begin
      iColorRow := ARow;
    end;
    if chkClasses.Checked = True then begin
      AFont.Color  := StringToColor(lstColorBox.Items[iColorRow]);          //getColorNoforClass(ARow)]);
    end else begin
        AFont.Color  :=  StringToColor(lstColorBox.Items.Strings[fiClassIndex] );
    end;
  end else begin
    iNoOfLeaveRows := ARow - fdiTotalClasses - 6;
    if iNoOfLeaveRows > 20 then begin
      dNoOfColorSets := iNoOfLeaveRows/20;
      iNoOfColorSets := Trunc(dNoOfColorSets);
      iColorRow := ARow - fdiTotalClasses - 6 - (iNoOfColorSets * 20);
    end else begin
      iColorRow := ARow;
    end;
    try
     AFont.Color  :=  StringToColor(lstLeaveColors.Items.Strings[iColorRow] );
    Except
      // kill the exception
    end;
  end;
end;

function TRosterCalGUI.GetTypeCatagory(Const sText:string):string;//(item: TPlannerItem): string;
var
  qry:TERPQuery;
begin
  Result := 'Allocation';
  if sText = UNAVAILABLE then Result := 'Other';

  qry := TERPQuery.Create(nil);
  try
    with qry do begin
      Connection := CommonDbLib.GetSharedMyDacConnection;
      SQL.Clear;
      SQL.Add('SELECT LeaveTypeID, LeaveType  FROM tblleavetypes WHERE Active = "T"');
      Open;
      if Locate('LeaveType', sText, [loCaseInsensitive])  then begin
        Result := 'Leave';
      end;
    end;
  finally
    FreeAndNil(qry);
  end;
end;

procedure TRosterCalGUI.SourceItemToFields(Sender: TObject; Fields: TFields; Item: TPlannerItem);
begin
  inherited;
  qryWeekRoster.FieldByName('Date').AsDateTime := Trunc(qryWeekRoster.FieldByName('StartTime').AsDateTime);

  if assigned(Item.ItemObject) then begin
    if TItemProperties(Item.ItemObject).IsClocked then qryWeekRoster.FieldByName('IsClocked').AsString := 'T' else qryWeekRoster.FieldByName('IsClocked').AsString := 'F';
     qryWeekRoster.FieldByName('Type').AsString :=  TItemProperties(item.ItemObject).TypeName;
    qryWeekRoster.FieldByName('TypeCatagory').AsString := TItemProperties(item.ItemObject).TypeCatagory;

    //Main Calendar
    if TItemProperties(item.ItemObject).TypeName = UNAVAILABLE then begin
      CreateUnavailableAppointment(Item);
    end;
    if TItemProperties(item.ItemObject).TypeCatagory = 'Leave' then begin
      CreateUnavailableAppointment(Item);
    end;
    if TItemProperties(item.ItemObject).TypeName = AVAILABLE then begin
      DeleteUnavailableAppointment(Item);
    end;


     //TO DO
    //Don't know why sometimes itemproperties don't get passed. fix when time permits
    if Item.tag = 0 then begin
      if TItemProperties(item.ItemObject).DepartmentID = 0 then
        qryWeekRoster.FieldByName('ClassID').AsInteger := GetEmployeeClass(GetEmployeeFromPosition(Item.ItemPos))
      else qryWeekRoster.FieldByName('ClassID').AsInteger :=  TItemProperties(item.ItemObject).DepartmentID
    end else begin
      qryWeekRoster.FieldByName('ClassID').AsInteger :=  Item.tag;
    end;
  end;

  qryWeekRoster.FieldByName('Hours').AsFloat := HourSpan(qryWeekRoster.FieldByName('EndTime').AsDateTime, qryWeekRoster.FieldByName('StartTime').AsDateTime);
  qryWeekRoster.FieldByName('Hours').AsFloat := RoundTo(qryWeekRoster.FieldByName('Hours').AsFloat, - 3);
  qryWeekRoster.FieldByName('EmployeeID').AsInteger := GetEmployeeFromPosition(Item.ItemPos);
  qryWeekRoster.FieldByName('EditedFlag').AsString := 'T';
  bIsModified := true;
end;
function TRosterCalGUI.NewItemProperty:TItemProperties;
begin
  REsult := TItemProperties.Create
end;
Procedure TRosterCalGUI.InitItemProperties(ItemProperties:TItemProperties;Fields: TFields);
begin
  ItemProperties.DepartmentID := Fields.FieldByName('ClassID').AsInteger;
  ItemProperties.TypeName :=  Trim(Fields.FieldByName('Type').AsString);
  ItemProperties.TypeCatagory :=  Trim(Fields.FieldByName('TypeCatagory').AsString);
  if  Trim(Fields.FieldByName('IsClocked').AsString) = 'T' then  ItemProperties.IsClocked := True else ItemProperties.IsClocked := False;
end;

procedure TRosterCalGUI.SourceFieldsToItem(Sender: TObject; Fields: TFields; Item: TPlannerItem);
var
  ItemProperties:TItemProperties;
begin
  inherited;

  Item.Shape := psHexagon;
  ItemProperties := NewItemProperty;

  initItemProperties(ItemProperties,fields);
  Item.ItemObject := ItemProperties;

  if Trim(Fields.FieldByName('Type').AsString) = AVAILABLE then begin
    Item.Background := true;
    SetItemColor(Item, CL_AVAILABLE);
  end else if Trim(Fields.FieldByName('Type').AsString) = UNAVAILABLE then begin
    Item.Background := true;
    SetItemColor(Item, CL_UNAVAILABLE);
  end else if Trim(Fields.FieldByName('Type').AsString) = 'Annual Leave' then begin
    SetItemColor(Item, CL_ANNUAL_LEAVE);
  //end else if Trim(Fields.FieldByName('Type').AsString) = 'Sick Leave' then begin
  end else if Trim(Fields.FieldByName('Type').AsString) = Appenv.RegionalOptions.SLName  then begin
    SetItemColor(Item, CL_SICK_LEAVE);
  end else if Trim(Fields.FieldByName('Type').AsString) = 'Special Leave' then begin
    SetItemColor(Item, CL_SPECIAL_LEAVE);
  end;

  if Trim(Fields.FieldByName('TypeCatagory').AsString) = 'Leave' then begin
    Item.Shape := psHexagon;
    SetItemColor(Item,GetColor(Fields.FieldByName('Type').AsString));  //LeaveToColor(Fields.FieldByName('Type').AsString));
  end else if Trim(Fields.FieldByName('TypeCatagory').AsString) = 'Other' then begin
    Item.Background := true;     

  end else if Trim(Fields.FieldByName('TypeCatagory').AsString) = 'Allocation' then begin
    if Fields.FieldByName('ClassID').AsInteger <> 0 then
      SetItemColor(Item, ClassToColour(Fields.FieldByName('ClassID').AsInteger));
  end else if (Trim(Fields.FieldByName('TypeCatagory').AsString) = 'ProcessStep') then begin
    if (Fields.FieldByName('ProcesstimeID').asInteger<>0) then begin
      SetItemColor(Item, CL_MANUFACTURE);
    end;
  end else begin
    Item.Shape := psRounded;
    if Fields.FieldByName('ClassID').AsInteger <> 0 then begin
      SetItemColor(Item, ClassToColour(Fields.FieldByName('ClassID').AsInteger));
    end;
  end;

  if  Trim(Fields.FieldByName('IsClocked').AsString) = 'T' then begin
    Item.Shape := psRect;
    Item.BrushStyle := BRUSH_CLOCKED;
  end;

  if TItemSource(Sender) = WeekSource then begin
    Item.FixedSize := true;  // freeze items
  end else begin
    Item.FixedSize := false;
  end;

  // Set item so that its level of control reflects the AccessLevel of the user
  // NOTE: We should be able to apply this a a higher level ie in the Planner itself,
  // .. but i'll be buggered if i can find the property
  Item.FixedPos := (AccessLevel <> 1);
  Item.FixedSize := (AccessLevel <> 1);
  Item.Id := fields.fieldbyname('rosterId').asInteger;
end;

function TRosterCalGUI.GetEmployeeFromPosition(Const iPosition: integer): integer;
begin
  if qryResources.Locate('ResourceID', iPosition, [loCaseInsensitive]) then begin
    Result := qryResources.FieldByName('EmployeeID').AsInteger;
  end else begin
    //CommonLib.MessageDlgXP_Vista('GetEmployeeFromPosition: Could not Match Employee with Position', mtWarning, [mbOK], 0);
    Result := 0;
  end;
end;

procedure TRosterCalGUI.PopupMenuHandler(Sender: TObject);
var
  MenuItem: TMenuItem;
  iDayCnt, iNumDays: integer;
  iCurrentCell, iPos: integer;
  oItem: TPlannerItem;
  dtDate: TDateTime;
  planner: TDBPlanner;
  i: integer;
  dtEndOfDay: TDateTime;
  bOk: boolean;
  ItemProperties :tItemProperties;
  bFoundASelectedItem:Boolean;

  procedure FillCellDetails(ItemProperties:TItemProperties);
  var
    sText: string;
  begin
    sText := StringReplace(MenuItem.Caption, '&', '', [rfReplaceAll,rfIgnoreCase]);
    ItemProperties.TypeName := sText;
    ItemProperties.TypeCatagory := GetTypeCatagory(sText);
    ItemProperties.DepartmentID := MenuItem.Tag;//oItem.Tag;

    if MenuItem.Tag <> 0 then begin
      // get here if an allocation or clocked
      oItem.Tag := MenuItem.Tag;  // Set class ID
      SetItemColor(oItem, GetColor(sText));
      if Sysutils.SameText(sText, 'Clocked') then begin
        oItem.Shape := psRect;    // clocked
        oItem.BrushStyle := BRUSH_CLOCKED;
        ItemProperties.IsClocked := True;
      end else begin
        oItem.Shape := psRounded;  // allocation
        oItem.BrushStyle := bsSolid;
        ItemProperties.IsClocked := False;

      end;
    end else begin
      sText := StringReplace(MenuItem.Caption, '&', '', [rfReplaceAll,rfIgnoreCase]);
      oItem.Background := false;
      SetItemColor(oItem, GetColor(sText));

      oItem.CaptionText  := MenuItem.Caption;
      oItem.AllowOverlap := false;
      oItem.Shape        := psHexagon;
      oItem.BrushStyle   := bsSolid;
    end;
  end;
begin   // PopupMenuHandler(Sender: TObject)
  inherited;
  bOk := true;
  MenuItem := TMenuItem(Sender);
  planner := GetPlanner;
  bFoundASelectedItem := False;
  if iRightClickedObject <> IS_ITEM then begin
    // create new item(s)
    if (planner = plannerWeek) and
      (planner.SelPosition <= qryResources.RecordCount - 1) then begin
      planner.Items.BeginUpdate;
      iCurrentCell := planner.SelItemBegin;
      iPos := planner.SelPosition;
      iNumDays := (planner.SelItemEnd - planner.SelItemBegin) + 1;
      iDayCnt := 0;
      while iDayCnt < iNumDays - 1 do begin
        planner.SelectCells(iCurrentCell + iDayCnt, iCurrentCell + iDayCnt, iPos);
        oItem := planner.CreateItemAtSelection;
        bFoundASelectedItem := True;
        ItemProperties := NewItemProperty;
        oItem.ItemObject :=  ItemProperties;  // assign object to item

        oItem.Tag :=  GetDeptID(StringReplace(MenuItem.Caption, '&', '', [rfReplaceAll,rfIgnoreCase]));
        TItemProperties(oItem.ItemObject).DepartmentID := oItem.Tag;

        dtDate := oItem.ItemStartTime;
        if AppEnv.CompanyPrefs.StartOfDay = 0 then begin
          oItem.ItemStartTime := dtDate + EncodeTime(8, 30, 0, 0);
          oItem.ItemEndTime := dtDate + EncodeTime(17, 30, 0, 0);
        end else begin
          if (AppEnv.CompanyPrefs.StartOfDay > AppEnv.CompanyPrefs.EndOfDay) and
            (AppEnv.CompanyPrefs.EndOfDay < 12) then begin
            // assume 12 hour clock time is being used
            dtEndOfDay := IncHour(AppEnv.CompanyPrefs.EndOfDay, 12);
          end else begin
            // assume 24 hour clock time is being used
            dtEndOfDay := AppEnv.CompanyPrefs.EndOfDay;
          end;
          oItem.ItemStartTime := dtDate + TimeOf(AppEnv.CompanyPrefs.StartOfDay);
          oItem.ItemEndTime := dtDate + TimeOf(dtEndOfDay);
        end;
        FillCellDetails(ItemProperties);
        oItem.Update;
        Inc(iDayCnt);
      end;
      planner.Items.EndUpdate;
    end else if planner = plannerDay then begin
      if OkToCreate(planner.SelItemBegin, planner.SelItemEnd, planner.SelPosition) then begin
        oItem := planner.CreateItemAtSelection;

        ItemProperties := NewItemProperty;
        oItem.ItemObject :=  ItemProperties;  // assign object to item

        if iSelectedItemClassID <> 0 then begin
          oItem.Tag := iSelectedItemClassID; //if the overwritten item had a class keep it
          TItemProperties(oItem.ItemObject).DepartmentID := iSelectedItemClassID;
        end else begin
          oItem.Tag := GetEmployeeClass(GetEmployeeID(PlannerWeek.Header.Captions.Strings[oItem.ItemPos + 1]));
          TItemProperties(oItem.ItemObject).DepartmentID := GetEmployeeClass(GetEmployeeID(PlannerWeek.Header.Captions.Strings[oItem.ItemPos + 1]));
        end;
        FillCellDetails(ItemProperties);
        oItem.Update;
      end;
    end;
  end else begin
    // Get here if an item is clicked

    if AnyAppointments() then begin
      if CommonLib.MessageDlgXP_Vista('One or more of the Selected Items have Associated Appointments'#10#13 +
        'To Reschedule Appointments, Answer "No" and Right-Click on the Rostered Item'#10#13#10#13 +
        'Do you wish to Continue?', mtWarning, [mbYes, mbNo], 0) <> mrYes then begin
        bOk := false;
      end;
    end;

    if bOk then begin
      planner.Items.BeginUpdate;
      for i := 0 to planner.Items.Count - 1 do begin
        if planner.Items.Items[i].Selected then begin
          oItem := planner.Items.Items[i];
          oItem.Tag := TItemProperties(oItem.ItemObject).DepartmentID;  // Set class ID
          FillCellDetails(TItemProperties(oItem.ItemObject));
          oItem.Update;
          bFoundASelectedItem := True;
        end;
      end;
      planner.Items.EndUpdate;
    end;
  end;
  iRightClickedObject := IS_NONE;
  planner.Items.UnSelectAll;
  if not bFoundASelectedItem then ShowMessage('Select an item');
end;

function TRosterCalGUI.OkToCreate(Const iBegin, iEnd, iPos: integer): boolean;
var
  oItem: TPlannerItem;
  planner: TDBPlanner;
begin
  Result := true;
  planner := GetPlanner;
  oItem := planner.Items.FindFirst(iBegin, iEnd, iPos);
  while oItem <> nil do begin
    if (not oItem.AllowOverlap) then begin
      Result := false;
      Break;
    end;
    oItem := planner.Items.FindNext(iBegin, iEnd, iPos)
  end;
end;

function TRosterCalGUI.GetColor(Const sDescription:string): TColor;
var
  i: integer;
begin
  Result := clBlack;
  if sDescription = AVAILABLE then begin
    Result := CL_AVAILABLE;
    exit;
  end;
  if sDescription = UNAVAILABLE then begin
    Result := CL_UNAVAILABLE;
    exit;
  end;

  for i := 0 to grdClass.RowCount - 1 do begin
    if grdClass.Cells[1,i] = sDescription then begin
      Result := grdClass.CellProperties[1,i].FontColor;
      break;
    end;
  end;
end;

function TRosterCalGUI.ClassToColour(Const iClassID: integer): TColor;
var
  sClass: string;
  i: integer;
begin
  Result := clBlack;
  if iClassID = 0 then exit;

  sClass := GetClassName(iClassID);
  for i := 0 to grdClass.RowCount - 1 do begin
    if grdClass.Cells[1,i] = sClass then begin
      Result := grdClass.CellProperties[1,i].FontColor;
      break;
    end;
  end;
end;

procedure TRosterCalGUI.PopulateClassGrids;
var
  MenuItem: TMenuItem;
  qryClass: TERPQuery;
  qryLeaves: TERPQuery;
  i, j,iRowCount: integer;
  Rec: TListRec;

  procedure AddToGrid(const iRow: integer; const sClassName: string);
  begin
    grdClass.Cells[0, iRow] := IntToStr(iRow);
    grdClass.Cells[1, iRow] := sClassName;
  end;

  procedure AddMenuItemToPopup(const Popup: TAdvPopupMenu; const iTag: integer; const sName: string);
  begin
    MenuItem := TMenuItem.Create(self);
    MenuItem.Caption := sName;
    MenuItem.Tag := iTag;
    MenuItem.OnClick := PopupMenuHandler;
    Popup.Items.Add(MenuItem);
  end;


  procedure AddMenuItem(const iTag: integer; const sName: string);
  begin
    AddMenuItemToPopup(PopupMenu, iTag, sName);
    AddMenuItemToPopup(PopupMenuPlannerItem, iTag, sName);
  end;

  procedure SetMenuEnabled(Popup: TAdvPopupMenu; bState: boolean);
  var
    i: integer;
  begin
    for i := 0 to Popup.Items.Count - 1 do begin
      Popup.Items[i].Enabled := bState;
    end;
  end;

  procedure RemoveConstColors;
  var
    x: integer;
  begin
    for x := 0 to lstColorBox.Count - 1 do begin
      if (lstColorBox.Items[x] = '$00D2FFD2') or (lstColorBox.Items[x] = '$00B7EDFB') or
        (lstColorBox.Items[x] = 'clLime') or (lstColorBox.Items[x] = 'clYellow') then begin
        //   CommonLib.MessageDlgXP_Vista(lstColorBox.Items[x], mtInformation,[mbOk], 0);
        lstColorBox.Items.Delete(x);
        Break;
      end;
    end;
  end;

begin  // procedure TRosterCalGUI.PopulateClassGrids;

  // populate class grid
//  RemoveConstColors;

  grdClass.Clear;
  grdClass.ColWidths[0] := 20;
  grdClass.ColWidths[1] := grdClass.Width - grdClass.ColWidths[0];

  qryClass := TERPQuery.Create(Self);
  qryLeaves := TERPQuery.Create(Self);
  try
    qryClass.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryClass.SQL.Clear;
    qryClass.sql.Add('SELECT ClassID, ClassName FROM tblclass WHERE Active = "T"');
    qryClass.Open;

    fdiTotalClasses :=qryClass.RecordCount;

    qryClass.First;
    for i := 0 to qryClass.RecordCount - 1 do
    begin
      if qryClass.FieldByName('ClassName').AsString = cboClass.Text then begin
        fiClassIndex := i ;
      end;
      qryClass.Next;
    end;

    if chkClasses.Checked <> True then begin
      qryClass.Close;
      qryClass.SQL.Clear;
      qryClass.sql.Add('SELECT ClassID, ClassName FROM tblclass WHERE Active = "T"');
      qryClass.sql.Add(' AND ClassName = ');
      qryClass.sql.Add(quotedStr(cboClass.Text));
      qryClass.Open;
    end;
    
    grdClass.RowCount := qryClass.RecordCount;

    qryLeaves.Connection := CommonDbLib.GetSharedMyDacConnection;
    qryLeaves.SQL.Clear;
    qryLeaves.sql.Add('SELECT LeaveTypeID, LeaveType FROM tblleavetypes WHERE Active = "T"');
    qryLeaves.Open;

    {Clear Menus}
    PopupMenu.Items.Clear;
    PopupMenuPlannerItem.Items.Clear;

    MenuItem         := TMenuItem.Create(self);
    MenuItem.Caption := ' ';
    PopupMenuPlannerItem.Items.Add(MenuItem);

    MenuItem         := TMenuItem.Create(self);
    MenuItem.Caption := '-';
    PopupMenuPlannerItem.Items.Add(MenuItem);

    MenuItem         := TMenuItem.Create(self);
    MenuItem.Caption := 'Delete';
    MenuItem.OnClick := PopupMenuDeleteClick;
    PopupMenuPlannerItem.Items.Add(MenuItem);

    MenuItem         := TMenuItem.Create(self);
    MenuItem.Caption := 'Repeat...';
    MenuItem.OnClick := PopupMenuRepeatClick;
    PopupMenuPlannerItem.Items.Add(MenuItem);

    MenuItem         := TMenuItem.Create(self);
    MenuItem.Caption := 'Edit...';
    MenuItem.OnClick := PopupMenuEditClick;
    PopupMenuPlannerItem.Items.Add(MenuItem);

    MenuItem         := TMenuItem.Create(self);
    MenuItem.Caption := 'Appointments...';
    MenuItem.OnClick := PopupMenuAppointmentsClick;
    PopupMenuPlannerItem.Items.Add(MenuItem);

    MenuItem         := TMenuItem.Create(self);
    MenuItem.Caption := '-';
    PopupMenuPlannerItem.Items.Add(MenuItem);

    qryClass.First;
    grdClass.RowCount := qryClass.RecordCount + qryLeaves.RecordCount + 2;

    i := 0;
    iRowCount := 0;
    while not qryClass.Eof do begin
      // fill in class grid items
      AddToGrid(iRowCount, qryClass.FieldByName('ClassName').AsString);

      // fill in popupmenu items
      AddMenuItem(qryClass.FieldByName('ClassID').AsInteger,
        qryClass.FieldByName('ClassName').AsString);
      //store in list to use later
      Rec := TListRec.Create;
      Rec.sClassLeaveName := qryClass.FieldByName('ClassName').AsString;
      Rec.iColor := StringToColor(lstColorBox.Items[i]);

      Rec.sTypeCatagory := 'Allocation';
      ClassLeaveList.Add(Rec);

      qryClass.Next;
      iRowCount := iRowcount + 1;
      i := i +1;
      if i > 20 then i := 0;
    end;

    // add others

    i := qryClass.RecordCount;
    fdiTotalClasses := qryClass.RecordCount;

    //   grdClass.RowCount := grdClass.RowCount + 5;
    AddMenuItem(0, '-');
    AddToGrid(i, AVAILABLE);
    AddMenuItem(0, AVAILABLE);
    Rec        := TListRec.Create;
    Rec.sClassLeaveName := AVAILABLE;
    Rec.iColor := CL_AVAILABLE;

    Rec.sTypeCatagory := 'Other';
    ClassLeaveList.Add(Rec);
    AddToGrid(i + 1, UNAVAILABLE);
    AddMenuItem(0, UNAVAILABLE);
    Rec        := TListRec.Create;
    Rec.sClassLeaveName := UNAVAILABLE;
    Rec.iColor := CL_UNAVAILABLE;

    Rec.sTypeCatagory := 'Other';
    ClassLeaveList.Add(Rec);
 
    i := fdiTotalClasses;

    qryLeaves.First;
    j := 2;

    while not qryLeaves.Eof do begin
      AddToGrid(i + j, qryLeaves.FieldByName('LeaveType').AsString);
      AddMenuItem(0, qryLeaves.FieldByName('LeaveType').AsString);
      //Add to list to use later
      Rec := TListRec.Create;
      Rec.sClassLeaveName := qryLeaves.FieldByName('LeaveType').AsString;
      Rec.sTypeCatagory := 'Leave';
      if qryLeaves.FieldByName('LeaveType').AsString ='Annual Leave' then
        Rec.iColor := CL_ANNUAL_LEAVE
      //else if qryLeaves.FieldByName('LeaveType').AsString ='Sick Leave' then
      else if qryLeaves.FieldByName('LeaveType').AsString =Appenv.RegionalOptions.SLName  then
        Rec.iColor := CL_SICK_LEAVE
      else if qryLeaves.FieldByName('LeaveType').AsString ='Special Leave' then
        Rec.iColor := CL_SPECIAL_LEAVE
      else
      //Rec.iColor := CL_OTHER_LEAVES;
      Rec.iColor := StringToColor(lstLeaveColors.Items[j - 2]);
      ClassLeaveList.Add(Rec);
      qryLeaves.Next;
      j := j + 1;
      if j > 22 then j := 1; //if there are more leaves than colors, cycle thru again
    end;


    MenuItem         := TMenuItem.Create(self);
    MenuItem.Caption := '-';
    PopupMenuPlannerItem.Items.Add(MenuItem);

    MenuItem         := TMenuItem.Create(self);
    MenuItem.Caption := 'Convert to Clocked';
    MenuItem.OnClick := PopupMenuClockedClick;
    PopupMenuPlannerItem.Items.Add(MenuItem);

    SetMenuEnabled(PopupMenuPlannerItem, (AccessLevel = 1));
    SetMenuEnabled(PopupMenu, (AccessLevel = 1));

  finally
    FreeandNil(qryClass);
    FreeandNil(qryLeaves);
  end;
end;

procedure TRosterCalGUI.plannerWeekPlannerKeyDown(Sender: TObject; var Key: word; Shift: TShiftState; Position, FromSel, FromSelPrecis, ToSel, ToSelPrecis: integer);
begin
  inherited;
  if Key = VK_DELETE then begin
    DeleteItems;
  end;
end;

procedure TRosterCalGUI.dtpMonthChange(Sender: TObject);
begin
  inherited;
  WeekSource.Month := MonthOfTheYear(dtpMonth.Date);
  WeekSource.Year := YearOf(dtpMonth.Date);
  WeekSource.UpdatePlanner;
  DaySource.Day := dtpMonth.Date;
  if PageControl1.ActivePage = tabWeekly then begin
    Dtfrom := EndOfAMonth(YearOf(dtpMonth.Date) , MonthOfTheYear(dtpMonth.Date));
    DtTo   := StartOfAMonth(YearOf(dtpMonth.Date), MonthOfTheYear(dtpMonth.Date));
  end else begin
    Dtfrom := dtpMonth.Date;
    DtTo   := dtpMonth.Date;
  end;
end;

procedure TRosterCalGUI.btnSaveClick(Sender: TObject);
var
  x: integer;
begin
  inherited;
  CommitTransaction;
  bSaved := true;
  for x := 0 to AppointmentList.Count -1 do
    AppEnv.GoogleUpdater.UpdateCalendar(AppointmentList.Item[x], AppEnv.ServerID);
  Notify;
  if fsModal in FormState then begin
    ModalResult := mrOk;
  end else begin
    Close;
  end;
end;


procedure TRosterCalGUI.btnCancelClick(Sender: TObject);
begin
  inherited;

  if fsModal in FormState then begin
    ModalResult := mrCancel;
  end else begin
    Close;
  end;
end;

procedure TRosterCalGUI.btnNextClick(Sender: TObject);
begin
  inherited;
  if PageControl1.ActivePage = tabWeekly then begin
    dtpMonth.Date := incMonth(dtpMonth.Date , 1);
  end else begin
    dtpMonth.Date := incday(dtpMonth.Date , 1);
  end;
end;

procedure TRosterCalGUI.FormCloseQuery(Sender: TObject; var CanClose: boolean);
var
  iResult: integer;
begin
  inherited;
  if not bSaved then begin
    if bIsModified then begin
      iResult := CommonLib.MessageDlgXP_Vista('Do you wish to keep any Changes you Have Made?', mtConfirmation, [mbYes, mbNo, mbCancel], 0);
      case iResult of
        mrYes: 
          begin
            CanClose := false;
            btnSave.Click;
          end;
        mrNo: RollbackTransaction;
        mrCancel: CanClose := false;
      end;
    end;
  end;
  RollbackTransaction;
end;

procedure TRosterCalGUI.PageControl1Change(Sender: TObject);
begin
  inherited;
  if bIsPlannersReady then begin
    if PageControl1.ActivePage = tabWeekly then begin
      dtpMonth.DisplayFormat := 'mmmm yyyy';
      DaySource.Active := false;
      WeekSource.Active := true;
      SetWeeklySelect(dtpMonth.Date);
      btnPrint.Enabled := true;
    end else if PageControl1.ActivePage = tabDaily then begin
      dtpMonth.Date := GetDateFromWeeklyPlanner;
      dtpMonth.DisplayFormat := 'dd mmmm yyyy';
      DaySource.Active := true;
      WeekSource.Active := false;
      btnPrint.Enabled := false;
    end;
  end;
end;

function TRosterCalGUI.GetDateFromWeeklyPlanner: TDateTime;
var
  iCol: integer;
  dtDummy: TDateTime;   // not used
begin
  iCol := plannerWeek.SelItemBegin;
  plannerWeek.CellToAbsTime(iCol, Result, dtDummy);
  if dtDummy = 0 then;  // prevents silly delphi hint
end;



function TRosterCalGUI.GetPlanner: TDBPlanner;
begin
  if PageControl1.ActivePage = tabWeekly then begin
    Result := plannerWeek;
  end else begin
    Result := plannerDay;
  end;
end;

procedure TRosterCalGUI.SetWeeklySelect(Const dtDate: TDateTime);
var
  iCol: integer;
begin
  iCol := plannerWeek.AbsTimeToCell(dtpMonth.Date);
  plannerWeek.SelectCells(iCol, iCol, 0);
end;

procedure TRosterCalGUI.plannerWeekItemRightClick(Sender: TObject; Item: TPlannerItem);
begin
  inherited;
  iRightClickedObject := IS_ITEM;
  PopupMenuPlannerItem.Items[0].Caption :=
    FormatDateTime(MysqlTimeFormat12hr, Item.ItemStartTime) + ' - ' + FormatDateTime(MysqlTimeFormat12hr, Item.ItemEndTime);
  SelectedItem := Item;
end;

procedure TRosterCalGUI.plannerWeekPlannerRightClick(Sender: TObject; Position, FromSel, FromSelPrecise, ToSel, ToSelPrecise: integer);
begin
  inherited;
  iRightClickedObject := IS_CELL;
end;

procedure TRosterCalGUI.PopupMenuDeleteClick(Sender: TObject);
begin
  DeleteItems;
end;

procedure TRosterCalGUI.PopupMenuRepeatClick(Sender: TObject);
begin
  RepeatItems;
end;

procedure TRosterCalGUI.PopupMenuEditClick(Sender: TObject);
begin
  EditItems;
end;

procedure TRosterCalGUI.PopupMenuAppointmentsClick(Sender: TObject);
begin
  Appointments;
end;


procedure TRosterCalGUI.PopupMenuClockedClick(Sender: TObject);
begin
  ChangeItemsToClocked;
end;

procedure TRosterCalGUI.DeleteItems;
var
  i: integer;
  bAllDeleted: boolean;
  planner: TDBPlanner;
begin
  // All I want to do here is delete all the selected items, but there seems to
  // .. be no easy way to do this that I can find.
  // So we must go thru all the items looking for selcted ones and tagging them
  // .. for deletion.  We cannot delete them as we go at this stage cuz when you
  // .. delete an item the selection is shifted to the next item, and we would therefore
  // .. end up deleting all the items


  planner := GetPlanner;

  if AnyAppointments() then begin
    if CommonLib.MessageDlgXP_Vista('One or more of the Selected Items have Associated Appointments'#10#13 +
      'To Reschedule Appointments, Answer "No" and Right-Click on the Rostered Item'#10#13#10#13 +
      'Do you wish to Continue?', mtWarning, [mbYes, mbNo], 0) <> mrYes then begin
      Exit;
    end;
  end;

  planner.Items.BeginUpdate;

  // tag all the selected items for deletion
  for i := 0 to planner.Items.Count - 1 do begin
    if planner.Items.Items[i].Selected then begin
      planner.Items.Items[i].Tag := -999;  // tag item for deletion (ClassID = -999 is safe)
    end;
  end;

  // Delete any corresponding UNAVAILABLE appointments (from tblAppointments)
  for i := 0 to planner.Items.Count - 1 do begin
    if planner.Items.Items[i].Selected then begin
    //  if planner.Items.Items[i].Color = CL_UNAVAILABLE then begin
      DeleteRosterRelatedEntries(Planner.Items.Items[i]);
    end;
  end;

  // now delete all the selcted items.
  // We have to restart after each delete cuz the item count changes  aftter each delete
  bAllDeleted := false;
  while not bAllDeleted do begin
    bAllDeleted := true;   // assume we've got them all at this stage
    for i := 0 to planner.Items.Count - 1 do begin
      if planner.Items.Items[i].Tag = -999 then begin
        DeleteRoster(planner , planner.Items.Items[i]);
        planner.Update;
        bAllDeleted := false;
        Break;
      end;
    end;
  end;

  planner.Items.EndUpdate;
end;
Procedure TRosterCalGUI.DeleteRoster(planner: TDBPlanner; Item:TPlannerItem);
begin
  planner.FreeItem(Item);
end;
Procedure TRosterCalGUI.DeleteRosterRelatedEntries(Item:TPlannerItem);
begin
      if TItemProperties(Item.ItemObject).TypeName = UNAVAILABLE then begin
        DeleteUnavailableAppointment(Item);
      end;
      if TItemProperties(Item.ItemObject).TypeCatagory = 'Leave' then begin
        DeleteUnavailableAppointment(Item);
      end;
end;
procedure TRosterCalGUI.ChangeItemsToClocked;
var
  i: integer;
  planner: TDBPlanner;
begin
  planner := GetPlanner;
  planner.Items.BeginUpdate;
  
  // tag all the selected items for change
  for i := 0 to planner.Items.Count - 1 do begin
    if planner.Items.Items[i].Selected then begin
      if planner.Items.Items[i].Shape = psRounded then begin
        planner.Items.Items[i].Shape := psRect;
        planner.Items.Items[i].BrushStyle := BRUSH_CLOCKED;
        TItemProperties(planner.Items.Items[i].ItemObject).IsClocked := True;
        planner.Items.Items[i].Update;
      end else if  planner.Items.Items[i].Shape = psRect then begin
        CommonLib.MessageDlgXP_Vista('Item is already clocked.', mtInformation,[mbOk], 0);
      end else begin
        CommonLib.MessageDlgXP_Vista('Leaves cannot be converted to clocked but will be paid if preference is set.', mtInformation,[mbOk], 0);
      end;
    end;
  end;
  planner.Items.EndUpdate;
  planner.Items.UnSelectAll;
end;

procedure TRosterCalGUI.Appointments;
var
  Form: TComponent;
begin
  Form := GetComponentByClassName('TCalendarGUI');
  if Assigned(Form) then begin //if has acess
    with TCalendarGUI(Form) do begin
      TCalendarGUI(Form).DBDaySource1.Day := GetDateFromWeeklyPlanner;
      TCalendarGUI(Form).DBDaySource2.Day := GetDateFromWeeklyPlanner;
      FormStyle := fsMDIChild;
      BringToFront;
    end;
  end;
end;

procedure TRosterCalGUI.EditItems;
var
  dtEarliest, dtStart, dtEnd: TDateTime;
  iBaseItem: integer;
  planner: TPlanner;
  i: integer;
begin
  if AnyAppointments() then begin
    if CommonLib.MessageDlgXP_Vista('One or more of the Selected Items have Associated Appointments'#10#13 +
      'To Reschedule Appointments, Answer "No" and Right-Click on the Rostered Item'#10#13#10#13 +
      'Do you wish to Continue?', mtWarning, [mbYes, mbNo], 0) <> mrYes then begin
      Exit;
    end;
  end;

  // Get the earliest item selected
  planner := GetPlanner;
  iBaseItem := -1;
  dtEarliest := 65000;
  for i := 0 to planner.Items.Count - 1 do begin
    if planner.Items.Items[i].Selected then begin
      if dtEarliest >= planner.Items.Items[i].ItemStartTime then begin
        dtEarliest := planner.Items.Items[i].ItemStartTime;
        iBaseItem := i;
      end;
    end;
  end;

  if iBaseItem >= 0 then begin
    // here we open up the roster edit form to allow change of times
    with TRosterEditGUI.Create(self) do begin
      try
        fbDirectUpdate := false;
        dtpStart.Time := planner.Items.Items[iBaseItem].ItemStartTime;
        dtpEnd.Time := planner.Items.Items[iBaseItem].ItemEndTime;
        dtDate.Date := StartOfTheDay(planner.Items.Items[iBaseItem].ItemStartTime);
        dtDateTo.Date := StartOfTheDay(planner.Items.Items[iBaseItem].ItemendTime);
        Position := poScreenCenter;

        ShowModal;
        if fbOk then begin
          dtStart := dtpStart.Time;
          dtEnd := dtpEnd.Time;

          for i := 0 to planner.Items.Count - 1 do begin
            if planner.Items.Items[i].Selected then begin
              planner.Items.Items[i].ItemStartTime :=
                (*StartOfTheDay(planner.Items.Items[i].ItemStartTime)*)dtDate.Date + dtStart;
              // i used item starttime here cuz there is a bug with the planner incrementing
              // .. spuriously to the next day at times with ItemEndTime
              planner.Items.Items[i].ItemEndTime :=
                (*StartOfTheDay(planner.Items.Items[i].ItemStartTime)*)dtDate.Date + dtEnd;
              planner.Items.Items[i].Update;
              if planner.Items.Items[i].Color = CL_UNAVAILABLE then begin
                EditUnavailableAppointment(planner.Items.Items[i]); // edit corresponding appointment
              end;
            end;
          end;
        end;
      finally
        Free;
      end;
    end;
  end;
end;

procedure TRosterCalGUI.RepeatItems;
var
  dtEarliest: TDateTime;
  iBaseItem: integer;
  planner: TPlanner;
  i: integer;
  procedure CreateItems(const dates: array of TDateTime);
  var
    i, j: integer;
    dtStart: TDateTime;
    lstItems: TList;
    pItem: PItemRec;
  begin

    lstItems := TList.Create;
    try
      Randomize;
      planner.Items.BeginUpdate;
      for i := 0 to planner.Items.Count - 1 do begin
        if planner.Items.Items[i].Selected then begin
          for j := 0 to Length(dates) - 1 do begin
            dtStart := planner.Items.Items[i].ItemStartTime + (StartOfTheDay(dates[j]) - dtEarliest);

            New(pItem);
            lstItems.Add(pItem);
            pItem^.EmployeeID := GetEmployeeFromPosition(planner.Items.Items[i].ItemPos);
            pItem^.ItemType :=  TItemProperties(planner.Items[i].ItemObject).TypeName;   //GetType(planner.Items.Items[i]);
            pItem^.ItemTypeCatagory := TItemProperties(planner.Items[i].ItemObject).TypeCatagory;
            pItem^.StartTime := dtStart;
            // Wierd and strange things happen here.  It appears that the end time created
            // .. is on the next day to the starttime...I can't give much more info, but it
            // .. does not give sensible results.
            //.. To fix the problem I assume that the start and end is always on the same day
            //.. Its pretty ugly....
            pItem.EndTime := StartOfTheDay(dtStart) + TimeOf(planner.Items.Items[i].ItemEndTime);
            pItem^.PlannerID := AppEnv.DefaultClass.DefaultClassName + FormatDateTime('yy:m:d:h:n:s:z:', Now()) + IntToStr(i * Length(dates) + j);
            if TItemProperties(planner.Items[i].ItemObject).IsClocked then begin
              pItem^.IsClocked := 'T';
              pItem^.ClockedOff := 'T';
            end else begin
              pItem^.IsClocked := 'F';
              pItem^.ClockedOff := 'F';
            end;
            pItem^.ClassID :=  TItemProperties(planner.Items[i].ItemObject).DepartmentID;
          end;
        end;
      end;

      for i := 0 to lstItems.Count - 1 do begin
        pItem := lstItems[i];
        qryWeekRoster.Open; // just in case
        qryWeekRoster.Insert;
        with qryWeekRoster do begin
          FieldByName('EmployeeID').AsInteger := pItem^.EmployeeID;
          FieldByName('PlannerID').AsString := pItem^.PlannerID;
          FieldByName('Type').AsString := pItem^.ItemType;
          FieldByName('TypeCatagory').AsString := pItem^.ItemTypeCatagory;
          FieldByName('ClockedOff').AsString := pItem^.ClockedOff;
          if pItem^.ClassID <> 0 then FieldByName('ClassID').AsInteger := pItem^.ClassID
          else FieldByName('ClassID').AsInteger := GetEmployeeClass(pItem^.EmployeeID);  
          FieldByName('IsClocked').AsString := pItem^.IsClocked;
          FieldByName('StartTime').AsDateTime := pItem^.StartTime;
          FieldByName('EndTime').AsDateTime := pItem^.EndTime;
          FieldByName('Hours').AsFloat := HourSpan(qryWeekRoster.FieldByName('EndTime').AsDateTime, qryWeekRoster.FieldByName('StartTime').AsDateTime);
          FieldByName('Hours').AsFloat := RoundTo(qryWeekRoster.FieldByName('Hours').AsFloat, - 3);

          Post;
        end;
      end;
      planner.Items.EndUpdate;
      planner.Items.UnSelectAll;
      DaySource.SynchDBItems;
      WeekSource.SynchDBItems;

    finally
      FreeandNil(lstItems);
    end;
  end;
begin // procedure TRosterCalGUI.RepeatItems;

  // Get the earliest date selected
  planner := GetPlanner;
  iBaseItem := -1;
  dtEarliest := 65000;
  for i := 0 to planner.Items.Count - 1 do begin
    if planner.Items.Items[i].Selected then begin
        if dtEarliest >= StartOfTheDay(planner.Items.Items[i].ItemStartTime) then begin
          dtEarliest := StartOfTheDay(planner.Items.Items[i].ItemStartTime);
          iBaseItem := i;
        end;
    end;
  end;

  if iBaseItem >= 0 then begin
    with TRepeatFrm.Create(self, CommonDbLib.GetSharedMyDacConnection.Database) do begin
      try
        Caption := 'Repeat Roster Item';
        dtBaseDate.Date := dtEarliest;
        dtBaseDate.Enabled := false;
        dtFinalDate.Date := dtBaseDate.Date + 14;
        ShowModal;
        if ModalResult = mrOk then begin
          CreateItems(dates);
        end;
      finally
        Free;
      end;
    end;
  end;
end;

function TRosterCalGUI.GetCaption(Const item: TPlannerItem): string;

  function GetLabelNum(const sLabel: string): string;
  var
    i: integer;
  begin
    Result := '';
    for i := 0 to grdClass.RowCount - 1 do begin
      if Sysutils.SameText(grdClass.Cells[1, i], sLabel) then begin
        Result := grdClass.Cells[0, i];
        Break;
      end;
    end;
  end;
begin
  Result := GetLabelNum(GetTypeName(item.Color));
end;

procedure TRosterCalGUI.btnPrevClick(Sender: TObject);
begin
  inherited;
  if PageControl1.ActivePage = tabWeekly then begin
    dtpMonth.Date := incMonth(dtpMonth.Date , -1);
  end else begin
    dtpMonth.Date := incday(dtpMonth.Date , -1);
  end;
end;

procedure TRosterCalGUI.btnPrintClick(Sender: TObject);
const
  LEGEND_LABELS_PER_ROW = 13;
  ctText: TCaptionType  = Planner.ctText;
  ctNone: TCaptionType  = Planner.ctNone;
var
  planner: TDBPlanner;
  i: integer;
  sLine: string;
  CopyCount: integer;
  PrintRoster: boolean;
begin
  DisableForm;
  try
    inherited;
    CopyCount := 1;

    if AppEnv.Employee.ShowPrintDialog then begin
      PrintRoster := PrintDialog.Execute;

      if PrintRoster then CopyCount := PrintDialog.Copies;
    end else PrintRoster := true;

    if PrintRoster then begin
      while CopyCount > 0 do begin
        planner := GetPlanner;
        planner.PrintOptions.Orientation := poLandscape;
        planner.PrintOptions.FitToPage := true;
        planner.PrintOptions.CellWidth := 150;
        planner.PrintOptions.SideBarWidth := 300;


        // set up footer
        planner.PrintOptions.FooterSize := 400;
        planner.PrintOptions.Footer.Clear;
        planner.PrintOptions.Footer.Add('');
        for i := 0 to grdClass.RowCount - 1 do begin
          if (i <> 0) and (i mod LEGEND_LABELS_PER_ROW = 0) then begin
            planner.PrintOptions.Footer.Add(sLine);
            sLine := '';
          end;
          sLine := sLine + '     ' + grdClass.Cells[0, i] + ' ' + grdClass.Cells[1, i]
        end;
        if (grdClass.RowCount mod LEGEND_LABELS_PER_ROW <> 0) then begin
          planner.PrintOptions.Footer.Add(sLine);
        end;
        planner.PrintOptions.Footer.Add('     ( Printed: ' + FormatDateTime('dd/mm/yyyy hh:nn', Now()) + ' )');

        // set up header
        planner.PrintOptions.HeaderSize := 350;
        planner.PrintOptions.Header.Clear;
        planner.PrintOptions.Header.Add(CommonDbLib.GetCompanyName);
        planner.PrintOptions.Header.Add('Roster: ' + dtpMonth.Text);

        // Optimize item appearance for printing
        planner.Items.BeginUpdate;
        for i := 0 to planner.Items.Count - 1 do begin
          if planner.Items.Items[i].Shape = psRect then begin
            // don't show clocked on the roster
            planner.Items.Items[i].Visible := false;
          end else begin
            planner.Items.Items[i].Selected := true;
            planner.Items.Items[i].CaptionType := ctText;
            planner.Items.Items[i].CaptionText := GetCaption(planner.Items.Items[i]);
          end;
        end;
        planner.Items.EndUpdate;

        planner.Print;

        // Optimize item appearance for viewing
        planner.Items.BeginUpdate;
        for i := 0 to planner.Items.Count - 1 do begin
          if planner.Items.Items[i].Shape = psRect then begin
            // don't show clocked on the roster
            planner.Items.Items[i].Visible := true;
          end else begin
            planner.Items.Items[i].Selected := false;
            planner.Items.Items[i].CaptionType := ctNone;
            planner.Items.Items[i].CaptionText := '';
          end;
        end;
        planner.Items.EndUpdate;
        Dec(CopyCount);
      end;
    end;
  finally
    EnableForm;
  end;  
end;

procedure TRosterCalGUI.btnReportClick(Sender: TObject);
begin
  inherited;
  CommitTransaction;
  bSaved := true;
  Notify;
  OpenERPListForm('TrosterReportGUI', beforeshowrosterReport);
  if fsModal in FormState then begin
    ModalResult := mrOk;
  end else begin
    Close;
  end;
end;
procedure TRosterCalGUI.beforeshowrosterReport(Sender: TObject);
begin
  if not(Sender is TrosterReportGUI) then exit;

  if PageControl1.ActivePage = tabWeekly then begin
    TrosterReportGUI(Sender).Dtfrom.date := EndOfAMonth(YearOf(dtpMonth.Date) , MonthOfTheYear(dtpMonth.Date));
    TrosterReportGUI(Sender).DtTo.date   := StartOfAMonth(YearOf(dtpMonth.Date), MonthOfTheYear(dtpMonth.Date));
  end else begin
    TrosterReportGUI(Sender).Dtfrom.date := dtpMonth.Date;
    TrosterReportGUI(Sender).DtTo.date   := dtpMonth.Date;
  end;
  TrosterReportGUI(Sender).fbDateRangeSupplied:= TRue;
end;
procedure TRosterCalGUI.SetItemColor(Const item: TPlannerItem; Const colour: TColor);
begin
  item.Color := colour;
end;

procedure TRosterCalGUI.plannerWeekItemSelect(Sender: TObject; Item: TPlannerItem);
var
  qry: TERPQuery;
  bFound:Boolean;
begin
  inherited;
  bFound := False;
  qry := TERPQuery.Create(nil);
  try
    with qry do begin
      Connection := MyConnection;
      SQL.Clear;
      SQL.Add('SELECT PlannerID,EmployeeID,ClassID FROM tblroster WHERE PlannerID = ');
      SQL.Add(QuotedStr(Item.DBKey));
      Open;
      if qry.RecordCount > 0 then begin
        iSelectedItemClassID := FieldByName('ClassID').AsInteger;
        bFound := True;
      end;
    end;
  finally
    FreeAndNil(qry);
  end;

  if not bFound then begin     //no class previously selected so load employees default class
    Item.Tag := GetEmployeeClass(GetEmployeeID(TPlanner(Sender).Header.Captions.Strings[Item.ItemPos + 1]));
  end;

  bAllowMove := false;  // do not allow cell to be moved without checking appointments
  // select the planner cell of the selected item (assume one day only)
  Item.Planner.SelectCells(Item.ItemBegin, Item.ItemBegin, Item.ItemPos);
end;

procedure TRosterCalGUI.plannerWeekItemMoving(Sender: TObject; Item: TPlannerItem; DeltaBegin, DeltaPos: integer; var Allow: boolean);
begin
  inherited;
  if not bAllowMove then begin
    bAllowMove := true;  // assume allowed at this stage
    if AnyAppointments(Item) then begin
      Allow := false;  // abandon move
      if CommonLib.MessageDlgXP_Vista('There are Appointments Scheduled for this Employee.  '#10#13 +
        'To Reschedule Appointments, Answer "No" and Right-Click on the Rostered Item'#10#13#10#13 +
        'Continue?',
        mtWarning, [mbYes, mbNo], 0) <> mrYes then begin
        bAllowMove := false;   // do not allow moving without checking
      end;
    end;
  end;
end;

procedure TRosterCalGUI.GetAppointments(Const dtStart, dtEnd: TDateTime; Const iPos: integer);
var
  dtEndTime, dtStartTime: TDateTime;
begin
  dtStartTime := dtStart;
  dtEndTime := SetToSameDay(dtStart, dtEnd);
  with qryChkAppoints do begin
    Close;
    Params.ParamByName('xTrainerID').AsInteger          := GetEmployeeFromPosition(iPos);
    Params.ParamByName('xRosteredStartTime').AsDateTime := dtStartTime;
    Params.ParamByName('xRosteredEndTime').AsDateTime   := dtEndTime;
    Open;
  end;
end;

function TRosterCalGUI.SetToSameDay(Const dtDate, dtTime: TDateTime): TDateTime;
{
  This funtion returns a DateTime whose time is given by dtTime and Date is given
  by dtDate.

  The need for this function arose cuz the Date time given by item.endtime
  seemed often to be incremented to the next day when the date was the saved
  the sames as the start date.
}
Var
  tTime: TDateTime;
begin
  tTime := TimeOf(dtTime);
  Result := StartOfTheDay(dtDate) + tTime;
end;

function TRosterCalGUI.IsAllocation(Const item: TPlannerItem): boolean;
begin
  Result := (item.Shape = psRounded);
end;

function TRosterCalGUI.AnyAppointments(Const item: TPlannerItem): boolean;
  { check if the rostered item has any associated appointments }
begin
  if IsAllocation(item) and (StartOfTheDay(item.ItemStartTime) >= Date()) then begin
    GetAppointments(item.ItemStartTime, item.ItemEndTime, item.ItemPos);
    Result := (qryChkAppoints.RecordCount > 0);
  end else begin
    Result := false;
  end;
end;

function TRosterCalGUI.AnyAppointments: boolean;
  { check if the any of the selected rostered item have any associated appointments }
var
  planner: TPlanner;
  i: integer;
begin
  Result := false;
  planner := GetPlanner;
  for i := 0 to planner.Items.Count - 1 do begin
    if planner.Items.Items[i].Selected then begin
      if AnyAppointments(planner.Items.Items[i]) then begin
        Result := true;
        Break;
      end;
    end;
  end;
end;

procedure TRosterCalGUI.plannerDayItemSizing(Sender: TObject; Item: TPlannerItem; DeltaBegin, DeltaEnd: integer; var Allow: boolean);
begin
  inherited;
(*
  For some reason we cannot drive the resizing like we do the moving...

  if not bAllowMove then begin
    bAllowMove := true;  // assume allowed at this stage
    if AnyAppointments(Item) then begin
      Allow := False;  // abandon move
      if CommonLib.MessageDlgXP_Vista('There are Appointments Scheduled for this Employee.  '#10#13+
                    'To Reschedule Appointments, Answer "No" and Right-Click on the Rostered Item'#10#13#10#13 +
                    'Continue?',
                    mtWarning, [mbYes, mbNo], 0) <> mrYes then begin
        bAllowMove := false;   // do not allow moving without checking
      end;
    end;
  end;
*)
end;



procedure TRosterCalGUI.plannerDayItemUnSelect(Sender: TObject;
  Item: TPlannerItem);
begin
  inherited;
  SelectedItem := nil;
end;
procedure TRosterCalGUI.CreateUnavailableAppointment(Const item: TPlannerItem);
var
  App: TAppointment;
begin
  App := TAppointment.Create(nil);
  try
    App.Connection := TMyDacDataConnection.Create(App);
    App.Connection.Connection := MyConnection;
    App.New;
    App.AppDate := StartOfTheDay(item.ItemStartTime);
    App.CreationDate := Date;
    App.TrainerID := GetEmployeeFromPosition(item.ItemPos);
    App.Unavailable := true;
    App.ClientId := TClient.CmpanyInfoClientID(self, True, False, False);
    App.StartTime := item.ItemStartTime;
    App.EndTime := SetToSameDay(item.ItemStartTime, item.ItemEndTime);
    App.Status := 'N/A';
    App.Save;
    AppointmentList.AddIfNotInList(App.ID);
  finally
    App.Free;
  end;
end;

procedure TRosterCalGUI.DeleteUnavailableAppointment(Const item: TPlannerItem);
var
  qry: TERPQuery;
  App: TAppointment;
begin
  qry := TERPQuery.Create(self);
  App := TAppointment.Create(nil);
  try
    qry.Connection := MyConnection;
    App.Connection := TMyDacDataConnection.Create(App);
    App.Connection.Connection := MyConnection;
    qry.Sql.Add('select AppointID FROM tblappointments ' +
      'WHERE Unavailable = "T" AND ' +
      '      TrainerID = :xTrainerID AND ' +
      '      TO_DAYS(StartTime) = TO_DAYS(:xItemStartTime)');
    qry.ParamByName('xTrainerID').asInteger := GetEmployeeFromPosition(item.ItemPos);
    qry.ParamByName('xItemStartTime').AsDateTime := item.ItemStartTime;
    qry.Open;
    while not qry.EOF do begin
      App.Load(qry.FieldByName('AppointID').AsInteger);
      App.Active := false;
      App.Save;
      AppointmentList.AddIfNotInList(App.ID);
      qry.Next;
    end;
  finally
    App.Free;
    FreeAndNil(qry);
  end;
end;

procedure TRosterCalGUI.EditUnavailableAppointment(Const item: TPlannerItem);
var
  qry: TERPQuery;
  App: TAppointment;
begin
  qry := TERPQuery.Create(self);
  App := TAppointment.Create(nil);
  try
    qry.Connection := MyConnection;
    App.Connection := TMyDacDataConnection.Create(App);
    App.Connection.Connection := MyConnection;
    qry.Sql.Add('select AppointID from tblappointments ' +
      'WHERE Unavailable = "T" AND ' +
      '      TrainerID = :xTrainerID AND ' +               '      TO_DAYS(StartTime) = TO_DAYS(:xStartTime)');
    qry.ParamByName('xTrainerID').AsInteger  := GetEmployeeFromPosition(item.ItemPos);
    qry.ParamByName('xStartTime').AsDateTime := Item.ItemStartTime;
    qry.Open;
    while not qry.EOF do begin
      App.Load(qry.FieldByName('AppointID').AsInteger);
      App.StartTime := item.ItemStartTime;
      App.EndTime := SetToSameDay(item.ItemStartTime, item.ItemEndTime);
      App.Save;
      AppointmentList.AddIfNotInList(App.ID);
      qry.Next;
    end;
  finally
    FreeAndNil(qry);
    App.Free;
  end;
end;


procedure TRosterCalGUI.FormKeyDown(Sender: TObject; var Key: word; Shift: TShiftState);
var
  cThisKey: char;
begin
  inherited;
  // Convert our keycode to a character.
  cThisKey := Chr(Key);
  // Our shortcut keys for our pagecontrol tabs.
  if Shift = [ssCtrl] then begin
    if cThisKey = 'W' then begin
      PageControl1.ActivePageIndex := 0;
      PageControl1Change(Sender);
      Key := 0;
      Exit;
    end;

    if cThisKey = 'D' then begin
      PageControl1.ActivePageIndex := 1;
      PageControl1Change(Sender);
      Key := 0;
      Exit;
    end;
  end;
end;
//Function TRosterCalGUI.getColorNoforClass(RowNo:Integer):Integer;
//var
//    R:REal;
//    i :Integer;
//    totalcolors :Integer;
//begin
//    if fiClasscolors = 0 then totalcolors := lstColorBox.items.count
//    else totalcolors := fiClasscolors;
//    if RowNo <totalcolors then REsult := RowNo
//    else if RowNo > fdiTotalClasses then begin
//        REsult := (totalcolors + (Rowno -fdiTotalClasses));
//        if REsult > totalcolors + 5 then REsult := totalcolors + 5;
//    end else begin
//        R:=RowNo/(totalcolors);
//        i := system.Round(int(R));
//        REsult  := (RowNo - i * (totalcolors));
//    end;
//end;

procedure TRosterCalGUI.cboClassCloseUp(Sender: TObject;
  LookupTable, FillTable: TDataSet; modified: Boolean);
begin
  if not Modified then Exit;
  inherited;
  PopulateClassGrids;
  ResetRoster;

//  CommonLib.MessageDlgXP_Vista(IntToStr(qryClasses.FieldByName('ClassID').AsInteger), mtInformation,[mbOk], 0);
end;

procedure TRosterCalGUI.ResetRoster;

begin
  with qryWeekRoster do begin
    Close;

    DaySource.Active := False;
    WeekSource.Active := False;

    SQL.Clear;
    SQL.Add('Select RosterID, tblroster.GlobalRef, PlannerID, tblroster.Type, tblroster.EmployeeID,tblroster.Date, ');
    SQL.Add('tblroster.ClassID, tblroster.Notes,tblroster.Hours, StartTime, EndTime, tblroster.EditedFlag, ');
    SQL.Add('ClockedOff,TypeCatagory,IsClocked FROM tblroster INNER JOIN tblEmployees using (EmployeeID)');
    SQL.Add('WHERE IsOnTheRoster = "T" and  Active="T" ');
 //   SQL.Add('and (Type <> "Clocked" or (Type = "Clocked" and ClockedOff = "T"))');
    SQL.Add('and (IsClocked <> "T" or (IsClocked = "T" and ClockedOff = "T"))');
    if chkClasses.Checked <> True then begin
      SQL.Add(' and ClassID = ');
      SQL.Add(IntToStr(qryClasses.FieldByName('ClassID').AsInteger));
    end;

    Open;

    DaySource.Active := True;
    WeekSource.Active := True;
    plannerweek.Refresh;
  end;
end;

procedure TRosterCalGUI.chkClassesClick(Sender: TObject);
begin
  inherited;
  if chkclasses.Checked = True then begin
    cboClass.Enabled := False;
    PopulateClassGrids;
    ResetRoster;
  end else begin
    cboClass.Enabled := True;
    cboClass.DropDown;
  end;
end;

initialization
  RegisterClassOnce(TRosterCalGUI);
end.



