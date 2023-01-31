{CompanyInfo}
SELECT CO.CompanyName, CO.Address, CO.Address2, CO.City,  CO.State, CO.Postcode,   CO.PhoneNumber AS PhoneNumber,  
 CO.FaxNumber AS FaxNumber, CO.ABN    
  FROM tblCompanyInformation AS CO       
  ~|||~{RepairDetails}    
  Select * ,    TotalCostex +TotalAdjusted + TotalBillex as TotalCostEx ,    
  TotalCostinc +TotalAdjusted + TotalBillinc as TotalCostinc ,   
  Totalinc + TotalServicecharge as TotalAmountinc,   
  Totalex + TotalServicecharge as TotalAmountex,   
  InvoiceTotalinc, InvoiceTotalEx    
  from (SELECT C.company, R.RepairID , R.GlobalRef , R.RepairDocNo , R.CreationDate , R.UpdateDate , R.Done , R.Notes , R.FeedbackNotes , R.EditedFlag , R.EnteredBy , R.CustomerDetails , R.Phone , R.AltPhone , R.Fax , R.JobDueDate , R.Converted ,       
  R.Status ,             
  R.BillToCustomerDetails , R.UseBillCust , R.BillPhone , R.BillAltPhone , R.BillFax , R.SOGlobalRef , R.QuoteGlobalRef , R.CustomerPONumber , 
  R.CompletionTime , R.Shipping , R.Terms , R.Mobile , R.BillMobile , R.QuotedAmount , R.QuotedAmountinc , R.HoldRepair , 
  R.CUSTFLD1 , R.CUSTFLD2 , R.CUSTFLD3 , R.CUSTFLD4 , R.CUSTFLD5 , 
  R.CUSTFLD6 , R.CUSTFLD7 , R.CUSTFLD8 , R.CUSTFLD9 , R.CUSTFLD10 , 
  R.CUSTFLD11 , R.CUSTFLD12 , R.CUSTFLD13 , R.CUSTFLD14 , R.CUSTFLD15 , 
  R.CUSTDATE1 , R.CUSTDATE2 , R.CUSTDATE3 , 
  R.DetailsExported , R.CustomerName , R.ClientPrintName , R.BillCustomerName , R.BilltotalPrice , R.Cancelled , R.Area , R.ContractValue , R.SuggestedSalesAmount , 
  R.EstimatedCost , R.Signature , R.SignatureTime,S.SaleDate ,  E.EmployeeName ,    
  (select Sum(PL.`TotalLineAmountInc` )      
  from tblpurchaselines PL 
  inner join  tblpurchaseorders PO on PO.PurchaseOrderID = PL.PurchaseOrderID and PO.IsBill ='T' 
  where PL.repairID=  R.RepairID) as TotalBillinc ,   
  (select Sum(PL.TotalLineAmount )           
  from tblpurchaselines PL 
  inner join  tblpurchaseorders PO on PO.PurchaseOrderID = PL.PurchaseOrderID and PO.IsBill ='T' where PL.repairID=  R.RepairID) as TotalBillEx ,   
  (Select sum(TotalAdjusted)                 
  from tbltimesheetentry TE  
  inner join tbltimesheets T on TE.TimesheetEntryID  = T.TimesheetEntryID 
  where TE.Type = 'Repair' and TE.TypeID = R.RepairID) as TotalAdjusted,   
  (Select sum(TotalServicecharge)            
  from tbltimesheetentry TE  
  inner join tbltimesheets T on TE.TimesheetEntryID  = T.TimesheetEntryID 
  where TE.Type = 'Repair' and TE.TypeID = R.RepairID) as TotalServicecharge,   
  (select sum(TotalAmountInc)                
  from tblsales where IsInvoice = 'T' and Repairglobalref = R.Globalref) as InvoiceTotalinc,  
  (select sum(TotalAmount)                   
  from tblsales where IsInvoice = 'T' and Repairglobalref = R.Globalref) as InvoiceTotalEx,  
  (Select sum(linecost)                      
  from tblrepairparts where RepairID = R.RepairID) as TotalCostEx,   
  (select sum(PriceInc*Qty+Markup-Discount)  
  from tblrepairparts 
  where RepairID = R.RepairID) as TotalInc,   
  (select sum(Linetotalex)                   
  from tblrepairparts 
  where RepairID = R.RepairID) as TotalEx,   
  (Select sum(linecostinc)                   
  from tblrepairparts 
  where RepairID = R.RepairID) as TotalCostinc    
  from tblRepairs   R    
  inner join tblClients as C on R.cusId = C.clientID   
  Left join tblSales S on S.Globalref = R.SOGlobalRef  
  Left join tblemployees E on R.employeeId = E.employeeId  
  where R.RepairId = 1) RepairDatials     
    ~|||~{PartsUsed}
  SELECT RP.RepairID,RP.PartName,RP.Description,RP.PriceEx,RP.PriceInc,  
  RP.TaxCode,RP.TaxRate,RP.Discount,RP.Markup,RP.DiscountPercent,RP.MarkupPercent,RP.LineTotalEx,   
  RP.priceinc*RP.Qty as LinetotalInc, 
  (Rp.priceinc - RP.priceEx)*RP.Qty as LineTotalTax,   
  RP.ClassName,RP.PartType,RP.ETADate,RP.Equipment,RP.UnitofMeasure,RP.UOMQty,RP.PartIssuedOn,RP.Linecost, RP.memoline ,  
  CE.Manufacture, CE.model, CE.Serialno, CE.Registration, 
  P.PurchaseDesc, 
  P.CUSTFLD1,P.CUSTFLD2,P.CUSTFLD3,P.CUSTFLD4,P.CUSTFLD5,
  P.CUSTFLD6,P.CUSTFLD7, P.CUSTFLD8,P.CUSTFLD9,P.CUSTFLD10,
  P.CUSTFLD11,P.CUSTFLD12,P.CUSTFLD13,P.CUSTFLD14,P.CUSTFLD15,P.CUSTDATE1,P.CUSTDATE2,P.CUSTDATE3  
  from tblRepairParts RP  
  Left join tblcustomerequip CE on RP.customerEquipmentId = CE.id  
  inner join tblParts P on P.partsId = RP.partsID  
  where RepairId = 1    
    ~|||~{Equipment}
  SELECT RE.RepairID,RE.Notes,RE.OnSite,RE.Description,  
  RE.CreationDate,RE.Code,RE.CustomField1,RE.CustomField2,RE.CustomField3,  RE.CustomField4,RE.CustomField5,
  RE.CustomField6,RE.CustomField7,  RE.CustomField8,RE.CustomField9,RE.CustomField10,
  RE.WarantyPeriodTaken,  RE.WarantyPeriodLeft,RE.UOM,RE.UOMQty,E.EquipName,E.WarantyPeriod,  
  E.WarantyFinishDate,E.Registration,E.Serialno,E.model,E.Manufacture, RE.VehicleRego_IDNo , 
  RE.VehicleRego_Description ,RE.VehicleRego_PurposeOfUse,RE.VehicleRego_Status , RE.VehicleRego_Expiry   
  FROM tblEquipmentxRef AS RE  
  Inner Join tblcustomerequip AS E 
  ON RE.CustomerEquipmentID = E.id 
  where RepairId = 1    
  ~|||~{Timesheet}
  SELECT TE.TypeID as REpairID,  FormatSecondsTotime(ifnull(T.hours,0)*60*60) as totalTime,   
  T.TimesheetDate,T.EmployeeName,  
  T.LabourCost,T.Hours,T.Total,T.ClassName,T.ServiceName,T.ServiceDate,   
  T.ChargeRate,T.Qty,T.TotalServicecharge,T.Equipment , 
  signature, signaturetime , 
  T.Notes from tbltimesheets T  
  inner join tblTimesheetentry TE   
  on T.TimeSheetEntryId = TE.timesheetEntryID and TE.Type =  'Repair'      
  where TE.TypeID = 1 order by TimesheetDate    
  ~|||~{CustomLabels}
  SELECT if(ifnull(CFLabel1,'')<> '' , CFLabel1,'Custom Field 1') as CF1, 
  if(ifnull(CFLabel2,'')<> '' , CFLabel2,'Custom Field 2') as CF2, 
  if(ifnull(CFLabel3,'')<> '' , CFLabel3,'Custom Field 3') as CF3,
   if(ifnull(CFLabel4,'')<> '' , CFLabel4,'Custom Field 4') as CF4, 
   if(ifnull(CFLabel5,'')<> '' , CFLabel5,'Custom Field 5') as CF5, 
   if(ifnull(CFLabel6,'')<> '' , CFLabel6,'Custom Field 6') as CF6, 
   if(ifnull(CFLabel7,'')<> '' , CFLabel7,'Custom Field 7') as CF7, 
   if(ifnull(CFLabel8,'')<> '' , CFLabel8,'Custom Field 8') as CF8, 
   if(ifnull(CFLabel9,'')<> '' , CFLabel9,'Custom Field 9') as CF9, 
   if(ifnull(CFLabel10,'')<> '' , CFLabel10,'Custom Field 10') as CF10, 
   if(ifnull(CFLabel11,'')<> '' , CFLabel11,'Custom Field 11') as CF11, 
   if(ifnull(CFLabel12,'')<> '' , CFLabel12,'Custom Field 12') as CF12, 
   if(ifnull(CFLabel13,'')<> '' , CFLabel13,'Custom Field 13') as CF13, 
   if(ifnull(CFLabel14,'')<> '' , CFLabel14,'Custom Field 14') as CF14, 
   if(ifnull(CFLabel15,'')<> '' , CFLabel15,'Custom Field 15') as CF15, 
   if(ifnull(CFLabel16,'')<> '' , CFLabel16,'Custom Date 1') as CF16, 
   if(ifnull(CFLabel17,'')<> '' , CFLabel17,'Custom Date 2') as CF17, 
   if(ifnull(CFLabel18,'')<> '' , CFLabel18,'Custom Date 3') as CF18 
   FROM tblcustomfields    ~|||~
   {RepairFaults}
   Select  RepairFault 
   from tblrepairsfaults where RepairID = 1    
   ~|||~{Followups}
   Select * from tblotherfollowup where RepairID = 1