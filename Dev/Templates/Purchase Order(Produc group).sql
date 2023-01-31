SELECT 
e.WorkPhone, 
Concat('Phone ',C.Phone) as 'Phone Number', 
Concat('Fax ',C.FaxNumber) as 'Fax Number' ,  
CompanyName, 
d2.ClientPrintName as SupplierPrintName,
Address, 
Address2,  
d1.City, 
d1.State, 
d1.Postcode, 
d1.PhoneNumber AS CompanyPhone, 
d1.FaxNumber AS CompanyFax, 
d1.ABN,  
C.street as SuppStreet,  
C.street2 as SuppStreet2,  
C.street3 as SuppStreet3,  
C.suburb as SuppSuburb,  
C.state as SuppState,  
C.country as SuppCountry,   
C.postcode as SuppPostcode, 
d2.* , 
C.Printname as Printname,
d3.*, 
Sum(d3.QtySold) as QtySold,   
d3.ProductName,
P.PRODUCTCODE,
P.ProductComment,
P.SupplierProductCode, 
d3.Product_Description,  
Sum(d3.UnitOfMeasureQtySold) as UnitOfMeasureQtySold,
(Sum(d3.QtySold) * d3.LineCostInc) as EstLineCostInc,  
(Sum(d3.QtySold) * d3.LineCost) as EstCostEx,    
((Sum(d3.QtySold) * d3.LineCostInc)-(Sum(d3.QtySold) * d3.LineCost)) as EstTax,     
UnitofMeasurePOLines,    
Concat("PL-",CONVERT(d3.PurchaseLineID, CHAR)) as PurchaseLineBarcode,
P.PURCHASEDESC_Memo as ProductPURCHASEDESC_Memo, 
P.CUSTFLD1 as ProductcustFld1,
P.CUSTFLD2 as ProductcustFld2,
P.CUSTFLD3  as ProductcustFld3,
P.CUSTFLD4 as ProductcustFld4,
P.CUSTFLD5 as ProductcustFld5,
P.CUSTFLD6 as ProductcustFld6,
P.CUSTFLD7 as ProductcustFld7,
P.CUSTFLD8 as ProductcustFld8,
P.CUSTFLD9 as ProductcustFld9,
P.CUSTFLD10 as ProductcustFld10,
P.CUSTFLD11 as ProductcustFld11,
P.CUSTFLD12 as ProductcustFld12,
P.CUSTFLD13 as ProductcustFld13,
P.CUSTDATE1 as ProductcustDate1,
P.CUSTDATE2 as ProductcustDate2,
P.CUSTDATE3 as ProductcustDate3, 
If(InStr(P.PRODUCTGROUP,'^') -1 >0,Left(P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')-1),P.PRODUCTGROUP) AS PartHeader,    
MID(P.PRODUCTGROUP, InStr(P.PRODUCTGROUP,'^')+1 ,  If(LOCATE('^',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')+1) - InStr(P.PRODUCTGROUP,'^') >0,LOCATE('^',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')+1)-1 - InStr(P.PRODUCTGROUP,'^'),  IF(InStr(P.PRODUCTGROUP,'^')<>0,CHAR_LENGTH(P.PRODUCTGROUP) - InStr(P.PRODUCTGROUP,'^'),0))) AS PartSubLevel1,    
If((LOCATE('^',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')+1)) >0, MID(P.PRODUCTGROUP,  LOCATE('^',P.PRODUCTGROUP, InStr(P.PRODUCTGROUP,'^')+1)+1,CHAR_LENGTH(P.PRODUCTGROUP)- LOCATE('^',P.PRODUCTGROUP,  InStr(P.PRODUCTGROUP,'^')+1)),  Null)  AS PartSubLevel2,  
Barcode,
ProductCode,
d1.Email as CompanyEmail, 
d1.URL as CompanyURL   , 
CustJob.JobNumber, 
pp.partpic      ,  
if(ifnull(d3.supplierProductCode , '')<>'' , d3.supplierProductCode , if(d2.SupplierName =  P.PREFEREDSUPP ,   p.supplierProductCode, '') )   as Supplier_ProductCode    ,   
CustJob.Manufacture , 
CustJob.JobRegistration , 
CustJob.Colour , 
CustJob.BodyType , 
CustJob.SerialNumber , 
CustJob.InsuranceCompanyName , 
CustJob.JobNumber , 
CustJob.ExcessAmount, 
CustJob.CustomerJobNumber, 
C.BillStreet , 
C.BillStreet2 , 
C.BillStreet3 , 
C.BillSuburb , 
C.BillState , 
C.BillCountry , 
C.BillPostcode  , 
Sum(d3.QtySold* d3.ForeignCurrencyLineCost) as EstForeingPrice  ,  
Sum(d3.QtySold* d3.ForeignCurrencyLineCost + d3.QtySold* d3.ForeignCurrencyLineCost * d3.LineTaxRate) as EstForeignPriceinc , 
Sum(d3.QtySold* d3.LineTaxRate) as EstTax, 
C.ClientNo as SuppClientNo,
C.BankAccountName as SuppBankAccountName,
C.BankLodgementRef as SuppBankLodgementRef,
C.BankAccountBSB as SuppBankAccountBSB,
C.BankAccountNo as SuppBankAccountNo,
C.BankCode as SuppBankCode,
C.ABN as SuppABN     ,
d3.UnitOfMeasureMultiplier * d3.ForeignCurrencyLineCost as ForeignUOMLineCost  
FROM tblCompanyInformation d1,     tblPurchaseOrders d2       
INNER JOIN tblpurchaselines AS d3 Using(PurchaseOrderID)            
INNER JOIN tblClients C on C.ClientID = d2.ClientID  
Inner JOIN tblparts P on ProductID=P.PartsID        
Left join tblpartspics pp on ifnull(pp.Isdefault, '') = 'T' and pp.partID = P.PartsID         
Left join tblclients CustJob on d3.CustomerJobId = CustJob.clientId        
Left join tblemployees e on e.EmployeeID = d2.EmployeeID          
WHERE d2.PurchaseOrderID = d3.PurchaseOrderID     
~|||~{TaxDetails}
Select 
TTCL.`SubTaxCode`, 
TTCL.Percentage,  
Sum(TTCL.`TaxAmount`) as TaxAmount 
from tblpurchasetaxcodelines TTCL 
inner join tblpurchasetaxcodes TTC on TTCL.PurchaseTaxCodeID = TTC.ID     
~|||~{ClientCustomFields}
Select  
CFL.Description , 
CCV.Value 
from  tblpurchaseorders  Trans  
inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID 
inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId 
where ifnull(CCV.Value,'')<>''   and CFL.ListType = 'ltSupplier'     
~|||~{TransComments}
SELECT 
C.CommentsID,
C.Comments  
FROM tblComments C  
inner join tbltranscomments TC on C.CommentsID = TC.CommentID    
