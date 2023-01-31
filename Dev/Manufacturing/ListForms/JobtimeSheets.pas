unit JobtimeSheets;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseListingForm, kbmMemTable, DB,  Menus,
  AdvMenus, ProgressDialog, DBAccess, MyAccess, ERPdbComponents, MemDS,
  ExtCtrls, wwDialog, Wwlocate, SelectionDialog, ActnList, PrintDAT,
  ImgList, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwdbdatetimepicker,
  StdCtrls, wwdblook, Shader, AdvOfficeStatusBar, DNMPanel, DNMSpeedButton,
  DBCtrls, DAScript, MyScript, wwcheckbox, CustomInputBox, wwclearbuttongroup,
  wwradiogroup, GIFImg;

type
  TJobtimeSheetsGUI = class(TBaseListingGUI)
    qryMaincaption: TWideStringField;
    qryMainProductId: TIntegerField;
    qryMainStatusno: TIntegerField;
    qryMainSaleId: TIntegerField;
    qryMainSaleDocNumber: TWideStringField;
    qryMainEmployeeClockonStatus: TWideStringField;
    QrymainEmployeeClockonStatusDate:TdateTimefield;
    qryMainSaleCustomerName: TWideStringField;
    qryMainSaleClassId: TIntegerField;
    qryMainSaleShipDate: TDateField;
    qryMainSaleDate: TDateField;
    qryMainSaleLineId: TIntegerField;
    qryMainLineProductName: TWideStringField;
    qryMainLineProductDescription: TWideStringField;
    qryMainLineQty: TFloatField;
    qryMainLineShipDate: TDateTimeField;
    qryMainComplete: TWideStringField;
    qryMainStatus: TWideStringField;
    qryMainCStatus: TWideStringField;
    qryMainEmployeename: TWideStringField;
    qryMainProcTreeId: TIntegerField;
    qryMainTimestart: TDateTimeField;
    qryMaintimeEnd: TDateTimeField;
    qryMainProcess: TWideStringField;
    memprocesses: TDBMemo;
    qryMainScheduledtimestart: TDateTimeField;
    qryMainScheduledtimeEnd: TDateTimeField;
    qryMainScheduledTime: TFloatField;
    qryMaintimeTaken: TFloatField;
    qryMaincTimeTaken: TWideStringField;
    qryMainCProcess: TWideStringField;
    qryMaintimeTakeninHr: TFloatField;
    qryMainconverted: TWideStringField;
    grpOptions: TRadioGroup;
    qryMainClientID: TIntegerField;
    qryMainPPTId: TLargeintField;
    QryjobsfortimesheetEntry: TERPQuery;
    QryjobsfortimesheetEntryTimesheetDate: TDateTimeField;
    QryjobsfortimesheetEntrytimeTakeninHr: TFloatField;
    QryjobsfortimesheetEntryTotal: TFloatField;
    QryjobsfortimesheetEntryEmployeeID: TLargeintField;
    QryjobsfortimesheetEntryEmployeename: TWideStringField;
    QryjobsfortimesheetEntryCost: TFloatField;
    QryjobsfortimesheetEntryClientID: TIntegerField;
    QryjobsfortimesheetEntryClassID: TIntegerField;
    QryjobsfortimesheetEntryClass: TWideStringField;
    QryjobsfortimesheetEntryPartsId: TIntegerField;
    QryjobsfortimesheetEntryPARTNAME: TWideStringField;
    QryjobsfortimesheetEntryPARTSDESCRIPTION: TWideStringField;
    QryjobsfortimesheetEntrySaleID: TIntegerField;
    QryjobsfortimesheetEntrySaleLineID: TIntegerField;
    QryjobsfortimesheetEntrycustomername: TWideStringField;
    QryjobsfortimesheetEntrypptID: TLargeintField;
    btntimesheet: TDNMSpeedButton;
    qryMainTimeSheetCreated: TWideStringField;
    grdTimesheet: TRadioGroup;
    lblMsg: TLabel;
    qryMaincScheduledTime: TWideStringField;
    qryMainDETAILS: TIntegerField;
    procedure qryMainCalcFields(DataSet: TDataSet);
    procedure grpFiltersClick(Sender: TObject);Override;
    procedure grdMainCalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont;
      ABrush: TBrush);
    procedure qryMainAfterScroll(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure grdMainDblClick(Sender: TObject);Override;
    procedure btntimesheetClick(Sender: TObject);
    procedure grdMainMultiSelectRecord(Grid: TwwDBGrid; Selecting: Boolean;
      var Accept: Boolean);
    procedure grdMainExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qryMainAfterOpen(DataSet: TDataSet);
  private
    Tablename :String;
    Procedure PopulateTable;
    procedure initemployeeParams;
  Protected
    Procedure SetGridColumns;Override;
    Procedure DoShowLookuplist; override;
    procedure OnEmployeeSelection(Sender:TObject);override;
    function DEfaultSelectedEmployeeID: Integer;override;
    Procedure DoQrymainafteropen;Override;
    procedure ReadnApplyGuiPrefExtra; Override;
    Procedure WriteGuiPrefExtra; Override;
  public
    Procedure RefreshQuery; override;
  end;


implementation

uses CommonLib, FastFuncs, ProcessUtils, frmBarCodeManufacturing,
  CommonDbLib, BusObjTimeSheet, BusObjBase, AppEnvironment, IntegerListObj,
  frmPayTimesheetFrm, CommonFormLib, tcDataUtils, MySQLConst, tcConst, LogLib;

{$R *.dfm}
procedure TJobtimeSheetsGUI.qryMainCalcFields(DataSet: TDataSet);
begin
  inherited;
       if Sysutils.SameText(qryMainStatus.asString , ProcessPartStatusToStr(psComplete))       then qryMainCStatus.asString := PS_STR_COMPLETE
  else if Sysutils.SameText(qryMainStatus.asString , ProcessPartStatusToStr(psScheduled))      then qryMainCStatus.asString := PS_STR_SCHEDULED
  else if Sysutils.SameText(qryMainStatus.asString , ProcessPartStatusToStr(psStarted))        then qryMainCStatus.asString := PS_STR_STARTED
  else if Sysutils.SameText(qryMainStatus.asString , ProcessPartStatusToStr(psNotScheduled))   then qryMainCStatus.asString := PS_STR_NOTSCHEDULED
  else if Sysutils.SameText(qryMainStatus.asString , ProcessPartStatusToStr(psQualityAssurance))   then qryMainCStatus.asString := PS_STR_QualityAssurance
  else if Pos(PS_STARTED   , qryMainStatus.asString )<> 0   then qryMainCStatus.asString := PS_STR_STARTED
  else if Pos(PS_COMPLETE  , qryMainStatus.asString )<> 0   then qryMainCStatus.asString := PS_STR_STARTED
  else if Pos(PS_SCHEDULED , qryMainStatus.asString )<> 0   then qryMainCStatus.asString := PS_STR_SCHEDULED
  else if Pos('From Stock' , qryMainStatus.asString )<> 0   then qryMainCStatus.asString := 'From Stock'
  else qryMainCStatus.asString := PS_STR_NOTSCHEDULED;

  qryMaincTimeTaken.asString := CommonLib.secondstotime(trunc(qryMaintimeTaken.asFloat),true);
  if QrymainProcess.asString = '' then QrymainCProcess.asString := '(No Process for this Job)' else QrymainCProcess.asString := QrymainProcess.asString; 
end;

procedure TJobtimeSheetsGUI.grpFiltersClick(Sender: TObject);
 Procedure Addfilter(const value:String);
  begin
    if value = '' then exit;
    if GroupFilterString <> '' then GroupFilterString := GroupFilterString + ' and ';
    GroupFilterString := GroupFilterString + value;
  end;
  
begin
  GroupFilterString := '';
       if grpOptions.ItemIndex = 0 then Addfilter ('(Details =1 )')
  else if grpOptions.ItemIndex = 1 then Addfilter ('(Details =2 )')
  else if grpOptions.ItemIndex = 2 then Addfilter ('(Details =2 or Details =3 )');

  if grdTimesheet.itemindex = 0 then begin
    Addfilter ('(Details =2 or Details =1 or TimesheetCreated = "T" )');
    grdMain.Options := grdMain.Options - [dgMultiSelect];
    btntimesheet.enabled := False;
  end else begin
    Addfilter ('(TimesheetCreated = "F")');
    grdMain.Options := grdMain.Options + [dgMultiSelect];
    btntimesheet.enabled := true;
  end;
       if grpFilters.Itemindex = 0 then Addfilter ('(Status =  '+QuotedStr(PS_NOTSCHEDULED)+' and Converted <>"T")' )
  else if grpFilters.Itemindex = 1 then Addfilter ('(Status <> '+QuotedStr(PS_NOTSCHEDULED)+' and Status <>'+QuotedStr(PS_COMPLETE)+' and  Converted <>"T")' )
  else if grpFilters.ItemIndex = 2 then Addfilter ('(Status ='+QuotedStr(PS_COMPLETE) +' or Converted ="T")' );

(*         if grpFilters.Itemindex = 0 then Addfilter ('(Statusno = 1 and  Converted <>"T")' )
  else if grpFilters.Itemindex = 1 then Addfilter ('(Statusno >1 and Statusno <6 and  Converted <>"T")' )
  else if grpFilters.ItemIndex = 2 then Addfilter ('(Statusno = 6 or Converted ="T")' );*)

  inherited grpFiltersClick(Sender);
end;

procedure TJobtimeSheetsGUI.OnEmployeeSelection(Sender: TObject);
begin
  inherited;
  (*closedb(qrymain);
  initemployeeParams;
  opendb(qrymain);*)
end;
procedure TJobtimeSheetsGUI.initemployeeParams;
begin
(*  Qrymain.ParamByName('Allemployee').AsString := iif(AllEmployees , 'T' , 'F');
  Qrymain.ParamByName('EmployeeName').AsString := tcdatautils.getemployeeName(SelectedEmployeeID);*)
end;

procedure TJobtimeSheetsGUI.PopulateTable;
var
  st:TStringlist;
begin
  st:= TStringlist.create;
  try
    st.Add('/*01*/truncate ' +tablename +';');
    st.Add('/*02*/insert into ' +tablename +'(PPID, PPTId,ClientID,converted,caption,Details,ProductId,SaleId,SaleDocNumber,SaleCustomerName,SaleClassId,SaleShipDate,SaleDate,'+
            ' SaleLineId,LineProductName,LineProductDescription,LineQty,LineShipDate,'+
            ' ProcTreeId,Complete,Status,Employeename,EmployeeId, Timestart,timeEnd,/*TimeEnd1,*/timeTaken,timeTakeninHr,'+
            ' Process,TimeSheetCreated) '+
            ' SELECT   distinct PP.ID, PPT.Id as PPTId, s.ClientID , S.converted, pt.caption , 3 as Details ,SL.ProductId,  ' +
            ' s.SaleId, s.InvoiceDocNumber as SaleDocNumber, s.CustomerName as SaleCustomerName, s.ClassId as SaleClassId,  ' +
            ' s.ShipDate as SaleShipDate, s.SaleDate,sl.SaleLineId, sl.ProductName as LineProductName,  ' +
            ' sl.Product_Description as LineProductDescription, sl.UnitOfMeasureShipped as LineQty, sl.ShipDate as LineShipDate, ' +
            ' pt.ProcTreeId ,PT.Complete , ' +
            ' PP.Status as Status, ' +
            ' E.Employeename ,E.employeeId,  PPT.Timestart, PPt.timeEnd, /*PPT.TimeEnd TimeEnd1,*/ ' +
            '       secondsBetween( PPT.timeStart, if(ifnull(PPT.timeEnd,0)=0 ,CURRENT_TIMESTAMP , PPT.timeEnd)) timeTaken, ' +
            ' ROUND(SecondsBetween( PPT.timeStart, if(ifnull(PPT.timeEnd,0)=0 ,CURRENT_TIMESTAMP , PPT.timeEnd)) /60/60,2) timeTakeninHr, ' +
            ' PS.Description as Process, ' +
            ' if(ifnull(TS.processparttimesheetID ,0)=0 , "F" , "T") TimeSheetCreated ' +
            ' FROM ' +
            ' tblSales s ' +
            ' inner join  tblSalesLines sl on sl.SaleId = s.SaleId and (SL.BOMGroupedLine ="F" or SL.BOMProductionLine ="T" )' +
            ' inner join  tblProcTree pt on pt.MasterId = sl.SaleLineId    and pt.MasterType = "mtSalesOrder" ' +
            ' inner join tblprocesspart PP on pt.ProcTreeId = pp.ProcTreeID ' +
            ' inner join tblProcessStep PS on PS.ID = PP.ProcessStepId ' +
            ' LEFT join tblprocessparttimesheet PPT on PP.Id = PPt.ProcessPartID and PPT.Active ="T" ' +
            ' LEFT  join tblemployees E on e.employeeId = PPt.EmployeeID ' +
            ' Left join tbltimesheets TS on TS.processparttimesheetID = PPT.Id ' +
            ' Where s.SaleDate between ' +Quotedstr(FormatDatetime(MysqlDateTimeFormat, FilterDateFrom)) +' AND ' +Quotedstr(FormatDatetime(MysqlDateTimeFormat, FilterDateTo)) +
            iif(AllEmployees , '' , ' and PPt.EmployeeID  = ' + inttostr(SelectedEmployeeID))+';');
    (*st.Add('/* */update ' + tablename +' Set  timeTaken =    Convert(Time_to_Sec(timediff(if(ifnull(timeEnd,0)=0 ,CURRENT_TIMESTAMP , timeEnd), timeStart)) , DECIMAL(65,2));');
    st.Add('/* */update ' + tablename +' Set  timeTakeninHr =   Convert(Round(Time_to_sec(timediff(if(ifnull(timeEnd,0)=0 ,CURRENT_TIMESTAMP , timeEnd), timeStart)) /60/60,2) , DECIMAL(65,2));');*)

    (*st.Add('/* */update ' + tablename +' Set  timeTaken     =   secondsBetween(if(ifnull(timeEnd,0)=0 ,CURRENT_TIMESTAMP , timeEnd), timeStart);');
    st.Add('/* */update ' + tablename +' Set  timeTakeninHr =   ROUND(SecondsBetween(if(ifnull(timeEnd,0)=0 ,CURRENT_TIMESTAMP , timeEnd), timeStart) /60/60,2);');*)


    st.Add('/*03*/Drop table if exists ' +tablename +'1;');
    st.Add('/*04*/create table ' +tablename +'1  ' +
            ' Select PT.ProcessPartId ,  ' +
            ' Min(PT.Timestart) as Scheduledtimestart, ' +
            ' Max(PT.Timestart) as ScheduledtimeEnd, ' +
            ' Round(sum(PT.Duration),2) ScheduledTime,  ' +
            ' /*SEC_TO_TIME*/FormatSecondsTotime(Round(sum(PT.Duration),2)) cScheduledTime   ' +
            ' from tblprocesstime  PT /*inner join ' +tablename +' T   on PT.ProcessPartId = T.PPID*/ group by PT.ProcessPartId; ');

    st.Add('/*05*/alter table ' +tablename +'1 Add index ProcessPartId (ProcessPartId);');;
    st.Add('/*06*/update ' +tablename +' t inner join ' +tablename +'1 as T1 on T.ppid =T1.ProcessPartId  ' +
            ' Set T.Scheduledtimestart = T1.Scheduledtimestart ,  ' +
            ' T.ScheduledtimeEnd = T1.ScheduledtimeEnd ,  ' +
            ' T.ScheduledTime = T1.ScheduledTime ,  ' +
            ' t.cScheduledTime = t1.cScheduledTime;');

    st.Add('/*07*/insert into ' +tablename +'(PPTId,ClientID,converted,caption,Details,ProductId,SaleId,SaleDocNumber,SaleCustomerName,SaleClassId,SaleShipDate,SaleDate,'+
            ' SaleLineId,LineProductName,LineProductDescription,LineQty,LineShipDate,'+
            ' ProcTreeId,Complete,Employeename,Status,'+
            ' TimeSheetCreated) '+
            ' SELECT  distinct 0, s.ClientID , S.converted, pt.caption , 2 as Details ,SL.ProductId,  s.SaleId, '+
            ' s.InvoiceDocNumber as SaleDocNumber, s.CustomerName as SaleCustomerName, s.ClassId as SaleClassId, s.ShipDate as SaleShipDate, s.SaleDate,'+
            ' sl.SaleLineId, sl.ProductName as LineProductName, sl.Product_Description as LineProductDescription, sl.UnitOfMeasureShipped as LineQty, sl.ShipDate as LineShipDate,'+
            ' pt.ProcTreeId ,PT.Complete ,'+
            ' "","From Stock",'+
            ' "F"'+
            ' FROM'+
            ' tblSales s'+
            ' inner join  tblSalesLines sl on sl.SaleId = s.SaleId and (SL.BOMGroupedLine ="F" or SL.BOMProductionLine ="T" )' +
            ' inner join  (tblProcTree pt  inner join tblprocesspart PPP on PT.ProcTreeId = ppP.ProcTreeID and (ifnull(ppP.ProcTreeID,0)<> 0 ) '+
                                          ' LEFT join tblprocessparttimesheet PPT on PPP.Id = PPt.ProcessPartID and PPT.Active ="T"  ) on pt.MasterId = sl.SaleLineId    and pt.MasterType = "mtSalesOrder"'+
            ' Where (PT.ParentId = 0 or ifnull(pt.ProcTreeID,0)<> 0)'+
            ' and s.SaleDate between ' +Quotedstr(FormatDatetime(MysqlDateTimeFormat, FilterDateFrom)) +' AND ' +Quotedstr(FormatDatetime(MysqlDateTimeFormat, FilterDateTo)) +
            iif(AllEmployees , '' , ' and PPt.EmployeeID  = ' + inttostr(SelectedEmployeeID))+
            ' group by pt.ProcTreeId;');

    st.Add('/*08*/Drop table if exists ' +tablename +'1;');
    st.Add('/*09*/Create table ' +tablename +'1 '+
            ' Select T.SaleLineID, group_concat(distinct ppd.Status) status '+
            ' from tblProcTree ptd '+
            ' Inner JOIN tblProcessPart PPd on PPd.ProcTreeId = PTd.ProcTreeId '+
            ' inner join ' +tablename + ' T  on  ptd.MasterId = T.SaleLineId and ptd.MasterType = "mtSalesOrder" group by T.SaleLineID;');

    st.Add('/*10*/update ' +tablename +' T inner join ' +tablename +'1 T1 on T.SaleLineId = T1.SaleLineId Set t.Status = ifnull(T1.Status , "From Stock") where T.Details = 2;');
    st.Add('/*11*/Drop table if exists ' +tablename +'1;');
    st.Add('/*12*/Create table ' +tablename +'1 '+
            '   Select '+
            '   t.ProcTreeId , '+
            '   Convert(Min(PPT.Timestart), DateTime) Timestart, '+
            '   Convert(Max(PPT.Timeend), DateTime) timeEnd, '+
            '   /*Convert(ifnull(Min(PPT.Timeend),0), DateTime) TimeEnd1, */'+
            (*'   sum(Time_to_sec(TimeDiff(ifnull(PPT.timeEnd,current_Timestamp), ifnull(PPt.TimeStart,0)))) timeTaken, '+
            '   sum(Round(Time_to_sec(TimeDiff(ifnull(PPT.timeEnd,current_Timestamp), ifnull(PPt.TimeStart,0)))/60/60,2)) 	 timeTakeninHr '+*)

            '   sum(      SecondsBetween(ifnull(PPt.TimeStart,0), ifnull(PPT.timeEnd,current_Timestamp) )) timeTaken, '+
            '   sum(Round(SecondsBetween(ifnull(PPt.TimeStart,0), ifnull(PPT.timeEnd,current_Timestamp) )/60/60,2)) 	 timeTakeninHr '+

            '   from tblprocessparttimesheet PPT '+
            '   inner join tblprocesspart pp on PP.Id = PPt.ProcessPartID and ppt.active = "T" '+
            '   inner join ' +tablename +' T on pp.ProcTreeID  =t.ProcTreeId '+
            '   where  T.Details = 2  '+
            '   Group by T.ProctreeID;');
    st.Add('/*13*/update ' +tablename +' T inner join ' +tablename +'1 T1 on T.ProcTreeId = T1.ProcTreeId  '+
            '   Set t.Timestart = T1.Timestart, '+
            '   T.timeEnd = T1.timeEnd ,  '+
            '   /*t.TimeEnd1  = T1.TimeEnd1, */'+
            '   T.timeTaken = T1.timeTaken,  '+
            '   T.timeTakeninHr = T1.timeTakeninHr '+
            '   where T.Details = 2;');

    st.Add('/*14*/Drop table if exists ' +tablename +'1;');
    st.Add('/*15*/Create table ' +tablename +'1 '+
            '   Select T.ProcTreeId, Min(PT.Timestart)  as Scheduledtimestart, '+
            '   Max(PT.Timestart) as ScheduledtimeEnd '+
            '   from tblprocesstime PT inner  join tblprocesspart PP on PT.ProcessPartId = pp.ID  '+
            '   inner join '+ tablename +' T on T.ProcTreeId = pp.ProcTreeID '+
            '   where ifnull(PT.Timestart,0)>="1899-12-31" and T.Details = 2'+
            '  group by T.ProcTreeId;');

    st.Add('/*16*/update ' +tablename +' T inner join ' +tablename +'1 T1 on T.ProcTreeId = T1.ProcTreeId  '+
            '   Set /*t.Timestart = T1.Scheduledtimestart,*/ '+
            '   T.Scheduledtimestart = T1.Scheduledtimestart ,  '+
            '   T.ScheduledtimeEnd = T1.ScheduledtimeEnd '+
            '   where T.Details = 2;');

    st.Add('/*17*/Drop table if exists ' +tablename +'1;');
    st.Add('/*18*/Create table ' +tablename +'1  '+
            '   Select PP.ProcTreeId , Round(sum(PT.Duration),2)  ScheduledTime, '+
            '   /*SEC_TO_TIME*/FormatSecondsTotime(Round(sum(PT.Duration),2)) cScheduledTime'+
            '   from tblprocesstime PT '+
            '   inner  join tblprocesspart PP on PT.ProcessPartId = pp.ID '+
            '   /*inner join '+ tablename +' T on T.ProcTreeId = pp.ProcTreeID */'+
            '   where ProcessPartId = pp.ID /*and T.Details = 2*/'+
            '  group by PP.ProcTreeId;');

    st.Add('/*19*/update ' +tablename +' T inner join ' +tablename +'1 T1 on T.ProcTreeId = T1.ProcTreeId  '+
            '   Set T.ScheduledTime = T1.ScheduledTime ,  '+
            '   T.cScheduledTime = T1.cScheduledTime '+
            '   where T.Details = 2;');

    st.Add('/*20*/Drop table if exists ' +tablename +'1;');
    st.Add('/*21*/Create table ' +tablename +'1  '+
            '   Select T.ProcTreeId , Group_concat(concat(Ps.Description," ")) Process'+
            '   from tblProcessStep PS'+
            '   inner  join tblprocesspart PP on PP.ProcessStepId = PS.ID' +
            '   inner join '+ tablename +' T on T.ProcTreeId = pp.ProcTreeID '+
            '   where /*T.PPID = pp.ID and */ T.Details = 2'+
            '  group by T.ProcTreeId;');

    st.Add('/*22*/update ' +tablename +' T inner join ' +tablename +'1 T1 on T.ProcTreeId = T1.ProcTreeId  '+
            '   Set  T.Process = T1.Process '+
            '   where T.Details = 2;');



    st.Add('/*23*/insert into ' +tablename +'(PPTId,ClientID,converted,caption,Details,ProductId,SaleId,SaleDocNumber,SaleCustomerName,SaleClassId,SaleShipDate,SaleDate,'+
            ' SaleLineId,LineProductName,LineProductDescription,LineQty,LineShipDate,'+
            ' ProcTreeId,Complete,Employeename,Status,'+
            ' TimeSheetCreated) '+
            ' SELECT  distinct 0,s.ClientID , S.converted, pt.caption , 1 as Details ,SL.ProductId,  s.SaleId, s.InvoiceDocNumber as SaleDocNumber, '+
            ' s.CustomerName as SaleCustomerName, s.ClassId as SaleClassId, s.ShipDate as SaleShipDate, s.SaleDate,'+
            ' sl.SaleLineId, sl.ProductName as LineProductName, sl.Product_Description as LineProductDescription, sl.UnitOfMeasureShipped as LineQty, sl.ShipDate as LineShipDate,'+
            ' pt.ProcTreeId ,PT.Complete ,'+
            ' "","From Stock",'+
            ' "F"'+
            ' FROM'+
            ' tblSales s'+
            ' inner join  tblSalesLines sl on sl.SaleId = s.SaleId and (SL.BOMGroupedLine ="F" or SL.BOMProductionLine ="T" )' +
            ' inner join  tblProcTree pt on pt.MasterId = sl.SaleLineId    and pt.MasterType = "mtSalesOrder" '+
            ' LEFT join tblprocesspart PPP on PT.ProcTreeId = ppP.ProcTreeID and (ifnull(ppP.ProcTreeID,0)<> 0 ) '+
            ' LEFT join tblprocessparttimesheet PPT on PPP.Id = PPt.ProcessPartID and PPT.Active ="T" '+
            ' Where (PT.ParentId = 0 )'+
            ' and s.SaleDate between ' +Quotedstr(FormatDatetime(MysqlDateTimeFormat, FilterDateFrom)) +' AND ' +Quotedstr(FormatDatetime(MysqlDateTimeFormat, FilterDateTo)) +
            iif(AllEmployees , '' , ' and PPt.EmployeeID  = ' + inttostr(SelectedEmployeeID))+
            ' group by pt.ProcTreeId;');

    st.Add('/*24*/Drop table if exists ' +tablename +'1;');
    st.Add('/*25*/Create table ' +tablename +'1 '+
            ' Select T.SaleLineID, group_concat(distinct ppd.Status) status'+
            ' from tblProcTree ptd '+
            ' Inner JOIN tblProcessPart PPd on PPd.ProcTreeId = PTd.ProcTreeId '+
            ' inner join ' +tablename + ' T  on  ptd.MasterId = T.SaleLineId and ptd.MasterType = "mtSalesOrder" group by T.SaleLineID;');
    st.Add('/*26*/update ' +tablename +' T inner join ' +tablename +'1 T1 on T.SaleLineId = T1.SaleLineId Set t.Status = ifnull(T1.Status , "From Stock") where T.Details = 1;');
    st.Add('/*27*/Drop table if exists ' +tablename +'1;');
    st.Add('/*28*/Create table ' +tablename +'1 '+
            '   Select '+
            '   t.ProcTreeId , '+
            '   Convert(Min(PPT.Timestart), DateTime) Timestart, '+
            '   Convert(Max(PPT.Timeend), DateTime) timeEnd, '+
            '   /*Convert(ifnull(Min(PPT.Timeend),0), DateTime) TimeEnd1, */'+
            (*'   sum(Time_to_sec(TimeDiff(ifnull(PPT.timeEnd,current_Timestamp), ifnull(PPt.TimeStart,0)))) timeTaken, '+
            '   sum(Round(Time_to_sec(TimeDiff(ifnull(PPT.timeEnd,current_Timestamp), ifnull(PPt.TimeStart,0)))/60/60,2)) 	 timeTakeninHr '+*)
            '   sum(      SecondsBetween(ifnull(PPt.TimeStart,0), ifnull(PPT.timeEnd,current_Timestamp) )) timeTaken, '+
            '   sum(Round(SecondsBetween(ifnull(PPt.TimeStart,0) , ifnull(PPT.timeEnd,current_Timestamp) )/60/60,2)) 	 timeTakeninHr '+
            '   from tblprocessparttimesheet PPT '+
            '   inner join tblprocesspart pp on PP.Id = PPt.ProcessPartID and ppt.active = "T" '+
            '   inner join ' +tablename +' T on pp.ProcTreeID  =t.ProcTreeId '+
            '   where  T.Details = 1  '+
            '   Group by T.ProctreeID;');
    st.Add('/*29*/update ' +tablename +' T inner join ' +tablename +'1 T1 on T.ProcTreeId = T1.ProcTreeId  '+
            '   Set t.Timestart = T1.Timestart, '+
            '   T.timeEnd = T1.timeEnd ,  '+
            '   /*t.TimeEnd1  = T1.TimeEnd1, */'+
            '   T.timeTaken = T1.timeTaken,  '+
            '   T.timeTakeninHr = T1.timeTakeninHr '+
            '   where T.Details = 1;');

    st.Add('/*30*/Drop table if exists ' +tablename +'1;');
    st.Add('/*31*/Create table ' +tablename +'1 '+
            '   Select T.ProcTreeId, Min(PT.Timestart)  as Scheduledtimestart, '+
            '   Max(PT.Timestart) as ScheduledtimeEnd '+
            '   from tblprocesstime PT inner  join tblprocesspart PP on PT.ProcessPartId = pp.ID  '+
            '   inner join '+ tablename +' T on T.ProcTreeId = pp.ProcTreeID '+
            '   where ifnull(PT.Timestart,0)>="1899-12-31" and T.Details = 1'+
            '  group by T.ProcTreeId;');

    st.Add('/*32*/update ' +tablename +' T inner join ' +tablename +'1 T1 on T.ProcTreeId = T1.ProcTreeId  '+
            '   Set /*t.Timestart = T1.Scheduledtimestart, */'+
            '   T.Scheduledtimestart = T1.Scheduledtimestart ,  '+
            '   T.ScheduledtimeEnd = T1.ScheduledtimeEnd '+
            '   where T.Details = 1;');

    st.Add('/*33*/Drop table if exists ' +tablename +'1;');
    st.Add('/*34*/Create table ' +tablename +'1  '+
            '   Select PP.ProcTreeId , Round(sum(PT.Duration),2)  ScheduledTime, '+
            '   /*SEC_TO_TIME*/FormatSecondsTotime(Round(sum(PT.Duration),2)) cScheduledTime'+
            '   from tblprocesstime PT '+
            '   inner  join tblprocesspart PP on PT.ProcessPartId = pp.ID '+
            '   /*inner join '+ tablename +' T on T.ProcTreeId = pp.ProcTreeID */'+
            '   where ProcessPartId = pp.ID /*and T.Details = 1*/'+
            '  group by PP.ProcTreeId;');

    st.Add('/*35*/update ' +tablename +' T inner join ' +tablename +'1 T1 on T.ProcTreeId = T1.ProcTreeId  '+
            '   Set T.ScheduledTime = T1.ScheduledTime ,  '+
            '   T.cScheduledTime = T1.cScheduledTime '+
            '   where T.Details = 1;');

    st.Add('/*36*/Drop table if exists ' +tablename +'1;');
    st.Add('/*37*/Create table ' +tablename +'1  '+
            '   Select T.ProcTreeId , Group_concat(concat(Ps.Description," ")) Process'+
            '   from tblProcessStep PS'+
            '   inner  join tblprocesspart PP on PP.ProcessStepId = PS.ID' +
            '   inner join '+ tablename +' T on T.ProcTreeId = pp.ProcTreeID '+
            '   where /*T.PPID = pp.ID and */ T.Details = 1'+
            '  group by T.ProcTreeId;');

    st.Add('/*38*/update ' +tablename +' T inner join ' +tablename +'1 T1 on T.ProcTreeId = T1.ProcTreeId  '+
            '   Set  T.Process = T1.Process '+
            '   where T.Details = 1;');

    st.Add('/*39*/Drop table if exists  ' +tablename +'1;');
    st.Add('/*40*/create table ' +tablename +'1'+
            '   Select R.employeeId , '+
            '   Max(R.RosterID) as RosterID'+
            '   from tblroster R'+
            '   inner join  ' +tablename +' T on R.EmployeeId = T.EmployeeId'+
            '   Where R.Type = "Clocked" AND IsClocked ="T"'+
            '   group by employeeID;');
    st.Add('/*41*/ALTER TABLE `' +tablename +'1` 	ADD INDEX `EmployeeId` (`EmployeeId`);');
    st.Add('/*42*/ALTER TABLE `' +tablename +'1` 	ADD INDEX `RosterID` (`RosterID`);');

    st.Add('/*43*/update ' +tablename +'1 T1 inner join  ' +tablename +' T on T.EmployeeId = T1.EmployeeId'+
            '   inner join tblroster R on R.RosterID =  T1.RosterID'+
            ' Left join tblrosterbreak RB  on RB.RosterID = R.RosterID and RB.Starttime >"1899-12-30 00:00:00" and RB.Endtime = "1899-12-30 00:00:00" ' +
            '   Set T.EmployeeClockonStatus = if(ifnull(R.EndTime,0)> "1899-12-30 00:00:00" , "Clocked-OFF" , '+
                                              'if(ifnull(RB.RosterBreakId,0)<>0 ,Concat("On " ,RB.RosterBreaktype, " Since " , DATE_FORMAT(RB.Starttime,"%d/%m%y %l:%i %p")), "Clocked-ON")), '+
            '   T.EmployeeClockonStatusDate = if(ifnull(R.EndTime,0)> "1899-12-30 00:00:00" , R.EndTime , R.Starttime);');
    st.Add('/*44*/Drop table if exists  ' +tablename +'1;');
    st.Add('/*45*/update  ignore ' +tablename +' set Statusno = ProcessPartStatusToNo(Status)  ;');
    clog(st.text);
    ExecuteSQLwithProgress(st.Text);
  finally
    Freeandnil(st);
  end;
end;

procedure TJobtimeSheetsGUI.grdMainCalcCellColors(
  Sender: TObject; Field: TField; State: TGridDrawState;
  Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  inherited;
    if qryMainDetails.asInteger <> 3 then begin
      if (SameText(Field.fieldname , qryMainTimeSheetCreated.Fieldname)) then
        AFont.Color :=ABrush.Color ;

    end;
    if qryMainDetails.asInteger = 2 then begin
      if grpOptions.ItemIndex = 2 then
        AFont.Style := AFont.Style + [fsBold];
      if (SameText(Field.fieldname , 'EmployeeName')) then
          AFont.Color :=ABrush.Color ;
    end else if qryMainDetails.asInteger = 3 then begin
      if grpOptions.ItemIndex = 0 then else begin
        if (SameText(Field.fieldname , 'EmployeeName')) or
          (SameText(Field.fieldname , 'TimeStart')) or
          (SameText(Field.fieldname , 'Timeend')) or
          (SameText(Field.fieldname , 'TimeTaken')) then begin
            ABrush.Color :=GridColhighLightYellow1;
            Afont.color := clblack;
        end;
      end;
    end;
    if QrymainScheduledtimestart.asDatetime =0 then
      if sameText(field.fieldname , QrymainScheduledtimestart.fieldname) then
        AFont.color := ABrush.color;

    if QrymainCProcess.asString = '(No Process for this Job)' then begin
      if (SameText(Field.fieldname , 'cTimeTaken')) or
        (SameText(Field.fieldname , 'TimeTakeninHr')) or
        (SameText(Field.fieldname , 'cStatus')) then begin
        AFont.Color :=ABrush.Color ;
      end;
    end;
    if qryMainScheduledtimestart.asDateTime <= 1 then
      if (SameText(Field.fieldname , qryMainScheduledtimestart.fieldname)) then AFont.Color :=ABrush.Color ;
    if qryMainScheduledtimeend.asDateTime <= 1 then
      if (SameText(Field.fieldname , qryMainScheduledtimeend.fieldname)) then AFont.Color :=ABrush.Color ;
    if qryMainScheduledtime.asfloat <= 1 then
      if (SameText(Field.fieldname , qryMainScheduledtime.fieldname)) then AFont.Color :=ABrush.Color ;
    if qryMainTimetaken.asfloat <= 1 then
      if (SameText(Field.fieldname , qryMainTimetaken.fieldname)) then AFont.Color :=ABrush.Color ;

      if qryMainDetails.asInteger = 3 then
        if  SameText(Field.fieldname , qryMainSaleDocNumber.fieldname) or
            SameText(Field.fieldname , qryMainSaleCustomerName.fieldname) or
            SameText(Field.fieldname , qryMainLineProductName.fieldname) or
            SameText(Field.fieldname , qryMainLineQty.fieldname) or
            SameText(Field.fieldname , qryMainCStatus.fieldname) or
            SameText(Field.fieldname , qryMaincaption.fieldname) or
            SameText(Field.fieldname , qryMainLineShipDate.fieldname) or
            SameText(Field.fieldname , qryMainScheduledtimestart.fieldname) or
            SameText(Field.fieldname , qryMaincScheduledtime.fieldname) or
            SameText(Field.fieldname , qryMainScheduledtimeEnd.fieldname) then
          Afont.color := ABrush.color;
end;

procedure TJobtimeSheetsGUI.ReadnApplyGuiPrefExtra;
var
  x:Integer;
begin
  inherited;
  if GuiPrefs.Node.Exists('grpOptions') then begin
    x := GuiPrefs.Node['grpOptions.ItemIndex'].asInteger;
    if x > 0 then if grpOptions.Items.Count >= x then grpOptions.ItemIndex := x - 1;
  end;
  WindowState := wsMaximized;
end;

procedure TJobtimeSheetsGUI.RefreshQuery;
begin
  closeDB(Qrymain);
  (*Qrymain.Params.Parambyname('FromDate1').asDatetime := FilterDateFrom;
  Qrymain.Params.Parambyname('ToDate1').asDatetime   := FilterDateTo;
  Qrymain.Params.Parambyname('FromDate2').asDatetime := FilterDateFrom;
  Qrymain.Params.Parambyname('ToDate2').asDatetime   := FilterDateTo;*)
  PopulateTable;
  initemployeeParams;
  inherited;
  qryMainScheduledtimestart.DisplayFormat := FormatSettings.ShortDateformat;
  qryMainScheduledtimeEnd.DisplayFormat := FormatSettings.ShortDateformat;
end;

procedure TJobtimeSheetsGUI.qryMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  DoQrymainafteropen;
end;

procedure TJobtimeSheetsGUI.qryMainAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  memprocesses.visible := (Pos(',',qryMainProcess.asString)<> 0) and (qryMainDetails.asInteger = 2);
end;

procedure TJobtimeSheetsGUI.SetGridColumns;
begin
  inherited;
  RemoveFieldfromGrid('Process');
  RemoveFieldfromGrid('Details');
  RemoveFieldfromGrid('ProductId');
  RemoveFieldfromGrid('SaleClassID');
  RemoveFieldfromGrid('ProcTreeId');
  RemoveFieldfromGrid('Status');
  RemoveFieldfromGrid('Timetaken');
  RemoveFieldfromGrid('Converted');
  RemoveFieldfromGrid('PPTID');
  RemoveFieldfromGrid('ScheduledTime');
  RemoveFieldfromGrid('Statusno');
end;

procedure TJobtimeSheetsGUI.WriteGuiPrefExtra;
begin
  inherited;
  GuiPrefs.Node['grpOptions.ItemIndex'].asInteger := grpOptions.ItemIndex+1;
end;

procedure TJobtimeSheetsGUI.FormCreate(Sender: TObject);
begin
  Tablename := CreateUserTemporaryTable('tmp_jobtimesheet');
  Qrymain.SQL.Clear;
  Qrymain.SQL.Add('Select *');
  Qrymain.SQL.Add('from ' +tablename);
  //Qrymain.SQL.Add('Where EmployeeName = :EmployeeName or :Allemployee ="T"');
  Qrymain.SQL.Add('order by saleID desc,LineProductName ,  ProctreeId, details');
  inherited;
  BaseIndexfields:=  qryMainSaleID.fieldname +' DESC,'+
                      qryMainLineProductName.fieldname +','+
                      qryMainProctreeId.fieldname +','+
                      qryMainDetails.fieldname ;

  SelectionOption := soEmployee;
  fbSaveListSortOrder := True;
end;

procedure TJobtimeSheetsGUI.FormDestroy(Sender: TObject);
begin
  CommonDbLib.DestroyUserTemporaryTable(tablename);
  inherited;
end;

procedure TJobtimeSheetsGUI.FormShow(Sender: TObject);
begin
  inherited;
  grpFilters.ItemIndex := 0;
end;


procedure TJobtimeSheetsGUI.DoQrymainafteropen;
begin
  inherited;
  TimerMsg(FilterLabel , 'The list is in the Order of Sale #(Desc), ' + AppEnv.DefaultClass.PartColumn+'. Selected Sorting is applied within these.', 30);
end;

procedure TJobtimeSheetsGUI.DoShowLookuplist;
begin
  inherited;
  Self.Caption := 'Job List';
  AllEmployees := True;
end;

procedure TJobtimeSheetsGUI.grdMainDblClick(Sender: TObject);
var
  TimesheetEntryID:Integer;
begin
  if Assigned(OnGridDataSelect) then begin
    OnGridDataSelect(twwDbGrid(Sender));
    Self.close;
    Exit;
  end;
  if (Sysutils.SameText(grdmain.SelectedField.fieldname , qryMainLineProductName.fieldName )) or
      (Sysutils.SameText(grdmain.SelectedField.fieldname , qryMainLineQty.fieldName )) or
      (Sysutils.SameText(grdmain.SelectedField.fieldname , qryMainStatus.fieldName )) or
      (Sysutils.SameText(grdmain.SelectedField.fieldname , qryMainCStatus.fieldName )) or
      (Sysutils.SameText(grdmain.SelectedField.fieldname , qryMainLineProductDescription.fieldName )) then begin
      TfmBarCodeManufacturing.OpenForsale(qryMainSaleId.asInteger);
  end else if (Sysutils.SameText(grdmain.SelectedField.fieldname , qryMainTimeSheetCreated.fieldName )) and (qryMainTimeSheetCreated.asBoolean) then begin
    TimesheetEntryID :=tcdatautils.TimesheetEntryID(QrymainSaleLineID.asInteger);
    if TimesheetEntryID >0 then
      OpenERPForm('TfrmTimeSheet' , TimesheetEntryID );
  end else
    inherited;
end;

procedure TJobtimeSheetsGUI.btntimesheetClick(Sender: TObject);
var
  Ids:String;
  TimeSheetEntry :TTimesheetEntry;
  saleLineID:Integer;
  timeSheetEntryLocked:boolean;
  invalidEmployeeID:TIntegerList;
  SalesLineIds:TIntegerList;
  s:String;
  
  Procedure Savetimesheetentry;
  begin
      if timeSheetEntryLocked then begin
        TimeSheetEntry.Save;
        TimeSheetEntry.Connection.CommitTransaction;
      end;
  end;
  function Opentimesheetentry:boolean;
  begin
      TimeSheetEntry.Connection.BeginTransaction;
      TimeSheetEntry.LoadSelect('Type = ' + QuotedStr('Manufacture') +' and typeId = ' +IntToStr(saleLineID));
      if TimeSheetEntry.count = 0 then begin
          Timesheetentry.New;
          timeSheetEntry.TypeName   := 'Manufacture';
          timeSheetEntry.EntryDate  := Now;
          timeSheetEntry.Whoentered := AppEnv.Employee.FirstName + ' ' + AppEnv.Employee.LastName;
          timeSheetEntry.TypeId     := SaleLineId;
          timeSheetEntry.PostDB;
      end;
      result := timeSheetEntry.Lock;
  end;
  Procedure opentimesheetform;
  begin
    if SalesLineIds.count <> 0 then begin
      with CommonDbLib.TempMyQuery do try
          SQL.add('Select Concat( "Sale Doc Number " , SaleId, " has made Lines ", Group_Concat(SaleLineID)) as Description  from tblSaleslines where SaleLineID in(' +SalesLineIds.Commatext +') Group by SaleID');
          open;
          (*s:= replaceStr(Groupconcat('Description') , ',' , chr(13) );*)
          s:= Groupconcat('Description' , '' , False , chr(13));
          if s<> '' then
            MessageDlgXP_Vista(s, mtWarning, [mbok],0);
        finally
            if active then close;
            Free;
        end;

        grdmain.UnselectAll;
        RefreshQuery;
      TfrmPayTimesheet.ShowLookuplist(nil);
    end;
  end;
  Procedure WarnforEmployeeWithoutHourlyRate;
  begin
    if (invalidEmployeeID.count >0) and (Appenv.CompanyPrefs.UsePayroll) then begin
        with CommonDbLib.TempMyQuery do try
          SQL.add('Select concat(Employeename," ") Employeename from tblemployees where employeeId in (' +invalidEmployeeID.commatext+')');
          open;
          s:= Groupconcat('employeeName');
          if s<> '' then
            MessageDlgXP_Vista('''Hourly Rate'' for  ''Normal Hours'' is Not Set for the Following Employee(s).' +chr(13) + chr(13) +
            s +chr(13) + chr(13) +
            'Timesheet Cannot be Created for These Employee(s).', mtWarning, [mbok],0);
        finally
            if active then close;
            Free;
        end;
      end;
  end;
begin
  inherited;
  Ids := SelectedIDs('PPTID' , True);
  if ids = '' then exit;
  closeDb(QryjobsfortimesheetEntry);
  QryjobsfortimesheetEntry.Sql.clear;
  QryjobsfortimesheetEntry.SQL.add('SELECT   PPT.TimeEnd AS TimesheetDate,'+
              (*' Round(Time_to_sec(timediff(if(ifnull(PPT.timeEnd,0)=0 ,CURRENT_TIMESTAMP , PPt.timeEnd), PPT.timeStart)) /60/60,2) timeTakeninHr,'+
              ' Round(Time_to_sec(timediff(if(ifnull(PPT.timeEnd,0)=0 ,CURRENT_TIMESTAMP , PPt.timeEnd), PPT.timeStart)) /60/60,2) *PT.cost As Total,'+*)
              ' Round(SecondsBetween(PPT.timeStart, if(ifnull(PPT.timeEnd,0)=0 ,CURRENT_TIMESTAMP , PPt.timeEnd)) /60/60,2) timeTakeninHr,'+
              ' Round(SecondsBetween(PPT.timeStart, if(ifnull(PPT.timeEnd,0)=0 ,CURRENT_TIMESTAMP , PPt.timeEnd) ) /60/60,2) *PT.cost As Total,'+
              ' PPT.EmployeeID,E.EmployeeName ,'+
              ' PT.Cost,S.ClientID,S.customername, S.ClassID,S.Class,PT.PartsId,P.PARTNAME,P.PARTSDESCRIPTION,'+
              ' SL.SaleID,SL.SaleLineID,PPT.ID as PPTID'+
              ' FROM tblprocessparttimesheet PPT'+
              ' inner join tblprocesspart PP  on PP.Id = PPt.ProcessPartID and PPT.Active ="T"'+
              ' inner join  tblProcTree pt on pt.ProcTreeId = pp.ProcTreeID'+
              ' inner join  tblSalesLines sl  on pt.MasterId = sl.SaleLineId    and pt.MasterType = "mtSalesOrder"'+
              ' inner  join  tblSales s on sl.SaleId = s.SaleId'+
              ' inner   join tblemployees E on e.employeeId = PPt.EmployeeID'+
              ' Left Join tblparts AS P ON PT.PartsId = P.PARTSID'+
              ' where PPT.ID in (' + Ids+') and ifnull(PPT.TimeEnd,0)<> 0'+
              ' Order by SaleID, SaleLineId' );
    QryjobsfortimesheetEntry.open;
    if QryjobsfortimesheetEntry.recordcount = 0 then exit;
    QryjobsfortimesheetEntry.First;
    invalidEmployeeID:=TIntegerList.create;
    SalesLineIds :=TIntegerList.create;
    try
      TimeSheetEntry :=TTimesheetEntry.create(self);
      try
        TimeSheetEntry.SilentMode:= true;
        TimeSheetEntry.Connection := TMyDacDataConnection.create(TimeSheetEntry);
        TimeSheetEntry.Connection.Connection := GetNewMyDacConnection(TimeSheetEntry);
        saleLineID:=QryjobsfortimesheetEntrySaleLineID.asInteger;
        timeSheetEntryLocked := opentimeSheetEntry;
        while QryjobsfortimesheetEntry.Eof = False do begin
          if saleLineID <> QryjobsfortimesheetEntrySaleLineID.asInteger then begin
            SavetimesheetEntry;
            saleLineID:=QryjobsfortimesheetEntrySaleLineID.asInteger;
            timeSheetEntryLocked := opentimeSheetEntry;
          end;
            if timeSheetEntryLocked then begin
              if QryjobsfortimesheetEntryPPTId.asInteger <> 0 then begin
                if not TimeSheetEntry.Timesheet.Locate('processparttimesheetID' , QryjobsfortimesheetEntryPPTId.asInteger, []) then begin
                  TimeSheetEntry.Timesheet.New;
                  TimeSheetEntry.Timesheet.TimesheetDate := QryjobsfortimesheetEntryTimesheetDate.asDateTime;

                  TimeSheetEntry.Timesheet.EmployeeName     := QryjobsfortimesheetEntryEmployeename.asString;
                  if TimeSheetEntry.Timesheet.HourlyRate = 0 then begin
                    (*TimeSheetEntry.Timesheet.Cancel;*)
                    invalidEmployeeID.AddIfNotInList(QryjobsfortimesheetEntryEmployeeID.asInteger);
                  end (*else begin*);
                    TimeSheetEntry.Timesheet.Hours            := QryjobsfortimesheetEntrytimeTakeninHr.AsFloat;
                    TimeSheetEntry.Timesheet.JobID            := QryjobsfortimesheetEntryclientId.asInteger;
                    TimeSheetEntry.Timesheet.TimeSheetClassID := QryjobsfortimesheetEntryclassid.asInteger;
                    TimeSheetEntry.Timesheet.PartID           := QryjobsfortimesheetEntryPartsId.asInteger;
                    TimeSheetEntry.Timesheet.PartName         := QryjobsfortimesheetEntryPARTNAME.asString;
                    TimeSheetEntry.Timesheet.PartsDescription := QryjobsfortimesheetEntryPARTSDESCRIPTION.asString;
                    TimeSheetEntry.Timesheet.SalesID          := QryjobsfortimesheetEntrySaleID.asInteger;
                    TimeSheetEntry.Timesheet.SaleLineID       := QryjobsfortimesheetEntrySaleLineID.asInteger;
                    TimeSheetEntry.Timesheet.processparttimesheetID := QryjobsfortimesheetEntrypptid.asinteger;
                    TimeSheetEntry.Timesheet.Postdb;
                    SalesLineIds.AddIfNotInList(QryjobsfortimesheetEntrySaleLineID.asInteger);
                  (*end;*)
                end;
              end;
            end;
          QryjobsfortimesheetEntry.Next;
          if QryjobsfortimesheetEntry.EOf then begin
            SavetimesheetEntry;
          end;
        end;
      finally
        Freeandnil(TimeSheetEntry);
      end;
    finally
        WarnforEmployeeWithoutHourlyRate;
        Freeandnil(invalidEmployeeID);
        opentimesheetform;

        Freeandnil(SalesLineIds);

    end;

end;

procedure TJobtimeSheetsGUI.grdMainMultiSelectRecord(Grid: TwwDBGrid;
  Selecting: Boolean; var Accept: Boolean);
begin
  inherited;
  if Selecting then
    if qryMainDetails.asInteger <> 3 then begin
      Accept := False;
      lblMsg.Caption:= 'Please Select an Extra Detail Entry To Create Timesheet. ';
      if grpOptions.ItemIndex = 0 then lblMsg.Caption:= lblMsg.Caption+'You Are In Summary Mode. Change To Extra Details.'
      else if grpOptions.ItemIndex = 1 then lblMsg.Caption:= lblMsg.Caption+'You Are In Detail Mode. Change To Extra Details.';  
    end else if qryMaintimeStart.asDatetime <= 1 then  begin
      Accept := False;
      lblMsg.Caption:= qryMainProcess.asString+ ' Is Not Started Yet.' ;
    end else if qryMaintimeEnd.asDatetime <= 1 then  begin
      Accept := False;
      lblMsg.Caption:= qryMainEmployeename.asString +'  Hasn''t Stopped This Process. Timesheets Can Be Created For Stopped Processes Only.' ;
    end else if qryMainTimeSheetCreated.asBoolean then begin
      Accept := False;
      lblMsg.Caption:= 'Timehseet is Already Created.' ;
    end;
  if Accept then  lblMsg.Caption:= '';
end;

procedure TJobtimeSheetsGUI.grdMainExit(Sender: TObject);
begin
  inherited;
  lblMsg.Caption:= '';
end;

function TJobtimeSheetsGUI.DEfaultSelectedEmployeeID: Integer;
begin
  result := inherited DEfaultSelectedEmployeeID;
  if result <0 then
    result := Appenv.employee.employeeId;
end;

initialization
  RegisterClassOnce(TJobtimeSheetsGUI);

end.

