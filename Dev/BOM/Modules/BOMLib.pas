unit BOMLib;

interface

uses
  ERPdbComponents, sysutils  , ProcCapacityPlanningObj,busobjbase , IntegerListobj, classes;


Type
  TSalesRelated = class(TComponent)
  Private
    Procedure DoConfirmQtysOnfinalisecallback(Const Sender: TBusObj; Var Abort: Boolean);
  Protected
  Public
    Procedure DoConfirmQtysOnfinalise(Sender: TBusObj);Overload;
  end;

Function IsResourceAvailableForWeekday(ResourceID:Integer; aDate:TDateTime;Connection: TERPConnection = nil):Boolean;

Procedure ResourceProcessCapacityForDate(ColRec: TColRec; const ResourceId: integer;
                               const aDate: TDateTime;
                               ProcessStepId: integer = 0;
                               Connection: TERPConnection = nil);
Function ProcResourceUnAvailability(ResourceDetailID:Integer; aFrom, aTo:TDateTime;Connection: TERPConnection = nil) : TERPQuery;
Function ProcessRostered(ResourceId,ProcessStepId:Integer):Boolean;
procedure MakeAssemblyProcess;
function DoJobComplete(SOList: TIntegerList; ConvertIncomplete: boolean; var msg: string): boolean;


implementation

uses DbSharedObjectsObj, AppEnvironment, MySQLConst, tcConst, CommonDbLib, dateutils,
  CommonLib, BusObjProcessStep, ProcessDataUtils, BusObjSales,
  frmsaleslineManufactureTotalQtyEdit, BusObjProcess;

var
  fProcResourceUnAvailability : TERPQuery;


{ TSalesRelated }

procedure TSalesRelated.DoConfirmQtysOnfinalise(Sender: TBusObj);
begin
  if sender is TSales then begin
        if AppEnv.CompanyPrefs.ConfirmQtysOnfinalise then begin
          TSales(sender).Lines.iteraterecords(DoConfirmQtysOnfinalisecallback);
        end;
  end else if sender is TSalesOrderline then begin
      if  TSalesOrderline(sender).IsTreeItem then begin
        if assigned( TSalesOrderline(sender).Container.ItemByClass(TSalesLineProcTree)) then begin
          TfmsaleslineManufactureTotalQtyEdit.EditsaleslineManufactureTotalQty(TERPConnection( TSalesOrderline(sender).Connection.Connection) ,
                                                                               TSalesOrderline(sender).ID,
                                                                               TSalesLineProcTree(TSalesOrderline(sender).Container.ItemByClass(TSalesLineProcTree)));
        end;
      end;
  end;
end;

Procedure TSalesRelated.DoConfirmQtysOnfinalisecallback(Const Sender: TBusObj; Var Abort: Boolean);
begin
  if sender is TSalesorderline then
    if TSalesorderline(Sender).IsTreeItem  then
      DoConfirmQtysOnfinalise(TSalesOrderline(Sender));
end;


{*AutoScheduleBasedonBOMEmpRoster*1}

function DoJobComplete(SOList: TIntegerList; ConvertIncomplete: boolean; var msg: string): boolean;
var
  fSalesRelatedObj:TSalesRelated;
  Function SalesRelatedObj: TSalesRelated;
  begin
    fSalesRelatedObj :=TSalesRelated.Create(nil);
    result := fSalesRelatedObj;
  end;
begin
      try
      result := ProcessDataUtils.DoJobComplete(SalesRelatedObj.DoConfirmQtysOnfinalise,SOList, ConvertIncomplete,msg);
      finally
        FreeandNil(fSalesRelatedObj);
      end;

end;

Function ProcResourceUnAvailability(ResourceDetailID:Integer; aFrom, aTo:TDateTime;Connection: TERPConnection = nil) : TERPQuery;
var
  s:String;
begin
  s:='select 1 as Details, ProcResourceDetailId DetailID, Description, TimeStart, TimeEnd from  tblprocresourceUnavailability ' +NL+
     ' Where ProcResourceDetailId =' + inttostr(ResourceDetailID)+NL+
     ' and ( (' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aFrom)) +' between  TimeStart and TimeEnd)  OR '+NL+
          ' (' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aTo  )) +' between  TimeStart and TimeEnd)  OR '+NL+
          ' (' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aFrom)) +'<= TimeStart and ' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aTo)) +'>= TimeEnd)  OR '+NL+
          ' (' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aFrom)) +'>= TimeStart and ' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aTo)) +'<= TimeEnd)  )'  +NL+
      ' union all ' +NL+
      ' Select 2 as Details, ResourceDetailsID DetailID, "Booked" as Description,  TimeStart, convert(DATE_ADD(TimeStart, INTERVAL Duration Second),DateTime) as TimeEnd from tblProcessTime ' +NL+
     ' Where ResourceDetailsID =' + inttostr(ResourceDetailID)+NL+
     ' and Status <> "psComplete" ' + NL+
     ' and ( (' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aFrom)) +' between  TimeStart and convert(DATE_ADD(TimeStart, INTERVAL Duration Second),DateTime))  OR '+NL+
          ' (' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aTo  )) +' between  TimeStart and convert(DATE_ADD(TimeStart, INTERVAL Duration Second),DateTime))  OR '+NL+
          ' (' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aFrom)) +'<= TimeStart and ' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aTo)) +'>= convert(DATE_ADD(TimeStart, INTERVAL Duration Second),DateTime))  OR '+NL+
          ' (' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aFrom)) +'>= TimeStart and ' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aTo)) +'<= convert(DATE_ADD(TimeStart, INTERVAL Duration Second),DateTime))  )' +NL+
      ' union all ' +NL+
      ' select  distinct 3 as details, ES.ResourceDetailId as DetailID , concat("Leave -" , ELR.type)  as Description,' +NL+
      ' ELR.StartTime as TimeStart, ELR.Endtime as TimeEnd' +NL+
      ' from tblempresprocschedule ES ' +NL+
      //' inner  join tblemployeeleaverequests ELR on DayofWeek(ELR.LeaveDate) = DayofWeek(ES.TimeFrom) and ES.EmployeeId = ELR.EmployeeId ' +NL+
      //' inner join tblroster ELR   on DayofWeek(ELR.Date) = DayofWeek(ES.TimeFrom) and ES.EmployeeId = ELR.EmployeeId  and (ELR.TYPE IN ("Annual Leave","Leave without Pay","Long Service","RDO","Sick Leave","Special Leave") or TYPE in ("UnAvailable")) ' +NL+
      ' inner join tblroster ELR   on DayofWeek(ELR.Date) = DayofWeek(ES.TimeFrom) and ES.EmployeeId = ELR.EmployeeId  and (ELR.TYPE IN ("Annual Leave","Leave without Pay","Long Service","RDO","' + Appenv.RegionalOptions.SLName +'","Special Leave") or TYPE in ("UnAvailable")) ' +NL+
     ' Where ES.ResourceDetailId =' + inttostr(ResourceDetailID)+NL+
     ' and ( (' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aFrom)) +' between  ELR.StartTime and ELR.EndTime)  OR '+NL+
          ' (' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aTo  )) +' between  ELR.StartTime and ELR.EndTime)  OR '+NL+
          ' (' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aFrom)) +'<= ELR.StartTime and ' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aTo)) +'>= ELR.EndTime)  OR '+NL+
          ' (' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aFrom)) +'>= ELR.StartTime and ' + Quotedstr(Formatdatetime(mySQLDateTimeFormat , aTo)) +'<= ELR.EndTime)  )'  +NL+
      '  Order by TimeStart ' ;

  if Connection <> nil then
    if (fProcResourceUnAvailability<> nil) and (fProcResourceUnAvailability.connection <> connection) then
      DbSharedObjectsObj.DbSharedObj.ReleaseObj(fProcResourceUnAvailability);


  if fProcResourceUnAvailability = nil then
    if connection =nil then
          fProcResourceUnAvailability := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection )
    else  fProcResourceUnAvailability := DbSharedObjectsObj.DbSharedObj.GetQuery(connection);

  if sametext(fProcResourceUnAvailability.sql.text , s) and (fProcResourceUnAvailability.active) then else begin
    closedb(fProcResourceUnAvailability);
    fProcResourceUnAvailability.SQL.Text := s;
    opendb(fProcResourceUnAvailability);
  end;
  result := fProcResourceUnAvailability;
end;
Function IsResourceAvailableForWeekday(ResourceID:Integer; aDate:TDateTime;Connection: TERPConnection = nil):Boolean;
var
  qry: TERPQuery;
begin
  if connection = nil then connection := GetSharedMyDacConnection ;
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(connection);
  try
       if Appenv.Companyprefs.AutoScheduleBasedonBOMEmpRoster then begin
          Qry.SQL.text := 'select * from tblempresprocschedule where resourceId =  ' +inttostr(ResourceID)+' and DayofWeek(TimeFrom) = DayofWeek('+ Quotedstr(FormatdateTime(MySQLDatetimeformat , adate)) +')';
          qry.Open;
          Result := Qry.recordcount >0;
       end else begin
          qry.SQL.Text:='Select ' +
                ' if (DAYOFWEEK(' + Quotedstr(Formatdatetime(mySQLDateFormat , aDate)) +')=1 and sunday   ="F" , "F" , ' +
                ' if (DAYOFWEEK(' + Quotedstr(Formatdatetime(mySQLDateFormat , aDate)) +')=2 and Monday   ="F" , "F" , ' +
                ' if (DAYOFWEEK(' + Quotedstr(Formatdatetime(mySQLDateFormat , aDate)) +')=3 and Tuesday  ="F" , "F" , ' +
                ' if (DAYOFWEEK(' + Quotedstr(Formatdatetime(mySQLDateFormat , aDate)) +')=4 and Wednesday="F" , "F" , ' +
                ' if (DAYOFWEEK(' + Quotedstr(Formatdatetime(mySQLDateFormat , aDate)) +')=5 and Thursday ="F" , "F" , ' +
                ' if (DAYOFWEEK(' + Quotedstr(Formatdatetime(mySQLDateFormat , aDate)) +')=6 and Friday   ="F" , "F" , ' +
                ' if (DAYOFWEEK(' + Quotedstr(Formatdatetime(mySQLDateFormat , aDate)) +')=7 and Saturday ="F" , "F" ,"T"))))))) Availability ' +
                ' from tblprocresourcedays PRD where PRD.ProcResourceID = ' +inttostr(ResourceID);
          qry.Open;
          Result := Qry.fieldbyname('Availability').asString = 'T';
       end;

  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

{*AutoScheduleBasedonBOMEmpRoster*2}
Procedure ResourceProcessCapacityForDate(ColRec: TColRec; const ResourceId: integer;
                               const aDate: TDateTime;
                               ProcessStepId: integer = 0;
                               Connection: TERPConnection = nil);
var
  qry: TERPQuery;
  fdt1, fdt2:TDateTime;
  s:String;
begin
  if connection = nil then connection := GetSharedMyDacConnection ;
  if not IsResourceAvailableForWeekday(ResourceId , aDate , connection) then exit;

  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(connection);
  try
        closedb(qry);
       if Appenv.Companyprefs.AutoScheduleBasedonBOMEmpRoster then begin
          qry.SQL.Text:= 'SELECT PR.ResourceName, DAYOFWEEK( ES.TimeFrom) dow1,DAYOFWEEK( ' + Quotedstr(FormatDateTime(MySQLDAteTimeFormat , dateof(aDate)))+') as dow2, '+NL+
                         ' PRD.ID  PRDID, ES.ID ESID, ES.EmployeeID, '+NL+
                         ' CONVERT(DATE_ADD( ' + Quotedstr(FormatDateTime(MySQLDAteTimeFormat , dateof(aDate)))+' , INTERVAL TIME_TO_SEC( time(ES.TimeFrom) ) second), DateTime) timefrom , '+NL+
                         ' CONVERT(DATE_ADD( ' + Quotedstr(FormatDateTime(MySQLDAteTimeFormat , dateof(aDate)))+' , INTERVAL TIME_TO_SEC( time(ES.Timeto) ) second), DateTime) timeto, '+NL+
                         ' PR.SetupHoursDay , PR.BreakdownHoursDay , SecondsBetween(ES.TimeFrom , ES.TimeTo) as Seconds'+NL+
                         ' FROM tblprocresource PR '+NL+
                         ' INNER JOIN tblprocresourcedetails PRD on PR.ProcResourceId = PRD.ProcResourceId '+NL+
                         ' INNER JOIN tblempresprocschedule ES on PRD.ID = ES.ResourceDetailId '+NL+
                         ' WHERE PR.UsedWithProductsInSeq ="F" and  PR.ResourceAvailable ="T" and  PRD.ResourceAvailable = "T" '+NL+
                         ' AND  DAYOFWEEK( ES.TimeFrom) = DAYOFWEEK( ' + Quotedstr(FormatDateTime(MySQLDAteTimeFormat , dateof(aDate)))+') '+NL+
                         ' AND (PRD.ClosedOnPublicHolidays="F" or Date(CONVERT(DATE_ADD( ' + Quotedstr(FormatDateTime(MySQLDAteTimeFormat , dateof(aDate)))+' , INTERVAL TIME_TO_SEC( time(ES.TimeFrom) ) second), DateTime)) not in (Select Day from tblpublicholidays))' ;
          if ProcessStepId > 0 then qry.SQL.Add('AND ES.ProcessStepId =' + inttostr(ProcessStepId));
          if ResourceId    > 0 then qry.SQL.Add('AND ES.ResourceID =' + inttostr(ResourceID));
          qry.SQL.Add('Order by timefrom');

          opendb(qry);
          if Qry.recordcount >0 then begin
            Qry.First;
            While Qry.Eof = False do begin
              s:= inttostr(Qry.fieldbyname('PRDID').asInteger)+','+ FormatDateTime('dd-mm-yy hh:nn:ss' ,Qry.fieldbyname('TimeFrom').asDateTime)+', '+ FormatDateTime('dd-mm-yy hh:nn:ss' ,Qry.fieldbyname('Timeto').asDateTime);
              With ProcResourceUnAvailability(Qry.fieldbyname('PRDID').asInteger ,Qry.fieldbyname('TimeFrom').asDateTime, Qry.fieldbyname('Timeto').asDateTime) do begin

                if recordcount =0 then begin
                   ColRec.NewSlot(aDate,
                                  ResourceId ,
                                  Qry.fieldbyname('PRDID').asInteger ,
                                  Qry.fieldbyname('ESID').AsInteger ,
                                  Qry.fieldbyname('EmployeeId').AsInteger,
                                  Qry.fieldbyname('TimeFrom').asDateTime,
                                  Qry.fieldbyname('Timeto').asDateTime,0);
                end else begin
                   fdt1:=Qry.fieldbyname('TimeFrom').asDateTime;
                   fdt2:=Qry.fieldbyname('Timeto').asDateTime;
                   First;

                   While EOF = False do begin

                    // make the allocated slot - for calculating total capacity
                    ColRec.NewSlot(aDate,
                                   ResourceId ,
                                   Qry.fieldbyname('PRDID').asInteger ,
                                   Qry.fieldbyname('ESID').AsInteger ,
                                   Qry.fieldbyname('EmployeeId').AsInteger,
                                   fieldbyname('TimeStart').asDateTime,
                                   fieldbyname('TimeEnd').asDateTime,
                                   SecondsBetween(fieldbyname('TimeStart').asDateTime,  fieldbyname('TimeEnd').asDateTime));


                     if (fdt1 < fieldbyname('TimeStart').asDateTime)  then begin
                          if fdt2 > fieldbyname('TimeStart').asDateTime then  begin
                                ColRec.NewSlot(aDate,
                                               ResourceId ,
                                               Qry.fieldbyname('PRDID').asInteger ,
                                               Qry.fieldbyname('ESID').AsInteger,
                                               Qry.fieldbyname('EmployeeId').AsInteger,
                                               fdt1,
                                               fieldbyname('TimeStart').asDateTime,
                                               0);
                          end else  begin
                                ColRec.NewSlot(aDate,
                                               ResourceId ,
                                               Qry.fieldbyname('PRDID').asInteger ,
                                               Qry.fieldbyname('ESID').AsInteger,
                                               Qry.fieldbyname('EmployeeId').AsInteger,
                                               fdt1,
                                               fdt2,
                                               0);
                          end;
                     end;
                     fdt1 := fieldbyname('TimeEnd').AsDateTime;
                     if fdt1>= fdt2 then break;
                     Next;
                   end;
                        if fdt1< fdt2 then begin
                          ColRec.NewSlot(aDate,
                                         ResourceId ,
                                         Qry.fieldbyname('PRDID').asInteger ,
                                         Qry.fieldbyname('ESID').AsInteger,
                                         Qry.fieldbyname('EmployeeId').AsInteger,
                                         fdt1,
                                         fdt2,
                                         0);
                        end;

                end;
              end;
              Qry.Next;
            end;
            Exit;
          end;
       end;
       if not(Appenv.Companyprefs.AutoScheduleBasedonBOMEmpRoster) or not (ProcessRostered(ResourceId,ProcessStepId)) then begin
          qry.SQL.Text:=  'Select Description , ResourceCount  , PRDetID ,  SetupHoursDay ,   BreakdownHoursDay , StartAt  ,   '+
                    'if (Date(date_add(StartAt  , INTERVAL round(CapacityHoursDay /ResourceCount,0) SECOND))<> date(StartAt ) , 		SecondsBetween(date(Date_add(StartAt ,Interval 1 Day)),StartAt ) , CapacityHoursDay) as CapacityHoursDay   '+
                    'from ( '+  NL +
                    ' SELECT  ifnull(PRDet.Description, PR.ResourceName) as Description, if(ifnull(PR.ResourceCount ,0)=0 ,1 , PR.ResourceCount) as ResourceCount, PRDet.Id as PRDetID,' +
                    ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =1 and PRD.Sunday   = "T" , PRD.SundayCapacityHoursDay , '+
                    ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =2 and PRD.Monday   = "T" , PRD.MondayCapacityHoursDay ,  '+
                    ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =3 and PRD.TuesDay  = "T" , PRD.TuesdayCapacityHoursDay ,  '+
                    ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =4 and PRD.Wednesday= "T" , PRD.WednesdayCapacityHoursDay ,  '+
                    ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =5 and PRD.Thursday = "T" , PRD.ThursdayCapacityHoursDay ,  '+
                    ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =6 and PRD.Friday   = "T" , PRD.FridayCapacityHoursDay ,  '+
                    ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =7 and PRD.Saturday = "T" , PRD.SaturdayCapacityHoursDay , 0))))))) CapacityHoursDay , '+
                    ' PR.SetupHoursDay, PR.BreakdownHoursDay,' +
                    ' CONVERT(DATE_ADD( ' + Quotedstr(FormatDateTime(MySQLDAteTimeFormat , dateof(aDate)))+' , INTERVAL TIME_TO_SEC( ERPTimeToTime('+
                    ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =1 and PRD.Sunday   = "T" , PRD.SundayStartAt , '+
                    ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =2 and PRD.Monday   = "T" , PRD.MondayStartAt ,  '+
                    ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =3 and PRD.TuesDay  = "T" , PRD.TuesdayStartAt ,  '+
                    ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =4 and PRD.Wednesday= "T" , PRD.WednesdayStartAt ,  '+
                    ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =5 and PRD.Thursday = "T" , PRD.ThursdayStartAt ,  '+
                    ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =6 and PRD.Friday   = "T" , PRD.FridayStartAt ,  '+
                    ' if(DAYOFWEEK( ' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ') =7 and PRD.Saturday = "T" , PRD.SaturdayStartAt , 0)))))))) ) second), DateTime) StartAt  '+
                    ' FROM tblProcResource PR INNER JOIN tblprocresourcedetails PRDet on PR.ProcResourceId = PRDet.ProcResourceId  '+
                    ' INNER JOIN tblProcResourceDays PRD on PRD.ProcResourceID = PR.ProcResourceId ';
                  if (ProcessStepId > 0) and (TProcessStep.ValidateProcessStep(ProcessStepId)) then qry.SQL.Add('JOIN tblProcResourceProcess PRP ON PRP.ProcResourceId = PR.ProcResourceId' +
                                                        ' AND PRP.ProcessStepId = ' +IntToStr(ProcessStepId));
                  qry.SQL.Add(' LEFT JOIN tblProcResourceAvailability RA ON RA.ProcResourceId = PR.ProcResourceId' +
                              ' WHERE PR.UsedWithProductsInSeq ="F" and  PR.ResourceAvailable = "T"');
                  if ResourceId > 0 then qry.SQL.Add(' AND PR.ProcResourceId = ' +IntToStr(ResourceId));
                  qry.SQL.Add(' AND ISNULL( RA.TimeStart) OR ' +
                              ' NOT ((' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ' >=  RA.TimeStart)' +
                              ' AND (' + QuotedStr(FormatDateTime(MysqlDateFormat,aDate)) + ' <=  RA.TimeEnd))'); {*AutoScheduleBasedonBOMEmpRoster*2}
          qry.SQL.Add(' ) as Details');
          opendb(qry);
          if Qry.recordcount > 0 then begin
            Qry.first;
            While Qry.eof = False do begin
              ColRec.NewSlot(Qry.fieldbyname('StartAt').asDatetime,
                             ResourceId ,
                             Qry.fieldbyname('PRDetID').asInteger , 0,0,
                             Qry.fieldbyname('StartAt').asDatetime,
                             incSecond(Qry.fieldbyname('StartAt').asDatetime ,trunc(Qry.fieldbyname('CapacityHoursDay').asfloat)),0);
              Qry.next;
            end;
          end;

       end;
 finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;


Function ProcessRostered(ResourceId,ProcessStepId:Integer):Boolean;
var
  qry: TERPQuery;
begin
  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection );
  try
      Qry.sql.text := 'Select Count(pr.ProcResourceId) ctr '+
                         ' FROM tblprocresource PR '+NL+
                         ' INNER JOIN tblprocresourcedetails PRD on PR.ProcResourceId = PRD.ProcResourceId '+NL+
                         ' INNER JOIN tblempresprocschedule ES on PRD.ID = ES.ResourceDetailId ';

      if ProcessStepId > 0 then qry.SQL.Add('AND ES.ProcessStepId =' + inttostr(ProcessStepId));
      if ResourceId    > 0 then qry.SQL.Add('AND ES.ResourceID =' + inttostr(ResourceID));
      Qry.open;
      result := Qry.fieldbyname('ctr').asInteger  >0;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;
end;

procedure MakeAssemblyProcess;
begin
  TProcessStep.IdForDescription('Assembly' , nil , True);

(*var
  Qry: TERPQuery;
  ProcessId,resourceID:Integer;
begin
  resourceID:= 0;


  qry := DbSharedObjectsObj.DbSharedObj.GetQuery(GetSharedMyDacConnection );
  try
    Qry.Connection := commondblib.GetNewMyDacConnection(Qry);
    Qry.Connection.StartTransaction;
    try
      if Qry.active then Qry.close;
      Qry.SQL.clear;
      Qry.SQL.add('Select * from tblprocessstep where Description = ' + Quotedstr('Assembly'));
      Qry.open;
      if Qry.recordcount =1 then begin
        if Qry.FieldByname('Active').asBoolean = False then begin
            Qry.Edit;
            Qry.FieldByname('Active').asBoolean := TRue;
            Qry.Post;
        end;
      end else begin
        Qry.Append;
        Qry.FieldByname('Description').asString := 'Assembly';
        Qry.FieldByname('Active').asBoolean := TRue;
        Qry.Post;
      end;
      ProcessId:= Qry.Fieldbyname('ID').asInteger;

      {check for Resource with process Assembly}
            if Qry.active then Qry.close;
            Qry.SQL.clear;
            Qry.SQL.add('Select * from tblprocresourceprocess where tblprocresourceprocess.ProcessStepId =  ' + inttostr(ProcessId));
            Qry.open;
            if Qry.recordcount >0 then begin
              resourceID := Qry.fieldByname('ProcresourceID').asInteger;
              if Qry.active then Qry.close;
                Qry.SQL.clear;
                Qry.SQL.add('Select * from tblProcResource where   ProcresourceID = ' + inttostr(resourceID));
                Qry.open;
                if Qry.recordcount >0 then begin
                  if Qry.FieldByname('Active').asBoolean = False then begin
                      Qry.Edit;
                      Qry.FieldByname('Active').asBoolean := TRue;
                      Qry.Post;
                  end;
                  Exit;
                end;
            end;
      {if resource with process Assembly doesn't exists  - check for resource Assembly and make if missing}
            if resourceID =0 then begin
              if Qry.active then Qry.close;
              Qry.SQL.clear;
              Qry.SQL.add('Select * from tblProcResource where   Description = ' + Quotedstr('Assembly'));
              Qry.open;
              if Qry.recordcount >0 then begin
                if Qry.FieldByname('Active').asBoolean = False then begin
                    Qry.Edit;
                    Qry.FieldByname('Active').asBoolean := TRue;
                    Qry.Post;
                end;
              end else begin
                Qry.Append;
                Qry.FieldByname('Description').asString := 'Assembly';
                Qry.FieldByname('ResourceName').asString := 'Assembly';
                Qry.FieldByname('Active').asBoolean := TRue;
                Qry.FieldByname('ResourceAvailable').asBoolean := TRue;
                Qry.FieldByname('HourlyLabourRate').asFloat := 30;
                Qry.Post;
              end;
              resourceID:= Qry.Fieldbyname('ProcResourceID').asInteger;
            end;

      if Qry.active then Qry.close;
      Qry.SQL.clear;
      Qry.SQL.Add('Select * from tblprocresourcedays where ProcResourceID = ' + inttostr(resourceID));
      Qry.open;
      if Qry.recordcount =0 then begin
        Qry.Append;
        Qry.Fieldbyname('ProcResourceID').asInteger :=resourceID;
        Qry.Fieldbyname('Sunday').asBoolean    := not IsWeekendday(7);
        Qry.Fieldbyname('Monday').asBoolean    := not IsWeekendday(1);
        Qry.Fieldbyname('Tuesday').asBoolean   := not IsWeekendday(2);
        Qry.Fieldbyname('Wednesday').asBoolean := not IsWeekendday(3);
        Qry.Fieldbyname('Thursday').asBoolean  := not IsWeekendday(4);
        Qry.Fieldbyname('Friday').asBoolean    := not IsWeekendday(5);
        Qry.Fieldbyname('Saturday').asBoolean  := not IsWeekendday(6);
        if Qry.Fieldbyname('Sunday').asBoolean    then Qry.Fieldbyname('SundayCapacityHoursDay').asFloat    := 8*60*60;
        if Qry.Fieldbyname('Monday').asBoolean    then Qry.Fieldbyname('MondayCapacityHoursDay').asFloat    := 8*60*60;
        if Qry.Fieldbyname('Tuesday').asBoolean   then Qry.Fieldbyname('TuesdayCapacityHoursDay').asFloat   := 8*60*60;
        if Qry.Fieldbyname('wednesday').asBoolean then Qry.Fieldbyname('WednesdayCapacityHoursDay').asFloat := 8*60*60;
        if Qry.Fieldbyname('Thursday').asBoolean  then Qry.Fieldbyname('ThursdayCapacityHoursDay').asFloat  := 8*60*60;
        if Qry.Fieldbyname('Friday').asBoolean    then Qry.Fieldbyname('FridayCapacityHoursDay').asFloat    := 8*60*60;
        if Qry.Fieldbyname('Saturday').asBoolean  then Qry.Fieldbyname('SauturdayCapacityHoursDay').asFloat := 8*60*60;
        Qry.Post;
      end;

      if Qry.active then Qry.close;
      Qry.SQL.clear;
      Qry.SQL.add('Select * from tblProcResourceProcess '+
                  ' Where /*ProcResourceId = ' + inttostr(resourceID) +
                  '   and */ ProcessStepId = ' +inttostr(ProcessId));
      Qry.open;

      if Qry.recordcount >0 then begin
      end else begin
        Qry.Append;
        Qry.FieldByname('ProcResourceId').asInteger := resourceID;
        Qry.FieldByname('ProcessStepId').asInteger := ProcessId;
        Qry.Post;
      end;
      Qry.Connection.Commit;
    Except
      on E:Exception do begin
        Qry.Connection.Rollback;
      end;
    end;
  finally
    DbSharedObjectsObj.DbSharedObj.ReleaseObj(qry);
  end;*)

end;

initialization
  fProcResourceUnAvailability := nil;

finalization
  if fProcResourceUnAvailability <> nil then DbSharedObjectsObj.DbSharedObj.ReleaseObj(fProcResourceUnAvailability);

end.
