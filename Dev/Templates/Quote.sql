{SQL}
SELECT     
P.Hyperlink as ProductHyperlink, 
e.WorkPhone,CONCAT_WS(' ', d4.Title, d4.FirstName,d4.LastName) as CompanyContact,      
concat_ws('-', d3.Productname, if(length(d3.SalesLinesCustField1)<=0 , null , d3.SalesLinesCustField1)) as ProductnamenCustFld1,
concat_ws('-', d3.ProductPrintName, if(length(d3.SalesLinesCustField1)<=0 , null , d3.SalesLinesCustField1)) as PrintProductnamenCustFld1,
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.UnitofMeasureSaleLines) as UnitofMeasure,        
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.UnitofMeasureShipped) as UnitofMeasureShipped,   
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.UnitofMeasureBackorder) as UnitofMeasureBackorder,     
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.TotalLineAmount/d3.UnitofMeasureShipped) as UnitofMeasureLinePrice,        
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.TotalLineAmountInc/d3.UnitofMeasureShipped) as UnitofMeasureLinePriceInc,    
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), '*', d3.ProductName) as ProductName,  
(d3.TotalLineAmountInc*1.55) as LineCalc,          
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.Shipped) as Shipped,          
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.BackOrder) as BackOrder,            
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.Product_Description) as Product_Description,      
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.LinePrice) as LinePrice,            
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.LineTax) as LineTax,          
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.TotalLineAmountInc) as TotalLineAmountInc,           
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.Shipped) as QtySold,           
d1.CompanyName, 
d1.tradingname as CompanyTA, 
d1.Address as CompanyAddress, 
d1.Address2 as CompanyAddress2, 
d1.Address3 as CompanyAddress3, 
d1.City as CompanyCity, 
d1.State as CompanyState, 
d1.Postcode as CompanyPC,  
Concat('Phone ', d1.PhoneNumber), Concat('Fax ', d1.FaxNumber), d1.ABN,  d1.phonenumber as CompanyPhone, 
d1.faxnumber as CompanyFax,   
d2.*, 
Concat('S-',D2.SaleId) as SaleBarcode, 
d4.Printname as Printname, 
d3.*,
d3.orglineprice+ d3.orglineprice* d3.linetaxrate as orglinepriceinc,
d3.OrgLinePrice*d3.Shipped as TotalOrgLinePrice , 
(d3.OrgLinePrice*d3.Shipped) + (d3.OrgLinePrice*d3.Shipped * d3.LineTaxRate) as TotalOrgLinePriceINC  , 
d3.QtySold* d3.ForeignCurrencyLinePrice as EstForeingPrice, 
d3.ForeignExchangeSellRate * d3.LineCost as FXCost, 
d3.OrgLinePrice * d3.Shipped as TotalOrglinePrice,
d3.OrgLinePrice * d3.Shipped+ d3.OrgLinePrice * d3.Shipped * d3.LineTaxRate as TotalOrglinePriceInc,
d3.OrgLinePrice * d3.QtySold as TotalOrgEstlinePrice,
d3.OrgLinePrice * d3.QtySold+ d3.OrgLinePrice * d3.QtySold * d3.LineTaxRate as TotalOrgEstlinePriceInc, 
FESL.Field1 as FormulaValue1, 
FESL.Field2 as FormulaValue2, 
FESL.Field3 as FormulaValue3, 
FESL.Field4 as FormulaValue4, 
FESL.Field5 as FormulaValue5, 
(Select FormulaEntryName from tblfenames where FormulaEntryId = 1) as Formulaname1,
(Select FormulaEntryName from tblfenames where FormulaEntryId = 2) as Formulaname2,
(Select FormulaEntryName from tblfenames where FormulaEntryId = 3) as Formulaname3,
(Select FormulaEntryName from tblfenames where FormulaEntryId = 4) as Formulaname4,
(Select FormulaEntryName from tblfenames where FormulaEntryId = 5) as Formulaname5,    
Concat(d4.FirstName, ' ', d4.LastName) as 'Contact',  
d4.Phone as CustPhone, 
d4.altphone as CustAltPhone, 
d4.altcontact, 
d4.mobile as CustMobile, 
d4.contact1, 
d4.contact2, 
d4.contact1phone, 
d4.contact2phone, 
d4.FaxNumber, 
d4.Street as 'Cust Street',  
d4.Street2 as 'Cust Street2', 
d4.Suburb as 'Cust Suburb', 
d4.State as 'Cust State', 
d4.Postcode  as  'Cust Postcode' , 
d4.Country as CustCountry,   
d4.BillCountry as CustBillCountry,    
(Price1+(Price1*LineTaxRate)) as OrgLinePriceInc,    
If(InStr(P.PRODUCTGROUP,'^') -1 >0,Left(P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')-1),P.PRODUCTGROUP) AS PartHeader,     
MID(P.PRODUCTGROUP, InStr(P.PRODUCTGROUP,'^')+1 ,If(LOCATE('^',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')+1) - InStr(P.PRODUCTGROUP,'^') >0,LOCATE('^',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')+1)-1 - InStr(P.PRODUCTGROUP,'^'), IF(InStr(P.PRODUCTGROUP,'^')<>0,CHAR_LENGTH(P.PRODUCTGROUP) - InStr(P.PRODUCTGROUP,'^'),0)))  AS PartSubLevel1,      
If((LOCATE('^',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')+1)) >0, MID(P.PRODUCTGROUP,LOCATE('^',P.PRODUCTGROUP, InStr(P.PRODUCTGROUP,'^')+1)+1,CHAR_LENGTH(P.PRODUCTGROUP)- LOCATE('^',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')+1)),  Null)  AS PartSubLevel2,      
d1.Email as CompanyEmail, 
ct.contactemail as ContEmail,
concat_Ws(' ' , pc.ContactTitle , pc.ContactFirstName , pc.ContactSurName) as Primarycontact,  
d1.URL as CompanyURL,
P.Barcode,
P.Productcode,   
UOM.Height  as Height, 
UOM.Width  as Width, 
UOM.Length  as Length, 
UOM.Weight  as Weight, 
UOM.Volume  as Volume,  
d3.UnitofMeasureShipped * UOM.Length as shippedLength,  
d3.UnitofMeasureShipped * UOM.Weight as shippedWeight,
d4.Manufacture , 
d4.JobRegistration , 
d4.Colour , 
d4.BodyType , 
d4.SerialNumber , 
d4.InsuranceCompanyName , 
d4.JobNumber , 
d4.ExcessAmount, 
d4.CustomerJobNumber , 
d4.Jobname  , 
SUBSTRING_INDEX( d4.company,'^',1) as Company_NoJobName , 
d4.ModelNumber, 
@LineCount := @LineCount + 1 AS LineCount, 
AmountToWords(d2.TotalAmount) as TotalAmountInWords, 
AmountToWords(d2.TotalAmountInc) as TotalAmountIncInWords,  
SaleLinePriceIncRelatedEx(d3.GlobalRef) as LinePriceIncRelatedEx,
SaleLinePriceIncRelatedInc(d3.GlobalRef) as LinePriceIncRelatedInc,
SaleTotalLineIncRelatedEx(d3.GlobalRef) as TotalLineIncRelatedEx,           
SaleTotalLineIncRelatedInc(d3.GlobalRef) as TotalLineIncRelatedInc           
FROM tblCompanyInformation d1, (SELECT @LineCount := 0) dummy, tblSales d2              
INNER JOIN tblSalesLines d3 Using(SaleID)   
Left join (tblfesaleslines FESL 
inner join tblfesaleslinesrelatedprs  FESLR on FESLR.FESalesLineID = FESL.FESalesLineID) on FESL.SaleLineID = d3.SaleLineID and FESLR.ProductID = D3.productId                 
INNER JOIN tblparts P on d3.ProductID=PartsID            
INNER JOIN tblunitsofmeasure UOM on UOM.UnitID = d3.UnitOfMeasureID    
LEFT JOIN tblrelatedparts AS d5 on (d3.ProductID=d5.ProductID AND d3.RelatedParentProductID=d5.ParentID)               
LEFT JOIN tblcontacts AS ct on (d2.ContactID=ct.ContactID)            
INNER JOIN tblClients as d4 ON d2.ClientID = d4.ClientID    
Left join tblcontacts pc on d4.clientID = pc.ClientID and pc.IsPrimarycontact ='T' and pc.active='T'              
Left join tblemployees e on e.EmployeeID = d2.EmployeeID        
WHERE d2.IsQuote = 'T'      
~|||~{TaxDetails}
Select 
TTCL.`SubTaxCode`, 
TTCL.Percentage,  
Sum(TTCL.`TaxAmount`) as TaxAmount 
from tblsalestaxcodelines TTCL 
inner join tblsalestaxcodes TTC on TTCL.SalesTaxCodeID = TTC.ID     
~|||~{ClientCustomFields}
Select  
CFL.Description , 
CCV.Value 
from  tblsales as Trans  
inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID 
inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId 
where ifnull(CCV.Value,'')<>''  and CFL.ListType = 'ltCustomer'    
~|||~{ShippingAddress}
select 
SA.* 
from tblsales as S 
inner join tblshippingaddress SA on S.ShipToID = SA.ShipAddressID  
~|||~{TransComments}
SELECT 
C.CommentsID,
C.Comments  
FROM tblComments C  
inner join tbltranscomments TC on C.CommentsID = TC.CommentID   
~|||~{StockLevels}  
Select   
PC.ClassID as ClassID,   
PC.ClassName as ClassName,  
P.PartsID as PartsID,    
P.PartName as PartName,  
P.ProductPrintName as ProductPrintName,  
Round(Sum( if(PQA.TransType ='TSalesOrderInvoiceLines'  and PQA.Active ='F' , 0, if(PQA.TransType ='TSalesOrderInvoiceLines'  and PQA.Active ='T' , ifnull(PQA.QTY,0),  if(PQA.Active ='F' and  PQA.alloctype  ='IN' and PQA.TransType in ('TProcProgressIn'), ifnull(PQA.QTY,0),  if(PQA.Active ='F' and  PQA.alloctype  ='IN' and PQA.TransType in ('TProcTreePart','TProcTreePartIN'), ifnull(PQA.QTY,0),  if((PQA.Active ='F') and  (not(PQA.TransType in ('TProcTreePart','TProcTreePartIN')) OR ((PQA.TransType='TProcTreePart') and (PQA.alloctype  ='IN')) ), 0,  if(PQA.TransType  in ('TStockMovementLines')  and PQA.Active ='T'  and PQA.alloctype ='IN' , ifnull(PQA.QTY,0) , if(PQA.TransType  in ('TStockMovementLines')  and PQA.Active ='T'  and PQA.alloctype ='OUT' , 0-ifnull(PQA.QTY,0) , if(PQA.TransType  in ('THireLines')    and PQA.alloctype  ='OUT' and PQA.Active ='T' , 0-ifnull(PQA.QTY,0) , if(PQA.TransType  in ('THireLinesIN')    and PQA.alloctype  ='IN' and PQA.Active ='T' , ifnull(PQA.QTY,0) , if( PQA.alloctype ='IN' and  ifnull(PQA.IsBO , 'F')='F', ifnull(PQA.QTY,0),  if(PQA.alloctype ='OUT' and (PQA.TransType<>'TSalesOrderLine' or ifnull(PQA.IsBO , 'F')='F') ,0-ifnull(PQA.QTY,0),0)))))))))))),5) as   AvailableQty,  
Round(Sum( if(PQA.TransType ='TSalesOrderInvoiceLines'  and PQA.Active ='F' , 0,   if(PQA.TransType ='TSalesOrderInvoiceLines'  and PQA.Active ='T' , ifnull(PQA.QTY,0),  if(PQA.Active ='F' and not (PQA.TransType in ('TPRocProgressIN','TPRocProgressOUT')) , 0,  if(PQA.TransType ='TSalesOrderLine' or ifnull(PQA.IsBO , 'F') ='T',0, if(PQA.TransType ='TPOSLaybyLines' and PQA.Reserved = 'T' ,0 , if(PQA.TransType in ('TStockMovementLines')  and PQA.Active ='T'  and PQA.alloctype ='IN' , ifnull(PQA.QTY,0) , if(PQA.TransType in ('TStockMovementLines')  and PQA.Active ='T'  and PQA.alloctype ='OUT' , 0-ifnull(PQA.QTY,0) , if(PQA.TransType in ('THireLines')    and PQA.alloctype  ='OUT' and PQA.Active ='T' , 0-ifnull(PQA.QTY,0) , if(PQA.TransType in ('THireLinesIN')    and PQA.alloctype  ='IN' and PQA.Active ='T' , ifnull(PQA.QTY,0) , if(PQA.alloctype ='IN'  , ifnull(PQA.QTY,0), 0-ifnull(PQA.QTY,0)))))))))))),5) as   InStockQty,  
Round(Sum(if(PQA.Active ='F' , 0,  if(((PQA.TransType = 'TSalesOrderLine') OR (PQA.TransType = 'TPOSLaybyLines' and PQA.Reserved = 'T')) and (ifnull(PQA.IsBO , 'F') ='F'),ifnull(PQA.QTY,0),  if(PQA.TransType = 'TSalesOrderInvoiceLines' and PQA.alloctype ='IN' , 0-ifnull(PQA.QTY,0),0 )))),5) as   SOQty,  Round(Sum(if(PQA.Active ='F' , 0,  if(PQA.TransType='TSalesOrderLine' and ifnull(PQA.IsBO , 'F') ='T',ifnull(PQA.QTY,0),0))),5) as   SOBOQty,  Round(Sum(if(PQA.Active ='F' , 0,  if(PQA.TransType='TInvoiceLine' and ifnull(PQA.IsBO , 'F') ='T',ifnull(PQA.QTY,0),0))),5) as   BOQty,  
Round(Sum(if(PQA.Active ='F' , 0,  if(PQA.TransType='TPurchaseOrderLine' and ifnull(PQA.IsBO , 'F') ='T',ifnull(PQA.QTY,0),0))),5) as OnOrderQty  
FROM tblsales S   
inner join tblsaleslines SL on S.saleId = SL.saleID  
inner join `tblParts` as P on P.partsId = SL.productId  
Left join `tblProductClasses` as PC on PC.ProductID = P.PartsId  
left join `tblPQA` as PQA on PQA.departmentID = PC.ClassID and PQA.ProductID =PC.ProductID   
left join `tblclass` as C on PQA.departmentID = C.ClassID   
Where PC.ClassID = S.ClassID  
~|||~{ETADetails}  
SELECT   
P.GlobalRef as GlobalRef,  
PL.ProductName as ProductName,   
PL.ProductID as ProductID,   
PL.ETADate as ETADate,  
Round(Round(Sum(if(PQA.Active ='F' , 0,  if(PQA.TransType='TPurchaseOrderLine' and ifnull(PQA.IsBO , 'F') ='T',ifnull(PQA.QTY,0),0))),5), 5) AS Backorder,  
PL.Class AS Classname,   
PL.PurchaseOrderID AS PurchaseOrderID   
FROM tblpurchaselines AS PL  
INNER JOIN tblpurchaseorders AS P on P.PurchaseOrderID = PL.PurchaseOrderID and P.IsPO='T'   
inner join tblPQA PQA  ON `PL`.`PurchaseLineID` = `PQA`.`TransLineID`   AND `PL`.`PurchaseOrderID` = `PQA`.`TransID`    AND `PL`.`PurchaseLineID` = `PQA`.`TransLineID`  and  `PQA`.`TransType`   in ('TPurchaseOrderLine')   and `PQA`.`IsBO` =  'T' and PQA.Active = 'T'  
inner join tblsaleslines SL on SL.productId = PQa.productId  
inner join tblsales S on S.saleId = SL.saleId  
WHERE PL.ClassID = S.ClassID   
~|||~{Packages}  
select   
SL.SaleID as SaleID,  
Pack.SaleLineID as SaleLineID,  
Pack.PackCount as PackCount,  
Pack.AttribValue1 as PackAttribValue1,   
Pack.AttribValue2 as PackAttribValue2,   
Pack.Deleted as Deleted,  
(select if(IfNull(FieldValue,'') <> '',FieldValue,'PackAttrib1')  from tbldbpreferences where Name = 'PackWeightField1') as PackAttribLabel1,  
(select if(IfNull(FieldValue,'') <> '',FieldValue,'PackAttrib2')  from tbldbpreferences where Name = 'PackWeightField2') as PackAttribLabel2  
from tblsaleslinepackweightlines Pack   
inner join tblSalesLines SL on SL.SaleLineID = Pack.SaleLineID   
where Pack.Deleted = 'F'    
