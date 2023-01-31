{COmpanyInfo}
Select * 
from tblCompanyInformation  
~|||~{Detail} 
SELECT   
PBin.Binlocation, 
PBin.binnumber,
PQABatch.Value as batchno,   
PQABatch.ExpiryDate,   
'' as serialnumber, 
sum(if (ifnull(PQABins.PQADEtailID,0)=0 , PQABatch.UOMQty , PQABins.UOMQty)) as BinQty,   
GROUP_CONCAT(PQASN.Value) as SoldSerials, 
SAL.ACCOUNTID,
SAL.ACCOUNTNAME,
SAL.PRODUCTID,
SAL.PRODUCTNAME,  
SAL.DESCRIPTION,
SAL.CLASSID,
SAL.CLASSNAME,
SAL.AVAILABLEUOMQTY,  
SAL.FINALUOMQTY,
SAL.ADJUSTUOMQTY,
SAL.COST,SAL.UOM,
SAL.UOMMULTIPLIER, 
SA.CreationDate,
SA.Adjustmentdate,
SA.AccountID AS HAccountID,  
SA.Accountname AS HAccountName,
SA.Notes,
SA.IsStocktake,  
SA.Employee,
SA.Deleted,
SA.Processed,
SAL.InStockQty ,   
SAL.Cost * SAL.AdjustQty as TotalLineCost, 
SAL.Notes as LineNotes
FROM `tblParts` as P  
inner join `tblpqa` as PQA on PQA.ProductId = P.PartsID   and ((P.multiplebins = 'F' and P.Batch='F' and P.SNTracking = 'F') OR (PQA.PQAID in (Select PQAID from `tblpqadetails`)))  
inner join `tblclass` as C on PQA.departmentID = C.ClassID   
Inner join `tblProductClasses` as PC on PC.ProductID = PQA.ProductID and PC.ClassID = PQA.departmentID  
left join `tblpqadetails` PQABatch  on PQABatch.PQAId  = PQA.PQAID and PQABatch.PQAType = 'Batch'  and PQABatch.Active= 'T'  
left join `tblpqadetails` PQABins  on PQABins.PQAId  = PQA.PQAID   and PQABins.PQAType = 'Bin' and PQABins.Active = 'T' and ( (PQABatch.globalref = IFNULL(PQABins.ParentRef,'') and P.Batch='T' and P.multiplebins = 'T')  or (ifnull(PQABins.Parentref ,'') = '' AND P.Batch='F' and P.multiplebins = 'T'))  
Left join `tblProductBin` PBin     on PBin.binId  = PQABins.BinID  
left join `tblpqadetails` PQASN    on (PQASN.PQAId  = PQA.PQAID and PQASN.PQAType = 'SN'   and PQASN.Active = 'T' and PQASN.Qty <> 0  and ((PQABatch.globalref = IFNULL(PQASN.ParentRef,'') and P.Batch='T' and P.multiplebins = 'F' and P.SNTracking = 'T') or (PQAbins.Globalref = IFNULL(PQASn.ParentRef,'') and P.Multiplebins = 'T' and P.SNTracking = 'T')  or ((ifnull(PQASN.Parentref ,'') = '') and P.Batch='F' and P.Multiplebins = 'F' and P.SNTracking = 'T')))   
inner join tmp_saeProducts as SAL on SAL.StockAdjustEntryID = PQA.TransID and SAL.StockAdjustEntryLinesID = PQA.TransLineId and PQA.TRanstype = 'TSAELinestree' 
inner join tblstockadjustentry as SA   on SA.StockAdjustEntryID = SAL.StockAdjustEntryID 
WHERE SA.StockAdjustEntryID= 2801 
Group by  SAL.STOCKADJUSTENTRYLINESID, PQABatch.Value , PQABatch.ExpiryDate, PBin.binnumber,PBin.Binlocation, SAL.ProductId