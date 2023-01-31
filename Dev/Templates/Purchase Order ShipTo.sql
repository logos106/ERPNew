{COYINFO}
SELECT   
CO.CompanyName, 
CO.Address, 
CO.Address2, 
CO.City, 
CO.State,   
CO.Postcode, 
CO.PhoneNumber AS PhoneNumber, 
CO.FaxNumber AS FaxNumber, 
CO.ABN     
FROM tblCompanyInformation AS CO  
~|||~{PurchaseDetails}  
SELECT  
e.WorkPhone,
P.*, 
PL.*, 
C.* ,   
Concat("PL-",CONVERT(PL.PurchaseLineID, CHAR)) as PurchaseLineBarcode,
custJob.Manufacture , 
custJob.JobRegistration , 
custJob.Colour , 
custJob.BodyType , 
custJob.SerialNumber , 
custJob.InsuranceCompanyName , 
custJob.JobNumber , 
custJob.ExcessAmount, 
custJob.CustomerJobNumber, 
CL.ClientPrintName as SupplierPrintName,
CL.BillStreet , 
CL.BillStreet2 , 
CL.BillStreet3 , 
CL.BillSuburb , 
CL.BillState , 
CL.BillCountry , 
CL.BillPostcode  , 
Sum(PL.QtySold* PL.ForeignCurrencyLineCost) as EstForeingPrice  ,  
Sum(PL.QtySold* PL.ForeignCurrencyLineCost + PL.QtySold* PL.ForeignCurrencyLineCost * PL.LineTaxRate) as EstForeignPriceinc , 
Sum(PL.QtySold* PL.LineTaxRate) as EstTax ,CL.ClientNo as SuppClientNo,
CL.BankAccountName as SuppBankAccountName,
CL.BankLodgementRef as SuppBankLodgementRef,
CL.BankAccountBSB as SuppBankAccountBSB,
CL.BankAccountNo as SuppBankAccountNo,
CL.BankCode as SuppBankCode,
CL.ABN as SuppABN, 
PL.UnitOfMeasureMultiplier * PL.ForeignCurrencyLineCost as ForeignUOMLineCost, 
ifnull((UOM.Weight * PL.UnitofMeasureShipped), 0) as TotalUOM_Weight   
FROM tblpurchaseorders AS P      
INNER JOIN tblpurchaselines AS PL Using(PurchaseOrderID)  
inner join tblclients CL on CL.ClientID = P.ClientID    
Left join tblemployees e on e.EmployeeID = P.EmployeeID        
LEFT JOIN tblclass AS C on PL.ClassID = C.ClassID        
Left join tblClients Custjob on Custjob.ClientID = PL.CustomerJobID  
inner join tblunitsofmeasure as UOM on UOM.UnitID = PL.UnitOfMeasureID     
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

