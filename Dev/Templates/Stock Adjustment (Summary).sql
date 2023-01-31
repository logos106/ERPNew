{CompanyInfo}
SELECT CO.CompanyName, 
CO.Address, 
CO.Address2, 
CO.City, 
CO.State, 
CO.Postcode, 
CO.PhoneNumber AS PhoneNumber, 
CO.FaxNumber AS FaxNumber, 
CO.ABN 
FROM tblCompanyInformation AS CO  
~|||~{Details}  
select distinct 
SAL.StockAdjustEntryID , 
ProductId, Productname, 
ClassId, Classname, 
concat(SAL.UOM , '(' , SAL.UOMMultiplier, ')') as UOM,  
SAL.AvailableUOMQty , 
SAL.InStockUOMQty, 
SAL.AdjustUOMQty , 
SAL.FinalUOMQty  
from tblstockadjustentry SA 
inner join tblstockadjustentrylines SAL  on SA.StockAdjustEntryID = SAL.StockAdjustEntryID  
where  ifnull(AdjustQty,0) <> 0    
order by productname, classname, uom