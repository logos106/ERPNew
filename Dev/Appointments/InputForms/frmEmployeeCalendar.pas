unit frmEmployeeCalendar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmCalendar, MyAccess, DB, DBPlanner, ProgressDialog, MemDS,
  DBAccess, ERPdbComponents, ImgList, Menus, AdvMenus, DataState,
  SelectionDialog, AppEvnts, ExtCtrls, StdCtrls, wwcheckbox, PlannerMonthView,
  DBPlannerMonthView, Mask, wwdbedit, Wwdbspin, Grids, AdvObj, BaseGrid,
  AdvGrid, Planner, ComCtrls, wwdblook, wwdbdatetimepicker, DNMSpeedButton,
  DBCtrls, DNMPanel, BusObjBase;

type
  TfmEmployeeCalendar = class(TCalendarGUI)
    pnlMsg: TDNMPanel;
    lblNote: TLabel;
    chkhideMsg: TCheckBox;
    Label2: TLabel;
    procedure DBPlanner1ItemDblClick(Sender: TObject; Item: TPlannerItem);
    procedure FormShow(Sender: TObject);
    procedure lblNoteDblClick(Sender: TObject);
    procedure chkhideMsgExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBPlannerMonthViewDblClick(Sender: TObject; SelDate: TDateTime);
    procedure DBPlanner1PlannerDblClick(Sender: TObject; Position, FromSel,
      FromSelPrecise, ToSel, ToSelPrecise: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Appointment:TBusobj;
    procedure beforshowPadRepairs(Sender: TObject);
    procedure copyEquipsToappointment(const Sender: TBusObj;
      var Abort: boolean);
    procedure MakeRepairnAppt(const selDate: TdateTime);
    procedure ReadnApplyGuiPrefExtra;
    Procedure WriteGuiPrefExtra;
  Protected
    procedure SetQueryDateRange;Override;
  public
  end;


implementation

uses AppEnvironment, CommonLib, CommonFormLib, frmPadRepairs, tcConst,
  frmRepairs, AppointmentLib, BusObjRepairs, BusObjAppointments,
  BusObjEquipment;

{$R *.dfm}

procedure TfmEmployeeCalendar.chkhideMsgExit(Sender: TObject);
begin
  inherited;
  if appenv.employee.HideMSgonEmployeeCalendar <> chkhideMsg.Checked then begin
      appenv.employee.HideMSgonEmployeeCalendar := chkhideMsg.Checked;
  end;
end;

procedure TfmEmployeeCalendar.DBPlanner1ItemDblClick(Sender: TObject;
  Item: TPlannerItem);
begin
//  inherited;
  OpenERPFormModal('TfmPadRepairs' , qryAppointmentsRepairID.AsInteger, beforshowPadRepairs);
end;

procedure TfmEmployeeCalendar.copyEquipsToappointment(const Sender: TBusObj;
  var Abort: boolean);
begin
  if not(sender is TEquipmentxRef) then Exit;
  if Appointment = nil then exit;
  if not(Appointment is TAppointment) then exit;
  TAppointment(Appointment).Equipment.New;
  TAppointment(Appointment).Equipment.CustomerEquipmentid:= TEquipmentxRef(Sender).CustomerEquipmentid;
  TAppointment(Appointment).Equipment.Code               := TEquipmentxRef(Sender).Code;
  TAppointment(Appointment).Equipment.UOM                := TEquipmentxRef(Sender).Uom;
  TAppointment(Appointment).Equipment.UOMID              := TEquipmentxRef(Sender).UOMID;
  TAppointment(Appointment).Equipment.UOMMultiplier      := TEquipmentxRef(Sender).UOMMultiplier;
  TAppointment(Appointment).Equipment.UOMQty             := TEquipmentxRef(Sender).UOMQty;
  TAppointment(Appointment).Equipment.Quantity           := TEquipmentxRef(Sender).Quantity;
  TAppointment(Appointment).Equipment.WarantyPeriodTaken := TEquipmentxRef(Sender).WarantyPeriodTaken;
  TAppointment(Appointment).Equipment.WarantyPeriodLeft  := TEquipmentxRef(Sender).WarantyPeriodLeft;
  TAppointment(Appointment).Equipment.WarantyFinishDate  := TEquipmentxRef(Sender).WarantyFinishDate;
  TAppointment(Appointment).Equipment.WarantyPeriod      := TEquipmentxRef(Sender).WarantyPeriod;
  TAppointment(Appointment).Equipment.Notes              := TEquipmentxRef(Sender).Notes;
  TAppointment(Appointment).Equipment.PostDB;
end;
procedure TfmEmployeeCalendar.DBPlanner1PlannerDblClick(Sender: TObject;
  Position, FromSel, FromSelPrecise, ToSel, ToSelPrecise: Integer);
begin
//  inherited;
  MakeRepairnAppt(TDBPlanner(Sender).CellToTime(TDBPlanner(Sender).SelPosition,TDBPlanner(Sender).SelItemBegin));
end;
procedure TfmEmployeeCalendar.MakeRepairnAppt(const selDate:TdateTime);
var
  newRepairID:Integer;
  newApptID:Integer;
  RepairObj:TRepairs;
  ApptObj :TAppointment;
begin
  newApptID:= 0;
  if MessageDlgXP_Vista('This will let you create a ''Repair'' and make an appointment for the newly created repair for you. '+NL+NL+
                        'Do you want to continue?', mtConfirmation, [mbYes, mbNo], 0) = mrno then exit;
  NewRepairID:= TRepairsGUI.MakeaNewRepair;
  if newRepairID<> 0 then begin
    RepairObj:= TRepairs.CreateWithNewConn(Self);
    try
      RepairObj.Load(newRepairID);
      if RepairObj.count = 1 then begin
        ApptObj:=  TAppointment.CreateWithNewConn(self);
        try
          ApptObj.SilentMode:= True;
          ApptObj.Load(0);
          ApptObj.Connection.BeginTransaction;
          ApptObj.New;
          ApptObj.TrainerID := appenv.Employee.EmployeeID;
          ApptObj.ClientID := REpairObj.ClientID;
          ApptObj.RepairId := RepairObj.ID;
          ApptObj.PostDB;
          ApptObj.Notes :=RepairObj.Notes;
          ApptObj.Feedbacknotes :=RepairObj.Feedbacknotes;
          if RepairObj.RepairEquipment.count >0 then begin
            Appointment:=ApptObj;
            RepairObj.RepairEquipment.IterateRecords(copyEquipsToappointment);
          end;
          ApptObj.StartTime := SeldAte;
          if ApptObj.Save then begin
            ApptObj.connection.CommitTransaction;
            newApptID:=ApptObj.ID;
          end;
        finally
          FreeandNil(ApptObj);
        end;
      end;
    finally
      Freeandnil(RepairObj);
    end;
    if newApptID <> 0 then begin
       closedb(qryAppointments);
       openDB(qryAppointments);
       if qryAppointments.Locate('AppointID' , newApptID , []) then
        OpenERPForm('TAppointmentGUI' , newApptID , nil);
    end;
  end;
end;


procedure TfmEmployeeCalendar.DBPlannerMonthViewDblClick(Sender: TObject;
  SelDate: TDateTime);
begin
//  inherited;
  MakeRepairnAppt(Seldate);
end;

procedure TfmEmployeeCalendar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteGuiPrefExtra;
  inherited;
end;

procedure TfmEmployeeCalendar.FormCreate(Sender: TObject);
begin
  inherited;
  qryResources.parambyname('employeeId').asInteger := Appenv.employee.EmployeeId;
end;

procedure TfmEmployeeCalendar.FormShow(Sender: TObject);
begin
  inherited;
  if appenv.employee.HideMSgonEmployeeCalendar = false then begin
    TimerMsg(pnlMsg,lblNote , 'Please note that this form will ONLY show the ''Repairs'' appointments of you'+NL+
                      '(Employee :' +Appenv.Employee.EmployeeName+')'+NL+
                      'Please goto the Main Calendar to see other appointments.', 20);
  end;
  ReadnApplyGuiPrefExtra;
end;

procedure TfmEmployeeCalendar.beforshowPadRepairs(Sender: TObject);
begin
if not(Sender is TfmPadRepairs) then exit;
   TfmPadRepairs(Sender).apptID :=qryAppointmentsAppointID.AsInteger;
end;


procedure TfmEmployeeCalendar.lblNoteDblClick(Sender: TObject);
begin
  inherited;
  tmrProcessMessageTimer(tmrProcessMessage);
end;


procedure TfmEmployeeCalendar.SetQueryDateRange;
begin
  inherited;
  qryAppointments.Parambyname('xTrainerID').AsInteger := Appenv.Employee.EmployeeID;
  Self.Caption := 'Calender : ' + Appenv.Employee.EmployeeName;
end;
procedure TfmEmployeeCalendar.ReadnApplyGuiPrefExtra;
var
  x: integer;
begin
      guiprefs.active:= True;
      if GuiPrefs.Node.Exists('CalendarOptions') then begin
        x := GuiPrefs.Node['CalendarOptions.PageIndex'].asInteger;
        if x > 0 then if PageControl1.ActivePageIndex  <> x-1 then begin
          PageControl1.ActivePageIndex := x - 1;
          PageControl1Change(PageControl1);
        end;
      end;
end;
procedure TfmEmployeeCalendar.WriteGuiPrefExtra;
begin
  GuiPrefs.Node['CalendarOptions.PageIndex'].asInteger := PageControl1.ActivePageIndex  + 1;
end;

initialization
  RegisterClassOnce(TfmEmployeeCalendar);

end.

