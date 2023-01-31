unit POSLIB;

interface

Function SalesCollatedByItemListSQL(const TillIDs:String; DateFrom:TDateTime=0; Dateto:TDatetime=0; ReportName:String =''):String;
Function SalesProductListSQL(const TillIDs:String; DateFrom:TDateTime=0; Dateto:TDatetime=0 ):String;
Function SalesCollatedByItemReportSQL(const TillIDs, reportname:String; DateFrom:TDateTime=0; Dateto:TDatetime=0):String;
Procedure MakeHourlySalesStatistics(var tablename:String; Const Datefrom , Dateto:TDatetime; tillID:Integer);
Function HourlySalesStatisticsSQL(tablename:String):String;
Function POSSalesTime(Const Tablename:String):String;
Function DailyStatisticsReportSQL(Const Tablename:String; Const Datefrom , Dateto:TDatetime):String;
function ForWholeSale(ReportName:String):boolean;
function ForRetail(ReportName:String):Boolean ;
function OkToOpenCashDrawer(iTillID:Integer): boolean;
Function POSEOPStarttime(const Starttime:Tdatetime):Tdatetime;
Function POSEOPEndtime(const Endtime:Tdatetime):Tdatetime;

implementation

uses classes, ProductQtyLib, sysutils, AppEnvironment, CommonLib, FastFuncs,
  ERPdbComponents, DbSharedObjectsObj, MySQLConst, LogLib, CommonDbLib, dateutils,
  TemplateReportsLib, SystemLib, tcDataUtils;


function OkToOpenCashDrawer(iTillID:Integer): boolean;
var
  qryTill: TERPQuery;
begin
  Result := False;
  if AppEnv.CompanyPrefs.MultiTills then begin
    qryTill := DbSharedObj.GetQuery(CommonDbLib.GetSharedMyDacConnection);
    try
      with qryTill do begin
        SQL.Clear;
        SQL.Add('SELECT UseDefaultPrinter, ReceiptPrinterOn, ReceiptPrinterPort, ' +
          'ReceiptPrinterType, UseCashDrawerOnly, UseLocalDrawer, UsePrintSpooler,EnableKickRemoteDrawer ' +
          'FROM tblPOSTills WHERE TillID = ' + inttostr(iTillID) +'');
        Open;
        if not IsEmpty then begin
          if FieldByName('UseDefaultPrinter').AsString <> 'T' then begin
            if (FieldByName('ReceiptPrinterOn').AsString = 'T') then begin
              if (FieldByName('UsePrintSpooler').AsString = 'T') then begin
                if (FieldByName('UseLocalDrawer').AsString <> 'T') then begin
                  if (FieldByName('EnableKickRemoteDrawer').AsString = 'T') then begin
                    Result := true;
                  end else begin
                    Result := false;
                  end;
                end else begin
                  Result := true;
                end;
              end else begin
                Result := False;// true; //binny - babylon having access violation issue when pos is closed and reopened
              end;
            end else begin
              Result := false;
            end;
          end else begin
            Result := False;// Result := AppEnv.CompanyPrefs.ReceiptPrinterOn; //binny - babylon having access violation issue when pos is closed and reopened
          end;
        end;
      end;
    finally
      FreeandNil(qryTill);
    end;
  end else begin
    Result := False;// Result := AppEnv.CompanyPrefs.ReceiptPrinterOn; //binny - babylon having access violation issue when pos is closed and reopened
  end;
end;

Function POSSalesTime(Const Tablename:String):String;
begin
      Result := '/*18*/drop table if exists '+ tablename +';'+
              ' create table '+ tablename +
              ' select S.saleID,S.saleDatetime, S.tillId ,S.classId '+
                              ' from tblsales S '+
                              ' where  S.IsLayby = "F" and (S.POS = "T" or (s.ISPOS ="T" and S.POS ="F") ) ' +
                              ' union all '+
              ' select S.saleID,S.saleDatetime , S.tillId ,S.classId  '+
                              ' from tblsales_pos S'+
                              ' where S.IsLayby = "F" and (S.POS = "T" or (s.ISPOS ="T" and S.POS ="F") ); '+
              ' Alter table '+ tablename +' add index saleID (saleID);'+
              ' Alter table '+ tablename +' add index tillId (tillId);'+
              ' Alter table '+ tablename +' add index classId (classId);';

end;
Function DailyStatisticsReportSQL(Const Tablename:String; Const Datefrom , Dateto:TDatetime):String;
begin
  Result := companyInfoSQL +
        '~|||~{Details} ' +HourlySalesStatisticsSQL(Tablename  )  +
        '~|||~{DateRange} Select ' + quotedstr(formatdateTime(MySQLDatetimeformat , Datefrom))+' as Datefrom ,  ' +
          quotedstr(formatdateTime(MySQLDatetimeformat , DAteTo))+' as DateTo  from DUAL'+
        '~|||~{best3}Select DATE_FORMAT(T.TimeFrom	,"%h %p") as TimeIntfrom, '+
              ' concat(DATE_FORMAT(T.TimeFrom	,"%h %p"), " - " , DATE_FORMAT(T.TimeTo	,"%h %p")) as Timeint  , '+
              ' sum(T.NoOfsales) totalSales from ' +tablename +' T group by timefrom order by totalSales desc  , TimeFrom limit 3'+
        '~|||~{worst3}Select DATE_FORMAT(T.TimeFrom	,"%h %p") as TimeIntfrom, '+
              ' concat(DATE_FORMAT(T.TimeFrom	,"%h %p"), " - " , DATE_FORMAT(T.TimeTo	,"%h %p")) as Timeint  , '+
              ' sum(T.NoOfsales) totalSales from ' +tablename +' T group by timefrom order by totalSales ,TimeFrom limit 3'+
        '~|||~{StaffPerformace}Select '+
              ' HSE.employeename highestSaleBy , HSE.noofsales HighestSale, '+
              ' LSE.employeename LowestSaleBy , LSE.noofsales LowestSale  from  '+
              ' (sELECT E.employeeName , noofsales FROM '+Tablename+' T inner join tblemployees E on T.employeeId = E.employeeId group by T.employeeID order by  noofsales desc limit 1) HSE , '+
              ' (sELECT E.employeeName , noofsales FROM '+Tablename+' T inner join tblemployees E on T.employeeId = E.employeeId group by T.employeeID order by  noofsales limit 1) LSE'+
        '~|||~'+ColumnHeadingsSQL;
end;
Function HourlySalesStatisticsSQL(tablename:String):String;
var
  st:TStringlist;
begin
  st:= TStringlist.create;
  try
    St.Add('select');
    St.Add('T.EmployeeId	            as EmployeeId         ,');
    St.Add('C.Classname	              as Classname         ,');
    St.Add('PT.tillname	              as tillname         ,');
    St.Add('e.EmployeeName            as EmployeeName       ,');
    St.Add('t.TimeFrom                as TimeFrom,');
    St.Add('t.TimeTo                  as TimeTo,');
    St.Add('DATE_FORMAT(T.TimeFrom	,"%h %p") as TimeIntfrom,');
    St.Add('concat(DATE_FORMAT(T.TimeFrom	,"%h %p"), " - " , DATE_FORMAT(T.TimeTo	,"%h %p")) as Timeint  ,');
    St.Add('T.NoOfsales	              as NoOfsales          ,');
    St.Add('T.NoOfCustomers	          as NoOfCustomers      ,');
    St.Add('T.NoOfProducts	          as NoOfProducts       ,');
    St.Add('T.UOMQty	                as UOMQty       ,');
    St.Add('T.Qty	                    as Qty       ,');
    St.Add('T.NoOfReturns	            as NoOfReturns        ,');
    St.Add('T.NoOfReturnProducts	    as NoOfReturnProducts ,');
    St.Add('T.ItemsPercustomer	      as ItemsPercustomer   ,');
    St.Add('T.QtyPerCustomer  	      as QtyPerCustomer   ,');
    St.Add('T.SalesPerCustomer	      as SalesPerCustomer   ,');
    St.Add('T.TotalsalesAmount	      as TotalsalesAmount   ,');
    St.Add('T.TotalsalesAmountInc     as TotalsalesAmountInc,');
    St.Add('T.salesAmountIncPerItem   as salesAmountIncPerItem,');
    St.Add('T.GrossProfit	            as GrossProfit      ,');
    St.Add('T.GPPerCustomer	          as GPPerCustomer      ,');
    St.Add('T.GPPerProduct	          as GPPerProduct       ,');
    St.Add('T.Stress15	              as Stress15           ,');
    St.Add('T.Stress5	                as Stress5            ,');
    St.Add('T.Streemorethan15         as Streemorethan15'     );
    St.Add('from '+tablename+' T');
    St.Add('inner join tblemployees e on T.employeeId = E.employeeId');
    St.Add('inner join tblclass C on T.classID = C.ClassId');
    St.Add('inner join tblpostills PT on T.tillid = PT.tillID');
    St.Add('order by classname, tillname, employeename , timeFrom');
  finally
    result := st.Text;
    Freeandnil(st);
  end;

end;
Procedure MakeHourlySalesStatistics(var tablename:String; Const Datefrom , Dateto:TDatetime; tillID:Integer);
var
  script :TERPScript;
  function DatenHourof(Const Dt:TDateTime):String;
  begin
    result := 'date_add(date_add('+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , dt)) +'  , interval 0-second('+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , dt)) +' ) second) , interval 0-minute('+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , dt)) +' ) minute)';
  end;
  Function hours(Datefrom , DateTo:Tdatetime):String;
  begin
    //datefrom := DatewithHourof(dateFrom);

    Datefrom := POSEOPStarttime(Datefrom);
    DateTo   := POSEOPendtime(DateTo);

    REsult := '';


    if Datefrom >= dateto then begin
      result := result +'Select '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , dateFrom)) + ' as TimeFrom  , '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , dateto)) + ' as TimeTo ';
      exit;
    end;


    While Datefrom < Dateto do begin
      if result <> '' then result := result + ' union ' ;
      result := result +'Select '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , dateFrom)) + '  as TimeFrom , ';
      DateFrom := DatewithHourof(inchour(dateFrom , 1));
      if datefrom > dateto then dateFrom := Dateto;
      result := result + Quotedstr(FormatdateTime(MysqlDatetimeFormat , dateFrom)) + '  as TimeTo  ';
(*                        ' if(date_add('+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , dateFrom)) + ' , Interval 1 hour) >  '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , dateto)) + ', '+
                                                  Quotedstr(FormatdateTime(MysqlDatetimeFormat , dateto)) + ','+
                                                  ' date_add('+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , dateFrom)) + ' , Interval 1 hour)) as TimeTo ';*)

    end;
  end;


  function AllSales:String;
  begin
    Result := 'drop table if exists '+ tablename +'Sales;'+
              ' create table '+ tablename +'Sales '+
              ' select T.Id, s.tillID , S.ClassID, S.SaleDateTime, s.saleID ,S.clientID,S.totalamount,S.totalamountInc , s.isrefund  '+
                              ' from '+ tablename +' T , tblsales S '+
                              ' where t.tillid = S.tillId and S.ClassId = T.classId and T.employeeID = s.employeeID and  s.Saledatetime >= t.timeFrom  and s.Saledatetime <= t.timeto and S.employeeId = T.employeeId '+
                              ' and S.IsLayby = "F" and (S.POS = "T" or (s.ISPOS ="T" and S.POS ="F") ) '+ iif(tillId<>0 , ' and S.tillid = ' + inttostr(tillID) , '') +
                              ' union all '+
              ' select T.Id, s.tillID , S.ClassID, S.SaleDateTime, s.saleID ,S.clientID,S.totalamount,S.totalamountInc , s.isrefund  '+
                              ' from '+ tablename +' T , tblsales_pos S '+
                              ' where t.tillid = S.tillId and S.ClassId = T.classId and T.employeeID = s.employeeID and s.Saledatetime >= t.timeFrom  and s.Saledatetime <= t.timeto and S.employeeId = T.employeeId '+
                              iif(tillId<>0 , ' and S.tillid = ' + inttostr(tillID) , ' ') +';';
  end;

  function AllSaleslines:String;
  begin
    Result := 'drop table if exists '+ tablename +'Saleslines;'+
              ' create table '+ tablename +'Saleslines '+
              ' select T.Id, s.tillID , S.ClassID, S.SaleDateTime, s.saleID ,S.clientID,S.totalamount,S.totalamountInc , s.isrefund , SL.ProductID ,SL.UnitofMeasureShipped ,SL.shipped ,SL.LineCost ,SL.LineCostInc  '+
                              ' from '+ tablename +' T , tblsales S  inner join tblsaleslines SL on S.saleId = SL.saleID'+
                              ' where t.tillid = S.tillId and S.ClassId = T.classId and T.employeeID = s.employeeID and  s.Saledatetime >= t.timeFrom  and s.Saledatetime <= t.timeto and S.employeeId = T.employeeId '+
                              ' and S.IsLayby = "F" and (S.POS = "T" or (s.ISPOS ="T" and S.POS ="F") ) '+ iif(tillId<>0 , ' and S.tillid = ' + inttostr(tillID) , '') +
                              ' union all '+
              ' select T.Id, s.tillID , S.ClassID, S.SaleDateTime, s.saleID ,S.clientID,S.totalamount,S.totalamountInc , s.isrefund , SL.ProductID ,SL.UnitofMeasureShipped ,SL.shipped ,SL.LineCost ,SL.LineCostInc  '+
                              ' from '+ tablename +' T , tblsales_pos S inner join tblsaleslines_POS SL on S.saleId = SL.saleID'+
                              ' where t.tillid = S.tillId and S.ClassId = T.classId and T.employeeID = s.employeeID and s.Saledatetime >= t.timeFrom  and s.Saledatetime <= t.timeto and S.employeeId = T.employeeId '+
                              iif(tillId<>0 , ' and S.tillid = ' + inttostr(tillID) , ' ') +';';
  end;
function updatefieldSQL(const Sumfield,  fieldname:String ; includesaleslines :Boolean; WhereSQL:String ='' ):String;
  begin
    Result := 'drop table if exists '+ tablename +'2;'+
              ' create table '+ tablename +'2 '+
              'select Id , ' + Sumfield +'   as ' + fieldname +'  '+
                              ' from '+ tablename + iif(includesaleslines ,'Saleslines' , 'Sales') +  ' S '+
                              iif(WhereSQL<> '' , ' Where ' + WhereSQL , '')+ ' group by ID;'+
              ' Alter table '+ tablename +'2 add index id (id);'+
              ' update '+ tablename +' T1 inner join '+ tablename +'2 t2 on t1.id = t2.id set t1.' + fieldname +'  = t2.' + fieldname +' ;'+
              'drop table if exists '+ tablename +'2;'
  end;


  (*function updatefieldSQL(const Sumfield,  fieldname:String ; includesaleslines :Boolean; WhereSQL:String ='' ):String;
  begin
    Result := 'drop table if exists '+ tablename +'2;'+
              ' create table '+ tablename +'2 '+
              'select T.Id , ' + Sumfield +'   as ' + fieldname +'  '+
                              ' from '+ tablename +' T , tblsales S '+ iif(includesaleslines , 'inner join tblsaleslines SL on S.saleId = Sl.saleID ' ,'')+
                              ' where t.tillid = S.tillId and S.ClassId = T.classId and T.employeeID = s.employeeID and  s.Saledatetime >= t.timeFrom  and s.Saledatetime <= t.timeto and S.employeeId = T.employeeId '+
                              ' and S.IsLayby = "F" and (S.POS = "T" or (s.ISPOS ="T" and S.POS ="F") ) '+ iif(tillId<>0 , ' and S.tillid = ' + inttostr(tillID) , '') +
                              iif(WhereSQL<> '' , ' and ' + WhereSQL , '')+
                              ' group by T.ID '+
                              ' union all '+
                              ' select T.Id , ' + Sumfield +'   as ' + fieldname +'  '+
                              ' from '+ tablename +' T , tblsales_pos S '+ iif(includesaleslines , 'inner join tblsaleslines_POS SL on S.saleId = Sl.saleID ', '') +
                              ' where t.tillid = S.tillId and S.ClassId = T.classId and T.employeeID = s.employeeID and s.Saledatetime >= t.timeFrom  and s.Saledatetime <= t.timeto and S.employeeId = T.employeeId '+ iif(tillId<>0 , ' and S.tillid = ' + inttostr(tillID) , ' ') +
                              iif(WhereSQL<> '' , ' and ' + WhereSQL , '')+
                              ' group by T.ID ;'+
              ' Alter table '+ tablename +'2 add index id (id);'+
              ' update '+ tablename +' T1 inner join '+ tablename +'2 t2 on t1.id = t2.id set t1.' + fieldname +'  = t2.' + fieldname +' ;'+
              'drop table if exists '+ tablename +'2;'
  end;*)
begin
  if tablename = '' then Tablename:= GetUserTemporaryTableName('DailyStatistics');
  script:= DbSharedObj.GetScript(Getsharedmydacconnection);
  try
      script.SQl.add('/*1*/Drop Table if exists '+tablename +';');
      script.SQl.add('/*2*/CREATE TABLE '+tableName+' ( '+
              ' ID                    INT NOT   NULL AUTO_INCREMENT, '+
              ' TillID                INT NOT   NULL , '+
              ' EmployeeId            INT NOT   NULL DEFAULT 0, '+
              ' ClassID               INT NOT   NULL DEFAULT 0, '+
              ' TimeFrom              DATETIME  NULL DEFAULT NULL, '+
              ' Timeto                DATETIME  NULL DEFAULT NULL, '+
              ' NoOfsales             INT       NULL DEFAULT 0, '+
              ' NoOfCustomers         INT       NULL DEFAULT 0, '+
              ' NoOfProducts          INT       NULL DEFAULT 0, '+
              ' UOMQty                double    NULL DEFAULT 0, '+
              ' Qty                   double    NULL DEFAULT 0, '+
              ' NoOfReturns           INT       NULL DEFAULT 0, '+
              ' NoOfReturnProducts    INT       NULL DEFAULT 0, '+
              ' ItemsPercustomer      INT       NULL DEFAULT 0, '+
              ' QtyPerCustomer        double    NULL DEFAULT 0, '+
              ' SalesPerCustomer      INT       NULL DEFAULT 0, '+
              ' TotalsalesAmount      double    NULL DEFAULT 0, '+
              ' TotalsalesAmountInc   double    NULL DEFAULT 0, '+
              ' salesAmountIncPerItem double    NULL DEFAULT 0, '+
              ' Totalcost             double    NULL DEFAULT 0, '+
              ' TotalcostInc          double    NULL DEFAULT 0, '+
              ' GrossProfit           double    NULL DEFAULT 0, '+
              ' GPPerCustomer         double    NULL DEFAULT 0, '+
              ' GPPerProduct          double    NULL DEFAULT 0, '+
              ' Stress15              INT       NULL DEFAULT 0, '+
              ' Stress5               INT       NULL DEFAULT 0, '+
              ' Streemorethan15       INT       NULL DEFAULT 0, '+
              ' PRIMARY KEY (ID) ) COLLATE="utf8_general_ci" ENGINE=MyISAM;');

      script.SQL.add('/*3*/insert ignore into ' + tablename + ' (employeeId , tillid, ClassId, timeFrom, timeto) ' +
              ' Select distinct EmployeeId ,tillid, ClassId, TimeFrom, Timeto from tblsales S , ' +
              '('+ hours(dateFrom, dateTo)+') '+' hours ' +
              ' where S.saleDatetime  between '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , datefrom)) +   ' and '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , DateTo)) +
                      iif(tillID>0 , ' and s.tillid = ' + inttostr(tillid ),'') +
                      ' and  S.IsLayby = "F" '+
                      ' and (S.POS = "T" or (s.ISPOS ="T" and S.POS ="F"))' +
              ' union Select distinct EmployeeId ,tillid, ClassId, TimeFrom, Timeto from tblsales_POS S , ' +
              '('+ hours(dateFrom, dateTo)+') '+' hours ' +
              ' where S.saleDatetime  between '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , datefrom)) +   ' and '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , DateTo)) +
                      iif(tillID>0 , ' and s.tillid = ' + inttostr(tillid ),'') +
                      ' and  S.IsLayby = "F" '+
                      ' and (S.POS = "T" or (s.ISPOS ="T" and S.POS ="F"))' +
              ' order by EmployeeId ;');

      {script.SQL.add('/*4*/'+updatefieldSQL( 'count(s.saleID )'                                                                      ,  'NoOfsales'          , False, '(s.isrefund<>"T"  )'));
      script.SQL.add('/*5*/' +updatefieldSQL( 'count(distinct s.clientID)'                                                            ,  'NoOfCustomers'      , False(*, '(s.isrefund<>"T"  )'*)));
      script.SQL.add('/*6*/' +updatefieldSQL(' count(distinct SL.ProductID) '                                                         ,  'NoOfProducts'       , True (*, '(s.isrefund<>"T" and SL.shipped>0 )'*)));
      script.SQL.add('/*6*/' +updatefieldSQL(' Sum(SL.UnitofMeasureShipped) '                                                         ,  'UOMQty'             , True (*, '(s.isrefund<>"T" and SL.shipped>0 )'*)));
      script.SQL.add('/*6*/' +updatefieldSQL(' Sum(SL.Shipped) '                                                                      ,  'Qty'                , True (*, '(s.isrefund<>"T" and SL.shipped>0 )'*)));
      script.SQL.add('/*7*/' +updatefieldSQL( 'count( distinct s.SaleID)'                                                             ,  'NoOfReturns'        , True  , '(s.isrefund="T" or (SL.shipped<0 and s.isrefund<>"T" ))'));
      script.SQL.add('/*8*/' +updatefieldSQL(' sum(if(s.isrefund="T" or (SL.shipped<0 and s.isrefund<>"T" ),1,0)) '                   ,  'NoOfReturnProducts' , True ));
      script.SQL.add('/*9*/' +updatefieldSQL(' count(distinct concat(S.clientID , "_" , SL.ProductID)) /count(distinct s.clientID) '  ,  'ItemsPercustomer'   , True (*, '(s.isrefund<>"T" and SL.shipped>0 )'*)));
      script.SQL.add('/*9*/' +updatefieldSQL(' Sum(SL.Shipped) /count(distinct s.clientID) '                                          ,  'QtyPerCustomer'     , True (*, '(s.isrefund<>"T" and SL.shipped>0 )'*)));
      script.SQL.add('/*10*/'+updatefieldSQL(' count(distinct S.saleID) /count(distinct s.clientID) '                                 ,  'SalesPerCustomer'   , False(*, '(s.isrefund<>"T" )'*)));
      script.SQL.add('/*11*/'+updatefieldSQL(' Sum(S.totalamount) '                                                                    ,  'TotalsalesAmount'   , False(*, '(s.isrefund<>"T"  )'*)));
      script.SQL.add('/*12*/'+updatefieldSQL(' Sum(S.totalamountInc) '                                                                 ,  'TotalsalesAmountinc', False(*, '(s.isrefund<>"T" )'*)));
      script.SQL.add('/*13*/'+updatefieldSQL(' Sum(SL.LineCost * SL.shipped) '                                                         ,  'TotalCost'          , True (*, '(s.isrefund<>"T" and SL.shipped>0 )'*)));
      script.SQL.add('/*14*/'+updatefieldSQL(' Sum(SL.LineCostInc * SL.shipped) '                                                      ,  'TotalCostInc'       , True (*, '(s.isrefund<>"T" and SL.shipped>0 )'*)));}
      script.SQL.add(AllSales);
      script.SQL.add(AllSaleslines);
      script.SQL.add('/*4*/' +updatefieldSQL( 'count(saleID )'                                                                 ,  'NoOfsales'          , False, '(isrefund<>"T"  )'));
      script.SQL.add('/*5*/' +updatefieldSQL( 'count(distinct clientID)'                                                       ,  'NoOfCustomers'      , False));
      script.SQL.add('/*6*/' +updatefieldSQL(' count(distinct ProductID) '                                                     ,  'NoOfProducts'       , True ));
      script.SQL.add('/*6*/' +updatefieldSQL(' Sum(UnitofMeasureShipped) '                                                     ,  'UOMQty'             , True ));
      script.SQL.add('/*6*/' +updatefieldSQL(' Sum(Shipped) '                                                                  ,  'Qty'                , True ));
      script.SQL.add('/*7*/' +updatefieldSQL( 'count( distinct SaleID)'                                                        ,  'NoOfReturns'        , True  , '(isrefund="T" or (shipped<0 and isrefund<>"T" ))'));
      script.SQL.add('/*8*/' +updatefieldSQL(' sum(if(isrefund="T" or (shipped<0 and isrefund<>"T" ),1,0)) '                   ,  'NoOfReturnProducts' , True ));
      script.SQL.add('/*9*/' +updatefieldSQL(' count(distinct concat(clientID , "_" , ProductID)) /count(distinct clientID) '  ,  'ItemsPercustomer'   , True ));
      script.SQL.add('/*9*/' +updatefieldSQL(' Sum(Shipped) /count(distinct clientID) '                                        ,  'QtyPerCustomer'     , True ));
      script.SQL.add('/*10*/'+updatefieldSQL(' count(distinct saleID) /count(distinct clientID) '                              ,  'SalesPerCustomer'   , False));
      script.SQL.add('/*11*/'+updatefieldSQL(' Sum(totalamount) '                                                              ,  'TotalsalesAmount'   , False));
      script.SQL.add('/*12*/'+updatefieldSQL(' Sum(totalamountInc) '                                                           ,  'TotalsalesAmountinc', False));
      script.SQL.add('/*13*/'+updatefieldSQL(' Sum(LineCost * shipped) '                                                       ,  'TotalCost'          , True ));
      script.SQL.add('/*14*/'+updatefieldSQL(' Sum(LineCostInc * shipped) '                                                    ,  'TotalCostInc'       , True ));


      script.SQL.add('/*15*/  update '+ tablename +' Set  GrossProfit = (TotalsalesAmountinc-TotalCostInc ) ;');
      script.SQL.add('/*16*/  update '+ tablename +' Set  GPPerCustomer = (TotalsalesAmountinc-TotalCostInc ) / NoOfCustomers;');
      script.SQL.add('/*17*/  update '+ tablename +' Set  GPPerProduct = (TotalsalesAmountinc -TotalCostInc ) / NoOfProducts;');
      script.SQL.add('/*17*/  update '+ tablename +' Set  salesAmountIncPerItem = (TotalsalesAmountinc  ) / NoOfProducts;');
(*      script.SQL.add('/*18*/'+updatefieldSQL(' sum(ifnull(if(TIME_TO_SEC((Select min(NS.saleDateTime) from tblsales NS where NS.SaleDateTime> S.saledatetime)) - TIME_TO_SEC(S.SaleDateTime)<= 15 , 1 , 0),0) )  ',  'Stress15'       , False ));
      script.SQL.add('/*19*/'+updatefieldSQL(' sum(ifnull(if(TIME_TO_SEC((Select min(NS.saleDateTime) from tblsales NS where NS.SaleDateTime> S.saledatetime)) - TIME_TO_SEC(S.SaleDateTime)<= 5  , 1 , 0),0) )  ',  'Stress5'       , False ));
      script.SQL.add('/*20*/'+updatefieldSQL(' sum(ifnull(if(TIME_TO_SEC((Select min(NS.saleDateTime) from tblsales NS where NS.SaleDateTime> S.saledatetime)) - TIME_TO_SEC(S.SaleDateTime)>  15 , 1 , 0),0) )  ',  'Streemorethan15'       , False ));*)
      (*script.SQL.add('/*18*/drop table if exists '+ tablename +'3;'+
              ' create table '+ tablename +'3 '+
              'select S.saleID,S.saleDatetime, S.tillId ,S.classId '+
                              ' from tblsales S '+
                              ' where s.Saledatetime >= t.timeFrom  and s.Saledatetime <= t.timeto  '+
                              ' and S.IsLayby = "F" and (S.POS = "T" or (s.ISPOS ="T" and S.POS ="F") ) '+ iif(tillId<>0 , ' and S.tillid = ' + inttostr(tillID) , '') +
                              ' union all '+
              ' select S.saleID,S.saleDatetime , S.tillId  ,S.classId'+
                              ' from tblsales_pos S'+
                              ' where s.Saledatetime >= t.timeFrom  and s.Saledatetime <= t.timeto  ' +
                              ' and S.IsLayby = "F" and (S.POS = "T" or (s.ISPOS ="T" and S.POS ="F") ) '+ iif(tillId<>0 , ' and S.tillid = ' + inttostr(tillID) , '') +
              ' Alter table '+ tablename +'3 add index saleID (saleID);'+
              ' Alter table '+ tablename +'3 add index tillId (tillId);'+
              ' Alter table '+ tablename +'3 add index classId (classId);');*)
      script.SQL.add(POSSalesTime(Tablename+'3'));
      script.SQL.add('/*19*/'+updatefieldSQL(' sum(ifnull(if(TIME_TO_SEC(S.SaleDateTime) - TIME_TO_SEC((Select max(PS.saleDateTime) from '+ tablename +'3 PS where PS.classID = S.classId and  PS.SaleDateTime< S.saledatetime)) <= 15 , 1 , 0),0) )  ',  'Stress15'       , False ));
      script.SQL.add('/*20*/'+updatefieldSQL(' sum(ifnull(if(TIME_TO_SEC(S.SaleDateTime) - TIME_TO_SEC((Select max(PS.saleDateTime) from '+ tablename +'3 PS where PS.classID = S.classId and PS.SaleDateTime< S.saledatetime)) <= 5  , 1 , 0),0) )  ',  'Stress5'       , False ));
      script.SQL.add('/*21*/'+updatefieldSQL(' sum(ifnull(if(TIME_TO_SEC(S.SaleDateTime) - TIME_TO_SEC((Select max(PS.saleDateTime) from '+ tablename +'3 PS where PS.classID = S.classId and PS.SaleDateTime< S.saledatetime)) >  15 , 1 , 0),0) )  ',  'Streemorethan15'       , False ));


      script.SQL.add('drop table if exists '+ tablename +'Sales;');
      script.SQL.add('drop table if exists '+ tablename +'Saleslines;');
      script.SQL.add('/*22*/drop table if exists '+ tablename +'3;');
  finally
    clog(Script.SQl.text);
    Script.execute;
    DbSharedObj.releaseOBJ(Script);
  end;

end;
function ForRetail(ReportName:String):Boolean ;
begin
  result := (PosEx(uppercase('Retail') , uppercase(reportName)) >0) or
            (PosEx(uppercase('combined') , uppercase(reportName)) >0);
end;
function ForWholeSale(ReportName:String):boolean;
begin
  result := (PosEx(uppercase('WholeSale') , uppercase(reportName)) >0) or
            (PosEx(uppercase('combined') , uppercase(reportName)) >0);
end;
Function SalesProductListSQL(const TillIDs:String; DateFrom:TDateTime=0; Dateto:TDatetime=0 ):String;

var
  st : TStringlist;

begin
  st:= TStringlist.create;
  try
    st.add('select Distinct ' +
          ' P.partsId           as partsId , ' +
          ' P.partname          as partname, ' +
          ' P.Description       as SalesDescription, ' +
          ' P.PURCHASEDESC      as PurchaseDescription, ' +
          ' concat(UOM.UnitName , "(" , UOM.Multiplier , ")") as UOM , ' +
          ' UOM.UnitID          as UnitID, ' +
          ' Retailer.Price1*UOM.Multiplier     as RetailPRICE, ' +
          ' P.WHOLESALEPRICE*UOM.Multiplier    as WHOLESALEPRICE, ' +
          ' P.COST1*UOM.Multiplier             as COST1, ' +
          ' P.COST2*UOM.Multiplier             as COST2, ' +
          ' P.COST3*UOM.Multiplier             as COST3, ' +
          ' P.COSTINC1*UOM.Multiplier          as COSTINC1, ' +
          ' P.COSTINC2*UOM.Multiplier          as COSTINC2, ' +
          ' P.COSTINC3*UOM.Multiplier          as COSTINC3,' +
          ' P.PRICE1*UOM.Multiplier            as PRICE1  , ' +
          ' P.PRICE2*UOM.Multiplier            as PRICE2,' +
          ' P.PRICE3*UOM.Multiplier            as PRICE3, ' +
          ' P.PRICEINC1*UOM.Multiplier         as PRICEINC1, ' +
          ' P.PRICEINC2*UOM.Multiplier         as PRICEINC2, ' +
          ' P.PRICEINC3*UOM.Multiplier         as PRICEINC3, '+
          ' WholeSaler1.Price1*UOM.Multiplier  as WSP1, ' +
          ' WholeSaler2.Price1*UOM.Multiplier  as WSP2, ' +
          ' WholeSaler3.Price1*UOM.Multiplier  as WSP3, ' +
          ' WholeSaler4.Price1*UOM.Multiplier  as WSP4 ' );
    st.add('from tblsales_POS S inner join tblsaleslines_pos SL on s.saleId = SL.saleId and ifnull(SL.shipped,0)<>0');
    st.add('inner join tblparts P on P.partsId = SL.productId ' +
                  ' inner join tblunitsofmeasure UOM on SL.UnitOfMeasureID = UOM.UnitID ' +
                  ' left join tblextrapricesell Retailer on Retailer.UOMID = UOM.UnitID and Retailer.PartsID = UOM.PartID and Retailer.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.RetailcustomerType1))+
                  ' left join tblextrapricesell WholeSaler1 on WholeSaler1.UOMID = UOM.UnitID and WholeSaler1.PartsID = UOM.PartID and WholeSaler1.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType1))+
                  ' left join tblextrapricesell WholeSaler2 on WholeSaler2.UOMID = UOM.UnitID and WholeSaler2.PartsID = UOM.PartID and WholeSaler2.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType2))+
                  ' left join tblextrapricesell WholeSaler3 on WholeSaler3.UOMID = UOM.UnitID and WholeSaler3.PartsID = UOM.PartID and WholeSaler3.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType3))+
                  ' left join tblextrapricesell WholeSaler4 on WholeSaler4.UOMID = UOM.UnitID and WholeSaler4.PartsID = UOM.PartID and WholeSaler4.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType4)) );

    st.add('Where S.tillid in ('+ TillIDs +')');
    if (DateFrom>0 ) and (Dateto>0) then st.add('and S.saleDatetime between ' + Quotedstr(FormatdateTime(MysqlDatetimeFormat , datefrom)) +   ' and '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , DateTo)) );
    st.add('having ifnull(RetailPRICE,0)<> 0 or ifnull(WSP1,0)<> 0  or ifnull(WSP2,0)<> 0  or ifnull(WSP3,0)<> 0  or ifnull(WSP4,0)<> 0  ' );
    st.add('union all');
    st.add('select   Distinct  ' +
          ' P.partsId           as partsId , ' +
          ' P.partname          as partname, ' +
          ' P.Description       as SalesDescription, ' +
          ' P.PURCHASEDESC      as PurchaseDescription, ' +
          ' concat(UOM.UnitName , "(" , UOM.Multiplier , ")") as UOM , ' +
          ' UOM.UnitID          as UnitID, ' +
          ' Retailer.Price1*UOM.Multiplier     as RetailPRICE, ' +
          ' P.WHOLESALEPRICE*UOM.Multiplier    as WHOLESALEPRICE, ' +
          ' P.COST1*UOM.Multiplier             as COST1, ' +
          ' P.COST2*UOM.Multiplier             as COST2, ' +
          ' P.COST3*UOM.Multiplier             as COST3, ' +
          ' P.COSTINC1*UOM.Multiplier          as COSTINC1, ' +
          ' P.COSTINC2*UOM.Multiplier          as COSTINC2, ' +
          ' P.COSTINC3*UOM.Multiplier          as COSTINC3,' +
          ' P.PRICE1*UOM.Multiplier            as PRICE1  , ' +
          ' P.PRICE2*UOM.Multiplier            as PRICE2,' +
          ' P.PRICE3*UOM.Multiplier            as PRICE3, ' +
          ' P.PRICEINC1*UOM.Multiplier         as PRICEINC1, ' +
          ' P.PRICEINC2*UOM.Multiplier         as PRICEINC2, ' +
          ' P.PRICEINC3*UOM.Multiplier         as PRICEINC3, '+
          ' WholeSaler1.Price1*UOM.Multiplier  as WSP1, ' +
          ' WholeSaler2.Price1*UOM.Multiplier  as WSP2, ' +
          ' WholeSaler3.Price1*UOM.Multiplier  as WSP3, ' +
          ' WholeSaler4.Price1*UOM.Multiplier  as WSP4 ' );
    st.add('from tblsales S inner join tblsaleslines SL on s.saleId = SL.saleId  and ifnull(SL.shipped,0)<>0');
    st.add('inner join tblparts P on P.partsId = SL.productId');
    st.add('inner join tblunitsofmeasure UOM on SL.UnitOfMeasureID = UOM.UnitID ' +
                  ' left join tblextrapricesell Retailer on Retailer.UOMID = UOM.UnitID and Retailer.PartsID = UOM.PartID and Retailer.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.RetailcustomerType1))+
                  ' left join tblextrapricesell WholeSaler1 on WholeSaler1.UOMID = UOM.UnitID and WholeSaler1.PartsID = UOM.PartID and WholeSaler1.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType1))+
                  ' left join tblextrapricesell WholeSaler2 on WholeSaler2.UOMID = UOM.UnitID and WholeSaler2.PartsID = UOM.PartID and WholeSaler2.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType2))+
                  ' left join tblextrapricesell WholeSaler3 on WholeSaler3.UOMID = UOM.UnitID and WholeSaler3.PartsID = UOM.PartID and WholeSaler3.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType3))+
                  ' left join tblextrapricesell WholeSaler4 on WholeSaler4.UOMID = UOM.UnitID and WholeSaler4.PartsID = UOM.PartID and WholeSaler4.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType4)) );
    st.add('Where S.IsLayby = "F"  and  S.tillid in ('+ TillIDs +')');
    if (DateFrom>0 ) and (Dateto>0) then st.add('and S.isPOS = "T" and S.saleDatetime between ' + Quotedstr(FormatdateTime(MysqlDatetimeFormat , datefrom)) +   ' and '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , DateTo)) )
    else st.add('and S.POS = "F" and S.ISPOS ="T"' );
    st.add('having ifnull(RetailPRICE,0)<> 0 or ifnull(WSP1,0)<> 0  or ifnull(WSP2,0)<> 0  or ifnull(WSP3,0)<> 0  or ifnull(WSP4,0)<> 0  ' );
    st.add('union all Select   Distinct ' +
          ' P.partsId           as partsId , ' +
          ' P.partname          as partname, ' +
          ' P.Description       as SalesDescription, ' +
          ' P.PURCHASEDESC      as PurchaseDescription, ' +
          ' NULL                as UOM , ' +
          ' NULL                as UnitID, ' +
          ' Retailer.Price1     as RetailPRICE, ' +
          ' P.WHOLESALEPRICE    as WHOLESALEPRICE, ' +
          ' P.COST1             as COST1, ' +
          ' P.COST2             as COST2, ' +
          ' P.COST3             as COST3, ' +
          ' P.COSTINC1          as COSTINC1, ' +
          ' P.COSTINC2          as COSTINC2, ' +
          ' P.COSTINC3          as COSTINC3,' +
          ' P.PRICE1            as PRICE1  , ' +
          ' P.PRICE2            as PRICE2,' +
          ' P.PRICE3            as PRICE3, ' +
          ' P.PRICEINC1         as PRICEINC1, ' +
          ' P.PRICEINC2         as PRICEINC2, ' +
          ' P.PRICEINC3         as PRICEINC3, '+
          ' WholeSaler1.Price1  as WSP1, ' +
          ' WholeSaler2.Price1  as WSP2, ' +
          ' WholeSaler3.Price1  as WSP3, ' +
          ' WholeSaler4.Price1  as WSP4 ');
    st.add('from tblsales_POS S inner join tblsaleslines_pos SL on s.saleId = SL.saleId and ifnull(SL.shipped,0)<>0');
    st.add('inner join tblparts P on P.partsId = SL.productId ' +
                  ' LEFT JOIN tblextrapricesell Retailer ON (IFNULL(Retailer.UOMID,0)=0 AND Retailer.PartsId = P.partsID) AND Retailer.ClientTypeID = '  + inttostr(getClientTypeID(Appenv.companyprefs.RetailcustomerType1))+
                  ' LEFT JOIN tblextrapricesell WholeSaler1 ON (IFNULL(WholeSaler1.UOMID,0)=0 AND WholeSaler1.PartsId = P.partsID) AND WholeSaler1.ClientTypeID = '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType1))+
                  ' LEFT JOIN tblextrapricesell WholeSaler2 ON (IFNULL(WholeSaler2.UOMID,0)=0 AND WholeSaler2.PartsId = P.partsID) AND WholeSaler2.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType2))+
                  ' LEFT JOIN tblextrapricesell WholeSaler3 ON (IFNULL(WholeSaler3.UOMID,0)=0 AND WholeSaler3.PartsId = P.partsID) AND WholeSaler3.ClientTypeID =   '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType3))+
                  ' LEFT JOIN tblextrapricesell WholeSaler4 ON (IFNULL(WholeSaler4.UOMID,0)=0 AND WholeSaler4.PartsId = P.partsID) AND WholeSaler4.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType4)));

    st.add('Where S.tillid in ('+ TillIDs +')');
    if (DateFrom>0 ) and (Dateto>0) then st.add('and S.saleDatetime between ' + Quotedstr(FormatdateTime(MysqlDatetimeFormat , datefrom)) +   ' and '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , DateTo)) );
    st.add('having  ifnull(RetailPRICE,0)<> 0 or ifnull(WSP1,0)<> 0  or ifnull(WSP2,0)<> 0  or ifnull(WSP3,0)<> 0  or ifnull(WSP4,0)<> 0  ' );
    st.add('union all Select   Distinct ' +
          ' P.partsId           as partsId , ' +
          ' P.partname          as partname, ' +
          ' P.Description       as SalesDescription, ' +
          ' P.PURCHASEDESC      as PurchaseDescription, ' +
          ' NULL                as UOM , ' +
          ' NULL                as UnitID, ' +
          ' Retailer.Price1     as RetailPRICE, ' +
          ' P.WHOLESALEPRICE    as WHOLESALEPRICE, ' +
          ' P.COST1             as COST1, ' +
          ' P.COST2             as COST2, ' +
          ' P.COST3             as COST3, ' +
          ' P.COSTINC1          as COSTINC1, ' +
          ' P.COSTINC2          as COSTINC2, ' +
          ' P.COSTINC3          as COSTINC3,' +
          ' P.PRICE1            as PRICE1  , ' +
          ' P.PRICE2            as PRICE2,' +
          ' P.PRICE3            as PRICE3, ' +
          ' P.PRICEINC1         as PRICEINC1, ' +
          ' P.PRICEINC2         as PRICEINC2, ' +
          ' P.PRICEINC3         as PRICEINC3, '+
          ' WholeSaler1.Price1  as WSP1, ' +
          ' WholeSaler2.Price1  as WSP2, ' +
          ' WholeSaler3.Price1  as WSP3, ' +
          ' WholeSaler4.Price1  as WSP4 ');
    st.add('from tblsales S inner join tblsaleslines SL on s.saleId = SL.saleId  and ifnull(SL.shipped,0)<>0');
    st.add('inner join tblparts P on P.partsId = SL.productId');
    st.add(' LEFT JOIN tblextrapricesell Retailer ON (IFNULL(Retailer.UOMID,0)=0 AND Retailer.PartsId = P.partsID) AND Retailer.ClientTypeID = '  + inttostr(getClientTypeID(Appenv.companyprefs.RetailcustomerType1))+
                  ' LEFT JOIN tblextrapricesell WholeSaler1 ON (IFNULL(WholeSaler1.UOMID,0)=0 AND WholeSaler1.PartsId = P.partsID) AND WholeSaler1.ClientTypeID = '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType1))+
                  ' LEFT JOIN tblextrapricesell WholeSaler2 ON (IFNULL(WholeSaler2.UOMID,0)=0 AND WholeSaler2.PartsId = P.partsID) AND WholeSaler2.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType2))+
                  ' LEFT JOIN tblextrapricesell WholeSaler3 ON (IFNULL(WholeSaler3.UOMID,0)=0 AND WholeSaler3.PartsId = P.partsID) AND WholeSaler3.ClientTypeID =   '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType3))+
                  ' LEFT JOIN tblextrapricesell WholeSaler4 ON (IFNULL(WholeSaler4.UOMID,0)=0 AND WholeSaler4.PartsId = P.partsID) AND WholeSaler4.ClientTypeID =  '  + inttostr(getClientTypeID(Appenv.companyprefs.WholeSaleCustomerType4)));
    st.add('Where S.IsLayby = "F"  and  S.tillid in ('+ TillIDs +')');
    if (DateFrom>0 ) and (Dateto>0) then st.add('and S.isPOS = "T" and S.saleDatetime between ' + Quotedstr(FormatdateTime(MysqlDatetimeFormat , datefrom)) +   ' and '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , DateTo)) )
    else st.add('and S.POS = "F" and S.ISPOS ="T"' );
    st.add('having  ifnull(RetailPRICE,0)<> 0 or ifnull(WSP1,0)<> 0  or ifnull(WSP2,0)<> 0  or ifnull(WSP3,0)<> 0  or ifnull(WSP4,0)<> 0  ' );
    st.add(' order by Partname');
  finally
    result := st.text;
    Freeandnil(st);
  end;
end;
Function SalesCollatedByItemListSQL(const TillIDs:String; DateFrom:TDateTime=0; Dateto:TDatetime=0; ReportName:String =''):String;
var
  st:TStringlist;
Function Retailwholesalefilter:String;
var
  s1, s2 :String;
begin

  result := '';
  s1:= '';
  s2:= '';
    if ForRetail(ReportName)    then s1:=  ' ifnull(C.ClientTypeID,0)<>0 and  CT.TypeName = ' + Quotedstr(Appenv.companyprefs.RetailcustomerType1);
    if ForWholeSale(ReportName) then s2:=  ' ifnull(C.ClientTypeID,0)<>0 and  CT.TypeName in ( ' +  Quotedstr(Appenv.companyprefs.WholeSaleCustomerType1)+',' +
                                                                                        Quotedstr(Appenv.companyprefs.WholeSaleCustomerType2)+',' +
                                                                                        Quotedstr(Appenv.companyprefs.WholeSaleCustomerType3)+',' +
                                                                                        Quotedstr(Appenv.companyprefs.WholeSaleCustomerType4)+')';
    if (s1<>'') and (s2<>'') then result := ' and ((' + s1 +') or (' + s2+'))'
    else if s1 <> '' then result := ' and (' + s1 +') '
    else if s2 <> '' then result := ' and (' + s2 +') ';
end;
begin
  {if date range is not passed into it, its the list of POS not processed in EOP}
  st:= TStringlist.create;
  try
    st.add('select ');
    st.add('1 as Category, ');
    st.add('S.saleId          as saleId,');
    st.add('CT.TypeName as CustomerType,');
    st.add('s.customername           as customername,');
    st.add(Firstcolumn   +'          as Column1,');
    st.add(Secondcolumn  +'          as Column2,');
    st.add(thirdcolumn   +'          as Column3,');
    st.add('Sl.productname           as productname,');
    st.add('concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier  , ")" ) as UOM,');
    st.add('U.BaseUnitName as BaseUnitName,');
    st.add('SL.UnitofMeasureShipped  as UnitofMeasureShipped,');
    st.add('SL.shipped as shipped,');
    st.add('SL.Shipped  as Shipped,');
    st.add('SL.LinePriceInc          as LinePriceInc,');
    st.add('SL.LinePrice             as LinePrice,');
    st.add('SL.Discounts             as Discounts,');
    st.add('SL.DiscountPercent       as DiscountPercent,');
    st.add('SL.Markup                as Markup,');
    st.add('SL.MarkupPercent         as MarkupPercent,');
    st.add('Round(((SL.TotalLineAmount - (ifnull(SL.LineCost,0)*SL.shipped )) / SL.TotalLineAmount) * 100, 5) as marginPercent ,');
    st.add('Round(((SL.TotalLineAmount - (ifnull(SL.LineCost,0)*SL.shipped )) ),5) as margin ,');
    st.add('SL.LineCost as LineCost,');
    st.add('ifnull(SL.LineCost,0)*SL.shipped  as totalLineCost,');
    st.add('P.LatestCost             as LatestCost,');
    st.add('P.AvgCost                as AvgCost,');
    st.add('P.PRICE1                 as PRICE1,');
    st.add('P.PRICEINC1              as PRICEINC1,');
    st.add('SL.TotalLineAmount       as TotalLineAmount,');
    st.add('SL.TotalLineAmountInc    as TotalLineAmountInc,');
    st.add('SL.LineTax               as LineTax, ');
    st.add('"F" as EOPDone ');
    st.add('from tblsales_POS S inner join tblsaleslines_pos SL on s.saleId = SL.saleId and ifnull(SL.shipped,0)<>0');
    st.add('Inner join tblunitsofmeasure U  on U.UnitId = SL.UnitOfMeasureID');
    st.add('inner join (tblclients C Left join tblclienttype CT on CT.ClientTypeID = C.ClientTypeID ) on c.clientId = S.clientID ');
    st.add('inner join tblparts P on P.partsId = SL.productId');
    st.add('Where S.tillid in ('+ TillIDs +')');
    if (DateFrom>0 ) and (Dateto>0) then st.add('and S.saleDatetime between ' + Quotedstr(FormatdateTime(MysqlDatetimeFormat , datefrom)) +   ' and '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , DateTo)) );
    st.add(retailwholeSalefilter);

    st.add('union all');
    st.add('select  ');
    st.add('2 as Category, ');
    st.add('S.saleId          as saleId,');
    st.add('CT.TypeName as CustomerType,');
    st.add('s.customername           as customername,');
    st.add(Firstcolumn   +'          as Column1,');
    st.add(Secondcolumn  +'          as Column2,');
    st.add(thirdcolumn   +'          as Column3,');
    st.add('Sl.productname           as productname,');
    st.add('concat(SL.UnitofMeasureSaleLines , "(" , SL.UnitofMeasureMultiplier  , ")" ) as UOM,');
    st.add('U.BaseUnitName as BaseUnitName,');
    st.add('SL.UnitofMeasureShipped  as UnitofMeasureShipped,');
    st.add('SL.shipped  as shipped,');
    st.add('SL.Shipped  as Shipped,');
    st.add('SL.LinePriceInc          as LinePriceInc,');
    st.add('SL.LinePrice             as LinePrice,');
    st.add('SL.Discounts             as Discounts,');
    st.add('SL.DiscountPercent       as DiscountPercent,');
    st.add('SL.Markup                as Markup,');
    st.add('SL.MarkupPercent         as MarkupPercent,');
    st.add('Round(((SL.TotalLineAmount - (ifnull(SL.LineCost,0)*SL.shipped )) / SL.TotalLineAmount) * 100, 5) as marginPercent,');
    st.add('Round(((SL.TotalLineAmount - (ifnull(SL.LineCost,0)*SL.shipped )) ),5) as margin ,');
    st.add('SL.LineCost as LineCost,');
    st.add('ifnull(SL.LineCost,0)*SL.shipped  as totalLineCost,');
    st.add('P.LatestCost             as LatestCost,');
    st.add('P.AvgCost                as AvgCost,');
    st.add('P.PRICE1                 as PRICE1,');
    st.add('P.PRICEINC1              as PRICEINC1,');
    st.add('SL.TotalLineAmount       as TotalLineAmount,');
    st.add('SL.TotalLineAmountInc    as TotalLineAmountInc,');
    st.add('SL.LineTax               as LineTax,');
    st.add('if(S.POS = "F"  , "T" , "F")  as EOPDone ');

    st.add('from tblsales S inner join tblsaleslines SL on s.saleId = SL.saleId  and ifnull(SL.shipped,0)<>0');
    st.add('Inner join tblunitsofmeasure U  on U.UnitId = SL.UnitOfMeasureID');
    st.add('inner join (tblclients C Left join tblclienttype CT on CT.ClientTypeID = C.ClientTypeID ) on c.clientId = S.clientID ');
    st.add('inner join tblparts P on P.partsId = SL.productId');
    st.add('Where S.IsLayby = "F"  and  S.tillid in ('+ TillIDs +')');
    if (DateFrom>0 ) and (Dateto>0) then st.add('and S.isPOS = "T" and S.saleDatetime between ' + Quotedstr(FormatdateTime(MysqlDatetimeFormat , datefrom)) +   ' and '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , DateTo)) )
    else st.add('and S.POS = "F" and S.ISPOS ="T"' );
    st.add(retailwholeSalefilter);
    if (ForWholeSale(ReportName) or ForRetail(ReportName) ) and (Appenv.Companyprefs.HideCustomertypeNotSelectedinSalesCatgbyItemReport = false) then begin
      if ReportName <> '' then begin
          st.add('union all');
          st.add('select distinct  ');
          st.add('3 as Category, ');
          st.add('null          as saleId,  ');
          st.add('Null as CustomerType,');
          st.add('null   as customername, ');
          st.add(Firstcolumn   +'          as Column1, ');
          st.add(Secondcolumn  +'          as Column2, ');
          st.add(thirdcolumn   +'          as Column3, ');
          st.add('null  as productname, ');
          st.add('null   as UOM, ');
          st.add('null as BaseUnitName,');
          st.add('null   as UnitofMeasureShipped, ');
          st.add('null   as shipped, ');
          st.add('null   as Shipped, ');
          st.add('null   as LinePriceInc, ');
          st.add('null   as LinePrice, ');
          st.add('null   as Discounts, ');
          st.add('null   as DiscountPercent, ');
          st.add('null   as Markup, ');
          st.add('null   as MarkupPercent, ');
          st.add('null   as marginPercent, ');
          st.add('null   as margin , ');
          st.add('null   as LineCost, ');
          st.add('null   as totalLineCost, ');
          st.add('null   as LatestCost, ');
          st.add('null   as AvgCost, ');
          st.add('null   as PRICE1, ');
          st.add('null   as PRICEINC1, ');
          st.add('null   as TotalLineAmount, ');
          st.add('null   as TotalLineAmountInc, ');
          st.add('null   as LineTax, ');
          st.add('null   as EOPDone ');
          st.add('from tblparts P ');
          st.add('where ifnull('+Firstcolumn+',"")<> "" and productgroup <>  partname ');
          st.add('and  ' + Firstcolumn +'  <> "" ');
          st.add('and PartsId not in ( Select SL.productId from tblsales S inner join tblsaleslines SL on s.saleId = SL.saleId  and ifnull(SL.shipped,0)<>0');
                        st.add('inner join (tblclients C Left join tblclienttype CT on CT.ClientTypeID = C.ClientTypeID ) on c.clientId = S.clientID ');
                        st.add('Where S.IsLayby = "F"  and  S.tillid in ('+ TillIDs +')');
                        if (DateFrom>0 ) and (Dateto>0) then st.add('and S.isPOS = "T" and S.saleDatetime between ' + Quotedstr(FormatdateTime(MysqlDatetimeFormat , datefrom)) +   ' and '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , DateTo)) )
                        else st.add('and S.POS = "F" and S.ISPOS ="T"' );
                        st.add(retailwholeSalefilter);
          st.add(')');
          st.add('and PartsId not in ( Select SL.productId from tblsales_POS S inner join tblsaleslines_pos SL on s.saleId = SL.saleId  and ifnull(SL.shipped,0)<>0');
                        st.add('inner join (tblclients C Left join tblclienttype CT on CT.ClientTypeID = C.ClientTypeID ) on c.clientId = S.clientID ');
                        st.add('Where S.tillid in ('+ TillIDs +')');
                        if (DateFrom>0 ) and (Dateto>0) then st.add('and S.saleDatetime between ' + Quotedstr(FormatdateTime(MysqlDatetimeFormat , datefrom)) +   ' and '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , DateTo)) );
                        st.add(retailwholeSalefilter);

          st.add(')');
      end;
    end;

    st.add('order by column1, column2, column3, Productname , saleId desc');

    if ForWholeSale(ReportName) then
          st.add('~|||~{WholeSaleClienttypes} Select fieldValue CustomerType from tbldbpreferences where name = "WholeSaleCustomerType1"  and ifnull(fieldvalue , "")<> "" '+
                                                        ' union all Select fieldValue CustomerType from tbldbpreferences where name = "WholeSaleCustomerType2" and ifnull(fieldvalue , "")<> "" '+
                                                        ' union all Select fieldValue CustomerType from tbldbpreferences where name = "WholeSaleCustomerType3" and ifnull(fieldvalue , "")<> "" '+
                                                        ' union all Select fieldValue CustomerType from tbldbpreferences where name = "WholeSaleCustomerType4" and ifnull(fieldvalue , "")<> ""');
    if ForRetail(ReportName) then
      st.add('~|||~{RetailClienttypes} Select fieldValue CustomerType from tbldbpreferences where name = "RetailcustomerType1"  and ifnull(fieldvalue , "")<> ""');
  finally
    REsult := st.text;
    clog(result);
    freeandNil(St);
  end;
end;
Function SalesCollatedByItemReportSQL(const TillIDs, reportname:String; DateFrom:TDateTime=0; Dateto:TDatetime=0):String;
begin
  result := companyInfoSQL+
        '~|||~{Details}';
  If FastFuncs.PosEx('Sales Product List', reportName) <>0  Then Begin
    Result:= Result+ SalesProductListSQL(tillIds, datefrom, DateTo );
  End else If FastFuncs.PosEx('(Sum)', reportName) = 0 Then Begin
      Result:= Result+ SalesCollatedByItemListSQL(tillIds, datefrom, DateTo , reportName);
  end else begin
    Result:= Result+' select '+
        Firstcolumn                  +' as Column1,'+
        Secondcolumn                 +' as Column2,'+
        Thirdcolumn                  +' as Column3,'+
        ' sum(SL.UnitofMeasureShipped)  as UnitofMeasureShipped,'+
        ' sum(SL.Shipped)               as Shipped,'+
        ' sum(SL.Shipped)               as Shipped,'+
        ' SL.LinePriceInc               as LinePriceInc,'+
        ' SL.LinePrice                  as LinePrice,'+
        ' sum(SL.Discounts)             as Discounts,'+
        ' sum(SL.Markup)                as Markup,'+
        ' Round(((sum(SL.TotalLineAmount) - sum((ifnull(SL.LineCost,0) * SL.shipped))) / sum(SL.TotalLineAmount)) * 100, 5) as marginPercent ,'+
        ' Round(sum(SL.TotalLineAmount) - sum(ifnull(SL.LineCost,0) * SL.shipped) ,5) as margin ,'+
        ' Avg(P.LatestCost)             as LatestCost,'+
        ' Avg(P.AvgCost)                as AvgCost,'+
        ' Avg(P.PRICE1)                 as PRICE1,'+
        ' Avg(P.PRICEINC1)              as PRICEINC1,'+
        ' sum(SL.TotalLineAmount)       as TotalLineAmount,'+
        ' sum(SL.TotalLineAmountInc)    as TotalLineAmountInc,'+
        ' sum(SL.LineTax)               as LineTax'+
        ' from tblsales_POS S inner join tblsaleslines_pos SL on s.saleId = SL.saleId  and ifnull(SL.shipped,0)<>0'+
        ' inner join tblparts P on P.partsId = SL.productId'+
        ' Where S.tillid in ('+ iif(TillIDs='' , 0 , TillIDs) +')'+
        iif((DateFrom>0 ) and (Dateto>0), 'and S.saleDatetime between ' + Quotedstr(FormatdateTime(MysqlDatetimeFormat , datefrom)) +   ' and '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , DateTo))  , '')+
        ' group by '+ Firstcolumn+','+Secondcolumn +','+Thirdcolumn +
        ' union all'+
        ' select '+
        Firstcolumn                  +' as Column1,'+
        Secondcolumn                 +' as Column2,'+
        Thirdcolumn                  +' as Column3,'+
        ' sum(SL.UnitofMeasureShipped)  as UnitofMeasureShipped,'+
        ' sum(SL.Shipped)               as Shipped,'+
        ' sum(SL.Shipped)               as Shipped,'+
        ' SL.LinePriceInc               as LinePriceInc,'+
        ' SL.LinePrice                  as LinePrice,'+
        ' sum(SL.Discounts)             as Discounts,'+
        ' sum(SL.Markup)                as Markup,'+
        ' Round(((sum(SL.TotalLineAmount) - sum((ifnull(SL.LineCost,0) * SL.shipped))) / sum(SL.TotalLineAmount)) * 100, 5) as marginPercent ,'+
        ' Round(sum(SL.TotalLineAmount) - sum(ifnull(SL.LineCost,0) * SL.shipped),5 ) as margin ,'+
        ' Avg(P.LatestCost)             as LatestCost,'+
        ' Avg(P.AvgCost)                as AvgCost,'+
        ' Avg(P.PRICE1)                 as PRICE1,'+
        ' Avg(P.PRICEINC1)              as PRICEINC1,'+
        ' sum(SL.TotalLineAmount)       as TotalLineAmount,'+
        ' sum(SL.TotalLineAmountInc)    as TotalLineAmountInc,'+
        ' sum(SL.LineTax)               as LineTax'+
        ' from tblsales S inner join tblsaleslines SL on s.saleId = SL.saleId  and ifnull(SL.shipped,0)<>0'+
        ' inner join tblparts P on P.partsId = SL.productId'+
        ' Where S.IsLayby = "F"  and  S.tillid in ('+ iif(TillIDs='' , 0 , TillIDs) +')'+
        iif((DateFrom>0 ) and (Dateto>0) ,
            ' and S.isPOS = "T" and S.saleDatetime between ' + Quotedstr(FormatdateTime(MysqlDatetimeFormat , datefrom)) +   ' and '+ Quotedstr(FormatdateTime(MysqlDatetimeFormat , DateTo)) ,
            ' and S.POS = "F" and S.ISPOS ="T"' )+
        ' group by '+ Firstcolumn+','+Secondcolumn +','+Thirdcolumn +
        ' order by column1, column2, column3';
  End;
  REsult := result + '~|||~' + ColumnHeadingsSQL ('' , Quotedstr(BooleantoStr(Appenv.companyprefs.HideCustomertypeNotSelectedinSalesCatgbyItemReport)) +' as HideCustomertypeNotSelectedinSalesCatgbyItemReport ');
end;
Function POSEOPStarttime(const Starttime:Tdatetime):Tdatetime;
begin
  REsult := StartTime;
  if Appenv.companyprefs.EOPReportShowAlltimeSlots then
    result := Dateof(StartTime);
end;
Function POSEOPEndtime(const Endtime:Tdatetime):Tdatetime;
begin
  REsult := Endtime;
  if Appenv.companyprefs.EOPReportShowAlltimeSlots then
    result := IncSecond(IncDay(dateof(endtime), 1), -1);

end;


end.
