unit ExportDataDefs;

interface

uses SysUtils;

procedure UpdateAllExportDataDefs;
procedure UpdateExportDataClientsAll;
procedure UpdateExportDataCustomers;
procedure UpdateExportDataCustomerTransactions;
procedure UpdateExportDataProductsAll;
procedure UpdateExportDataPurchases;
procedure UpdateExportDataSales;
procedure UpdateExportDataStockQtys;
procedure UpdateExportDataSuppliers;
procedure UpdateExportDataSupplierTransactions;
procedure UpdateExportDataTransactionsAll;

implementation

uses
  Dialogs, tcTypes, tcDataUtils;

procedure UpdateAllExportDataDefs;
begin
  UpdateExportDataClientsAll;
  UpdateExportDataCustomers;
  UpdateExportDataCustomerTransactions;
  UpdateExportDataProductsAll;
  UpdateExportDataPurchases;
  UpdateExportDataSales;
  UpdateExportDataStockQtys;
  UpdateExportDataSuppliers;
  UpdateExportDataSupplierTransactions;
  UpdateExportDataTransactionsAll;
end;

procedure UpdateExportDataClientsAll;
var
  ExportRec: TExportRec;
begin
  ExportRec.TableName := 'Clients';
  ExportRec.TableDescription := 'Client list';
  ExportRec.SQL := 'SELECT tblclients.GlobalRef, tblclienttype.TypeName, tblclients.Company, ' +
    'tblclients.ABN, tblclients.Title, tblclients.FirstName, ' +
    'tblclients.MiddleName, tblclients.LastName, tblclients.Position, ' +
    'tblclients.Street, tblclients.Street2, tblclients.Suburb, ' +
    'tblclients.State, tblclients.Country, tblclients.Postcode, ' +
    'tblclients.BillStreet, tblclients.BillStreet2, tblclients.BillSuburb, ' +
    'tblclients.BillState, tblclients.BillCountry, tblclients.BillPostcode, ' +
    'tblclients.POBox, tblclients.POSuburb, tblclients.POState, ' +
    'tblclients.POCountry, tblclients.POPostcode, tblclients.Phone, ' +
    'tblclients.FaxNumber, tblclients.Mobile, tblclients.Email, ' +
    'tblclients.AltContact, tblclients.AltPhone, tblclients.PhoneSupportTill, ' +
    'tblclients.Contact1, tblclients.Contact2, tblclients.Contact1Phone, ' +
    'tblclients.Contact2Phone, tblclients.CreationDate, tblclients.UpdateDate, ' +
    'tblclients.DateInactive, tblclients.Notes, tblclients.ClientNo, ' +
    'tblclients.TYPE, tblclients.CreditLimit, tblclients.Balance, ' +
    'tblclients.SOBalance, tblclients.ShippingMethod, tblclients.Discount, ' +
    'tblclients.SpecialDiscount, tblclients.JobName, tblclients.JobRegistration, ' +
    'tblclients.WarrantyFinishDate, tblclients.HoursTakenForJob, ' +
    'tblclients.IsJob, tblclients.CUSTFLD1, tblclients.CUSTFLD2, ' +
    'tblclients.CUSTFLD3, tblclients.CUSTFLD4, tblclients.CUSTFLD5, ' +
    'tblclients.CUSTFLD6, tblclients.CUSTFLD7, tblclients.CUSTFLD8, ' +
    'tblclients.CUSTFLD9, tblclients.CUSTFLD10, tblclients.CUSTFLD11, ' +
    'tblclients.CUSTFLD12, tblclients.CUSTFLD13, tblclients.CUSTFLD14, ' +
    'tblclients.CUSTFLD15, tblclients.Feedback, tblclients.Customer, ' +
    'tblclients.Supplier, tblclients.OtherContact, tblclients.OtherContactType, ' +
    'tblclients.RepName, tblclients.Action, tblclients.Global, ' +
    'tblclients.Done, tblclients.DateEntered, tblclients.Active, ' +
    'tblclients.EditedFlag, tblclients.CorrespondenceMethod, tblclients.DontContact, ' +
    'tblclients.CompletionDate, tblclients.ShipTime, tblclients.GracePeriod, ' +
    'tblclients.LastContactDate, tblclients.LoyaltyValue, tblclients.LastSaleDate, ' +
    'tblclients.AccountNo, tblclients.URL, ' + 'tblclients.StopCredit, tblclients.ForcePOOnBooking, tblclients.ForcePOOnInvoice, ' +
    'tblclients.PickingPriority, tblclients.LoyaltyDateSaleDays, ' +
    'tblclients.LoyaltyDateAmount, tblclients.LoyaltyDateAppointDays, ' +
    'tblclients.GroupDiscountOverridesAll, tblclients.DefaultClass, ' +
    'tblclients.ForeignExchangeSellCode, tblclients.Area, tblclients.DischargeDate, ' +
    'tblclients.UseInvBase, tblclients.InvBaseNumber, tblclients.ApprovalFromDate, ' +
    'tblclients.ApprovalToDate, tblclients.ReminderDateTime, ' + 'tblclients.SpecialInstructions, tblclients.DeliveryNotes, ' +
    'tblclients.Manufacture, tblclients.ModelNumber, tblclients.Tasks, ' +
    'tblclients.DefaultContactMethod, tblclients.LastUpdated, tblclients.WarrantyPeriod ' +
    'FROM tblclients ' + 'LEFT JOIN tblclienttype ON tblclients.ClientTypeID = tblclienttype.ClientTypeID';

  UpdateExportDataRec(ExportRec);
end;

procedure UpdateExportDataCustomers;
var
  ExportRec: TExportRec;
begin
  ExportRec.TableName := 'Customers';
  ExportRec.TableDescription := 'Customer list';
  ExportRec.SQL := 'SELECT tblclients.GlobalRef, tblclienttype.TypeName, tblclients.Company, ' +
    'tblclients.ABN, tblclients.Title, tblclients.FirstName, ' +
    'tblclients.MiddleName, tblclients.LastName, tblclients.Position, ' +
    'tblclients.Street, tblclients.Street2, tblclients.Suburb, ' +
    'tblclients.State, tblclients.Country, tblclients.Postcode, ' +
    'tblclients.BillStreet, tblclients.BillStreet2, tblclients.BillSuburb, ' +
    'tblclients.BillState, tblclients.BillCountry, tblclients.BillPostcode, ' +
    'tblclients.POBox, tblclients.POSuburb, tblclients.POState, ' +
    'tblclients.POCountry, tblclients.POPostcode, tblclients.Phone, ' +
    'tblclients.FaxNumber, tblclients.Mobile, tblclients.Email, ' +
    'tblclients.AltContact, tblclients.AltPhone, tblclients.PhoneSupportTill, ' +
    'tblclients.Contact1, tblclients.Contact2, tblclients.Contact1Phone, ' +
    'tblclients.Contact2Phone, tblclients.CreationDate, tblclients.UpdateDate, ' +
    'tblclients.DateInactive, tblclients.Notes, tblclients.ClientNo, ' +
    'tblclients.TYPE, tblclients.CreditLimit, tblclients.Balance, ' +
    'tblclients.SOBalance, tblclients.ShippingMethod, tblclients.Discount, ' +
    'tblclients.SpecialDiscount, tblclients.WarrantyFinishDate, ' +
    'tblclients.HoursTakenForJob, tblclients.CUSTFLD1, tblclients.CUSTFLD2, ' +
    'tblclients.CUSTFLD3, tblclients.CUSTFLD4, tblclients.CUSTFLD5, ' +
    'tblclients.CUSTFLD6, tblclients.CUSTFLD7, tblclients.CUSTFLD8, ' +
    'tblclients.CUSTFLD9, tblclients.CUSTFLD10, tblclients.CUSTFLD11, ' +
    'tblclients.CUSTFLD12, tblclients.CUSTFLD13, tblclients.CUSTFLD14, ' +
    'tblclients.CUSTFLD15, tblclients.Feedback, tblclients.OtherContact, ' +
    'tblclients.OtherContactType, tblclients.RepName, tblclients.Action, ' +
    'tblclients.Global, tblclients.Done, tblclients.DateEntered, ' +
    'tblclients.Active, tblclients.EditedFlag, tblclients.CorrespondenceMethod, ' +
    'tblclients.DontContact, tblclients.CompletionDate, tblclients.ShipTime, ' +
    'tblclients.GracePeriod, tblclients.LastContactDate, tblclients.LoyaltyValue, ' +
    'tblclients.LastSaleDate, tblclients.URL, tblclients.StopCredit, tblclients.ForcePOOnBooking, ' +
    'tblclients.ForcePOOnInvoice, tblclients.PickingPriority, ' +
    'tblclients.LoyaltyDateSaleDays, tblclients.LoyaltyDateAmount, ' +
    'tblclients.LoyaltyDateAppointDays, tblclients.GroupDiscountOverridesAll, ' +
    'tblclients.DefaultClass, tblclients.ForeignExchangeSellCode, ' +
    'tblclients.Area, tblclients.DischargeDate, tblclients.UseInvBase, ' +
    'tblclients.InvBaseNumber, tblclients.ApprovalFromDate, ' + 'tblclients.ApprovalToDate, tblclients.ReminderDateTime, ' +
    'tblclients.SpecialInstructions, tblclients.DeliveryNotes, ' +
    'tblclients.Manufacture, tblclients.ModelNumber, tblclients.Tasks, ' +
    'tblclients.DefaultContactMethod, tblclients.LastUpdated, ' + 'tblclients.WarrantyPeriod ' +
    'FROM tblclients INNER JOIN' + ' tblclienttype ON tblclients.ClientTypeID = tblclienttype.ClientTypeID ' +
    'WHERE tblclients.Customer = "T"';

  UpdateExportDataRec(ExportRec);
end;

procedure UpdateExportDataCustomerTransactions;
var
  ExportRec: TExportRec;
begin
  ExportRec.TableName := 'CustomerTransactions';
  ExportRec.TableDescription := 'Customer Transactions List';
  ExportRec.SQL := 'SELECT tbltransactions.Date AS TransactionDate, tbltransactions.Type, ' +
    'tbltransactions.GlobalRef, tbltransactions.AccountName, ' + 'tbltransactions.AccountType, tbltransactions.ClientName, ' +
    'tbltransactions.ProductName, tbltransactions.ProductDesc, ' + 'tbltransactions.RepName, tbltransactions.TaxCode, ' +
    'tbltransactions.TaxRate, tbltransactions.DebitsEx, ' + 'tbltransactions.CreditsEx, tbltransactions.DebitsInc, ' +
    'tbltransactions.CreditsInc, tbltransactions.Reconciled, ' + 'tbltransactions.Notes ' +
    'FROM tbltransactions INNER JOIN' + ' tblclients ON tbltransactions.ClientID = tblclients.ClientID ' +
    'WHERE tblclients.Customer = "T"';

  UpdateExportDataRec(ExportRec);
end;

procedure UpdateExportDataProductsAll;
var
  ExportRec: TExportRec;
begin
  ExportRec.TableName := 'Products';
  ExportRec.TableDescription := 'Product List';
  ExportRec.SQL := 'SELECT tblparts.GlobalRef, tblparts.PARTNAME, tblparts.PARTSDESCRIPTION, ' +
    'tblparts.PURCHASEDESC, tblparts.PARTTYPE, tblparts.PRODUCTGROUP, ' +
    'tblparts.INCOMEACCNT, tblparts.ASSETACCNT, tblparts.COGSACCNT, ' +
    'tblparts.TAXCODE, tblparts.PURCHTAXCODE, tblparts.PREFEREDSUPP, ' +
    'tblparts.SpecialDiscount, tblparts.MultipleBins, tblparts.Batch, ' +
    'tblparts.AutoBatch, tblparts.AutoReorder, tblparts.BuyQTY1, ' + 'tblparts.BuyQTY2, tblparts.BuyQTY3, tblparts.COST1, ' +
    'tblparts.COST2, tblparts.COST3, tblparts.AvgCost, ' + 'tblparts.SellQTY1, tblparts.SellQTY2, tblparts.SellQTY3, ' +
    'tblparts.PRICE1, tblparts.PRICE2, tblparts.PRICE3, ' + 'tblparts.OrgPrice1, tblparts.OrgPrice2, tblparts.OrgPrice3, ' +
    'tblparts.WHOLESALEPRICE, tblparts.Active, tblparts.EditedFlag, ' +
    ' tblparts.OrderTime, ' +
    'tblparts.ManufactureTime, tblparts.OverrunTime, tblparts.Duration, ' +
    'tblparts.ProductComment, tblparts.Attrib1Sale, tblparts.Attrib2Sale, ' +
    'tblparts.Attrib1SaleRate, tblparts.Attrib1Purchase, tblparts.Attrib2Purchase, ' +
    'tblparts.Attrib1PurchaseRate, tblparts.SupplierProductCode, tblparts.Required, ' +
    'tblparts.DateCreated, tblparts.DateUpdated, tblparts.Area, ' +
    'tblparts.Discontinued, tblparts.OnSpecial,   ' +
    'tblparts.UseHedgingFormula, tblparts.OnCostIncrease, tblparts.OnCostDecrease, ' +
    'tblparts.LastUpdated, tblparts.LatestCost, tblparts.LatestCostDate, ' +
    'tblparts.PDAMinSellQty, tblparts.LandedCost, tblparts.IsVariable, ' + 'tblparts.IncludeInAnalysis ' + 'FROM tblparts';

  UpdateExportDataRec(ExportRec);
end;

procedure UpdateExportDataPurchases;
var
  ExportRec: TExportRec;
begin
  ExportRec.TableName := 'Purchases';
  ExportRec.TableDescription := 'Purchase List';
  ExportRec.SQL :=
    'SELECT tblpurchaseorders.PurchaseOrderNumber, ' + 'tblpurchaseorders.SupplierName, tblpurchaseorders.OrderDate, ' +
    'tblpurchaseorders.Paid, tblpurchaseorders.InvoiceNumber, ' + 'tblpurchaseorders.InvoiceDate, tblpurchaseorders.DueDate, ' +
    'tblpurchaselines.GlobalRef, tblpurchaselines.ProductName, ' +
    'tblpurchaselines.Product_Description, tblpurchaselines.ProductGroup, ' +
    'tblpurchaselines.AccountNumber, tblpurchaselines.AccountName, ' +
    'tblpurchaselines.AccountGroup, tblpurchaselines.LineTaxRate, ' + 'tblpurchaselines.LineCost, tblpurchaselines.AvgCost, ' +
    'tblpurchaselines.LineCostInc, tblpurchaselines.LineTaxCode, ' + 'tblpurchaselines.LineTax, tblpurchaselines.QtySold, ' +
    'tblpurchaselines.UnitofMeasureQtySold AS UOMQtySold, ' + 'tblpurchaselines.Shipped, ' +
    'tblpurchaselines.UnitofMeasureShipped AS UOMQtyShipped, ' + 'tblpurchaselines.BackOrder, ' +
    'tblpurchaselines.UnitofMeasureBackorder AS UOMQtyBO, ' +
    'tblpurchaselines.UnitofMeasureMultiplier, tblpurchaselines.Invoiced, ' +
    'tblpurchaselines.Class AS Department, tblpurchaselines.RAQty, ' + 'tblpurchaselines.RAstatus, tblpurchaselines.Batch, ' +
    'tblpurchaselines.UseTimecost, tblpurchaselines.TimecostMarkupPer, ' +
    'tblpurchaselines.TimecostPrice, tblpurchaselines.TimecostMarkupDol, ' +
    'tblpurchaselines.TotalLineAmount, tblpurchaselines.TotalLineAmountInc, ' +
    'tblpurchaselines.COGSTotalLineAmount, tblpurchaselines.COGSTotalLineAmountInc, ' +
    'tblpurchaselines.EditedFlag, tblpurchaselines.Deleted, ' +
    'tblpurchaselines.RAInvoiceNo, tblpurchaselines.Attrib1Purchase, ' +
    'tblpurchaselines.Attrib2Purchase, tblpurchaselines.Attrib1PurchaseRate, ' +
    'tblpurchaselines.LandedCostsPerItem, tblpurchaselines.LandedCostsPercentage, ' +
    'tblpurchaselines.LandedCostsTotal, tblpurchaselines.ForeignExchangeRate, ' +
    'tblpurchaselines.ForeignExchangeCode, tblpurchaselines.ForeignCurrencyLineCost, ' +
    'tblpurchaselines.ReceivedDate, ' +
    'tblpurchaselines.DocketNumber, tblpurchaselines.SpecDescription, ' +
    'tblpurchaselines.SpecValue, tblpurchaselines.NewForeignExchangeRate ' + 'FROM tblpurchaselines ' +
    'LEFT JOIN tblpurchaseorders ON tblpurchaselines.PurchaseOrderID = tblpurchaseorders.PurchaseOrderID';

  UpdateExportDataRec(ExportRec);
end;

procedure UpdateExportDataSales;
var
  ExportRec: TExportRec;
begin
  ExportRec.TableName := 'Sales';
  ExportRec.TableDescription := 'Sale List';
  ExportRec.SQL := 'SELECT tblsaleslines.ProductName, tblsaleslines.Product_Description, ' +
    'tblsaleslines.PARTTYPE AS PartType, tblsales.InvoiceDocNumber, ' + 'tblsales.CustomerName, tblsales.SaleDate, ' +
    'tblsales.ShipDate, tblsales.DueDate, tblsales.PayDueDate, ' + 'tblsales.OriginalCreationDate, tblsales.OriginalNo, ' +
    'tblsales.Account, tblsales.Class AS Department, ' + 'tblsales.OrderNumber, tblsales.PONumber, tblsales.ChequeNo, ' +
    'tblsales.AmountDue, tblsales.Deposited, ' + 'tblsaleslines.INCOMEACCNT AS IncomeAccount, ' +
    'tblsaleslines.ASSETACCNT AS AssetAccount, ' + 'tblsaleslines.COGSACCNT AS COGSAccount, tblsaleslines.ProductGroup, ' +
    'tblsaleslines.OrgLinePrice, tblsaleslines.LinePrice, ' + 'tblsaleslines.LinePriceInc, tblsaleslines.LineWholesalePrice, ' +
    'tblsaleslines.LineTaxRate, tblsaleslines.LineCost, ' + 'tblsaleslines.LineCostInc, tblsaleslines.LineTaxCode, ' +
    'tblsaleslines.LineTax, tblsaleslines.QtySold, ' + 'tblsaleslines.UnitofMeasureQtySold AS UOMQtySold, ' +
    'tblsaleslines.Shipped, tblsaleslines.UnitofMeasureShipped AS UOMQtyShipped, ' +
    'tblsaleslines.BackOrder, tblsaleslines.UnitofMeasureBackorder AS UOMBackorder, ' +
    'tblsaleslines.UnitofMeasureSaleLines AS UOMSaleLines, ' + 'tblsaleslines.UnitofMeasureMultiplier AS UOMMultiplier, ' +
    'tblsaleslines.Invoiced, tblsaleslines.Discounts, tblsaleslines.Markup, ' +
    'tblsaleslines.MarkupPercent, tblsaleslines.DiscountPercent, ' +
    'tblsaleslines.Timecostused, tblsaleslines.TimeCostExpAcc, ' + 'tblsaleslines.GroupName, tblsaleslines.IsGroupItem, ' +
    'tblsaleslines.TotalLineAmount, tblsaleslines.TotalLineAmountInc, ' +
    'tblsaleslines.EditedFlag, tblsaleslines.Deleted, tblsaleslines.RefundQty, ' +
    'tblsaleslines.SoldSerials, tblsaleslines.Attrib1Sale, ' + 'tblsaleslines.Attrib2Sale, tblsaleslines.Attrib1SaleRate, ' +
    'tblsaleslines.Supplier, ' +
    'tblsaleslines.SupplierContact, tblsaleslines.ForeignExchangeSellRate, ' +
    'tblsaleslines.ForeignExchangeSellCode, tblsaleslines.ForeignCurrencyLinePrice, ' +
    'tblsaleslines.Area, tblsaleslines.IsRelatedProduct, ' + 'tblsaleslines.LastUpdated, tblsaleslines.IsQuote, ' +
    'tblsaleslines.DocketNumber, tblsaleslines.UseHedging, ' + 'tblsaleslines.SpecDescription, tblsaleslines.SpecValue, ' +
    'tblsaleslines.CreationDate, tblsaleslines.WarrantyPeriod ' + 'FROM tblsaleslines ' +
    'LEFT JOIN tblsales ON tblsaleslines.SaleID = tblsales.SaleID';
  
  UpdateExportDataRec(ExportRec);
end;

procedure UpdateExportDataStockQtys;
var
  ExportRec: TExportRec;
begin
  ExportRec.TableName := 'StockItems';
  ExportRec.TableDescription := 'Stock Quantities';
  ExportRec.SQL :=
    'SELECT tblparts.PARTNAME as ProductName, tblpartqtylines.ProductGroup, ' +
    'tblpartqtylines.ClassName AS Department, tblpartqtylines.InStockQty, ' +
    'tblpartqtylines.SalesOrdersQty, tblpartqtylines.InvoiceBOQty, ' +
    'tblpartqtylines.OnOrderQty, tblpartqtylines.ReOrderPoint, ' +
    'tblpartqtylines.PreferredLevel, tblpartqtylines.ReOrderAmount, ' +
    'tblpartqtylines.LastAdj, tblpartqtylines.LastAdjAccount, ' +
    'tblpartqtylines.ClassPriceVariance, tblpartqtylines.VariantPrice, ' +
    'tblpartqtylines.SalesOrderBOQty, tblpartqtylines.OnHireQTY, ' +
    'tblpartqtylines.OnLaybyQty, tblpartqtylines.NextStocktakeDate, ' +
    'tblpartqtylines.EditedFlag, tblpartqtylines.GlobalRef ' +
    'FROM tblpartqtylines INNER JOIN tblparts On PARTSID=ProductID';
  
  UpdateExportDataRec(ExportRec);
end;

procedure UpdateExportDataSuppliers;
var
  ExportRec: TExportRec;
begin
  ExportRec.TableName := 'Suppliers';
  ExportRec.TableDescription := 'Supplier List';
  ExportRec.SQL := 'SELECT tblclients.GlobalRef, tblclienttype.TypeName, ' +
    'tblclients.Company, tblclients.ABN, tblclients.Title, ' +
    'tblclients.FirstName, tblclients.MiddleName, tblclients.LastName, ' +
    'tblclients.Position, tblclients.Street, tblclients.Street2, ' +
    'tblclients.Suburb, tblclients.State, tblclients.Country, ' +
    'tblclients.Postcode, tblclients.BillStreet, tblclients.BillStreet2, ' +
    'tblclients.BillSuburb, tblclients.BillState, tblclients.BillCountry, ' +
    'tblclients.BillPostcode, tblclients.POBox, tblclients.POSuburb, ' +
    'tblclients.POState, tblclients.POCountry, tblclients.POPostcode, ' +
    'tblclients.Phone, tblclients.FaxNumber, tblclients.Mobile, ' +
    'tblclients.Email, tblclients.AltContact, tblclients.AltPhone, ' +
    'tblclients.PhoneSupportTill, tblclients.Contact1, tblclients.Contact2, ' +
    'tblclients.Contact1Phone, tblclients.Contact2Phone, ' + 'tblclients.CreationDate, tblclients.UpdateDate, ' +
    'tblclients.DateInactive, tblclients.Notes, tblclients.ClientNo, ' +
    'tblclients.TYPE, tblclients.CreditLimit, tblclients.Balance, ' +
    'tblclients.SOBalance, tblclients.ShippingMethod, tblclients.Discount, ' +
    'tblclients.SpecialDiscount, tblclients.JobName, tblclients.JobRegistration, ' +
    'tblclients.WarrantyFinishDate, tblclients.HoursTakenForJob, ' +
    'tblclients.IsJob, tblclients.CUSTFLD1, tblclients.CUSTFLD2, ' +
    'tblclients.CUSTFLD3, tblclients.CUSTFLD4, tblclients.CUSTFLD5, ' +
    'tblclients.CUSTFLD6, tblclients.CUSTFLD7, tblclients.CUSTFLD8, ' +
    'tblclients.CUSTFLD9, tblclients.CUSTFLD10, tblclients.CUSTFLD11, ' +
    'tblclients.CUSTFLD12, tblclients.CUSTFLD13, tblclients.CUSTFLD14, ' +
    'tblclients.CUSTFLD15, tblclients.Feedback, tblclients.Customer, ' +
    'tblclients.OtherContact, tblclients.OtherContactType, tblclients.RepName, ' +
    'tblclients.Action, tblclients.Global, tblclients.Done, ' +
    'tblclients.DateEntered, tblclients.Active, tblclients.EditedFlag, ' +
    'tblclients.CorrespondenceMethod, tblclients.DontContact, ' +
    'tblclients.CompletionDate, tblclients.ShipTime, tblclients.GracePeriod, ' +
    'tblclients.LastContactDate, tblclients.LoyaltyValue, tblclients.LastSaleDate, ' + 'tblclients.URL, ' +
    'tblclients.StopCredit, tblclients.ForcePOOnBooking, ' + 'tblclients.ForcePOOnInvoice, tblclients.PickingPriority, ' +
    'tblclients.LoyaltyDateSaleDays, tblclients.LoyaltyDateAmount, ' +
    'tblclients.LoyaltyDateAppointDays, tblclients.GroupDiscountOverridesAll, ' +
    'tblclients.DefaultClass, tblclients.ForeignExchangeSellCode, tblclients.Area, ' +
    'tblclients.DischargeDate, tblclients.UseInvBase, tblclients.InvBaseNumber, ' +
    'tblclients.ApprovalFromDate, tblclients.ApprovalToDate, ' + 'tblclients.ReminderDateTime, tblclients.SpecialInstructions, ' +
    'tblclients.DeliveryNotes, tblclients.Manufacture, tblclients.ModelNumber, ' +
    'tblclients.Tasks, tblclients.DefaultContactMethod, tblclients.LastUpdated, ' + 'tblclients.WarrantyPeriod ' +
    'FROM tblclients LEFT JOIN' + ' tblclienttype ON tblclients.ClientTypeID = tblclienttype.ClientTypeID' +
    ' WHERE tblclients.Supplier = "T"';
  
  UpdateExportDataRec(ExportRec);
end;

procedure UpdateExportDataSupplierTransactions;
var
  ExportRec: TExportRec;
begin
  ExportRec.TableName := 'SupplierTransactions';
  ExportRec.TableDescription := 'Supplier Transaction List';
  ExportRec.SQL := 'SELECT tbltransactions.Date AS TransactionDate, tbltransactions.Type, ' +
    'tbltransactions.GlobalRef, tbltransactions.AccountName, ' + 'tbltransactions.AccountType, tbltransactions.ClientName, ' +
    'tbltransactions.ProductName, tbltransactions.ProductDesc, ' + 'tbltransactions.RepName, tbltransactions.TaxCode, ' +
    'tbltransactions.TaxRate, tbltransactions.DebitsEx, ' + 'tbltransactions.CreditsEx, tbltransactions.DebitsInc, ' +
    'tbltransactions.CreditsInc, tbltransactions.Reconciled, ' + 'tbltransactions.Notes ' +
    'FROM tbltransactions INNER JOIN' + ' tblclients ON tbltransactions.ClientID = tblclients.ClientID ' +
    'WHERE tblclients.Supplier = "T"';
  
  UpdateExportDataRec(ExportRec);
end;

procedure UpdateExportDataTransactionsAll;
var
  ExportRec: TExportRec;
begin
  ExportRec.TableName := 'Transactions';
  ExportRec.TableDescription := 'Transaction List';
  ExportRec.SQL :=
    'SELECT tbltransactions.Date AS TransactionDate, tbltransactions.Type, ' +
    'tbltransactions.GlobalRef, tbltransactions.AccountName, ' + 'tbltransactions.AccountType, tbltransactions.ClientName, ' +
    'tbltransactions.ProductName, tbltransactions.ProductDesc, ' + 'tbltransactions.RepName, tbltransactions.TaxCode, ' +
    'tbltransactions.TaxRate, tbltransactions.DebitsEx, ' + 'tbltransactions.CreditsEx, tbltransactions.DebitsInc, ' +
    'tbltransactions.CreditsInc, tbltransactions.Reconciled, ' + 'tbltransactions.Notes ' + 'FROM tbltransactions';
  
  UpdateExportDataRec(ExportRec);
end;

end.
