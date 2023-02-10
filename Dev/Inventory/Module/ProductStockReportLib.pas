unit ProductStockReportLib;

interface

uses classes, controls;

function SQLtoAddDataToProductMovementTable(Tablename:String;PartsIDs:String;IgnoreDates :Boolean; dateFrom, DateTo:TDatetime):String;
function SQLtoAddDataToStockFormulaSummary(Tablename:String;PartsID:Integer;IgnoreDates :Boolean; dateFrom, DateTo:TDatetime): String;

implementation

uses  SysUtils, ProductQtylib, (*AppEnvironment, CommonLib, *)MySQLConst, Dateutils,
  tcConst, PQALib(*, LogLib*), AppEnvironmentVirtual  {$IFDEF DevMode}  , LogLib  {$ENDIF}, strutils;

function SQLtoAddDataToProductMovementTable(Tablename: String; PartsIDs: String; IgnoreDates: Boolean; dateFrom, DateTo: TDatetime): String;
var
  st:TStringlist;
  filename:String;
  ssql:String;
  QtyRoundTo:Integer;
begin
  if trim(PartsIDs) = '' then PartsIDs := '0';
  QtyRoundTo := (*appEnv.CompanyPrefs.QtyRoundTo*)tcConst.GeneralRoundPlaces;
  ST := TStringlist.create;
  try
    st.add('Truncate ' + tablename + ';');
    ssql := ' INSERT INTO ' + tablename + ' (PQAID, TransactionDate,TransType,PQATranstype,PQAActive, FormName,StockMovementEntryglobalref,'+
                                                            'ProductName,FirstColumn,SecondColumn,ThirdColumn,Qty,instockQty, AvailQty,'+
                                                            'TotalCost,AverageCost,Cost,'+
                                                            'TotalPrice,Price,'+
                                                            'ProductID,ClassID,TransactionNo,TransLineID, RunningTotal,RunningTotalAvailable,'+
                                                            'InvID,SoID,'+
                                                            'available,instock,so,invbo,pobo,OnBuild,building,'+
                                                            'Converted, alloctype) ';
    ssql := ssql +' SELECT PQA.PQAID, PQA.TransDate as TransactionDate,' ;
    ssql := ssql +' if(ifnull(SMTT.Description,"")<> "" ,SMTT.Description, if(ifnull(TT.Description,"") = "" , PQA.TransType , TT.Description))  as TransType,' ;
    ssql := ssql +' PQA.TransType as PQATranstype, PQA.active as PQAActive,' ;
    ssql := ssql +' ifnull(TT.formName, SMTT.formname) as formName,' ;
    ssql := ssql +' SM.StockmovementEntryglobalref,' ;
    ssql := ssql +' PQA.ProductName as ProductName,' ;
    ssql := ssql +firstColumn + ' As Firstcolumn,' ;
    ssql := ssql +Secondcolumn + ' As Secondcolumn,' ;
    ssql := ssql +Thirdcolumn + ' As Thirdcolumn,' ;
    //ssql := ssql + SQL4Qty(tTransQty) +' as Qty,' ;
    ssql := ssql + SQL4Qty(tActStockwithMan) +' as Qty,' ;
    ssql := ssql + SQL4Qty(tInstock) +' as instockQty,' ;
    ssql := ssql + SQL4Qty(tAvailable) +' as AvailQty,' ;
    ssql := ssql +' if(ifnull(P.AvgCost,0)=0 , P.costinc1 , P.Avgcost)  * ' + SQL4Qty(tAvailable) +' as totalcost,' ;
    ssql := ssql +' if(ifnull(P.AvgCost,0)=0 , P.costinc1 , P.Avgcost) as AverageCost,' ;
    ssql := ssql +' if(ifnull(P.AvgCost,0)=0 , P.costinc1 , P.Avgcost)  as Cost ,' ;
    ssql := ssql +' P.PRICEINC1 * ' + SQL4Qty(tAvailable) +' as totalPrice,' ;
    ssql := ssql +' P.PRICEINC1  as Price,' ;
    ssql := ssql +' PQA.ProductID ,' ;
    ssql := ssql +' PQA.DepartMentID as ClassID,' ;
    ssql := ssql +' PQA.TransID as TransactionNo,' ;
    ssql := ssql +' PQA.TransLineID as TransLineID,' ;
    ssql := ssql +' 0.0 as RunningTotal, ' ;
    ssql := ssql +' 0.0 as RunningTotalAvailable,' ;
    ssql := ssql +' 0 as InvID,' ;//ssql := ssql +' Inv.SaleId as InvID,' ;
    ssql := ssql +' 0 as  SoID,' ;//ssql := ssql +' So.SaleID as SoID,' ;
    ssql := ssql + 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tAvailable)+',0.0),' + IntToStr(QtyRoundTo)+') AS "Available",';
    ssql := ssql + 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInstock)  +',0.0),' + IntToStr(QtyRoundTo)+') AS "InStock",';
    ssql := ssql + 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tSO)       +',0.0),' + IntToStr(QtyRoundTo)+') AS "so",';
    ssql := ssql + 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tInvBO)    +',0.0),' + IntToStr(QtyRoundTo)+') AS "InvBo",';
    ssql := ssql + 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tPOBO)     +',0.0),' + IntToStr(QtyRoundTo)+') AS "POBO",';
    ssql := ssql + 'Round(IF(P.PARTTYPE = "INV",' +ProductQtylib.SQL4Qty(tOnBuild)  +',0.0),' + IntToStr(QtyRoundTo)+') AS "OnBuild",';
    ssql := ssql + '0-Round(IF(P.PARTTYPE="INV",' +ProductQtylib.SQL4Qty(tBuilding) +',0.0),' + IntToStr(QtyRoundTo)+') AS "Building",';
    ssql := ssql +' S3.Converted as Converted, PQA.AllocType' ;
    ssql := ssql +' FROM ' + ProductTables(tSummary, False, TRue);
    ssql := ssql +' LEFT join `tblSales` S3 on S3.SaleId = PQA.TransID and ((PQA.TRansType in ("TSalesOrderline" )) or (PQA.TransType in ("TProcTreePart") and PQA.AllocType = "IN")  or '+
                  ' (PQA.Transtype in ("TSalesOrderInvoiceLines") and PQA.Active ="T") )' ;
    ssql := ssql +' LEFt JOIN `tblStockMovement` SM on SM.Deleted = "F" and SM.StockmovementId = PQA.TransId and PQA.TransType = ' + QuotedStr('TStockMovementLines');
    ssql := ssql +' LEFt JOIN `tblpqatranstypes` as SMTT on SM.StockmovementEntryType = SMTT.TransType' ;
    ssql := ssql +' Where ((' + quotedstr(trim(PartsIDs))+' ="0") or (PQA.ProductID in ( '+PartsIDs +')))';
    if IgnoreDates= False then
       ssql := ssql +'  AND PQA.TransDate Between ' +Quotedstr(FormatDateTime(MysqlDateFormat, DateFrom)) + ' AND ' + QuotedStr(FormatDateTime(MysqlDateFormat, incday(Dateto)));
    ssql := ssql +'  and (' + SQL4QtyField(tAvailable) +' <> 0' ;
    ssql := ssql +'  Or ' + SQL4QtyField(tInstock) +' <> 0 ) ' ;
    ssql := ssql +' group by  TransDate , PQA.TransID, PQA.productID, PQA.TRansType, PQA.departmentID, PQA.PQAID' ;
    ssql := ssql +' Union All' ;
    ssql := ssql +' Select  null, cast(0 as Date) as TransactionDate,' ;
    ssql := ssql +' "Opening Balance" as TransType,' ;
    ssql := ssql +' "" ,"F", ' ;
    ssql := ssql +' "" ,' ;
    ssql := ssql +' "",' ;
    ssql := ssql +' PartName,' ;
    ssql := ssql +firstColumn + ',' ;
    ssql := ssql +Secondcolumn + ',' ;
    ssql := ssql +Thirdcolumn + ' ,' ;
    ssql := ssql + '0 ,' ;
    ssql := ssql + '0 ,' ;
    ssql := ssql + '0 ,' ;
    ssql := ssql +' if(ifnull(P.AvgCost,0)=0 , P.costinc1 , P.Avgcost)  ,' ;
    ssql := ssql +' if(ifnull(P.AvgCost,0)=0 , P.costinc1 , P.Avgcost)  ,' ;
    ssql := ssql +' if(ifnull(P.AvgCost,0)=0 , P.costinc1 , P.Avgcost)  ,' ;
    ssql := ssql +' P.PRICEINC1  as totalPrice,' ;
    ssql := ssql +' P.PRICEINC1  as Price,' ;
    ssql := ssql +' PartsId ,' ;
    ssql := ssql +' 0 ,' ;
    ssql := ssql +' 0 ,' ;
    ssql := ssql +' 0 ,' ;
    ssql := ssql +' 0.0 ,' ;
    ssql := ssql +' 0.0 ,' ;
    ssql := ssql +' 0 as InvID,' ;
    ssql := ssql +' 0 as SoID,' ;
    ssql := ssql +' 0,0,0,0,0,0,0,';
    ssql := ssql +' "F" as Converted, "IN"' ;
    ssql := ssql +' FROM `tblparts` P ' ;
    ssql := ssql +' Where  ((' + quotedstr(trim(PartsIDs))+' ="0") or (PartsId in ( '+PartsIDs +')));';


    ssql := ssql +' update ' +tablename+' t inner join `tblSales` S on S.SaleId = T.TransactionNo and '+
            ' ((T.PQATranstype in ("TSalesOrderline" )  and S.converted = "T") or '+
            '       (T.PQATranstype in ("TProcTreePart") and T.AllocType = "IN" and S.Converted = "T") or '+
            '       (T.PQATranstype in ("TSalesOrderInvoiceLines") and T.PQAActive ="T") )'+
            ' INNER  join `tblSales` Inv on ifnull(Inv.SalesOrderGlobalref,"") =S.globalref Set T.InvId = Inv.saleID;' ;
    ssql := ssql +' update ' +tablename+' t inner join `tblSales` S2 on S2.SaleId = T.TransactionNo and T.PQATranstype in ("TInvoiceLine" )'+
            ' INNER join `tblSales` SO on ifnull(S2.SalesOrderGlobalref,"") =SO.globalref Set T.SOID = So.SaleId;' ;
    st.add(ssql);

    ST.add('update  '+ Tablename +'  T ' +
            ' inner join `tblSalesLines` SL on SL.sAlelineId = T.TransLineId and T.PQATranstype  in (' + SalesTransTypes+')' +
            ' set T.cost = Sl.LineCost,  TotalCost = Sl.LineCost * AvailQty where ifnull(Sl.LineCost,0)<>0 ;');

    ST.add('update  '+ Tablename +'  T ' +
            ' inner join `tblSalesLines` SL on SL.sAlelineId = T.TransLineId and T.PQATranstype  in (' + SalesTransTypes+')' +
            ' set T.Price = Sl.LinePriceInc,  TotalPrice = Sl.LinePriceInc * AvailQty where ifnull(Sl.LinePriceInc,0)<>0 ;');


    ST.add('update  '+ Tablename +'  T ' +
            ' inner join `tblpurchaselines` PL on PL.PurchaseLineID = T.TransLineId and T.PQATranstype  in (' + POTranstypes+')' +
            ' set  T.cost =  PL.LineCost ,  TotalCost = PL.LineCost * AvailQty where ifnull(PL.LineCost,0)<>0 ;');

    ST.add('update  '+ Tablename +'  T ' +
            ' inner join `tblpurchaselines` PL on PL.PurchaseLineID = T.TransLineId and T.PQATranstype  in (' + POTranstypes+')' +
            ' set  T.price =  NULL ,  Totalprice = NULL ;');

    ST.add('update  '+ Tablename +'  T ' +
            ' inner join `tblstockmovementlines` SML on SML.StockmovementLinesID = T.TransLineId and T.PQATranstype  in (' + StockMovementtypes+')' +
            ' set  T.cost =  SML.cost , TotalCost = SML.cost * AvailQty where ifnull(SML.Cost,0)<>0 ;');

    ST.add('update  '+ Tablename +'  T ' +
            ' inner join `tblstockmovementlines` SML on SML.StockmovementLinesID = T.TransLineId and T.PQATranstype  in (' + StockMovementtypes+')' +
            ' set  T.PRICE =  NULL, TotalPrice = NULL ;');

   ST.add('update  '+ Tablename +'  T ' +
          ' inner Join `tblproctreepart`        AS PTP  ON PTP.ProcTreePartId = T.TransLineID           and T.PQATRanstype in (' +ManufactureTypes+')' +
          ' inner join `tblproctree`  As PT on PT.ProcTreeId = PTP.ProcTreeID   and ifnull(PT.parentID,0)<>0' +
          ' Set T.cost =  PT.Cost/Quantity , TotalCost = PT.Cost/Quantity * AvailQty where ifnull(PT.Cost,0)<>0 ;');

   ST.add('update  '+ Tablename +'  T ' +
          ' inner Join `tblproctreepart`        AS PTP  ON PTP.ProcTreePartId = T.TransLineID           and T.PQATRanstype in (' +ManufactureTypes+')' +
          ' inner join `tblproctree`  As PT on PT.ProcTreeId = PTP.ProcTreeID   and ifnull(PT.parentID,0)<>0' +
          ' set  T.PRICE =  NULL, TotalPrice = NULL ;');

   ST.add('update  '+ Tablename +'  T ' +
          ' inner Join `tblprocprogress`        AS PPG  ON PPG.ProcProgressID = T.TransLineID           and T.PQATRanstype in ("TProcProgressOUT")' +
          ' inner Join `tblprocprogress`        AS PPGIN  ON PPG.InProcProgressId = PPGIN.ProcProgressID  and ifnull(PPGIN.Qty,0)=0         ' +
          ' set  T.TRanstype = "Progress Build(Wastage)";');

   ST.add('update  '+ Tablename +'  T ' +
            ' inner join `tblSalesLines` SL on SL.sAlelineId = T.TransLineId and T.Transtype = "Sales Order" ' +
            ' inner join `tblproctree` PT on Sl.SaleLineId	= PT.masterID and PT.ParentID=0 and PT.Mastertype <> "mtProduct" ' +
            ' Set T.FromStock = "T" where PT.PartSource = "psStock" ;');

   ST.add('update  '+ Tablename +'  T ' +
            '  inner join tblprocprogress PPg on T.TransLineID = PPg.ProcProgressID ' +
            '  and pqatranstype in ("TProcProgressIn" , "TProcProgressOUT") and PPg.BuildStatus ="W" Set TransType = concat(Transtype , "(Wastage)") ;');

   ST.add('update  '+ Tablename +'  T ' +
                ' inner join tblstockadjustentry SA on T.StockmovementEntryglobalref = SA.globalref '+
                ' set T.SAID = SA.StockAdjustEntryID '+
                ' where ifnull(T.Transtype,"") = "Stock Adjustment";');

   ST.add('update  '+ Tablename +'  T ' +
                ' inner join tblstocktransferentry ST on T.StockmovementEntryglobalref = ST.globalref '+
                ' set T.STID = ST.TransferEntryID'+
                ' where ifnull(T.Transtype,"") = "Stock Transfer";');

   ST.add('update  '+ Tablename +'  T ' +
                ' inner join tblststags ST on T.StockmovementEntryglobalref = ST.globalref  '+
                ' set T.StSID = ST.ID '+
                ' where ifnull(T.Transtype,"") = "Seed To Sale";');


   ST.add('update  '+ Tablename +'  T ' +
                ' inner join tblststag_actions STA on T.translineId  = STA.SMLLineID '+
                ' set T.ExtraDesc = STA.StatusAction'+
                ' where ifnull(T.Transtype,"") = "Seed To Sale";');


   ST.add('update  '+ Tablename +'  T ' +
                ' inner join tblparts P on T.ProductId = P.PartsId Set T.Productname = P.partname where ifnull(T.Productname, "")="";');


    REsult := St.Text;
    {$IFDEF DevMode}clog(St.text);{$ENDIF}
  finally
    //AppEnv.UtilsClient.DeleteServerFiles(replaceStr(Filename, '.tmp' , '*.tmp'));
    AppEnvVirt.DeleteServerFiles(ReplaceStr(Filename, '.tmp' , '*.tmp'));
    Freeandnil(st);
  end;
end;

function SQLtoAddDataToStockFormulaSummary(Tablename:String;PartsID:Integer;IgnoreDates :Boolean; dateFrom, DateTo:TDatetime): String;
var
  st:TStringlist;
begin
  st:= Tstringlist.Create;
  try
    St.Add( SQLtoAddDataToProductMovementTable(Tablename,inttostr(PartsID),IgnoreDates , dateFrom, DateTo));
        St.Add('Delete from ' +tablename +' where transtype = "Opening Balance";' );

        ST.add('update  '+ Tablename +'  T ' +
                ' inner join `tblSalesLines` SL on SL.sAlelineId = T.TransLineId and T.PQATranstype  in (' + SalesTransTypes+')' +
                ' set T.FormulaQtyvalue1 = if(ifnull(SL.shipped,0)=0 , SL.FormulaQtySoldValue1 , SL.FormulaQtyShippedValue1),'+
                '     T.FormulaQtyvalue2 = if(ifnull(SL.shipped,0)=0 , SL.FormulaQtySoldValue2 , SL.FormulaQtyShippedValue2),'+
                '     T.FormulaQtyvalue3 = if(ifnull(SL.shipped,0)=0 , SL.FormulaQtySoldValue3 , SL.FormulaQtyShippedValue3),'+
                '     T.FormulaQtyvalue4 = if(ifnull(SL.shipped,0)=0 , SL.FormulaQtySoldValue4 , SL.FormulaQtyShippedValue4),'+
                '     T.FormulaQtyvalue5 = if(ifnull(SL.shipped,0)=0 , SL.FormulaQtySoldValue5 , SL.FormulaQtyShippedValue5);');



        ST.add('update  '+ Tablename +'  T ' +
                ' inner join `tblpurchaselines` PL on PL.PurchaseLineID = T.TransLineId and T.PQATranstype  in (' + POTranstypes+')' +
                ' set T.FormulaQtyvalue1 = if(ifnull(PL.shipped,0)=0 , PL.FormulaQtySoldValue1 , PL.FormulaQtyShippedValue1),'+
                '     T.FormulaQtyvalue2 = if(ifnull(PL.shipped,0)=0 , PL.FormulaQtySoldValue2 , PL.FormulaQtyShippedValue2),'+
                '     T.FormulaQtyvalue3 = if(ifnull(PL.shipped,0)=0 , PL.FormulaQtySoldValue3 , PL.FormulaQtyShippedValue3),'+
                '     T.FormulaQtyvalue4 = if(ifnull(PL.shipped,0)=0 , PL.FormulaQtySoldValue4 , PL.FormulaQtyShippedValue4),'+
                '     T.FormulaQtyvalue5 = if(ifnull(PL.shipped,0)=0 , PL.FormulaQtySoldValue5 , PL.FormulaQtyShippedValue5);');


        ST.add('update  '+ Tablename +'  T ' +
                ' inner join `tblstockmovementlines` SML on SML.StockmovementLinesID = T.TransLineId and T.PQATranstype  in (' + StockMovementtypes+')' +
                ' set T.FormulaQtyvalue1 = SML.FormulaQtyValue1,'+
                '     T.FormulaQtyvalue2 = SML.FormulaQtyValue2,'+
                '     T.FormulaQtyvalue3 = SML.FormulaQtyValue3,'+
                '     T.FormulaQtyvalue4 = SML.FormulaQtyValue4,'+
                '     T.FormulaQtyvalue5 = SML.FormulaQtyValue5;');



       ST.add('update  '+ Tablename +'  T ' +
              ' inner Join `tblproctreepart`        AS PTP  ON PTP.ProcTreePartId = T.TransLineID           and T.PQATRanstype in (' +ManufactureTypes+')' +
              ' inner join `tblproctree`  As PT on PT.ProcTreeId = PTP.ProcTreeID ' +
                ' set T.FormulaQtyvalue1 = PT.FormulaQtyValue1,'+
                '     T.FormulaQtyvalue2 = PT.FormulaQtyValue2,'+
                '     T.FormulaQtyvalue3 = PT.FormulaQtyValue3,'+
                '     T.FormulaQtyvalue4 = PT.FormulaQtyValue4,'+
                '     T.FormulaQtyvalue5 = PT.FormulaQtyValue5;');

  finally
    REsult := St.Text;
    FreeandNil(st);
  end;

end;



end.

