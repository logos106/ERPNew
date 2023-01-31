{SQL}
SELECT     
P.PurchaseDesc,
P.CUSTFLD1 as ProductCUSTFLD1,
P.CUSTFLD2 as ProductCUSTFLD2,
P.CUSTFLD3 as ProductCUSTFLD3,
P.CUSTFLD4 as ProductCUSTFLD4,
P.CUSTFLD5 as ProductCUSTFLD5,
P.CUSTFLD6 as ProductCUSTFLD6,
P.CUSTFLD7 as ProductCUSTFLD7,
P.CUSTFLD8 as ProductCUSTFLD8,
P.CUSTFLD9 as ProductCUSTFLD9,
P.CUSTFLD10 as ProductCUSTFLD10,
P.CUSTFLD11 as ProductCUSTFLD11,
P.CUSTFLD12 as ProductCUSTFLD12,
P.CUSTFLD13 as ProductCUSTFLD13,
P.CUSTFLD14 as ProductCUSTFLD14,
P.CUSTFLD15 as ProductCUSTFLD15,
P.CUSTDATE1 as ProductCUSTDATE1,
P.CUSTDATE2 as ProductCUSTDATE2,
P.CUSTDATE3 as ProductCUSTDATE3,  
P.Productcomment, 
e.WorkPhone,CONCAT_WS(' ', d4.Title, d4.FirstName, d4.LastName) as CompanyContact,        
concat_ws('-', d3.Productname, if(length(d3.SalesLinesCustField1)<=0 , null , d3.SalesLinesCustField1)) as ProductnamenCustFld1 ,
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
CompanyName, 
Address, 
Address2, 
City, 
d1.State, 
d1.Postcode, 
d1.PhoneNumber AS PhoneNumber, 
d1.FaxNumber AS FaxNumber, 
d1.ABN,   
d4.JobName as CustJobName,    
d4.ABN as CustABN,  
d4.Title as CustTitle,        
d4.FirstName as CustFirstName,  
d4.MiddleName as CustMiddleName,    
d4.LastName as CustLastName,    
d4.Street as CustStreet,      
d4.Street2 as CustStreet2,  
d4.Suburb as CustSuburb,    
d4.State as CustState,    
d4.Country as CustCountry,    
d4.Postcode as CustPostcode,  
d4.BillStreet as CustBillStreet,        
d4.BillStreet2 as CustBillStreet2,  
d4.BillSuburb as CustBillSuburb,    
d4.BillState as CustBillState,    
d4.BillCountry as CustBillCountry,  
d4.BillPostcode as CustBillPostcode,      
d4.POBox as CustPOBox,    
d4.POSuburb as CustPOSuburb,  
d4.POState as CustPOState,    
d4.POCountry as CustPOCountry,    
d4.POPostcode as CustPOPostcode,  
d4.Phone as CustPhone,      
d4.FaxNumber as CustFaxNumber,    
d4.Mobile as CustMobile,  
d4.Email as CustEmail,    
d4.AltContact as CustAltContact,    
d4.AltPhone as CustAltPhone, 
d4.ClientNo,      
d4.DeliveryNotes,   
d2.* , 
Concat('S-',D2.SaleId) as SaleBarcode , 
d4.Printname as Printname ,     
(Select Sum(PP.Balance) as TotalBalance from tblSalesPrepayments  SP inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  Where PP.Deleted = 'F' and SP.SalesRef = d2.Globalref ) as Prepayments,   (Select Sum(Sl.totalLineamountinc) as totalLineamountinc from tblsales S inner join tblSaleslines SL on S.SaleId = Sl.SaleId  and SL.Productname = 'Progress Payment' where ifnull(S.SOProgressPaymentGlobalRef,'') = d2.Globalref   and ifnull(S.SOProgressPaymentGlobalRef,'') <> '' ) as ProgressPayments ,   (Select Sum(PP.Balance) TotalBalance from tblSalesPrepayments  SP inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  Where PP.Deleted = 'F' and SP.SalesRef = d2.Globalref or SP.SalesRef = d2.salesorderglobalref) +d2.payment as Totalpayment , 
d2.totalamountinc - (Select Sum(Sl.totalLineamountinc) as totalLineamountinc from tblsales S inner join tblSaleslines SL on S.SaleId = Sl.SaleId  and SL.Productname = 'Progress Payment' where ifnull(S.SOProgressPaymentGlobalRef,'') = d2.Globalref   and ifnull(S.SOProgressPaymentGlobalRef,'') <> '' )   -payment as SOBalanceofProgressPayment  , 
d2.totalamountinc - (Select Sum(PP.Balance) TotalBalance from tblSalesPrepayments  SP inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  Where PP.Deleted = 'F' and SP.SalesRef = d2.Globalref ) -payment as Salesorderbalance, 
d3.*,
d3.orglineprice+ d3.orglineprice* d3.linetaxrate as  orglinepriceinc ,
d3.OrgLinePrice*d3.Shipped as TotalOrgLinePrice, 
(d3.OrgLinePrice*d3.Shipped) + (d3.OrgLinePrice*d3.Shipped * d3.LineTaxRate) as TotalOrgLinePriceINC, 
d3.QtySold* d3.ForeignCurrencyLinePrice as EstForeingPrice, 
d3.ForeignExchangeSellRate * d3.LineCost as FXCost, 
d3.OrgLinePrice * d3.Shipped as TotalOrglinePrice,
d3.OrgLinePrice * d3.Shipped+ d3.OrgLinePrice * d3.Shipped * d3.LineTaxRate as TotalOrglinePriceInc,
d3.OrgLinePrice * d3.QtySold as TotalOrgEstlinePrice,
d3.LinePrice * d3.QtySold as TotalEstBOPrice,
d3.LinePriceInc * d3.QtySold as TotalEstBOPriceInc  , 
d3.LinePrice * d3.QtySold + totalLineamount as TotalEstPrice,
d3.LinePriceInc * d3.QtySold + TotalLineamountinc as TotalEstPriceInc  ,
(d3.LinePriceinc - d3.LinePrice ) * d3.QtySold as TotalEstBOTax,
d3.LinePriceInc * d3.QtySold + linetax as TotalEstTax,  
d3.OrgLinePrice * d3.QtySold+ d3.OrgLinePrice * d3.QtySold * d3.LineTaxRate as TotalOrgEstlinePriceInc  , 
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
(d3.shipped*d3.ForeignCurrencyLinePrice) as TotalForeignCurrencyLinePrice,   
d3.Attrib1SaleRate * d3.Shipped as Attrib1SaleRateShipped, 
d3.Attrib1SaleRate * d3.qtysold as Attrib1SaleRateOrdered,   
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
d4.ModelNumber, if(d3.iscontainer ='T' , 0 , ifnull(d3.UnitofMeasureShipped,0)*ifnull(UOM.Weight,0)) as UOMWeight   ,  
d3.backorder * d3.lineprice as backorderTotallineAmount,   
d3.backorder * d3.linepriceinc as backorderTotallineAmountinc,   
ifnull((Select Sum(SL.backorder*SL.LinePrice) from tblsaleslines SL where SL.saleId = d2.saleId ),0) -  ifnull((Select Sum(PP.Balance) TotalBalance from tblSalesPrepayments  SP inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  Where PP.Deleted = 'F' and SP.SalesRef = d2.Globalref ),0)  as BackorderBalanceEx,   ifnull((Select Sum(SL.backorder*SL.LinePriceinc) from tblsaleslines SL where SL.saleId = d2.saleId ),0) -  ifnull((Select Sum(PP.Balance) TotalBalance from tblSalesPrepayments  SP inner join tblprepayments PP on PP.GlobalRef = SP.PrepayRef  Where PP.Deleted = 'F' and SP.SalesRef = d2.Globalref ),0)  as BackorderBalanceinc    , 
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
INNER JOIN tblClients d4 ON d2.ClientID = d4.ClientID        
Left join tblpartspics pp on ifnull(pp.Isdefault, '') = 'T' and pp.partID = d3.ProductID       
LEFT JOIN tblcontacts AS ct on (d2.ContactID=ct.ContactID)     
Left join tblemployees e on e.EmployeeID = d2.EmployeeID      
WHERE IsSalesOrder = 'T'        
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
from  tblsales Trans  
inner join tblcustomfieldvaluesClients CCV on Trans.ClientID = CCV.MasterID 
inner join tblcustomfieldlist CFL on CFL.CFID = CCV.CustomFieldlistId 
where ifnull(CCV.Value,'')<>'' and CFL.ListType = 'ltCustomer'       
~|||~{ShippingAddress}
select 
SA.* 
from tblsales S 
inner join tblshippingaddress SA on S.ShipToID = SA.ShipAddressID    
~|||~{ShippingDetails}
Select 
* 
from  tblsalesshippingdetails  
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
Round(Sum(if(PQA.Active ='F' , 0,  if(((PQA.TransType = 'TSalesOrderLine') OR (PQA.TransType = 'TPOSLaybyLines' and PQA.Reserved = 'T')) and (ifnull(PQA.IsBO , 'F') ='F'),ifnull(PQA.QTY,0),  if(PQA.TransType = 'TSalesOrderInvoiceLines' and PQA.alloctype ='IN' , 0-ifnull(PQA.QTY,0),0 )))),5) as   SOQty,  
Round(Sum(if(PQA.Active ='F' , 0,  if(PQA.TransType='TSalesOrderLine' and ifnull(PQA.IsBO , 'F') ='T',ifnull(PQA.QTY,0),0))),5) as   SOBOQty,  Round(Sum(if(PQA.Active ='F' , 0,  if(PQA.TransType='TInvoiceLine' and ifnull(PQA.IsBO , 'F') ='T',ifnull(PQA.QTY,0),0))),5) as   BOQty,  
Round(Sum(if(PQA.Active ='F' , 0,  if(PQA.TransType='TPurchaseOrderLine' and ifnull(PQA.IsBO , 'F') ='T',ifnull(PQA.QTY,0),0))),5) as   OnOrderQty  
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
Round(Round(Sum(if(PQA.Active ='F' , 0,  if(PQA.TransType='TPurchaseOrderLine' and ifnull(PQA.IsBO , 'F') ='T',ifnull(PQA.QTY,0),0))),5), 5)   AS Backorder,  
PL.Class AS Classname,   
PL.PurchaseOrderID  AS PurchaseOrderID   
FROM   tblpurchaselines AS PL  
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

