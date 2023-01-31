unit StockValueSQL;

interface

uses
  classes, ReportBaseObj;

Type
  TStockValue = class(TReportWithDateRangeBase)
  Private
    fTablename: string;
    fClassID: Integer;
    fProductID: Integer;
    fExcludeSO: Boolean;
    fHideRunningQty: Boolean;
    fIsAging: Boolean;
    fFilterIndex: Integer;

    procedure PopulateData;

  Protected

  Public
    constructor Create; Override;

    function PopulateReportSQL(SQL: TStrings; var msg: string): boolean; override;

  Published
    property ClientID: Integer  read fClassID write fClassID;
    property ProductID: Integer  read fProductID write fProductID;
    property ExcludeSO: Boolean  read fExcludeSO write fExcludeSO;
    property HideRunningQty: Boolean  read fHideRunningQty write fHideRunningQty;
    property IsAging: Boolean read fIsAging write fIsAging;
    property FilterIndex: Integer read fFilterIndex write fFilterIndex;
  end;

implementation

uses sysutils, ProductQtyLib, StringUtils, CommonDbLib, ERPdbComponents, MySQLConst,
  LogLib, CommonLib, PQALib;

constructor TStockValue.Create;
begin
   inherited;

   fTablename := CommonDbLib.CreateUserTemporaryTable('tmp_ssrr' );
   fClassID := 0;
   fProductID := 0;

   DateFrom := MinDateTime;
   DateTo := MaxDateTime;
end;

procedure TStockValue.PopulateData;
var
  ScriptMain: TERPScript;

  function Datefieldtofilter: string;
  begin
    if IsAging then result := 'ActualTransdate' else result := 'TransDate';
  end;
begin
  ScriptMain := TERPScript.Create(nil);
  try
    with ScriptMain do begin
      Connection := CommonDbLib.GetSharedMyDacConnection;
      SQL.Clear;

      SQL.Add('/*1*/TRUNCATE ' + fTableName + ';');
      SQL.Add('/*2*/DROP TABLE IF EXISTS ' + fTableName + '_PQA;');
      SQL.Add('/*3*/CREATE TABLE  ' + fTableName + '_PQA LIKE tblpqa;');
      SQL.Add('/*3.1*/ALTER TABLE  ' + fTableName + '_PQA ENGINE=MyISAM;');
      SQL.Add('/*3.2*/ALTER TABLE  ' + fTableName + '_PQA ROW_FORMAT=Fixed;');
      SQL.Add('/*3.3*/ALTER TABLE  ' + fTableName + '_PQA	ADD INDEX `TransLineID_TransType` (`TransLineID`, `TransType`);');
      SQL.Add('/*3.4*/ALTER TABLE  ' + fTableName + '_PQA ADD INDEX `ProductID` (`ProductID`), ADD INDEX `DepartmentID` (`DepartmentID`);');
      SQL.Add('/*4*/INSERT INTO ' + fTableName + '_PQA SELECT * FROM tblpqa '+
                  'WHERE TransDate BETWEEN ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat, DateFrom)) + ' AND ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat,DateTo)) +
                  iif(fClassID <> 0, ' AND departmentID = ' + IntToStr(fClassID), '') +
                  iif(fProductID <> 0, ' AND ProductID = ' + IntToStr(fProductID), '') +
                  '  AND ifnull(Qty,0)<> 0  ;');
      SQL.Add('/*5*/ALTER TABLE ' + fTableName + '_PQA  ADD COLUMN `ActualTransDate` DATETIME NULL DEFAULT NULL ;');
      SQL.Add('/*5.1*/ALTER TABLE ' + fTableName + '_PQA ADD INDEX ActualTransdate (ActualTransdate);');
      SQL.Add('/*6*/UPDATE ' + fTableName +'_PQA PQA ' +
                ' INNER JOIN tblpurchaselines       AS POL ON PQA.TransLineID = POL.PurchaseLineID       AND PQA.TRanstype in (' + POTranstypes + ') ' +
                ' INNER JOIN tblpurchaseOrders PO on POL.purchaseOrderId = PO.purchaseorderID   ' +
                ' SET PQA.ActualTransDate = PO.OrderDate;');
      SQL.Add('/*7*/UPDATE ' + fTableName +'_PQA PQA  ' +
                ' INNER JOIN tblsaleslines          AS SL  ON PQA.TransLineID = Sl.SalelineID            AND PQA.TRanstype in (' + SalesTransTypes + ') ' +
                ' INNER JOIN tblsales S on Sl.saleid = s.saleId  ' +
                ' SET PQA.ActualTransdate  = s.SaleDateTime;');
      SQL.Add('/*8*/UPDATE ' + fTableName +'_PQA PQA  ' +
                ' INNER JOIN tblstockmovementlines  AS SML ON PQA.TransLineID = SML.StockmovementLinesID AND PQA.TRanstype in (' + StockMovementtypes + ')   ' +
                ' SET PQA.ActualTransdate = PQA.transdate;');
      SQL.Add('/*9*/UPDATE ' + fTableName +'_PQA PQA  ' +
                ' INNER JOIN tblproctreepart        AS PTP ON PQA.TransLineID = PTP.ProcTreePartId       AND PQA.TRanstype in (' + ManufactureTypes + ') ' +
                ' INNER JOIN tblproctree PT on PTP.proctreeId = PT.proctreeID  ' +
                ' INNER JOIN tblsaleslines SL on SL.saleLineID = PT.masterId  ' +
                ' INNER JOIN tblsales S on S.saleId = SL.saleID ' +
                ' Set PQA.actualTransdate = s.saleDate;');
      SQL.Add('/*10*/UPDATE ' + fTableName + '_PQA PQA Set PQA.actualTransdate = PQA.transDate WHERE IFNULL(actualTransdate,0)=0;' );
      SQL.Add('/*10.1*/UPDATE ' + fTableName + '_PQA PQA Set PQA.active="T" WHERE Transtype IN ("TPRocProgressIN" , "TPRocProgressOUT");' );

      SQL.Add('/*11*/INSERT INTO ' + fTableName + '(Levelno,TransDate,Actualtransdate, className,transType,Transactionno,FormName,ProductName,Firstcolumn,Secondcolumn,Thirdcolumn,Qty,OQ,RQ,Avgcost)');
      SQL.Add('SELECT');
      SQL.Add('1 AS Levelno,');
      SQL.Add('null AS TransDate, ');
      SQL.Add('null AS Actualtransdate, ');
      SQL.Add('C.className, ');
      SQL.Add('"" AS transType,  ');
      SQL.Add('0 AS Transactionno, ');
      SQL.Add('"" AS FormName, ');
      SQL.Add('PQA.ProductName,');
      SQL.Add(Firstcolumn + ' AS Firstcolumn,');
      SQL.Add(Secondcolumn + '  AS Secondcolumn,');
      SQL.Add(Thirdcolumn + ' AS Thirdcolumn,');

      if ExcludeSO then
        SQL.Add(SQL4Qty(tInStock(*tActStock*)) + ' AS Qty,')
      else
        SQL.Add(SQL4Qty(tInStockMovement) + ' AS Qty,');
      if HideRunningQty = False then begin
        if ExcludeSO then begin
          SQL.Add('(SELECT ' + SQL4Qty(tInStock(*tActStock*), 'OQPQA', 'OQPQA.qty') + ' FROM ' + fTableName +'_PQA AS OQPQA ');
                SQL.Add('WHERE OQPQA.ProductID = PQA.ProductID ');
                SQL.Add('AND OQPQA.departmentID = PQA.DepartmentID ');
                if fClassId <> 0 then SQL.Add('AND OQPQA.departmentID = ' + IntToStr(fClassId));
                if ProductId <> 0 then SQL.Add('AND OQPQA.ProductId = ' + IntToStr(ProductId));
                SQL.Add('AND OQPQA.' + Datefieldtofilter +' < ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat, DateFrom)) + ') AS OQ,');
        end else begin
          SQL.Add('(SELECT ' + SQL4Qty(tInStockMovement, 'OQPQA', 'OQPQA.qty') + ' FROM ' + fTableName +'_PQA AS OQPQA ');
                SQL.Add('WHERE OQPQA.ProductID = PQA.ProductID ');
                SQL.Add('AND OQPQA.departmentID = PQA.DepartmentID ');
                if fClassId <> 0 then SQL.Add('AND OQPQA.departmentID = ' +IntToStr(fClassId));
                if ProductId <> 0 then SQL.Add('AND OQPQA.ProductId = ' +IntToStr(ProductId));
                SQL.Add('AND OQPQA.' + Datefieldtofilter +' < ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat , DateFrom)) + ') AS OQ,');
        end;
      end else begin
        SQL.Add('0.0 AS OQ,');
      end;
      SQL.Add('0.0 AS RQ,');
      SQL.Add('P.Avgcost');
      SQL.Add(' FROM ' + replacestr(ProductTables(tsummary), ' `tblPQA` ', ' ' + fTableName + '_PQA '));
      SQL.Add('WHERE PQA.' + Datefieldtofilter +' BETWEEN ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat, DateFrom)) );
      SQL.Add(' AND  ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat, DateTo)) );
      if fclassId <> 0 then SQL.Add('AND PQA.departmentID = ' + IntToStr(fClassId));
      if ProductId <> 0 then SQL.Add('AND PQA.ProductId = ' + IntToStr(ProductId));
      SQL.Add(' AND PQA.Active = "T"');
      SQL.Add('group by PQA.ProductID, PQA.DepartmentID');
      SQL.Add('order by className,ProductName, ' + Datefieldtofilter + ', Transtype , Transactionno;');

      if fFilterIndex = 1 then begin
        SQL.Add('/*12*/INSERT INTO ' + fTableName + '(Levelno,TransDate,Actualtransdate,className,transType,Transactionno,FormName,ProductName,Firstcolumn,Secondcolumn,Thirdcolumn,Qty,OQ,RQ,Avgcost)');
        SQL.Add('SELECT 2 AS Levelno, PQA.TransDate, PQA.actualtransdate, C.className,TT.Description Transtype, 0 AS Transactionno, ');
        SQL.Add('"" , PQA.ProductName,');
        SQL.Add(Firstcolumn + ' AS Firstcolumn,');
        SQL.Add(Secondcolumn + ' AS Secondcolumn,');
        SQL.Add(Thirdcolumn +' AS Thirdcolumn,');
        if ExcludeSO then
          SQL.Add(SQL4Qty(tInStock) + ' AS Qty,')
        else
          SQL.Add(SQL4Qty(tInStockMovement) + ' AS Qty,');
        SQL.Add('0 AS OQ,');
        if HideRunningQty = False then begin
          if ExcludeSO then begin
            SQL.Add('(SELECT ' + SQL4Qty(tInStock(*tActStock*), 'OQPQA', 'OQPQA.qty') + ' FROM ' + fTableName +'_PQA AS OQPQA ');
                  SQL.Add('WHERE OQPQA.ProductID = PQA.ProductID ');
                  SQL.Add('AND OQPQA.departmentID = PQA.DepartmentID ');
                  if fClassId <> 0 then SQL.Add('AND OQPQA.departmentID = ' +IntToStr(fClassId));
                  if ProductId <> 0 then SQL.Add('AND OQPQA.ProductId = ' +IntToStr(ProductId));
                  SQL.Add('AND OQPQA.' + Datefieldtofilter +' >= ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat, DateFrom)) );
                  SQL.Add('AND OQPQA.' + Datefieldtofilter +'<= PQA.' + Datefieldtofilter +' ) AS RQ,');
          end else begin
            SQL.Add('(SELECT ' + SQL4Qty(tInStockMovement, 'OQPQA' , 'OQPQA.qty') + '  FROM ' + fTableName +'_PQA AS OQPQA ');
                  SQL.Add('WHERE OQPQA.ProductID = PQA.ProductID ');
                  SQL.Add('AND OQPQA.departmentID = PQA.DepartmentID ');
                  if fClassId <> 0 then SQL.Add('AND OQPQA.departmentID = ' +IntToStr(fClassId));
                  if ProductId <> 0 then SQL.Add('AND OQPQA.ProductId = ' +IntToStr(ProductId));
                  SQL.Add('AND OQPQA.' + Datefieldtofilter +' >= ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat, DateFrom)));
                  SQL.Add('AND OQPQA.' + Datefieldtofilter +'<= PQA.' + Datefieldtofilter +' ) AS RQ,');
          end;
        end else begin
           SQL.Add('0.0 AS RQ,');
        end;
        SQL.Add(' P.Avgcost');
        SQL.Add('  FROM ' + replacestr(ProductTables(tsummary, false, true), ' `tblPQA` ' , ' ' + fTableName +'_PQA '));
        SQL.Add('WHERE PQA.' + Datefieldtofilter +' BETWEEN ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat, DateFrom)) );
        SQL.Add('  AND  ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat , DateTo)) );
        if fClassId <> 0 then SQL.Add(' AND PQA.departmentID = ' +IntToStr(fClassId));
        if ProductId <> 0 then SQL.Add(' AND PQA.ProductId = ' +IntToStr(ProductId));
        SQL.Add('  AND PQA.Active = "T"  AND PQA.ISBo="F"');
        //if chkExcludeSo.chedked then SQL.Add('  AND PQA.transtype <> "TSalesOrderline"');
        if fClassId <> 0 then SQL.Add(' AND PQA.departmentID = ' +IntToStr(fClassId));
        if ProductId <> 0 then SQL.Add(' AND PQA.ProductId = ' +IntToStr(ProductId));
        SQL.Add(' group by PQA.ProductID, PQA.DepartmentID, TT.Description');
        SQL.Add(' order by className,ProductName,' + Datefieldtofilter +', Transtype , Transactionno;');
      end else if fFilterIndex = 2 then begin
        SQL.Add(' /*13*/insert into ' + fTableName + '(Levelno,TransDate,ActualTransdate,className,transType,PQATranstype,PQATranslineID ,  Transactionno,FormName,ProductName,Firstcolumn,Secondcolumn,Thirdcolumn,Qty,OQ,RQ,Avgcost)');
        SQL.Add(' SELECT 3 AS Levelno,PQA.transdate, PQA.actualtransdate, C.className,TT.Description  ,PQA.Transtype, PQa.transLineId , PQA.TransID AS Transactionno, ');
        SQL.Add(' TT.formname,  PQA.ProductName,');
        SQL.Add(Firstcolumn + ' AS Firstcolumn,');
        SQL.Add(Secondcolumn + ' AS Secondcolumn,');
        SQL.Add(Thirdcolumn +' AS Thirdcolumn,');
        if ExcludeSO then
          SQL.Add(SQL4Qty(tInStock(*tActStock*)) + ' AS Qty,')
        else
          SQL.Add(SQL4Qty(tInStockMovement) + ' AS Qty,');
        SQL.Add(' 0 AS OQ,');
        if HideRunningQty = False then begin
          if ExcludeSO then begin
            SQL.Add(' (SELECT ' + SQL4Qty(tInStock(*tActStock*) , 'OQPQA' , 'OQPQA.qty') + '  FROM ' + fTableName +'_PQA AS OQPQA ');
                  SQL.Add('WHERE OQPQA.ProductID = PQA.ProductID ');
                  SQL.Add(' AND OQPQA.departmentID = PQA.DepartmentID ');
                  if fclassID <> 0 then SQL.Add(' AND OQPQA.departmentID = ' +IntToStr(fClassID));
                  if ProductId <> 0 then SQL.Add(' AND OQPQA.ProductId = ' +IntToStr(ProductId));
                  SQL.Add(' AND OQPQA.' + Datefieldtofilter +' >= ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat, DateFrom)));
                  SQL.Add(' AND OQPQA.' + Datefieldtofilter +'<= PQA.' + Datefieldtofilter +' ) AS RQ,');
          end else begin
            SQL.Add(' (SELECT ' + SQL4Qty(tInStockMovement , 'OQPQA' , 'OQPQA.qty') + ' FROM ' + fTableName + '_PQA AS OQPQA ');
                  SQL.Add('WHERE OQPQA.ProductID = PQA.ProductID ');
                  SQL.Add(' AND OQPQA.departmentID = PQA.DepartmentID ');
                  if fClassID <> 0 then SQL.Add(' AND OQPQA.departmentID = ' +IntToStr(fClassID));
                  if ProductId <> 0 then SQL.Add(' AND OQPQA.ProductId = ' +IntToStr(ProductId));
                  SQL.Add(' AND OQPQA.' + Datefieldtofilter +' >= ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat, DateFrom)));
                  SQL.Add(' AND OQPQA.' + Datefieldtofilter +'<= PQA.' + Datefieldtofilter + ' ) AS RQ,');
          end;
        end else begin
          SQL.Add(' 0.0 AS RQ,');
        end;
        SQL.Add(' P.Avgcost');
        SQL.Add('  FROM ' + replacestr(ProductTables(tsummary, false, true), ' `tblPQA` ', ' ' + fTableName +'_PQA '));
        SQL.Add('WHERE PQA.' + Datefieldtofilter +' BETWEEN ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat, DateFrom)) );
        SQL.Add('  AND  ' + QuotedStr(FormatDateTime(MysqlDatetimeFormat, DateTo)) );
        SQL.Add('  AND PQA.Active = "T" AND PQA.ISBo="F"');
        if fClassID <> 0 then SQL.Add(' AND PQA.departmentID = ' +IntToStr(fClassID));
        if ProductId <> 0 then SQL.Add(' AND PQA.ProductId = ' +IntToStr(ProductId));
        SQL.Add(' GROUP BY PQA.PQAID/*ProductID, PQA.DepartmentID, TT.Description , PQA.TransID*/');
        SQL.Add(' ORDER BY className,ProductName,' + Datefieldtofilter + ', Transtype , Transactionno;');

            {purchase order's total cost is used instead of qtyxcost to avoid round issue }
        SQL.Add(' /*14*/UPDATE ' + fTableName + ' T INNER JOIN tblpurchaselines       AS POL ON T.PQATransLineID = POL.PurchaseLineID       AND T.PQATRanstype in (' +POTranstypes      +')  Set T.Linecost = POL.Linecost, T.totalLinecost = POL.TotalLineAmount WHERE T.levelno = 3;');
        SQL.Add(' /*15*/UPDATE ' + fTableName + ' T INNER JOIN tblsaleslines          AS SL  ON T.PQATransLineID = Sl.SalelineID            AND T.PQATRanstype in (' +SalesTransTypes   +')  Set T.Linecost = SL.Linecost WHERE T.levelno = 3;');
        SQL.Add(' /*16*/UPDATE ' + fTableName + ' T INNER JOIN tblstockmovementlines  AS SML ON T.PQATransLineID = SML.StockmovementLinesID AND T.PQATRanstype in (' +StockMovementtypes+')  Set T.Linecost = SML.cost   WHERE T.levelno = 3;');
        SQL.Add(' /*17*/UPDATE ' + fTableName + ' T INNER JOIN tblproctreepart        AS PTP ON T.PQATransLineID = PTP.ProcTreePartId       AND T.PQATRanstype in (' +ManufactureTypes  +') INNER JOIN tblproctree PT on PTP.proctreeId = PT.proctreeID  ' + ' Set T.Linecost = (PT.cost/if(PT.TreeRootID = PT.ProctreeId , PT.totalQty,PT.Quantity)) WHERE T.levelno = 3;');
        SQL.Add(' /*17.1*/UPDATE '+fTableName + ' T INNER JOIN tblprocprogress        AS PP  ON T.PQATransLineID = PP.ProcProgressID        AND T.PQATRanstype in ("TProcProgressIn" , "TProcProgressOUT") ' +
                        ' INNER JOIN tblproctreepart AS PTP ON PP.ProcTreePartID = PTP.ProcTreePartId ' +
                        ' INNER JOIN tblproctree PT on PTP.proctreeId = PT.proctreeID ' +
                        ' SET T.linecost = (PT.cost/if(PT.TreeRootID = PT.ProctreeId , PT.totalQty,PT.Quantity)) ' +
                        ' WHERE T.levelno = 3;');
      end;
      SQL.Add(' /*18*/UPDATE ' + fTableName + ' T  SET cTranstype = Transtype, cTransId = transactionno WHERE transType <> "Stock movement" ;');
      SQL.Add(' /*19*/UPDATE ' + fTableName + ' T  '+
              ' INNER JOIN tblstockMovement SM on SM.StockmovementId = T.Transactionno '+
              ' INNER JOIN tblstockadjustentry SA on SM.StockmovementEntryglobalref = SA.GlobalRef AND SM.StockmovementEntryType = "StockAdjustEntry" ' +
              'SET cTransID = SA.StockAdjustEntryID, cTranstype =SM.StockmovementEntryType WHERE T.transType = "Stock movement";');

      SQL.Add(' /*20*/UPDATE ' + fTableName + ' T  '+
              ' INNER JOIN tblstockMovement SM on SM.StockmovementId = T.Transactionno ' +
              ' INNER JOIN tblstocktransferentry ST on SM.StockmovementEntryglobalref = ST.GlobalRef AND SM.StockmovementEntryType = "StockTransferEntry" ' +
              'SET cTransID = ST.TransferEntryID, cTranstype =SM.StockmovementEntryType WHERE T.transType = "Stock movement";');

      LogText(ScriptMain.SQLtext);
      ScriptMain.Execute;
    end;

  finally
    ScriptMain.Free;
  end;

end;

function TStockValue.PopulateReportSQL(SQL: TStrings; var msg: string): boolean;
var
  ScriptMain: TERPScript;

  function ReplaceAlias(AClause: string): string;
  var
    STemp: string;
  begin
    STemp := AClause;
    STemp := ReplaceStr(STemp, 'true', '"T"');
    STemp := ReplaceStr(STemp, 'false', '"F"');
    Result := STemp;
  end;

begin
  PopulateData;

  result := inherited;

  SQL.Clear;
  SQL.Add('SELECT');
  SQL.Add('Levelno          AS Levelno,');
  SQL.Add('TransDate        AS TransDate,');
  SQL.Add('ActualTransDate  AS ActualTransDate,');
  SQL.Add('ClassName        AS className,');
  SQL.Add('TransType        AS transType,');
  SQL.Add('Transactionno    AS Transactionno,');
  SQL.Add('FormName         AS FormName,');
  SQL.Add('ProductName      AS ProductName,');
  SQL.Add('Firstcolumn      AS Firstcolumn,');
  SQL.Add('Secondcolumn     AS Secondcolumn,');
  SQL.Add('Thirdcolumn      AS Thirdcolumn,');
  SQL.Add('Qty              AS Qty,');
  SQL.Add('OQ               AS OQ,');
  SQL.Add('RQ               AS RQ,');
  SQL.Add('Avgcost          AS Avgcost,');
  SQL.Add('Linecost         AS Linecost,');
  SQL.Add('LinecostInc      AS linecostinc,');
  SQL.Add('CTransID         AS cTransID,');
  SQL.Add('CTranstype       AS cTranstype');
  SQL.Add('FROM ' + ftablename);

  if not (Search = '') then
    SQL.Add('AND ' + ReplaceAlias(Search));

  if not (OrderBy = '') then
    SQL.Add('ORDER BY ' + OrderBy)
  else
    SQL.Add('ORDER BY className, ProductName, Transdate, Transtype, Transactionno');

end;

initialization

   RegisterClass(TStockValue);

end.
