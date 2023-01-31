{details}
SELECT  
d2.saleId, 
d2.SaleDate , 
CONCAT_WS(' ', c.Title, c.FirstName,c.LastName) as CompanyContact,     
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL,  d3.UnitofMeasureSaleLines) as UnitofMeasure,     
d3.RefundQty ,  
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL,  d3.TotalLineAmount/d3.UnitofMeasureShipped) as UnitofMeasureLinePrice,     
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL,  d3.TotalLineAmountInc/d3.UnitofMeasureShipped) as UnitofMeasureLinePriceInc,        
IF (d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T', '*', d3.ProductName) as ProductName,         
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL,  d3.Product_Description) as Product_Description,     
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL,  d3.LinePrice) as LinePrice,         
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL,  d3.TotalLineAmountInc) as TotalLineAmountInc,   
d3.MemoLine as MemoLine,    
pp.partpic, 
P.PRODUCTCODE,
P.ProductComment,
P.SupplierProductCode as SuppProdCode,   
ct.contactemail as ContEmail, 
ct.contacttitle as ContTitle, 
ct.contactfirstname as ContFirstName, 
ct.contactsurname as ContSurname, 
ct.contactaddress as ContAddress, 
ct.contactaddress2 as ContAddress2, 
ct.contactaddress3 as ContAddress3, 
ct.contactcity as ContCity, 
ct.contactstate as ContState, 
ct.contactpcode as ContPostcode, 
ct.contactcountry as ContCountry, 
ct.contactph as ContPh, 
ct.contactaltph as ContAltPh, 
ct.contactmob as ContMob, 
ct.contactfax as ContactFax,   
If(InStr(P.PRODUCTGROUP,'^') -1 >0,Left(P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')-1),P.PRODUCTGROUP) AS ProductHeader,        
MID(P.PRODUCTGROUP, InStr(P.PRODUCTGROUP,'^')+1 ,If(LOCATE('^',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')+1) - InStr(P.PRODUCTGROUP,'^') >0,LOCATE('^',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')+1)-1 - InStr(P.PRODUCTGROUP,'^'),IF(InStr(P.PRODUCTGROUP,'^')<>0,CHAR_LENGTH(P.PRODUCTGROUP) - InStr(P.PRODUCTGROUP,'^'),0)))  AS ProductSubLevel1,        
If((LOCATE('^',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')+1)) >0, MID(P.PRODUCTGROUP,LOCATE('^',P.PRODUCTGROUP, InStr(P.PRODUCTGROUP,'^')+1)+1,CHAR_LENGTH(P.PRODUCTGROUP)- LOCATE('^',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')+1)),  Null)  AS ProductSubLevel2 ,  
d2.Comments, 
c.*      
FROM tblSales d2 
inner join  tblSalesLines d3 on d2.SaleID = d3.SaleID 
INNER JOIN tblclients c on d2.ClientID = c.ClientID  
Inner JOIN tblparts P on d3.ProductID=PartsID     
LEFT JOIN tblrelatedparts AS d5 on (d3.ProductID=d5.ProductID AND d3.RelatedParentProductID=d5.ParentID)  
Left join tblpartspics pp on ifnull(pp.Isdefault, '') = 'T' and pp.partID = d3.ProductID  
LEFT JOIN tblcontacts AS ct on (d2.ContactID=ct.ContactID)     
WHERE isCustomerReturn = 'T'    
~|||~{ClientCustomFields}
Select  
CFL.Description , 
CCV.Value 
from  tblsales Trans  
inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID 
inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId 
where ifnull(CCV.Value,'')<>''  and CFL.ListType = 'ltCustomer'   
~|||~{CompanyInfo}
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
~|||~{TransComments}
SELECT C.CommentsID,
C.Comments  
FROM tblComments C  
inner join tbltranscomments TC on C.CommentsID = TC.CommentID