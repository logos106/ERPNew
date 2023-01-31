unit ReportSqlProductStocknSalePeriod;

interface

uses ERPDbComponents, ReportSQLBase, classes;

type
  TPeriodtype = (ptMonth=1, ptQuarter =2, ptYear =3);
  TReportSqlProductStocknSalePeriod = Class(TReportSQLBase)
  Private
    fPeriodtype: TPeriodtype;
    fsQrymaintablename: String;
    Procedure CreateTempPLPeriodTable;
    Procedure AddDataToTempPLPeriodTable;
    Function Periodcount:Integer;
    Function PeriodDateFrom(Const Periodno:Integer):TDatetime;
    Function  PeriodDateto(Const Periodno:Integer):TDatetime;
    function Fieldname(const FieldSufix: String; periodno: Integer): String;
  Protected
  Public
    function PrepareForReport:Boolean; override;
    Property Qrymaintablename :String read fsQrymaintablename write fsQrymaintablename;
    Property Periodtype :TPeriodtype read fPeriodtype write fPeriodtype;
    Procedure MakeMainQryTable(SQL: TStrings);
    constructor Create(Aowner:TComponent);override;
    Destructor Destroy;override;

  End;

implementation

uses DbSharedObjectsObj, DateUtils, ProductQtyLib, sysutils, MySQLConst,
  CommonDbLib, PQALib, TempTableUtils, CommonLib, tcConst;

{ TReportSqlProductStocknSalePeriod }

procedure TReportSqlProductStocknSalePeriod.MakeMainQryTable(SQL: TStrings);
var
  ctr:Integer;
begin
  SQL.clear;
  SQL.Add('Select');
  for ctr := 1 to Periodcount do begin
                 SQL.Add('Sum(M.' + Fieldname('SalesShipQty'  ,ctr)+') as ' + Fieldname('SalesShipQty' ,ctr)+',');
                 SQL.Add('Sum(M.' + Fieldname('SalesBOQty'    ,ctr)+') as ' + Fieldname('SalesBOQty'   ,ctr)+',');
                 SQL.Add('Sum(M.' + Fieldname('SalesPrice'    ,ctr)+') as ' + Fieldname('SalesPrice'   ,ctr)+',');
                 SQL.Add('Sum(M.' + Fieldname('SalesBOPrice'  ,ctr)+') as ' + Fieldname('SalesBOPrice' ,ctr)+',');
                 SQL.Add('Sum(M.' + Fieldname('SalesCost'     ,ctr)+') as ' + Fieldname('SalesCost'    ,ctr)+',');
                 SQL.Add('Sum(M.' + Fieldname('SalesBOCost'   ,ctr)+') as ' + Fieldname('SalesBOCost'  ,ctr)+',');
                 SQL.Add('Sum(M.' + Fieldname('StockQty'      ,ctr)+') as ' + Fieldname('StockQty'     ,ctr)+',');
                 SQL.Add('Sum(M.' + Fieldname('StockCost'     ,ctr)+') as ' + Fieldname('StockCost'    ,ctr)+',');
                 SQL.Add('H.' + Fieldname('TypeDesc'          ,ctr)+'  as '+ Fieldname('TypeDesc'     ,ctr)+',');
                 SQL.Add('H.' + Fieldname('dateFrom'          ,ctr)+'  as '+ Fieldname('dateFrom'     ,ctr)+',');
                 SQL.Add('H.' + Fieldname('DateTo'            ,ctr)+'  as '+ Fieldname('DateTo'       ,ctr)+',');
  end;
  SQL.Add('H.PeriodType as PeriodType');
  SQL.Add('from ' + Qrymaintablename + ' M, '+ Qrymaintablename +'_CH H ');
end;
Function TReportSqlProductStocknSalePeriod.Periodcount:Integer;
begin
  if Periodtype =ptYear then result := DateUtils.YearsBetween(Datefrom, dateto)
  else if Periodtype =ptMonth then result := DateUtils.MonthsBetween(Datefrom, dateto)
  else if trunc(DateUtils.MonthsBetween(Datefrom, dateto)/3) <> DateUtils.MonthsBetween(Datefrom, dateto)/3 then
    result := trunc(DateUtils.MonthsBetween(Datefrom, dateto)/3)+1 else result := trunc(DateUtils.MonthsBetween(Datefrom, dateto)/3);
end;

Function TReportSqlProductStocknSalePeriod.PeriodDateFrom(Const Periodno:Integer):TDatetime;
begin
         if Periodtype =ptYear  then result := incyear(datefrom, periodno-1)
    else if Periodtype =ptMonth then result := incmonth(datefrom, periodno-1)
    else result := incmonth(datefrom, (periodno-1)*3);
end;
Function TReportSqlProductStocknSalePeriod.PeriodDateto(Const Periodno:Integer):TDatetime;
begin
         if Periodtype =ptYear  then result := incyear(datefrom, periodno)
    else if Periodtype =ptMonth then result := incmonth(datefrom, periodno)
    else result := incmonth(datefrom, (periodno)*3);
    result := incsecond(result, -1);
end;
  Function TReportSqlProductStocknSalePeriod.Fieldname(const FieldSufix:String; periodno:Integer):String;
  begin
      result := trim(FieldSufix)+'_' +trim(inttostr(periodno));
  end;
constructor TReportSqlProductStocknSalePeriod.Create(Aowner: TComponent);
begin
  inherited;
  Qrymaintablename  := CommonDbLib.GetUserTemporaryTableName('StocknSale');
end;

procedure TReportSqlProductStocknSalePeriod.CreateTempPLPeriodTable;
var
  cmd :TERPCommand;
  s1,s2:String;
  ctr:Integer;
  Function PeriodDesc(periodno :Integer):String;
  begin
         if Periodtype =ptYear  then result := 'YEAR(DATE_ADD( ' + quotedstr(formatdatetime(mysqldateTimeformat , datefrom))+',INTERVAL '+ inttostr(Periodno-1)+' YEAR) )'
    else if Periodtype =ptMonth then result := 'concat(DATE_FORMAT((DATE_ADD( ' + quotedstr(formatdatetime(mysqldateTimeformat , datefrom))+',INTERVAL '+ inttostr(Periodno-1)+'  MONTH) ), "%b"), "-" ,'+
                                                       ' year(DATE_ADD( ' + quotedstr(formatdatetime(mysqldateTimeformat , datefrom))+',INTERVAL '+ inttostr(Periodno-1)+'  MONTH) ))'
    else result := 'concat(DATE_FORMAT(DATE_ADD( ' + quotedstr(formatdatetime(mysqldateTimeformat , datefrom))+',INTERVAL '+ inttostr((Periodno-1)*3)+'  MONTH) , "%b"), "-" ,'+
                         ' DATE_FORMAT(DATE_ADD(DATE_ADD( ' + quotedstr(formatdatetime(mysqldateTimeformat , datefrom))+',INTERVAL '+ inttostr((Periodno)*3)+'  MONTH),INTERVAL 1 DAY) , "%b"), "-" ,'+
                         ' year(DATE_ADD( ' + quotedstr(formatdatetime(mysqldateTimeformat , datefrom))+',INTERVAL '+ inttostr((Periodno-1)*3)+' MONTH) ))';


  end;
begin
  inherited;
  cmd := DbSharedObj.Getcommand(commondblib.GetSharedMyDacConnection);
  try
    cmd.SQL.clear;
    cmd.SQL.AdD('Drop table if exists ' +Qrymaintablename+';');
    cmd.SQL.AdD('Drop table if exists ' +Qrymaintablename+'_CH;');
    s1:= 'Create table  ' +Qrymaintablename+'('+
                               ' ID INT NOT NULL AUTO_INCREMENT, '+
                               ' ProductId INT NULL DEFAULT NULL,'+
                               ' Productname varchar(255) NULL DEFAULT NULL,';
    s2:= 'Create table  ' +Qrymaintablename+'_CH ('+
                               ' ID INT NOT NULL AUTO_INCREMENT, PeriodType VARCHAR(25) NULL DEFAULT NULL, ';

    for ctr := 1 to Periodcount do begin
       s1:= s1 + Fieldname('SalesShipQty' ,ctr)+' DOUBLE NULL DEFAULT NULL,'+
                 Fieldname('SalesBOQty'   ,ctr)+' DOUBLE NULL DEFAULT NULL,'+
                 Fieldname('SalesPrice'   ,ctr)+' DOUBLE NULL DEFAULT NULL,'+
                 Fieldname('SalesBOPrice'   ,ctr)+' DOUBLE NULL DEFAULT NULL,'+
                 Fieldname('SalesCost'   ,ctr)+' DOUBLE NULL DEFAULT NULL,'+
                 Fieldname('SalesBOCost'   ,ctr)+' DOUBLE NULL DEFAULT NULL,'+
                 Fieldname('StockQty'     ,ctr)+' DOUBLE NULL DEFAULT NULL,'+
                 Fieldname('StockCost'    ,ctr)+' DOUBLE NULL DEFAULT NULL,';
       s2:= s2 + Fieldname('TypeDesc'     ,ctr)+' VARCHAR(25) NULL DEFAULT NULL,'+
                 Fieldname('Datefrom'     ,ctr)+' DateTime NULL DEFAULT NULL,'+
                 Fieldname('DateTo'     ,ctr)+' DateTime NULL DEFAULT NULL,'     ;
    end;
    s1:= s1 +' PRIMARY KEY (ID)) COLLATE="utf8_general_ci";';
    s2:= s2 +' PRIMARY KEY (ID)) COLLATE="utf8_general_ci";';
    cmd.SQL.AdD(s1);
    cmd.SQL.AdD(s2);
    //
      s1 :='';
    for ctr := 1 to Periodcount do begin
        if s1 <> '' then s1 := s1 +',';
        s1 := s1 + Fieldname('TypeDesc'         ,ctr)+' = '+ PeriodDesc(ctr)+',';
        s1 := s1 + Fieldname('datefrom'         ,ctr)+' = '+ quotedstr(FormatDatetime(MySQLDateTimeformat , PeriodDateFrom(ctr)))+',';
        s1 := s1 + Fieldname('Dateto'           ,ctr)+' = '+ quotedstr(FormatDatetime(MySQLDateTimeformat , PeriodDateTo(ctr)));
    end;
    if s1<> '' then cmd.SQL.AdD('insert ignore into  ' +Qrymaintablename+'_CH Set  PeriodType = '+ quotedstr(iif(Periodtype=ptYear, 'Year',iif(Periodtype=ptMonth, 'Month','Quarter')))+','+s1+';');
    cmd.SQL.add('insert ignore into  '+ Qrymaintablename+' (ProductID) '+
                  ' Select distinct ProductId from tblpqa '+
                  ' where Transdate between ' + quotedstr(formatdatetime(mysqldateTimeformat, dateFrom))+
                  ' and  ' + quotedstr(formatdatetime(mysqldateTimeformat, dateto))+
                  ' and transtype in (' + SalesTransTypes +');');

    cmd.Execute;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;

end;

destructor TReportSqlProductStocknSalePeriod.Destroy;
begin
  if Qrymaintablename <> '' then begin
    TempTableUtils.DestroyUserTemporaryTable(GetSharedMyDacConnection,  Qrymaintablename);
    TempTableUtils.DestroyUserTemporaryTable(GetSharedMyDacConnection,  Qrymaintablename+'_CH');
    TempTableUtils.DestroyUserTemporaryTable(GetSharedMyDacConnection,  Qrymaintablename+'_1');
  end;
  inherited;
end;

procedure TReportSqlProductStocknSalePeriod.AddDataToTempPLPeriodTable;
var
  ctr:Integer;
  cmd :TERPCommand;
begin
  inherited;
  cmd := DbSharedObj.Getcommand(commondblib.GetSharedMyDacConnection);
  try
    for ctr := 1 to Periodcount do begin
        cmd.SQL.add('Drop table if exists '+  Qrymaintablename+'_1;');
        cmd.SQL.add('Create table  '+  Qrymaintablename+'_1 Select pqa.productId, ' +

                                                                  SQL4Qty(tTotSalesExBo) +' as   SalesQty , ' +   NL+
                                                                  SQL4Qty(tInvBO)+'+'+ SQL4Qty(tSOBO) +' as   BOQty , ' +NL+

                                                                  SQL4Qty(tTotSalesExBo , 'PQA', 'PQA.qty*SL.linepriceinc') +' as   SalesQtyPrice , ' +NL+
                                                                  SQL4Qty(tInvBO, 'PQA', 'PQA.qty*SL.linepriceinc')+'+'+ SQL4Qty(tSOBO) +' as   BOQtyPrice , ' +NL+

                                                                  SQL4Qty(tTotSalesExBo , 'PQA', 'PQA.qty*SL.lineCostinc') +' as   SalesQtyCost , ' +NL+
                                                                  SQL4Qty(tInvBO, 'PQA', 'PQA.qty*SL.lineCostinc')+'+'+ SQL4Qty(tSOBO) +' as   BOQtyCost ' +NL+

                                                                ' from tblpqa pqa inner join tblsaleslines sl on sl.salelineId = pqa.translineId and pqa.transtype in (' + SalesTransTypes +')'+
                                                                ' where pqa.transdate between ' + quotedstr(formatdatetime(mysqldateTimeformat, PeriodDateFrom(ctr)))+' and  ' + quotedstr(formatdatetime(mysqldateTimeformat, PeriodDateto(ctr)))+
                                                                ' Group by pqa.productId;');
        cmd.SQL.add('update '+  Qrymaintablename+' T inner join '+  Qrymaintablename+'_1 T1 on T.productId = t1.productID set T.'+fieldname('SalesShipQty'  ,ctr)+'= T1.SalesQty, ' +
                                                                                                                            ' T.'+fieldname('SalesBOQty'    ,ctr)+'= T1.BOQty, ' +
                                                                                                                            ' T.'+Fieldname('SalesPrice'    ,ctr)+'= T1.SalesQtyPrice, ' +
                                                                                                                            ' T.'+Fieldname('SalesBOPrice'  ,ctr)+'= T1.BOQtyPrice, ' +
                                                                                                                            ' T.'+Fieldname('SalesCost'     ,ctr)+'= T1.SalesQtyCost, ' +
                                                                                                                            ' T.'+Fieldname('SalesBOCost'   ,ctr)+'= T1.BOQtyCost;' );
        cmd.SQL.add('Drop table if exists '+  Qrymaintablename+'_1;');
        cmd.SQL.add('Create table  '+  Qrymaintablename+'_1 Select pqa.productId, ' +
                                                                  SQL4Qty(tInStock) +' as   instockqty , ' +NL+
                                                                  SQL4Qty(tInStock) +'* If(P.AvgCost=0.00,Cost1,P.AvgCost) as    instockqtyCost  ' +NL+
                                                                ' from tblpqa pqa inner join tblparts p on p.partsId = pqa.productId'+
                                                                ' where pqa.transdate between ' + quotedstr(formatdatetime(mysqldateTimeformat, PeriodDateFrom(ctr)))+' and  ' + quotedstr(formatdatetime(mysqldateTimeformat, PeriodDateto(ctr)))+
                                                                ' Group by pqa.productId;');
        cmd.SQL.add('update '+  Qrymaintablename+' T inner join '+  Qrymaintablename+'_1 T1 on T.productId = t1.productID set T.'+fieldname('StockQty'  ,ctr)+'= T1.instockqty, ' +
                                                                                                                            ' T.'+Fieldname('StockCost'   ,ctr)+'= T1.instockqtyCost;' );

        cmd.SQL.add('Drop table if exists '+  Qrymaintablename+'_1;');
    end;
    cmd.SQL.add('update ' + Qrymaintablename +' T inner join tblparts P on T.productId = P.PartsId Set T.Productname = P.partname;');
    cmd.Execute;
  finally
    DbSharedObj.ReleaseObj(cmd);
  end;

end;

function TReportSqlProductStocknSalePeriod.PrepareForReport: Boolean;
begin
    CreateTempPLPeriodTable;
    AddDataToTempPLPeriodTable;
    Result := True;
end;

end.
