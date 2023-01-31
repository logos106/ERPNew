unit frmProjectInstallation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBPlanner, ProgressDialog, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog, Menus, ExtCtrls, Planner, ComCtrls, wwdbdatetimepicker,
  Shader, StdCtrls, wwdblook, Grids, AdvObj, BaseGrid, AdvGrid, DNMSpeedButton,
  GuiPrefsObj, DNMPanel, BaseInputForm, wwcheckbox, Wwdbigrd, Wwdbgrid, Spin , DNMSizeablePanel;

const
  TYPE_Appointment ='Appointment';
  TYPE_Holiday     ='Holiday';
  TYPE_Leave       ='Leave';

  CL_Appointment   = clGreen;
  CL_GRPAppointment= $0000B900;
  CL_Holiday       = ClGray;
  CL_Leave         = $00FFFF80;
  CL_Select        = clYellow;
  CL_Border        = $0062B0FF;
  CL_Weekend       = clSilver;
  CL_Today         = $00E8E8FF;
  DAYS_IN_PLANNER  = 36; // maximum 5 weeks in the month


type
  TRosterItemProperties = class(TObject)  //used to add extra properties to a planner item
  private
    fiID        : integer;
    fiGroupID   : integer;
    fiClassID   : integer;
    fsTypeName  : string;
    fsGloGalRef : string;
    fiTrainerID : Integer;
    fdDate      : TDateTime;
    fsNotes     : String;
    fsemployeename: String;
    fsClientName: String;
    fsClientCode: String;
    fdHours     : double;
  public
    property ID         : Integer   read fiID         write fiID;
    property GroupID    : Integer   read fiGroupID    write fiGroupID;
    property ClassID    : Integer   read fiClassID    write fiClassID;
    property TypeName   : String    read fsTypeName   write fsTypeName;
    property GloGalRef  : String    read fsGloGalRef  write fsGloGalRef;
    Property TrainerID  : Integer   read fiTrainerID  write fiTrainerID;
    Property Date       : TDateTime read fdDate       write fdDate;
    Property ClientCode : String    read fsClientCode write fsClientCode;
    Property Hours      : double    read fdHours      write fdHours;
    Property Notes      : String    read fsNotes      write fsNotes;
    Property employeename      : String    read fsemployeename      write fsemployeename;
    Property ClientName      : String    read fsClientName      write fsClientName;
  end;


  TfmProjectInstallation = class(TBaseInputGUI)
    pnlMain: TDNMSizeablePanel;
    qryWeekRoster: TERPQuery;
    dsWeekRoster: TDataSource;
    WeekSource: TDBWeekSource;
    PopGrid: TPopupMenu;
    popItem: TPopupMenu;
    MakeLeave1: TMenuItem;
    MakeAppointment1: TMenuItem;
    MnuOpenItem: TMenuItem;
    MnuDelete: TMenuItem;
    MnuReschedule: TMenuItem;
    qryWeekRosterID: TLargeintField;
    qryWeekRosterGlobalRef: TWideStringField;
    qryWeekRosterTrainerID: TLargeintField;
    qryWeekRosterDate: TDateField;
    qryWeekRosterStartTime: TDateTimeField;
    qryWeekRosterEndtime: TDateTimeField;
    qryWeekRosterClassID: TLargeintField;
    qryWeekRosterClientCode: TWideStringField;
    qryWeekRosterNotes: TWideMemoField;
    qryWeekRosteremployeename: TWideStringField;
    qryWeekRosterClientName: TWideStringField;
    qryWeekRosterhours: TFloatField;
    qryWeekRosterType: TWideStringField;
    qryWeekRostergroupID: TLargeintField;
    Planner1: TDBPlanner;
    mnuListAppts: TMenuItem;
    mnuSelectAllintheGroup: TMenuItem;
    UnselectAll1: TMenuItem;
    N1: TMenuItem;
    pnlResize1: TDNMPanel;
    btnDecHeight: TDNMSpeedButton;
    btnIncHeight: TDNMSpeedButton;
    Label1: TLabel;
    pnlRowHeight1: TDNMPanel;
    Label2: TLabel;
    btnDecRowHeight: TDNMSpeedButton;
    btnIncRowHeight: TDNMSpeedButton;
    shpRowHeight1: TShape;
    shpResize1: TShape;
    pnlRowHeight: TDNMPanel;
    shpRowHeight: TShape;
    lblRowHeight: TLabel;
    edtRowHeight: TEdit;
    pnlResize: TDNMPanel;
    shpResize: TShape;
    edtHeight: TEdit;
    lblHeight: TLabel;
    SpnbtnHeight: TSpinButton;
    spnbtnRowHeight: TSpinButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qryWeekRosterBeforeOpen(DataSet: TDataSet);
    procedure SourceFieldsToItem(Sender: TObject; Fields: TFields;Item: TPlannerItem);
    procedure SourceItemTofields(Sender: TObject; Fields: TFields;Item: TPlannerItem);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure WeekSourceResourceToPosition(Sender: TObject; Field: TField;
      var Position: Integer; var Accept: Boolean);
    procedure LeaveRequest1Click(Sender: TObject);
    procedure Appoitntment1Click(Sender: TObject);
    procedure MnuOpenItemClick(Sender: TObject);
    procedure MnuDeleteClick(Sender: TObject);
    procedure Planner1ItemSelect(Sender: TObject; Item: TPlannerItem);
    procedure Planner1ItemUnSelect(Sender: TObject; Item: TPlannerItem);
    procedure Planner1ItemMove(Sender: TObject; Item: TPlannerItem;
      FromBegin, FromEnd, FromPos, ToBegin, ToEnd, ToPos: Integer);
    procedure Move1Click(Sender: TObject);
    procedure qryWeekRosterAfterOpen(DataSet: TDataSet);
    procedure mnuListApptsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure mnuSelectAllintheGroupClick(Sender: TObject);
    procedure Planner1ItemPopupPrepare(Sender: TObject;
      PopupMenu: TPopupMenu; Item: TPlannerItem);
    procedure Planner1HeaderSized(Sender: TObject; APosition,
      AWidth: Integer);
    procedure UnselectAll1Click(Sender: TObject);
(*    procedure btnIncHeightClick(Sender: TObject);
    procedure btnDecHeightClick(Sender: TObject);*)
    procedure Planner1Resize(Sender: TObject);
(*    procedure btnIncRowHeightClick(Sender: TObject);
    procedure btnDecRowHeightClick(Sender: TObject);*)
    procedure OnHeightChange(Sender: TObject);
    procedure OnRowHeightChange(Sender: TObject);
    procedure SpnbtnHeightDownClick(Sender: TObject);
    procedure SpnbtnHeightUpClick(Sender: TObject);
    procedure spnbtnRowHeightDownClick(Sender: TObject);
    procedure spnbtnRowHeightUpClick(Sender: TObject);
    procedure edtHeightKeyPress(Sender: TObject; var Key: Char);
    procedure edtRowHeightKeyPress(Sender: TObject; var Key: Char);
    procedure pnlMainResize(Sender: TObject);
  private

    fbformshown : Boolean;
    CreateIfWorkingDay :Boolean;
    //WeekDatesSelected:Array of TDateTime;
    //fiEmpIDForAppt :Integer;
    itemsSelected, Itemno:Integer;
    iDaysToreschedule :Integer;
    iEmprescheduleTo :Integer;
    FirstSelectedItem: TPlannerItem;

    //itemsingroup:Integer;
    UpdateLinkedAppointmentsonReschedule:Boolean;
    RowHeight:Integer;
    fdStartDate: TDate;
    fqryEmployees: TERPQuery;
    fiMonthno: Integer;
    fdBaseDate: TdateTime;
    fbAllclasses: Boolean;
    fiClassID: Integer;
    CurgroupID:Integer;
    Flag :Boolean;
    procedure UpdateHeaders(const planner: TDBPlanner);
    function InitPlanners:Boolean;
    //function GetEmployeeFromPosition(const TrainerID: integer): integer;
    function GetEmployeeFromPosition(const Position: integer): integer;
    function GetPositionFromEmployee(const TrainerID: integer): integer;
    procedure MakeLeaveRequest(Item: TPlannerItem);
    ///////Procedure MakeAppointment(Item: TPlannerItem);
    Procedure DeleteItem(Item: TPlannerItem);
    Procedure OpenItem(Item: TPlannerItem);
    //////function EmpOnLeave(const iEmployeeID:Integer; fDate:TDateTime):Boolean;
    //////procedure InitApptGroupAptdates(Sender: TObject);
    procedure SetPlannerEvents;
    procedure DeleteAppt(Item: TPlannerItem);
    procedure DeleteLeave(Item: TPlannerItem);
    procedure openAppt(Item: TPlannerItem);
    procedure openLeave(Item: TPlannerItem);
    procedure OpenHoliday(Item: TPlannerItem);
    procedure IncnShowItemNoProcessed(const Itemtype:String);
    Procedure ValidateSelectionToDelete;
    //Procedure ValidateSelectionToReschedule;
    //Procedure ValidateSelectionToMove;
    procedure ValidateSelectionToDeleteCallback(Item: TPlannerItem);
    //procedure ValidateSelectionToRescheduleCallback(Item: TPlannerItem);

    //procedure ValidateSelectionToMoveCallback(Item: TPlannerItem);
    //procedure ResceduleItem(Item: TPlannerItem);
    procedure ReScheduleAppt(Item: TPlannerItem);
    procedure RescheduleLeave(Item: TPlannerItem);
    //////procedure SelectAllintheGroup(Item: TPlannerItem);
    procedure SelectmainAptCallback(Item: TPlannerItem);

    procedure OnInsertnUpdateDs(Sender: TObject; APlannerItem: TPlannerItem);
    //procedure SelectAllAptinGroup( Item: TPlannerItem);
    //procedure SelectMainAppt;
    procedure FilterAppointmentList(Sender: TObject);
    procedure initform;
    procedure SetMonthno(const Value: Integer);
    procedure setBaseDate(const Value: TdateTime);
    Function DateFrom :TDateTime;
    Function DAteTo:TDateTime;
    Procedure TimerMsg(const Value:String);
    Procedure doDatechange;
    function WeekEmployeeID(Item: TPlannerItem): Integer;
    function EmployeeID(planner: TDBPlanner; Item: TPlannerItem): Integer;
    procedure ResetHeights(const fRowHeight, fPanelHeight: Integer);
    function Heightvalue: Integer;
    function RowHeightvalue: Integer;
  Protected
    procedure SetConnectionString(const TransactionMode: boolean = true);Override;
  public
    IsDirty:Boolean;
    function ISOKToSelect(Item: TPlannerItem): Boolean;
    Procedure RefreshQuery;
    Property StartDate :TDate read fdStartDate write fdStartDate;
    Property qryEmployees :TERPQuery read fqryEmployees write fqryEmployees;
    Class Function ProjectInstallationInst(AOwner:Tform; iMonthNo:Integer;IsfirstIsntance:Boolean):TfmProjectInstallation;
    function MaxItemPerCell: Integer;
    Procedure ReadGuiprefs(fGuiPrefs: TFormGuiPrefs);
    Procedure WriteGuiprefs(fGuiPrefs: TFormGuiPrefs);
    Property Monthno :Integer read fiMonthno write SetMonthno;
    Property BaseDate:TdateTime read fdBaseDate write setBaseDate;
    Property ClassID:Integer read fiClassID write fiClassId;
    Property Allclasses :Boolean read fbAllclasses write fbAllclasses;
    function NewItemProperty: (*TRosterItemProperties*)TObject;
    Function SelectmainApt(fiCurgroupID:Integer):boolean;
  end;

implementation

uses DNMLib, CommonLib, SystemLib, CommonDbLib, AppEnvironment , Dateutils,
  LogLib, MySQLConst, (*ManufactureLib, *)BusObjAppointments, PlannerLib,
  BusObjEmployeeLeaveRequests, tcDataUtils, DbSharedObjectsObj, CommonFormLib,
  frmAppointments, tcConst, frmDateSelectDialog, AppointmentListForm,
  frmCalendar, frmProjectInstallationRoster, ManufactureLib;


{$R *.dfm}
(*function TfmProjectInstallations.EmpOnLeave(Const iEmployeeID:Integer; fDate:TDateTime):Boolean;
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
end;*)
(*Procedure TfmProjectInstallations.MakeAppointment(Item: TPlannerItem);
begin
  if not(CreateIfWorkingDay) or (isworkingday(Dateof(item.ItemStartTime)) and Not(EmpOnLeave(WeekEmployeeID(Item), Dateof(item.ItemStartTime)) )) then begin
    SetLength(WeekDatesSelected , length(WeekDatesSelected)+1);
    WeekDatesSelected[high(WeekDatesSelected)] := Dateof(item.ItemStartTime);
    fiEmpIDForAppt := WeekEmployeeID(Item);
  end;
end;*)
(*procedure TfmProjectInstallations.InitApptGroupAptdates(Sender:TObject);
begin
   if not(Sender is TAppointmentGUI) then exit;
   TAppointmentGUI(Sender).TransConnection := MyConnection;
   TAppointmentGUI(Sender).InitialEmployeeID :=fiEmpIDForAppt;
   TAppointmentGUI(Sender).GroupAptdates(WeekDatesSelected);
end;*)
procedure TfmProjectInstallation.Appoitntment1Click(Sender: TObject);
begin
  inherited;
  if (Assigned(Owner)) and (owner is TfmProjectInstallationRoster) then begin
    TfmProjectInstallationRoster(Owner).MakeAppointments;
  end;

(*  try
    SetLength(WeekDatesSelected , 0);
    try
        CreateIfWorkingDay :=  MessageDlgXP_Vista('Do you wish to exclude the Holidays and Weekend Days?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
        IterateOnSelectedCells(Planner1 ,MakeAppointment ,NewItemProperty);
        if Length(WeekDatesSelected)>0 then begin
            OpenERPFormModal('TAppointmentGUI' , 0, InitApptGroupAptdates);
            Application.ProcessMessages;
        end;
    finally
      SetLength(WeekDatesSelected , 0);
    end;
    RefreshQuery;
  Except
    on E:Exception do begin
      MessageDlgXP_vista('e.message', mtWarning, [mbOK], 0);
    end;
  end;*)

end;

Function TfmProjectInstallation.MaxItemPerCell:Integer;
var
  Qry:TERPQuery;
begin
  Qry := DbSharedObj.GetQuery(myconnection);
  try
    Qry.SQL.Text := 'Select TrainerId, Date , count(ID) ctr from ( ' + qryWeekRoster.SQL.Text+') as Main group by trainerId, date  order by ctr desc limit 1';
    Qry.open;
    result := Qry.fieldbyname('ctr').AsInteger;
    if result =0 then result := 1;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;
procedure TfmProjectInstallation.FormActivate(Sender: TObject);
begin
  inherited;
  if WindowState <> wsMaximized then WindowState := wsMaximized;
end;

procedure TfmProjectInstallation.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //WriteGuiprefs;
  inherited;
  Action := caFree;
end;

procedure TfmProjectInstallation.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
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

procedure TfmProjectInstallation.FormCreate(Sender: TObject);
begin
  fbAllclasses:=False;
  fiClassID:=0;
  Planner1.Display.colorNonActive:= CL_Weekend;
  Planner1.Display.Colorcurrent:= CL_Today;
  fdBaseDate := 0;
  fdStartDate :=  Date;
  UpdateLinkedAppointmentsonReschedule:= true;
  WeekSource.Month := monthof(date);
  WeekSource.year := yearof(date);
  itemsSelected:= 0;
  Itemno :=0;
  fbformshown := False;
  inherited;
  IsDirty:= False;
  SetPlannerEvents;
  iDaysToreschedule:= 0;
  iEmprescheduleTo := 0;
  pnlResize.Top := 0;
  pnlResize.Left := pnlResize.Parent.Width-pnlResize.Width;
  pnlRowHeight.Top := 0;
  pnlRowHeight.Left := pnlResize.Left - pnlRowHeight.Width-2;
  pnlResize.Transparent := True;
  pnlResize.Parentcolor := False;
  pnlRowHeight.Transparent := True;
  pnlRowHeight.Parentcolor := False;
  shpResize.top := 0; shpResize.left := 0; shpResize.width := shpResize.parent.width; shpResize.height := shpResize.parent.height-1;
  shpRowHeight.top := 0; shpRowHeight.left := 0; shpRowHeight.width := shpRowHeight.parent.width; shpRowHeight.height := shpRowHeight.parent.height-1;
  edtHeight.top     := lblHeight.top    ; edtHeight.height    := lblHeight.height;
  edtRowHeight.top  := lblRowHeight.top ; edtRowHeight.height := lblRowHeight.height;
end;

procedure TfmProjectInstallation.initform;
Var
  QueryNamesNotToOpen: Array Of String;
begin
    inherited;
    //UserLock.enabled := True;
    //ReadGuiprefs;
    Setlength(QueryNamesNotToOpen, 1);
    QueryNamesNotToOpen[0] := 'qryWeekRoster';
    OpenQueries(QueryNamesNotToOpen);
    //RefreshQuery;
    //dtpMonth.Date := StartDate;
    InitPlanners;
    //BeginTransaction;
    IsDirty := False;
    fbformshown := True;
(*    edtHeight.Value := pnlMain.Height ;
    edtRowHeight.Value :=  Planner1.PositionWidth;*)
end;



procedure TfmProjectInstallation.Planner1HeaderSized(Sender: TObject;
  APosition, AWidth: Integer);
begin
  inherited;
  RowHeight:= AWidth;
end;

procedure TfmProjectInstallation.Planner1ItemMove(Sender: TObject; Item: TPlannerItem;  FromBegin, FromEnd, FromPos, ToBegin, ToEnd, ToPos: Integer);
begin
  inherited;
      if assigned(Item.ItemObject) then begin
            if TRosterItemProperties(Item.ItemObject).typename  = TYPE_Appointment then begin
              iEmprescheduleTo := GetEmployeeFromPosition(ToPos);
              iDaysToreschedule  := Daysbetween(incday(Planner1.mode.Periodstartdate , frombegin) , incday(Planner1.mode.Periodstartdate , tobegin));
              if tobegin < frombegin  then iDaysToreschedule := 0-iDaysToreschedule;
              try
                UpdateLinkedAppointmentsonReschedule := False;
                try
                  ReScheduleAppt(Item);
                finally
                  UpdateLinkedAppointmentsonReschedule := true;
                end;
              finally
                iEmprescheduleTo := 0;
                iDaysToreschedule  := 0;
              end;
            end else if TRosterItemProperties(Item.ItemObject).typename  = TYPE_Leave then begin
              iDaysToreschedule  := Daysbetween(incday(Planner1.mode.Periodstartdate , frombegin) , incday(Planner1.mode.Periodstartdate , tobegin));
              RescheduleLeave(Item);
            end;
      end;
      item.selected := False;
      //Item.Update;
end;

procedure TfmProjectInstallation.Planner1ItemPopupPrepare(Sender: TObject;PopupMenu: TPopupMenu; Item: TPlannerItem);
begin
  inherited;
  mnuSelectAllintheGroup.Visible := TRosterItemProperties(Item.ItemObject).typename = TYPE_Appointment;
  MnuReschedule.Visible := (TRosterItemProperties(Item.ItemObject).typename = TYPE_Appointment) (*or (TRosterItemProperties(Item.ItemObject).typename = TYPE_Leave) *);
  MnuDelete.Visible := (TRosterItemProperties(Item.ItemObject).typename = TYPE_Appointment) or (TRosterItemProperties(Item.ItemObject).typename = TYPE_Leave) ;
  mnuListAppts.Visible := TRosterItemProperties(Item.ItemObject).typename = TYPE_Appointment;
  MnuOpenItem.Visible := (TRosterItemProperties(Item.ItemObject).typename = TYPE_Appointment) or (TRosterItemProperties(Item.ItemObject).typename = TYPE_Leave)  or (TRosterItemProperties(Item.ItemObject).typename = TYPE_Holiday) ;
end;

Function TfmProjectInstallation.ISOKToSelect( Item: TPlannerItem):Boolean;
var
  i: integer;
begin
  REsult := False;
  for i := 0 to Planner1.Items.Count - 1 do begin
    if (Planner1.Items.Items[i] <> item) and (Planner1.Items.Items[i].Selected) then begin
      if not Sametext(TRosterItemProperties(Item.ItemObject).typename , TRosterItemProperties(Planner1.Items.Items[i].ItemObject).typename) then begin
        TimerMsg(TRosterItemProperties(Planner1.Items.Items[i].ItemObject).typename +' is already selected.  You can select items of the same type only');
        exit; // same type can be selected
      end;
      if TRosterItemProperties(Item.ItemObject).typename = TYPE_Appointment then
        if (TRosterItemProperties(Item.ItemObject).GroupID <> TRosterItemProperties(Planner1.Items.Items[i].ItemObject).GroupID) then begin
          TimerMsg('An appointment of another group is already selected.  You can select appointments of the same group only.');
          exit; // Same group of the appointment
        end;
    end;
  end;
  result := TRue;
end;
(*procedure TfmProjectInstallations.SelectAllAptinGroup( Item: TPlannerItem);
var
  i: integer;
  flag:Boolean;
begin
  flag:=False;
  if not (TRosterItemProperties(Item.ItemObject).typename = TYPE_Appointment) then exit;
  for i := 0 to Planner1.Items.Count - 1 do begin
    if (Planner1.Items.Items[i] <> item) then
      if  not(Planner1.Items.Items[i].Selected) then
        if (TRosterItemProperties(Planner1.Items.Items[i].ItemObject).typename = TYPE_Appointment ) then
          if TRosterItemProperties(Item.ItemObject).GroupID <> 0 then
            if (TRosterItemProperties(Item.ItemObject).GroupID = TRosterItemProperties(Planner1.Items.Items[i].ItemObject).GroupID) then begin
                Planner1.Items.Items[i].Selected := True;
                Planner1.Items.Items[i].Color :=CL_Select;
                Planner1.Items.Items[i].ColorTo :=CL_Select;
                flag:=true;
                //Planner1.Items.Items[i].Update;
            end;
  end;
  if flag then
    TimerMsg( 'All appointments of the group is selected');
end;*)

procedure TfmProjectInstallation.mnuSelectAllintheGroupClick(Sender: TObject);
begin
  inherited;
  if (Assigned(Owner)) and (owner is TfmProjectInstallationRoster) then begin
    TfmProjectInstallationRoster(Owner).SelectAllIntheGroup;
  end;

  (*  FirstSelectedItem := GetFirstItemSelected(Planner1);
  try
    if not(Assigned(FirstSelectedItem)) then  begin
      MessageDlgXP_Vista('Please select an item', mtWarning, [mbOK], 0);
      exit;
    end;
    if TRosterItemProperties(FirstSelectedItem.ItemObject).GroupID=0 then exit;
    itemsingroup := 0;
    IterateOnAllItems(Planner1,SelectAllintheGroup);
    if ItemsInGroup >0 then TimerMsg( inttostr(itemsingroup) +' appointments in the group.');
    Planner1.Update;
  finally
    FirstSelectedItem := nil;
  end;*)
end;
(*procedure TfmProjectInstallations.SelectAllintheGroup(Item: TPlannerItem);
begin
  if not(Assigned(FirstSelectedItem)) then exit;

  Item.selected := (Item = FirstSelectedItem) or (TRosterItemProperties(Item.ItemObject).GroupID = TRosterItemProperties(FirstSelectedItem.ItemObject).GroupID);
  if Item.selected  then begin
    Item.Color :=CL_Select;
    Item.ColorTo :=CL_Select;
    itemsingroup := itemsingroup+1;
  end;
end;*)
(*procedure TfmProjectInstallations.SelectMainAppt;
var
  i: integer;
  groupID:Integer;
  Flag:Boolean;
begin
  groupID:=0;
  flag:= False;
  try
      for i := 0 to Planner1.Items.Count - 1 do
        if (Planner1.Items.Items[i].Selected) then
          if Sametext(TRosterItemProperties(Planner1.Items.Items[i].ItemObject).typename ,TYPE_Appointment ) then begin
            groupID:=TRosterItemProperties(Planner1.Items.Items[i].ItemObject).GroupID ;
            if TRosterItemProperties(Planner1.Items.Items[i].ItemObject).ID <> TRosterItemProperties(Planner1.Items.Items[i].ItemObject).GroupID then begin
              Planner1.Items.Items[i].Selected := False;
            end else begin
              flag := TRue;
              Planner1.Items.Items[i].Color :=CL_Select;
              Planner1.Items.Items[i].ColorTo :=CL_Select;
              Planner1.Items.Items[i].Focus:= true;
            end;
        end;
      if not (flag ) and (groupID <>0) then
        for i := 0 to Planner1.Items.Count - 1 do
          if TRosterItemProperties(Planner1.Items.Items[i].ItemObject).ID = TRosterItemProperties(Planner1.Items.Items[i].ItemObject).GroupID then
            if TRosterItemProperties(Planner1.Items.Items[i].ItemObject).GroupID  = groupId then begin
              Planner1.Items.Items[i].Selected := true;
              Planner1.Items.Items[i].Color :=CL_Select;
              Planner1.Items.Items[i].ColorTo :=CL_Select;
              Planner1.Items.Items[i].Focus:= true;
              Flag := True;
              exit;
            end;
  finally
    if Flag then begin
      TimerMsg('All appointments of the group will be rescheduled');
    end;
    Planner1.Update;
  end;
end;*)

function TfmProjectInstallation.SelectmainApt(fiCurgroupID: Integer): boolean;
begin
  REsult := False;
  if fiCurgroupID =0 then exit;
  CurgroupID := fiCurgroupID;
  Flag := False;
  try
    IterateOnAllItems(Planner1, SelectmainAptCallback, true, False);
    REsult := Flag;
  finally
    Flag:= False;
    CurgroupID :=0;
  end;
end;
procedure TfmProjectInstallation.SelectmainAptCallback(Item: TPlannerItem);
begin
  if Sametext(TRosterItemProperties(Item.ItemObject).typename,TYPE_Appointment) then
    if TRosterItemProperties(Item.ItemObject).Id = CurgroupID then begin
      Item.selected := True;
      Item.Color :=CL_Select;
      Item.ColorTo :=CL_Select;
      Flag:=true;
    end else begin
      Item.selected := False;
    end;
end;
procedure TfmProjectInstallation.setBaseDate(const Value: TdateTime);
begin
  fdBaseDate := Value;
  DoDateChange;
end;

procedure TfmProjectInstallation.Planner1ItemSelect(Sender: TObject;Item: TPlannerItem);
begin
  inherited;
  hidetimermsg;
  if (Assigned(Owner)) and (owner is TfmProjectInstallationRoster) then begin
    if not TfmProjectInstallationRoster(Owner).ISOKToSelect(Item) then begin
        item.Selected := False;
    end else begin
        TfmProjectInstallationRoster(Owner).ItemSelected(Self,Item , true);
        Item.Color :=CL_Select;
        Item.ColorTo :=CL_Select;
    end;
  end;

  (*if not ISOKToSelect(Item)  then begin
    item.Selected := False;
  end else begin
    //SelectAllAptinGroup(Item);
    Item.Color :=CL_Select;
    Item.ColorTo :=CL_Select;
  end;*)
  //item.update;
  Planner1.Update;
end;

procedure TfmProjectInstallation.Planner1ItemUnSelect(Sender: TObject;  Item: TPlannerItem);
begin
  inherited;
      TfmProjectInstallationRoster(Owner).ItemSelected(Self,Item , False);
      if assigned(Item.ItemObject) then begin
            if TRosterItemProperties(Item.ItemObject).typename  = TYPE_Appointment then begin
                if TRosterItemProperties(Item.ItemObject).GroupID <> 0 then
                    Item.Color := CL_GRPAppointment (*+  TColor(TRosterItemProperties(Item.ItemObject).GroupID)*)
                else Item.Color := CL_Appointment;
            end else if TRosterItemProperties(Item.ItemObject).typename  = TYPE_Leave then begin
              Item.Color := CL_Leave;
            end else if TRosterItemProperties(Item.ItemObject).typename  = TYPE_Holiday then begin
              Item.Color := CL_Holiday;
            end;
      end;
      Item.ColorTo :=Item.Color;
end;

procedure TfmProjectInstallation.Planner1Resize(Sender: TObject);
begin
  inherited;
  pnlResize.Top := 0;
  pnlResize.Left := pnlResize.Parent.Width-pnlResize.Width;
  pnlRowHeight.Top := 0;
  pnlRowHeight.Left := pnlResize.Left - pnlRowHeight.Width-2;

end;

procedure TfmProjectInstallation.pnlMainResize(Sender: TObject);
begin
  inherited;
  if not fbformshown then exit;
  edtHeight.Text := inttostr(pnlmain.height);
  ResetHeights(0 , Heightvalue);
end;

procedure TfmProjectInstallation.qryWeekRosterAfterOpen(DataSet: TDataSet);
begin
  inherited;
  WeekSource.active:= True;
end;

procedure TfmProjectInstallation.qryWeekRosterBeforeOpen(DataSet: TDataSet);
begin
  inherited;

    WeekSource.active := False;
    qryWeekRoster.SQL.Clear;
    qryWeekRoster.SQL.Add('Select distinct ');
    qryWeekRoster.SQL.Add('Convert(A.AppointID,SIGNED)  as ID,');
    qryWeekRoster.SQL.Add('A.GlobalRef ,');
    qryWeekRoster.SQL.Add('Convert(A.TrainerID,SIGNED)  as TrainerID,');
    qryWeekRoster.SQL.Add('A.AppDate as Date,');
    qryWeekRoster.SQL.Add('A.Starttime as StartTime,');
    qryWeekRoster.SQL.Add('A.EndTime   as Endtime,');
    qryWeekRoster.SQL.Add('E.employeename,');
    qryWeekRoster.SQL.Add('C.Company as ClientName,');
    qryWeekRoster.SQL.Add('Convert(A.ClassID,SIGNED)  as ClassID,');
    qryWeekRoster.SQL.Add('if(ifnull(C.ClientCode,"")="" , SUBSTR(C.company ,1,3), ClientCode) as ClientCode,');
    qryWeekRoster.SQL.Add('convert(ifnull(A.Notes , A.ClientName),char) as Notes,');
    qryWeekRoster.SQL.Add('A.HrstoInvoice hours,');
    qryWeekRoster.SQL.Add(quotedstr(TYPE_Appointment) +' as Type,');
    qryWeekRoster.SQL.Add('if(ifnull(A.LinkAppointID,0)=0 , if(ifnull(LA.AppointID,0)<>0 , A.AppointID , 0) , A.LinkAppointID) as groupID');
    qryWeekRoster.SQL.Add('FROM tblappointments A');
    qryWeekRoster.SQL.Add('Left join tblappointments LA on A.AppointID = LA.LinkAppointID');
    qryWeekRoster.SQL.Add('INNER JOIN tblEmployees E on A.TrainerID = E.employeeId');
    qryWeekRoster.SQL.Add('inner join tblclients C on C.clientId = A.CusId');
    qryWeekRoster.SQL.Add('WHERE A.Active ="T" and A.Cancellation ="F" and  E.onPMRoster = "T" and  A.Active="T"');
    qryWeekRoster.SQL.Add('and (A.ClassID =' + inttostr(ClassID)+' or ' + Quotedstr(BooleantoStr(AllClasses)) + ' ="T")');
    qryWeekRoster.SQL.Add('and  A.AppDate between '+Quotedstr(FormatDateTime(MysqlDateFormat , DateFrom)) +' and  '+Quotedstr(FormatDateTime(MysqlDateFormat , DateTo)) +'');

    qryWeekRoster.SQL.Add('union all');
    qryWeekRoster.SQL.Add('select');
    qryWeekRoster.SQL.Add('Convert(ER.ID,SIGNED)  as ID,');
    qryWeekRoster.SQL.Add('ER.GlobalRef,');
    qryWeekRoster.SQL.Add('Convert(ER.EmployeeId ,SIGNED)  as TrainerID,');
    qryWeekRoster.SQL.Add('ER.LeaveDate as Date,');
    qryWeekRoster.SQL.Add('ER.Starttime ,');
    qryWeekRoster.SQL.Add('ER.endtime,');
    qryWeekRoster.SQL.Add('E.employeename,');
    qryWeekRoster.SQL.Add('Null as ClientName,');
    qryWeekRoster.SQL.Add('Convert(E.DefaultClassID ,SIGNED)  as ClassID,');
    qryWeekRoster.SQL.Add('"" ClientCode,');
    qryWeekRoster.SQL.Add('"" Notes,');
    qryWeekRoster.SQL.Add('Hours,');
    qryWeekRoster.SQL.Add(Quotedstr(TYPE_Leave)+' as type,');
    qryWeekRoster.SQL.Add('0 as groupID');
    qryWeekRoster.SQL.Add('from tblemployeeleaverequests ER inner join tblemployees E on ER.employeeId = E.employeeID');
    qryWeekRoster.SQL.Add('where ER.Active ="T" and   ER.Starttime >= '+Quotedstr(FormatDateTime(MysqlDateFormat , DateFrom)) +' and  ER.endtime <= '+Quotedstr(FormatDateTime(MysqlDateFormat , DateTo)) +'');


    if fqryEmployees.Active then begin
      fqryEmployees.First;
      While fqryEmployees.Eof = False do begin
          qryWeekRoster.SQL.Add('union all');
          qryWeekRoster.SQL.Add('select');
          //qryWeekRoster.SQL.Add('ID +' +inttostr(fqryEmployees.fieldbyname('employeeId').AsInteger) + ' as ID,');
          qryWeekRoster.SQL.Add('Convert(truncate(RAND()*1000,0),SIGNED) as ID,'); // need a unique ID for the planner to work
          qryWeekRoster.SQL.Add('GlobalRef ,');
          qryWeekRoster.SQL.Add('Convert('+inttostr(fqryEmployees.fieldbyname('employeeId').AsInteger) + '  ,SIGNED)  as TrainerID,');
          qryWeekRoster.SQL.Add('Day  as Date ,');
          qryWeekRoster.SQL.Add('Date_add(Date(Day) , INTERVAL  TIME_TO_SEC(' +Quotedstr(FormatDateTime(MysqlTimeFormat , Appenv.CompanyPrefs.StartOfDay)) +')  second) as StartTime,');
          qryWeekRoster.SQL.Add('Date_add(Date(Day) , INTERVAL  TIME_TO_SEC(' +Quotedstr(FormatDateTime(MysqlTimeFormat , Appenv.CompanyPrefs.EndOfDay)) +')  second) as EndTime,');
          qryWeekRoster.SQL.Add('Null as employeename,');
          qryWeekRoster.SQL.Add('Null as ClientName,');
          qryWeekRoster.SQL.Add('Convert(0,SIGNED)  as ClassID,');
          qryWeekRoster.SQL.Add('null ClientCode,');
          qryWeekRoster.SQL.Add('convert(Description,char) as Notes,');
          qryWeekRoster.SQL.Add('7.6 as  hours ,');
          qryWeekRoster.SQL.Add(Quotedstr(TYPE_Holiday) +' as Type,');
          qryWeekRoster.SQL.Add('0 as groupID');
          qryWeekRoster.SQL.Add('from tblpublicholidays');
          qryWeekRoster.SQL.Add('Where Day between '+Quotedstr(FormatDateTime(MysqlDateFormat , DateFrom)) +' and  '+Quotedstr(FormatDateTime(MysqlDateFormat , DateTo)) +'');
          fqryEmployees.Next;
      end;
    end;

    qryWeekRoster.SQL.Add('Order by Date');
    if assigned(TransConnection) and  TransConnection.Connected then qryWeekRoster.connection := TransConnection;
    clog(qryWeekRoster.SQL.text);

end;

procedure TfmProjectInstallation.RefreshQuery;
begin
  ProcessingCursor(true);
  try
      Closedb(qryWeekRoster);
      OpenDB(qryWeekRoster);
      if devmode then
        TimerMsg( 'Date Range :' + Quotedstr(formatdateTime(FormatSettings.ShortDateFormat , dateFrom)) + ' and ' + Quotedstr(formatdateTime(FormatSettings.ShortDateFormat , dateto)) );
      Planner1.PositionWidth := RowHeight;
      Planner1.update;
  finally
    ProcessingCursor(False);
  end;
end;
(*procedure TfmProjectInstallation.ResceduleItem(Item: TPlannerItem);
begin
  if TRosterItemProperties(Item.ItemObject).TypeName = TYPE_Appointment then begin
    ReScheduleAppt(Item);
  end else if TRosterItemProperties(Item.ItemObject).TypeName = TYPE_Leave then begin
    RescheduleLeave(Item);
  end;
end;*)

procedure TfmProjectInstallation.ReScheduleAppt(Item: TPlannerItem);
var
  Appt:TAppointment;
begin
  if (iDaysToreschedule =0) and (iEmprescheduleTo = TRosterItemProperties(Item.ItemObject).TrainerId) then exit;

  IncnShowItemNoProcessed(TRosterItemProperties(Item.ItemObject).TypeName);
  Appt := TAppointment.CreateWithNewConn(Self);
  try
    Appt.UserLock := UserLock;
    Appt.Connection.Connection := TransConnection;
    Appt.Load(TRosterItemProperties(Item.ItemObject).ID);
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
      if iEmprescheduleTo <> 0 then
        Appt.trainerId := iEmprescheduleTo;
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

procedure TfmProjectInstallation.RescheduleLeave(Item: TPlannerItem);
var
  EmpLeaveRequests :TEmpLeaveRequests;
begin
  IncnShowItemNoProcessed(TRosterItemProperties(Item.ItemObject).TypeName);
  EmpLeaveRequests := TEmpLeaveRequests.CreateWithNewConn(Self);
  try
    EmpLeaveRequests.Connection.Connection := TransConnection;
    EmpLeaveRequests.Load(TRosterItemProperties(Item.ItemObject).ID);
    if EmpLeaveRequests.count =0 then begin
      MessageDlgXP_Vista('Leave cannot be located.' , mtWarning, [mbOK], 0);
      exit;
    end;
    if not(EmpLeaveRequests.Lock) then begin
      MessageDlgXP_Vista(ReplaceStr(EmpLeaveRequests.UserLock.LockMessage  , 'Unable to update data.' ,'Leave #' + inttostr(EmpLeaveRequests.ID)+' cannot be rescheduled.') , mtWarning, [mbOK], 0);
      exit;
    end;
    EmpLeaveRequests.LoadSelect('employeeId = ' + inttostr(EmpLeaveRequests.employeeID) +' and LeaveDate =' + quotedstr(formatdateTime(MysqlDateFormat ,incday(EmpLeaveRequests.LeaveDate , iDaysToreschedule))));
    if EmpLeaveRequests.count >0 then begin
      MessageDlgXP_Vista(EmpLeaveRequests.EmployeeName +' is already on leave on the proposed date :' +  quotedstr(formatdateTime(FormatSettings.ShortDateFormat ,incday(EmpLeaveRequests.LeaveDate , iDaysToreschedule))) , mtWarning, [mbOK], 0);
      exit;
    end;
    EmpLeaveRequests.Load(TRosterItemProperties(Item.ItemObject).ID);
    EmpLeaveRequests.LeaveDate :=incday(EmpLeaveRequests.LeaveDate , iDaysToreschedule);
    EmpLeaveRequests.Save;
    TimerMsg( 'Leave #' + inttostr(EmpLeaveRequests.ID)+' is Rescheduled.');
    //RefreshQuery;
    IsDirty := True;
  finally
    FreeandNil(EmpLeaveRequests);
  end;
end;

class function TfmProjectInstallation.ProjectInstallationInst(AOwner:Tform; iMonthNo:Integer;IsfirstIsntance:Boolean): TfmProjectInstallation;
begin
  REsult := TfmProjectInstallation.Create(AOwner);
  if Aowner is TfmProjectInstallationRoster then begin
    Result.TransConnection := TfmProjectInstallationRoster(Aowner).MyConnection;
    Result.pnlMain.Parent := TfmProjectInstallationRoster(Aowner).Scrollbox;
    Result.qryEmployees :=TfmProjectInstallationRoster(Aowner).qryEmployees;
    Result.ClassID :=TfmProjectInstallationRoster(Aowner).qryClassesClassID.AsInteger;
    Result.AllClasses :=TfmProjectInstallationRoster(Aowner).chkclasses.Checked;
    Result.pnlMain.Align := altop;
    //Result.pnlMain.Top := itop;
    //itop := itop + Result.pnlMain.height;
    Result.Monthno := iMonthno;
    Result.Planner1.Caption.title := 'Planner ' + inttostr(iMonthno);
    Result.Planner1.Caption.Background := clNavy;
    Result.initform;
    //Result.edtHeight.maxvalue := TfmProjectInstallationRoster(aOwner).Scrollbox.Height;
  end;
end;

function TfmProjectInstallation.NewItemProperty:(*TRosterItemProperties*)TObject;
begin
  REsult := TObject(TRosterItemProperties.Create);
end;
procedure TfmProjectInstallation.SourceFieldsToItem(Sender: TObject; Fields: TFields;   Item: TPlannerItem);
var
  ItemProperties:TRosterItemProperties;
function Appthint:String;
begin
  REsult := Fields.FieldByName('ClientName').ASString;
  if ItemProperties.TypeName = TYPE_Appointment then begin
    result := result + NL + formatdateTime(FormatSettings.ShortDateFormat +' hh:nn AM/PM', Fields.fieldbyname('starttime').asDateTime);
    result := result + ' to ' ;
    if dateof(fields.fieldbyname('endtime').asdatetime) = dateof(fields.fieldbyname('starttime').asdatetime) then
         result := result +formatdateTime('hh:nn AM/PM'                  , Fields.fieldbyname('endtime').asDateTime)
    else result := result +formatdateTime(FormatSettings.ShortDateFormat +' hh:nn AM/PM', Fields.fieldbyname('endtime').asDateTime);
    result := result + NL+ Fields.fieldbyname('employeename').asString;
    if not sametext(Fields.FieldByName('ClientName').ASString, Fields.FieldByName('Notes').ASString) then REsult := result + NL+ Fields.FieldByName('Notes').ASString;
    result := result + NL;
  end;
end;
begin
  inherited;

(*
  Item.CaptionBkg:= clgreen;
  Item.CaptionBkgTo := clblack;
  Item.SelectColor := clyellow;
  Item.SelectColorTo := clpurple;
  Item.TrackColor := clMaroon;
  Item.TrackLinkColor := clGray;
  Item.TrackSelectColor := clLime;*)
  Item.TrackVisible := False;
  Item.BorderColor := clwhite;

  ItemProperties := TRosterItemProperties(NewItemProperty);

  ItemProperties.ID         := Fields.FieldByName('ID').AsInteger;
  ItemProperties.GroupID    := Fields.FieldByName('GroupID').AsInteger;
  ItemProperties.ClassId    := Fields.FieldByName('ClassID').AsInteger;
  ItemProperties.TrainerId  := Fields.FieldByName('TrainerId').AsInteger;
  ItemProperties.Date       := Fields.FieldByName('Date').AsDateTime;
  ItemProperties.ClientCode := Fields.FieldByName('ClientCode').ASString;
  ItemProperties.Notes      := Fields.FieldByName('Notes').ASString;
  ItemProperties.employeename := Fields.FieldByName('employeename').ASString;
  ItemProperties.ClientName := Fields.FieldByName('ClientName').ASString;
  ItemProperties.Hours      := Fields.FieldByName('Hours').asFloat;
  ItemProperties.TypeName   := Fields.FieldByName('Type').AsString;
  ItemProperties.GloGalRef  := Fields.FieldByName('Globalref').AsString;



  Item.ItemObject := ItemProperties;
  Item.Shape := psRect;

  //Item.Background := true;
  Item.Font.Size := 10;
  if Trim(Fields.FieldByName('Type').AsString) = TYPE_Appointment then begin
    //Item.CaptionText := ItemProperties.ClientCode;
    Item.Text.Text:= ItemProperties.ClientCode;
    item.Hint := Appthint; // ItemProperties.notes ;

    if ItemProperties.GroupID <> 0 then
        Item.Color := CL_GRPAppointment
    else Item.Color := CL_Appointment;

  end else if Trim(Fields.FieldByName('Type').AsString) = TYPE_Leave then begin
    Item.Text.Text:= 'X';
    item.Hint := 'Not Available';
    Item.Color := CL_Leave;
    item.FixedPosition := True; // can move to a diff date but not to another employee
  end else if Trim(Fields.FieldByName('Type').AsString) = TYPE_Holiday then begin
    Item.Color := CL_Holiday;
    Item.Text.Text := 'PH';
    item.Hint := 'Public Holiday : ' + ItemProperties.notes;
    item.FixedPos:= True; // can't move at all
(*  end else if Trim(Fields.FieldByName('Type').AsString) = TYPE_Weekend then begin
    Item.Color := Planner1.Display.colorNonActive; //CL_Weekend;
    item.Hint := 'Weekend';
    item.FixedPos:= True;// can't move at all*)
  end;
  Item.Colorto := Item.color;
  Item.Alignment := taCenter;
  Item.CaptionAlign := taCenter;
  Item.FixedPos := (AccessLevel <> 1) and ( Trim(Fields.FieldByName('Type').AsString) <> TYPE_Holiday) (*and (Trim(Fields.FieldByName('Type').AsString) <> TYPE_Weekend )*);
  Item.Id := ItemProperties.ID;
end;

procedure TfmProjectInstallation.SourceItemTofields(Sender: TObject; Fields: TFields;   Item: TPlannerItem);
begin
  // to be done
end;
procedure TfmProjectInstallation.SpnbtnHeightDownClick(Sender: TObject);
begin
  inherited;
    if not fbformshown then exit;
    edtHeight.Text := inttostr(Heightvalue-1);
    ResetHeights(0 , Heightvalue);
end;

procedure TfmProjectInstallation.SpnbtnHeightUpClick(Sender: TObject);
begin
  inherited;
    if not fbformshown then exit;
    edtHeight.Text := inttostr(Heightvalue+1);
    ResetHeights(0 , Heightvalue);
end;

procedure TfmProjectInstallation.spnbtnRowHeightDownClick(Sender: TObject);
begin
  inherited;
  if not fbformshown then exit;
  edtRowHeight.Text := inttostr(RowHeightvalue -1);
  ResetHeights(RowHeightvalue , 0);
end;

procedure TfmProjectInstallation.spnbtnRowHeightUpClick(Sender: TObject);
begin
  inherited;
  if not fbformshown then exit;
  edtRowHeight.Text := inttostr(RowHeightvalue +1);
  ResetHeights(RowHeightvalue , 0);
end;

procedure TfmProjectInstallation.TimerMsg(const Value: String);
begin
  if Assigned(Owner) then
    if owner is TfmProjectInstallationRoster then
      TfmProjectInstallationRoster(Owner).TimerMsg(Value);
end;

procedure TfmProjectInstallation.UnselectAll1Click(Sender: TObject);
begin
  inherited;
  if (Assigned(Owner)) and (owner is TfmProjectInstallationRoster) then begin
    TfmProjectInstallationRoster(Owner).unSelectall;
  end;
end;

procedure TfmProjectInstallation.UpdateHeaders(Const planner: TDBPlanner);
begin
  planner.Header.Height := 100;
  planner.Header.TextHeight := 100;
  planner.Header.Color := $00FFDDC6;
  planner.Header.Captions.Clear;
  planner.Header.Captions.Add('');
  planner.ItemGap := 0;

  with fqryEmployees do begin
    First;
    while not Eof do begin
      planner.Header.Captions.Add(FieldByName('EmployeeName').AsString);
      Next;
    end;
  end;
  planner.Header.AllowResize := True;
  planner.Header.AutoSize := True;

  planner.InactiveDays.Mon := (Appenv.REgionalOptions.WeekEndDay1 = 1) or (Appenv.REgionalOptions.WeekEndDay2 = 1);
  planner.InactiveDays.Tue := (Appenv.REgionalOptions.WeekEndDay1 = 2) or (Appenv.REgionalOptions.WeekEndDay2 = 2);
  planner.InactiveDays.Wed := (Appenv.REgionalOptions.WeekEndDay1 = 3) or (Appenv.REgionalOptions.WeekEndDay2 = 3);
  planner.InactiveDays.Thu := (Appenv.REgionalOptions.WeekEndDay1 = 4) or (Appenv.REgionalOptions.WeekEndDay2 = 4);
  planner.InactiveDays.Fri := (Appenv.REgionalOptions.WeekEndDay1 = 5) or (Appenv.REgionalOptions.WeekEndDay2 = 5);
  planner.InactiveDays.Sat := (Appenv.REgionalOptions.WeekEndDay1 = 6) or (Appenv.REgionalOptions.WeekEndDay2 = 6);
  planner.InactiveDays.Sun := (Appenv.REgionalOptions.WeekEndDay1 = 7) or (Appenv.REgionalOptions.WeekEndDay2 = 7);

end;


procedure TfmProjectInstallation.ValidateSelectionToDelete;
begin
  IterateOnSelectedItems(Planner1,ValidateSelectionToDeleteCallback);
end;
(*procedure TfmProjectInstallation.ValidateSelectionToReschedule;
begin
  IterateOnSelectedItems(Planner1,ValidateSelectionToRescheduleCallback);
end;*)
(*procedure TfmProjectInstallation.ValidateSelectionToRescheduleCallback(Item: TPlannerItem);
begin
  if TRosterItemProperties(Item.ItemObject).TypeName <> TYPE_Appointment then begin
    TimerMsg( 'Only Appointment can be resceduled - unselecting them');
    item.Selected := False;
    //item.update;
  end;
end;*)
procedure TfmProjectInstallation.ValidateSelectionToDeleteCallback(Item: TPlannerItem);
begin
  if TRosterItemProperties(Item.ItemObject).TypeName = TYPE_Holiday then begin
    TimerMsg( 'It is not possible to Delete/Reschedule Public holidays - unselecting them');
    item.Selected := False;
    //item.update;
  end;
end;

(*procedure TfmProjectInstallations.ValidateSelectionToMove;
begin
  IterateOnSelectedItems(Planner1,ValidateSelectionToMoveCallback);
end;*)

(*procedure TfmProjectInstallations.ValidateSelectionToMoveCallback(Item: TPlannerItem);
begin
  if TRosterItemProperties(Item.ItemObject).TypeName = TYPE_Holiday then begin
    TimerMsg( 'It is not possible to Delete/Reschedule Public holidays - unselecting them');
    item.Selected := False;
    //item.update;
  end;
end;*)

procedure TfmProjectInstallation.WeekSourceResourceToPosition(Sender: TObject;
  Field: TField; var Position: Integer; var Accept: Boolean);
begin
  inherited;
  Position := GetPositionFromEmployee(Field.asInteger);
  Accept := position >=0;
end;

Function TfmProjectInstallation.InitPlanners:Boolean ;
begin
  Result := True;
  WeekSource.NumberOfResources := fqryEmployees.RecordCount;
  Planner1.MultiSelect := true;
  Planner1.Display.DisplayEnd := DAYS_IN_PLANNER;
  Planner1.Display.ShowCurrent := true;
  UpdateHeaders(Planner1);
  Planner1.GridPopup := PopGrid;
  Planner1.ItemPopup := popItem;
end;
procedure TfmProjectInstallation.MnuDeleteClick(Sender: TObject);
begin
  inherited;
  ValidateSelectionToDelete;
  itemsSelected := PlannerItemsSelected(Planner1);
  if itemsSelected =0 then begin
    MessageDlgXP_Vista('Please select the item(s) to be Deleted', mtWarning, [mbOK], 0);
    exit;
  end;
  itemno:= 0;
  IterateOnSelectedItems(Planner1,DeleteItem);
  RefreshQuery;
  itemno:= 0;
  itemsSelected:=0;
  hideTimerMsg;
end;
(*procedure TfmProjectInstallation.btnIncHeightClick(Sender: TObject);
begin
  inherited;
  pnlMain.Height := pnlMain.Height +1;
end;

procedure TfmProjectInstallation.btnDecHeightClick(Sender: TObject);
begin
  inherited;
  pnlMain.Height := pnlMain.Height -1;
end;*)

function TfmProjectInstallation.DateFrom: TDateTime;
begin
  result := incday(Dateof(StartOfTheMonth(StartDate)),-7);
end;

function TfmProjectInstallation.DAteTo: TDateTime;
begin
  result :=  incSecond(incday(DateFrom , DAYS_IN_PLANNER +1), -1);
end;

Procedure TfmProjectInstallation.DeleteAppt(Item: TPlannerItem);
var
  Appt:TAppointment;
begin
  IncnShowItemNoProcessed(TRosterItemProperties(Item.ItemObject).TypeName);
  Appt := TAppointment.CreateWithNewConn(Self);
  try
    Appt.UserLock := UserLock;
    Appt.Connection.Connection := TransConnection;
    Appt.Load(TRosterItemProperties(Item.ItemObject).ID);
    if Appt.count =0 then begin
      MessageDlgXP_Vista('Appointment cannot be located.' , mtWarning, [mbOK], 0);
      exit;
    end;
    if not(Appt.Lock) then begin
      MessageDlgXP_Vista(ReplaceStr(Appt.UserLock.LockMessage  , 'Unable to update data.' ,'Appointemnt #' + inttostr(Appt.ID)+' cannot be deleted.') , mtWarning, [mbOK], 0);
      exit;
    end;
    Appt.Active := false;
    Appt.Save;
    TimerMsg('Appointemnt #' + inttostr(Appt.ID)+' is deleted.');
    //RefreshQuery;
    IsDirty := True;
  finally
    FreeandNil(Appt);
  end;
end;
Procedure TfmProjectInstallation.DeleteLeave(Item: TPlannerItem);
var
  EmpLeaveRequests :TEmpLeaveRequests;
begin
  IncnShowItemNoProcessed(TRosterItemProperties(Item.ItemObject).TypeName);
  EmpLeaveRequests := TEmpLeaveRequests.CreateWithNewConn(Self);
  try
    EmpLeaveRequests.Connection.Connection := TransConnection;
    EmpLeaveRequests.Load(TRosterItemProperties(Item.ItemObject).ID);
    if EmpLeaveRequests.count =0 then begin
      MessageDlgXP_Vista('Leave cannot be located.' , mtWarning, [mbOK], 0);
      exit;
    end;
    if not(EmpLeaveRequests.Lock) then begin
      MessageDlgXP_Vista(ReplaceStr(EmpLeaveRequests.UserLock.LockMessage  , 'Unable to update data.' ,'Leave #' + inttostr(EmpLeaveRequests.ID)+' cannot be deleted.') , mtWarning, [mbOK], 0);
      exit;
    end;
    EmpLeaveRequests.Active := false;
    EmpLeaveRequests.Save;
    TimerMsg( 'Leave #' + inttostr(EmpLeaveRequests.ID)+' is deleted.');
    //RefreshQuery;
    IsDirty := True;
  finally
    FreeandNil(EmpLeaveRequests);
  end;
end;
(*procedure TfmProjectInstallation.btnDecRowHeightClick(Sender: TObject);
begin
  inherited;
  if Planner1.PositionWidth <=30 then exit;
  Planner1.PositionWidth := Planner1.PositionWidth -1;
  RowHeight := RowHeight -1;
end;

procedure TfmProjectInstallation.btnIncRowHeightClick(Sender: TObject);
begin
  inherited;
  Planner1.PositionWidth := Planner1.PositionWidth +1;
  RowHeight := RowHeight +1;
end;*)

procedure TfmProjectInstallation.doDatechange;
begin
  StartDate := incmonth(fdbasedate , fiMonthno-1);
  Planner1.Caption.Title := FormatDatetime('mmmm yyyy' , StartDate);
  WeekSource.Month := MonthOfTheYear(StartDate);
  WeekSource.Year := YearOf(StartDate);
  WeekSource.UpdatePlanner;
  Planner1.Display.DisplayEnd := DAYS_IN_PLANNER;
end;

procedure TfmProjectInstallation.edtHeightKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if CharInSet(key, ['0','1','2','3','4','5','6','7','8','9']) then else Key := chr(0);
end;

procedure TfmProjectInstallation.edtRowHeightKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if CharInSet(key,['0','1','2','3','4','5','6','7','8','9']) then else Key := chr(0);
end;

procedure TfmProjectInstallation.OnHeightChange(Sender: TObject);
begin
  inherited;
  if not fbformshown then exit;
  ResetHeights(0 , Heightvalue);
end;
Function TfmProjectInstallation.RowHeightvalue:Integer;
begin
  REsult := RowHeight;
  try
    result := strtoInt(edtRowHeight.text);
  Except
  end;

end;
Function TfmProjectInstallation.Heightvalue:Integer;
begin
  REsult := Pnlmain.height;
  try
    result := strtoInt(edtHeight.text);
  Except
  end;
end;
Procedure TfmProjectInstallation.ResetHeights(const fRowHeight:Integer; const fPanelHeight:Integer);
begin
  if fPanelHeight <>0 then if Heightvalue    <> fPanelHeight  then edtHeight.text    := inttostr(fPanelHeight);
  if Heightvalue <100 then begin  edtHeight.Text := '100'; TimerMsg( 'Minimum height 100'); end;
  if Heightvalue > pnlmain.parent.height then begin  edtHeight.Text := inttostr(pnlmain.parent.height); TimerMsg( 'Maximum height ' + inttostr(pnlmain.parent.height)); end;
  pnlMain.Height := HeightValue;
  if fRowHeight   <>0 then if RowHeightvalue <> fRowHeight    then edtRowHeight.text := inttostr(fRowHeight);
  if RowHeightvalue <20 then begin edtRowHeight.text := '20';TimerMsg( 'Minimum Row Height 20');end;
  if RowHeightvalue >Heightvalue then begin edtRowHeight.text := inttostr(Heightvalue); TimerMsg( 'Maximum Row Height '+ inttostr(Heightvalue)); end;
  Planner1.PositionWidth := RowHeightValue;
  RowHeight := RowHeightValue;
end;
procedure TfmProjectInstallation.OnRowHeightChange(Sender: TObject);
begin
  inherited;
  if not fbformshown then exit;
  ResetHeights(RowHeightvalue , 0);
end;

Procedure TfmProjectInstallation.DeleteItem(Item: TPlannerItem);

begin
  inherited;
      if assigned(Item.ItemObject) then begin
        if TRosterItemProperties(Item.ItemObject).ID <> 0 then begin
            if TRosterItemProperties(Item.ItemObject).typename  = TYPE_Appointment then begin
              DeleteAppt(Item);
            end else if TRosterItemProperties(Item.ItemObject).typename  = TYPE_Leave then begin
              DeleteLeave(Item);
            end else if TRosterItemProperties(Item.ItemObject).typename  = TYPE_Holiday then begin
              MessageDlgXP_Vista('Public Holidays cannot be dleted from here. Please delete it from the List(Mainmenu -> General -> Public Holiday)' , mtWarning, [mbOK], 0);
            end;
        end;
      end;
end;

Procedure TfmProjectInstallation.OpenItem(Item: TPlannerItem);
begin
      if assigned(Item.ItemObject) then begin
        if TRosterItemProperties(Item.ItemObject).ID <> 0 then begin
            if TRosterItemProperties(Item.ItemObject).typename  = TYPE_Appointment then begin
              openAppt(Item);
            end else if TRosterItemProperties(Item.ItemObject).typename  = TYPE_Leave then begin
              openLeave(Item);
            end else if TRosterItemProperties(Item.ItemObject).typename  = TYPE_Holiday then begin
              OpenHoliday(Item);
            end;
        end;
      end;
end;



Function TfmProjectInstallation.EmployeeID(planner: TDBPlanner;Item: TPlannerItem):Integer;begin  result := GetEmployeeID(planner.Header.Captions.Strings[Item.ItemPos + 1]);end;
procedure TfmProjectInstallation.MakeLeaveRequest(Item: TPlannerItem);
var
  EmpLeaveRequests :TEmpLeaveRequests;
begin

  if (CreateIfWorkingDay) and (not(isworkingday(Dateof(item.ItemStartTime)))) then Exit;

  EmpLeaveRequests := TEmpLeaveRequests.CreateWithNewConn(Self);
  try
    EmpLeaveRequests.Connection.Connection := TransConnection;
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
end;
procedure TfmProjectInstallation.Move1Click(Sender: TObject);
begin
  itemsSelected := PlannerItemsSelected(Planner1);
  if itemsSelected =0 then begin
    MessageDlgXP_Vista('Please select the item(s) to be Moved', mtWarning, [mbOK], 0);
    exit;
  end;
  FirstSelectedItem := GetFirstItemSelected(Planner1);
  if Assigned(FirstSelectedItem) and (sametext(TRosterItemProperties(FirstSelectedItem.ItemObject).Typename, TYPE_Appointment)) then begin
    if (Assigned(Owner)) and (owner is TfmProjectInstallationRoster) then begin
      TfmProjectInstallationRoster(Owner).RescheduleAppointment(FirstSelectedItem);
    end;
  end;


(*var
  dt1, dt2 : TDatetime;
begin
  inherited;
  ValidateSelectionToDelete;
  itemsSelected := PlannerItemsSelected(Planner1);
  if itemsSelected =0 then begin
    MessageDlgXP_Vista('Please select the item(s) to be Moved', mtWarning, [mbOK], 0);
    exit;
  end;
  itemno:= 0;
  SelectMainAppt; // only select the mail appoitment as the rest are all automatically rescheduled
  dt1:= PlannerFirstdateSelected(Planner1);
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
  end;

  itemno:= 0;
  itemsSelected:=0;
  hideTimerMsg;*)

end;

procedure TfmProjectInstallation.LeaveRequest1Click(Sender: TObject);
begin
  inherited;
(*  if (Assigned(Owner)) and (owner is TfmProjectInstallationRoster) then begin
    TfmProjectInstallationRoster(Owner).MakeLeaves;
  end;*)

  try
    CreateIfWorkingDay :=  MessageDlgXP_Vista('Do you wish to exclude the Holidays and Weekend Days?', mtConfirmation, [mbYes, mbNo], 0) = mrYes;
    IterateOnSelectedCells(Planner1 ,MakeLeaveRequest ,NewItemProperty);
    RefreshQuery;
  Except
    on E:Exception do begin
      MessageDlgXP_vista('e.message', mtWarning, [mbOK], 0);
    end;
  end;
end;
procedure TfmProjectInstallation.mnuListApptsClick(Sender: TObject);
begin
  inherited;
  FirstSelectedItem := GetFirstItemSelected(Planner1);
  if not(Assigned(FirstSelectedItem)) then  begin
    MessageDlgXP_Vista('Please select an item', mtWarning, [mbOK], 0);
    exit;
  end;
  OpenERPListForm('TAppointmentListGUI' , FilterAppointmentList);
  FirstSelectedItem := nil;
end;
Procedure TfmProjectInstallation.FilterAppointmentList(Sender:TObject);
begin
  if not(Sender is TAppointmentListGUI) then exit;
  TAppointmentListGUI(Sender).ListforAday(TRosterItemProperties(FirstSelectedItem.ItemObject).Date);
  TAppointmentListGUI(Sender).filterString := 'TrainerId =' + inttostr(TRosterItemProperties(FirstSelectedItem.ItemObject).TrainerID) ;
end;
function TfmProjectInstallation.GetEmployeeFromPosition(const Position: integer): integer;
begin
  fqryEmployees.first;
  fqryEmployees.MoveBy(position);
  REsult :=fqryEmployees.Fieldbyname('employeeID').AsInteger;
end;
function TfmProjectInstallation.GetPositionFromEmployee(const TrainerID: integer): integer;
begin
  result := -1;
  if not(fqryEmployees.active ) then exit;
  if fqryEmployees.Locate('EmployeeId', TrainerID, [loCaseInsensitive]) then begin
    Result := fqryEmployees.recno-1;
  end else begin
    Result := -1;
  end;
end;
(*function TfmProjectInstallations.GetEmployeeFromPosition(Const TrainerID: integer): integer;
begin
  if fqryEmployees.Locate('EmployeeId', TrainerID, [loCaseInsensitive]) then begin
    Result := fqryEmployees.FieldByName('EmployeeID').AsInteger;
  end else begin
    Result := 0;
  end;
end;*)
Procedure TfmProjectInstallation.ReadGuiprefs(fGuiPrefs: TFormGuiPrefs);
begin
  RowHeight:= 60;
  pnlMain.Height := 280;
  if fGuiPrefs.Active =False then fGuiPrefs.Active := True;
  if fGuiPrefs.Node.Exists('Options.RowHeight_'+trim(inttostr(monthno))) then RowHeight:= fGuiPrefs.Node['Options.RowHeight_'+trim(inttostr(monthno))].asInteger;
  if fGuiPrefs.Node.Exists('Options.FormHeight_'+trim(inttostr(monthno))) then pnlMain.Height:= fGuiPrefs.Node['Options.FormHeight_'+trim(inttostr(monthno))].asInteger;
  (*edtHeight.Value := pnlMain.Height ;
  edtRowHeight.Value :=  RowHeight;
  edtRowHeight.maxvalue :=pnlMain.Height ;*)
  edtRowheight.text := inttostr(RowHeight);
  edtHeight.text := inttostr(pnlMain.Height);
  ResetHeights( RowHeight , pnlMain.Height);
end;
Procedure TfmProjectInstallation.WriteGuiprefs(fGuiPrefs: TFormGuiPrefs);
begin
  fGuiPrefs.Node['Options.RowHeight_'+trim(inttostr(monthno))].asInteger := RowHeight;
  fGuiPrefs.Node['Options.FormHeight_'+trim(inttostr(monthno))].asInteger := pnlMain.Height;
end;
procedure TfmProjectInstallation.MnuOpenItemClick(Sender: TObject);
begin
  inherited;
  itemsSelected := PlannerItemsSelected(Planner1);
  if itemsSelected =0 then begin
    MessageDlgXP_Vista('Please select the item(s) to be Opened', mtWarning, [mbOK], 0);
    exit;
  end;
  itemno:= 0;
  IterateOnSelectedItems(Planner1,OpenItem);
  RefreshQuery;
  itemno:= 0;
  itemsSelected:=0;
  hideTimerMsg;
end;
procedure TfmProjectInstallation.openLeave(Item: TPlannerItem);
begin
  IncnShowItemNoProcessed(TRosterItemProperties(Item.ItemObject).TypeName);
  OpenERPFormModal('TfmEmployeeLeaveRequests' , TRosterItemProperties(Item.ItemObject).ID );
  Application.ProcessMessages;
end;
procedure TfmProjectInstallation.openAppt(Item: TPlannerItem);
begin
  IncnShowItemNoProcessed(TRosterItemProperties(Item.ItemObject).TypeName);
  OpenERPFormModal('TAppointmentGUI' , TRosterItemProperties(Item.ItemObject).ID );
  Application.ProcessMessages;
end;

procedure TfmProjectInstallation.OpenHoliday(Item: TPlannerItem);
begin
  IncnShowItemNoProcessed(TRosterItemProperties(Item.ItemObject).TypeName);
  OpenERPFormModal('TfrmPublicHolidaysGUI' , TRosterItemProperties(Item.ItemObject).ID );
  Application.ProcessMessages;
end;
procedure TfmProjectInstallation.SetConnectionString(const TransactionMode: boolean);
var
  iIndex: integer;
begin
    if Assigned(TransConnection) then begin
      for iIndex := 0 to Self.ComponentCount - 1 do begin
        if Self.Components[iIndex] is TCustomMyDataSet then
          with Self.Components[iIndex] as TCustomMyDataSet do begin
              Connection := TransConnection;
          end;
      end;
    end else begin
      inherited;
    end;
end;

procedure TfmProjectInstallation.SetMonthno(const Value: Integer);
begin
  fiMonthno := Value;
  DoDatechange;
end;

Procedure TfmProjectInstallation.SetPlannerEvents;
begin
  WeekSource.OnInsertItem:= OnInsertnUpdateDs;
  WeekSource.OnUpdateItem:= OnInsertnUpdateDs;
end;

procedure TfmProjectInstallation.OnInsertnUpdateDs(Sender: TObject; APlannerItem: TPlannerItem);
begin
  //Dont delete this as otherwise insert/change will try to update the dataset of the planner which is not editable
end;
procedure TfmProjectInstallation.IncnShowItemNoProcessed(const Itemtype:String);
begin
  itemno:= itemno+1;
  TimerMsg( Itemtype +' : ' +inttostr(itemno) +' of ' + inttostr(itemsSelected));
end;
Function TfmProjectInstallation.WeekEmployeeID(Item: TPlannerItem):Integer;begin  result := EmployeeID(Planner1,Item);end;



{ TRosterItemProperties }


initialization
// RegisterClassOnce(TfmProjectInstallations);

end.
