{COmpanyInfo}
Select * 
from tblCompanyInformation;
~|||~{Detail}
SELECT  
ST.EmployeeName, 
ST.TransferEntryID, 
ST.DateTransferred, 
Notes, 
FromClass.ClassName as 'TransferedFrom', 
ToClass.ClassName as 'TransferedTo', 
ProductName, 
ProductDesc, 
AvailableQty, 
TransferQty, 
UOM,  
UOMTransferQty,  
UOMAvailableQty, 
UOMMultiplier, 
BatchNoFrom as TransferFromBatch, 
expiryDateFrom as TransferFromExpiryDate, 
BinLocationFrom as TransferFromBinLocation, 
BinNumberFrom as TransferFromBinNumber, 
BatchNoTo as TransferToBatch,  
expiryDateTo as TransferToExpiryDate, 
BinLocationTo as TransferTobinLocation, 
BinNumberTo as TransferTobinNumber, 
STL.TransferUOMAllocatedQty, 
case when P.PRODUCTGROUP = '' then 'Unassigned' when P.PRODUCTGROUP is null then 'Unassigned' when InStr(P.PRODUCTGROUP,'^') -1 >0 then  Left(P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')-1) else P.PRODUCTGROUP END  as PartHeader, 
MID(P.PRODUCTGROUP, InStr(P.PRODUCTGROUP,'^')+1 ,  If(LOCATE('^',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')+1) - InStr(P.PRODUCTGROUP,'^') >0, LOCATE('^',P.PRODUCTGROUP,  InStr(P.PRODUCTGROUP,'^')+1)-1 - InStr(P.PRODUCTGROUP,'^'), IF(InStr(P.PRODUCTGROUP,'^')<>0,CHAR_LENGTH(P.PRODUCTGROUP) - InStr(P.PRODUCTGROUP,'^'),0)))  AS PartSubLevel1, 
If((LOCATE('^',P.PRODUCTGROUP,InStr(P.PRODUCTGROUP,'^')+1)) >0,  MID(P.PRODUCTGROUP,LOCATE('^',P.PRODUCTGROUP, InStr(P.PRODUCTGROUP,'^')+1)+1,CHAR_LENGTH(P.PRODUCTGROUP)-  LOCATE('^',P.PRODUCTGROUP,  InStr(P.PRODUCTGROUP,'^')+1)),  Null) AS PartSubLevel2, 
P.CUSTFLD1, 
P.CUSTFLD2, 
P.CUSTFLD3, 
P.CUSTFLD4, 
P.CUSTFLD5, 
P.CUSTFLD6, 
P.CUSTFLD7, 
P.CUSTFLD8, 
P.CUSTFLD9, 
P.CUSTFLD10, 
P.CUSTFLD11, 
P.CUSTFLD12, 
P.CUSTFLD13, 
P.CUSTFLD14, 
P.CUSTFLD15, 
P.CUSTDATE1, 
P.CUSTDATE2, 
P.CUSTDATE3 
FROM tblstocktransferEntry ST 
INNER JOIN tblstocktransferEntrylines STL ON STL.TransferEntryID = ST.TransferEntryID 
INNER JOIN tblClass as FromClass ON FromClass.ClassID = ST.TransferFromClassID 
INNER JOIN tblClass as ToClass ON ToClass.ClassID = STL.ClassIDTo 
INNER JOIN tblParts P on P.PartsId = STL.ProductId
