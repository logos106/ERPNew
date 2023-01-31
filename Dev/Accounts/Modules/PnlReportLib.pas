unit PnlReportLib;

interface

function  PnlTransSQL(fsTablename:String; isEmployee :Boolean; includePO, includeBill,
  includeCredit, includecheque, includeinvoice,includeVoucher,  includeSO, includeCashSale,
  includePOS, includeRefund, includeLayby, includeJE:Boolean; DateFrom , Dateto: TDatetime;
  DepartmentList: string = ''): String;

implementation

uses sysutils, MySQLUtils, tcConst, CommonLib, MySQLConst;

function  PnlTransSQL(fsTablename:String; isEmployee :Boolean; includePO, includeBill,
  includeCredit, includecheque, includeinvoice,includeVoucher,  includeSO, includeCashSale,
  includePOS, includeRefund, includeLayby, includeJE:Boolean; DateFrom, Dateto:TDatetime;
  DepartmentList: string = ''): String;

  Function FormatDateField(const FieldName:String):String;  begin     result:= 'DATE_FORMAT('       + Fieldname +', ' + Quotedstr(MYSQLShorDateFormat) +')';  end;
  function WeekNo(const fieldName:String)         :String;  begin     REsult:= 'concat(year('       + fieldname +'),"-" , WEEKOFYEAR(' +fieldname +'))';  end;
  function MonthNo(const fieldName:String)        :String;  begin     REsult:= 'concat(year('       + fieldname +'),"-" , MONTH('      +fieldname +'))';  end;
  function QuarterNo(const fieldName:String)      :String;  begin     REsult:= 'concat(year('       + fieldname +'),"-" , QUARTER('    +fieldname +'))';  end;
  Function Week(Const FieldName:String)           :String;  begin     result:= 'concat(WEEKOFYEAR(' + FieldName +'),"-" , year('       +FieldName +'))';  end;
  function Month(const fieldName:String)          :String;  begin     REsult:= 'concat(Month('      + fieldname +'),"-" , year('       +fieldname +'))';  end;
  function Quarter(const fieldName:String)        :String;  begin     REsult:= 'concat(QUARTER('    + fieldname +'),"-" , year('       +fieldname +'))';  end;
  function CategoryFieldName(const TableAlias:String ='') :String;  begin
    if isEmployee then begin
           if TableAlias ='S' then result := 'S.EmployeeName'
      else if TableAlias ='JL' then result := 'JL.EmployeeName'
      else result := 'POL.EmployeeName';
    end else  if TableAlias='S' then
      result :='S.Area'
    else Result:= 'AreaCode';
  end;
  function Salesfilter:String;
  begin
    REsult:= '';
    if includeinvoice then result := 'S.ISInvoice ="T"';
    if includeSO then begin
      if result <> '' then result := result +' OR ';
      result := result + 'S.IsSalesOrder="T"';
    end;
    if includevoucher then begin
      if result <> '' then result := result +' OR ';
      result := result + 'S.ISvoucher="T"';
    end;
    if includeCashSale then begin
      if result <> '' then result := result +' OR ';
      result := result + 'S.IsCashSAle="T"';
    end;
    if includePOS then begin
      if result <> '' then result := result +' OR ';
      result := result + 'S.isPOS="T"';
    end;
    if includeRefund then begin
      if result <> '' then result := result +' OR ';
      result := result + 'S.IsRefund="T"';
    end;
    if includeLayby then begin
      if result <> '' then result := result +' OR ';
      result := result + 'S.IsLayby="T"';
    end;
    if result = '' then result := '"T"="F"';
    if result <> '' then result := '(' + result +') and ';
    REsult := REsult + ' SL.Invoiced="T" AND S.Deleted ="F"  AND S.IsQuote="F"  AND S.converted = "F" and ';
  end;
  function POFilter  :String;
  begin
    REsult:= '';
    if IncludePO then result := result + 'PO.isPO="T"';

    if includeCredit then begin
      if result <> '' then result := result +' OR ';
      result := result + 'PO.isCredit="T"';
    end;
    if includeBill then begin
      if result <> '' then result := result +' OR ';
      result := result + 'PO.isBill="T"';
    end;
    if includecheque then begin
      if result <> '' then result := result +' OR ';
      result := result + 'PO.ischeque="T"';
    end;
    if result = '' then result := '"T"="F"';
    if result <> '' then result := '(' + result +') and '
  end;

  function POTableSQL:String;
  begin
    Result := 'From tblpurchaseORders PO inner join tblPurchaseLines POL on PO.purchaseOrderID = POL.purchaseOrderID' +
              ' Where  ' + POFilter +'   PO.orderDate between ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, Datefrom)) + ' and ' +  Quotedstr(formatDatetime(MysqlDateTimeFormat, DateTo)) +' ' +
              ' and (ifnull(0-POL.totalLineAmount,0)<> 0 or ifnull(0-POL.lineTax,0) <> 0 or ifnull(0-POL.totalLineAmountinc,0)<>0)';
    if DepartmentList <> '' then
      result := result + ' and (POL.Class in ('+DepartmentList+'))'
  end;

  function SalesTableSQL:String;
  begin
      Result:= 'From tblSales s inner join tblsaleslines SL on S.SAleId = SL.saleID' +
                ' Where    ' + Salesfilter +' S.SaleDate between ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, Datefrom)) + ' and ' +  Quotedstr(formatDatetime(MysqlDateTimeFormat, DateTo)) +'  '+
                ' and (ifnull(SL.totalLineAmount,0)<> 0 or ifnull(SL.lineTax,0) <> 0 or ifnull(SL.totalLineamountinc,0)<>0)';
    if DepartmentList <> '' then
      result := result + ' and (S.Class in ('+DepartmentList+'))'
  end;

  function GEJTableSQL:String;
  begin
    REsult:= 'From tblgeneraljournal J inner join tblgeneraljournaldetails JL on J.GJID = JL.GJID' +
             ' Where   J.TransactionDate between ' + Quotedstr(formatDatetime(MysqlDateTimeFormat, Datefrom)) + ' and ' +  Quotedstr(formatDatetime(MysqlDateTimeFormat, DateTo)) +' ' +
             ' and (ifnull(JL.CreditAmount,0)<> 0 or ifnull(JL.TaxAmount,0) <> 0 or ifnull(JL.DebitAmount,0)<>0)';
    if DepartmentList <> '' then
      result := result + ' and (JL.ClassName in ('+DepartmentList+'))'
  end;

begin
    result:= '';
    result := result +  ' Drop table if Exists ' + fsTablename +';' + #13#10;
    result := result +  ' CREATE TABLE `' + fsTablename +'` (' + #13#10;
    result := result +  ' 	`ID` INT(11) NOT NULL AUTO_INCREMENT,' + #13#10;
    result := result +  ' 	`Details` INT(20) NOT NULL DEFAULT "0",' + #13#10;
    result := result +  ' 	`TransID` INT(11) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`OrderDate` DATETIME NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`Weekno` INT(20) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`monthno` INT(20) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`Quarterno` INT(20) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`yearno` INT(20) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`PeriodID` VARCHAR(30) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`Period` VARCHAR(30) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`Category` VARCHAR(50) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`Department` VARCHAR(255) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`Description` VARCHAR(60) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`AccountID` INT(11) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`AccountName` VARCHAR(100) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`AccountType` VARCHAR(100) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`AccountNo` VARCHAR(100) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`Level1` VARCHAR(255) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`Level2` VARCHAR(255) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`Level3` VARCHAR(255) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`Level4` VARCHAR(255) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`Transtype` VARCHAR(26) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`CostEx` DOUBLE NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`AmountTax` DOUBLE NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`CostInc` DOUBLE NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`PriceEx` DOUBLE NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`PriceInc` DOUBLE NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	`RecInfo` VARCHAR(2000) NULL DEFAULT NULL,' + #13#10;
    result := result +  ' 	PRIMARY KEY (`ID`),' + #13#10;
    result := result +  ' 	INDEX `AccountID` (`AccountID`)' (*+',' + #13#10;
    result := result +  ' 	INDEX `RecInfo` (`RecInfo`)' *)+'' + #13#10;
    result := result +  ' )' + #13#10;
    result := result +  ' COLLATE="utf8_general_ci"' + #13#10;
    result := result +  ' ENGINE=MyISAM;' + #13#10;



    result := result +  ' insert into ' +fstablename +' (Details,TransID,OrderDate,Weekno,monthno,Quarterno,yearno,PeriodID,Period,Category,Department,Description,AccountName,Transtype,CostEx,AmountTax,CostInc,PriceEx,PriceInc)' + #13#10;
    result := result +  ' Select ' + #13#10;
    result := result +  ' 1                                               as Details,' + #13#10;
    result := result +  ' PO.PurchaseOrderID                              as TransID,' + #13#10;
    result := result +  ' convert(PO.orderDate , dateTime)                as OrderDate,' + #13#10;
    result := result +  ' convert(WEEKOFYEAR(PO.orderDate) , signed)      as Weekno,' + #13#10;
    result := result +  ' convert(Month(PO.orderDate)      , signed)      as monthno,' + #13#10;
    result := result +  ' convert(Quarter(PO.orderDate)    , signed)      as Quarterno,' + #13#10;
    result := result +  ' convert(year(PO.orderDate)       , signed)      as yearno,' + #13#10;
    result := result +  ' PO.orderDate                                    as PeriodID,' + #13#10;
    result := result +  '  ' + FormatDateField('PO.orderDate')+'                as Period,' + #13#10;
    result := result +  ' ' + CategoryFieldName +'                        as Category,' + #13#10;
    result := result +  ' POL.Class                                       as Department,' + #13#10;
    result := result +  ' if(PO.isPO="T" , POL.productName, null)         as Description ,' + #13#10;
    result := result +  ' POL.accountname                                 as AccountName,' + #13#10;
    result := result +  ' ' + Transtype('PO',False) +'                    as Transtype,' + #13#10;
    result := result +  ' (0-POL.totalLineAmount)                         as CostEx,' + #13#10;
    result := result +  ' (0-POL.lineTax)                                 as AmountTax,' + #13#10;
    result := result +  ' (0-POL.totalLineAmountinc)                      as CostInc,' + #13#10;
    result := result +  ' 0                                               as PriceEx,' + #13#10;
    result := result +  ' 0                                               as PriceInc' + #13#10;
    result := result +  '  ' + POTableSQL + #13#10;

    result := result +  ' union all' + #13#10;
    result := result +  ' Select ' + #13#10;
    result := result +  ' 1                                              as Details,' + #13#10;
    result := result +  ' S.SaleID                                       as TransID,' + #13#10;
    result := result +  ' convert(S.SaleDate , dateTime)                 as OrderDate,' + #13#10;
    result := result +  ' convert(WEEKOFYEAR(S.SaleDate) , signed)       as Weekno,' + #13#10;
    result := result +  ' convert(Month(S.SaleDate)      , signed)       as monthno,' + #13#10;
    result := result +  ' convert(Quarter(S.SaleDate)    , signed)       as Quarterno,' + #13#10;
    result := result +  ' convert(year(S.SaleDate)       , signed)       as yearno,' + #13#10;
    result := result +  ' S.SaleDate                                     as PeriodID,' + #13#10;
    result := result +  '  ' + FormatDateField('S.SaleDate')+'                 as Period,' + #13#10;
    result := result +  ' ' + CategoryFieldName('S') +'                  as Category,' + #13#10;
    result := result +  ' S.Class                                        as Department,' + #13#10;
    result := result +  ' SL.productName                                 as Description ,' + #13#10;
    result := result +  ' S.Account                                      as AccountName,' + #13#10;
    result := result +  ' ' + Transtype('S',True) +'                     as Transtype,' + #13#10;
    result := result +  ' (SL.LineCost * SL.Shipped)                     as CostEx,' + #13#10;
    result := result +  ' (SL.lineTax)                                   as AmountTax,' + #13#10;
    result := result +  ' (SL.LineCostInc * SL.Shipped)                  as CostInc,' + #13#10;
    result := result +  ' (Sl.TotalLineamount)                           as PriceEx,' + #13#10;
    result := result +  ' (Sl.TotalLineamountInc)                        as PriceInc' + #13#10;
    result := result +  '  ' + SalesTableSQL + #13#10;
    if includeJE then begin
      result := result +  ' union all' + #13#10;
      result := result +  ' Select' + #13#10;
      result := result +  ' 1                                                as Details,' + #13#10;
      result := result +  ' J.GJID                                           as TransID,' + #13#10;
      result := result +  ' convert(J.TransactionDate , dateTime)            as OrderDate,' + #13#10;
      result := result +  ' convert(WEEKOFYEAR(J.TransactionDate ), signed)  as Weekno,' + #13#10;
      result := result +  ' convert(Month(J.TransactionDate)      , signed)  as monthno,' + #13#10;
      result := result +  ' convert(Quarter(J.TransactionDate)    , signed)  as Quarterno,' + #13#10;
      result := result +  ' convert(year(J.TransactionDate)       , signed)  as yearno,' + #13#10;
      result := result +  ' J.TransactionDate                                as PeriodID,' + #13#10;
      result := result +  '  ' + FormatDateField('J.TransactionDate')+'            as Period,' + #13#10;
      result := result +  ' ' + CategoryFieldName('JL') +'                   as Category,' + #13#10;
      result := result +  ' JL.ClassName                                     as Department,' + #13#10;
      result := result +  ' NULL                                             as Description,' + #13#10;
      result := result +  ' JL.AccountName                                   as AccountName,' + #13#10;
      result := result +  ' "Journal Entry"                                  as TransType,' + #13#10;
      result := result +  ' if(J.TaxSelect="INPUT" , (JL.CreditAmount - JL.DebitAmount ) , 0)        as CostEx,' + #13#10;
      result := result +  ' if(J.TaxSelect="INPUT" , 0-JL.TaxAmount , JL.TaxAmount)                  as AmountTax,' + #13#10;
      result := result +  ' if(J.TaxSelect="INPUT" , (JL.CreditAmountinc - JL.DebitAmountinc ) , 0)  as CostInc, ' + #13#10;
      result := result +  ' if(J.TaxSelect="INPUT" , 0 , (JL.DebitAmount-JL.CreditAmount ))          as PriceEx,' + #13#10;
      result := result +  ' if(J.TaxSelect="INPUT" , 0 , (JL.DebitAmountinc -JL.CreditAmountinc ))   as PriceInc' + #13#10;
      result := result +  '  ' + GEJTableSQL + #13#10;
    end;

    result := result +  ' union all';
    result := result +  ' Select ';
    result := result +  ' 2                                                as Details,';
    result := result +  ' NULL                                             as TransID,';
    result := result +  ' convert(PO.orderDate , dateTime)                 as OrderDate,';
    result := result +  ' convert(WEEKOFYEAR(PO.orderDate) , signed)       as Weekno,';
    result := result +  ' convert(Month(PO.orderDate)      , signed)       as monthno,';
    result := result +  ' convert(Quarter(PO.orderDate)    , signed)       as Quarterno,';
    result := result +  ' convert(year(PO.orderDate)       , signed)       as yearno,';
    result := result +  ' PO.orderDate                                     as PeriodID,';
    result := result +  '  ' + FormatDateField('PO.orderDate')+'                 as Period,';
    result := result +  ' ' + CategoryFieldName +'                         as Category,';
    if DepartmentList = '' then
      result := result +  ' NULL                                             as Department,'
    else
      result := result +  ' POL.Class                                      as Department,';
    result := result +  ' if(PO.isPO="T" , POL.productName, null)          as Description ,';
    result := result +  ' POL.accountname                                  as AccountName,';
    result := result +  ' ' + Transtype('PO',False) +'                     as Transtype,';
    result := result +  ' sum(0-POL.totalLineAmount)                       as CostEx,';
    result := result +  ' Sum(0-POL.lineTax)                               as AmountTax,';
    result := result +  ' Sum(0-POL.totalLineAmountinc)                    as CostInc,';
    result := result +  ' (0)                                              as PriceEx,';
    result := result +  ' (0)                                              as PriceInc';
    result := result +  '  ' + POTableSQL;
    result := result +  ' group by PO.OrderDate, ' + CategoryFieldName;
    if DepartmentList <> '' then
      result := result + ', POL.Class';
    result := result +  ', AccountName , '+
                    'if(PO.isPO="T" , POL.productName, null),  '+
                    '' + Transtype('PO',False) ;


    result := result +  ' union all';
    result := result +  ' Select ';
    result := result +  ' 2                                                as Details,';
    result := result +  ' NULL                                             as TransID,';
    result := result +  ' convert(S.SaleDate , dateTime)                   as OrderDate,';
    result := result +  ' convert(WEEKOFYEAR(S.SaleDate) , signed)         as Weekno,';
    result := result +  ' convert(Month(S.SaleDate)      , signed)         as monthno,';
    result := result +  ' convert(Quarter(S.SaleDate)    , signed)         as Quarterno,';
    result := result +  ' convert(year(S.SaleDate)       , signed)         as yearno,';
    result := result +  ' S.SaleDate                                       as PeriodID,';
    result := result +  '  ' + FormatDateField('S.SaleDate')+'                   as Period,';
    result := result +  ' ' + CategoryFieldName('S') +'                    as Category,';
    if DepartmentList = '' then
      result := result +  ' NULL                                             as Department,'
    else
      result := result +  ' S.Class                                          as Department,';
    result := result +  ' SL.productName                                   as Description ,';
    result := result +  ' S.Account                                        as AccountName,';
    result := result +  ' ' + Transtype('S',True) +'                       as Transtype,';
    result := result +  ' sum(SL.LineCost * SL.Shipped)                    as CostEx,';
    result := result +  ' sum(SL.lineTax)                                  as AmountTax,';
    result := result +  ' sum(SL.LineCostInc * SL.Shipped)                 as CostInc,';
    result := result +  ' Sum(Sl.TotalLineamount)                          as PriceEx,';
    result := result +  ' Sum(Sl.TotalLineamountInc)                       as PriceInc';
    result := result +  '  ' + SalesTableSQL;
    result := result +  ' group by S.SaleDate, ' + CategoryFieldName('S');
    if DepartmentList <> '' then
      result := result + ', S.Class';
    result := result +  ', S.Account , '+
                    'SL.ProductName,  '+
                    '' + Transtype('S',True) +' ';
    if includeJE then begin
      result := result +  ' union all';
      result := result +  ' Select';
      result := result +  ' 2                                                as Details,';
      result := result +  ' NULL                                             as TransID,';
      result := result +  ' convert(J.TransactionDate , dateTime)            as OrderDate,';
      result := result +  ' convert(WEEKOFYEAR(J.TransactionDate ), signed)  as Weekno,';
      result := result +  ' convert(Month(J.TransactionDate)      , signed)  as monthno,';
      result := result +  ' convert(Quarter(J.TransactionDate)    , signed)  as Quarterno,';
      result := result +  ' convert(year(J.TransactionDate)       , signed)  as yearno,';
      result := result +  ' J.TransactionDate                                as PeriodID,';
      result := result +  '  ' + FormatDateField('J.TransactionDate')+'            as Period,';
      result := result +  ' ' + CategoryFieldName('JL') +'                   as Category,';
      if DepartmentList = '' then
        result := result +  ' NULL                                             as Department,'
      else
        result := result +  ' JL.ClassName                                     as Department,';
      result := result +  ' NULL                                             as Description,';
      result := result +  ' JL.AccountName                                   as AccountName,';
      result := result +  ' "Journal Entry"                                  as Transtype,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , (JL.CreditAmount - JL.DebitAmount ) , 0))        as CostEx,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0-JL.TaxAmount , JL.TaxAmount))                  as AmountTax,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , (JL.CreditAmountinc - JL.DebitAmountinc ) , 0))  as CostInc, ';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0 , (JL.DebitAmount-JL.CreditAmount )))          as PriceEx,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0 , (JL.DebitAmountinc -JL.CreditAmountinc )))   as PriceInc';
      result := result +  '  ' + GEJTableSQL;
      result := result +  ' group by J.TransactionDate, ' + CategoryFieldName('JL');
      if DepartmentList <> '' then
        result := result + ', JL.ClassName';
      result := result +  ', AccountName, J.GJID  ';
    end;

    result := result +  ' union all';
    result := result +  ' Select';
    result := result +  ' 3                                                as details,';
    result := result +  ' Null                                             as TransID,';
    result := result +  ' convert(NULL , dateTime)                         as OrderDate,';
    result := result +  ' convert(WEEKOFYEAR(PO.orderDate) , signed)       as Weekno,';
    result := result +  ' convert(Month(PO.orderDate)      , signed)       as monthno,';
    result := result +  ' convert(Quarter(PO.orderDate)    , signed)       as Quarterno,';
    result := result +  ' convert(year(PO.orderDate)       , signed)       as yearno,';
    result := result +  '  ' + Weekno('PO.OrderDate')+'                          as PeriodID,';
    result := result +  '  ' + Week('PO.OrderDate')+'                            as Period,';
    result := result +  ' ' + CategoryFieldName +'                         as Category, ';
    if DepartmentList = '' then
      result := result +  ' NULL                                             as Department,'
    else
      result := result +  ' POL.Class                                        as Department,';
    result := result +  ' if(PO.isPO="T" , POL.productName, null)          as Description ,  ';
    result := result +  ' POL.accountname                                  as AccountName,';
    result := result +  ' ' + Transtype('PO',False) +'                     as Transtype,';
    result := result +  ' sum(0-POL.totalLineAmount)                       as CostEx,';
    result := result +  ' Sum(0-POL.lineTax)                               as AmountTax,';
    result := result +  ' Sum(0-POL.totalLineAmountinc)                    as CostInc,';
    result := result +  ' (0)                                              as PriceEx,';
    result := result +  ' (0)                                              as PriceInc';
    result := result +  '  ' + POTableSQL;
    result := result +  ' group by year(PO.orderdate),WEEKOFYEAR(PO.orderdate), ' + CategoryFieldName;
    if DepartmentList <> '' then
      result := result + ', POL.Class';
    result := result +  ',AccountName ,  '+
                    'if(PO.isPO="T" , POL.productName, null),  '+
                    '' + Transtype('PO',False) +' ' ;

    result := result +  ' union all';
    result := result +  ' Select ';
    result := result +  ' 3                                             as Details,';
    result := result +  ' NULL                                          as TransID,';
    result := result +  ' convert(NULL, dateTime)                       as OrderDate,';
    result := result +  ' convert(WEEKOFYEAR(S.SaleDate) , signed)      as Weekno,';
    result := result +  ' convert(Month(S.SaleDate)      , signed)      as monthno,';
    result := result +  ' convert(Quarter(S.SaleDate)    , signed)      as Quarterno,';
    result := result +  ' convert(year(S.SaleDate)       , signed)      as yearno,';
    result := result +  '  ' + Weekno('S.SaleDate')+'                         as PeriodID,';
    result := result +  '  ' + Week('S.SaleDate')+'                           as Period,';
    result := result +  ' ' + CategoryFieldName('S') +'                 as Category,';
    if DepartmentList = '' then
      result := result +  ' NULL                                             as Department,'
    else
      result := result +  ' S.Class                                       as Department,';
    result := result +  ' SL.productName                                as Description ,';
    result := result +  ' S.Account                                     as AccountName,';
    result := result +  ' ' + Transtype('S',True) +'                    as Transtype,';
    result := result +  ' sum(SL.LineCost * SL.Shipped)                 as CostEx,';
    result := result +  ' sum(SL.lineTax)                               as AmountTax,';
    result := result +  ' sum(SL.LineCostInc * SL.Shipped)              as CostInc,';
    result := result +  ' Sum(Sl.TotalLineamount)                       as PriceEx,';
    result := result +  ' Sum(Sl.TotalLineamountInc)                    as PriceInc';
    result := result +  '  ' + SalesTableSQL;
    result := result +  ' group by year(S.SaleDate),WEEKOFYEAR(S.SaleDate), ' + CategoryFieldName('S');
    if DepartmentList <> '' then
      result := result + ', S.Class';
    result := result +  ',S.Account ,  '+
                    'SL.productName,  '+
                    '' + Transtype('S',True) +' ' ;
    if includeJE then begin
      result := result +  ' union all';
      result := result +  ' Select';
      result := result +  ' 3                                                as details ,';
      result := result +  ' Null                                             as TransID,';
      result := result +  ' convert(NULL , dateTime)                         as OrderDate,';
      result := result +  ' convert(WEEKOFYEAR(J.TransactionDate ), signed)  as Weekno,';
      result := result +  ' convert(Month(J.TransactionDate)      , signed)  as monthno,';
      result := result +  ' convert(Quarter(J.TransactionDate)    , signed)  as Quarterno,';
      result := result +  ' convert(year(J.TransactionDate)       , signed)  as yearno,';
      result := result +  '  ' + Weekno('J.TransactionDate')+'                     as PeriodID,';
      result := result +  '  ' + Week('J.TransactionDate')+'                       as Period,';
      result := result +  ' ' + CategoryFieldName('JL') +'                   as Category,';
      if DepartmentList = '' then
        result := result +  ' NULL                                             as Department,'
      else
        result := result +  ' JL.ClassName                                     as Department,';
      result := result +  ' NULL                                             as Description,';
      result := result +  ' JL.AccountName                                   as AccountName,';
      result := result +  ' "Journal Entry"                                  as TransType,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , (JL.CreditAmount - JL.DebitAmount ) , 0))        as CostEx,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0-JL.TaxAmount , JL.TaxAmount))                  as AmountTax,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , (JL.CreditAmountinc - JL.DebitAmountinc ) , 0))  as CostInc, ';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0 , (JL.DebitAmount-JL.CreditAmount )))          as PriceEx,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0 , (JL.DebitAmountinc -JL.CreditAmountinc )))   as PriceInc';
      result := result +  '  ' + GEJTableSQL;
      result := result +  ' group by year(J.TransactionDate),WEEKOFYEAR(J.TransactionDate) , ' + CategoryFieldName('JL');
      if DepartmentList <> '' then
        result := result + ', JL.ClassName';
      result := result +  ' ,AccountName ';
    end;

    result := result +  ' union all';
    result := result +  ' Select';
    result := result +  ' 4                                                as details,';
    result := result +  ' Null                                             as TransID,';
    result := result +  ' convert(NULL , dateTime)                         as OrderDate,';
    result := result +  ' convert(NULL                     , signed)       as Weekno,';
    result := result +  ' convert(Month(PO.orderDate)      , signed)       as monthno,';
    result := result +  ' convert(Quarter(PO.orderDate)    , signed)       as Quarterno,';
    result := result +  ' convert(year(PO.orderDate)       , signed)       as yearno,';
    result := result +  '  ' + Monthno('PO.orderdate')+'                         as PeriodID,';
    result := result +  '  ' + Month('PO.orderdate')+'                           as Period,';
    result := result +  ' ' + CategoryFieldName +'                         as Category, ';
    if DepartmentList = '' then
      result := result +  ' NULL                                             as Department,'
    else
      result := result +  ' POL.Class                                        as Department,';
    result := result +  ' if(PO.isPO="T" , POL.productName, null)          as Description ,  ';
    result := result +  ' POL.accountname                                  as AccountName,';
    result := result +  ' ' + Transtype('PO',False) +'                     as Transtype,';
    result := result +  ' sum(0-POL.totalLineAmount)                       as CostEx,';
    result := result +  ' Sum(0-POL.lineTax)                               as AmountTax,';
    result := result +  ' Sum(0-POL.totalLineAmountinc)                    as CostInc,';
    result := result +  ' (0)                                              as PriceEx,';
    result := result +  ' (0)                                              as PriceInc';
    result := result +  '  ' + POTableSQL;
    result := result +  ' group by year(PO.orderdate),month(PO.orderdate), ' + CategoryFieldName;
    if DepartmentList <> '' then
      result := result + ', POL.Class';
    result := result +  ',AccountName ,  '+
                    'if(PO.isPO="T" , POL.productName, null),  '+
                    '' + Transtype('PO',False) +' ' ;

    result := result +  ' union all';
    result := result +  ' Select ';
    result := result +  ' 4                                              as Details,';
    result := result +  ' NULL                                           as TransID,';
    result := result +  ' convert(NULL, dateTime)                        as OrderDate,';
    result := result +  ' convert(NULL , signed)                         as Weekno,';
    result := result +  ' convert(Month(S.SaleDate)      , signed)       as monthno,';
    result := result +  ' convert(Quarter(S.SaleDate)    , signed)       as Quarterno,';
    result := result +  ' convert(year(S.SaleDate)       , signed)       as yearno,';
    result := result +  '  ' + Monthno('S.SaleDate')+'                         as PeriodID,';
    result := result +  '  ' + Month('S.SaleDate')+'                           as Period,';
    result := result +  ' ' + CategoryFieldName('S') +'                  as Category,';
    if DepartmentList = '' then
      result := result +  ' NULL                                             as Department,'
    else
      result := result +  ' S.Class                                        as Department,';
    result := result +  ' SL.productName                                 as Description ,';
    result := result +  ' S.Account                                      as AccountName,';
    result := result +  ' ' + Transtype('S',True) +'                     as Transtype,';
    result := result +  ' sum(SL.LineCost * SL.Shipped)                  as CostEx,';
    result := result +  ' sum(SL.lineTax)                                as AmountTax,';
    result := result +  ' sum(SL.LineCostInc * SL.Shipped)               as CostInc,';
    result := result +  ' Sum(Sl.TotalLineamount)                        as PriceEx,';
    result := result +  ' Sum(Sl.TotalLineamountInc)                     as PriceInc';
    result := result +  '  ' + SalesTableSQL;
    result := result +  ' group by year(S.SaleDate),month(S.SaleDate), ' + CategoryFieldName('S');
    if DepartmentList <> '' then
      result := result + ', S.Class';
    result := result +  ',AccountName ,  '+
                    'SL.productName,  '+
                    '' + Transtype('S',True) +' ' ;

    if includeJE then begin
      result := result +  ' union all';
      result := result +  ' Select';
      result := result +  ' 4                                                as details ,';
      result := result +  ' Null                                             as TransID,';
      result := result +  ' convert(NULL , dateTime)                         as OrderDate,';
      result := result +  ' convert(NULL                          , signed)  as Weekno,';
      result := result +  ' convert(Month(J.TransactionDate)      , signed)  as monthno,';
      result := result +  ' convert(Quarter(J.TransactionDate)    , signed)  as Quarterno,';
      result := result +  ' convert(year(J.TransactionDate)       , signed)  as yearno,';
      result := result +  '  ' + Monthno('J.TransactionDate')+'                    as PeriodID,';
      result := result +  '  ' + Month('J.TransactionDate')+'                      as Period,';
      result := result +  ' ' + CategoryFieldName('JL') +'                   as Category,';
      if DepartmentList = '' then
        result := result +  ' NULL                                             as Department,'
      else
        result := result +  ' JL.ClassName                                     as Department,';
      result := result +  ' NULL                                             as Description,';
      result := result +  ' JL.AccountName                                   as AccountName,';
      result := result +  ' "Journal Entry"                                  as TransType,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , (JL.CreditAmount - JL.DebitAmount ) , 0))        as CostEx,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0-JL.TaxAmount , JL.TaxAmount))                  as AmountTax,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , (JL.CreditAmountinc - JL.DebitAmountinc ) , 0))  as CostInc, ';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0 , (JL.DebitAmount-JL.CreditAmount )))          as PriceEx,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0 , (JL.DebitAmountinc -JL.CreditAmountinc )))   as PriceInc';
      result := result +  '  ' + GEJTableSQL;
      result := result +  ' group by year(J.TransactionDate), month(J.TransactionDate) , ' + CategoryFieldName('JL');
      if DepartmentList <> '' then
        result := result + ', JL.ClassName';
      result := result +  ' ,AccountName ';
    end;

    result := result +  ' union all';
    result := result +  ' Select';
    result := result +  ' 5                                                as Details, ';
    result := result +  ' Null                                             as TransID,';
    result := result +  ' convert(NULL , dateTime)                         as OrderDate,';
    result := result +  ' convert(NULL                     , signed)       as Weekno,';
    result := result +  ' convert(NULL                     , signed)       as monthno,';
    result := result +  ' convert(Quarter(PO.orderDate)    , signed)       as Quarterno,';
    result := result +  ' convert(year(PO.orderDate)       , signed)       as yearno,';
    result := result +  '  ' + QuarterNo('PO.orderdate')+'                       as PeriodID,';
    result := result +  '  ' + Quarter('PO.orderdate')+'                         as Period ,';
    result := result +  ' ' + CategoryFieldName +'                         as Category, ';
    if DepartmentList = '' then
      result := result +  ' NULL                                             as Department,'
    else
      result := result +  ' POL.Class                                        as Department,';
    result := result +  ' if(PO.isPO="T" , POL.productName, null)          as Description ,  ';
    result := result +  ' POL.accountname                                  as AccountName,';
    result := result +  ' ' + Transtype('PO',False) +'                     as Transtype,';
    result := result +  ' sum(0-POL.totalLineAmount)                       as CostEx,';
    result := result +  ' Sum(0-POL.lineTax)                               as AmountTax,';
    result := result +  ' Sum(0-POL.totalLineAmountinc)                    as CostInc,';
    result := result +  ' (0)                                              as PriceEx,';
    result := result +  ' (0)                                              as PriceInc';
    result := result +  '  ' + POTableSQL;
    result := result +  ' group by year(PO.orderdate) , QUARTER(PO.orderdate), ' + CategoryFieldName;
    if DepartmentList <> '' then
      result := result + ', POL.Class';
    result := result +  ' , Accountname,  '+
                    'if(PO.isPO="T" , POL.productName, null), '+
                    '' + Transtype('PO',False) +' ' ;

    result := result +  ' union all';
    result := result +  ' Select ';
    result := result +  ' 5                                              as Details,';
    result := result +  ' NULL                                           as TransID,';
    result := result +  ' convert(NULL, dateTime)                        as OrderDate,';
    result := result +  ' convert(NULL , signed)                         as Weekno,';
    result := result +  ' convert(NULL      , signed)                    as monthno,';
    result := result +  ' convert(Quarter(S.SaleDate)    , signed)       as Quarterno,';
    result := result +  ' convert(year(S.SaleDate)       , signed)       as yearno,';
    result := result +  '  ' + QuarterNo('S.SaleDate')+'                       as PeriodID,';
    result := result +  '  ' + Quarter('S.SaleDate')+'                         as Period,';
    result := result +  ' ' + CategoryFieldName('S') +'                  as Category,';
    if DepartmentList = '' then
      result := result +  ' NULL                                             as Department,'
    else
      result := result +  ' S.Class                                        as Department,';
    result := result +  ' SL.productName                                 as Description ,';
    result := result +  ' S.Account                                      as AccountName,';
    result := result +  ' ' + Transtype('S',True) +'                     as Transtype,';
    result := result +  ' sum(SL.LineCost * SL.Shipped)                  as CostEx,';
    result := result +  ' sum(SL.lineTax)                                as AmountTax,';
    result := result +  ' sum(SL.LineCostInc * SL.Shipped)               as CostInc,';
    result := result +  ' Sum(Sl.TotalLineamount)                        as PriceEx,';
    result := result +  ' Sum(Sl.TotalLineamountInc)                     as PriceInc';
    result := result +  '  ' + SalesTableSQL;
    result := result +  ' group by year(S.SaleDate) , QUARTER(S.SaleDate), ' + CategoryFieldName('S');
    if DepartmentList <> '' then
      result := result + ', S.Class';
    result := result +  ' , S.Account,  '+
                    'SL.productName, '+
                    '' + Transtype('S',True) +' ' ;


    if includeJE then begin
      result := result +  ' union all';
      result := result +  ' Select';
      result := result +  ' 5                                                as Details, ';
      result := result +  ' Null                                             as TransID,';
      result := result +  ' convert(NULL , dateTime)                         as OrderDate,';
      result := result +  ' convert(NULL                          , signed)  as Weekno,';
      result := result +  ' convert(NULL                          , signed)  as monthno,';
      result := result +  ' convert(Quarter(J.TransactionDate)    , signed)  as Quarterno,';
      result := result +  ' convert(year(J.TransactionDate)       , signed)  as yearno,';
      result := result +  '  ' + QuarterNo('J.TransactionDate')+'                  as PeriodID,';
      result := result +  '  ' + Quarter('J.TransactionDate')+'                    as Period ,';
      result := result +  ' ' + CategoryFieldName('JL') +'                   as Category,';
      if DepartmentList = '' then
        result := result +  ' NULL                                             as Department,'
      else
        result := result +  ' JL.ClassName                                     as Department,';
      result := result +  ' NULL                                             as Description,';
      result := result +  ' JL.AccountName                                   as AccountName,';
      result := result +  ' "Journal Entry"                                  as TransType,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , (JL.CreditAmount - JL.DebitAmount ) , 0))        as CostEx,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0-JL.TaxAmount , JL.TaxAmount))                  as AmountTax,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , (JL.CreditAmountinc - JL.DebitAmountinc ) , 0))  as CostInc, ';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0 , (JL.DebitAmount-JL.CreditAmount )))          as PriceEx,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0 , (JL.DebitAmountinc -JL.CreditAmountinc )))   as PriceInc';
      result := result +  '  ' + GEJTableSQL;
      result := result +  ' group by year(J.TransactionDate), QUARTER(J.TransactionDate), ' + CategoryFieldName('JL');
      if DepartmentList <> '' then
        result := result + ', JL.ClassName';
      result := result +  ' , accountname ';
    end;

    result := result +  ' union all';
    result := result +  ' Select';
    result := result +  ' 6                                                as details,  ';
    result := result +  ' Null                                             as TransID,';
    result := result +  ' convert(NULL                     , dateTime)     as OrderDate,';
    result := result +  ' convert(NULL                     , signed)       as Weekno,';
    result := result +  ' convert(NULL                     , signed)       as monthno,';
    result := result +  ' convert(NULL                     , signed)       as Quarterno,';
    result := result +  ' convert(year(PO.orderDate)       , signed)       as yearno,';
    result := result +  ' year(PO.orderdate)                               as PeriodID, ';
    result := result +  ' year(PO.orderdate)                               as Period, ';
    result := result +  ' ' + CategoryFieldName +'                         as Category, ';
    if DepartmentList = '' then
      result := result +  ' NULL                                             as Department,'
    else
      result := result +  ' POL.Class                                        as Department,';
    result := result +  ' if(PO.isPO="T" , POL.productName, null)          as Description ,  ';
    result := result +  ' POL.accountname                                  as AccountName,';
   result := result +  ' ' + Transtype('PO',False) +'                      as Transtype,';
    result := result +  ' sum(0-POL.totalLineAmount)                       as CostEx,';
    result := result +  ' Sum(0-POL.lineTax)                               as AmountTax,';
    result := result +  ' Sum(0-POL.totalLineAmountinc)                    as CostInc,';
    result := result +  ' (0)                                              as PriceEx,';
    result := result +  ' (0)                                              as PriceInc';
    result := result +  '  ' + POTableSQL;
    result := result +  ' group by year(PO.orderdate), ' + CategoryFieldName;
    if DepartmentList <> '' then
      result := result + ', POL.Class';
    result := result +  ' , Accountname,  '+
                    '' + Transtype('PO',False) +' ' ;

    result := result +  ' union all';
    result := result +  ' Select ';
    result := result +  ' 6                                                as Details,';
    result := result +  ' NULL                                             as TransID,';
    result := result +  ' convert(NULL, dateTime)                          as OrderDate,';
    result := result +  ' convert(NULL , signed)                           as Weekno,';
    result := result +  ' convert(NULL      , signed)                      as monthno,';
    result := result +  ' convert(NULL    , signed)                        as Quarterno,';
    result := result +  ' convert(year(S.SaleDate)       , signed)         as yearno,';
    result := result +  ' year(S.SaleDate)                                 as PeriodID,';
    result := result +  ' year(S.SaleDate)                                 as Period,';
    result := result +  ' ' + CategoryFieldName('S') +'                    as Category,';
    if DepartmentList = '' then
      result := result +  ' NULL                                             as Department,'
    else
      result := result +  ' S.Class                                          as Department,';
    result := result +  ' SL.productName                                   as Description ,';
    result := result +  ' S.Account                                        as AccountName,';
    result := result +  ' ' + Transtype('S',True) +'                       as Transtype,';
    result := result +  ' sum(SL.LineCost * SL.Shipped)                    as CostEx,';
    result := result +  ' sum(SL.lineTax)                                  as AmountTax,';
    result := result +  ' sum(SL.LineCostInc * SL.Shipped)                 as CostInc,';
    result := result +  ' Sum(Sl.TotalLineamount)                          as PriceEx,';
    result := result +  ' Sum(Sl.TotalLineamountInc)                       as PriceInc';
    result := result +  '  ' + SalesTableSQL;
    result := result +  ' group by year(S.SaleDate), ' + CategoryFieldName('S');
    if DepartmentList <> '' then
      result := result + ', S.Class';
    result := result +  ' , S.Account,  '+
                    '' + Transtype('S',True) +' ' ;
    if includeJE then begin
      result := result +  ' union all';
      result := result +  ' Select';
      result := result +  ' 6                                                as details,';
      result := result +  ' Null                                             as TransID,';
      result := result +  ' convert(NULL                     , dateTime)     as OrderDate,';
      result := result +  ' convert(NULL                     , signed)       as Weekno,';
      result := result +  ' convert(NULL                     , signed)       as monthno,';
      result := result +  ' convert(NULL                     , signed)       as Quarterno,';
      result := result +  ' convert(year(J.TransactionDate)  , signed)       as yearno,';
      result := result +  ' year(J.TransactionDate)                          as PeriodID,';
      result := result +  ' year(J.TransactionDate)                          as Period ,';
      result := result +  ' ' + CategoryFieldName('JL') +'                   as Category,';
      if DepartmentList = '' then
        result := result +  ' NULL                                             as Department,'
      else
        result := result +  ' JL.ClassName                                     as Department,';
      result := result +  ' NULL                                             as Description,';
      result := result +  ' JL.AccountName                                   as AccountName,';
      result := result +  ' "Journal Entry"                                  as  TransType,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , (JL.CreditAmount - JL.DebitAmount ) , 0))        as CostEx,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0-JL.TaxAmount , JL.TaxAmount))                  as AmountTax,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , (JL.CreditAmountinc - JL.DebitAmountinc ) , 0))  as CostInc, ';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0 , (JL.DebitAmount-JL.CreditAmount )))          as PriceEx,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0 , (JL.DebitAmountinc -JL.CreditAmountinc )))   as PriceInc';
      result := result +  '  ' + GEJTableSQL;
      result := result +  ' group by year(J.TransactionDate) , ' + CategoryFieldName('JL');
      if DepartmentList <> '' then
        result := result + ', JL.ClassName';
      result := result +  ' , accountname ';
    end;



    result := result +  ' union all';
    result := result +  ' Select';
    result := result +  ' 7                                                as details,  ';
    result := result +  ' Null                                             as TransID,';
    result := result +  ' convert(NULL                     , dateTime)     as OrderDate,';
    result := result +  ' convert(NULL                     , signed)       as Weekno,';
    result := result +  ' convert(NULL                     , signed)       as monthno,';
    result := result +  ' convert(NULL                     , signed)       as Quarterno,';
    result := result +  ' convert(year(PO.orderDate)       , signed)       as yearno,';
    result := result +  ' year(PO.orderdate)                               as PeriodID, ';
    result := result +  ' year(PO.orderdate)                               as Period, ';
    result := result +  ' ' + CategoryFieldName +'                         as Category, ';
    if DepartmentList = '' then
      result := result +  ' NULL                                             as Department,'
    else
      result := result +  ' POL.Class                                        as Department,';
    result := result +  ' if(PO.isPO="T" , POL.productName, null)          as Description ,  ';
    result := result +  ' POL.accountname                                  as AccountName,';
    result := result +  ' NULL                                             as TransType,';
    result := result +  ' sum(0-POL.totalLineAmount)                       as CostEx,';
    result := result +  ' Sum(0-POL.lineTax)                               as AmountTax,';
    result := result +  ' Sum(0-POL.totalLineAmountinc)                    as CostInc,';
    result := result +  ' (0)                                              as PriceEx,';
    result := result +  ' (0)                                              as PriceInc';
    result := result +  '  ' + POTableSQL;
    result := result +  ' group by year(PO.orderdate), ' + CategoryFieldName;
    if DepartmentList <> '' then
      result := result + ', POL.Class';
    result := result +  ' , Accountname  ';

    result := result +  ' union all';
    result := result +  ' Select ';
    result := result +  ' 7                                                as Details,';
    result := result +  ' NULL                                             as TransID,';
    result := result +  ' convert(NULL, dateTime)                          as OrderDate,';
    result := result +  ' convert(NULL , signed)                           as Weekno,';
    result := result +  ' convert(NULL      , signed)                      as monthno,';
    result := result +  ' convert(NULL    , signed)                        as Quarterno,';
    result := result +  ' convert(year(S.SaleDate)       , signed)         as yearno,';
    result := result +  ' year(S.SaleDate)                                 as PeriodID,';
    result := result +  ' year(S.SaleDate)                                 as Period,';
    result := result +  ' ' + CategoryFieldName('S') +'                    as Category,';
    if DepartmentList = '' then
      result := result +  ' NULL                                             as Department,'
    else
      result := result +  ' S.Class                                          as Department,';
    result := result +  ' SL.productName                                   as Description ,';
    result := result +  ' S.Account                                        as AccountName,';
    result := result +  ' NULL                                             as Transtype,';
    result := result +  ' sum(SL.LineCost * SL.Shipped)                    as CostEx,';
    result := result +  ' sum(SL.lineTax)                                  as AmountTax,';
    result := result +  ' sum(SL.LineCostInc * SL.Shipped)                 as CostInc,';
    result := result +  ' Sum(Sl.TotalLineamount)                          as PriceEx,';
    result := result +  ' Sum(Sl.TotalLineamountInc)                       as PriceInc';
    result := result +  '  ' + SalesTableSQL;
    result := result +  ' group by year(S.SaleDate), ' + CategoryFieldName('S');
    if DepartmentList <> '' then
      result := result + ', S.Class';
    result := result +  ' , S.Account  ';

    if includeJE then begin
      result := result +  ' union all';
      result := result +  ' Select';
      result := result +  ' 7                                                as details,';
      result := result +  ' Null                                             as TransID,';
      result := result +  ' convert(NULL                     , dateTime)     as OrderDate,';
      result := result +  ' convert(NULL                     , signed)       as Weekno,';
      result := result +  ' convert(NULL                     , signed)       as monthno,';
      result := result +  ' convert(NULL                     , signed)       as Quarterno,';
      result := result +  ' convert(year(J.TransactionDate)  , signed)       as yearno,';
      result := result +  ' year(J.TransactionDate)                          as PeriodID,';
      result := result +  ' year(J.TransactionDate)                          as Period ,';
      result := result +  ' ' + CategoryFieldName('JL') +'                   as Category,';
      if DepartmentList = '' then
        result := result +  ' NULL                                             as Department,'
      else
        result := result +  ' JL.ClassName                                     as Department,';
      result := result +  ' NULL                                             as Description,';
      result := result +  ' JL.AccountName                                   as AccountName,';
      result := result +  ' NULL                                             as  TransType,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , (JL.CreditAmount - JL.DebitAmount ) , 0))        as CostEx,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0-JL.TaxAmount , JL.TaxAmount))                  as AmountTax,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , (JL.CreditAmountinc - JL.DebitAmountinc ) , 0))  as CostInc, ';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0 , (JL.DebitAmount-JL.CreditAmount )))          as PriceEx,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0 , (JL.DebitAmountinc -JL.CreditAmountinc )))   as PriceInc';
      result := result +  '  ' + GEJTableSQL;
      result := result +  ' group by year(J.TransactionDate), ' + CategoryFieldName('JL');
      if DepartmentList <> '' then
        result := result + ', JL.ClassName';
      result := result +  ' , accountname';
    end;


    result := result +  ' union all';
    result := result +  ' Select ';
    result := result +  ' Details                                          as Details, ';
    result := result +  ' TRANSID                                          as TransID,';
    result := result +  ' OrderDate                                        as OrderDate,';
    result := result +  ' convert(Weekno     , signed)                     as Weekno,';
    result := result +  ' convert(monthno    , signed)                     as monthno,';
    result := result +  ' convert(QuarterNo  , signed)                     as Quarterno,';
    result := result +  ' convert(yearNo     , signed)                     as yearno,';
    result := result +  ' PeriodID                                         as PeriodID, ';
    result := result +  ' Period                                           as Period, ';
    result := result +  ' Category                                         as Category, ';
    result := result +  ' Department                                       as Department, ';
    result := result +  ' Description                                      as Description, ';
    result := result +  ' Accountname                                      as Accountname, ';
    result := result +  ' TransType                                        as TransType, ';
    result := result +  ' sum(CostEx)                                      as CostEx, ';
    result := result +  ' Sum(AmountTax)                                   as Amounttax, ';
    result := result +  ' Sum(CostInc)                                     as CostInc, ';
    result := result +  ' sum(PriceEx)                                     as PriceEx,';
    result := result +  ' Sum(PriceInc)                                    as PriceInc';
    result := result +  ' from';
    result := result +  ' (Select';
    result := result +  ' 8                                                as details,  ';
    result := result +  ' Null                                             as TransID,';
    result := result +  ' convert(NULL   , dateTime)                       as OrderDate,';
    result := result +  ' convert(NULL   , signed)                         as Weekno,';
    result := result +  ' convert(NULL   , signed)                         as monthno,';
    result := result +  ' convert(NULL   , signed)                         as Quarterno,';
    result := result +  ' convert(NULL   , signed)                         as yearno,';
    result := result +  ' Null                                             as PeriodID, ';
    result := result +  ' NULL                                             as Period, ';
    result := result +  ' ' + CategoryFieldName +'                         as Category, ';
    if DepartmentList = '' then
      result := result +  ' NULL                                             as Department,'
    else
      result := result +  ' POL.Class                                        as Department,';
    result := result +  ' NULL                                             as Description,';
    result := result +  ' NULL                                             as AccountName,';
    result := result +  ' NULL                                             as TransType,';
    result := result +  ' sum(0-POL.totalLineAmount)                       as CostEx,';
    result := result +  ' Sum(0-POL.lineTax)                               as AmountTax,';
    result := result +  ' Sum(0-POL.totalLineAmountinc)                    as CostInc,';
    result := result +  ' (0)                                              as PriceEx,';
    result := result +  ' (0)                                              as PriceInc';
    result := result +  '  ' + POTableSQL;
    result := result +  ' group by ' + CategoryFieldName +'  ';
    if DepartmentList <> '' then
      result := result + ', POL.Class ';
    result := result +  ' union all';
    result := result +  ' Select ';
    result := result +  ' 8                                                as Details,';
    result := result +  ' NULL                                             as TransID,';
    result := result +  ' convert(NULL, dateTime)                          as OrderDate,';
    result := result +  ' convert(NULL , signed)                           as Weekno,';
    result := result +  ' convert(NULL      , signed)                      as monthno,';
    result := result +  ' convert(NULL    , signed)                        as Quarterno,';
    result := result +  ' convert(year(S.SaleDate)       , signed)         as yearno,';
    result := result +  ' NULL                                             as PeriodID,';
    result := result +  ' NULL                                             as Period,';
    result := result +  ' ' + CategoryFieldName('S') +'                    as Category,';
    if DepartmentList = '' then
      result := result +  ' NULL                                             as Department,'
    else
      result := result +  ' S.Class                                          as Department,';
    result := result +  ' NULL                                             as Description ,';
    result := result +  ' NULL                                             as AccountName,';
    result := result +  ' NULL                                             as Transtype,';
    result := result +  ' sum(SL.LineCost * SL.Shipped)                    as CostEx,';
    result := result +  ' sum(SL.lineTax)                                  as AmountTax,';
    result := result +  ' sum(SL.LineCostInc * SL.Shipped)                 as CostInc,';
    result := result +  ' Sum(Sl.TotalLineamount)                          as PriceEx,';
    result := result +  ' Sum(Sl.TotalLineamountInc)                       as PriceInc';
    result := result +  '  ' + SalesTableSQL;
    result := result +  ' group by ' + CategoryFieldName('S') +'  ';
    if DepartmentList <> '' then
      result := result + ', S.Class ';

    if includeJE then begin
      result := result +  ' union all';
      result := result +  ' Select';
      result := result +  ' 8                                                as details,';
      result := result +  ' Null                                             as TransID,';
      result := result +  ' convert(NULL   , dateTime)                       as OrderDate,';
      result := result +  ' convert(NULL   , signed)                         as Weekno,';
      result := result +  ' convert(NULL   , signed)                         as monthno,';
      result := result +  ' convert(NULL   , signed)                         as Quarterno,';
      result := result +  ' convert(NULL   , signed)                         as yearno,';
      result := result +  ' NULL                                             as PeriodID,';
      result := result +  ' NULL                                             as Period ,';
      result := result +  ' ' + CategoryFieldName('JL') +'                   as Category,';
      if DepartmentList = '' then
        result := result +  ' NULL                                             as Department,'
      else
        result := result +  ' JL.ClassName                                     as Department,';
      result := result +  ' NULL                                             as Description,';
      result := result +  ' NULL                                             as AccountName,';
      result := result +  ' NULL                                             as TransType,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , (JL.CreditAmount - JL.DebitAmount ) , 0))        as CostEx,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0-JL.TaxAmount , JL.TaxAmount))                  as AmountTax,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , (JL.CreditAmountinc - JL.DebitAmountinc ) , 0))  as CostInc, ';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0 , (JL.DebitAmount-JL.CreditAmount )))          as PriceEx,';
      result := result +  ' Sum(if(J.TaxSelect="INPUT" , 0 , (JL.DebitAmountinc -JL.CreditAmountinc )))   as PriceInc';
      result := result +  '  ' + GEJTableSQL;
      result := result +  ' group by ' + CategoryFieldName('JL') +'';
      if DepartmentList <> '' then
        result := result + ', JL.ClassName ';
    end;
    result := result +  ' ) as summary';
    result := result +  ' group by Category';
    result := result +  ' ORder by Details, Category, Period, TransType, accountname;';
    result := result +  ' update ' + fsTablename +' T '+
                        ' inner join tblchartofaccounts COA on T.Accountname = COA.accountname  '+
                        ' Set T.accountId = COA.accountID ,  '+
                        ' T.AccountNo = COA.AccountNumber,  '+
                        ' T.AccountType = COA.AccountType , ' +
                        ' T.Level1 = COA.Level1,  '+
                        ' T.Level2 = COA.Level2,  '+
                        ' T.Level3 = COA.Level3,  '+
                        ' T.Level4 = COA.Level4;';
end;
end.

