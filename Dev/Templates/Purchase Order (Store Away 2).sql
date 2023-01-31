{CompanyInfo}
SELECT 
CompanyName, 
Address, 
Address2, 
City, 
State, 
Postcode, 
PhoneNumber AS PhoneNumber, 
FaxNumber AS FaxNumber, 
ABN  
from tblCompanyInformation  
~|||~{PO} 
SELECT 
PO.SupplierName,
PO.ClientPrintName as SupplierPrintName,   
if(ifnull(POL.partbarcode, '') ='', P.BARCODE, POL.partbarcode) as ProductBarCode, 
CL.JobNumber as CustomerJobnumber, 
CL.Company as CustomerJob, 
SUBSTRING_INDEX(CL.Company, '^',1) as Customer, 
Cl.jobname as Customerjobname,  
POL.PurchaselineId, 
PO.InvoiceNumber, 
PO.ETADate, 
PO.OrderDate, 
POL.QtySold,   
if(ifnull(POL.supplierProductCode, '')<>'', POL.supplierProductCode, if(PO.SupplierName =  P.PREFEREDSUPP,   p.supplierProductCode, '') ) as Supplier_ProductCode, 
p.PartName, 
p.PartsDescription,
P.CUSTFLD1 AS ProductCustField1, 
P.CUSTFLD2 AS ProductCustField2, 
P.CUSTFLD3 AS ProductCustField3, 
P.CUSTFLD4 AS ProductCustField4, 
P.CUSTFLD5 AS ProductCustField5, 
P.CUSTFLD6 AS ProductCustField6, 
P.CUSTFLD7 AS ProductCustField7, 
P.CUSTFLD8 AS ProductCustField8, 
P.CUSTFLD9 AS ProductCustField9, 
P.CUSTFLD10 AS ProductCustField10, 
P.CUSTFLD11 AS ProductCustField11, 
P.CUSTFLD12 AS ProductCustField12, 
P.CUSTFLD13 AS ProductCustField13, 
P.CUSTFLD14 AS ProductCustField14, 
P.CUSTFLD15 AS ProductCustField15, 
P.CUSTDATE1 AS ProductCustDate1,
P.CUSTDATE2 AS ProductCustDate2,
P.CUSTDATE3 AS ProductCustDate3,
c.ClassName,  
POL.Shipped, 
pol.backorder,
POL.UnitofMeasurePOLines, 
pol.UnitofMeasureQtySold,
pol.UnitofMeasureShipped, 
pol.UnitofMeasureBackorder, 
concat(POL.UnitofMeasurePOLines, '(', POL.UnitofMeasureMultiplier, ')') as Uom,  
POL.LineCostInc, 
POL.TotalLineAmountInc, 
POL.LineCost, 
POL.TotalLineAmount, 
Concat("PL-",CONVERT(POL.PurchaseLineID, CHAR)) as PurchaseLineBarcode,
POL.CustomField1 AS LineCustomField1,
POL.CustomField2 AS LineCustomField2,
POL.CustomField3 AS LineCustomField3,
POL.CustomField4 AS LineCustomField4,
POL.CustomField5 AS LineCustomField5,
POL.CustomField6 AS LineCustomField6,
POL.CustomField7 AS LineCustomField7,
POL.CustomField8 AS LineCustomField8,
POL.CustomField9 AS LineCustomField9,
POL.CustomField10 AS LineCustomField10,
PO.TotalAmount, 
PO.TotalAmountInc, 
PO.TotalTax,
PO.Comments, 
po.PurchaseOrderNumber, 
PBin.Binlocation, 
PBin.binnumber, 
PQABatch.Value as batchno, 
replace(replace(PQABatch.Value, Left(SUBSTRING_INDEX(PQABatch.Value,concat('PO-',PO.purchaseOrderID, '-'),1),255), ''), concat('PO-',PO.purchaseOrderID, '-'), '')  as RollNo,  
PQABatch.ExpiryDate,   
if(P.Batch='T','Batch Number', '') as BatchnoCaption,  
if(P.Batch='T','Expiry Date', '') as ExpiryDateCaption,  
if(P.Multiplebins='T','Bin Location ', '') as BinLocationCaption,  
if(P.Multiplebins='T','Bin Number ', '') as BinNumberCaption,  
sum(if (ifnull(PQABins.PQADEtailID,0)=0, PQABatch.UOMQty, PQABins.UOMQty)) as Qty, 
CL.Manufacture, 
CL.JobRegistration, 
CL.Colour, 
CL.BodyType, 
CL.SerialNumber, 
CL.InsuranceCompanyName, 
CL.JobNumber, 
CL.ExcessAmount, 
CL.CustomerJobNumber, 
CL.Jobname, 
CL.ModelNumber,  
CL.BillStreet, 
CL.BillStreet2, 
CL.BillStreet3, 
CL.BillSuburb, 
CL.BillState, 
CL.BillCountry, 
CL.BillPostcode,  
Sum(POL.QtySold* POL.ForeignCurrencyLineCost) as EstForeingPrice,  
Sum(POL.QtySold* POL.ForeignCurrencyLineCost + POL.QtySold* POL.ForeignCurrencyLineCost * POL.LineTaxRate) as EstForeignPriceinc, 
Sum(POL.QtySold* POL.LineTaxRate) as EstTax, 
Uom.unitDEscription, 
uom.Weight, 
uom.NoOfBoxes, 
uom.Height, 
uom.Width, 
uom.Length, 
uom.Volume, 
POC.ClientNo as SuppClientNo,
POC.BankAccountName as SuppBankAccountName,
POC.BankLodgementRef as SuppBankLodgementRef,
POC.BankAccountBSB as SuppBankAccountBSB,
POC.BankAccountNo as SuppBankAccountNo,
POC.BankCode as SuppBankCode,
POC.ABN as SuppABN, 
POL.UnitOfMeasureMultiplier * POL.ForeignCurrencyLineCost as ForeignUOMLineCost, 
ifnull((UOM.Weight * POL.UnitofMeasureShipped), 0) as TotalUOM_Weight,
POL.ProductPrintName,
POL.ReceivedDate,
IFNULL(UOM.Volume * POL.UnitOfMeasureShipped,0) AS VolumeShipped,
P.PurchaseDesc AS ProductPurchaseDescription,
Convert(CONCAT(IfNull(POL.CustomField1,""),"-",IfNull(P.CUSTFLD1,""),"-",IfNull(P.CUSTFLD2,""),"-",IfNull(P.CUSTFLD3,""),"-",IfNull(pol.UnitofMeasureShipped,"")), CHAR(1000)) AS CustomBarcode  
FROM tblParts as P 
inner join tblPQA as PQA on PQA.ProductId = P.PartsID   
inner join tblclass as C on PQA.departmentID = C.ClassID   
Left join tblProductClasses as PC on PC.ProductID = PQA.ProductID and PC.ClassID = PQA.departmentID  
left join tblPqaDetails PQABatch  on PQABatch.PQAId  = PQA.PQAID and PQABatch.PQAType = 'Batch'  and PQABatch.Active= 'T'  
left join tblPqaDetails PQABins  on PQABins.PQAId  = PQA.PQAID   and PQABins.PQAType = 'Bin' and PQABins.Active = 'T' and ( (PQABatch.globalref = IFNULL(PQABins.ParentRef,'') and P.Batch='T'   and P.multiplebins = 'T') or (ifnull(PQABins.Parentref, '') = '' AND P.Batch='F' and P.multiplebins = 'T')) 
Left join tblProductBin PBin on PBin.binId  = PQABins.BinID  
inner join tblPurchaseLines POL on POL.PurchaseLineID = PQA.TRansLineID and POL.PurchaseOrderID = PQA.TransID and PQA.TransType ='TPurchaseOrderLine'  
inner join tblpurchaseorders PO on PO.PurchaseOrderID = POL.PurchaseOrderID 
inner join tblclients POC on POC.clientID = PO.clientID   
inner join tblunitsofmeasure UOM on UOM.UnitID = POL.UnitOfMeasureID 
Left join tblclients CL on poL.customerJobId  = cl.clientID   
~|||~{TaxDetails}
Select 
TTCL.`SubTaxCode`, 
TTCL.Percentage, Sum(TTCL.`TaxAmount`) as TaxAmount 
from tblpurchasetaxcodelines TTCL 
inner join tblpurchasetaxcodes TTC on TTCL.PurchaseTaxCodeID = TTC.ID   
~|||~{ClientCustomFields}
Select  
CFL.Description, 
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

