{SQL}
SELECT 
concat( if(ifnull(d2.contactID,0)<> 0,concat(d2.CustomerName, ' '),'') , d2.invoiceto) as invoicetowithcomp,   
e.WorkPhone,CONCAT_WS(' ', c.Title, c.FirstName,c.LastName) as CompanyContact,  
e.SkypeName as EmployeeSkypeName,   
e.NextOfKin as EmployeeNextOfKin, 
e.NextOfKinRelationship as EmployeeNextOfKinRelationship, 
e.NextOfKinPhone as EmployeeNextOfKinPhone, 
concat_ws('-', d3.Productname, if(length(d3.SalesLinesCustField1)<=0 , null , d3.SalesLinesCustField1)) as ProductnamenCustFld1,
concat_ws('-', d3.ProductPrintName, if(length(d3.SalesLinesCustField1)<=0 , null , d3.SalesLinesCustField1)) as PrintProductnamenCustFld1,  
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.UnitofMeasureSaleLines) as UnitofMeasure,       
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.UnitofMeasureShipped) as UnitofMeasureShipped,          
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.UnitofMeasureBackorder) as UnitofMeasureBackorder,          
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.TotalLineAmount/d3.UnitofMeasureShipped) as UnitofMeasureLinePrice,              
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.TotalLineAmountInc/d3.UnitofMeasureShipped) as UnitofMeasureLinePriceInc,                  
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), '*' , d3.ProductName) as ProductName,                  
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.Shipped) as Shipped,                  
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.BackOrder) as BackOrder,                  
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.Product_Description) as Product_Description,              
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.LinePrice) as LinePrice,                  
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.LineTax) as LineTax,                 
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.TotalLineAmountInc) as TotalLineAmountInc,                 
IF ((d3.IsRelatedProduct = 'T' AND d5.HideRelated = 'T') OR (P.HideOnPrint = 'T'), NULL, d3.Shipped) as QtySold,   
CompanyName, 
Address, 
Address2, 
City, 
d1.State, 
d1.Postcode,   
d1.POBox as CompanyPOBox, 
d1.POBox2 as CompanyPOBox2, 
d1.POCity as CompanyPOCity,     
d1.POState as CompanyPOState, 
d1.POPostCode as CompanyPOPostCode, 
d1.POCountry as CompanyPOCountry, 
d1.PhoneNumber AS PhoneNumber, 
d1.FaxNumber AS FaxNumber,   
d1.ABN,         
Invoice_Footer, 
(Price1+(Price1*LineTaxRate)) as OrgLinePriceInc, 
(100-DisCountPercent) as RebatePercent ,           
If(InStr(P.PRODUCTGROUP,'^') -1 >0, Left(P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')-1),  P.PRODUCTGROUP) AS PartHeader,       
if(d2.Paid='T','YES','NO') as Paid2,                       
SUBSTRING_INDEX( c.Company,'^',1) as Company_NoJobName,      
P.Price1 as 'ListPrice(Ex)',                 
MID(P.PRODUCTGROUP, InStr(P.PRODUCTGROUP,'^')+1, If(LOCATE('^',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')+1) - InStr(P.PRODUCTGROUP,'^') >0, LOCATE('^',P.PRODUCTGROUP, InStr(P.PRODUCTGROUP,'^')+1)-1 - InStr(P.PRODUCTGROUP,'^'), IF(InStr(P.PRODUCTGROUP,'^')<>0,CHAR_LENGTH(P.PRODUCTGROUP) - InStr(P.PRODUCTGROUP,'^'),0)))  AS PartSubLevel1,              
If((LOCATE('^',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')+1)) >0, MID(P.PRODUCTGROUP,LOCATE('^',P.PRODUCTGROUP, InStr(P.PRODUCTGROUP,'^')+1)+1,CHAR_LENGTH(P.PRODUCTGROUP)-  LOCATE('^',P.PRODUCTGROUP, InStr(P.PRODUCTGROUP,'^')+1)),  Null) AS PartSubLevel2,       
CONCAT_WS(CHAR(13,10), CONCAT_WS(' ', CONCAT_WS(' ', c.Title, c.FirstName), c.LastName), CONCAT_WS(CHAR(13,10), CONCAT_WS(CHAR(13,10), c.Street, IF(ISNULL(c.Street2), '', c.Street2)), CONCAT_WS(CHAR(13,10), CONCAT_WS('  ', CONCAT_WS('  ', c.Suburb, c.State), c.Postcode), c.Country))) AS 'No Company Name', replace(d2.InvoiceTo, concat(ct.Company, char(13), char(10)),'') InvoiceTo_No_contactname, c.Company  as  Company, 
C.Printname as Printname, 
c.ABN as ABN, 
c.Title as Title, 
c.FirstName as FirstName,      
c.MiddleName as MiddleName, 
c.LastName as LastName, 
c.Position as Position,        
c.Street as CustStreet,  
c.Street2 as CustStreet2,  
c.Street3 as CustStreet3,        
c.Suburb as CustSuburb,  
c.State as CustState,  
c.Country as CustCountry,        
c.Postcode as CustPostcode,  
c.BillStreet as BillStreet, 
c.BillStreet2 as BillStreet2,
c.BillStreet3 as BillStreet3,         
c.BillSuburb as BillSuburb, 
c.BillState as BillState, 
c.BillCountry as BillCountry,          
c.BillPostcode as BillPostcode,  
c.POBox as POBox,  
c.POSuburb as POSuburb,  
c.POState as POState,      
c.POCountry as POCountry, 
c.POPostcode as POPostcode, 
c.Phone as Phone,          
c.FaxNumber as FaxNumber, 
c.Mobile as Mobile,  
c.Email as Email, 
c.AltContact as AltContact,      
c.AltPhone as AltPhone,  
c.PhoneSupportTill as PhoneSupportTill, 
c.Contact1 as Contact1,        
c.Contact2 as Contact2, 
c.Contact1Phone as Contact1Phone, 
c.Contact2Phone as Contact2Phone,        
c.CreationDate as CreationDate,  
c.UpdateDate as UpdateDate, 
c.DateInactive as DateInactive,      
c.Notes as Notes, 
c.ClientNo as ClientNo,  
c.JobName as JobName,    
c.CUSTFLD1 as CUSTFLD1, 
c.CUSTFLD2 as CUSTFLD2, 
c.CUSTFLD3 as CUSTFLD3,  
c.CUSTFLD4 as CUSTFLD4,  
c.CUSTFLD5 as CUSTFLD5,          
c.CUSTFLD6 as CUSTFLD6, 
c.CUSTFLD7 as CUSTFLD7,  
c.CUSTFLD8 as CUSTFLD8,  
c.CUSTFLD9 as CUSTFLD9, 
c.CUSTFLD10 as CUSTFLD10,   
c.CUSTFLD11 as CUSTFLD11, 
c.CUSTFLD12 as CUSTFLD12, 
c.CUSTFLD13 as CUSTFLD13, 
c.CUSTFLD14 as CUSTFLD14,  
c.CUSTFLD15 as CUSTFLD15,    
c.DeliveryNotes,    
d2.*, 
Concat('S-',D2.SaleId) as SaleBarcode,     
(Select Sum(PP.Balance) TotalBalance from tblSalesPrepayments SP inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef Where PP.Deleted = 'F' and SP.SalesRef = d2.Globalref or SP.SalesRef = d2.salesorderglobalref) as Prepayments,  
(Select Sum(PP.Balance) TotalBalance from tblSalesPrepayments SP inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef Where PP.Deleted = 'F' and SP.SalesRef = d2.Globalref or SP.SalesRef = d2.salesorderglobalref) +d2.payment as Totalpayment,   
d2.totalamountinc - (Select Sum(PP.Balance) TotalBalance from tblSalesPrepayments SP inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef Where PP.Deleted = 'F' and SP.SalesRef = d2.Globalref or SP.SalesRef = d2.salesorderglobalref) -payment as Invoicebalance, 
d3.*,
d3.orglineprice+ d3.orglineprice* d3.linetaxrate as orglinepriceinc,  
d3.OrgLinePrice*d3.Shipped as TotalOrgLinePrice, 
(d3.OrgLinePrice*d3.Shipped) + (d3.OrgLinePrice*d3.Shipped * d3.LineTaxRate) as TotalOrgLinePriceINC, 
d3.QtySold* d3.ForeignCurrencyLinePrice as EstForeingPrice,  
d3.ForeignExchangeSellRate * d3.LineCost as FXCost, 
d3.OrgLinePrice * d3.Shipped as TotalOrglinePrice,
d3.OrgLinePrice * d3.Shipped+ d3.OrgLinePrice * d3.Shipped * d3.LineTaxRate as TotalOrglinePriceInc,
d3.OrgLinePrice * d3.UnitOfMeasureMultiplier as OrigUOMLinePrice,   
d3.OrgLinePrice * d3.UnitOfMeasureMultiplier * (1 + d3.LineTaxRate) as OrigUOMLinePriceInc, 
d3.LinePrice * d3.UnitOfMeasureMultiplier as UOMLinePrice, 
d3.LinePriceInc * d3.UnitOfMeasureMultiplier as UOMLinePriceInc,  
d3.OrgLinePrice * d3.QtySold TotalOrgEstlinePrice,
d3.LinePrice * d3.QtySold TotalEstBOPrice,d3.LinePriceInc * d3.QtySold as TotalEstBOPriceInc, 
d3.LinePrice * d3.QtySold + totalLineamount TotalEstPrice,d3.LinePriceInc * d3.QtySold + TotalLineamountinc as TotalEstPriceInc,
(d3.LinePriceinc - d3.LinePrice ) * d3.QtySold as TotalEstBOTax,
d3.LinePriceInc * d3.QtySold + linetax as TotalEstTax,  
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
(Select FormulaEntryName from tblfenames where FormulaEntryId = 5) as Formulaname5 ,
d3.backorder*d3.LinePrice as Bakorderamount,     
pp.partpic, 
P.PRODUCTCODE,
P.ProductComment,
P.SupplierProductCode as SuppProdCode,   
(d3.TotalLineAmountInc*1.50) as LineCalc,    
(d3.TotalLineAmountInc*0.50) as TotalSavings,  
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
(d3.shipped*d3.ForeignCurrencyLinePrice) as TotalForeignCurrencyLinePrice,   
d1.Email as CompanyEmail, 
d1.URL as CompanyURL,     
IF(c.IsJob = 'T', IF(C2.StopCredit='T','Yes','No'), IF(c.StopCredit='T','Yes','No')) AS StopCredit,    
(Totaltax-TotalWETTax ) as TotalTaxExWET,
FC.Currency,   
d3.QtySold* d3.LinePrice as EstPriceEx, 
d3.QtySold* d3.LinePriceinc as EstPriceInc, 
d3.LinePrice*d3.QtySold* d3.LineTaxRate as estTax,    
d3.BackOrder* d3.LinePrice as BackOrderPriceEx, 
d3.BackOrder* d3.LinePriceinc as BackOrderPriceInc, 
d3.LinePrice*d3.BackOrder* d3.LineTaxRate as BackOrderTax,     
UOM.Height as Height, 
UOM.Width as Width, 
UOM.Length as Length, 
UOM.Weight as Weight, 
UOM.Volume as Volume,    
d3.UnitofMeasureShipped * UOM.Length as ShippedLength,  
d3.UnitofMeasureShipped * UOM.Weight as ShippedWeight,   
C.Manufacture, 
C.JobRegistration, 
C.Colour, 
C.BodyType, 
C.SerialNumber, 
C.InsuranceCompanyName, 
C.JobNumber, 
C.ExcessAmount, 
C.CustomerJobNumber, 
C.Jobname, 
C.ModelNumber,   
if(d3.iscontainer ='T', 0, ifnull(d3.UnitofMeasureShipped,0)*ifnull(UOM.Weight,0)) as UOMWeight,  
(select Abs(TotalLineAmountInc) from tblsaleslines where SaleID = d2.SaleId and ProductName = 'Total Sale Discount') as TotalSaleDiscount,    
ifnull((Select Sum(SL.backorder*SL.LinePrice) from tblsaleslines SL where SL.saleId = d2.saleId ),0) - ifnull((Select Sum(PP.Balance) TotalBalance from tblSalesPrepayments SP inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  Where PP.Deleted = 'F' and SP.SalesRef = d2.Globalref or SP.SalesRef = d2.salesorderglobalref),0)  as BackorderBalanceEx,     
ifnull((Select Sum(SL.backorder*SL.LinePriceinc) from tblsaleslines SL where SL.saleId = d2.saleId ),0) - ifnull((Select Sum(PP.Balance) TotalBalance from tblSalesPrepayments  SP inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  Where PP.Deleted = 'F' and SP.SalesRef = d2.Globalref or SP.SalesRef = d2.salesorderglobalref),0)  as BackorderBalanceinc, 
@LineCount := @LineCount + 1 AS LineCount, 
AmountToWords(d2.TotalAmount) as TotalAmountInWords, 
AmountToWords(d2.TotalAmountInc) as TotalAmountIncInWords,
SaleLinePriceIncRelatedEx(d3.GlobalRef) as LinePriceIncRelatedEx,
SaleLinePriceIncRelatedInc(d3.GlobalRef) as LinePriceIncRelatedInc,
SaleTotalLineIncRelatedEx(d3.GlobalRef) as TotalLineIncRelatedEx,           
SaleTotalLineIncRelatedInc(d3.GlobalRef) as TotalLineIncRelatedInc           
FROM tblCompanyInformation d1, vinvoicefooterpref d4, (SELECT @LineCount := 0) dummy, tblSales d2                    
INNER JOIN tblSalesLines d3 Using(SaleID)     
Left join (tblfesaleslines FESL 
inner join tblfesaleslinesrelatedprs FESLR on FESLR.FESalesLineID = FESL.FESalesLineID) on FESL.SaleLineID = d3.SaleLineID and FESLR.ProductID = D3.productId                          
INNER JOIN tblparts P on d3.ProductID=P.PartsID                          
INNER JOIN tblunitsofmeasure UOM on UOM.UnitID = d3.UnitOfMeasureID    
INNER JOIN tblclients c on d2.ClientID = c.ClientID               
LEFt join tblcurrencyconversion FC on  FC.Code = d2.ForeignExchangeCode         
LEFT JOIN tblcontacts AS ct on (d2.ContactID=ct.ContactID)               
LEFT JOIN tblClients as C2 on c.ParentClientID = C2.ClientID              
Left join tblpartspics pp on ifnull(pp.Isdefault, '') = 'T' and pp.partID = d3.ProductID              
LEFT JOIN tblrelatedparts AS d5 on (d3.ProductID=d5.ProductID AND d3.RelatedParentProductID=d5.ParentID)                   
Left join tblemployees e on e.EmployeeID = d2.EmployeeID
WHERE d2.SaleID = d3.SaleID            
~|||~{TaxDetails}
Select 
TTCL.`SubTaxCode`, 
TTCL.Percentage,  
Sum(TTCL.`TaxAmount`) as TaxAmount 
from tblsalestaxcodelines TTCL 
inner join tblsalestaxcodes TTC on TTCL.SalesTaxCodeID = TTC.ID         
~|||~{ClientCustomFields}
Select  
CFL.Description, 
CCV.Value 
from tblsales Trans  
inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID 
inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId 
where ifnull(CCV.Value,'') <> '' and CFL.ListType = 'ltCustomer'         
~|||~{EarlyPayment} 
Select 
S.SaleID, 
abs(totallineamountinc) as EarlyPaymentDiscountApplied,
if(ifnull(SL.SaleLineId,0)=0, if(ifnull(T.EarlyPaymentDiscount ,0) = 0, 0, S.totalamountinc*T.EarlyPaymentDiscount/100), 0) as EarlyPaymentDiscount 
from tblSales S 
Left join tblsaleslines SL on Sl.ProductName = 'Early Payment Discount' and SL.sAleId = s.SAleID  
Left join tblterms T on S.Terms = T.Terms         
~|||~{ShippingAddress}
select 
SA.* 
from tblsales S 
inner join tblshippingaddress SA on S.ShipToID = SA.ShipAddressID        
~|||~{ShippingDetails}
Select 
* 
from tblsalesshippingdetails
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
Round(Sum( if(PQA.TransType ='TSalesOrderInvoiceLines' and PQA.Active ='F' , 0, if(PQA.TransType ='TSalesOrderInvoiceLines' and PQA.Active ='T', ifnull(PQA.QTY,0), if(PQA.Active ='F' and PQA.alloctype ='IN' and PQA.TransType in ('TProcProgressIn'), ifnull(PQA.QTY,0), if(PQA.Active ='F' and PQA.alloctype  ='IN' and PQA.TransType in ('TProcTreePart','TProcTreePartIN'), ifnull(PQA.QTY,0),  if((PQA.Active ='F') and (not(PQA.TransType in ('TProcTreePart','TProcTreePartIN')) OR ((PQA.TransType='TProcTreePart') and (PQA.alloctype  ='IN')) ), 0, if(PQA.TransType in ('TStockMovementLines') and PQA.Active ='T'  and PQA.alloctype ='IN' , ifnull(PQA.QTY,0) , if(PQA.TransType  in ('TStockMovementLines')  and PQA.Active ='T'  and PQA.alloctype ='OUT' , 0-ifnull(PQA.QTY,0) , if(PQA.TransType in ('THireLines') and PQA.alloctype  ='OUT' and PQA.Active ='T' , 0-ifnull(PQA.QTY,0) , if(PQA.TransType in ('THireLinesIN') and PQA.alloctype  ='IN' and PQA.Active ='T' , ifnull(PQA.QTY,0) , if( PQA.alloctype ='IN' and ifnull(PQA.IsBO , 'F')='F', ifnull(PQA.QTY,0), if(PQA.alloctype ='OUT' and (PQA.TransType<>'TSalesOrderLine' or ifnull(PQA.IsBO , 'F')='F') ,0-ifnull(PQA.QTY,0),0)))))))))))),5) as AvailableQty,  
Round(Sum( if(PQA.TransType ='TSalesOrderInvoiceLines' and PQA.Active ='F' , 0, if(PQA.TransType ='TSalesOrderInvoiceLines'  and PQA.Active ='T' , ifnull(PQA.QTY,0),  if(PQA.Active ='F' and not (PQA.TransType in ('TPRocProgressIN','TPRocProgressOUT')) , 0,  if(PQA.TransType ='TSalesOrderLine' or ifnull(PQA.IsBO , 'F') ='T',0, if(PQA.TransType ='TPOSLaybyLines' and PQA.Reserved = 'T' ,0 , if(PQA.TransType in ('TStockMovementLines')  and PQA.Active ='T' and PQA.alloctype ='IN' , ifnull(PQA.QTY,0) , if(PQA.TransType in ('TStockMovementLines')  and PQA.Active ='T' and PQA.alloctype ='OUT' , 0-ifnull(PQA.QTY,0) , if(PQA.TransType in ('THireLines') and PQA.alloctype  ='OUT' and PQA.Active ='T', 0-ifnull(PQA.QTY,0), if(PQA.TransType in ('THireLinesIN') and PQA.alloctype  ='IN' and PQA.Active ='T', ifnull(PQA.QTY,0), if(PQA.alloctype ='IN', ifnull(PQA.QTY,0), 0-ifnull(PQA.QTY,0)))))))))))),5) as InStockQty,  
Round(Sum(if(PQA.Active ='F', 0,  if(((PQA.TransType = 'TSalesOrderLine') OR (PQA.TransType = 'TPOSLaybyLines' and PQA.Reserved = 'T')) and (ifnull(PQA.IsBO , 'F') ='F'),ifnull(PQA.QTY,0), if(PQA.TransType = 'TSalesOrderInvoiceLines' and PQA.alloctype ='IN' , 0-ifnull(PQA.QTY,0),0 )))),5) as SOQty,  
Round(Sum(if(PQA.Active ='F' , 0,  if(PQA.TransType='TSalesOrderLine' and ifnull(PQA.IsBO , 'F') ='T',ifnull(PQA.QTY,0),0))),5) as SOBOQty,  
Round(Sum(if(PQA.Active ='F' , 0,  if(PQA.TransType='TInvoiceLine' and ifnull(PQA.IsBO , 'F') ='T',ifnull(PQA.QTY,0),0))),5) as BOQty,  
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
Round(Round(Sum(if(PQA.Active ='F' , 0, if(PQA.TransType='TPurchaseOrderLine' and ifnull(PQA.IsBO , 'F') ='T',ifnull(PQA.QTY,0),0))),5), 5) AS Backorder,  
PL.Class AS Classname,   
PL.PurchaseOrderID AS PurchaseOrderID   
FROM tblpurchaselines AS PL  
INNER JOIN tblpurchaseorders AS P on P.PurchaseOrderID = PL.PurchaseOrderID and P.IsPO='T'   
inner join tblPQA PQA  ON `PL`.`PurchaseLineID` = `PQA`.`TransLineID` AND `PL`.`PurchaseOrderID` = `PQA`.`TransID` AND `PL`.`PurchaseLineID` = `PQA`.`TransLineID` and `PQA`.`TransType` in ('TPurchaseOrderLine') and `PQA`.`IsBO` =  'T' and PQA.Active = 'T'  
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
(select if(IfNull(FieldValue,'') <> '',FieldValue,'PackAttrib1') from tbldbpreferences where Name = 'PackWeightField1') as PackAttribLabel1,  
(select if(IfNull(FieldValue,'') <> '',FieldValue,'PackAttrib2') from tbldbpreferences where Name = 'PackWeightField2') as PackAttribLabel2 
from tblsaleslinepackweightlines as Pack   
inner join tblSalesLines SL on SL.SaleLineID = Pack.SaleLineID   
where Pack.Deleted = 'F'    
