{CompanyInfo}
SELECT 
CO.CompanyName, 
CO.Address, 
CO.Address2, 
CO.City, 
CO.State, 
CO.Postcode, 
Concat('Phone  ',CO.PhoneNumber) AS PhoneNumber, 
Concat('Fax ',CO.FaxNumber) AS FaxNumber, 
CO.ABN   
FROM     tblCompanyInformation AS CO    
~|||~ {Barcodes} 
SELECT 
'RECEIPT-PROCESS' as ReceiptProcess,
'RECEIPT-NEW' as ReceiptNew   
