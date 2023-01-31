unit frmEmpResProcRosternSchedule;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  DAScript, MyScript, ERPdbComponents, DB,
  SelectionDialog, kbmMemTable, CustomInputBox, Menus, AdvMenus, ProgressDialog,
  DBAccess, MyAccess, MemDS, wwDialog, Wwlocate, ExtCtrls, ActnList, PrintDAT,
  ImgList, AdvOfficeStatusBar, StdCtrls, Buttons, Wwdbigrd, Grids, Wwdbgrid,
  wwdbdatetimepicker, wwcheckbox, wwdblook, DNMSpeedButton, Shader, DNMPanel , BusobjEmpResProcSchedule , frmEmpResProcRoster,
  DNMAction, DBPlanner, DataState, AppEvnts, AdvGlowButton, Planner, BusObjBase , frmEmpResProcRosternScheduleConfig , IntegerListObj,
  ComCtrls, DataSourcePrefs, wwradiogroup, wwclearbuttongroup;

type

  TEmpResProcRosternSchedule = class(TEmpResProcRoster)
    Private
      Tablename:String;
      fdDateFrom: TDatetime;
      fdDateTo: TDatetime;
      fSQLList:TStringlist;

      procedure ScriptBeforeExecute(Sender: TObject; var SQL: string;var Omit: Boolean);
      function  GetrosterId      : Integer   ;
      function  GetScheduleID    : Integer   ;
      function  GetSeqno         : Integer   ;
      function  GetLeaveID       : Integer   ;
      function  GetupdateSeqno   : Integer   ;
      Function  GetDescription   : String;
      Function  GetSubject   : String;
      function  GetProcessPartID : Integer   ;
      procedure SetrosterId      (const Value: Integer);
      procedure SetScheduleID    (const Value: Integer);
      procedure SetSeqno         (const Value: Integer);
      procedure SetLeaveID       (const Value: Integer);
      procedure SetupdateSeqno   (const Value: Integer);
      Procedure SetDescription   (Const Value: String);
      Procedure SetSubject   (Const Value: String);
      procedure SetProcessPartID (const Value: Integer);
      function getIsChanged: Boolean;
      function getDeleted: Boolean;
      procedure SetIsChanged(const Value: Boolean);
      procedure SetDeleted(const Value: Boolean);
    Protected
    Public
      constructor   Create(AOwner :TComponent);override;
      Destructor    Destroy;Override;
      procedure     Load(const fIsReadonly:boolean =False); Override;
      function      SQLList :TStringlist;

      Property DateFrom     :TDatetime  read fdDateFrom       write fdDateFrom      ;
      Property DateTo       :TDatetime  read fdDateTo         write fdDateTo        ;
      property rosterId     :Integer    read getrosterId      write setrosterId     ;
      property ScheduleID   :Integer    read getScheduleID    write setScheduleID   ;
      property Seqno        :Integer    read getSeqno         write setSeqno        ;
      property LeaveID      :Integer    read getLeaveID       write setLeaveID      ;
      property updateSeqno  :Integer    read getupdateSeqno   write setupdateSeqno  ;
      Property Description  :String     read getDescription   write setDescription  ;
      Property Subject  :String     read getSubject   write setSubject  ;
      property ProcessPartID:Integer    read getProcessPartID write setProcessPartID;
      Property IsChanged    :Boolean    read getIsChanged     write SetIsChanged    ;
      Property Deleted      :Boolean    read getDeleted       write SetDeleted      ;
  end;

  TfmEmpResProcScheduleVsRoster = class(TfmEmpResProcRoster)
    DNMSpeedButton1: TDNMSpeedButton;
    cmdPrint: TDNMSpeedButton;
    PlannerMonth: TDBPlanner;
    QryRosterSeqno: TIntegerField;
    QryRosterLeaveID: TIntegerField;
    QryRosterupdateSeqno: TIntegerField;
    QryRosterSaleID: TIntegerField;
    QryRostersaleLineId: TIntegerField;
    QryRosterProductName: TWideStringField;
    QryRosterCustomerName: TWideStringField;
    QryRostershipped: TFloatField;
    QryRosterUOM: TWideStringField;
    QryRosterShipDate: TDateTimeField;
    QryRosterrosterId: TIntegerField;
    QryRosterScheduleID: TIntegerField;
    QryRosterProcessPartID: TIntegerField;
    QryRosterDescription: TWideStringField;
    QryRosterIsChanged: TWideStringField;
    QryRosterDeleted: TWideStringField;
    TabMonthly: TTabSheet;
    dsMonthRoster: TDataSource;
    MonthRosterSource: TDBWeekSource;
    grpFilters: TwwRadioGroup;
    TabWeekly: TTabSheet;
    PlannerWeek: TDBPlanner;
    dsWeekRoster: TDataSource;
    WeekRosterSource: TDBTimeLineSource;
    QryRosterSubject: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure RosterFieldsToItem(Sender: TObject; Fields: TFields;
      Item: TPlannerItem);
    procedure grpFiltersClick(Sender: TObject);
    procedure QryRosterCalcFields(DataSet: TDataSet);
    procedure DNMSpeedButton1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PlannerItemMove(Sender: TObject; Item: TPlannerItem; FromBegin,
      FromEnd, FromPos, ToBegin, ToEnd, ToPos: Integer);
    procedure PlannerItemSize(Sender: TObject; Item: TPlannerItem; Position,
      FromBegin, FromEnd, ToBegin, ToEnd: Integer);
    procedure QryRosterBeforeDelete(DataSet: TDataSet);
    procedure cmdPrintClick(Sender: TObject);
    procedure PlannerItemMoving(Sender: TObject; Item: TPlannerItem; DeltaBegin,
      DeltaPos: Integer; var Allow: Boolean);
    procedure pgeRostersChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    fEmpResProcRosternSchedule: TEmpResProcRosternSchedule;
    fAllocatedTimeSlotDetails : TAllocatedTimeSlotDetails;
    DelectedScheduleIDs:TIntegerlist;
    CleanDate :TDateTime;
    //DateRangeSelector : TDateRangeSelector;
    function filterdatefrom:TdateTime;
    Function filterDateto:TdateTime;
    function Show_Status :Boolean;
    function ShowSaleID  :Boolean;
    function ShowProduct :Boolean;
    function ShowCustomer:Boolean;
    function showShipDate:Boolean;
    function showManQty  :Boolean;
    function showDuration:Boolean;
    function showLineFeed:Boolean;


  Protected
    Procedure MakeBusObj;Override;
    Procedure LoadBusObj;Override;
    Function MinDateRange:TDateTime; Override;
    Function MaxDateRange:TDateTime;Override;
    function StartDate:TDateTime; Override;
    Procedure InitItemProperties(Fields: TFields);Override;
    procedure ItemToField(Item: TPlannerItem);Override;
    Procedure SaveRecordCallback(Const Sender: TBusObj; var Abort: Boolean);Override;
    function SaveRecord: Boolean;Override;
    Procedure ReadGuiprefs;Override;
    Procedure WriteGuiprefs;Override;
    Procedure DoOnDelete(Item:TPlannerItem);Override;
    procedure OnDatechange(Sender: TObject);Override;
    procedure ReadOnlyAccess(const Value: Boolean);Override;
    function PlannerEmployeeId:Integer;Override;
    Procedure InitPlanner;Override;
  public
    Procedure RefreshQuery;Overload;Override;
    Procedure RefreshQuery(Sender:TObject);reintroduce;Overload;
  end;

implementation

uses CommonDbLib, DbSharedObjectsObj , DateUtils, MySQLConst, CommonLib,
  tcConst, LogLib, ManufactureLib, frmRosterDatePicker;

{$R *.dfm}

{ TEmpResProcRosternSchedule }
function  TEmpResProcRosternSchedule.GetrosterId      : Integer   ; begin Result := GetIntegerField('rosterId');end;
function  TEmpResProcRosternSchedule.GetScheduleID    : Integer   ; begin Result := GetIntegerField('ScheduleID');end;
function  TEmpResProcRosternSchedule.GetSeqno         : Integer   ; begin Result := GetIntegerField('Seqno');end;
function  TEmpResProcRosternSchedule.GetLeaveID       : Integer   ; begin Result := GetIntegerField('LeaveID');end;
function  TEmpResProcRosternSchedule.GetupdateSeqno   : Integer   ; begin Result := GetIntegerField('updateSeqno');end;
function  TEmpResProcRosternSchedule.GetDescription   : String    ; begin Result := GetStringField('Description');end;
function  TEmpResProcRosternSchedule.GetSubject   : String    ; begin Result := GetStringField('Subject');end;
function  TEmpResProcRosternSchedule.GetProcessPartID : Integer   ; begin Result := GetIntegerField('ProcessPartID');end;
function  TEmpResProcRosternSchedule.getIsChanged     : Boolean   ; begin REsult := GetBooleanfield('IsChanged');end;
function  TEmpResProcRosternSchedule.getDeleted       : Boolean   ; begin REsult := GetBooleanfield('Deleted');end;
procedure TEmpResProcRosternSchedule.SetrosterId      (const Value: Integer); begin SetIntegerField('rosterId'     , Value);end;
procedure TEmpResProcRosternSchedule.SetScheduleID    (const Value: Integer); begin SetIntegerField('ScheduleID'   , Value);end;
procedure TEmpResProcRosternSchedule.SetSeqno         (const Value: Integer); begin SetIntegerField('Seqno'        , Value);end;
procedure TEmpResProcRosternSchedule.SetLeaveID       (const Value: Integer); begin SetIntegerField('LeaveID'      , Value);end;
procedure TEmpResProcRosternSchedule.SetupdateSeqno   (const Value: Integer); begin SetIntegerField('updateSeqno'  , Value);end;
procedure TEmpResProcRosternSchedule.SetDescription   (const Value: String ); begin SetStringField('Description'   , Value);end;
procedure TEmpResProcRosternSchedule.SetSubject   (const Value: String ); begin SetStringField('Subject'   , Value);end;
procedure TEmpResProcRosternSchedule.SetIsChanged     (const Value: Boolean); begin SetBooleanfield('IsChanged'    , Value);end;
procedure TEmpResProcRosternSchedule.SetDeleted       (const Value: Boolean); begin SetBooleanfield('Deleted'      , Value);end;
procedure TEmpResProcRosternSchedule.SetProcessPartID (const Value: Integer); begin SetIntegerField('ProcessPartID', Value);end;

function TEmpResProcRosternSchedule.SQLList: TStringlist;
begin
  if fSQLList = nil then fSQLList:= TStringlist.Create;
  REsult := fSQLList;
end;
constructor TEmpResProcRosternSchedule.Create(AOwner: TComponent);
begin
  fSQLList:=nil;
  Tablename := commondblib.GetUserTemporaryTableName('ResProcSchnroster');
  inherited;
  fSQL:='Select * from '+tablename +' Order by Seqno';
end;

destructor TEmpResProcRosternSchedule.Destroy;
begin
  if fSQLList<> nil then Freeandnil(fSQLList);
  DestroyUserTemporaryTable(Tablename);
  inherited;
end;



procedure TEmpResProcRosternSchedule.Load(const fIsReadonly:boolean =False);
var
  script :TERPScript;
  s:String;
  fd:TDatetime;
begin
  script := DbSharedObj.GetScript(connection.Connection);
  try
    fd:= DAteFrom;
    s:= '';
    script.SQL.clear;
    script.SQL.add('Drop table if exists ' + Tablename +';');
    script.SQL.add('CREATE TABLE `' + Tablename  + '` ( '+
            ' `ID` int(11) NOT NULL AUTO_INCREMENT, '+
            ' Seqno int(11), '+
            ' LeaveID int(11), '+
            ' updateSeqno int(11), '+
            ' SaleID int(11), '+
            ' saleLineId int(11) , '+
            ' ProductName varchar(255), '+
            ' CustomerName varchar(255), '+
            ' shipped double, '+
            ' UOM varchar(255) , '+
            '`ShipDate` datetime DEFAULT NULL , '+
            ' `rosterId` int(11) DEFAULT NULL, '+
            ' `ScheduleID` int(11) DEFAULT NULL, '+
            ' `GlobalRef` varchar(255) DEFAULT NULL, '+
            ' `ProcessPartID` int(11) DEFAULT NULL, '+
            ' `PlannerId` varchar(255) DEFAULT NULL, '+
            ' `employeeId` int(11) DEFAULT NULL, '+
            ' `WeekDayNo` int(11) DEFAULT NULL, '+
            ' `ProcessStepId` int(11) NOT NULL DEFAULT "0", '+
            ' `ResourceID` int(11) DEFAULT NULL, '+
            ' `ResourceDetailId` int(11) DEFAULT NULL, '+
            ' `timefrom` datetime DEFAULT NULL, '+
            ' `timeto` datetime DEFAULT NULL, '+
            ' Description varchar(255), '+
            ' Subject varchar(255), '+
            ' `msTimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP, '+
            ' `msUpdateSiteCode` varchar(3) DEFAULT "", '+
            ' `Active` Enum("T","F") NOT NULL DEFAULT "T" ,'+
            ' `IsChanged` Enum("T","F") NOT NULL DEFAULT "F" ,'+
            ' `Deleted` Enum("T","F") NOT NULL DEFAULT "F" ,'+
            ' PRIMARY KEY (`ID`)) ENGINE=MyISAM DEFAULT CHARSET=utf8 ;');

   {weekly roster}
    While fd<= DateTo do begin
      script.SQL.add('insert ignore into ' + Tablename  + ' (Subject ,  Seqno , rosterId,ScheduleID,GlobalRef,ProcessPartID,PlannerId,employeeId,WeekDayNo,ProcessStepId,ResourceID,ResourceDetailId,timefrom,timeto,Active)   '+
            ' Select distinct '+
            ' "Roster" as Subject ,  1, ER.ID rosterId , null as ScheduleID, ER.GlobalRef, null as ProcessPartID, ER.PlannerId, ER.employeeId, ER.WeekDayNo , ER.ProcessStepId, ER.ResourceID, ER.ResourceDetailId, '+
            ' DAte_add(ER.timefrom,  interval  DateDiff( ' +quotedstr(formatDateTime(MysQLDateTimeformat, fd))+', timefrom) day) timefrom, '+
            ' DAte_add(ER.TimeTo,  interval  DateDiff( ' +quotedstr(formatDateTime(MysQLDateTimeformat, fd))+', timefrom) day) timeto, '+
            ' ER.Active '+
            ' from  tblempresprocschedule ER '+
            ' where ER.WeekDayNo = DAYOFWEEK(' +quotedstr(formatDateTime(MysQLDateTimeformat, fd))+');') ;
      fd:= incDay(fd);
    end;
    {Leaves}
    script.SQL.add('insert ignore into ' + Tablename  + ' ( Subject , Seqno, Description , rosterId,ScheduleID,GlobalRef,ProcessPartID,PlannerId,employeeId,WeekDayNo,ProcessStepId,ResourceID,ResourceDetailId,timefrom,timeto,Active)   '+
                    ' sELECT "Leave" Subject ,  3, R.TYPE , RosterID, null as ScheduleID, R.GlobalRef , null as ProcessPartID , R.PlannerID as PlannerId , R.EmployeeID as employeeId ,'+
                    ' DayofWeek(R.StartTime) as Weekdayno , null as ProcessStepId , null as ResourceID, null as ResourceDetailId, R.StartTime as timefrom, R.EndTime as timeto ,"T"'+
                    ' FROM tblroster R'+
                    ' inner join tblemployeeprocesssteps E on R.EmployeeID = E.employeeID '+
                    ' WHERE (R.TYPE IN (' + Leaves(true) +') or TYPE in ('+ Quotedstr(UNAVAILABLE)+'))'+
                    ' and (R.StartTime >=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, Datefrom))+'and  R.StartTime <=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, DAteTo))+') or '+
                          ' (R.EndTime   >=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, Datefrom))+'and  R.EndTime   <=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, DAteTo))+') or '+
                          ' (R.StartTime <=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, Datefrom))+'and  R.EndTime   >=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, DAteTo))+');');

    {schedules}
    script.SQL.add('insert ignore into ' + Tablename  + ' ( Subject , Seqno , rosterId,SaleId, saleLineId, ProductNAme, CustomerName, shipped ,uom, shipDate ,  ScheduleID,GlobalRef,ProcessPartID,PlannerId,employeeId,WeekDayNo,ProcessStepId,ResourceID,ResourceDetailId,timefrom,timeto,Active)   '+
            ' Select "Job Schedule" Subject , 2, null as rosterId,  SL.SaleID, SL.SaleLineID , SL.ProductName,S.CustomerName,'+
            'SL.UnitofMeasureShipped as Shipped, concat(SL.UnitofMeasureSaleLines , " (" , SL.UnitofMeasureMultiplier , ")") as UOM,if(ifnull(SL.ShipDate,0)=0, S.shipdate, Sl.shipdate), '+
            'Pt.ProcesstimeID as ScheduleID, Pt.Globalref , Pt.ProcessPartID, if(ifnull(Pt.Globalref,"")<>"" , PT.Globalref ,Pt.ProcesstimeID) as PlannerId ,Pt.EmployeeId, '+
            ' DayofWeek(Pt.Timestart) as Weekdayno , '+
            ' PP.ProcessStepID, PD.ProcResourceId, Pt.ResourcedetailsID, Pt.TimeStart timefrom,  DATE_ADD(Pt.TimeStart,INTERVAL Pt.Duration second) timeto,  Pt.Active '+
            ' from tblprocesstime Pt  '+
            ' Left join tblprocresourcedetails PD on Pt.ResourcedetailsID = PD.ID  '+
            ' inner join tblprocesspart PP on Pt.ProcesspartId = PP.ID '+
            ' inner join tblproctree PR on PP.proctreeId = Pr.ProcTreeId and Pr.MasterType <> "mtProduct" '+
            ' inner join tblsaleslines SL on Pr.MasterId = SL.SaleLineID '+
            ' inner join tblsales S on S.saleId = SL.saleId '+
            ' Where (Pt.TimeStart >=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, Datefrom))+'and  Pt.TimeStart <=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, DAteTo))+') or '+
                  ' (Pt.TimeEnd   >=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, Datefrom))+'and  Pt.TimeEnd   <=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, DAteTo))+') or '+
                  ' (Pt.TimeStart <=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, Datefrom))+'and  Pt.TimeEnd   >=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, DAteTo))+');');


    {Resource Unavailability}
    script.SQL.add('insert ignore into ' + Tablename  + ' ( Subject , Seqno, Description , rosterId,ScheduleID,GlobalRef,ProcessPartID,PlannerId,employeeId,WeekDayNo,ProcessStepId,ResourceID,ResourceDetailId,timefrom,timeto,Active)   '+
                    ' sELECT distinct "Res Un-Available" Subject , 4, R.Description , R.ProcResourceUnAvailabilityId rosterId ,  null as ScheduleID, R.GlobalRef ,    '+
                    ' null as ProcessPartID , R.Globalref as PlannerId ,  ES.employeeId as employeeId , DayofWeek(R.TimeStart) as Weekdayno ,    '+
                    ' ES.ProcessStepId as ProcessStepId , R.ProcResourceId as ResourceID,  R.ProcResourceDetailId as ResourceDetailId, R.TimeStart as timefrom,    '+
                    ' R.TimeEnd as timeto ,"T"      '+
                    ' from tblprocresourceunavailability R '+
                    ' inner join tblempresprocschedule ES on R.ProcResourceDetailId = ES.ResourceDetailId  and ES.WeekDayNo = DAYOFWEEK(R.TimeStart) '+
                    ' WHERE (R.TimeStart >=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, Datefrom))+'and  R.TimeStart <=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, DAteTo))+') or '+
                          ' (R.TimeEnd   >=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, Datefrom))+'and  R.TimeEnd   <=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, DAteTo))+') or '+
                          ' (R.TimeStart <=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, Datefrom))+'and  R.TimeEnd   >=  ' +quotedstr(formatDateTime(MysQLDateTimeformat, DAteTo))+');');


    {Leaves}
    script.SQL.add('drop table if exists '+Tablename+'1;');
    script.SQL.add('Create table '+Tablename+'1 '+
                    ' Select * from '+Tablename+' where Seqno =3;');


    {LeaveFrom..Schedule From..Schedule To..Leave To}
    script.SQL.add('update '+Tablename+' T inner join '+Tablename+'1 Leaves on T.employeeId = Leaves.employeeId  and T.Seqno =2 '+
                    ' Set T.LeaveID = Leaves.ID , T.updateSeqno =1 '+
                    '  where  Leaves.timefrom <= T.timefrom and T.TimeTo <= Leaves.timeTo ;');


   (*  {Resource Unavailability}
    script.SQL.add('drop table if exists '+Tablename+'1;');
    script.SQL.add('Create table '+Tablename+'1 '+
                    ' Select * from '+Tablename+' where Seqno =4;');


    {LeaveFrom..Schedule From..Schedule To..Leave To}
    script.SQL.add('update '+Tablename+' T inner join '+Tablename+'1 Leaves on T.employeeId = Leaves.employeeId  and T.Seqno =2 '+
                    ' Set T.updateSeqno =6 '+
                    '  where  Leaves.timefrom <= T.timefrom and T.TimeTo <= Leaves.timeTo ;');*)


    {Schedule From..LeaveFrom..Leave To..Schedule To}
    script.SQL.add('drop table if exists '+Tablename+'2;');
    script.SQL.add('create table '+Tablename+'2 '+
                    ' select '+
                    ' Schedule.*, Schedule.TimeFrom time1, Leaves.timefrom time2, Leaves.timeTo time3, Schedule.TimeTo time4 '+
                    ' from '+Tablename+' Schedule inner join '+Tablename+'1 Leaves on Schedule.employeeId = Leaves.employeeId  and Schedule.Seqno =2 '+
                    ' where ifnull(Schedule.updateSeqno,0) =0 and ifnull(Schedule.LeaveID,0)=0 '+
                    ' and  Schedule.timefrom<= Leaves.timefrom and  Leaves.timeTo <= Schedule.TimeTo;');


    script.SQL.add('update '+Tablename+' T inner join '+Tablename+'2 T2 on T.ID = T2.ID '+
                    ' Set T.Timefrom = Time2,  T.timeTo = t2.Time3 ,T.LeaveId = T2.Id,  T.updateSeqno =2;');


    script.SQL.add('insert ignore into '+Tablename+' '+
                    ' (updateSeqno, Seqno ,SaleID ,saleLineId ,ProductName ,CustomerName ,shipped ,UOM ,ShipDate,rosterId,ScheduleID, '+
                    ' GlobalRef,ProcessPartID,PlannerId,employeeId,WeekDayNo,ProcessStepId,ResourceID,ResourceDetailId,timefrom,timeto, '+
                    ' Description ,Active,IsChanged,Deleted,LeaveID, mstimeStamp,msUpdateSiteCode) '+
                    ' Select 3, Seqno ,SaleID ,saleLineId ,ProductName ,CustomerName ,shipped ,UOM ,ShipDate,rosterId,ScheduleID, '+
                    ' GlobalRef,ProcessPartID,concat(PlannerId,"-",ID) as PlannerID,employeeId,WeekDayNo,ProcessStepId,ResourceID,ResourceDetailId, '+
                    ' time1 as timefrom,time2 as timeto,Description ,Active,IsChanged,Deleted,null as LeaveID, mstimeStamp,msUpdateSiteCode from '+Tablename+'2;');

    script.SQL.add('insert ignore into '+Tablename+' '+
                    ' (updateSeqno, Seqno ,SaleID ,saleLineId ,ProductName ,CustomerName ,shipped ,UOM ,ShipDate,rosterId,ScheduleID, '+
                    ' GlobalRef,ProcessPartID,PlannerId,employeeId,WeekDayNo,ProcessStepId,ResourceID,ResourceDetailId,timefrom, '+
                    ' timeto,Description ,Active,IsChanged,Deleted,LeaveID, mstimeStamp,msUpdateSiteCode) '+
                    ' Select 4, Seqno ,SaleID ,saleLineId ,ProductName ,CustomerName ,shipped ,UOM ,ShipDate,rosterId,ScheduleID, '+
                    ' GlobalRef,ProcessPartID,concat(PlannerId,"-",ID) as PlannerID,employeeId,WeekDayNo,ProcessStepId,ResourceID,ResourceDetailId, '+
                    ' time3 as timefrom,time4 as timeto,Description ,Active,IsChanged,Deleted,null as LeaveID, mstimeStamp,msUpdateSiteCode from '+Tablename+'2;');


    {LeaveFrom.. Schedule From..Leave To..Schedule To}
    script.SQL.add('drop table if exists '+Tablename+'2;');
    script.SQL.add('create table '+Tablename+'2 '+
                    ' select '+
                    ' Schedule.*, Leaves.timeFrom Time1, Schedule.TimeFrom time2, Leaves.timeto time3, Leaves.TimeTo time4 '+
                    ' from '+Tablename+' Schedule inner join '+Tablename+'1 Leaves on Schedule.employeeId = Leaves.employeeId  and Schedule.Seqno =2 '+
                    ' where ifnull(Schedule.updateSeqno ,0)=0 and ifnull(Schedule.LeaveID,0)=0  '+
                    ' and  Leaves.timefrom < Schedule.timefrom  and Schedule.Timefrom <  Leaves.timeTo  and Schedule.timeTo >Leaves.timefrom  and Schedule.TimeTo >  Leaves.timeTo ;');


    script.SQL.add('update '+Tablename+' T inner join '+Tablename+'2 T2 on T.ID = T2.ID '+
                    ' Set T.updateSeqno = 5, T.timeTo = t2.Time3, T.LeaveId = T2.Id;');



    script.SQL.add('insert ignore into '+Tablename+' '+
                    ' (updateSeqno , Seqno ,SaleID ,saleLineId ,ProductName ,CustomerName ,shipped ,UOM ,ShipDate,rosterId,ScheduleID, '+
                    ' GlobalRef,ProcessPartID,PlannerId,employeeId,WeekDayNo,ProcessStepId,ResourceID,ResourceDetailId,timefrom,timeto, '+
                    ' Description ,Active,IsChanged,Deleted,LeaveID, mstimeStamp,msUpdateSiteCode) '+
                    ' Select 6, Seqno ,SaleID ,saleLineId ,ProductName ,CustomerName ,shipped ,UOM ,ShipDate,rosterId,ScheduleID, '+
                    ' GlobalRef,ProcessPartID,concat(PlannerId,"-",ID) as PlannerID,employeeId,WeekDayNo,ProcessStepId,ResourceID,ResourceDetailId, '+
                    ' time3 as timefrom,time4 as timeto,Description ,Active,IsChanged,Deleted,null as LeaveID, mstimeStamp,msUpdateSiteCode from '+Tablename+'2;');




    {Schedule From..LeaveFrom..Schedule To.. Leave To}
    script.SQL.add('drop table if exists '+Tablename+'2;');
    script.SQL.add('create table '+Tablename+'2 '+
                    ' select '+
                    ' Schedule.*, Schedule.TimeFrom time1, Leaves.timefrom time2, Schedule.timeto time3, Leaves.TimeTo time4 '+
                    ' from '+Tablename+' Schedule inner join '+Tablename+'1 Leaves on Schedule.employeeId = Leaves.employeeId  and Schedule.Seqno =2 '+
                    ' where ifnull(Schedule.updateSeqno,0)=0 and  ifnull(Schedule.LeaveID,0)=0  '+
                    ' and  Schedule.timefrom<  Leaves.timefrom and Schedule.Timeto > Leaves.TimeFrom  and Schedule.TimeTo <  Leaves.timeTo ;');


    script.SQL.add('update '+Tablename+' T inner join '+Tablename+'2 T2 on T.ID = T2.ID '+
                    ' Set T.updateSeqno = 7, T.timeTo = t2.Time2;');


    script.SQL.add('insert ignore into '+Tablename+' '+
                    ' (updateSeqno, Seqno ,SaleID ,saleLineId ,ProductName ,CustomerName ,shipped ,UOM ,ShipDate,rosterId,ScheduleID, '+
                    ' GlobalRef,ProcessPartID,PlannerId,employeeId,WeekDayNo,ProcessStepId,ResourceID,ResourceDetailId,timefrom,timeto, '+
                    ' Description ,Active,IsChanged,Deleted,LeaveID, mstimeStamp,msUpdateSiteCode) '+
                    ' Select 8, Seqno ,SaleID ,saleLineId ,ProductName ,CustomerName ,shipped ,UOM ,ShipDate,rosterId,ScheduleID, '+
                    ' GlobalRef,ProcessPartID,concat(PlannerId,"-",ID) as PlannerID,employeeId,WeekDayNo,ProcessStepId,ResourceID,ResourceDetailId, '+
                    ' time2 as timefrom,time3 as timeto,Description ,Active,IsChanged,Deleted,Id as LeaveID, mstimeStamp,msUpdateSiteCode from '+Tablename+'2;');

    script.SQL.add('drop table if exists '+Tablename+'2;');
    script.SQL.add('drop table if exists '+Tablename+'1;');

    script.SQL.add('delete from '+Tablename+' where timefrom = timeto;');



    Script.BeforeExecute:= ScriptBeforeExecute;
    try
      doShowProgressbar(Script.SQL.count , WaitMSG);
      try
        clog(Script.SQL.text);
        script.Execute;
      finally
        DoHideProgressbar;
      end;
    finally
      Script.BeforeExecute := nil;
    end;
  finally
    DbSharedObj.ReleaseObj(Script);
  end;
  closedb;
  inherited Load(fIsReadonly);
end;

{ TfmEmpResProcScheduleVsRoster }

procedure TEmpResProcRosternSchedule.ScriptBeforeExecute(Sender: TObject;
  var SQL: string; var Omit: Boolean);
begin
  inherited;
  DoStepProgressbar;
end;

procedure TfmEmpResProcScheduleVsRoster.cmdPrintClick(Sender: TObject);
begin
  inherited;
  Planner.Print;
end;

procedure TfmEmpResProcScheduleVsRoster.DNMSpeedButton1Click(Sender: TObject);
begin
  inherited;
  if TfmEmpResProcRosternScheduleConfig.DoAllocatedTimeSlotDetails(fAllocatedTimeSlotDetails) then
    onDateChange(nil);
end;

procedure TfmEmpResProcScheduleVsRoster.DoOnDelete(Item: TPlannerItem);
begin
  inherited;
      if fEmpResProcRosternSchedule.PlannerId =  TEmpResProcScheduleItem(Item.ItemObject).PlannerId then begin
        fEmpResProcRosternSchedule.IsChanged := True;
        fEmpResProcRosternSchedule.Deleted := true;
        fEmpResProcRosternSchedule.PostDB;
      end;
end;
Procedure TfmEmpResProcScheduleVsRoster.OnDatechange (Sender:TObject);
begin
  if Assigned(fEmpResProcRosternSchedule) then
    if fEmpResProcRosternSchedule.Dirty then begin
      if not SaveRecord then begin
        RosterDatePicker.StartDate :=CleanDate;
        Exit;
      end;
    end;
  if pgeRosters.ActivePage = TabMonthly then begin
    MonthRosterSource.Month := MonthOfTheYear(FilterdateFrom);
    MonthRosterSource.Year := YearOf(FilterdateFrom);
    Dtfrom := RosterDatePicker.StartDate;
    DtTo   := RosterDatePicker.EndDate;
    RefreshQuery;
  end else  if pgeRosters.ActivePage = TabWeekly then begin
    WeekRosterSource.StartDAte := FilterdateFrom;
    WeekRosterSource.Enddate := FilterdateTo;
    Dtfrom := RosterDatePicker.StartDate;
    DtTo   := RosterDatePicker.EndDate;
    RefreshQuery;
end else begin
    inherited;
  end;
  CleanDate := RosterDatePicker.StartDate;
end;
procedure TfmEmpResProcScheduleVsRoster.pgeRostersChange(Sender: TObject);
begin
  RosterSource.Active     := False;
  MonthRosterSource.Active := False;
  WeekRosterSource.Active := False;
  inherited;
  if pgeRosters.ActivePage = TabMonthly then begin
    RosterDatePicker.DateMode := tdmMonthly;
  end else if pgeRosters.ActivePage = TabWeekly then begin
    RosterDatePicker.DateMode := tdmWeekly;
  end;
  if isformShown then begin
      if pgeRosters.ActivePage = TabMonthly then begin
        PlannerMonth.Mode.PeriodStartDay   :=  Dayof(Filterdatefrom);
        PlannerMonth.Mode.PeriodStartMonth := Monthof(Filterdatefrom);
        PlannerMonth.Mode.PeriodStartYear  := Yearof(Filterdatefrom);

        PlannerMonth.Mode.PeriodEndDay     := Dayof(Filterdateto);
        PlannerMonth.Mode.PeriodEndMonth   := Monthof(Filterdateto);
        PlannerMonth.Mode.PeriodEndYear    := Yearof(Filterdateto);
        PlannerMonth.Mode.TimeLineStart    := filterdatefrom;
        PlannerMonth.Mode.Year             := Yearof(Filterdateto);
        PlannerMonth.Mode.Weekstart        := DayoftheWeek(Filterdatefrom);
        PlannerMonth.Display.DisplayStart  := 1;//StartofTheday(Filterdatefrom);
        PlannerMonth.Display.DisplayEnd    := DaysInMonth(Filterdatefrom);//30;//EndoftheDay(Filterdatefrom) ;
        //PlannerMonth.Display.DisplayScale  := trunc((PlannerMonth.Width-PlannerMonth.Height)/DaysInMonth(Filterdatefrom) );
      end else if pgeRosters.ActivePage = TabWeekly then begin
        (*PlannerWeek.Mode.PeriodStartDay   := Dayof(Filterdatefrom);
        PlannerWeek.Mode.PeriodStartMonth := Monthof(Filterdatefrom);
        PlannerWeek.Mode.PeriodStartYear  := Yearof(Filterdatefrom);

        PlannerWeek.Mode.PeriodEndDay     := Dayof(Filterdateto);
        PlannerWeek.Mode.PeriodEndMonth   := Monthof(Filterdateto);
        PlannerWeek.Mode.PeriodEndYear    := Yearof(Filterdateto);
        PlannerWeek.Mode.TimeLineStart    := filterdatefrom;
        PlannerWeek.Mode.Year             := Yearof(Filterdateto);
        PlannerWeek.Mode.Weekstart        := DayoftheWeek(Filterdatefrom);
        PlannerWeek.Display.DisplayStart  := 1;
        PlannerWeek.Display.DisplayEnd    := 15;*)


       PlannerWeek.Display.DisplayUnit := 30; // 30 min steps
        PlannerWeek.Display.DisplayEnd := (14 * 48) - 1; // 14 days
        PlannerWeek.Display.DisplayScale := 12;
        PlannerWeek.Display.DisplayText := 2; // only display every second number .. ie hours
        PlannerWeek.Sidebar.Width := 40;
        PlannerWeek.Sidebar.DateTimeFormat := FormatSettings.ShortDateFormat;
      end;
      RosterSource.Active     := pgeRosters.ActivePage = tabDaily;
      MonthRosterSource.Active := pgeRosters.ActivePage = TabMonthly;
      WeekRosterSource.Active := pgeRosters.ActivePage = TabWeekly;
  end;
end;

function TfmEmpResProcScheduleVsRoster.filterdatefrom: TdateTime;
begin
  //REsult := DateRangeSelector.filterdateFrom;
  if pgeRosters.ActivePage = TabMonthly  then
        Result :=  StartOfTheMonth(Dateof(RosterDatePicker.StartDate))
  else  if pgeRosters.ActivePage = TabWeekly  then
        Result :=  Dateof(RosterDatePicker.StartDate)
  else  Result :=  RosterDatePicker.StartDate;
  Result := Dateof(Result);
end;

function TfmEmpResProcScheduleVsRoster.filterDateto: TdateTime;
begin
  if pgeRosters.ActivePage = TabMonthly  then
       Result :=  EndOfTheMonth(Dateof(RosterDatePicker.StartDate))
  else if pgeRosters.ActivePage = TabWeekly  then
       Result :=  incday(RosterDatePicker.StartDate,14)
  else Result := RosterDatePicker.StartDate;
  Result := incsecond(incday(Dateof(Result),1),-1);
end;

procedure TfmEmpResProcScheduleVsRoster.FormCreate(Sender: TObject);
begin
    DelectedScheduleIDs:= TIntegerlist.create;
    fAllocatedTimeSlotDetails.ShowStatus  := False;
    fAllocatedTimeSlotDetails.ShowSaleID  := True;
    fAllocatedTimeSlotDetails.ShowProduct := True;
    fAllocatedTimeSlotDetails.ShowCustomer:= False;
    fAllocatedTimeSlotDetails.showShipDate:= False;
    fAllocatedTimeSlotDetails.showManQty  := False;
    fAllocatedTimeSlotDetails.showLineFeed:= False;
    fAllocatedTimeSlotDetails.showDuration:= False;
    MonthRosterSource.Planner :=  PlannerMonth;
    WeekRosterSource.Planner  :=  PlannerWeek;
  inherited;
  RosterDatePicker.StartDate := date;
end;

procedure TfmEmpResProcScheduleVsRoster.FormDestroy(Sender: TObject);
begin
try
  Freeandnil(DelectedScheduleIDs);
  inherited;
Except
  on E:Exception do begin
    MessageDlgXP_Vista(E.Message, mtWarning, [mbOK], 0);
  end;
end;

end;

procedure TfmEmpResProcScheduleVsRoster.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Shift = [ssAlt,ssCtrl] then begin
    if pgeRosters.ActivePage = TabMonthly  then begin
      PlannerMonth.Display.Scaletofit := False;
      if Key = vk_Right then begin
        PlannerMonth.Display.DisplayScale  := PlannerMonth.Display.DisplayScale +1;
      end else if Key = vk_LEFT then begin
        PlannerMonth.Display.DisplayScale  := PlannerMonth.Display.DisplayScale -1;
      end;
    end else if pgeRosters.ActivePage = TabWeekly  then begin
      PlannerWeek.Display.Scaletofit := False;
      if Key = vk_Right then begin
        PlannerWeek.Display.DisplayScale  := PlannerWeek.Display.DisplayScale +1;
      end else if Key = vk_LEFT then begin
        PlannerWeek.Display.DisplayScale  := PlannerWeek.Display.DisplayScale -1;
      end;
    end else if pgeRosters.ActivePage = tabDaily  then begin
      Planner.Display.Scaletofit := False;
      if Key = vk_Right then begin
        Planner.Display.DisplayScale  := Planner.Display.DisplayScale +1;
      end else if Key = vk_LEFT then begin
        Planner.Display.DisplayScale  := Planner.Display.DisplayScale -1;
      end;
    end;
  end;
end;

procedure TfmEmpResProcScheduleVsRoster.FormShow(Sender: TObject);
begin
  inherited;
  PlannerMonth.caption.Background := clNavy;
  PlannerMonth.caption.Backgroundto := clWhite;

  PlannerWeek.caption.Background := clNavy;
  PlannerWeek.caption.Backgroundto := clWhite;

  if GuiPrefs.Node.Exists('Options.activepageindex') then begin
    pgeRosters.ActivePageindex  :=  GuiPrefs.Node['Options.activepageindex'].asInteger;
    RefreshQuery;
    MonthRosterSource.Active :=  True;
    WeekRosterSource.Active :=  True;
  end;
end;

procedure TfmEmpResProcScheduleVsRoster.grpFiltersClick(Sender: TObject);
begin
  inherited;
  Planner.Layer := grpfilters.ItemIndex;
  PlannerMonth.Layer := grpfilters.ItemIndex;
  PlannerWeek.Layer := grpfilters.ItemIndex;
end;

procedure TfmEmpResProcScheduleVsRoster.InitItemProperties(Fields: TFields);
begin
  inherited;
  EmpResProcScheduleItemProperties.RosterID           := fEmpResProcRosternSchedule.RosterID;
  EmpResProcScheduleItemProperties.ScheduleId         := fEmpResProcRosternSchedule.ScheduleId;
  EmpResProcScheduleItemProperties.ProcessPartID      := fEmpResProcRosternSchedule.ProcessPartID;
  EmpResProcScheduleItemProperties.Seqno              := fEmpResProcRosternSchedule.Seqno;
  EmpResProcScheduleItemProperties.LeaveID            := fEmpResProcRosternSchedule.LeaveID;
  EmpResProcScheduleItemProperties.updateSeqno        := fEmpResProcRosternSchedule.updateSeqno;
  EmpResProcScheduleItemProperties.Description        := fEmpResProcRosternSchedule.Description;
  if EmpResProcScheduleItemProperties.Seqno =3 then
    EmpResProcScheduleItemProperties.ItemCaption      :=EmpResProcScheduleItemProperties.Description;
end;

procedure TfmEmpResProcScheduleVsRoster.InitPlanner;
begin
  inherited;
  opendb(QryProcessEmployees);
  {Month planner }
  MonthRosterSource.NumberOfResources := QryProcessEmployees.RecordCount;

  if PlannerMonth.PositionWidth  < 30 then PlannerMonth.PositionWidth := 30;
  PlannerMonth.GridLeftCol := 14;
  PlannerMonth.MultiSelect := true;


  PlannerMonth.Header.Height := 100;
  PlannerMonth.Header.TextHeight := 100;
  PlannerMonth.Header.Color := $00FFDDC6;
  PlannerMonth.Header.Captions.Clear;
  PlannerMonth.Header.Captions.Add('');
  PlannerMonth.ItemGap := 0;

  PlannerMonth.Mode.PlannerType := plWeek;
  PlannerMonth.Display.DisplayText := 0;
  PlannerMonth.Sidebar.Width := 30;
  PlannerMonth.Sidebar.DateTimeFormat := FormatSettings.ShortDateFormat;

  with QryProcessEmployees do begin
    First;
    while not Eof do begin
      PlannerMonth.Header.Captions.Add(FieldByName('EmployeeName').AsString);
      Next;
    end;
  end;

  {Weekplanner}
  WeekRosterSource.NumberOfResources := QryProcessEmployees.RecordCount;
  if PlannerWeek.PositionWidth  < 30 then PlannerWeek.PositionWidth := 30;
  PlannerWeek.GridLeftCol := 14;
  PlannerWeek.MultiSelect := true;


  PlannerWeek.Header.Height := 100;
  PlannerWeek.Header.TextHeight := 100;
  PlannerWeek.Header.Color := $00FFDDC6;
  PlannerWeek.Header.Captions.Clear;
  PlannerWeek.Header.Captions.Add('');
  PlannerWeek.ItemGap := 0;

  PlannerWeek.Mode.PlannerType := plTimeline;
  PlannerWeek.Display.DisplayText := 0;
  PlannerWeek.Sidebar.Width := 30;
  PlannerWeek.Sidebar.DateTimeFormat := FormatSettings.ShortDateFormat;

  with QryProcessEmployees do begin
    First;
    while not Eof do begin
      PlannerWeek.Header.Captions.Add(FieldByName('EmployeeName').AsString);
      Next;
    end;
  end;

end;

procedure TfmEmpResProcScheduleVsRoster.ItemToField(Item: TPlannerItem);
begin
  inherited;

  EmpResProcScheduleItemProperties.RosterID     := QryRosterrosterId.AsInteger;
  EmpResProcScheduleItemProperties.ScheduleId   := QryRosterScheduleID.AsInteger;
  EmpResProcScheduleItemProperties.ProcessPartID:= QryRosterProcessPartID.AsInteger;
  EmpResProcScheduleItemProperties.Seqno        := QryRosterSeqno.AsInteger;
  EmpResProcScheduleItemProperties.LeaveID      := QryRosterLeaveID.AsInteger;
  EmpResProcScheduleItemProperties.updateSeqno  := QryRosterupdateSeqno.AsInteger;

  fEmpResProcRosternSchedule.RosterID        := EmpResProcScheduleItemProperties.RosterID;
  fEmpResProcRosternSchedule.ScheduleId      := EmpResProcScheduleItemProperties.ScheduleId;
  fEmpResProcRosternSchedule.ProcessPartID   := EmpResProcScheduleItemProperties.ProcessPartID;;
  fEmpResProcRosternSchedule.Seqno           := EmpResProcScheduleItemProperties.Seqno;;
  fEmpResProcRosternSchedule.LeaveID         := EmpResProcScheduleItemProperties.LeaveID;;
  fEmpResProcRosternSchedule.updateSeqno     := EmpResProcScheduleItemProperties.updateSeqno;;

end;

procedure TfmEmpResProcScheduleVsRoster.LoadBusObj;
begin
  //inherited;
  fEmpResProcRosternSchedule.Load;
  self.BeginTransaction;
  if not ManufactureLib.LockCapacityplanner(Userlock, titleLabel.Caption , 'Daily Process Schedule') then begin
        AccessLevel := 5;
  end else begin
        self.BeginTransaction;
  end;

end;

procedure TfmEmpResProcScheduleVsRoster.MakeBusObj;
begin
  //inherited;

  fEmpResProcRosternSchedule := TEmpResProcRosternSchedule.CreateWithNewConn(Self);
  fEmpResProcRosternSchedule.Connection.connection := Self.MyConnection;
  fEmpResProcRosternSchedule.BusObjEvent := DoBusinessObjectEvent;
  EmpResProcSchedule := fEmpResProcRosternSchedule;
end;

function TfmEmpResProcScheduleVsRoster.MaxDateRange: TDateTime;
begin
  Result := 0;
end;

function TfmEmpResProcScheduleVsRoster.MinDateRange: TDateTime;
begin
  Result := 0;
end;

function TfmEmpResProcScheduleVsRoster.PlannerEmployeeId: Integer;
begin
  Result := 0;
  if pgeRosters.ActivePage = TabMonthly then begin
    if (PlannerMonth.SelPosition <= QryProcessEmployees.RecordCount - 1) then begin
      QryProcessEmployees.First;
      QryProcessEmployees.MoveBy(PlannerMonth.SelPosition);
      Result := QryProcessEmployeesemployeeId.AsInteger;
    end;
  end else if pgeRosters.ActivePage = TabWeekly then begin
    if (PlannerWeek.SelPosition <= QryProcessEmployees.RecordCount - 1) then begin
      QryProcessEmployees.First;
      QryProcessEmployees.MoveBy(PlannerWeek.SelPosition);
      Result := QryProcessEmployeesemployeeId.AsInteger;
    end;
  end else begin
    Result := inherited PlannerEmployeeId;
  end;
end;

procedure TfmEmpResProcScheduleVsRoster.PlannerItemMove(Sender: TObject;
  Item: TPlannerItem; FromBegin, FromEnd, FromPos, ToBegin, ToEnd,
  ToPos: Integer);
begin
  inherited;
  fEmpResProcRosternSchedule.IsChanged:= True;
end;

procedure TfmEmpResProcScheduleVsRoster.PlannerItemMoving(Sender: TObject;
  Item: TPlannerItem; DeltaBegin, DeltaPos: Integer; var Allow: Boolean);
begin
  inherited;
  Allow := false;
end;

procedure TfmEmpResProcScheduleVsRoster.PlannerItemSize(Sender: TObject;
  Item: TPlannerItem; Position, FromBegin, FromEnd, ToBegin, ToEnd: Integer);
begin
  inherited;
  fEmpResProcRosternSchedule.IsChanged:= True;
end;

procedure TfmEmpResProcScheduleVsRoster.QryRosterBeforeDelete(
  DataSet: TDataSet);
begin
  inherited;
  if (fEmpResProcRosternSchedule.rosterID=0) and (fEmpResProcRosternSchedule.scheduleID<> 0) then
    DelectedScheduleIDs.add(fEmpResProcRosternSchedule.ScheduleID);
end;

procedure TfmEmpResProcScheduleVsRoster.QryRosterCalcFields(DataSet: TDataSet);
function LineFeed:String;
begin
  if showLineFeed then result := NL else result := ', ';
end;
begin
  if (QryRosterRosterID.asInteger =0) and (QryRosterScheduleId.asInteger <> 0) then begin
    QryRosterNotes.asString := '';
    if devmode      then QryRosterNotes.asString := '#' + inttostr(QryRosterID.asInteger)+iif(showLineFeed=False , NL, '');
    if Show_Status  then QryRosterNotes.asString := QryRosterNotes.asString + LineFeed + 'Booked';
    if ShowSaleID   then QryRosterNotes.asString := QryRosterNotes.asString + LineFeed + 'ID#' + inttostr(QryRosterSaleID.asInteger);
    if ShowProduct  then QryRosterNotes.asString := QryRosterNotes.asString + LineFeed + QryRosterProductName.asString;
    if ShowCustomer then QryRosterNotes.asString := QryRosterNotes.asString + LineFeed + QryRosterCustomerName.asString;
    if showShipDate then QryRosterNotes.asString := QryRosterNotes.asString + LineFeed + formatdatetime(FormatSettings.shortDateformat, QryRosterShipDate.asDateTime);
    if showManQty   then QryRosterNotes.asString := QryRosterNotes.asString + LineFeed + FloatTostrF(QryrosterShipped.asFloat , ffGeneral , 15,0) + ' '+ QryrosterUOM.asString;
    //if showDuration then QryRosterNotes.asString := QryRosterNotes.asString + LineFeed + SecondsToTime(SecondsBetween(QryRosterTimeTo.AsDateTime , QryRosterTimeFrom.AsDateTime));
    QryRosterNotes.asString := trim(QryRosterNotes.asString);
    if QryRosterNotes.asString = '' then
      QryRosterNotes.asString :=  'ID#' + inttostr(QryRosterSaleID.asInteger)+ LineFeed + QryRosterProductName.asString;
    //Exit;
  end else  if QryRosterSeqno.asInteger =3 then begin
    if SameText(QryRosterDescription.asString, UNAVAILABLE) then
      QryRosterNotes.asString := QryRosterDescription.asString
    else QryRosterNotes.asString := 'Leave : ' + QryRosterDescription.asString;
    //if showDuration then QryRosterNotes.asString := QryRosterNotes.asString + LineFeed + SecondsToTime(SecondsBetween(QryRosterTimeTo.AsDateTime , QryRosterTimeFrom.AsDateTime));
    //Exit;
  end else  if QryRosterSeqno.asInteger =4 then begin
    QryRosterNotes.asString :=QryRosterDescription.asString;
    if QryRosterNotes.asString ='' then QryRosterNotes.asString := 'Un-Available';
  end else begin
    inherited;
  end;
  if showDuration then QryRosterNotes.asString := QryRosterNotes.asString + LineFeed + SecondsToTime(SecondsBetween(QryRosterTimeTo.AsDateTime , QryRosterTimeFrom.AsDateTime));
end;

procedure TfmEmpResProcScheduleVsRoster.ReadGuiprefs;
begin
  inherited;
  if not Guiprefs.active then Guiprefs.Active := True;
  if GuiPrefs.Node.Exists('Options') then begin
    fAllocatedTimeSlotDetails.ShowStatus  := GuiPrefs.Node['Options.ShowStatus'].asBoolean;
    fAllocatedTimeSlotDetails.ShowSaleID  := GuiPrefs.Node['Options.ShowSaleID'].asBoolean;
    fAllocatedTimeSlotDetails.ShowProduct := GuiPrefs.Node['Options.ShowProduct'].asBoolean;
    fAllocatedTimeSlotDetails.ShowCustomer:= GuiPrefs.Node['Options.ShowCustomer'].asBoolean;
    fAllocatedTimeSlotDetails.showShipDate:= GuiPrefs.Node['Options.showShipDate'].asBoolean;
    fAllocatedTimeSlotDetails.showManQty  := GuiPrefs.Node['Options.showManQty'].asBoolean;
    fAllocatedTimeSlotDetails.showDuration:= GuiPrefs.Node['Options.showDuration'].asBoolean;
    fAllocatedTimeSlotDetails.showLineFeed:= GuiPrefs.Node['Options.showLineFeed'].asBoolean;
  end;





  if GuiPrefs.Node.Exists('Options.Monthcolumnwidth') then PlannerMonth.Display.DisplayScale  := GuiPrefs.Node['Options.Monthcolumnwidth'].asInteger;

  if GuiPrefs.Node.Exists('Options.Weekcolumnwidth') then PlannerWeek.Display.DisplayScale  := GuiPrefs.Node['Options.Weekcolumnwidth'].asInteger;

  if GuiPrefs.Node.Exists('Options.activepageindex') then
    pgeRosters.ActivePageindex  :=  GuiPrefs.Node['Options.activepageindex'].asInteger;

  if GuiPrefs.Node.Exists('Options.MonthRowHeight') then
    PlannerMonth.PositionWidth := GuiPrefs.Node['Options.MonthRowHeight'].asInteger;

  if GuiPrefs.Node.Exists('Options.WeekRowHeight') then
    PlannerWeek.PositionWidth := GuiPrefs.Node['Options.WeekRowHeight'].asInteger;

  if GuiPrefs.Node.Exists('Options.DayRowHeight') then
    Planner.PositionWidth := GuiPrefs.Node['Options.DayRowHeight'].asInteger;

end;

procedure TfmEmpResProcScheduleVsRoster.ReadOnlyAccess(const Value: Boolean);
begin
  inherited;
  if Value then begin
    PlannerMonth.DefaultItem.FixedPos:=True;
    PlannerMonth.DefaultItem.FixedSize:=True;
    PlannerMonth.DefaultItem.FixedTime:=True;
    PlannerMonth.DefaultItem.FixedPosition:=True;
    PlannerMonth.DefaultItem.Readonly:=True;

    PlannerWeek.DefaultItem.FixedPos:=True;
    PlannerWeek.DefaultItem.FixedSize:=True;
    PlannerWeek.DefaultItem.FixedTime:=True;
    PlannerWeek.DefaultItem.FixedPosition:=True;
    PlannerWeek.DefaultItem.Readonly:=True;

  end else begin
    PlannerMonth.DefaultItem.FixedPos:=False;
    PlannerMonth.DefaultItem.FixedSize:=False;
    PlannerMonth.DefaultItem.FixedTime:=False;
    PlannerMonth.DefaultItem.FixedPosition:=False;
    PlannerMonth.DefaultItem.Readonly:=False;

    PlannerWeek.DefaultItem.FixedPos:=False;
    PlannerWeek.DefaultItem.FixedSize:=False;
    PlannerWeek.DefaultItem.FixedTime:=False;
    PlannerWeek.DefaultItem.FixedPosition:=False;
    PlannerWeek.DefaultItem.Readonly:=False;
  end;

end;

procedure TfmEmpResProcScheduleVsRoster.RefreshQuery(Sender: TObject);
begin
  RefreshQuery;
end;

procedure TfmEmpResProcScheduleVsRoster.RefreshQuery;
begin
  fEmpResProcRosternSchedule.DateFrom := FilterDateFrom;
  fEmpResProcRosternSchedule.DateTo := FilterDateto;
  inherited;
end;

procedure TfmEmpResProcScheduleVsRoster.RosterFieldsToItem(Sender: TObject;
  Fields: TFields; Item: TPlannerItem);
begin
  inherited;
  item.Shape := psRounded;
  if fEmpResProcRosternSchedule.Seqno = 2 then begin {Schedule}
    item.Font.color := clblack;
    item.Color :=  ResourceToDarkcolor(EmpResProcScheduleItemProperties.ResourceID, EmpResProcScheduleItemProperties.ProcessStepId);
    item.bordercolor :=item.Font.color;
    item.Colorto :=  item.Color;
    item.TrackColor := item.bordercolor;
    item.TracklinkColor := item.bordercolor;
    item.selectFontcolor := item.bordercolor;
    item.Shadow := False;
    //item.Shape := psRounded;
    item.Layer := 2;
    //item.AllowOverlap :=False;
    if fEmpResProcRosternSchedule.LeaveId <> 0 then begin
      item.Font.Style := item.Font.Style +[fsStrikeOut];
      item.Colorto :=  clred;
    end;
    //item.captionText := 'Job Schedule';
  end else if fEmpResProcRosternSchedule.Seqno =3  then begin  {Leave}
    item.Font.color := clwhite;
    item.Color :=  clred;
    item.bordercolor :=item.Font.color;
    item.Colorto :=  clNavy;
    item.TrackColor := item.bordercolor;
    item.TracklinkColor := item.bordercolor;
    item.selectFontcolor := item.bordercolor;
    item.Shadow := False;
    //item.Shape := psRounded;
    item.Layer := 3;
    //item.AllowOverlap :=False;
    //item.captionText := 'Leave';
  end else if fEmpResProcRosternSchedule.Seqno =4  then begin  {Resource Unavailable }
    item.Font.color := clwhite;
    item.Color :=    $00FF0909;
    item.bordercolor :=item.Font.color;
    item.Colorto :=$004A4AFF;
    item.TrackColor := item.bordercolor;
    item.TracklinkColor := item.bordercolor;
    item.selectFontcolor := item.bordercolor;
    item.Shadow := False;
    //item.Shape := psRounded;
    item.Layer := 4;
    //item.AllowOverlap :=False;
    //item.captionText := 'Resource Unavailable';
  end else begin {Roster}
    //item.captionText := 'Employee Allocation';
    item.Background := True;
    item.Layer := 1;
    item.showDeleteButton:= false;
    //item.AllowOverlap :=False;
  end;
  item.AllowOverlap :=False;
  item.CaptionBkg  :=  item.Color  ;
  item.CaptionBkgTo:=  item.Color ;
end;


function TfmEmpResProcScheduleVsRoster.SaveRecord: Boolean;
var
  ctr:Integer;
begin
  try
    fEmpResProcRosternSchedule.SQLList.clear;
    inherited;

    {Delete the deleted schedules}
    if DelectedScheduleIDs.count >0 then
      for ctr:= 0 to DelectedScheduleIDs.count-1 do
        if DelectedScheduleIDs[ctr] <> 0 then
          fEmpResProcRosternSchedule.SQLList.add('Delete from tblprocesstime  Where ProcesstimeId = ' + inttostr(DelectedScheduleIDs[ctr])+';');

    if fEmpResProcRosternSchedule.SQLList.count <> 0 then begin
      clog(fEmpResProcRosternSchedule.SQLList.Text);
      fEmpResProcRosternSchedule.ExecuteSQL(fEmpResProcRosternSchedule.SQLList,true);
    end;

    Result := True;
  Except
    on E:Exception do begin
      Result := False;
    end;
  end;
end;

procedure TfmEmpResProcScheduleVsRoster.SaveRecordCallback(const Sender: TBusObj; var Abort: Boolean);
begin
  if not (Sender is TEmpResProcRosternSchedule) then exit;
  if (TEmpResProcRosternSchedule(Sender).rosterId<>0) or (TEmpResProcRosternSchedule(Sender).ScheduleId =0) then exit; // these are not the allcoation
  if not(TEmpResProcRosternSchedule(Sender).IsChanged) then exit;
  if TEmpResProcRosternSchedule(Sender).Deleted then
    TEmpResProcRosternSchedule(Sender).SQLList.add('Delete from tblprocesstime  Where ProcesstimeId = ' + inttostr(TEmpResProcRosternSchedule(Sender).ScheduleId)+';')
  else
    TEmpResProcRosternSchedule(Sender).SQLList.add('update tblprocesstime Set  timestart = ' +Quotedstr(formatdateTime(MysqlDateTimeFormat,TEmpResProcRosternSchedule(Sender).TimeFrom))+', ' +
                                                                           ' TimeEnd = ' +Quotedstr(formatdateTime(MysqlDateTimeFormat,TEmpResProcRosternSchedule(Sender).TimeTo))+', ' +
                                                                           ' Duration = ' + inttostr(SecondsBetween(TEmpResProcRosternSchedule(Sender).TimeTo , TEmpResProcRosternSchedule(Sender).TimeFrom)) +', ' +
                                                                           ' ResourcedetailsID =  if(' + inttostr(TEmpResProcRosternSchedule(Sender).EmployeeID) +'<> EmployeeId , 0,' + inttostr(TEmpResProcRosternSchedule(Sender).ResourceDetailId) +'), ' +
                                                                           ' EmployeeID = ' + inttostr(TEmpResProcRosternSchedule(Sender).EmployeeID) +
                                                                           ' Where ProcesstimeId = ' + inttostr(TEmpResProcRosternSchedule(Sender).ScheduleId)+';');

  inherited;
end;

function TfmEmpResProcScheduleVsRoster.ShowCustomer : Boolean;begin  Result := fAllocatedTimeSlotDetails.ShowCustomer ;end;
function TfmEmpResProcScheduleVsRoster.showManQty   : Boolean;begin  Result := fAllocatedTimeSlotDetails.showManQty   ;end;
function TfmEmpResProcScheduleVsRoster.showLineFeed : Boolean;begin  Result := fAllocatedTimeSlotDetails.showLineFeed ;end;
function TfmEmpResProcScheduleVsRoster.showDuration : Boolean;begin  Result := fAllocatedTimeSlotDetails.showDuration ;end;
function TfmEmpResProcScheduleVsRoster.ShowProduct  : Boolean;begin  Result := fAllocatedTimeSlotDetails.ShowProduct  ;end;
function TfmEmpResProcScheduleVsRoster.ShowSaleID   : Boolean;begin  Result := fAllocatedTimeSlotDetails.ShowSaleID   ;end;
function TfmEmpResProcScheduleVsRoster.showShipDate : Boolean;begin  Result := fAllocatedTimeSlotDetails.showShipDate ;end;
function TfmEmpResProcScheduleVsRoster.Show_Status  : Boolean;begin  Result := fAllocatedTimeSlotDetails.ShowStatus   ;end;
function TfmEmpResProcScheduleVsRoster.StartDate: TDateTime;
begin
  REsult := 0;
  if not Guiprefs.active then Guiprefs.Active := True;
  if GuiPrefs.Node.Exists('EmpResProcScheduleDay') then
    Result := GuiPrefs.Node['EmpResProcScheduleDay'].asDatetime;
  if result =0 then result := Date;
end;

procedure TfmEmpResProcScheduleVsRoster.WriteGuiprefs;
begin
  inherited;
  GuiPrefs.Node['Options.ShowStatus'].asBoolean     := fAllocatedTimeSlotDetails.ShowStatus ;
  GuiPrefs.Node['Options.ShowSaleID'].asBoolean     := fAllocatedTimeSlotDetails.ShowSaleID;
  GuiPrefs.Node['Options.ShowProduct'].asBoolean    := fAllocatedTimeSlotDetails.ShowProduct;
  GuiPrefs.Node['Options.ShowCustomer'].asBoolean   := fAllocatedTimeSlotDetails.ShowCustomer;
  GuiPrefs.Node['Options.showShipDate'].asBoolean   := fAllocatedTimeSlotDetails.showShipDate;
  GuiPrefs.Node['Options.showManQty'].asBoolean     := fAllocatedTimeSlotDetails.showManQty;
  GuiPrefs.Node['Options.showLineFeed'].asBoolean   := fAllocatedTimeSlotDetails.showLineFeed;
  GuiPrefs.Node['Options.showDuration'].asBoolean   := fAllocatedTimeSlotDetails.showDuration;

  //GuiPrefs.Node['Options.RowHeight'].asInteger      := iif(PlannerMonth.PositionWidth < Planner.PositionWidth  , PlannerMonth.PositionWidth  , Planner.PositionWidth );

  GuiPrefs.Node['Options.Monthcolumnwidth'].asInteger:= PlannerMonth.Display.DisplayScale  ;
  GuiPrefs.Node['Options.MonthRowHeight'].asInteger  := PlannerMonth.PositionWidth;


  GuiPrefs.Node['Options.Weekcolumnwidth'].asInteger:= PlannerWeek.Display.DisplayScale  ;
  GuiPrefs.Node['Options.WeekRowHeight'].asInteger  := PlannerWeek.PositionWidth;
  GuiPrefs.Node['Options.DayRowHeight'].asInteger  := Planner.PositionWidth;

  GuiPrefs.Node['Options.activepageindex'].asInteger:= pgeRosters.ActivePageindex;

end;

initialization
  RegisterClassOnce(TfmEmpResProcScheduleVsRoster);
end.
