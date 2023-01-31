{CompanyInfo}
SELECT 
CO.CompanyName, 
CO.Address, 
CO.Address2, 
CO.City, 
CO.State, 
CO.Postcode, 
Concat('Phone ',CO.PhoneNumber) AS PhoneNumber, 
Concat('Fax ',CO.FaxNumber) AS FaxNumber, 
CO.ABN 
FROM tblCompanyInformation AS CO      
~|||~
{Header}
Select 
T.*  , 
T.ClientPrintName as SupplierPrintName,
C.Phone , 
C.FaxNumber , 
C.AltPhone , 
C.Mobile, 
C.email, 
C.Street , 
C.Street2 , 
C.Suburb , 
C.State , 
C.Postcode ,  
IFNULL(CC.ContactPH,C.Phone) AS ContactPH    ,
IFNULL(`ContactAltPH`,C.AltPhone) AS ContactAltPH ,
IFNULL(`ContactMOB`,C.Mobile) AS ContactMOB   ,
IFNULL(`ContactFax`,C.FaxNumber) AS ContactFax   ,
IFNULL(`ContactEmail`,C.email) AS ContactEmail  
from tblPurchaseOrders T   
inner join tblClients C on T.ClientID = C.ClientID  
Left join tblcontacts CC on CC.ContactID = T.contactID   
~|||~{Details}
Select 
0 as ID, 
space(255) as Groupname, 
0 as PAG_ID,   
space(255) as Column1,  
space(255) as Column2,  
space(255) as Column3,  
space(255) as Column4,  
space(255) as Column5,  
space(255) as Column6,  
space(255) as Column7,  
space(255) as Column8,  
space(255) as Column9,  
space(255) as Column10,  
space(255) as Column11,  
space(255) as xName,  
space(255) as yName,  
space(255) as xValue,  
0 as Sold1, 
0 as Shipped1, 
0 as BO1 , 
space(255) as uom1,  
0 as Sold2, 
0 as Shipped2, 
0 as BO2 , 
space(255) as uom2,  
0 as Sold3, 
0 as Shipped3, 
0 as BO3 , 
space(255) as uom3,  
0 as Sold4, 0 as Shipped4, 
0 as BO4 , 
space(255) as uom4,  
0 as Sold5, 
0 as Shipped5, 
0 as BO5 , 
space(255) as uom5,  
0 as Sold6, 
0 as Shipped6, 
0 as BO6 , 
space(255) as uom6,  
0 as Sold7, 
0 as Shipped7, 
0 as BO7 , 
space(255) as uom7,  
0 as Sold8, 
0 as Shipped8, 
0 as BO8 , 
space(255) as uom8,  
0 as Sold9, 
0 as Shipped9, 
0 as BO9 , 
space(255) as uom9,  
0 as Sold10, 
0 as Shipped10, 
0 as BO10 , 
space(255) as uom10      
~|||~{NonAttribProducts}
Select 
* 
from tblPurchaseLines 
where PurchaseOrderId = 6 and productId not in (Select ProductId from tblproductattributeproducts)   
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
where ifnull(CCV.Value,"")<>""   and CFL.ListType = "ltSupplier"
~|||~{TransComments}
SELECT 
C.CommentsID,
C.Comments  
FROM tblComments C  
inner join tbltranscomments TC on C.CommentsID = TC.CommentID 
