{CompanyInfo}
Select * , 
Concat(Address,' ',Address2,' ',City,' ',tblCompanyInformation.State,' ',tblCompanyInformation.Postcode) AS CompanyAddress 
from tblCompanyInformation     
~|||~{TransDet} 
SELECT 
CO.CompanyName, 
Concat(CO.Address,' ',CO.Address2,' ',CO.City,' ',CO.State,' ',CO.Postcode) AS CompanyAddress,
Concat('Phone',CO.PhoneNumber,' Fax',CO.FaxNumber) AS PhoneFax,        
Concat('ABN ',CO.ABN) AS ABN,  
'%s' AS `AmountInWords`,
'%s' AS `DisplayAmount`,
`W`.`PaymentID`,
`W`.`SupplierID`,
`W`.`Amount`,
`W`.`PayMethodID`,
`W`.`ReferenceNo`,
`W`.`PaymentDate`,  
`COA`.`OpeningBalance`,  
`COA`.`ClosingBalance`,
`W`.`ClassID`,
`W`.`AccountID`,
`W`.`Applied`,
`W`.`UnApplied`,
`W`.`Notes`,  
`WL`.`TrnType`,
`WL`.`OrderDate`,
`WL`.`PONo`,
`WL`.`OriginalAmount`,
`WL`.`AmountDue`,  
`WL`.`AmountOutstanding`,
WL.AmountDue-WL.AmountOutstanding AS `AmountPaid`,
`WL`.`PaidInFull`,
`WL`.`POID`,  
`WL`.`ForeignOriginalAmount`,
`WL`.`ForeignAmountDue`,
`WL`.`ForeignPayment`,
`WL`.`ForeignAmountOutstanding`,
OrderDiscountAmount(WL.POID) as PaymentDiscount,
OrderDiscountPercent(WL.POID) as PaymentDiscountPercent,
'%s' AS `ForeignAmountInWords`,
'%s' AS `ForeignDisplayAmount`,  
`C`.`Company`,
`COA`.`AccountName`,
`CL`.`ClassName`,
PM.`NAME` AS `PayMethod`,  
CONCAT_WS(' ',C.Title,C.FirstName,C.LastName) AS `ClientContactName`,
`C`.`Company` AS `ClientCompany`,  
`C`.`Street` AS `ClientStreet`,
`C`.`Street2` AS `ClientStreet2`,
`C`.`Suburb` AS `ClientSuburb`,  
`C`.`State` AS `ClientState`,
`C`.`Country` AS `ClientCountry`,
`C`.`Postcode` AS `ClientPostcode`,  
`C`.`BillStreet` AS `ClientBillStreet`,
`C`.`BillStreet2` AS `ClientBillStreet2`,
`C`.`BillSuburb` AS `ClientBillSuburb`,  
`C`.`BillState` AS `ClientBillState`,
`C`.`BillCountry` AS `ClientBillCountry`,  
`C`.`BillPostcode` AS `ClientBillPostcode`,
CONCAT_WS(' ',C.Suburb,C.State,C.Postcode) AS `ClientLocation`,  
CONCAT_WS(' ',C.BillSuburb,C.BillState,C.BillPostcode) AS `ClientBillLocation`,
`C`.`Phone`,  
`C`.`FaxNumber`,
`C`.`JobName`,
`C`.`BankAccountName`,
`PO`.`InvoiceNumber`,
PO.InvoiceDate,   
`W`.`ForeignExchangeRate`,
`W`.`ForeignExchangeCode`,
`W`.`ForeignCurrencyAmount`    
FROM tblCompanyInformation CO, `tblwithdrawal` AS `W`    
Left Join `tblwithdrawallines` AS `WL` ON `W`.`PaymentID` = `WL`.`PaymentID`    
Inner Join `tblclients` AS `C` ON `W`.`SupplierID` = `C`.`ClientID` AND '' = ''    
Left Join `tblclass` AS `CL` ON `W`.`ClassID` = `CL`.`ClassID`    
Left Join `tblchartofaccounts` AS `COA` ON `W`.`AccountID` = `COA`.`AccountID`    
Left Join `tblpaymentmethods` PM ON `W`.`PayMethodID` = PM.`PayMethodID`    
Left Join `tblpurchaseorders` AS `PO` ON `WL`.`POID` = `PO`.`PurchaseOrderID`    
~|||~{BlankLines}
Select '' as details 
from DUAL