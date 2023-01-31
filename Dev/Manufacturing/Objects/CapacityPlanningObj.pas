unit CapacityPlanningObj;

interface

uses IntegerListObj,ERPdbComponents, Contnrs, classes;

type

  TSchedules = class(TComponent)
  Public
    TimeFrom :Tdatetime;
    TimeTo:Tdatetime;
    Duration:Integer;
    class Function NewInstance(AOwner:Tcomponent;  fTimeFrom :Tdatetime;fTimeTo:Tdatetime;fDuration:Integer):TSchedules;

  End;

  TProcResforDate = class;

  TProcResforDateDetails = class(TComponent)
  Private
    function ProcResforDate: TProcResforDate;
  Public
    Seqno:Integer;
    ResourcedetailsID :Integer;
    TimeFrom:TdateTime;
    Timeto:TDatetime;
    Capacity: Integer;
    SetupHoursDay : Integer;
    BreakdownHoursDay : Integer;
    Allocated: double;
    EmployeeId :Integer;
    Schedules : Array of TSchedules;

    function Available: double;
    constructor Create(Aowner:TComponent);Override;
    Procedure NewSchedule(fDuration :Integer ; fTimeStart:TDatetime);
    Procedure LoadAllocatins(Connection: TERPConnection);
    function NextAvailableSlot(fDate:TDateTime) : TSchedules;
    function FirstslotSlot(fDate:TDateTime) : TSchedules;

  end;

  TProcResforDate = class(TComponent)
  private
    procedure setAllocated(Value: Integer);
    function getCapacity: Integer;
  public
    ResourceId: integer;
    Date: TDateTime;
    //SaleLineId :Integer;
    ProcResforDateDetails :Array of TProcResforDateDetails;
    //StartAt:TTime;
    function Available: double;
    constructor Create(Aowner:TComponent);Override;
    destructor Destroy; override;
    Property Allocated :Integer write setAllocated;
    Property Capacity :Integer read getCapacity;
    Procedure   NewProcResforDateDetails;
    Procedure CalcProcessTimeAllocatedForDate;

  end;

  TResSchedList = class(TComponent)
    private
      fList: TObjectList;
      fProcResforDateList: TObjectList;
      fConnection: TERPConnection;
      fResourceIdList: TIntegerList;
      function GetCount: integer;
      function GetItem(const index: integer): TProcResforDate;
      function GetConnection: TERPConnection;
      procedure SetConnection(const Value: TERPConnection);
      function GetResourceIdList: TIntegerList;
      function ResourceProcessCapacityForDate(ProcResforDate : TProcResforDate;Connection: TERPConnection): double;
      function IsEmployeeandResourceAvailablefordate(const aProcResourceId, aProcResourceDetailsId:Integer; const aTimefrom, aTimeTo: TDatetime;const aEmployeeID: Integer): Boolean;
    public
      constructor Create(Aowner:TComponent);Override;
      destructor Destroy; override;
      property Count: integer read GetCount;
      property Item[const index: integer]: TProcResforDate read GetItem; default;
      procedure Clear;
      function AvailabilityForDate(const aDate: TDateTime;const  ProcResourceId: integer;Reschedling:Boolean =False): TProcResforDate;
      property Connection: TERPConnection read GetConnection write SetConnection;
      procedure PopulateForDateRange(const aDateFrom, aDateTo: TDateTime);
      procedure SummaryForDate(const aDate: TDateTime; var Capacity, Available,Overallocated: double);
      function ResourceCapacityFordate(const aDate: TDateTime; aResID:Integer):double;
      function AvailableForDate(const aDate: TDateTime; const aResourceId: integer): double;
      (*procedure AdjustForDate(const aDate: TDateTime; const aResourceId: integer; const aValue: Integer);*)
      property ResourceIdList: TIntegerList read GetResourceIdList;

  end;

implementation

uses DbSharedObjectsObj, CommonDbLib, CommonLib, MySQLConst , sysutils,
  AppEnvironment, ProcessDataUtils, dateutils, tcDataUtils, LogLib,
  ManufactureLib;

var
  fiProcResforDateDetailsSeqno:Integer;


{ TProcResforDate }

function TProcResforDate.Available: double;
var
  ctr:Integer;
begin
  Result := 0;
  if length(ProcResforDateDetails) =0 then exit;
  for ctr := low(ProcResforDateDetails) to high(ProcResforDateDetails) do begin
    REsult := result + ProcResforDateDetails[ctr].Available;
  end;
end;

procedure TProcResforDate.CalcProcessTimeAllocatedForDate;
begin

end;

constructor TProcResforDate.Create(Aowner:TComponent);
begin
  inherited Create(AOwner);
  Setlength(ProcResforDateDetails,0);
end;

destructor TProcResforDate.Destroy;
var
  ctr:Integer;
begin
  if length(ProcResforDateDetails)>0 then begin
    for ctr:= high(ProcResforDateDetails) downto Low(ProcResforDateDetails) do
      Freeandnil(ProcResforDateDetails[ctr]);
    SetLength(ProcResforDateDetails,0);
  end;

  inherited;
end;

function TProcResforDate.getCapacity: Integer;
var
  ctr:Integer;
begin
  REsult := 0;
  if length(ProcResforDateDetails) =0 then exit;
  for ctr := low(ProcResforDateDetails) to high(ProcResforDateDetails) do
    Result := result + ProcResforDateDetails[ctr].Capacity;

end;

procedure TProcResforDate.NewProcResforDateDetails;
begin
  SetLength(ProcResforDateDetails , Length(ProcResforDateDetails)+1);
  ProcResforDateDetails[high(ProcResforDateDetails)] := TProcResforDateDetails.create(Self);
end;


procedure TProcResforDate.setAllocated(Value: Integer);
var
  ctr:Integer;
begin
  for ctr:= low(ProcResforDateDetails) to high(ProcResforDateDetails) do
    ProcResforDateDetails[ctr].allocated := 0;
  for ctr:= low(ProcResforDateDetails) to high(ProcResforDateDetails) do begin
    if value <= ProcResforDateDetails[ctr].Capacity then begin
      ProcResforDateDetails[ctr].allocated := Value ;
      Value := 0;
    end else begin
      ProcResforDateDetails[ctr].allocated := ProcResforDateDetails[ctr].Capacity;
      Value := Value - ProcResforDateDetails[ctr].Capacity;
    end;
    if value <=0 then break;
  end;
end;

{ TProcResforDateDetails }

function TProcResforDateDetails.Available: double;
begin
  Result:= self.Capacity - self.Allocated;
end;

{ TResSchedList }

(*procedure TResSchedList.AdjustForDate(const aDate: TDateTime;  const aResourceId: integer; const aValue: Integer);
var
  rec: TProcResforDate;
begin
  rec:= self.AvailabilityForDate(aDate, aResourceId);
  if Assigned(rec) then
    rec.Allocated:= rec.Allocated + aValue;
end;*)

function TResSchedList.AvailableForDate(const aDate: TDateTime;
  const aResourceId: integer): double;
var
  rec: TProcResforDate;
begin
  Result:= 0;
  rec:= self.AvailabilityForDate(aDate, aResourceId);
  if Assigned(rec) then
    Result:= rec.Available;
end;

procedure TResSchedList.Clear;
begin
  fList.Clear;
end;

constructor TResSchedList.Create(Aowner:TComponent);
begin
  inherited Create(AOwner);
  fList:= TObjectList.Create(true);
end;

destructor TResSchedList.Destroy;
begin
  fList.Free;
  fResourceIdList.Free;
  inherited;
end;

function TResSchedList.GetConnection: TERPConnection;
begin
  if Assigned(fConnection) then
    Result:= fConnection
  else
    Result:= CommonDbLib.GetSharedMyDacConnection;
end;

function TResSchedList.GetCount: integer;
begin
  Result:= fList.Count;
end;

function TResSchedList.GetItem(const index: integer): TProcResforDate;
begin
  Result:= TProcResforDate(fList[index]);
end;

function TResSchedList.GetResourceIdList: TIntegerList;
var
  qry: TERPQuery;
begin
  if not Assigned(fResourceIdList) then begin
    fResourceIdList:= TIntegerList.Create;
    qry:= TERPQuery.Create(nil);
    try
      qry.Connection:= Connection;
      qry.SQL.Text:=
       'SELECT ProcResourceId'+
       ' FROM tblProcResource WHERE ResourceAvailable = "T"';
      qry.Open;
      while not qry.Eof do begin
        fResourceIdList.Add(qry.FieldByName('ProcResourceId').AsInteger);
        qry.Next;
      end;
    finally
      qry.Free;
    end;
  end;
  Result:= fResourceIdList;
end;


procedure TResSchedList.PopulateForDateRange(const aDateFrom,aDateTo: TDateTime);
var
  Rec: TProcResforDate;
  dt: TDateTime;
  x: integer;
  StartAt:TTime;
  ResourcedetailsID:Integer;
begin
  fList.Clear;
  for x:= 0 to Self.Count -1 do begin
    dt:= aDateFrom;
    while dt <= aDateTo do begin
      AvailabilityForDate(dt ,Self.item[x].ResourceId);
      dt:= dt + 1;
    end;
  end;
end;

function TResSchedList.ResourceCapacityFordate(const aDate: TDateTime;aResID: Integer): double;
var
  x: integer;
begin
  result:= 0;
  for x:= 0 to fList.Count -1 do begin
    if (Item[x].ResourceId = aResID) and (dateof(Item[x].Date) = dateof(aDate)) then begin
      result:= Item[x].Capacity;
      exit;
    end;
  end;
end;

function TResSchedList.AvailabilityForDate(const aDate: TDateTime;const ProcResourceId: integer; Reschedling: Boolean): TProcResforDate;
var
  x: integer;
  StartAt:TTime;
  ResourcedetailsID :Integer;
begin
  Result:= nil;
  for x:= 0 to Count -1 do begin
    if (Item[x].ResourceId = ProcResourceId) and (Trunc(Item[x].Date) = Trunc(aDate)) then begin
      Result:= Item[x];
      break;
    end;
  end;
  if not Assigned(Result) then begin
    Result            := TProcResforDate.Create(Self);
    Result.ResourceId := ProcResourceId;
    Result.Date       := aDate;
    ResourceProcessCapacityForDate(Result, Connection);

    Result.Allocated:= 0;

    if Reschedling then
    else for x := low (REsult.ProcResforDateDetails) to high(REsult.ProcResforDateDetails) do
      REsult.ProcResforDateDetails[x].allocated:= trunc(ProcessTimeAllocatedForDatenDetail(0,Result.ResourceId,REsult.ProcResforDateDetails[x].ResourcedetailsID, Result.Date, Connection));
    fList.Add(Result);
    if Length(Result.ProcResforDateDetails)=0 then
      LogText(inttostr(Result.ResourceId)+',' +
              FormatDateTime('dd-mm-yy hh:nn:ss' , Result.Date));
  end;
end;
function TResSchedList.IsEmployeeandResourceAvailablefordate(const aProcResourceId, aProcResourceDetailsId:Integer; const aTimefrom, aTimeTo: TDatetime;const aEmployeeID: Integer): Boolean;
var
  qry: TERPQuery;
  fbIsPublicholiday:boolean;
  fbClosedOnPublicHolidays:Boolean;
  fbempAvailable:Boolean;
begin
  Result := False;

  fbIsPublicholiday       := False;
  fbClosedOnPublicHolidays:= False;
  fbempAvailable          := False;

  Qry := DbSharedObj.GetQuery(Connection);
  try
    closedb(Qry);
    Qry.SQL.text := 'Select * from tblpublicholidays where day = ' + Quotedstr(formatDateTime(MysqlDateFormat, Dateof(aTimefrom)));
    Qry.open;
    fbIsPublicholiday := Qry.recordcount >0;

    if aProcResourceDetailsId <> 0 then begin
      closedb(Qry);
      Qry.SQL.text := 'Select ClosedOnPublicHolidays  from tblprocresourcedetails where ProcResourceId = ' + inttostr(aProcResourceDetailsId);
      Qry.open;
      fbClosedOnPublicHolidays:= Qry.FieldByName('ClosedOnPublicHolidays').AsBoolean;
    end else if aProcResourceId <> 0 then begin
      closedb(Qry);
      Qry.SQL.text := 'Select ClosedOnPublicHolidays from tblprocresource where ProcResourceId = ' + inttostr(aProcResourceId);
      Qry.open;
      fbClosedOnPublicHolidays:= Qry.FieldByName('ClosedOnPublicHolidays').AsBoolean;
    end;

    closedb(Qry);
    Qry.SQL.text := 'Select * from tblroster where ((type like "%Leave%" ) or (type like "Unavailable" )) and (employeeId = ' + inttostr(aEmployeeID)+')'+
                    ' and ((StartTime between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,atimeFrom))+' and  ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,Atimeto))+') or '+
                    '      (endtime   between ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,atimeFrom))+' and  ' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,Atimeto))+') or '+
                    '      (StartTime <= '      + QuotedStr(FormatDateTime(MysqlDateTimeFormat,atimeFrom))+' and  endtime >=' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,Atimeto))+'))';
    Qry.open;
    fbempAvailable := Qry.RecordCount =0;

    if fbIsPublicholiday and  fbClosedOnPublicHolidays then Exit;
    if not fbempAvailable then exit;
    Result :=True;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;
function TResSchedList.ResourceProcessCapacityForDate(ProcResforDate : TProcResforDate;Connection: TERPConnection): double;
var
  qry: TERPQuery;
begin

  Result:= 0;
  if Connection = nil then Connection :=Commondblib.getsharedmydacconnection;
  Qry := DbSharedObj.GetQuery(Connection);

  try
    qry.SQL.Text:=
        ' select Distinct PR.ProcResourceID, EPSC.EmployeeId,ResourceDetailId , '+
        ' PR.SetupHoursDay, '+
        ' PR.BreakdownHoursDay, '+
        ' Convert( ADDTIME(' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,dateof(ProcResforDate.Date))) + ', TIME(EPSC.TimeFrom)), datetime) timefrom, '+
        ' Convert( ADDTIME(' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,dateof(ProcResforDate.Date))) + ', TIME(EPSC.TimeTo)), datetime) timeTo , '+
        ' time_To_SEc(TIMEDIFF(EPSC.TimeTo,EPSC.TimeFrom)) Seconds   '+
        ' from tblempresprocschedule EPSC '+
        ' inner join tblProcResource PR   on PR.ProcResourceID = EPSC.ResourceID and PR.active ="T" and PR.ResourceAvailable ="T" '+
        ' where EPSC.active ="T" and PR.ResourceAvailable ="T"  and  Weekdayno = DAYOFWEEK(' + QuotedStr(FormatDateTime(MysqlDateFormat,ProcResforDate.Date)) + ') ';
    if ProcResforDate.ResourceId >0 then qry.SQL.add(' and EPSC.ResourceID =' + inttostr(ProcResforDate.ResourceId));
    qry.SQL.add(' Order by TimeFrom, ResourceDetailId,timeto');
    qry.open;

    if (qry.recordcount =0) and (Appenv.CompanyPrefs.AutoScheduleBasedonBOMEmpRoster=False) and (not(Resourcerostered(ProcResforDate.ResourceId))) then begin
        CloseDb(qry);
        Qry.SQL.Text := 'SELECT PR.ProcResourceId , 0 as EmployeeId,'+
        ' PRDT.ID as  ResourceDetailId , '+
        ' PR.SetupHoursDay, PR.BreakdownHoursDay, '+
        {TimeFrom}
        ' Convert( ADDTIME(' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,dateof(ProcResforDate.Date))) + ',  convert('+
        '  if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =1 and PRD.Sunday   = "T" , ifnull(PRD.SundayStartAt    ,' + QuotedStr(FormatDateTime(MysqlTimeFormat,Appenv.companyPrefs.StartOfDay)) + ' ), '+
        '  if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =2 and PRD.Monday   = "T" , ifnull(PRD.MondayStartAt    ,' + QuotedStr(FormatDateTime(MysqlTimeFormat,Appenv.companyPrefs.StartOfDay)) + ' ), '+
        '  if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =3 and PRD.TuesDay  = "T" , ifnull(PRD.TuesdayStartAt   ,' + QuotedStr(FormatDateTime(MysqlTimeFormat,Appenv.companyPrefs.StartOfDay)) + ' ), '+
        '  if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =4 and PRD.Wednesday= "T" , ifnull(PRD.WednesdayStartAt ,' + QuotedStr(FormatDateTime(MysqlTimeFormat,Appenv.companyPrefs.StartOfDay)) + ' ), '+
        '  if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =5 and PRD.Thursday = "T" , ifnull(PRD.ThursdayStartAt  ,' + QuotedStr(FormatDateTime(MysqlTimeFormat,Appenv.companyPrefs.StartOfDay)) + ' ), '+
        '  if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =6 and PRD.Friday   = "T" , ifnull(PRD.FridayStartAt    ,' + QuotedStr(FormatDateTime(MysqlTimeFormat,Appenv.companyPrefs.StartOfDay)) + ' ), '+
        '  if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =7 and PRD.Saturday = "T" , ifnull(PRD.SaturdayStartAt  ,' + QuotedStr(FormatDateTime(MysqlTimeFormat,Appenv.companyPrefs.StartOfDay)) + ' ), 0))))))), Time)), datetime) timefrom , '+

        {TimeTo}
        ' Convert( ADDTIME(' + QuotedStr(FormatDateTime(MysqlDateTimeFormat,dateof(ProcResforDate.Date))) + ', '+
        '  SEC_TO_TIME( if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =1 and PRD.Sunday   = "T" , TIME_TO_SEC( ifnull(PRD.SundayStartAt   ,' + QuotedStr(FormatDateTime(MysqlTimeFormat,Appenv.companyPrefs.StartOfDay)) + ' ))+PRD.SundayCapacityHoursDay   , '+
        '               if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =2 and PRD.Monday   = "T" , TIME_TO_SEC( ifnull(PRD.MondayStartAt   ,' + QuotedStr(FormatDateTime(MysqlTimeFormat,Appenv.companyPrefs.StartOfDay)) + ' ))+PRD.MondayCapacityHoursDay     , '+
        '               if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =3 and PRD.TuesDay  = "T" , TIME_TO_SEC( ifnull(PRD.TuesdayStartAt  ,' + QuotedStr(FormatDateTime(MysqlTimeFormat,Appenv.companyPrefs.StartOfDay)) + ' ))+PRD.TuesdayCapacityHoursDay    , '+
        '               if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =4 and PRD.Wednesday= "T" , TIME_TO_SEC( ifnull(PRD.WednesdayStartAt,' + QuotedStr(FormatDateTime(MysqlTimeFormat,Appenv.companyPrefs.StartOfDay)) + ' ))+PRD.WednesdayCapacityHoursDay  , '+
        '               if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =5 and PRD.Thursday = "T" , TIME_TO_SEC( ifnull(PRD.ThursdayStartAt ,' + QuotedStr(FormatDateTime(MysqlTimeFormat,Appenv.companyPrefs.StartOfDay)) + ' ))+PRD.ThursdayCapacityHoursDay   , '+
        '               if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =6 and PRD.Friday   = "T" , TIME_TO_SEC( ifnull(PRD.FridayStartAt   ,' + QuotedStr(FormatDateTime(MysqlTimeFormat,Appenv.companyPrefs.StartOfDay)) + ' ))+PRD.FridayCapacityHoursDay     , '+
        '               if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =7 and PRD.Saturday = "T" , TIME_TO_SEC( ifnull(PRD.SaturdayStartAt ,' + QuotedStr(FormatDateTime(MysqlTimeFormat,Appenv.companyPrefs.StartOfDay)) + ' ))+PRD.SaturdayCapacityHoursDay   , 0))))))))), datetime) timeto , '+

        {Seconds}
        '  if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =1 and PRD.Sunday   = "T" , PRD.SundayCapacityHoursDay , '+
        '  if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =2 and PRD.Monday   = "T" , PRD.MondayCapacityHoursDay , '+
        '  if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =3 and PRD.TuesDay  = "T" , PRD.TuesdayCapacityHoursDay , '+
        '  if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =4 and PRD.Wednesday= "T" , PRD.WednesdayCapacityHoursDay , '+
        '  if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =5 and PRD.Thursday = "T" , PRD.ThursdayCapacityHoursDay , '+
        '  if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =6 and PRD.Friday   = "T" , PRD.FridayCapacityHoursDay , '+
        '  if(DAYOFWEEK(  ' + QuotedStr(FormatDateTime(MysqlDateFormat,dateof(ProcResforDate.Date))) + ') =7 and PRD.Saturday = "T" , PRD.SaturdayCapacityHoursDay , 0))))))) Seconds '+

        '  FROM tblProcResource PR '+
        '  inner join tblProcResourceDays PRD on PRD.ProcResourceID = PR.ProcResourceId '+
        '  inner join tblprocresourcedetails PRDT on PRDT.ProcResourceId = PR.ProcResourceId '+
        '  LEFT JOIN tblProcResourceAvailability RA ON RA.ProcResourceId = PR.ProcResourceId '+
        '  WHERE PR.ResourceAvailable = "T"       AND (ISNULL( RA.TimeStart) OR NOT ((' + QuotedStr(FormatDateTime(MysqlDateFormat,ProcResforDate.Date)) + ' >=  RA.TimeStart) AND (' + QuotedStr(FormatDateTime(MysqlDateFormat,ProcResforDate.Date)) + ' <=  RA.TimeEnd))) ';

        if ProcResforDate.ResourceId >0 then qry.SQL.add(' AND PR.ProcResourceId = ' + inttostr(ProcResforDate.ResourceId));
        qry.SQL.add(' Order by TimeFrom, timeto');
        qry.Open;
    end;
    if qry.recordcount =0 then Exit;
    qry.First;
    result:= 0;
    while not qry.Eof do begin
      if Qry.FieldByName('timeto').AsDateTime > ProcResforDate.Date  then begin
        if IsEmployeeandResourceAvailablefordate(Qry.FieldByName('ProcResourceId').asInteger ,Qry.FieldByName('ResourceDetailId').asInteger ,Qry.FieldByName('timefrom').AsDateTime ,  Qry.FieldByName('timeto').AsDateTime ,Qry.fieldbyname('employeeID').asInteger) then begin
          ProcResforDate.NewProcResforDateDetails;
          //SetLength(ProcResforDate.ProcResforDateDetails , Length(ProcResforDate.ProcResforDateDetails)+1);
          //ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)] := TProcResforDateDetails.create;
          ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].ResourcedetailsID  := Qry.FieldByName('ResourceDetailId').AsInteger;
          ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].TimeFrom           := Qry.FieldByName('timefrom').AsDateTime;//iif(ProcResforDate.Date <Qry.FieldByName('timefrom').AsDateTime , Qry.FieldByName('timefrom').AsDateTime , ProcResforDate.Date);
          ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].Timeto             := Qry.FieldByName('timeto').AsDateTime;
          ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].Capacity           := Qry.FieldByName('Seconds').AsInteger;//Secondsbetween(ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].TimeFrom, ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].Timeto );  //Qry.FieldByName('Seconds').AsInteger;
          ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].EmployeeId         := Qry.FieldByName('EmployeeId').AsInteger;
          ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].BreakdownHoursDay  := Qry.FieldByName('BreakdownHoursDay').AsInteger;
          ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].SetupHoursDay      := Qry.FieldByName('SetupHoursDay').AsInteger;
          ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].LoadAllocatins(Connection);
          //ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].CalcProcessTimeAllocatedForDate;
          result:= result +(qry.Fieldbyname('Seconds').AsFloat - qry.Fieldbyname('SetupHoursDay').AsFloat - qry.Fieldbyname('BreakdownHoursDay').AsFloat);
          LogTExt(inttostr(ProcResforDate.ResourceId)+',' +
                            FormatDateTime('dd-mm-yy hh:nn:ss' , ProcResforDate.Date)+',' +
                            inttostr(ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].ResourcedetailsID) +',' +
                            FormatDateTime('dd-mm-yy hh:nn:ss' , ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].TimeFrom)+',' +
                            FormatDateTime('dd-mm-yy hh:nn:ss' , ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].TimeTo)+',' +
                            inttostr(ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].Capacity) +',' +
                            inttostr(ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].employeeId) +',' +
                            inttostr(ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].BreakdownHoursDay) +',' +
                            inttostr(ProcResforDate.ProcResforDateDetails[high(ProcResforDate.ProcResforDateDetails)].SetupHoursDay) );
        end;
      end;
      qry.Next;
    end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;
end;
procedure TResSchedList.SetConnection(const Value: TERPConnection);
begin
  fConnection:= Value;
end;

procedure TResSchedList.SummaryForDate(const aDate: TDateTime;var Capacity, Available,Overallocated: double);
var
  x: integer;
begin
  for x:= 0 to fList.Count -1 do begin
    if (dateof(Item[x].Date) = dateof(aDate)) then begin
      Capacity:= Capacity + Item[x].Capacity;
      Available:= Available + Item[x].Available;
      if Item[x].Available <0 then Overallocated := Overallocated + 0- Item[x].Available;
    end;
  end;

end;

constructor TProcResforDateDetails.Create(Aowner:TComponent);
begin
  inherited Create(AOwner);
  fiProcResforDateDetailsSeqno := fiProcResforDateDetailsSeqno +1;
  Seqno := fiProcResforDateDetailsSeqno;
  SetLength(Schedules,0);
end;
procedure TProcResforDateDetails.LoadAllocatins(Connection: TERPConnection);
var
  qry: TERPQuery;
begin
  if Connection = nil then Connection :=Commondblib.getsharedmydacconnection;
  Qry := DbSharedObj.GetQuery(Connection);
  try
    Qry.SQl.text :=  'Select * from  tblprocesstime where  ResourcedetailsID = ' + inttostr(ResourcedetailsID) + ' and ' +
                                                         ' ((TimeStart between ' + Quotedstr(formatDateTime(mySQLDateTimeformat , timefrom)) + ' and  ' + Quotedstr(formatDateTime(mySQLDateTimeformat , timeto)) + ') or ' +
                                                         ' (TimeEnd    between ' + Quotedstr(formatDateTime(mySQLDateTimeformat , timefrom)) + ' and  ' + Quotedstr(formatDateTime(mySQLDateTimeformat , timeto)) + ') or ' +
                                                         ' (TimeStart < ' + Quotedstr(formatDateTime(mySQLDateTimeformat , timefrom)) + ' and  TimeEnd >' + Quotedstr(formatDateTime(mySQLDateTimeformat , timeto)) + ')) ';
    Qry.Open;
    if Qry.recordcount =0 then exit;
    Qry.first;
    While Qry.Eof = False do begin
        NewSchedule(Qry.fieldbyname('Duration').AsInteger , Qry.fieldbyname('TimeStart').asDatetime);
        Qry.Next;
    end;
  finally
    DbSharedObj.ReleaseObj(Qry);
  end;

end;

procedure TProcResforDateDetails.NewSchedule(fDuration: Integer;fTimeStart: TDatetime);
begin
  SetLength(Schedules,length(Schedules)+1);
  Schedules[high(Schedules)]  := TSchedules.Create(Self);
  with Schedules[high(Schedules)] do begin
    Duration := fDuration;
    TimeFrom := fTimeStart;
    Timeto := incSecond(TimeFrom, Duration);
    try
      LogTExt(inttostr(ProcResforDate.ResourceId)+',' +
                            FormatDateTime('dd-mm-yy hh:nn:ss' , ProcResforDate.Date)+',' +
                            inttostr(Self.ResourcedetailsID) +',' +
                            FormatDateTime('dd-mm-yy hh:nn:ss' , Self.TimeFrom)+',' +
                            FormatDateTime('dd-mm-yy hh:nn:ss' , Self.TimeTo)+',' +
                            inttostr(Self.Capacity) +',' +
                            inttostr(Self.employeeId) +',' +
                            inttostr(Self.BreakdownHoursDay) +',' +
                            inttostr(Self.SetupHoursDay)+',' +
                            FormatDateTime('dd-mm-yy hh:nn:ss' , TimeFrom)+',' +
                            FormatDateTime('dd-mm-yy hh:nn:ss' , TimeTo)+',' +
                            inttostr(Duration));
    Except
      //kill the exception
    end;
  end;

end;
function TProcResforDateDetails.FirstslotSlot(fDate:TDateTime) : TSchedules;
var
  ctr :Integer;
begin
   Result := nil;
   if (fDate >timeto) then exit;
   if dateof(fdate) <> dateof(timeto) then exit;
   if ((fDate <timefrom) ) then fdate := timeFrom;

   if (Length(Schedules) = 0) then
       Result := TSchedules.NewInstance(Self, fDate , TimeTo , SecondsBetween(fDate , timeTo));
   REsult :=Schedules[low(Schedules)];
end;

function TProcResforDateDetails.NextAvailableSlot(fDate:TDateTime): TSchedules;
var
  ctr :Integer;
begin
   Result := nil;
   if (fDate >timeto) then exit;
   if dateof(fdate) <> dateof(timeto) then exit;
   if ((fDate <timefrom) ) then fdate := timeFrom;

   if (Length(Schedules) = 0) then begin
       Result := TSchedules.NewInstance(Self, fDate , TimeTo , SecondsBetween(fDate , timeTo));
   end else begin
      if fDate < timeFrom then fDate := TimeFrom;
      for ctr := low(Schedules) to high(Schedules) do begin
        if fDate < Schedules[ctr].TimeFrom then begin
          Result := TSchedules.NewInstance(Self, fDate , Schedules[ctr].TimeFrom , SecondsBetween(fDate, Schedules[ctr].TimeFrom));
          Exit;
        end else begin
          fDate := Schedules[ctr].Timeto(*incSecond(Schedules[ctr].Timeto,1)*);
        end;
      end;
      if Fdate < Timeto then
        Result := TSchedules.NewInstance(Self, fDate , TimeTo , SecondsBetween(fDate,timeTo));
   end;
end;

function TProcResforDateDetails.ProcResforDate: TProcResforDate;
begin
  REsult := nil ;
  if Assigned(Owner) then
    if Owner is TProcResforDate then
      REsult := TProcResforDate(Owner);
end;

{ TSchedules }

class function TSchedules.NewInstance(AOwner: Tcomponent; fTimeFrom,  fTimeTo: Tdatetime; fDuration: Integer): TSchedules;
begin
  REsult := nil;
  if ftimeFrom>= fTimeto then exit;
  Result :=TSchedules.Create(AOwner);
  Result.TimeFrom := ftimeFrom;
  Result.TimeTo   := ftimeTo;
  Result.Duration := fDuration;
end;

initialization
  fiProcResforDateDetailsSeqno:= 0;
end.
