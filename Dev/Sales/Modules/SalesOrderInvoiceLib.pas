unit SalesOrderInvoiceLib;

interface

  Function GetSalesOrderAllocationTobeInvoiced(const SalesOrderLineID:Integer):String;

implementation

uses CommonDbLib, sysutils, busobjPQA, BusObjSales, busobjSalesorderInvoice,
  LogLib;

Function GetSalesOrderAllocationTobeInvoiced(const SalesOrderLineID:Integer):String;
begin
  Result:= GetUserTemporaryTableName('SalesOrderInvoiceAllocation');
  With TempMyScript() do try
    SQL.Add('Drop table if exists  ' + result +';');
    SQL.Add('CREATE TABLE `' + Result + '` (');
    SQL.Add('ID           int(11)       NOT NULL auto_increment,');
    SQL.Add('batchbin     varchar(255)            DEFAULT NULL,');
    SQL.Add('Keydata      varchar(255)            DEFAULT NULL,');
    SQL.Add('batchno      varchar(100)            DEFAULT NULL,');
    SQL.Add('expirydate   datetime      NULL      DEFAULT NULL,');
    SQL.Add('batchqty     double NULL             DEFAULT NULL,');
    SQL.Add('binlocation  varchar(30)             DEFAULT NULL,');
    SQL.Add('binnumber    varchar(30)             DEFAULT NULL,');
    SQL.Add('binid        int(11)                 DEFAULT 0,');
    SQL.Add('binqty       double NULL             DEFAULT NULL,');
    SQL.Add('serialnumber varchar(100)            DEFAULT NULL,');
    SQL.Add('Category     varchar(5)    NULL  DEFAULT "",');
    SQL.Add('DetailID     int(11)       NULL  DEFAULT 0,');
    SQL.Add('Globalref    varchar(255)            DEFAULT NULL,');
    SQL.Add('ParentRef    varchar(255)            DEFAULT NULL,');
    SQL.Add('pqaSNID      int(11)                 DEFAULT 0,');
    SQL.Add('pqabinid     int(11)                 DEFAULT 0,');
    SQL.Add('pqabatchID   int(11)       NULL  DEFAULT 0,');
    SQL.Add('Allocqty     double NULL             DEFAULT NULL,');
    SQL.Add('Hidebatch    enum("T","F")           DEFAULT "F",');
    SQL.Add('HideBin      enum("T","F")           DEFAULT "F",');
    SQL.Add('PRIMARY KEY  (ID)');
    SQL.Add(') ENGINE=MyISAM DEFAULT CHARSET=utf8;');

    SQL.Add('INSERT INTO `' + Result + '` (Keydata,batchbin,batchno,expirydate,batchqty,binlocation,binnumber,binid,binqty,serialnumber,Category,DetailID,Globalref,ParentRef,pqaSNID,pqabinid,pqabatchID)');
    SQL.Add('SELECT');
    SQL.Add('concat(ifnull(pqabatch.value,""),"-", ifnull(pqabatch.expirydate,0),"-",ifnull(pqabins.binID,""), "-", ifnull(PQASN.Value,"") ,');
    SQL.Add('if(not(isnull(PQASN.PQADetailID)) , ' + quotedstr(TPQASN.PQADetailtype) +' , if(not(isnull(pqabins.PQADetailID)) ,  ' + quotedstr(TPQABins.PQADetailtype) +' , ' + quotedstr(TPQABatch.PQADetailtype) +'))) as Keydata,');
    SQL.Add('concat(ifnull(pqabatch.value,""),"-", ifnull(pqabatch.expirydate,0),"-",ifnull(pqabins.Value,"")) as batchbin,');
    SQL.Add('pqabatch.value as batchno , pqabatch.expirydate,');
    SQL.Add('if(isnull(PQABins.PQADetailID) and isnull(Pqasn.PQADetailID) ,  pqabatch.uomqty, null) as batchqty,');
    SQL.Add('pbin.binlocation, pbin.binnumber,');
    SQL.Add('pqabins.Value as binID,');
    SQL.Add('if(isnull(Pqasn.PQADetailID) ,  PQABins.uomqty, null) as binqty,');
    SQL.Add('pqasn.value serialnumber,');
    SQL.Add('if(not(isnull(PQASN.PQADetailID)) , ' + quotedstr(TPQASN.PQADetailtype) +' , if(not(isnull(pqabins.PQADetailID)) ,  ' + quotedstr(TPQABins.PQADetailtype) +' , ' + quotedstr(TPQABatch.PQADetailtype) +')) as Category,');
    SQL.Add('ifnull(PQASN.PQADetailID,ifnull(pqabins.PQADetailID,PQAbatch.PQADetailID)) as DetailID,');
    SQL.Add('ifnull(PQASN.Globalref,ifnull(pqabins.Globalref,PQAbatch.Globalref)) as DetailGlobalref,');
    SQL.Add('ifnull(PQASN.ParentRef,ifnull(pqabins.ParentRef,PQAbatch.ParentRef)) as DetailParentRef,');
    SQL.Add('PQASN.PQADetailID pqaSNID,');
    SQL.Add('pqabins.PQADetailID pqabinid,');
    SQL.Add('PQAbatch.PQADetailID pqabatchID');
    SQL.Add('FROM tblsales S');
    SQL.Add('INNER JOIN tblsaleslines SL ON s.saleId = SL.saleId');
    SQL.Add('INNER JOIN tblparts p ON p.partsid = sl.productid');
    SQL.Add('INNER JOIN tblpqa pqa ON SL.saleId = pqa.transId AND pqa.translineId = SL.saleLineid AND pqa.transtype = ' + Quotedstr(TSalesOrderLine.classname)+'');
    SQL.Add('LEFT JOIN `tblPqaDetails` PQABatch  ON PQABatch.PQAId 	= PQA.PQAID AND PQABatch.PQAType = ' + quotedstr(TPQABatch.PQADetailtype) +'  AND PQABatch.Active= "T"');
    SQL.Add('LEFT JOIN `tblPqaDetails` PQABins  ON PQABins.PQAId 	= PQA.PQAID  AND PQABins.PQAType = ' + quotedstr(TPQABins.PQADetailtype) +' AND PQABins.Active = "T"');
    SQL.Add('           AND   ( (PQABatch.globalref = IFNULL(PQABins.ParentRef,"") AND P.Batch="T"  AND P.multiplebins = "T") or (ifnull(PQABins.Parentref ,"") = ""');
    SQL.Add('           AND P.Batch="F" AND P.multiplebins = "T"))');
    SQL.Add('LEFT JOIN `tblProductBin` PBin     ON PBin.binId 	= PQABins.BinID');
    SQL.Add('LEFT JOIN `tblPqaDetails` PQASN    ON (PQASN.PQAId 	= PQA.PQAID AND PQASN.PQAType = ' + quotedstr(TPQASN.PQADetailtype) +'   AND PQASN.Active = "T"');
    SQL.Add('AND ((PQABatch.globalref = IFNULL(PQASN.ParentRef,"") AND P.Batch="T" AND P.multiplebins = "F" AND P.SNTracking = "T")');
    SQL.Add('OR (PQAbins.Globalref = IFNULL(PQASn.ParentRef,"") AND P.Multiplebins = "T" AND P.SNTracking = "T") or');
    SQL.Add('ifnull(PQASN.Parentref ,"") = "" AND P.Batch="F" AND P.Multiplebins = "F" AND P.SNTracking = "T" ))');
    SQL.Add('WHERE SL.saleLineID = ' + inttostr(SalesOrderLineID) +'');
    SQL.Add('ORDER BY batchno, expirydate, binlocation, binnumber,serialnumber;');

    SQL.Add('Drop table if exists ' + Result + '1;');
    SQL.Add('Create table  ' + Result + '1');
    SQL.Add('SELECT');
    SQL.Add('concat(ifnull(pqabatch.value,""),"-", ifnull(pqabatch.expirydate,0),"-",ifnull(pqabins.binID,""), "-", ifnull(PQASN.Value,"") ,');
    SQL.Add('if(not(isnull(PQASN.PQADetailID)) , ' + quotedstr(TPQASN.PQADetailtype) +' , if(not(isnull(pqabins.PQADetailID)) ,  ');
    SQL.Add( quotedstr(TPQABins.PQADetailtype) +' , ' + quotedstr(TPQABatch.PQADetailtype) +'))) as Keydata,');
    SQL.Add('pqabatch.value as batchno , pqabatch.expirydate,  pqabins.Value as binID,  pqasn.value serialnumber,  if(not(isnull(PQASN.PQADetailID)) , ');
    SQL.Add('' + quotedstr(TPQASN.PQADetailtype) +' , if(not(isnull(pqabins.PQADetailID)) ,  ' + quotedstr(TPQABins.PQADetailtype) +' , ' + quotedstr(TPQABatch.PQADetailtype) +')) as Category,  ');
    SQL.Add('sum(ifnull(Pqasn.qty ,  ifnull(PQABins.qty, PQABatch.qty))) as qty,sum(ifnull(Pqasn.uomqty ,  ifnull(PQABins.uomqty, PQABatch.uomqty))) as uomqty,  ');
    SQL.Add('PQASN.PQADetailID    pqaSNID,  pqabins.PQADetailID  pqabinid,  PQAbatch.PQADetailID pqabatchID  ');
    SQL.Add('from tblpqa PQA  ');
    SQL.Add('inner join tblparts P on P.partsId = PQa.productId  ');
    SQL.Add('inner join tblSalesOrderInvoiceLines SOIL on SOIL.SOInvoiceLineID = PQA.transLineID and SOIL.SOInvoiceID = PQa.transId and PQA.TransType = ' + Quotedstr(TSalesOrderInvoiceLines.classname)+'  ');
    SQL.Add('inner join tblSaleslines SOL on  SOL.SaleLineID = SOIL.SalesOrderLineID and SOL.SaleLineID= ' + inttostr(SalesOrderLineID) );
    SQL.Add('LEft  JOIN `tblPqaDetails` PQABatch  ON PQABatch.PQAId 	= PQA.PQAID AND PQABatch.PQAType = ' + quotedstr(TPQABatch.PQADetailtype) +'  AND PQABatch.Active= "T" and ifnull(PQABatch.qty,0)<>0  ');
    SQL.Add('LEFT JOIN `tblPqaDetails` PQABins  ON PQABins.PQAId 	= PQA.PQAID  AND PQABins.PQAType = ' + quotedstr(TPQABins.PQADetailtype) +' AND PQABins.Active = "T"  and ifnull(PQABins.qty,0)<>0');
    SQL.Add('AND   ( (PQABatch.globalref = IFNULL(PQABins.ParentRef,"") AND P.Batch="T"  AND P.multiplebins = "T") ');
    SQL.Add('or (ifnull(PQABins.Parentref ,"") = ""             AND P.Batch="F" AND P.multiplebins = "T"))  ');
    SQL.Add('LEFT JOIN `tblPqaDetails` PQASN    ON (PQASN.PQAId 	= PQA.PQAID AND PQASN.PQAType = ' + quotedstr(TPQASN.PQADetailtype) +'   ');
    SQL.Add('AND PQASN.Active = "T" and ifnull(PQASN.qty,0)<>0  AND ((PQABatch.globalref = IFNULL(PQASN.ParentRef,"") AND P.Batch="T" AND P.multiplebins = "F" AND P.SNTracking = "T")  ');
    SQL.Add('OR (PQAbins.Globalref = IFNULL(PQASn.ParentRef,"") AND P.Multiplebins = "T" AND P.SNTracking = "T") or  ifnull(PQASN.Parentref ,"") = "" AND P.Batch="F" ');
    SQL.Add('AND P.Multiplebins = "F" AND P.SNTracking = "T" ))  ');
    SQL.Add('group by concat(ifnull(pqabatch.value,""),"-", ifnull(pqabatch.expirydate,0),"-",ifnull(pqabins.Value,""), "-", ifnull(PQASN.Value,"") ,  ');
    SQL.Add('if(not(isnull(PQASN.PQADetailID)) , ' + quotedstr(TPQASN.PQADetailtype) +' , if(not(isnull(pqabins.PQADetailID)) ,  ' + quotedstr(TPQABins.PQADetailtype) +' , ' + quotedstr(TPQABatch.PQADetailtype) +'))) ;');
    SQL.Add('Delete T.* from ' + Result + ' T  inner join ' + Result + '1 as T1 on T.Keydata = T1.keydata where ifnull(T.serialnumber,"")<> "" and T1.category = ' + quotedstr(TPQASN.PQADetailtype) +';');
    SQL.Add('update ' + Result + ' T  inner join ' + Result + '1 as T1 on T.Keydata = T1.keydata  Set T.BinQty    = T.binQty    - T1.Qty where T.Category = ' + quotedstr(TPQABins.PQADetailtype) +';');
    SQL.Add('update ' + Result + ' T  inner join ' + Result + '1 as T1 on T.Keydata = T1.keydata  Set T.BatchQty  = T.BatchQty  - T1.Qty where T.Category = ' + quotedstr(TPQABatch.PQADetailtype) +';');
    logtext(sql.Text);
    Execute;
  finally
    Free;
  end;
end;

end.

