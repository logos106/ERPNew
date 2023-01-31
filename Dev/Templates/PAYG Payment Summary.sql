{main}   
tmp_PAYGReport.*, 
tblemployees.*,  
tblemployees.TFN as EmployeeSocialSecurityNo,  
Concat(tblemployees.FirstName,IF(IfNUll(tblemployees.MiddleName,'') <> '',Concat(' ',Left(tblemployees.MiddleName,1)),' '),' ') as FirstNameAndInitial,   
Concat(tblemployees.Street,IF(IfNUll(tblemployees.Street2,'') <> '' ,Concat('',tblemployees.Street2),' '),' ',tblemployees.Suburb,', ',tblemployees.State,' ',tblemployees.PostCode) as EmployeeAddress,  
Concat('PAYG Payment Summary Statement for year ending 30 June ',tmp_PAYGReport.YearEnding) as SummaryTitle     
from tmp_PAYGReport  
inner join tblemployees on tblemployees.EmployeeID = tmp_PAYGReport.EmployeeID  
~|||~  {CompanyInfo}  
SELECT 
CO.CompanyName, 
CO.Address, 
CO.Address2, 
CO.City, 
CO.State, 
CO.Postcode,   
Concat('Phone ',CO.PhoneNumber) AS PhoneNumber,   
Concat('Fax ',CO.FaxNumber) AS FaxNumber,   
CO.ABN, CO.ABN as EmployerIdentificationNumber,  
Concat(CO.CompanyName,' ',CO.Address,IF(IfNUll(CO.Address2,'') <> '' ,Concat(' ',CO.Address2),' '),' ',CO.City,', ',CO.State,' ',CO.PostCode) as EmployeerNameAndAddress  
FROM tblCompanyInformation AS CO