unit frmEmpResProcRoster;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBPlanner, DB, ProgressDialog, MemDS, DBAccess,
  MyAccess, ERPdbComponents, ImgList, AdvMenus, DataState, AppEvnts,
  SelectionDialog, Menus, ExtCtrls, Planner, DNMPanel, StdCtrls , frmEmpRosterBase, BusObjBase, BusobjEmpResProcSchedule,
  DNMSpeedButton, Shader, wwdbdatetimepicker, AdvGlowButton, ActnList, DNMAction,
  GIFImg, CheckLst, Grids, Wwdbigrd, Wwdbgrid, frmchooseDays, ComCtrls,
  DataSourcePrefs;

type


  TEmpResProcScheduleItem = class(TRosterBaseObj)
  Private
    fsPlannerId: string;
    fiResourceDetailId: Integer;
    fiProcessStepId: Integer;
    fiWeekDayNo: Integer;
    fiEmployeeId: Integer;
    fdTimeTo: TDateTime;
    fbActive: Boolean;
    fiResourceID: Integer;
    fdTimeFrom: TDateTime;
    fsREsourceDetailDescription: STring;
    fsResourceName: String;
    fsProcessStep: String;
    fiRosterID: Integer;
    fiScheduleId: Integer;
    fiProcessPartID: Integer;
    fiSeqno: Integer;
    fiLeaveID: Integer;
    fiupdateSeqno: Integer;
    fsDescription :String;
    procedure setResourceID(const Value: Integer);
  Protected
  Public
    property PlannerId                  :string       read fsPlannerId                  write fsPlannerId       ;
    property EmployeeId                 :Integer      read fiEmployeeId                 write fiEmployeeId      ;
    property WeekDayNo                  :Integer      read fiWeekDayNo                  write fiWeekDayNo       ;
    property ProcessStepId              :Integer      read fiProcessStepId              write fiProcessStepId   ;
    property ResourceID                 :Integer      read fiResourceID                 write setResourceID      ;
    property ResourceDetailId           :Integer      read fiResourceDetailId           write fiResourceDetailId;
    property TimeFrom                   :TDateTime    read fdTimeFrom                   write fdTimeFrom        ;
    property TimeTo                     :TDateTime    read fdTimeTo                     write fdTimeTo          ;
    property Active                     :Boolean      read fbActive                     write fbActive          ;
    Property ProcessStep                :String       read fsProcessStep                write fsProcessStep;
    Property ResourceName               :String       read fsResourceName               write fsResourceName;
    Property REsourceDetailDescription  :STring       read fsREsourceDetailDescription  write fsREsourceDetailDescription;
    property RosterID                   :Integer      read fiRosterID                   write fiRosterID       ;
    property ScheduleId                 :Integer      read fiScheduleId                 write fiScheduleId     ;
    property ProcessPartID              :Integer      read fiProcessPartID              write fiProcessPartID  ;
    property Seqno                      :Integer      read fiSeqno                      write fiSeqno  ;
    property LeaveID                    :Integer      read fiLeaveID                    write fiLeaveID  ;
    property updateSeqno                :Integer      read fiupdateSeqno                write fiupdateSeqno  ;
    Property Description                :String       read fsDescription                write fsDescription;

  end;
  TfmEmpResProcRoster = class(TfmEmpRosterBase)
    QryRosterID: TIntegerField;
    QryRosterGlobalRef: TWideStringField;
    QryRosterPlannerId: TWideStringField;
    QryRosterEmployeeId: TIntegerField;
    QryRosterWeekDayNo: TIntegerField;
    QryRosterProcessStepId: TIntegerField;
    QryRosterResourceID: TIntegerField;
    QryRosterResourceDetailId: TIntegerField;
    QryRosterTimeFrom: TDateTimeField;
    QryRosterTimeTo: TDateTimeField;
    QryRosterActive: TWideStringField;
    QryRostermsTimeStamp: TDateTimeField;
    QryRostermsUpdateSiteCode: TWideStringField;
    QryProcessResourceResDetails: TERPQuery;
    QryProcessResourceResDetailsProcessStepID: TIntegerField;
    QryProcessResourceResDetailsProcessStep: TWideStringField;
    QryProcessResourceResDetailsResourceId: TIntegerField;
    QryProcessResourceResDetailsResourceName: TWideStringField;
    QryProcessResourceResDetailsREsourceDetailID: TIntegerField;
    QryProcessResourceResDetailsREsourceDetailDescription: TWideStringField;
    QryRosterProcessStep: TStringField;
    QryRosterResourceName: TStringField;
    QryRosterREsourceDetailDescription: TStringField;
    QryEmpProcesses: TERPQuery;
    popPlanner: TPopupMenu;
    QryProcessResourceResDetailsrownum: TLargeintField;
    QryEmpProcessesrownum: TLargeintField;
    QryEmpProcessesProcessStepID: TIntegerField;
    QryEmpProcessesProcessStep: TWideStringField;
    QryEmpProcessesResourceId: TIntegerField;
    QryEmpProcessesResourceName: TWideStringField;
    QryEmpProcessesREsourceDetailID: TIntegerField;
    QryEmpProcessesREsourceDetailDescription: TWideStringField;
    QryEmpProcessesemployeeId: TIntegerField;
    QryRosterNotes: TStringField;
    lsTDNMSpeedButtonActions: TActionList;
    actSunday: TDNMAction;
    actSaturday: TDNMAction;
    actMonday: TDNMAction;
    actTuesday: TDNMAction;
    actWednesday: TDNMAction;
    actThursday: TDNMAction;
    actFriday: TDNMAction;
    btnnext: TAdvGlowButton;
    btnPrevious: TAdvGlowButton;
    actNext: TDNMAction;
    actPrevious: TDNMAction;
    pnlbuttons: TDnMPanel;
    btnsunday: TAdvGlowButton;
    btnMonday: TAdvGlowButton;
    btnTuesday: TAdvGlowButton;
    btnWednesday: TAdvGlowButton;
    btnThursday: TAdvGlowButton;
    btnFriday: TAdvGlowButton;
    btnSaturday: TAdvGlowButton;
    popupPlannerItem: TPopupMenu;
    mnuDeleteItem: TMenuItem;
    Copy1: TMenuItem;
    QryResources: TERPQuery;
    dsREsources: TDataSource;
    QryResourcesNo: TIntegerField;
    QryResourcesResourceName: TWideStringField;
    QryResourcesProcessstep: TWideStringField;
    QryResourcesProcResourceId: TIntegerField;
    QryResourcesProcessStepId: TIntegerField;
    actShowResouce: TDNMAction;
    btnShowResouce: TDNMSpeedButton;
    Label1: TLabel;
    grdResources: TwwDBGrid;
    lblMsg: TLabel;
    btnCreateDEfaultAllocation: TDNMSpeedButton;
    procedure popPlannerPopup(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RosterItemToField(Sender: TObject; Fields: TFields;Item: TPlannerItem);
    procedure RosterSourcePositionToResource(Sender: TObject; Field: TField;Position: Integer);
    procedure RosterSourceResourceToPosition(Sender: TObject; Field: TField;var Position: Integer; var Accept: Boolean);
    procedure QryRosterCalcFields(DataSet: TDataSet);
    procedure QryRosterAfterInsert(DataSet: TDataSet);
    procedure OnDaySelect(Sender: TObject);
    procedure OnDayupdate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuDeleteItemClick(Sender: TObject);
    procedure PlannerItemSize(Sender: TObject; Item: TPlannerItem; Position,
      FromBegin, FromEnd, ToBegin, ToEnd: Integer);
    procedure PlannerItemMove(Sender: TObject; Item: TPlannerItem; FromBegin,
      FromEnd, FromPos, ToBegin, ToEnd, ToPos: Integer);
    procedure PlannerItemSelect(Sender: TObject; Item: TPlannerItem);
    procedure PlannerEnter(Sender: TObject);
    procedure PlannerItemMoving(Sender: TObject; Item: TPlannerItem; DeltaBegin,
      DeltaPos: Integer; var Allow: Boolean);
    procedure PlannerItemSizing(Sender: TObject; Item: TPlannerItem; DeltaBegin,
      DeltaEnd: Integer; var Allow: Boolean);
    procedure PlannerItemStartEdit(Sender: TObject; Item: TPlannerItem);
    procedure Copy1Click(Sender: TObject);
    procedure RosterFieldsToItem(Sender: TObject; Fields: TFields;
      Item: TPlannerItem);
    procedure actShowResouceUpdate(Sender: TObject);
    procedure actShowResouceExecute(Sender: TObject);
    procedure grdResourcesCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure FormDestroy(Sender: TObject);
    procedure pnltopDblClick(Sender: TObject);
    procedure btnCreateDEfaultAllocationClick(Sender: TObject);
  private
    buttons : Array [1..7] of TAdvGlowButton ;
    Days    : Array [1..7] of TDate ;
    AllrecsValid :boolean;
    Tablename :String;
    iDays :TIntArray;
    procedure Logit;
    function CurWeekdayNo:Integer;
    procedure RefreshSidebuttons(WeekdayNo: Integer);
    function SplitVertical(const Value: String): String;
    procedure RefreshQryEmpProcesses(const empID:Integer);
    function CopyRosterItem(Item: TPlannerItem):boolean;
    Function DateforWeekday(const Value:Integer):Tdate;
    Procedure MakeResourcecolorList;
    procedure CheckForProcessStepEmployees(Sender:TObject);
  Protected
    EmpResProcSchedule : TEmpResProcRoster;
    EmpResProcScheduleItemProperties : TEmpResProcScheduleItem;
    Procedure NewItemProperty; Override;
    Procedure InitItemProperties(Fields: TFields);Override;
    procedure DoBusinessObjectEvent(Const Sender: TDatasetBusObj; const EventType, Value: string);Override;
    function SaveRecord: Boolean;Override;
    Procedure SaveRecordCallback(Const Sender: TBusObj; var Abort: Boolean);Virtual;
    function busobj: TMSBusObj;Override;
    Procedure LoadBusObj;Override;
    Procedure MakeNewEntry(oItem : TPlannerItem; Sender:TObject);Override;
    function StartDate:TDateTime; Override;
    Procedure RefreshQuery; Override;
    Procedure PopupMenuHandler(Sender:TObject); Override;
    Procedure ReadGuiprefs;Virtual;
    Procedure WriteGuiprefs;Virtual;
    Procedure MakeBusObj;Virtual;
    Function MinDateRange:TDateTime; virtual;
    Function MaxDateRange:TDateTime;Virtual;
    function ResourceToDarkcolor(const REsourceID: Integer; ProcessStepID:Integer): TColor;
    function ResourceToLightcolor(const REsourceID: Integer; ProcessStepID:Integer): TColor;
    procedure ItemToField(Item: TPlannerItem);Virtual;
    Procedure DoOnDelete(Item:TPlannerItem);Virtual;
    Procedure OnDatechange (Sender:TObject);Override;
    procedure ReadOnlyAccess(const Value: Boolean);virtual;
  public
  end;


implementation

uses CommonLib, BusObjConst, tcConst, LogLib,dateutils,
  CommonDbLib, DbSharedObjectsObj, MySQLConst, CommonFormLib, AppEnvironment;

{$R *.dfm}

procedure TfmEmpResProcRoster.actShowResouceExecute(Sender: TObject);
begin
  inherited;
  grdResources.Visible := not(grdResources.Visible);
end;

procedure TfmEmpResProcRoster.actShowResouceUpdate(Sender: TObject);
begin
  inherited;
  if grdResources.Visible then  actShowResouce.Caption := 'Hide Resource List' else actShowResouce.Caption := 'Show Resource List';
end;

function TfmEmpResProcRoster.busobj: TMSBusObj;
begin
  Result := TMSBusObj(EmpResProcSchedule);
end;


Procedure TfmEmpResProcRoster.Logit;
begin
  if not devmode then Exit;

  lblmsg.caption :=  EmpResProcSchedule.SQL+ NL +
                    FormatdateTime('dd-mm-yyyy hh:nn:ss' ,    RosterSource.Day) + NL+
                    FormatdateTime('dd-mm-yyyy hh:nn:ss' ,    EmpResProcSchedule.timeFrom) +  ' - ' +FormatdateTime('dd-mm-yyyy hh:nn:ss' ,    EmpResProcSchedule.timeTo)+ NL+
                           'Employee ID:' + inttostr(EmpResProcSchedule.EmployeeId)+NL +
                           'Resource ID:' + inttostr(EmpResProcSchedule.ResourceID)+NL +
                           'ProcessStep ID:' + inttostr(EmpResProcSchedule.ProcessStepId)+NL +
                           'Resource Detail ID:' + inttostr(EmpResProcSchedule.ResourceDetailId);
end;
procedure TfmEmpResProcRoster.Copy1Click(Sender: TObject);
var
  i:Integer;
  Item:TPlannerItem;
begin
  inherited;
  SetLength(iDays,1);
  iDays[low(iDays)] :=CurWeekdayNo;
  Choosedays(iDays, self);
  if Length(idays)=0 then Exit;

  for i := planner.Items.Count - 1 downto 0  do begin
    Item := planner.Items.Items[i];
    if Item.Selected then begin
      if EmpResProcSchedule.Locate('PlannerId' , TEmpResProcScheduleItem(Item.ItemObject).PlannerId , []) then begin
        CopyRosterItem(Item);
      end;
    end;
  end;
  EmpResProcSchedule.Closedb;
  EmpResProcSchedule.OpenDb;
  planner.Update;
  EmpResProcSchedule.Dirty := True;
end;

function TfmEmpResProcRoster.CopyRosterItem(  Item:TPlannerItem):boolean;
  var
  ctr:Integer;
  Obj : TEmpResProcRoster;
begin
  inherited;
  Result := False;
    Obj := TEmpResProcRoster.Create(nil); // form shouldn't own it to avoid using the planner's dataset
    try
        obj.Connection := EmpResProcSchedule.Connection;
        for ctr:= low(iDays) to high(iDays) do begin
          obj.LoadSelect('WeekDayNo = ' + inttostr(iDays[ctr])+
                                ' and  ((   timeFrom = ' + Quotedstr(formatDatetime(MySQLDatetimeformat , DateforWeekday(iDays[ctr])+ timeof(TEmpResProcScheduleItem(Item.ItemObject).timeFrom)))+
                                '       and timeto   = ' + Quotedstr(formatDatetime(MySQLDatetimeformat , DateforWeekday(iDays[ctr])+ timeof(TEmpResProcScheduleItem(Item.ItemObject).timeto))) + ')'+
                                ' or    (   timeFrom < ' + Quotedstr(formatDatetime(MySQLDatetimeformat , DateforWeekday(iDays[ctr])+ timeof(TEmpResProcScheduleItem(Item.ItemObject).timeFrom)))+
                                '       and timeto  > ' + Quotedstr(formatDatetime(MySQLDatetimeformat , DateforWeekday(iDays[ctr])+ timeof(TEmpResProcScheduleItem(Item.ItemObject).timeFrom)))+') ' +
                                ' or    (   timeFrom > ' + Quotedstr(formatDatetime(MySQLDatetimeformat , DateforWeekday(iDays[ctr])+ timeof(TEmpResProcScheduleItem(Item.ItemObject).timeFrom)))+
                                '       and timeto  < ' + Quotedstr(formatDatetime(MySQLDatetimeformat , DateforWeekday(iDays[ctr])+ timeof(TEmpResProcScheduleItem(Item.ItemObject).timeFrom)))+')) ' +
                         ' and EmployeeId =' + inttostr(TEmpResProcScheduleItem(Item.ItemObject).employeeID )+
                         ' and ProcessStepId =' + inttostr(TEmpResProcScheduleItem(Item.ItemObject).ProcessStepId )+
                         ' and ResourceID =' + inttostr(TEmpResProcScheduleItem(Item.ItemObject).ResourceID )+
                         ' and ResourceDetailId =' + inttostr(TEmpResProcScheduleItem(Item.ItemObject).ResourceDetailId ));
          if obj.Count =0 then begin
            obj.New;
            obj.EmployeeId      := TEmpResProcScheduleItem(Item.ItemObject).employeeID ;
            obj.ProcessStepId   := TEmpResProcScheduleItem(Item.ItemObject).ProcessStepId ;;
            obj.ResourceID      := TEmpResProcScheduleItem(Item.ItemObject).ResourceID ;
            obj.ResourceDetailId:= TEmpResProcScheduleItem(Item.ItemObject).ResourceDetailId ;
            obj.WeekDayNo       := iDays[ctr];
            obj.TimeFrom        := DateforWeekday(iDays[ctr])+ timeof(TEmpResProcScheduleItem(Item.ItemObject).timeFrom);
            obj.TimeTo          := DateforWeekday(iDays[ctr])+ timeof(TEmpResProcScheduleItem(Item.ItemObject).timeto);
            obj.PostDB;
          end;
          Result := True;
          end;
    finally
      Freeandnil(Obj);
    end;
  //end;
end;

function TfmEmpResProcRoster.CurWeekdayNo: Integer;
var
  ctr:Integer;
begin
  result := -1;
  for ctr:= low(buttons)to high(buttons) do
    if RosterDatePicker.StartDate = Days[ctr] then begin
      result := ctr;
      break;
    end;
end;

function TfmEmpResProcRoster.DateforWeekday(const Value: Integer): Tdate;
begin
       if Value = 1 then result := EmpResProcScheduleDays.Sunday
  else if Value = 2 then result := EmpResProcScheduleDays.Monday
  else if Value = 3 then result := EmpResProcScheduleDays.Tuesday
  else if Value = 4 then result := EmpResProcScheduleDays.Wednesday
  else if Value = 5 then result := EmpResProcScheduleDays.Thursday
  else if Value = 6 then result := EmpResProcScheduleDays.Friday
  else if Value = 7 then result := EmpResProcScheduleDays.Saturday
  else result := 0;
end;

procedure TfmEmpResProcRoster.btnCreateDEfaultAllocationClick(Sender: TObject);
var
  ans : Word;
  sSQL:String;
  ctr:Integer;
  Obj : TEmpResProcRoster;
  qry: TERPQuery;
  dt1, dt2:TDatetime;
begin
  inherited;
  if not SaveRecord then exit;
  EmpResProcSchedule.Connection.CommitTransaction;
  EmpResProcSchedule.Connection.BeginTransaction;
  try

      ans := MessageDlgXP_Vista('Do you Wish to Create The Schedule for '+NL+
                                'Just the ''Default User'' as Assigned in Process Step or '+NL+
                                '''All Users'' as Assigned in the Process Step,  of all Process Steps? ', mtConfirmation, [], 0, nil , '', '', false, nil, 'Default Users,All Users,Cancel' );
      if ans= 102 then exit;
      sSQL := '';
      for ctr := 0 to (7-Appenv.companyPrefs.NoofWeekendDays)-1 do begin  // for all working days in the system
        if sSQL <> '' then sSQL := sSQL + 'union'+NL;
        sSQL := sSQL + ' select ' +
                       ' E.EmployeeName, PRD.Description as ResName,  EP.EmployeeID,  ' +
                       quotedstr(Appenv.companyPrefs.StartWorkWeek)+' as Dayname, '+
                       ' nextdayno('+quotedstr(Appenv.companyPrefs.StartWorkWeek)+','+ inttostr(ctr)+') as Weekdayno , ' +
                       ' PS.Id as ProcessStepID, ' +
                       ' PRD.ProcResourceId , ' +
                       ' Min(PRD.ID) ProcResourcedetailID, ' +
                       ' convert('+Quotedstr(formatDatetime(mysqldatetimeformat , Appenv.companyprefs.StartOfDay))+', datetime)    as TimeFrom, ' +
                       ' convert('+Quotedstr(formatDatetime(mysqldatetimeformat , Appenv.companyprefs.EndOfDay))+', datetime)    as TimeTo ' +
                       ' from tblemployeeprocesssteps EP ' +
                       ' inner join tblemployees E on EP.employeeId = E.employeeID '+
                       ' inner join tblprocessStep Ps on EP.ProcessStepID = Ps.ID ' +
                       ' inner join tblprocresourceprocess PRP on PRP.ProcessStepId = PS.ID ' +
                       ' inner join tblprocresourcedetails PRD on PRD.ProcResourceId = PRP.ProcResourceId ' +
                       iif(ans = 100 , ' where EP.isdefault ="T" ' , '') +
                       ' group by EP.EmployeeID,PS.Id'+NL;
      end;
      if sSQL = '' then exit;
      sSQL := sSQL  +' Order by weekdayno, ProcResourcedetailID';
      qry := DbSharedObjectsObj.DbSharedObj.GetQuery(EmpResProcSchedule.Connection.Connection);
      try
        Qry.sql.text := sSQL;
        Qry.open;
        if Qry.recordcount =0 then exit;

        Obj := TEmpResProcRoster.Create(nil); // form shouldn't own it to avoid using the planner's dataset
        try
            obj.Connection := EmpResProcSchedule.Connection;

            DoShowProgressbar(Qry.recordcount, WAITMSG);
            try
                Qry.first;
                ctr := 0;
                While Qry.EOF = False do begin
                  dt1:= DateforWeekday(Qry.fieldbyname('Weekdayno').asInteger);
                  dt1:= dt1 + timeof(Qry.fieldbyname('TimeFrom').asDateTime);
                  dt2:= DateforWeekday(Qry.fieldbyname('Weekdayno').asInteger);
                  dt2 := dt2 +timeof(Qry.fieldbyname('TimeTo').asDateTime);

                  sSQL := 'WeekDayNo = ' + inttostr(Qry.fieldbyname('Weekdayno').asInteger)+
                                        ' and  ((timeFrom = ' + Quotedstr(formatDatetime(MySQLDatetimeformat , dt1))+
                                        ' and    timeto   = ' + Quotedstr(formatDatetime(MySQLDatetimeformat , dt2)) + ')'+
                                        ' or    (timeFrom < ' + Quotedstr(formatDatetime(MySQLDatetimeformat , dt1))+
                                        ' and    timeto  > ' + Quotedstr(formatDatetime(MySQLDatetimeformat  , dt1))+') ' +
                                        ' or    (timeFrom > ' + Quotedstr(formatDatetime(MySQLDatetimeformat , dt2))+
                                        ' and    timeto  < ' + Quotedstr(formatDatetime(MySQLDatetimeformat  , dt2))+')) ' +
                                 ' and EmployeeId       =' + inttostr(Qry.fieldbyname('EmployeeID').asInteger )+
                                 ' and ProcessStepId    =' + inttostr(Qry.fieldbyname('ProcessStepID').asInteger )+
                                 ' and ResourceID       =' + inttostr(Qry.fieldbyname('ProcResourceId').asInteger )+
                                 ' and ResourceDetailId =' + inttostr(Qry.fieldbyname('ProcResourcedetailID').asInteger );
                  obj.LoadSelect(sSQL);
                  if obj.Count =0 then begin
                    obj.New;
                    obj.EmployeeId      := Qry.fieldbyname('EmployeeID').asInteger ;
                    obj.ProcessStepId   := Qry.fieldbyname('ProcessStepID').asInteger ;;
                    obj.ResourceID      := Qry.fieldbyname('ProcResourceId').asInteger ;
                    obj.ResourceDetailId:= Qry.fieldbyname('ProcResourcedetailID').asInteger ;
                    obj.WeekDayNo       := Qry.fieldbyname('Weekdayno').asInteger;
                    obj.TimeFrom        := dt1;
                    obj.TimeTo          := dt2;
                    obj.PostDB;
                    ctr := ctr +1;
                  end;
                  DoStepProgressbar('Allocating :' + Qry.fieldbyname('EmployeeName').asString +' On ' +
                                      //Qry.fieldbyname('Dayname').asString +' in ' +
                                      WeekDay(Qry.fieldbyname('Weekdayno').asInteger) +' in ' +
                                      Qry.fieldbyname('ResName').asString +' : '+ inttostr(Qry.recno)+' of '+ inttostr(Qry.recordcount));
                  Qry.Next;
                end;
            finally
              DoHideProgressbar;
            end;
        finally
          Freeandnil(Obj);
          if ctr >0 then begin
            MessageDlgXP_Vista(inttostr(ctr)+' Allocation(s) are Made. ', mtInformation, [mbOK], 0);
          end;
        end;
      finally
        DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
      end;
  Except
    on E:Exception do begin
      MessageDlgXP_Vista('Error Occured in auto Allocation.'+NL+NL+E.message, mtInformation, [mbOK], 0);
      EmpResProcSchedule.Connection.RollbackTransaction;
      EmpResProcSchedule.Connection.BeginTransaction;
      Exit;
    end;
  end;
  EmpResProcSchedule.Connection.CommitTransaction;
  Self.Close;
end;

procedure TfmEmpResProcRoster.mnuDeleteItemClick(Sender: TObject);
var
  i:Integer;
  Item:TPlannerItem;
begin
  inherited;
 for i := planner.Items.Count - 1 downto 0  do begin
    Item := planner.Items.Items[i];
    if Item.Selected then begin
      if EmpResProcSchedule.Locate('PlannerId' , TEmpResProcScheduleItem(Item.ItemObject).PlannerId , []) then begin
        planner.FreeItem(Item);
        planner.Update;
        EmpResProcSchedule.Dirty := True;
        DoOnDelete(Item);
        Exit;
      end;
    end;
  end;
end;


procedure TfmEmpResProcRoster.DoBusinessObjectEvent(const Sender: TDatasetBusObj;  const EventType, Value: string);
begin
  inherited;
     if (Eventtype = BusObjEvent_Dataset) and (Value = BusObjEvent_AssignDataset) then begin
        if Sender is TEmpResProcRoster then TEmpResProcRoster(Sender).Dataset  := QryRoster;
     end else if (Eventtype = BusObjEvent_Dataset) and ((Sender.IsdataIdchangeEvent(Value)) or (Value = BusObjEventDataset_AfterOpen)) then begin
      if Sender is TEmpResProcRoster then
        logit;
     end else if (Eventtype = BusobjEvent_Event) and (Value = BusObjEventDataset_AfterInsert) then begin
        if Sender is TEmpResProcRoster then
          TEmpResProcRoster(Sender).weekdayno := CurWeekDayNo;
     end;
end;


procedure TfmEmpResProcRoster.DoOnDelete(Item: TPlannerItem);
begin

end;

procedure TfmEmpResProcRoster.FormClose(Sender: TObject;  var Action: TCloseAction);
begin
  WriteGuiprefs;

  inherited;

end;

procedure TfmEmpResProcRoster.FormCreate(Sender: TObject);
begin
  buttons[1]:= btnsunday    ; Days[1]:= EmpResProcScheduleDays.Sunday;
  buttons[2]:= btnMonday    ; Days[2]:= EmpResProcScheduleDays.monday;
  buttons[3]:= btnTuesday   ; Days[3]:= EmpResProcScheduleDays.tuesday;
  buttons[4]:= btnWednesday ; Days[4]:= EmpResProcScheduleDays.Wednesday;
  buttons[5]:= btnThursday  ; Days[5]:= EmpResProcScheduleDays.Thursday;
  buttons[6]:= btnFriday    ; Days[6]:= EmpResProcScheduleDays.Friday;
  buttons[7]:= btnSaturday  ; Days[7]:= EmpResProcScheduleDays.Saturday;

  MakeREsourcecolorList;

  inherited;

  lblmsg.visible := Devmode;
  if MinDateRange <> 0 then begin
    if RosterDatePicker.StartDate =0 then RosterDatePicker.StartDate :=MinDateRange;
    RosterDatePicker.MinDate := MinDateRange;
  end;
  if MaxDateRange <> 0 then begin
    if RosterDatePicker.StartDate =0 then RosterDatePicker.StartDate :=MaxDateRange;
    RosterDatePicker.MaxDate := MaxDateRange;
  end;

  MakeBusobj;

end;

procedure TfmEmpResProcRoster.FormDestroy(Sender: TObject);
begin
  DestroyUserTemporaryTable(Tablename);
  inherited;

end;

procedure TfmEmpResProcRoster.FormShow(Sender: TObject);
var
  s:String;
begin
  inherited;
  ReadGuiprefs;
  RefreshSidebuttons(CurWeekdayNo);
  Planner.caption.Background := clNavy;
  Planner.caption.Backgroundto := clWhite;
  if not UserLock.Enabled then UserLock.enabled := True;
  if not IsFormReadOnly then
    If Not UserLock.Lock('tblempresprocschedule', 0, 'BOM Schedule Roster') Then Begin
       accesslevel:= 5;
      s:=UserLock.LockMessage;
      s:= replacestr(s, 'Unable to update data.' , 'Unable to Do BOM Schedule Roster.');
      s:= replacestr(s, 'accessing this record' , 'Scheduling');
      s:= replacestr(s, 'Record' , 'Module');
      CommonLib.MessageDlgXP_Vista(s, MtWarning, [MbOK], 0);
    End;
    ReadOnlyAccess(IsFormReadOnly);
    if not(IsFormReadOnly) and (Classnameis('TfmEmpResProcRoster')) then begin
      tmrDelay.OnTimer := CheckForProcessStepEmployees;
      tmrdelay.interval := 500;
      tmrDelay.Enabled := True;
    end;
   //RosterDatePicker.Visible := Devmode;
end;
procedure TfmEmpResProcRoster.CheckForProcessStepEmployees(Sender:TObject);
var
  qry: TERPQuery;
begin
  tmrDelay.Enabled := False;
  tmrDelay.OnTimer := nil;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(Self.MyConnection);
  try
    Qry.SQL.text := 'Select   Ps.ID as ProcessStepId, Ps.Description as Processstep ' +
                    ' from  tblprocessstep Ps ' +
                    ' Left join tblprocresourceprocess PR  on Ps.ID = PR.ProcessStepId ' +
                    ' where ifnull(PR.ProcResourceProcessId,0)=0 ' +
                    ' union ' +
                    ' Select Ps.ID as ProcessStepId, Ps.Description as Processstep ' +
                    ' from  tblprocessstep Ps ' +
                    ' left join tblemployeeprocesssteps EP on Ps.ID = EP.ProcessStepID ' +
                    ' where ifnull(EP.EmpProcessStepsID,0)=0 ' +
                    ' order by Processstep Limit 1';
    opendb(Qry);
    if Qry.recordcount >0 then begin
      OpenERPFormModal('TFmProcessStepUnAssigned' , 0);
      QryProcessEmployees.Refresh;
      InitPlanner;
      RefreshQuery;
    end;
    TimerMsg(lblMsg, 'Please Select the Time slots for the Employee and Right Click for List of the Process Steps that the employee Can Do, to Assign for the Selected Slot');
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;
procedure TfmEmpResProcRoster.grdResourcesCalcCellColors(Sender: TObject;
  Field: TField; State: TGridDrawState; Highlight: Boolean; AFont: TFont;
  ABrush: TBrush);
begin
  inherited;
  if sametext(QryREsourcesREsourceName.asString , 'Leave') then begin
    ABrush.Color := clNavy;
    AFont.color := clWhite;
  end else begin
    if devmode then begin
      if sametext(field.FieldName , QryREsourcesProcessstep.FieldName) then  ABrush.Color := Lightcolor(QryREsourcesno.asInteger) else   ABrush.Color := Darkcolor(QryREsourcesno.asInteger);
    end else begin
        ABrush.Color := Lightcolor(QryREsourcesno.asInteger)
    end;
  end;
end;

procedure TfmEmpResProcRoster.ReadGuiprefs;
begin
  if GuiPrefs.active = false then GuiPrefs.Active := TRue;
  if GuiPrefs.Node.Exists('Options.RowHeight') then
    Planner.PositionWidth := GuiPrefs.Node['Options.RowHeight'].asInteger;
  if GuiPrefs.Node.Exists('Options.ResourceListvisible') then
    grdResources.visible := GuiPrefs.Node['Options.ResourceListvisible'].asBoolean;

  if GuiPrefs.Node.Exists('Options.Header') then begin
    Planner.header.height := GuiPrefs.Node['Options.Header.Height'].asInteger;
    Planner.header.ItemHeight := Planner.header.height ;
    planner.Header.TextHeight := Planner.header.height ;
  end;
end;

Procedure TfmEmpResProcRoster.ReadOnlyAccess(Const Value:Boolean);
begin
  if Value then begin
    Planner.DefaultItem.FixedPos:=True;
    Planner.DefaultItem.FixedSize:=True;
    Planner.DefaultItem.FixedTime:=True;
    Planner.DefaultItem.FixedPosition:=True;
    Planner.DefaultItem.Readonly:=True;
    mnuDeleteItem.Enabled := False;
    SetcontrolFocus(cmdCancel);
  end else begin
    Planner.DefaultItem.FixedPos:=False;
    Planner.DefaultItem.FixedSize:=False;
    Planner.DefaultItem.FixedTime:=False;
    Planner.DefaultItem.FixedPosition:=False;
    Planner.DefaultItem.Readonly:=False;
    mnuDeleteItem.Enabled := TRue;
    SetcontrolFocus(Planner);
  end;
end;
procedure TfmEmpResProcRoster.InitItemProperties(Fields: TFields);
begin
  inherited InitItemProperties(EmpResProcSchedule.dataset.fields);

  EmpResProcScheduleItemProperties.PlannerId                  := EmpResProcSchedule.PlannerId;
  EmpResProcScheduleItemProperties.EmployeeId                 := EmpResProcSchedule.EmployeeId;
  EmpResProcScheduleItemProperties.WeekDayNo                  := EmpResProcSchedule.WeekDayNo;
  EmpResProcScheduleItemProperties.ProcessStepId              := EmpResProcSchedule.ProcessStepId;
  EmpResProcScheduleItemProperties.ResourceID                 := EmpResProcSchedule.ResourceID;
  EmpResProcScheduleItemProperties.ResourceDetailId           := EmpResProcSchedule.ResourceDetailId;
  EmpResProcScheduleItemProperties.TimeFrom                   := EmpResProcSchedule.TimeFrom;
  EmpResProcScheduleItemProperties.TimeTo                     := EmpResProcSchedule.TimeTo;
  EmpResProcScheduleItemProperties.Active                     := EmpResProcSchedule.Active;
  EmpResProcScheduleItemProperties.ProcessStep                := EmpResProcSchedule.ProcessStep;
  EmpResProcScheduleItemProperties.ResourceDetailDescription  := EmpResProcSchedule.REsourceDetailDescription;
  EmpResProcScheduleItemProperties.ResourceName               := EmpResProcSchedule.ResourceName;
  if EmpResProcScheduleItemProperties.ProcessStep <> '' then
    EmpResProcScheduleItemProperties.ItemCaption              := EmpResProcScheduleItemProperties.ProcessStep + ':' +
                                                                 iif(EmpResProcScheduleItemProperties.REsourceDetailDescription ='' , EmpResProcScheduleItemProperties.ResourceName,EmpResProcScheduleItemProperties.REsourceDetailDescription );
end;

procedure TfmEmpResProcRoster.LoadBusObj;
begin
  inherited;
  EmpResProcSchedule.LoadSelect('WeekDayNo = ' + inttostr(DayofWeek(RosterDatePicker.StartDate))+
                                ' or DAYOFWEEK(timeFrom) = ' + inttostr(DayofWeek(RosterDatePicker.StartDate))+
                                ' or DAYOFWEEK(timeto)  = ' + inttostr(DayofWeek(RosterDatePicker.StartDate)) +' or (DAYOFWEEK(timeFrom) < '+ inttostr(DayofWeek(RosterDatePicker.StartDate))+' and  DAYOFWEEK(timeto)  > ' + inttostr(DayofWeek(RosterDatePicker.StartDate))+')');
  EmpResProcSchedule.connection.BeginTransaction;
end;

procedure TfmEmpResProcRoster.MakeBusObj;
begin
  EmpResProcSchedule := TEmpResProcRoster.CreateWithNewConn(Self);
  EmpResProcSchedule.Connection.connection := Self.MyConnection;
  EmpResProcSchedule.BusObjEvent := DoBusinessObjectEvent;
end;

procedure TfmEmpResProcRoster.MakeNewEntry(oItem : TPlannerItem; Sender:TObject);
var
  x:Integer;
begin
  inherited;
  if not(Sender is TMenuItem) then exit;
  x:= TMenuItem(sender).tag;
  if x<=0 then exit;
  if not QryEmpProcesses.locate('rownum' , x , []) then exit;
  if oitem.DBKey <> '' then
    if (EmpResProcSchedule.PlannerId <>oitem.DBKey) then
      if not EmpResProcSchedule.Locate('PlannerId' , oitem.DBKey , []) then begin
        EmpResProcSchedule.New;
        EmpResProcSchedule.PlannerId :=oitem.DBKey;
      end;
  if (EmpResProcSchedule.PlannerId =oitem.DBKey) then begin
    if not QryEmpProcesses.locate('rownum' , x , []) then exit;
    EmpResProcSchedule.EmployeeId                 := GetEmployeeFromPosition(oItem.ItemPos);
    EmpResProcSchedule.WeekDayNo                  := DayOfWeek(oItem.ItemStartTime);
    EmpResProcSchedule.ProcessStepId              := QryEmpProcessesProcessStepID.AsInteger;
    EmpResProcSchedule.ResourceID                 := QryEmpProcessesResourceId.AsInteger;
    EmpResProcSchedule.ResourceDetailId           := QryEmpProcessesREsourceDetailID.AsInteger;
    EmpResProcSchedule.TimeFrom                   := oitem.ItemStartTime;
    EmpResProcSchedule.TimeTo                     := oitem.ItemEndTime;
    EmpResProcSchedule.Active                     := TRue;
    EmpResProcSchedule.PostDB;
  end;
  InitItemProperties(nil);
end;
procedure TfmEmpResProcRoster.MakeResourcecolorList;
var
  Script :TERPScript;
  {function colors:String;
  var
    ctr:Integer;
  begin
    result := '';
    for ctr := low(colours) to high(colours) do begin
      if result <> '' then result := result +' union all ';
      result := result + 'Select ' +inttostr(ctr+1)+' as no ';
    end;
    (*for ctr:= 0 to lstColorBox.Items.Count-1 do begin
      if result <> '' then result := result +' union all ';
      result := result + 'Select ' +inttostr(ctr+1)+' as no , '+quotedstr(lstColorBox.Items[ctr])+' as color';
    end;*)

  end;}
  function Nos:String;
  var
    ctr:Integer;
  begin
    REsult := '';
    for ctr:= low(BOMColours.colours) to high(BOMColours.colours) do begin
      if result <> '' then Result := result +' union ';
      result := result + 'Select '+ inttostr(ctr+1) +' as no ' ;
    end;

  end;
begin
  TableName := GetUserTemporaryTableName('ProcResource');
  Script := DbSharedObj.GetScript(Commondblib.GetSharedMyDacConnection);
  try
    Script.SQL.Clear;
    Script.SQL.Add('Drop table if exists '+ Tablename +';');

    Script.SQL.Add('create table ' + Tablename);
    Script.SQL.Add('(No int(11) null default 0,');
    Script.SQL.Add('ResourceName varchar(255) null default null,');
    Script.SQL.Add('ProcessStep varchar(255) null default null,');
    Script.SQL.Add('ProcResourceId int(11) null default 0,');
    Script.SQL.Add('ProcessStepId int(11) null default 0)ENGINE=MyISAM ');
    Script.SQL.Add('Select CONVERT(if(@rownum<' + inttostr(length(BOMColours.colours)) +', @rownum:=@rownum+1 , @rownum:=1),SIGNED) as No,');
    Script.SQL.Add('R.ResourceName, Ps.Description as Processstep, PR.ProcResourceId, PR.ProcessStepId ');
    Script.SQL.Add('from tblprocresourceprocess PR ');
    Script.SQL.Add('inner join tblprocresource R on PR.ProcResourceId = R.ProcResourceId ');
    Script.SQL.Add('inner join tblprocessstep Ps on Ps.ID = PR.ProcessStepId ');
    Script.SQL.Add(', (SELECT @rownum:=0) x ');
    Script.SQL.Add('order by ProcResourceId, ProcessStepId ;');
    Script.SQL.Add('insert ignore into '+ Tablename +'  (No, ResourceName) Select (Select max(no) +1 from ' +Tablename +') , "Leave";');
    if devmode then
      Script.SQL.Add('insert into '+ Tablename +' (no)  Select nos.no from (' + nos +' ) nos left join '+ Tablename +'  T on nos.no = T.no  where ifnull(T.no,0)=0;');

    (*Script.SQL.Add('Alter table '+ TableName +' add column ResColor varchar(50);');
    Script.SQL.Add('Drop table if exists '+ Tablename +'1;');
    Script.SQL.Add('Create table '+ Tablename +'1 ' + colors +';');
    Script.SQL.Add('update '+Tablename + ' T inner join '+tablename+'1 as T1 on T.no = T1.no Set T.ResColor = T1.color;');
    Script.SQL.Add('Drop table if exists '+ Tablename +'1;');*)
    Script.Execute;
    Script.SQL.Clear;
  finally
    DbSharedObj.ReleaseObj(Script);
  end;
  QryREsources.SQL.Text := 'Select * from '+Tablename;
end;

function TfmEmpResProcRoster.MaxDateRange: TDateTime;
begin
  Result :=EmpResProcScheduleDays.Saturday;
end;

function TfmEmpResProcRoster.MinDateRange: TDateTime;
begin
  Result := EmpResProcScheduleDays.sunday;
end;

procedure TfmEmpResProcRoster.WriteGuiprefs;
begin
  GuiPrefs.Node['Options.RowHeight'].asInteger          := Planner.PositionWidth ;
  GuiPrefs.Node['EmpResProcScheduleDay'].asDatetime     := RosterSource.Day ;
  GuiPrefs.Node['Options.ResourceListvisible'].asBoolean:= grdResources.visible;
  //GuiPrefs.Node['Options.HeaderHeight'].asInteger       := Planner.header.height;
  GuiPrefs.Node['Options.Header.Height'].asInteger      := Planner.header.height ;
  GuiPrefs.Node['Options.Header.ItemHeight'].asInteger  := Planner.header.ItemHeight;
end;

Procedure  TfmEmpResProcRoster.NewItemProperty;
begin
  EmpResProcScheduleItemProperties  := TEmpResProcScheduleItem.Create;
  ItemProperties := TRosterBaseObj(EmpResProcScheduleItemProperties);
end;

procedure TfmEmpResProcRoster.OnDatechange(Sender: TObject);
begin
  inherited;
  Self.Repaint;
end;

procedure TfmEmpResProcRoster.OnDaySelect(Sender: TObject);
var
  dt:Tdatetime;
  fbIsDirty:boolean;
begin
  inherited;
  Case TDnmAction(Sender).tag of
    1: dt := EmpResProcScheduleDays.sunday;
    2: dt := EmpResProcScheduleDays.Monday;
    3: dt := EmpResProcScheduleDays.Tuesday;
    4: dt := EmpResProcScheduleDays.Wednesday;
    5: dt := EmpResProcScheduleDays.Thursday;
    6: dt := EmpResProcScheduleDays.Friday;
    7: dt := EmpResProcScheduleDays.SAturday;
    else Exit;
  End;
  if RosterDatePicker.StartDate <> dt then begin
    fbIsDirty:=EmpResProcSchedule.dirty;
    try
      if not IsFormReadOnly then if not Saverecord then exit;
      RosterDatePicker.StartDate := dt;
      RefreshSidebuttons(TDnmAction(Sender).tag);
    finally
      EmpResProcSchedule.Dirty := fbIsDirty;
    end;
  end;
end;
Procedure TfmEmpResProcRoster.RefreshSidebuttons(WeekdayNo:Integer);
begin
  if WeekdayNo <0 then exit;
  if  (WeekdayNo < high(Days))  then begin
    actNext.Caption := UpperCase(Buttons[WeekdayNo+1].Caption);
    actNext.Tag :=WeekdayNo+1;
  end else begin
    actNext.Caption := UpperCase(Buttons[Low(Days)].Caption);
    actNext.Tag :=Low(Days);
  end;

  if  WeekdayNo > Low(Days)  then begin
    actPrevious.Caption := UpperCase(Buttons[WeekdayNo-1].Caption);
    actPrevious.Tag :=WeekdayNo-1;
  end else begin
    actPrevious.Caption := UpperCase(Buttons[high(Days)].Caption);
    actPrevious.Tag :=high(Days);
  end;
  btnPrevious.Caption :=  SplitVertical('PREVIOUS DAY ' +actPrevious.caption);
  btnNext.Caption :=  SplitVertical('NEXT DAY '+ actNext.caption);
end;
Function TfmEmpResProcRoster.SplitVertical(const Value:String):String;
var
  ctr:Integer;
begin
  REsult := '';
  for ctr:= 1 to length(Value) do
    REsult := Result+copy(Value,ctr,1)+chr(13)+chr(10)(*+chr(13)+chr(10)*);
end;
procedure TfmEmpResProcRoster.OnDayupdate(Sender: TObject);
var
  ctr:Integer;
begin
  for ctr:= low(buttons)to high(buttons) do begin
    if RosterDatePicker.StartDate = Days[ctr] then begin
      buttons[ctr].Appearance.color := (*clNavy ;//*)$0040FF00;
      buttons[ctr].Appearance.colorMirror := (*clNavy ;//*)$0040FF00;
      Planner.Caption.Title := '                ' + TitleLabel.caption +'  : ' + buttons[ctr].Caption;
    end else begin
      buttons[ctr].Appearance.color := $00FF7575;//$00B0FFB0;
      buttons[ctr].Appearance.colorMirror := $00FF7575;//$00B0FFB0;
    end;
    buttons[ctr].Appearance.colorHot := $00FF7575;//$00B0FFB0;
    buttons[ctr].Appearance.colorHotTo := $00FF7575;//$00B0FFB0;
    buttons[ctr].Appearance.colorMirrorHot := $00FF7575;//$00B0FFB0;
    Buttons[ctr].Appearance.colorMirrorHotTo := $00FF7575;//$00B0FFB0;

  end;

end;

procedure TfmEmpResProcRoster.PlannerEnter(Sender: TObject);
begin
  inherited;
  if IsFormReadOnly then begin
    SetcontrolFocus(cmdCancel);
  end;
end;

procedure TfmEmpResProcRoster.PlannerItemMove(Sender: TObject;
  Item: TPlannerItem; FromBegin, FromEnd, FromPos, ToBegin, ToEnd,
  ToPos: Integer);
begin
  inherited;
  EmpResProcSchedule.Dirty := True;
end;

procedure TfmEmpResProcRoster.PlannerItemMoving(Sender: TObject;
  Item: TPlannerItem; DeltaBegin, DeltaPos: Integer; var Allow: Boolean);
begin
  inherited;
  Allow := not IsFormReadOnly;
end;

procedure TfmEmpResProcRoster.PlannerItemSelect(Sender: TObject;
  Item: TPlannerItem);
begin
  inherited;
  if Assigned(Item.ItemObject) then  EmpResProcScheduleItemProperties := TEmpResProcScheduleItem(Item.ItemObject);
  QryEmpProcesses.Locate('ProcessStepID;ResourceId;REsourceDetailID', vararrayof([EmpResProcScheduleItemProperties.ProcessStepID, EmpResProcScheduleItemProperties.ResourceId, EmpResProcScheduleItemProperties.REsourceDetailID]) , []);
  Item.ReadOnly := true;
  Item.Editor := nil;
end;

procedure TfmEmpResProcRoster.PlannerItemSize(Sender: TObject;
  Item: TPlannerItem; Position, FromBegin, FromEnd, ToBegin, ToEnd: Integer);
begin
  inherited;
  EmpResProcSchedule.Dirty := True;
end;
procedure TfmEmpResProcRoster.PlannerItemSizing(Sender: TObject;
  Item: TPlannerItem; DeltaBegin, DeltaEnd: Integer; var Allow: Boolean);
begin
  inherited;
  Allow := not IsFormReadOnly;
end;

procedure TfmEmpResProcRoster.PlannerItemStartEdit(Sender: TObject;
  Item: TPlannerItem);
begin
  inherited;
  if IsFormReadOnly then begin
    Abort;
  end;
end;

procedure TfmEmpResProcRoster.RefreshQryEmpProcesses(const empID:Integer);
begin
  CloseDB( QryEmpProcesses);
  QryEmpProcesses.ParamByName('employeeID').asInteger := empID;
  openDB( QryEmpProcesses);
end;
procedure TfmEmpResProcRoster.pnltopDblClick(Sender: TObject);
begin
  inherited;
  Planner.header.height := 100;
end;

procedure TfmEmpResProcRoster.popPlannerPopup(Sender: TObject);
var
  MenuItem : TMenuItem;
begin
  inherited;
  if Self.classnameis('TfmEmpResProcRoster') then begin
    popPlanner.Items.Clear;
    RefreshQryEmpProcesses(PlannerEmployeeId);
    if QryEmpProcesses.RecordCount =0 then exit;

    QryEmpProcesses.First;
    while QryEmpProcesses.Eof = False do begin
      MenuItem := TMenuItem.Create(self);
      MenuItem.Caption := QryEmpProcessesProcessStep.AsString +' : ' + iif(QryEmpProcessesREsourceDetailDescription.AsString <> '' , QryEmpProcessesREsourceDetailDescription.AsString ,  QryEmpProcessesResourceName.AsString) ;
      MenuItem.Tag := QryEmpProcessesrownum.AsInteger;
      MenuItem.enabled := not IsFormReadOnly;
      MenuItem.OnClick := PopupMenuHandler;
      popPlanner.Items.Add(MenuItem);
      QryEmpProcesses.Next;
    end;
  end;
end;

procedure TfmEmpResProcRoster.PopupMenuHandler(Sender: TObject);
begin
  inherited;
  Logit;
end;

procedure TfmEmpResProcRoster.QryRosterAfterInsert(DataSet: TDataSet);
begin
  inherited;
  NewItemProperty;
end;

procedure TfmEmpResProcRoster.QryRosterCalcFields(DataSet: TDataSet);
begin
  inherited;
  QryRosterNotes.asString := QryRosterProcessStep.asString +' :' ;
  if QryRosterREsourceDetailDescription.asString <> '' then QryRosterNotes.asString := QryRosterNotes.asString + QryRosterREsourceDetailDescription.AsString
  else QryRosterNotes.asString := QryRosterNotes.asString +  QryRosterResourceName.asString;
end;

procedure TfmEmpResProcRoster.RefreshQuery;
var
  fbIsDirty:boolean;
begin
  inherited;
  ProcessingCursor(true);
  Try
    fbIsDirty:=EmpResProcSchedule.dirty;
    try
      EmpResProcSchedule.closedb;
      LoadbusObj;
    finally
      EmpResProcSchedule.Dirty := fbIsDirty;
    end;
  Finally
    ProcessingCursor(False);
  End;
end;

procedure TfmEmpResProcRoster.RosterFieldsToItem(Sender: TObject;  Fields: TFields; Item: TPlannerItem);
begin
  inherited;
  item.Color :=  ResourceToLightcolor(EmpResProcScheduleItemProperties.ResourceID, EmpResProcScheduleItemProperties.ProcessStepId);
  item.CaptionBkg  :=  item.Color  ;
  item.CaptionBkgTo:=  item.Color ;
end;
Function TfmEmpResProcRoster.ResourceToDarkcolor(const REsourceID:Integer; ProcessStepID:Integer):TColor;
begin
  openDB(QryREsources);
  if (REsourceID<> 0) and  QryREsources.Locate('ProcResourceId;ProcessStepId' , vararrayof([REsourceID , ProcessStepID]), [] ) then
    REsult := Darkcolor(QryREsources.fieldbyname('no').AsInteger)
  else if (REsourceID= 0) and  QryREsources.Locate('ProcessStepId' , ProcessStepID, [] ) then
    REsult := Darkcolor(QryREsources.fieldbyname('no').AsInteger)
  else result := clwhite;

end;

Function TfmEmpResProcRoster.ResourceToLightcolor(const REsourceID:Integer; ProcessStepID:Integer):TColor;
begin
  openDB(QryREsources);
  if (REsourceID<> 0) and  QryREsources.Locate('ProcResourceId;ProcessStepId' , vararrayof([REsourceID , ProcessStepID]), [] ) then
    REsult := Lightcolor(QryREsources.fieldbyname('no').AsInteger)
  else if (REsourceID= 0) and (ProcessStepID<>0) and  QryREsources.Locate('ProcessStepId' , ProcessStepID,  [] ) then
    REsult := Lightcolor(QryREsources.fieldbyname('no').AsInteger)
  else result := clwhite;
end;
procedure TfmEmpResProcRoster.RosterItemToField(Sender: TObject;Fields: TFields; Item: TPlannerItem);
begin
  inherited;
  if assigned(Item.ItemObject) then begin
    EmpResProcScheduleItemProperties :=TEmpResProcScheduleItem(Item.ItemObject);
    RefreshQryEmpProcesses(EmpResProcScheduleItemProperties.EmployeeId);
    QryEmpProcesses.Locate('ProcessStepID;ResourceId;REsourceDetailID', vararrayof([TEmpResProcScheduleItem(Item.ItemObject).ProcessStepID, TEmpResProcScheduleItem(Item.ItemObject).ResourceId, TEmpResProcScheduleItem(Item.ItemObject).REsourceDetailID]) , []);
  end else begin
    if EmpResProcScheduleItemProperties  = nil then NewItemProperty;
  end;
  ItemToField(Item);
end;
procedure TfmEmpResProcRoster.ItemToField(Item: TPlannerItem);
begin
  if EmpResProcScheduleItemProperties  = nil then NewItemProperty;

  EmpResProcScheduleItemProperties.EmployeeId                 := GetEmployeeFromPosition(Item.ItemPos);
  EmpResProcScheduleItemProperties.WeekDayNo                  := DayOfWeek(Item.ItemStartTime);
  EmpResProcScheduleItemProperties.ProcessStepId              := QryEmpProcessesProcessStepID.AsInteger;
  EmpResProcScheduleItemProperties.ResourceID                 := QryEmpProcessesResourceId.AsInteger;
  EmpResProcScheduleItemProperties.ResourceDetailId           := QryEmpProcessesREsourceDetailID.AsInteger;
  EmpResProcScheduleItemProperties.TimeFrom                   := item.ItemStartTime;
  EmpResProcScheduleItemProperties.TimeTo                     := item.ItemEndTime;
  EmpResProcScheduleItemProperties.Active                     := TRue;

  EmpResProcSchedule.PlannerId        := EmpResProcScheduleItemProperties.PlannerId;
  EmpResProcSchedule.EmployeeId       := EmpResProcScheduleItemProperties.EmployeeId;
  EmpResProcSchedule.WeekDayNo        := EmpResProcScheduleItemProperties.WeekDayNo;;
  EmpResProcSchedule.ProcessStepId    := EmpResProcScheduleItemProperties.ProcessStepId;
  EmpResProcSchedule.ResourceID       := EmpResProcScheduleItemProperties.ResourceID;
  EmpResProcSchedule.ResourceDetailId := EmpResProcScheduleItemProperties.ResourceDetailId;
  EmpResProcSchedule.TimeFrom         := EmpResProcScheduleItemProperties.TimeFrom;
  EmpResProcSchedule.TimeTo           := EmpResProcScheduleItemProperties.TimeTo;
  EmpResProcSchedule.Active           := EmpResProcScheduleItemProperties.Active;

  end;

procedure TfmEmpResProcRoster.RosterSourcePositionToResource(Sender: TObject;
  Field: TField; Position: Integer);
begin
  inherited;
  if EmpResProcScheduleItemProperties <> nil then begin
    EmpResProcScheduleItemProperties.PlannerId  := EmpResProcSchedule.PlannerId;
    EmpResProcScheduleItemProperties.EmployeeId := GetEmployeeFromPosition(Position);
  end;
end;

procedure TfmEmpResProcRoster.RosterSourceResourceToPosition(Sender: TObject;
  Field: TField; var Position: Integer; var Accept: Boolean);
begin
  inherited;
  Position := -1;
  if isinteger(field.asString) then
    Position := GetPositionFromEmployee(strToInt(field.asString));
  Accept := Position <= QryProcessEmployees.RecordCount;
end;

function TfmEmpResProcRoster.SaveRecord: Boolean;
begin
  AllrecsValid := True;
  if EmpResProcSchedule.dirty then  EmpResProcSchedule.IterateRecords(SaveRecordCallback, True);
  Result := AllrecsValid;
end;
Procedure TfmEmpResProcRoster.SaveRecordCallback(Const Sender: TBusObj; var Abort: Boolean);
begin
  if not (Sender is TEmpResProcRoster) then exit;
  AllrecsValid := inherited  SaveRecord;
  if not AllrecsValid then Abort := True;
end;
function TfmEmpResProcRoster.StartDate: TDateTime;
begin
       if IsSunday    (Date) then   Result := EmpResProcScheduleDays.Sunday
  else if IsMonday    (Date) then   Result := EmpResProcScheduleDays.Monday
  else if IsTuesday   (Date) then   Result := EmpResProcScheduleDays.Tuesday
  else if IsWednesday (Date) then   Result := EmpResProcScheduleDays.Wednesday
  else if IsThursday  (Date) then   Result := EmpResProcScheduleDays.Thursday
  else if IsFriday    (Date) then   Result := EmpResProcScheduleDays.Friday
  else if IsSaturday  (Date) then   Result := EmpResProcScheduleDays.Saturday
  else Result := EmpResProcScheduleDays.Sunday;
end;


{ TEmpResProcScheduleItem }

procedure TEmpResProcScheduleItem.setResourceID(const Value: Integer);
begin
  fiResourceID := Value;
end;

initialization
  RegisterClassOnce(TfmEmpResProcRoster);

end.
