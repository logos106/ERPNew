inherited fmMain: TfmMain
  Left = 368
  Top = 205
  Caption = 'ERP Data Update'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Script: TMyScript
    SQL.Strings = (
      'delete from tblPreferences where PrefGroup = "GuiPrefs";'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TRemindersListGUI", NULL, "<?xml version="' +
        '"1.0"" encoding=""UTF-8"" ?><TRemindersListGUI><grdMain><GridFie' +
        'lds><![CDATA[Client'#9'22'#9'Client'#9'F'
      'Description'#9'84'#9'Description'#9'F'
      'In Days'#9'15'#9'In Days'#9'F'
      
        'Type'#9'13'#9'Type'#9'F]]></GridFields><TitleFont><Name>Arial</Name><Size' +
        '>9</Size><Color>-2147483640</Color><Style>fsBold</Style></TitleF' +
        'ont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</Co' +
        'lor><Style></Style></Font><ShowGridLines>True</ShowGridLines><Al' +
        'ternatingRowColor>536870911</AlternatingRowColor><CustomColumns>' +
        '</CustomColumns></grdMain></TRemindersListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TPrefSettingsListGUI", NULL, "<?xml versio' +
        'n=""1.0"" encoding=""UTF-8"" ?><TPrefSettingsListGUI><grdMain><G' +
        'ridFields><![CDATA[]]></GridFields><TitleFont><Name>Arial</Name>' +
        '<Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></T' +
        'itleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214748364' +
        '0</Color><Style></Style></Font><ShowGridLines>True</ShowGridLine' +
        's><AlternatingRowColor>536870911</AlternatingRowColor></grdMain>' +
        '</TPrefSettingsListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TGlobalListFrm", NULL, "<?xml version=""1.' +
        '0"" encoding=""UTF-8"" ?><TGlobalListFrm><grdMain><GridFields><!' +
        '[CDATA[Name'#9'20'#9'Name'#9'F'
      'ContactName'#9'15'#9'ContactName'#9'F'
      'Type'#9'13'#9'Type'#9'F'
      'Phone'#9'14'#9'Phone'#9'F'
      'Mobile'#9'14'#9'Mobile'#9'F'
      'Balance'#9'13'#9'Balance'#9'F'
      'Rep'#9'14'#9'Rep'#9'F'
      'Street'#9'20'#9'Street'#9'F'
      'Suburb'#9'17'#9'Suburb'#9'F'
      'State'#9'11'#9'State'#9'F'
      'Postcode'#9'7'#9'Postcode'#9'F'
      'Country'#9'7'#9'Country'#9'F'
      'Email'#9'20'#9'Email'#9'F'
      'FaxNumber'#9'14'#9'FaxNumber'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TGlobalListFrm>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TSalesOrderGUI", NULL, "<?xml version=""1.' +
        '0"" encoding=""UTF-8"" ?><TSalesOrderGUI><grdTransactions><GridF' +
        'ields><![CDATA[ProductName'#9'17'#9'Name'#9'F'
      'UnitofMeasureSaleLines'#9'10'#9'Units'#9'F'
      'UnitofMeasureQtySold'#9'6'#9'Ordered'#9'F'
      'UnitofMeasureShipped'#9'6'#9'Shipped'#9'F'
      'UnitofMeasureBackorder'#9'6'#9'BO'#9'F'
      'PQA'#9'8'#9'Allocation'#9'F'
      'Product_Description'#9'20'#9'Description'#9'F'
      'LinePriceInc'#9'10'#9'Price (Inc)'#9'F'
      'LineTaxCode'#9'7'#9'Code'#9'F'
      'LineTax'#9'10'#9'Tax'#9'F'
      'TotalLineAmountInc'#9'14'#9'Amount (Inc)'#9'F'
      'SpecDescription'#9'17'#9'Specifications'#9'F'
      'SpecValue'#9'10'#9'Spec Qty'#9'F'
      'CostCentreName'#9'20'#9'Cost Centre'#9'F'
      'WarrantyEndsOn'#9'14'#9'Warranty Ends On'#9'F'
      'WarrantyPeriod'#9'20'#9'Warranty Period'#9'F'
      'CalcProfit'#9'10'#9'Profit (Inc)'#9'F'
      'CalcProfitPercent'#9'10'#9'% Profit (Inc)'#9'F'
      'CalcGrossProfitPercentInc'#9'10'#9'GP %'#9'F'
      'LatestCostPriceInc'#9'13'#9'Latest Cost (Inc)'#9'F'
      'Discounts'#9'10'#9'Discount ($)'#9'F'
      'Supplier'#9'20'#9'Supplier'#9'F'
      'SupplierContact'#9'20'#9'Supplier Contact'#9'F'
      'DocketNumber'#9'20'#9'Docket Number'#9'F'
      'BaseLineno'#9'10'#9'BaseLineno'#9'F'
      
        'SmartOrderCreated'#9'7'#9'Ordered?'#9'F]]></GridFields><TitleFont><Name>A' +
        'rial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold' +
        '</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color' +
        '>-2147483640</Color><Style></Style></Font><ShowGridLines>True</S' +
        'howGridLines><AlternatingRowColor>536870911</AlternatingRowColor' +
        '><CustomColumns></CustomColumns></grdTransactions></TSalesOrderG' +
        'UI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmEmployeeList", NULL, "<?xml version=""' +
        '1.0"" encoding=""UTF-8"" ?><TfrmEmployeeList><grdMain><GridField' +
        's><![CDATA[FirstName'#9'11'#9'First Name'#9'F'
      'LastName'#9'10'#9'Last Name'#9'F'
      'Phone'#9'13'#9'Phone'#9'F'
      'Mobile'#9'12'#9'Mobile'#9'F'
      'Fax Number'#9'13'#9'Fax Number'#9'F'
      'Address'#9'25'#9'Address'#9'T'
      'Suburb'#9'15'#9'Suburb'#9'F'
      'State'#9'4'#9'State'#9'F'
      'Postcode'#9'8'#9'Postcode'#9'F'
      'Country'#9'7'#9'Country'#9'F'
      'Department'#9'10'#9'Department'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TfrmEmployeeList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TEmployeeReportGUI", NULL, "<?xml version=' +
        '""1.0"" encoding=""UTF-8"" ?><TEmployeeReportGUI><grdMain><GridF' +
        'ields><![CDATA[Name'#9'15'#9'Name'#9'F'
      'CustomerName'#9'17'#9'CustomerName'#9'F'
      'LineCost'#9'12'#9'LineCost (Ex)'#9'F'
      'LineCostInc'#9'13'#9'LineCost (Inc)'#9'F'
      'Total Amount (Ex)'#9'14'#9'Total Amount (Ex)'#9'T'
      'Total Amount (Inc)'#9'14'#9'Total Amount (Inc)'#9'F'
      'SaleProfitEx'#9'11'#9'SaleProfit (Ex)'#9'F'
      'SaleProfit'#9'12'#9'SaleProfit (Inc)'#9'F'
      'Profit (%)'#9'11'#9'Profit (%)'#9'F'
      'GrossProfit'#9'10'#9'GrossProfit'#9'F'
      'CommissionDue'#9'13'#9'CommissionDue'#9'F'
      'CommissionPaid'#9'13'#9'CommissionPaid'#9'F'
      'Paid'#9'3'#9'Paid'#9'F'
      'Invoice Number'#9'12'#9'Invoice Number'#9'F'
      'SaleDate'#9'12'#9'SaleDate'#9'F'
      'DueDate'#9'10'#9'DueDate'#9'F'
      'Type'#9'12'#9'Type'#9'F'
      'Details'#9'9'#9'Details'#9'F'
      
        'CommissionRep'#9'12'#9'CommissionRep'#9'F]]></GridFields><TitleFont><Name' +
        '>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBo' +
        'ld</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Col' +
        'or>-2147483640</Color><Style></Style></Font><ShowGridLines>True<' +
        '/ShowGridLines><AlternatingRowColor>536870911</AlternatingRowCol' +
        'or><CustomColumns></CustomColumns></grdMain></TEmployeeReportGUI' +
        '>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TSalesOrderListGUI", NULL, "<?xml version=' +
        '""1.0"" encoding=""UTF-8"" ?><TSalesOrderListGUI><grdMain><GridF' +
        'ields><![CDATA[Customer Name'#9'21'#9'Customer Name'#9'F'
      'Sale Date'#9'10'#9'Sale Date'#9'F'
      'Employee Name'#9'14'#9'Employee Name'#9'F'
      'Held'#9'3'#9'Held'#9'F'
      'Total Amount (Ex)'#9'14'#9'Total Amount (Ex)'#9'F'
      'Total Tax'#9'10'#9'Total Tax'#9'F'
      'Total Amount (Inc)'#9'14'#9'Total Amount (Inc)'#9'F'
      'Sales Order Number'#9'16'#9'Sales Order Number'#9'F'
      'Ship Date'#9'10'#9'Ship Date'#9'F'
      'ConvertFromQuote'#9'16'#9'Convert From Quote'#9'F'
      'Converted'#9'8'#9'Converted'#9'F'
      'PO Number'#9'11'#9'PO Number'#9'F'
      'Consignment Note'#9'15'#9'Consignment Note'#9'F'
      'Class Name'#9'15'#9'Department Name'#9'F'
      'Deleted'#9'6'#9'Deleted'#9'F'
      'Balance'#9'10'#9'Balance'#9'F'
      'Comments'#9'17'#9'Comments'#9'T'
      'DueDate'#9'10'#9'Due Date'#9'F'
      'Terms'#9'12'#9'Terms'#9'F'
      
        'FutureSO'#9'8'#9'Future SO'#9'F]]></GridFields><TitleFont><Name>Arial</Na' +
        'me><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style>' +
        '</TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214748' +
        '3640</Color><Style></Style></Font><ShowGridLines>True</ShowGridL' +
        'ines><AlternatingRowColor>536870911</AlternatingRowColor><Custom' +
        'Columns></CustomColumns></grdMain></TSalesOrderListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TCustomerListGUI", NULL, "<?xml version=""' +
        '1.0"" encoding=""UTF-8"" ?><TCustomerListGUI><grdMain><GridField' +
        's><![CDATA[CompanyName'#9'19'#9'Company Name'#9'T'
      'ContactName'#9'16'#9'Contact Name'#9'T'
      'Phone'#9'13'#9'Phone'#9'F'
      'FaxNumber'#9'14'#9'Fax Number'#9'F'
      'AR Balance'#9'12'#9'AR Balance'#9'F'
      'AP Balance'#9'12'#9'AP Balance'#9'F'
      'Balance'#9'12'#9'Balance'#9'F'
      'Total Balance'#9'11'#9'Total Balance'#9'F'
      'Terms'#9'8'#9'Terms'#9'F'
      'CreditLimit'#9'10'#9'Credit Limit'#9'F'
      'Rep'#9'11'#9'Rep'#9'F'
      'GracePeriod'#9'10'#9'Grace Period'#9'F'
      'AccountNo'#9'10'#9'Account No'#9'F'
      'Email'#9'23'#9'Email'#9'F'
      'StopCredit'#9'9'#9'Stop Credit'#9'F'
      'Street'#9'18'#9'Street'#9'F'
      'Suburb'#9'20'#9'Suburb'#9'F'
      'State'#9'6'#9'State'#9'F'
      'Postcode'#9'10'#9'Postcode'#9'F'
      'Country'#9'8'#9'Country'#9'F'
      'AltPhone'#9'12'#9'Alt Phone'#9'F'
      'Mobile'#9'11'#9'Mobile'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TCustomerListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TStatementListGUI", NULL, "<?xml version="' +
        '"1.0"" encoding=""UTF-8"" ?><TStatementListGUI><grdMain><GridFie' +
        'lds><![CDATA[Customer Name'#9'14'#9'Customer Name'#9'F'
      'Status'#9'11'#9'Status'#9'F'
      'Invoice Number'#9'12'#9'Invoice Number'#9'F'
      'Receipt #'#9'10'#9'Receipt #'#9'F'
      'Days Outstanding'#9'15'#9'Days Outstanding'#9'F'
      'Total Amount'#9'10'#9'Total Amount'#9'F'
      'Within Terms'#9'10'#9'Within Terms'#9'T'
      '1-30 Days'#9'12'#9'1-30 Days'#9'T'
      '30-60 Days'#9'11'#9'30-60 Days'#9'T'
      '60-90 Days'#9'12'#9'60-90 Days'#9'T'
      '>90 Days'#9'10'#9'>90 Days'#9'T'
      'Outstanding Amount'#9'16'#9'Outstanding Amount'#9'F'
      
        'Type'#9'7'#9'Type'#9'F]]></GridFields><TitleFont><Name>Arial</Name><Size>' +
        '9</Size><Color>-2147483640</Color><Style>fsBold</Style></TitleFo' +
        'nt><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</Col' +
        'or><Style></Style></Font><ShowGridLines>True</ShowGridLines><Alt' +
        'ernatingRowColor>536870911</AlternatingRowColor><CustomColumns><' +
        '/CustomColumns></grdMain></TStatementListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TAppointmentListGUI", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TAppointmentListGUI><grdMain><Gri' +
        'dFields><![CDATA[AppDate'#9'10'#9'App Date'#9'F'
      'Rep'#9'11'#9'Rep'#9'T'
      'Company'#9'16'#9'Company'#9'F'
      'Contact Name'#9'13'#9'Contact Name'#9'T'
      'Mobile'#9'12'#9'Mobile'#9'F'
      'Phone'#9'13'#9'Phone'#9'F'
      'Street'#9'20'#9'Street'#9'F'
      'Suburb'#9'18'#9'Suburb'#9'F'
      'State'#9'9'#9'State'#9'F'
      'Postcode'#9'7'#9'Postcode'#9'F'
      'Service Description'#9'17'#9'Service Description'#9'F'
      'Start Time'#9'10'#9'Start Time'#9'F'
      'Feedback'#9'7'#9'Feedback'#9'F'
      'Cancellation'#9'10'#9'Cancellation'#9'F'
      'Rescheduled'#9'10'#9'Rescheduled'#9'F'
      'EnteredBy'#9'13'#9'EnteredBy'#9'F'
      'Email'#9'19'#9'Email'#9'F'
      'AppointmentDetails'#9'43'#9'Appointment Details'#9'T'
      'FaxNumber'#9'12'#9'FaxNumber'#9'F'
      'AltContact'#9'9'#9'AltContact'#9'F'
      
        'AltPhone'#9'12'#9'AltPhone'#9'F]]></GridFields><TitleFont><Name>Arial</Na' +
        'me><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style>' +
        '</TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214748' +
        '3640</Color><Style></Style></Font><ShowGridLines>True</ShowGridL' +
        'ines><AlternatingRowColor>536870911</AlternatingRowColor><Custom' +
        'Columns></CustomColumns></grdMain></TAppointmentListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TQuoteListGUI", NULL, "<?xml version=""1.0' +
        '"" encoding=""UTF-8"" ?><TQuoteListGUI><grdMain><GridFields><![C' +
        'DATA[Customer Name'#9'16'#9'Customer Name'#9'F'
      'QuoteStatus'#9'11'#9'Quote Status'#9'F'
      'Done'#9'4'#9'Done'#9'F'
      'Employee Name'#9'14'#9'Employee Name'#9'F'
      'Total Amount (Ex)'#9'15'#9'Total Amount (Ex)'#9'F'
      'Total Tax'#9'10'#9'Total Tax'#9'F'
      'Total Amount (Inc)'#9'14'#9'Total Amount (Inc)'#9'F'
      'Followup Date'#9'11'#9'Followup Date'#9'F'
      'Comments'#9'26'#9'Comments'#9'T'
      'Class Name'#9'14'#9'Department Name'#9'F'
      'Invoice Number'#9'12'#9'Invoice Number'#9'F'
      'InvoiceTo'#9'15'#9'Invoice To'#9'F'
      
        'ShipTo'#9'15'#9'Ship To'#9'F]]></GridFields><TitleFont><Name>Arial</Name>' +
        '<Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></T' +
        'itleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214748364' +
        '0</Color><Style></Style></Font><ShowGridLines>True</ShowGridLine' +
        's><AlternatingRowColor>536870911</AlternatingRowColor><CustomCol' +
        'umns></CustomColumns></grdMain></TQuoteListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TInvoiceListGUI", NULL, "<?xml version=""1' +
        '.0"" encoding=""UTF-8"" ?><TInvoiceListGUI><grdMain><GridFields>' +
        '<![CDATA[Customer Name'#9'20'#9'Customer Name'#9'F'
      'Sale Date'#9'10'#9'Sale Date'#9'F'
      'Invoice Number'#9'12'#9'Invoice Number'#9'F'
      'Total Amount (Ex)'#9'14'#9'Total Amount (Ex)'#9'F'
      'Total Tax'#9'10'#9'Total Tax'#9'F'
      'Total Amount (Inc)'#9'14'#9'Total Amount (Inc)'#9'F'
      'Employee Name'#9'14'#9'Employee Name'#9'F'
      'PO Number'#9'9'#9'PO Number'#9'F'
      'Held'#9'3'#9'Held'#9'F'
      'Paid'#9'3'#9'Paid'#9'F'
      'ConvertFromQuote'#9'17'#9'Convert From Quote'#9'F'
      'ConvertFromSO'#9'14'#9'Convert From SO'#9'F'
      'Comments'#9'18'#9'Comments'#9'T'
      'Class Name'#9'14'#9'Department Name'#9'F'
      'Terms'#9'13'#9'Terms'#9'F'
      'Ship Date'#9'10'#9'Ship Date'#9'F'
      
        'DueDate'#9'10'#9'Due Date'#9'F]]></GridFields><TitleFont><Name>Arial</Nam' +
        'e><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style><' +
        '/TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483' +
        '640</Color><Style></Style></Font><ShowGridLines>True</ShowGridLi' +
        'nes><AlternatingRowColor>536870911</AlternatingRowColor><CustomC' +
        'olumns></CustomColumns></grdMain></TInvoiceListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TLoyaltyListGUI", NULL, "<?xml version=""1' +
        '.0"" encoding=""UTF-8"" ?><TLoyaltyListGUI><grdMain><GridFields>' +
        '<![CDATA[Company'#9'22'#9'Company'#9'F'
      'Ref_Date'#9'12'#9'Ref Date'#9'F'
      'ReferenceTxt'#9'44'#9'Reference Txt'#9'F'
      
        'LoyaltyProgram'#9'13'#9'Loyalty Program'#9'F]]></GridFields><TitleFont><N' +
        'ame>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>f' +
        'sBold</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><' +
        'Color>-2147483640</Color><Style></Style></Font><ShowGridLines>Tr' +
        'ue</ShowGridLines><AlternatingRowColor>536870911</AlternatingRow' +
        'Color><CustomColumns></CustomColumns></grdMain></TLoyaltyListGUI' +
        '>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TJobProfitabilityGUI", NULL, "<?xml versio' +
        'n=""1.0"" encoding=""UTF-8"" ?><TJobProfitabilityGUI><grdMain><G' +
        'ridFields><![CDATA[CompanyName'#9'16'#9'Company Name'#9'F'
      'JobName'#9'13'#9'Job Name'#9'F'
      'JobNumber'#9'10'#9'Job Number'#9'F'
      'Transaction Type'#9'20'#9'Transaction Type'#9'F'
      'Cost (Ex)'#9'13'#9'Cost (Ex)'#9'F'
      'Income (Ex)'#9'12'#9'Income (Ex)'#9'F'
      'Quoted (Ex)'#9'12'#9'Quoted (Ex)'#9'F'
      '$ Diff (Income-Cost)'#9'16'#9'$ Diff (Income-Cost)'#9'F'
      '% Diff (Income/Cost)'#9'16'#9'% Diff (Income/Cost)'#9'F'
      '$ Diff (Quote-Cost)'#9'14'#9'$ Diff (Quote-Cost)'#9'F'
      '% Diff (Quote/Cost)'#9'15'#9'% Diff (Quote/Cost)'#9'F'
      'Debit (Ex)'#9'12'#9'Debit (Ex)'#9'F'
      'Credit (Ex)'#9'12'#9'Credit (Ex)'#9'F'
      'Profit %'#9'10'#9'Profit %'#9'F'
      'Department'#9'14'#9'Department'#9'F'
      'ProductName'#9'15'#9'Product'#9'F'
      'FirstColumn'#9'15'#9'Manufacture'#9'F'
      'SecondColumn'#9'13'#9'Type'#9'F'
      'ThirdColumn'#9'12'#9'Dept'#9'F'
      
        'Area'#9'15'#9'Area'#9'F]]></GridFields><TitleFont><Name>Arial</Name><Size' +
        '>9</Size><Color>-2147483640</Color><Style>fsBold</Style></TitleF' +
        'ont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</Co' +
        'lor><Style></Style></Font><ShowGridLines>True</ShowGridLines><Al' +
        'ternatingRowColor>536870911</AlternatingRowColor><CustomColumns>' +
        '</CustomColumns></grdMain></TJobProfitabilityGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmPayTimesheet", NULL, "<?xml version=""' +
        '1.0"" encoding=""UTF-8"" ?><TfrmPayTimesheet><grdMain><GridField' +
        's><![CDATA[Name'#9'16'#9'Name'#9'F'
      'Job'#9'18'#9'Job'#9'F'
      'TimesheetDate'#9'20'#9'Timesheet Date'#9'F'
      'Hours'#9'10'#9'Hours'#9'F'
      'LabourCost'#9'10'#9'Labour Cost'#9'F'
      'Total'#9'12'#9'Total'#9'F'
      'Notes'#9'40'#9'Notes'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TfrmPayTimesheet>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TCustomerSalesOnProductListGUI", NULL, "<?' +
        'xml version=""1.0"" encoding=""UTF-8"" ?><TCustomerSalesOnProduc' +
        'tListGUI><grdMain><GridFields><![CDATA[SaleDate'#9'10'#9'SaleDate'#9#9
      'Class'#9'20'#9'Class'#9'F'#9
      'Employee'#9'20'#9'Employee'#9'F'#9
      'Qty'#9'10'#9'Qty'#9#9
      'ProductName'#9'30'#9'ProductName'#9'F'#9
      'Price (Inc)'#9'10'#9'Price (Inc)'#9#9
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor></grdMain></TCustomerSalesOnP' +
        'roductListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TAccountsReceivableNotes", NULL, "<?xml ve' +
        'rsion=""1.0"" encoding=""UTF-8"" ?><TAccountsReceivableNotes><gr' +
        'dMain><GridFields><![CDATA[CustomerName'#9'14'#9'Customer Name'#9'F'
      'SaleDate'#9'10'#9'Sale Date'#9'F'
      'ARNotes'#9'39'#9'AR Notes'#9'F'
      'TotalAmountInc'#9'13'#9'Total Amount Inc'#9'F'
      'EmployeeName'#9'18'#9'Employee Name'#9'F'
      'InvoiceNumber'#9'15'#9'Invoice Number'#9'F'
      
        'AccountName'#9'20'#9'Account Name'#9'F]]></GridFields><TitleFont><Name>Ar' +
        'ial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold<' +
        '/Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>' +
        '-2147483640</Color><Style></Style></Font><ShowGridLines>True</Sh' +
        'owGridLines><AlternatingRowColor>536870911</AlternatingRowColor>' +
        '<CustomColumns></CustomColumns></grdMain></TAccountsReceivableNo' +
        'tes>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TQuoteGUI", NULL, "<?xml version=""1.0"" e' +
        'ncoding=""UTF-8"" ?><TQuoteGUI><grdTransactions><GridFields><![C' +
        'DATA[ProductName'#9'18'#9'Name'#9'F'
      'UnitofMeasureQtySold'#9'6'#9'Ordered'#9'F'
      'UnitofMeasureSaleLines'#9'10'#9'Units'#9'F'
      'Product_Description'#9'34'#9'Description'#9'F'
      'LinePriceInc'#9'10'#9'Price (Inc)'#9'F'
      'LineTaxCode'#9'7'#9'Code'#9'F'
      'LineTax'#9'10'#9'Tax'#9'F'
      'Discounts'#9'10'#9'Discount ($)'#9'F'
      'TotalLineAmountInc'#9'14'#9'Amount (Inc)'#9'F'
      
        'BaseLineno'#9'10'#9'BaseLineno'#9'F]]></GridFields><TitleFont><Name>Arial' +
        '</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</St' +
        'yle></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21' +
        '47483640</Color><Style></Style></Font><ShowGridLines>True</ShowG' +
        'ridLines><AlternatingRowColor>536870911</AlternatingRowColor><Cu' +
        'stomColumns></CustomColumns></grdTransactions></TQuoteGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TInvoiceGUI", NULL, "<?xml version=""1.0""' +
        ' encoding=""UTF-8"" ?><TInvoiceGUI><grdTransactions><GridFields>' +
        '<![CDATA[ProductName'#9'16'#9'Name'#9'F'
      'UnitofMeasureSaleLines'#9'8'#9'Units'#9'F'
      'UnitofMeasureQtySold'#9'6'#9'Ordered'#9'F'
      'UnitofMeasureShipped'#9'6'#9'Shipped'#9'F'
      'UnitofMeasureBackorder'#9'6'#9'BO'#9'F'
      'PQA'#9'8'#9'Allocation'#9'F'
      'Product_Description'#9'20'#9'Description'#9'F'
      'LinePriceInc'#9'9'#9'Price (Inc)'#9'F'
      'LineTaxCode'#9'7'#9'Code'#9'F'
      'LineTax'#9'9'#9'Tax'#9'F'
      'Discounts'#9'10'#9'Discount ($)'#9'F'
      'TotalLineAmountInc'#9'10'#9'Amount (Inc)'#9'F'
      
        'BaseLineno'#9'10'#9'BaseLineno'#9'F]]></GridFields><TitleFont><Name>Arial' +
        '</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</St' +
        'yle></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21' +
        '47483640</Color><Style></Style></Font><ShowGridLines>True</ShowG' +
        'ridLines><AlternatingRowColor>536870911</AlternatingRowColor><Cu' +
        'stomColumns></CustomColumns></grdTransactions></TInvoiceGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TProductListExpressGUI", NULL, "<?xml vers' +
        'ion=""1.0"" encoding=""UTF-8"" ?><TProductListExpressGUI><grdMai' +
        'n><GridFields><![CDATA[ProductName'#9'25'#9'Product'#9'F'
      'SalesDescription'#9'35'#9'Sales Description'#9'F'
      'FirstColumn'#9'18'#9'Manufacture'#9'T'
      'SecondColumn'#9'16'#9'Type'#9'T'
      'ThirdColumn'#9'16'#9'Dept'#9'T'
      'PartType'#9'9'#9'Part Type'#9'F'
      
        'PriceInc'#9'13'#9'Price Inc'#9'T]]></GridFields><TitleFont><Name>Arial</N' +
        'ame><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style' +
        '></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474' +
        '83640</Color><Style></Style></Font><ShowGridLines>True</ShowGrid' +
        'Lines><AlternatingRowColor>536870911</AlternatingRowColor><Custo' +
        'mColumns></CustomColumns></grdMain></TProductListExpressGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TDeliveryDocketListGUI", NULL, "<?xml vers' +
        'ion=""1.0"" encoding=""UTF-8"" ?><TDeliveryDocketListGUI><grdMai' +
        'n><GridFields><![CDATA[Sale Date'#9'10'#9'Sale Date'#9'F'
      'Type'#9'11'#9'Type'#9'F'
      'Trans No #'#9'30'#9'Trans No #'#9'F'
      
        'Customer'#9'40'#9'Customer'#9'F]]></GridFields><TitleFont><Name>Arial</Na' +
        'me><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style>' +
        '</TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214748' +
        '3640</Color><Style></Style></Font><ShowGridLines>True</ShowGridL' +
        'ines><AlternatingRowColor>536870911</AlternatingRowColor><Custom' +
        'Columns></CustomColumns></grdMain></TDeliveryDocketListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TCashSaleGUI", NULL, "<?xml version=""1.0"' +
        '" encoding=""UTF-8"" ?><TCashSaleGUI></TCashSaleGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TRefundGUI", NULL, "<?xml version=""1.0"" ' +
        'encoding=""UTF-8"" ?><TRefundGUI></TRefundGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBASListGUI", NULL, "<?xml version=""1.0""' +
        ' encoding=""UTF-8"" ?><TBASListGUI><grdMain><GridFields><![CDATA' +
        '[BAS Number'#9'10'#9'BAS Number'#9'F'
      
        'BAS Sheet Description'#9'50'#9'BAS Sheet Description'#9'F]]></GridFields>' +
        '<TitleFont><Name>Arial</Name><Size>9</Size><Color>-2147483640</C' +
        'olor><Style>fsBold</Style></TitleFont><Font><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style></Style></Font><Sho' +
        'wGridLines>True</ShowGridLines><AlternatingRowColor>536870911</A' +
        'lternatingRowColor><CustomColumns></CustomColumns></grdMain></TB' +
        'ASListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TAccountTypesListGUI", NULL, "<?xml versio' +
        'n=""1.0"" encoding=""UTF-8"" ?><TAccountTypesListGUI><grdMain><G' +
        'ridFields><![CDATA[AccountTypes'#9'28'#9'Account Types'#9'F'
      
        'Description'#9'44'#9'Description'#9'F]]></GridFields><TitleFont><Name>Ari' +
        'al</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</' +
        'Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-' +
        '2147483640</Color><Style></Style></Font><ShowGridLines>True</Sho' +
        'wGridLines><AlternatingRowColor>536870911</AlternatingRowColor><' +
        'CustomColumns></CustomColumns><Columns><GlobalRef><Visible>True<' +
        '/Visible><Index>2</Index><DisplayWidth>40</DisplayWidth><Display' +
        'Label>Global Ref</DisplayLabel><Hidden>False</Hidden></GlobalRef' +
        '><Description><Visible>True</Visible><Index>1</Index><DisplayWid' +
        'th>60</DisplayWidth><DisplayLabel>Description</DisplayLabel><Hid' +
        'den>False</Hidden></Description><AccountTypes><Visible>True</Vis' +
        'ible><Index>0</Index><DisplayWidth>60</DisplayWidth><DisplayLabe' +
        'l>Account Types</DisplayLabel><Hidden>False</Hidden></AccountTyp' +
        'es><AccType><Hidden>False</Hidden><Visible>False</Visible><Index' +
        '>5</Index><DisplayWidth>40</DisplayWidth><DisplayLabel>AccType</' +
        'DisplayLabel></AccType><TypeID><Hidden>False</Hidden><Visible>Fa' +
        'lse</Visible><Index>5</Index><DisplayWidth>10</DisplayWidth><Dis' +
        'playLabel>TypeID</DisplayLabel></TypeID></Columns></grdMain></TA' +
        'ccountTypesListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TJournalListGui", NULL, "<?xml version=""1' +
        '.0"" encoding=""UTF-8"" ?><TJournalListGui><grdMain><GridFields>' +
        '<![CDATA[TransactionDate'#9'13'#9'Transaction Date'#9'F'
      'AccountName'#9'32'#9'Account Name'#9'F'
      'ClassName'#9'16'#9'Department Name'#9'F'
      'Entry No'#9'9'#9'Entry No'#9'F'
      'DebitAmount'#9'12'#9'Debit Amount'#9'F'
      'CreditAmount'#9'12'#9'Credit Amount'#9'F'
      
        'TaxAmount'#9'11'#9'Tax Amount'#9'F]]></GridFields><TitleFont><Name>Arial<' +
        '/Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Sty' +
        'le></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214' +
        '7483640</Color><Style></Style></Font><ShowGridLines>True</ShowGr' +
        'idLines><AlternatingRowColor>536870911</AlternatingRowColor><Cus' +
        'tomColumns></CustomColumns></grdMain></TJournalListGui>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TTrialBalanceGUI", NULL, "<?xml version=""' +
        '1.0"" encoding=""UTF-8"" ?><TTrialBalanceGUI><grdMain><GridField' +
        's><![CDATA[AccountName'#9'29'#9'Account Name'#9'T'
      'AccountNumber'#9'13'#9'Account Number'#9'F'
      'Account'#9'25'#9'Account'#9'F'
      'CreditsEx'#9'13'#9'Credits Ex'#9'F'
      'CreditsInc'#9'13'#9'Credits Inc'#9'F'
      'DebitsEx'#9'12'#9'Debits Ex'#9'F'
      
        'DebitsInc'#9'14'#9'Debits Inc'#9'F]]></GridFields><TitleFont><Name>Arial<' +
        '/Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Sty' +
        'le></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214' +
        '7483640</Color><Style></Style></Font><ShowGridLines>True</ShowGr' +
        'idLines><AlternatingRowColor>536870911</AlternatingRowColor><Cus' +
        'tomColumns></CustomColumns></grdMain></TTrialBalanceGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TProfitandLossGUI", NULL, "<?xml version="' +
        '"1.0"" encoding=""UTF-8"" ?><TProfitandLossGUI></TProfitandLossG' +
        'UI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TProfitLossPeriodGUI", NULL, "<?xml versio' +
        'n=""1.0"" encoding=""UTF-8"" ?><TProfitLossPeriodGUI></TProfitLo' +
        'ssPeriodGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TAccountsReceiveListGUI", NULL, "<?xml ver' +
        'sion=""1.0"" encoding=""UTF-8"" ?><TAccountsReceiveListGUI><grdM' +
        'ain><GridFields><![CDATA[Name'#9'18'#9'Name'#9'F'
      'Phone'#9'13'#9'Phone'#9'F'
      'InvoiceNumber'#9'12'#9'Invoice Number'#9'F'
      'DueDate'#9'10'#9'Due Date'#9'F'
      'AmountDue'#9'11'#9'Amount Due'#9'F'
      'Current'#9'11'#9'Current'#9'F'
      '1-30Days'#9'11'#9'1-30Days'#9'F'
      '30-60Days'#9'11'#9'30-60Days'#9'F'
      '60-90Days'#9'12'#9'60-90Days'#9'F'
      '>90Days'#9'12'#9'>90Days'#9'F'
      'EmployeeName'#9'15'#9'Employee Name'#9'F'
      'StopCredit'#9'9'#9'Stop Credit'#9'F'
      'CreditLimit'#9'10'#9'Credit Limit'#9'F'
      'SaleDate'#9'10'#9'Sale Date'#9'F'
      'FaxNumber'#9'13'#9'Fax Number'#9'F'
      'Mobile'#9'13'#9'Mobile'#9'F'
      
        'AltPhone'#9'14'#9'Alt Phone'#9'F]]></GridFields><TitleFont><Name>Arial</N' +
        'ame><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style' +
        '></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474' +
        '83640</Color><Style></Style></Font><ShowGridLines>True</ShowGrid' +
        'Lines><AlternatingRowColor>536870911</AlternatingRowColor><Custo' +
        'mColumns></CustomColumns></grdMain></TAccountsReceiveListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TAccountsPayListGUI", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TAccountsPayListGUI><grdMain><Gri' +
        'dFields><![CDATA[Name'#9'18'#9'Name'#9'F'
      'PONumber'#9'11'#9'PO Number'#9'F'
      'DueDate'#9'10'#9'Due Date'#9'F'
      'AmountDue'#9'12'#9'Amount Due'#9'F'
      'Current'#9'12'#9'Current'#9'F'
      '30Days'#9'12'#9'30Days'#9'F'
      '60Days'#9'13'#9'60Days'#9'F'
      '90Days'#9'13'#9'90Days'#9'F'
      '120Days'#9'13'#9'120Days'#9'F'
      'Type'#9'7'#9'Type'#9'F'
      'OrderDate'#9'12'#9'Order Date'#9'F'
      'InvoiceDate'#9'12'#9'Invoice Date'#9'F'
      
        'Notes'#9'10'#9'Notes'#9'F]]></GridFields><TitleFont><Name>Arial</Name><Si' +
        'ze>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Titl' +
        'eFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</' +
        'Color><Style></Style></Font><ShowGridLines>True</ShowGridLines><' +
        'AlternatingRowColor>536870911</AlternatingRowColor><CustomColumn' +
        's></CustomColumns></grdMain></TAccountsPayListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TDepositedListGUI", NULL, "<?xml version="' +
        '"1.0"" encoding=""UTF-8"" ?><TDepositedListGUI><grdMain><GridFie' +
        'lds><![CDATA[DepositDate'#9'10'#9'Deposit Date'#9'F'
      'From Account'#9'14'#9'From Account'#9'F'
      'Amount'#9'10'#9'Amount'#9'F'
      'AccountName'#9'14'#9'Account Name'#9'F'
      'Payment Method'#9'13'#9'Payment Method'#9'F'
      'Received From'#9'14'#9'Received From'#9'F'
      'ReferenceNo'#9'12'#9'Reference No'#9'F'
      'Type'#9'11'#9'Type'#9'T'
      'ClassName'#9'14'#9'Department Name'#9'F'
      'Deleted'#9'6'#9'Deleted'#9'F'
      
        'Line Reference'#9'20'#9'Line Reference'#9'F]]></GridFields><TitleFont><Na' +
        'me>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fs' +
        'Bold</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><C' +
        'olor>-2147483640</Color><Style></Style></Font><ShowGridLines>Tru' +
        'e</ShowGridLines><AlternatingRowColor>536870911</AlternatingRowC' +
        'olor><CustomColumns></CustomColumns></grdMain></TDepositedListGU' +
        'I>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmCheque", NULL, "<?xml version=""1.0"" ' +
        'encoding=""UTF-8"" ?><TfrmCheque><grdTransactions><GridFields><!' +
        '[CDATA[AccountName'#9'23'#9'Account Name'#9'F'
      'LineTaxCode'#9'8'#9'Code'#9'F'
      'LineCost'#9'10'#9'Amount (Ex)'#9'F'
      'LineTax'#9'8'#9'Tax'#9'F'
      'Product_Description'#9'21'#9'Memo'#9'F'
      'CustomerJob'#9'17'#9'Customer Job'#9'F'
      'Class'#9'10'#9'Departments'#9'F'
      
        'RelatedPOID'#9'10'#9'RelatedPOID'#9'F]]></GridFields><TitleFont><Name>Ari' +
        'al</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</' +
        'Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-' +
        '2147483640</Color><Style></Style></Font><ShowGridLines>True</Sho' +
        'wGridLines><AlternatingRowColor>536870911</AlternatingRowColor><' +
        'CustomColumns></CustomColumns></grdTransactions></TfrmCheque>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TChequeListGUI", NULL, "<?xml version=""1.' +
        '0"" encoding=""UTF-8"" ?><TChequeListGUI><grdMain><GridFields><!' +
        '[CDATA[OrderDate'#9'12'#9'Order Date'#9'F'
      'Company'#9'23'#9'Company'#9'F'
      'Phone'#9'12'#9'Phone'#9'F'
      'ChequeNumber'#9'11'#9'Cheque Number'#9'F'
      'ReferenceNo'#9'11'#9'Reference No'#9'F'
      'Comments'#9'35'#9'Comments'#9'F'
      'Total Amount (Ex)'#9'14'#9'Total Amount (Ex)'#9'F'
      
        'Deleted'#9'6'#9'Deleted'#9'F]]></GridFields><TitleFont><Name>Arial</Name>' +
        '<Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></T' +
        'itleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214748364' +
        '0</Color><Style></Style></Font><ShowGridLines>True</ShowGridLine' +
        's><AlternatingRowColor>536870911</AlternatingRowColor><CustomCol' +
        'umns></CustomColumns></grdMain></TChequeListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TProdAttribGroupsGUI", NULL, "<?xml versio' +
        'n=""1.0"" encoding=""UTF-8"" ?><TProdAttribGroupsGUI><grdMain><G' +
        'ridFields><![CDATA[Name'#9'34'#9'Name'#9'F'
      'XAttribName'#9'11'#9'X Attrib Name'#9'F'
      'YAttribName'#9'11'#9'Y Attrib Name'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TProdAttribGroupsGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TProductListGUI", NULL, "<?xml version=""1' +
        '.0"" encoding=""UTF-8"" ?><TProductListGUI><grdMain><GridFields>' +
        '<![CDATA[ProductName'#9'24'#9'ProductName'#9'F'
      'FirstColumn'#9'13'#9'FirstColumn'#9'T'#9'Product Group'
      'SecondColumn'#9'14'#9'SecondColumn'#9'T'#9'Product Group'
      'ThirdColumn'#9'12'#9'ThirdColumn'#9'T'#9'Product Group'
      'SalesDescription'#9'17'#9'SalesDescription'#9'F'
      'Available'#9'8'#9'Available'#9'F'#9'Quantity read as Units'
      'In Stock'#9'8'#9'In Stock'#9'F'#9'Quantity read as Units'
      'Allocated SO'#9'10'#9'Allocated SO'#9'F'#9'Quantity read as Units'
      'Allocated BO'#9'10'#9'Allocated BO'#9'F'#9'Quantity read as Units'
      'SO BackOrders'#9'14'#9'SO Back Orders'#9'F'#9'Quantity read as Units'
      'On Order'#9'8'#9'On Order'#9'F'#9'Quantity read as Units'
      'Preferred Supplier'#9'17'#9'Preferred Supplier'#9'F'
      'Sell Qty (A)'#9'10'#9'Sell Qty (A)'#9'F'#9'Sell Qty & Price'
      'Price Inc (A)'#9'10'#9'Price Inc (A)'#9'F'#9'Sell Qty & Price'
      'Sell Qty (B)'#9'10'#9'Sell Qty (B)'#9'F'#9'Sell Qty & Price'
      'Price Inc (B)'#9'10'#9'Price Inc (B)'#9'F'#9'Sell Qty & Price'
      'Sell Qty (C)'#9'10'#9'Sell Qty (C)'#9'F'#9'Sell Qty & Price'
      'Price Inc (C)'#9'10'#9'Price Inc (C)'#9'F'#9'Sell Qty & Price'
      'Wholesale Price'#9'14'#9'Wholesale Price'#9'F'
      'Buy Qty (A)'#9'10'#9'Buy Qty (A)'#9'F'#9'Buy Qty & Cost'
      'Cost Inc (A)'#9'10'#9'Cost Inc (A)'#9'F'#9'Buy Qty & Cost'
      'Buy Qty (B)'#9'10'#9'Buy Qty (B)'#9'F'#9'Buy Qty & Cost'
      'Cost Inc (B)'#9'10'#9'Cost Inc (B)'#9'F'#9'Buy Qty & Cost'
      'Buy Qty (C)'#9'10'#9'Buy Qty (C)'#9'F'#9'Buy Qty & Cost'
      'Cost Inc (C)'#9'9'#9'Cost Inc (C)'#9'F'#9'Buy Qty & Cost'
      'Purchase Description'#9'18'#9'Purchase Description'#9'F'
      'Income Account'#9'14'#9'Income Account'#9'F'#9'Account'
      'Asset Account'#9'14'#9'Asset Account'#9'F'#9'Account'
      
        'Cost of Goods Sold Account'#9'24'#9'Cost of Goods Sold Account'#9'F'#9'Accou' +
        'nt'
      'AvgCost'#9'8'#9'Avg Cost'#9'F'
      'Landed Cost'#9'10'#9'Landed Cost'#9'F'
      'Stock Value'#9'10'#9'Stock Value'#9'T'#9'Value'
      'Value Avg'#9'10'#9'Value Avg'#9'F'#9'Value'
      '%Cost'#9'5'#9'%Cost'#9'F'
      'Barcode'#9'10'#9'Barcode'#9'F'
      'Product Code'#9'11'#9'Product Code'#9'F'
      'ProductTypeCode'#9'14'#9'ProductTypeCode'#9'F'#9'Product Type'
      'Product Type'#9'13'#9'Product Type'#9'F'#9'Product Type'
      'SupplierProductCode'#9'18'#9'SupplierProductCode'#9'F'
      'Taxcode'#9'11'#9'Taxcode'#9'F'#9'Tax Code'
      'Purchase Taxcode'#9'15'#9'Purchase Taxcode'#9'F'#9'Tax Code'
      'DateCreated'#9'11'#9'DateCreated'#9'F'
      'DateUpdated'#9'11'#9'DateUpdated'#9'F'
      'VariancePriceInc'#9'14'#9'VariancePriceInc'#9'T'
      'Area'#9'6'#9'Area'#9'F'
      'Discontinued'#9'10'#9'Discontinued'#9'F'
      
        'OnSpecial'#9'8'#9'OnSpecial'#9'F]]></GridFields><TitleFont><Name>Arial</N' +
        'ame><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style' +
        '></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474' +
        '83640</Color><Style></Style></Font><ShowGridLines>True</ShowGrid' +
        'Lines><AlternatingRowColor>536870911</AlternatingRowColor><Custo' +
        'mColumns></CustomColumns></grdMain></TProductListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TSupplierProductReportGUI", NULL, "<?xml v' +
        'ersion=""1.0"" encoding=""UTF-8"" ?><TSupplierProductReportGUI><' +
        'grdMain><GridFields><![CDATA[Supplier Name'#9'20'#9'Supplier Name'#9'F'
      'Product Name'#9'20'#9'Product'#9'F'
      'Product Description'#9'26'#9'Product Description'#9'F'
      'Shipped'#9'10'#9'Received'#9'F'
      'Line Cost Total(Ex)'#9'15'#9'Line Cost Total(Ex)'#9'F'
      'Department'#9'13'#9'Manufacture'#9'T'
      'Type'#9'12'#9'Type'#9'T'
      'Manufacturer'#9'13'#9'Dept'#9'T'
      'Transaction Type'#9'16'#9'Transaction Type'#9'T'
      'Line Cost (Ex)'#9'11'#9'Line Cost (Ex)'#9'F'
      'Line Tax'#9'10'#9'Line Tax'#9'F'
      'Invoice Number'#9'14'#9'Invoice Number'#9'F'
      'Comments'#9'26'#9'Comments'#9'F'
      'Class Name'#9'15'#9'Department Name'#9'F'
      'AccountName'#9'16'#9'Account Name'#9'F'
      'Product Type'#9'13'#9'Product Type'#9'F'
      'Tax Code'#9'7'#9'Tax Code'#9'F'
      'Deleted'#9'6'#9'Deleted'#9'F'
      'Order Date'#9'13'#9'Order Date'#9'F'
      'Total Amount (Ex)'#9'14'#9'Total Amount (Ex)'#9'F'
      'Total Tax'#9'10'#9'Total Tax'#9'F'
      'Total Amount (Inc)'#9'14'#9'Total Amount (Inc)'#9'F'
      'Employee Name'#9'14'#9'Employee Name'#9'T'
      'DocketNumber'#9'12'#9'Docket Number'#9'F'
      
        'ReceivedDate'#9'11'#9'Received Date'#9'F]]></GridFields><TitleFont><Name>' +
        'Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBol' +
        'd</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style></Style></Font><ShowGridLines>True</' +
        'ShowGridLines><AlternatingRowColor>536870911</AlternatingRowColo' +
        'r><CustomColumns></CustomColumns></grdMain></TSupplierProductRep' +
        'ortGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TSalesReportGUI", NULL, "<?xml version=""1' +
        '.0"" encoding=""UTF-8"" ?><TSalesReportGUI><grdMain><GridFields>' +
        '<![CDATA[CustomerName'#9'16'#9'Customer Name'#9'F'
      'EmployeeName'#9'13'#9'Employee Name'#9'F'
      'ProductName'#9'16'#9'Product'#9'F'
      'ProductDescription'#9'24'#9'Product Description'#9'F'
      'Shipped'#9'10'#9'Shipped'#9'F'
      'TotalAmountEx'#9'13'#9'Total Amount Ex'#9'F'
      'TotalTax'#9'10'#9'Total Tax'#9'F'
      'TotalAmountInc'#9'13'#9'Total Amount Inc'#9'F'
      'Grossprofit'#9'11'#9'Grossprofit'#9'F'
      'PercentProfit'#9'12'#9'Percent Profit'#9'F'
      'ClassName'#9'15'#9'Department Name'#9'F'
      'Manufacturer'#9'10'#9'Manufacture'#9'F'
      'Type'#9'9'#9'Type'#9'F'
      'Department'#9'11'#9'Dept'#9'F'
      'ItemCostEx'#9'12'#9'Item Cost Ex'#9'F'
      'LineCostEx'#9'12'#9'Line Cost Ex'#9'F'
      'LineTax'#9'11'#9'Line Tax'#9'F'
      'LineCostInc'#9'12'#9'Line Cost Inc'#9'F'
      'LineTotalEx'#9'12'#9'Line Total Ex'#9'F'
      'LineTotalInc'#9'12'#9'Line Total Inc'#9'F'
      'SaleDate'#9'10'#9'Sale Date'#9'F'
      'InvoiceNumber'#9'13'#9'Invoice Number'#9'F'
      'Comments'#9'10'#9'Comments'#9'F'
      'Memo'#9'10'#9'Memo'#9'F'
      'Source'#9'13'#9'Source'#9'F'
      'TaxCode'#9'7'#9'Tax Code'#9'F'
      'Till'#9'8'#9'Till'#9'F'
      'TimeOfSale'#9'11'#9'Time Of Sale'#9'F'
      
        'TransactionType'#9'14'#9'Transaction Type'#9'F]]></GridFields><TitleFont>' +
        '<Name>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style' +
        '>fsBold</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size' +
        '><Color>-2147483640</Color><Style></Style></Font><ShowGridLines>' +
        'True</ShowGridLines><AlternatingRowColor>536870911</AlternatingR' +
        'owColor><CustomColumns></CustomColumns></grdMain></TSalesReportG' +
        'UI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmParts", NULL, "<?xml version=""1.0"" e' +
        'ncoding=""UTF-8"" ?><TfrmParts></TfrmParts>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TCustomersOnSupportListGUI", NULL, "<?xml ' +
        'version=""1.0"" encoding=""UTF-8"" ?><TCustomersOnSupportListGUI' +
        '><grdMain><GridFields><![CDATA[Company'#9'18'#9'Company'#9'F'
      'Phone'#9'13'#9'Phone'#9'F'
      'Mobile'#9'13'#9'Mobile'#9'F'
      'FaxNumber'#9'13'#9'Fax Number'#9'F'
      'Active Until'#9'10'#9'Active Until'#9'F'
      'Street'#9'19'#9'Street'#9'F'
      'Suburb'#9'14'#9'Suburb'#9'F'
      'State'#9'4'#9'State'#9'F'
      'Postcode'#9'7'#9'Postcode'#9'F'
      'Country'#9'11'#9'Country'#9'F'
      'StopCredit'#9'9'#9'Stop Credit'#9'F'
      
        'AltPhone'#9'10'#9'Alt Phone'#9'F]]></GridFields><TitleFont><Name>Arial</N' +
        'ame><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style' +
        '></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474' +
        '83640</Color><Style></Style></Font><ShowGridLines>True</ShowGrid' +
        'Lines><AlternatingRowColor>536870911</AlternatingRowColor><Custo' +
        'mColumns></CustomColumns><Columns><Suburb><Visible>True</Visible' +
        '><Index>15</Index><DisplayWidth>27</DisplayWidth><DisplayLabel>S' +
        'uburb</DisplayLabel><Hidden>False</Hidden></Suburb><Street3><Vis' +
        'ible>True</Visible><Index>14</Index><DisplayWidth>40</DisplayWid' +
        'th><DisplayLabel>Street3</DisplayLabel><Hidden>False</Hidden></S' +
        'treet3><Street2><Visible>True</Visible><Index>13</Index><Display' +
        'Width>38</DisplayWidth><DisplayLabel>Street2</DisplayLabel><Hidd' +
        'en>False</Hidden></Street2><Street><Visible>True</Visible><Index' +
        '>12</Index><DisplayWidth>38</DisplayWidth><DisplayLabel>Street</' +
        'DisplayLabel><Hidden>False</Hidden></Street><StopCredit><Visible' +
        '>True</Visible><Index>11</Index><DisplayWidth>1</DisplayWidth><D' +
        'isplayLabel>Stop Credit</DisplayLabel><Hidden>False</Hidden></St' +
        'opCredit><State><Visible>True</Visible><Index>10</Index><Display' +
        'Width>3</DisplayWidth><DisplayLabel>State</DisplayLabel><Hidden>' +
        'False</Hidden></State><Postcode><Visible>True</Visible><Index>9<' +
        '/Index><DisplayWidth>4</DisplayWidth><DisplayLabel>Postcode</Dis' +
        'playLabel><Hidden>False</Hidden></Postcode><Phone><Visible>True<' +
        '/Visible><Index>8</Index><DisplayWidth>10</DisplayWidth><Display' +
        'Label>Phone</DisplayLabel><Hidden>False</Hidden></Phone><Mobile>' +
        '<Visible>True</Visible><Index>7</Index><DisplayWidth>10</Display' +
        'Width><DisplayLabel>Mobile</DisplayLabel><Hidden>False</Hidden><' +
        '/Mobile><GlobalRef><Visible>True</Visible><Index>6</Index><Displ' +
        'ayWidth>15</DisplayWidth><DisplayLabel>Global Ref</DisplayLabel>' +
        '<Hidden>False</Hidden></GlobalRef><FaxNumber><Visible>True</Visi' +
        'ble><Index>5</Index><DisplayWidth>10</DisplayWidth><DisplayLabel' +
        '>Fax Number</DisplayLabel><Hidden>False</Hidden></FaxNumber><Cur' +
        'rent><Visible>True</Visible><Index>4</Index><DisplayWidth>5</Dis' +
        'playWidth><DisplayLabel>Current</DisplayLabel><Hidden>False</Hid' +
        'den></Current><Country><Visible>True</Visible><Index>3</Index><D' +
        'isplayWidth>40</DisplayWidth><DisplayLabel>Country</DisplayLabel' +
        '><Hidden>False</Hidden></Country><Company><Visible>True</Visible' +
        '><Index>2</Index><DisplayWidth>80</DisplayWidth><DisplayLabel>Co' +
        'mpany</DisplayLabel><Hidden>False</Hidden></Company><AltPhone><V' +
        'isible>True</Visible><Index>1</Index><DisplayWidth>10</DisplayWi' +
        'dth><DisplayLabel>Alt Phone</DisplayLabel><Hidden>False</Hidden>' +
        '</AltPhone><Active_x20_Until><Visible>True</Visible><Index>0</In' +
        'dex><DisplayWidth>10</DisplayWidth><DisplayLabel>Active Until</D' +
        'isplayLabel><Hidden>False</Hidden></Active_x20_Until><ClientID><' +
        'Hidden>False</Hidden><Visible>False</Visible><Index>18</Index><D' +
        'isplayWidth>10</DisplayWidth><DisplayLabel>Client ID</DisplayLab' +
        'el></ClientID><ID><Hidden>False</Hidden><Visible>False</Visible>' +
        '<Index>18</Index><DisplayWidth>10</DisplayWidth><DisplayLabel>ID' +
        '</DisplayLabel></ID></Columns></grdMain></TCustomersOnSupportLis' +
        'tGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TPhSupportLogListGUI", NULL, "<?xml versio' +
        'n=""1.0"" encoding=""UTF-8"" ?><TPhSupportLogListGUI><grdMain><G' +
        'ridFields><![CDATA[DateCreated'#9'18'#9'Date Created'#9'F'
      'Company'#9'14'#9'Company'#9'F'
      'Contact'#9'14'#9'Contact'#9'F'
      'CallTime'#9'7'#9'Call Time'#9'F'
      'Issue'#9'23'#9'Issue'#9'F'
      'Solution'#9'29'#9'Solution'#9'F'
      'Version'#9'6'#9'Version'#9'F'
      'EnteredBy'#9'11'#9'Entered By'#9'F'
      
        'Finished'#9'6'#9'Finished'#9'F]]></GridFields><TitleFont><Name>Arial</Nam' +
        'e><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style><' +
        '/TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483' +
        '640</Color><Style></Style></Font><ShowGridLines>True</ShowGridLi' +
        'nes><AlternatingRowColor>536870911</AlternatingRowColor><CustomC' +
        'olumns></CustomColumns></grdMain></TPhSupportLogListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TReconListGUI", NULL, "<?xml version=""1.0' +
        '"" encoding=""UTF-8"" ?><TReconListGUI><grdMain><GridFields><![C' +
        'DATA[ReconciliationDate'#9'15'#9'Reconciliation Date'#9'F'
      'AccountName'#9'14'#9'Account Name'#9'F'
      'StatementNo'#9'11'#9'Statement No'#9'F'
      'ClassName'#9'14'#9'Department Name'#9'F'
      'Notes'#9'21'#9'Notes'#9'F'
      'OpenBalance'#9'13'#9'Open Balance'#9'F'
      'CloseBalance'#9'13'#9'Close Balance'#9'F'
      'EmployeeName'#9'16'#9'Employee Name'#9'T'
      
        'Finished'#9'6'#9'Finished'#9'F]]></GridFields><TitleFont><Name>Arial</Nam' +
        'e><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style><' +
        '/TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483' +
        '640</Color><Style></Style></Font><ShowGridLines>True</ShowGridLi' +
        'nes><AlternatingRowColor>536870911</AlternatingRowColor><CustomC' +
        'olumns></CustomColumns></grdMain></TReconListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBankAccountListGUI", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TBankAccountListGUI><grdMain><Gri' +
        'dFields><![CDATA[Date'#9'10'#9'Date'#9'F'
      'AccountName'#9'12'#9'Account Name'#9'F'
      'Type'#9'17'#9'Type'#9'F'
      'Chq/RefNo'#9'10'#9'Chq/Ref No'#9'F'
      'Amount'#9'12'#9'Amount'#9'F'
      'Reconciled'#9'9'#9'Reconciled'#9'F'
      'Notes'#9'47'#9'Notes'#9'F'
      
        'ClassName'#9'15'#9'Department Name'#9'F]]></GridFields><TitleFont><Name>A' +
        'rial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold' +
        '</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color' +
        '>-2147483640</Color><Style></Style></Font><ShowGridLines>True</S' +
        'howGridLines><AlternatingRowColor>536870911</AlternatingRowColor' +
        '><CustomColumns></CustomColumns></grdMain></TBankAccountListGUI>' +
        '");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBudgetDefGUI", NULL, "<?xml version=""1.0' +
        '"" encoding=""UTF-8"" ?><TBudgetDefGUI><grdMain><GridFields><![C' +
        'DATA[Name'#9'20'#9'Name'#9'F'
      'Description'#9'35'#9'Description'#9'F'
      'StartDate'#9'12'#9'Start Date'#9'F'
      'EndDate'#9'11'#9'End Date'#9'F'
      'IntervalPeriod'#9'11'#9'Interval Period'#9'F'
      'IntervalDuration'#9'13'#9'Interval Duration'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TBudgetDefGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBudgetGUI", NULL, "<?xml version=""1.0"" ' +
        'encoding=""UTF-8"" ?><TBudgetGUI><grdMain><GridFields><![CDATA[N' +
        'ame'#9'13'#9'Name'#9'F'
      'Description'#9'36'#9'Description'#9'F'
      'StartDate'#9'13'#9'Start Date'#9'F'
      'EndDate'#9'11'#9'End Date'#9'F'
      
        'BudgetNo'#9'8'#9'Budget No'#9'F]]></GridFields><TitleFont><Name>Arial</Na' +
        'me><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style>' +
        '</TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214748' +
        '3640</Color><Style></Style></Font><ShowGridLines>True</ShowGridL' +
        'ines><AlternatingRowColor>536870911</AlternatingRowColor><Custom' +
        'Columns></CustomColumns></grdMain></TBudgetGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TChartOfAccountsListGUI", NULL, "<?xml ver' +
        'sion=""1.0"" encoding=""UTF-8"" ?><TChartOfAccountsListGUI><grdM' +
        'ain><GridFields><![CDATA[FullAccountName'#9'29'#9'Full Account Name'#9'F'
      'Description'#9'18'#9'Description'#9'F'
      'AccountTree'#9'24'#9'Account Tree'#9'T'
      'Balance'#9'10'#9'Balance'#9'F'
      'TotalBalance'#9'12'#9'Total Balance'#9'F'
      'Type'#9'19'#9'Type'#9'F'
      'BankAccountName'#9'18'#9'Bank Account Name'#9'F'
      'BSB'#9'4'#9'BSB'#9'F'
      'BankAccNo'#9'11'#9'Bank Acc No'#9'F'
      'TaxCode'#9'7'#9'Tax Code'#9'F'
      'TaxCodeDescription'#9'21'#9'Tax Code Description'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TChartOfAccountsListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TJobBudgetVsActual", NULL, "<?xml version=' +
        '""1.0"" encoding=""UTF-8"" ?><TJobBudgetVsActual><grdMain><GridF' +
        'ields><![CDATA[AccountName'#9'20'#9'Account Name'#9'F'
      'AccountType'#9'20'#9'Account Type'#9'F'
      'ClientName'#9'20'#9'Job'#9'F'
      'Actual'#9'10'#9'Actual'#9'F'
      'Aggressive'#9'10'#9'Amount'#9'F'#9'Aggressive'
      'Aggressive_var'#9'10'#9'Variation'#9'F'#9'Aggressive'
      'Aggressive_varPerc'#9'10'#9'Varn Percentage'#9'F'#9'Aggressive'
      'Conservative'#9'10'#9'Amount'#9'F'#9'Conservative'
      'Conservative_var'#9'10'#9'Variation'#9'F'#9'Conservative'
      'Conservative_varPerc'#9'10'#9'Varn Perc'#9'F'#9'Conservative'
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor><CustomColumns></CustomColumn' +
        's></grdMain></TJobBudgetVsActual>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmOthersList", NULL, "<?xml version=""1.' +
        '0"" encoding=""UTF-8"" ?><TfrmOthersList><grdMain><GridFields><!' +
        '[CDATA[CompanyName'#9'14'#9'Company Name'#9'F'
      'ContactName'#9'15'#9'Contact Name'#9'T'
      'Phone'#9'12'#9'Phone'#9'F'
      'Mobile'#9'14'#9'Mobile'#9'F'
      'Email'#9'20'#9'Email'#9'F'
      'Employee'#9'12'#9'Employee'#9'T'
      'Street'#9'14'#9'Street'#9'F'
      'Suburb'#9'13'#9'Suburb'#9'F'
      'State'#9'4'#9'State'#9'F'
      'Postcode'#9'7'#9'Postcode'#9'F'
      'Country'#9'12'#9'Country'#9'F'
      'FaxNumber'#9'15'#9'Fax Number'#9'F'
      'AltPhone'#9'13'#9'Alt Phone'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TfrmOthersList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmMarketingRatios", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TfrmMarketingRatios><grdMain><Gri' +
        'dFields><![CDATA[Source'#9'20'#9'Source'#9'F'#9
      'Calls'#9'10'#9'Calls'#9#9
      'DMContacted'#9'10'#9'DMContacted'#9#9
      'Leads'#9'10'#9'Leads'#9#9
      'Approved'#9'10'#9'Approved'#9#9
      'NotApproved'#9'10'#9'NotApproved'#9#9
      'CallsApprovedRatio'#9'10'#9'CallsApprovedRatio'#9'F'#9
      'Sales'#9'10'#9'Sales'#9#9
      'CallsSalesRatio'#9'10'#9'CallsSalesRatio'#9'F'#9
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor></grdMain></TfrmMarketingRati' +
        'os>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TCanvasserListGUI", NULL, "<?xml version="' +
        '"1.0"" encoding=""UTF-8"" ?><TCanvasserListGUI><grdMain><GridFie' +
        'lds><![CDATA[Employee Name'#9'19'#9'Employee Name'#9'F'
      'Phone'#9'18'#9'Phone'#9'F'
      'Mobile'#9'14'#9'Mobile'#9'F'
      'Fax Number'#9'11'#9'Fax Number'#9'F'
      'Address'#9'20'#9'Address'#9'F'
      'Suburb'#9'13'#9'Suburb'#9'F'
      'State'#9'19'#9'State'#9'F'
      'Postcode'#9'8'#9'Postcode'#9'F'
      'Country'#9'17'#9'Country'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TCanvasserListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TSmartOrderGUI", NULL, "<?xml version=""1.' +
        '0"" encoding=""UTF-8"" ?><TSmartOrderGUI><grdLines><GridFields><' +
        '![CDATA[PARTSNAME'#9'21'#9'Name ""F5,F6,F7""'#9'F'
      'UnitofMeasure'#9'10'#9'Unit'#9'F'
      'UnitofMeasureQty'#9'5'#9'Qty'#9'F'
      'PODesc'#9'35'#9'Description'#9'F'
      'CusJobName'#9'18'#9'Customer: Job'#9'F'
      'ClassName'#9'12'#9'Department'#9'F'
      'CostInc'#9'9'#9'Cost (Inc)'#9'F'
      
        'SupplierName'#9'20'#9'Supplier'#9'F]]></GridFields><TitleFont><Name>Arial' +
        '</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</St' +
        'yle></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21' +
        '47483640</Color><Style></Style></Font><ShowGridLines>True</ShowG' +
        'ridLines><AlternatingRowColor>536870911</AlternatingRowColor><Cu' +
        'stomColumns></CustomColumns></grdLines></TSmartOrderGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmAwardsList", NULL, "<?xml version=""1.' +
        '0"" encoding=""UTF-8"" ?><TfrmAwardsList><grdMain><GridFields><!' +
        '[CDATA[Award Name'#9'22'#9'Award Name'#9'F'
      'Pay Period'#9'10'#9'Pay Period'#9'F'
      'Super Type'#9'19'#9'Super Type'#9'F'
      'Super Value'#9'12'#9'Super Value'#9'T'
      'A/L Loading'#9'12'#9'A/L Loading'#9'F'
      'Department'#9'13'#9'Department'#9'F'
      
        'Active'#9'8'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TfrmAwardsList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TSourceListGUI", NULL, "<?xml version=""1.' +
        '0"" encoding=""UTF-8"" ?><TSourceListGUI><grdMain><GridFields><!' +
        '[CDATA[Source Name'#9'20'#9'Source Name'#9'F'
      'SuccessRate'#9'13'#9'Success Rate'#9'F'
      'Enquiries'#9'8'#9'Enquiries'#9'F'
      'Appointment Count'#9'15'#9'Appointment Count'#9'F'
      'Account Name'#9'18'#9'Account Name'#9'F'
      'Estimated Cost'#9'15'#9'Estimated Cost (Ex)'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TSourceListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmSalesPipelineReport", NULL, "<?xml ver' +
        'sion=""1.0"" encoding=""UTF-8"" ?><TfrmSalesPipelineReport><grdM' +
        'ain><GridFields><![CDATA[LeadStatus'#9'15'#9'Quote/LeadStatus'#9'F'
      'Action'#9'10'#9'Action'#9'F'
      'Company'#9'20'#9'Company'#9'F'
      'ActionDate'#9'12'#9'Date'#9'F'
      'Rep'#9'15'#9'Rep'#9'F'
      'Notes'#9'35'#9'Notes'#9'F'
      'LeadCount'#9'10'#9'LeadCount'#9'F'
      
        'QuoteValue'#9'13'#9'Quote Value'#9'F]]></GridFields><TitleFont><Name>Aria' +
        'l</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</S' +
        'tyle></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2' +
        '147483640</Color><Style></Style></Font><ShowGridLines>True</Show' +
        'GridLines><AlternatingRowColor>536870911</AlternatingRowColor><C' +
        'ustomColumns></CustomColumns></grdMain></TfrmSalesPipelineReport' +
        '>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmMailMergeHistoryList", NULL, "<?xml ve' +
        'rsion=""1.0"" encoding=""UTF-8"" ?><TfrmMailMergeHistoryList><gr' +
        'dMain><GridFields><![CDATA[RecipientName'#9'20'#9'Recipient Name'#9'F'
      'MMGroup'#9'20'#9'MM Group'#9'F'
      'DocumentName'#9'20'#9'Document Name'#9'F'
      'DateSent'#9'22'#9'Date Sent'#9'F'
      
        'Success'#9'8'#9'Success'#9'F]]></GridFields><TitleFont><Name>Arial</Name>' +
        '<Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></T' +
        'itleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214748364' +
        '0</Color><Style></Style></Font><ShowGridLines>True</ShowGridLine' +
        's><AlternatingRowColor>536870911</AlternatingRowColor><CustomCol' +
        'umns></CustomColumns></grdMain></TfrmMailMergeHistoryList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmProductRewardPointsList", NULL, "<?xml ' +
        'version=""1.0"" encoding=""UTF-8"" ?><TfmProductRewardPointsList' +
        '><grdMain><GridFields><![CDATA[PartName'#9'26'#9'Part Name'#9'F'
      'Points'#9'11'#9'Points'#9'F'
      'Value'#9'11'#9'Value'#9'F'
      'DateCreated'#9'16'#9'Date Created'#9'F'
      'DateFrom'#9'13'#9'Date From'#9'F'
      'DateTo'#9'13'#9'Date To'#9'F'
      'UseDate'#9'7'#9'Use Date'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TfmProductRewardPointsList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TFeedbackListGUI", NULL, "<?xml version=""' +
        '1.0"" encoding=""UTF-8"" ?><TFeedbackListGUI><grdMain><GridField' +
        's><![CDATA[Company'#9'20'#9'Company'#9'F'
      'Date'#9'10'#9'Date'#9'F'
      'FeedbackNotes'#9'33'#9'Feedback Notes'#9'F'
      'Rep'#9'11'#9'Rep'#9'F'
      'Notes'#9'34'#9'Notes'#9'F'
      'Type'#9'7'#9'Type'#9'F'
      'Class'#9'10'#9'Department'#9'F'
      
        'Cancellation'#9'10'#9'Cancellation'#9'F]]></GridFields><TitleFont><Name>A' +
        'rial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold' +
        '</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color' +
        '>-2147483640</Color><Style></Style></Font><ShowGridLines>True</S' +
        'howGridLines><AlternatingRowColor>536870911</AlternatingRowColor' +
        '><CustomColumns></CustomColumns></grdMain></TFeedbackListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TManifestVehiclesListGUI", NULL, "<?xml ve' +
        'rsion=""1.0"" encoding=""UTF-8"" ?><TManifestVehiclesListGUI><gr' +
        'dMain><GridFields><![CDATA[OwnerName'#9'20'#9'Owner Name'#9'F'
      'VehicleName'#9'14'#9'Vehicle Name'#9'F'
      'RegistrationNo'#9'12'#9'Registration No'#9'F'
      'Trailer'#9'15'#9'Trailer'#9'F'
      'Driver'#9'15'#9'Driver'#9'F'
      'Phone'#9'16'#9'Phone'#9'F'
      'Notes'#9'24'#9'Notes'#9'F'
      'Rate (%)'#9'10'#9'Rate (%)'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TManifestVehiclesListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TManifestRouteListGUI", NULL, "<?xml versi' +
        'on=""1.0"" encoding=""UTF-8"" ?><TManifestRouteListGUI><grdMain>' +
        '<GridFields><![CDATA[From'#9'30'#9'From'#9'F'
      'To'#9'30'#9'To'#9'F'
      'RouteDesc'#9'39'#9'Route Desc'#9'F'
      'Distance'#9'10'#9'Distance'#9'F'
      
        'PaletteRate'#9'10'#9'Palette Rate'#9'F]]></GridFields><TitleFont><Name>Ar' +
        'ial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold<' +
        '/Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>' +
        '-2147483640</Color><Style></Style></Font><ShowGridLines>True</Sh' +
        'owGridLines><AlternatingRowColor>536870911</AlternatingRowColor>' +
        '<CustomColumns></CustomColumns></grdMain></TManifestRouteListGUI' +
        '>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TManifestAllocationListGUI", NULL, "<?xml ' +
        'version=""1.0"" encoding=""UTF-8"" ?><TManifestAllocationListGUI' +
        '><grdMain><GridFields><![CDATA[InvoiceNo'#9'10'#9'Invoice No'#9'T'
      'From'#9'19'#9'From'#9'T'
      'Fromcity'#9'18'#9'Fromcity'#9'F'
      'FromState'#9'11'#9'From State'#9'F'
      'FromPostCode'#9'13'#9'From Post Code'#9'F'
      'To'#9'8'#9'To'#9'T'
      'ToCity'#9'10'#9'To City'#9'T'
      'ToPostcode'#9'10'#9'To Postcode'#9'T'
      'ToState'#9'6'#9'To State'#9'T'
      'AddToManifest'#9'13'#9'Add To Manifest'#9'F'
      
        'IsSalesOrder'#9'11'#9'Is Sales Order'#9'F]]></GridFields><TitleFont><Name' +
        '>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBo' +
        'ld</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Col' +
        'or>-2147483640</Color><Style></Style></Font><ShowGridLines>True<' +
        '/ShowGridLines><AlternatingRowColor>536870911</AlternatingRowCol' +
        'or><CustomColumns></CustomColumns></grdMain></TManifestAllocatio' +
        'nListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TManifestListGUI", NULL, "<?xml version=""' +
        '1.0"" encoding=""UTF-8"" ?><TManifestListGUI><grdMain><GridField' +
        's><![CDATA[OwnerName'#9'21'#9'Owner Name'#9'F'
      'Vehicle'#9'15'#9'Vehicle'#9'F'
      'Driver'#9'14'#9'Driver'#9'F'
      'Phone'#9'13'#9'Phone'#9'F'
      'ManifestNo'#9'10'#9'Manifest No'#9'F'
      'DespatchDate'#9'11'#9'Despatch Date'#9'F'
      'Distance (Km)'#9'11'#9'Distance (Km)'#9'F'
      'FromCity'#9'11'#9'From City'#9'F'
      'FromState'#9'9'#9'From State'#9'F'
      'FromPostcode'#9'13'#9'From Postcode'#9'F'
      'ToCity'#9'13'#9'To City'#9'F'
      'ToState'#9'7'#9'To State'#9'F'
      'ToPostcode'#9'10'#9'To Postcode'#9'F'
      'Route'#9'8'#9'Route'#9'F'
      'Notes'#9'22'#9'Notes'#9'F'
      
        'Completed'#9'8'#9'Completed'#9'F]]></GridFields><TitleFont><Name>Arial</N' +
        'ame><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style' +
        '></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474' +
        '83640</Color><Style></Style></Font><ShowGridLines>True</ShowGrid' +
        'Lines><AlternatingRowColor>536870911</AlternatingRowColor><Custo' +
        'mColumns></CustomColumns></grdMain></TManifestListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TRepListGUI", NULL, "<?xml version=""1.0""' +
        ' encoding=""UTF-8"" ?><TRepListGUI><grdMain><GridFields><![CDATA' +
        '[Employee Name'#9'16'#9'Employee Name'#9'T'
      'Phone'#9'13'#9'Phone'#9'F'
      'Mobile'#9'12'#9'Mobile'#9'F'
      'Fax Number'#9'13'#9'Fax Number'#9'F'
      'Address'#9'31'#9'Address'#9'T'
      'Suburb'#9'16'#9'Suburb'#9'F'
      'State'#9'6'#9'State'#9'F'
      'Postcode'#9'7'#9'Postcode'#9'F'
      'Country'#9'7'#9'Country'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TRepListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TTaxCodeListGUI", NULL, "<?xml version=""1' +
        '.0"" encoding=""UTF-8"" ?><TTaxCodeListGUI><grdMain><GridFields>' +
        '<![CDATA[Name'#9'13'#9'Name'#9'F'
      'Description'#9'50'#9'Description'#9'F'
      'Rate'#9'10'#9'Rate'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TTaxCodeListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TToDoListGUI", NULL, "<?xml version=""1.0"' +
        '" encoding=""UTF-8"" ?><TToDoListGUI><grdMain><GridFields><![CDA' +
        'TA[Employee Name'#9'14'#9'Employee Name'#9'F'
      'ToDoByDate'#9'21'#9'To Do By Date'#9'F'
      'Result'#9'5'#9'Result'#9'F'
      'Done'#9'4'#9'Done'#9'F'
      'Created By'#9'9'#9'Created By'#9'F'
      'Description'#9'52'#9'Description'#9'F'
      'CreatedDate'#9'18'#9'Created Date'#9'F'
      
        'Completed'#9'8'#9'Completed'#9'F]]></GridFields><TitleFont><Name>Arial</N' +
        'ame><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style' +
        '></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474' +
        '83640</Color><Style></Style></Font><ShowGridLines>True</ShowGrid' +
        'Lines><AlternatingRowColor>536870911</AlternatingRowColor><Custo' +
        'mColumns></CustomColumns></grdMain></TToDoListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TRosterListGUI", NULL, "<?xml version=""1.' +
        '0"" encoding=""UTF-8"" ?><TRosterListGUI><grdMain><GridFields><!' +
        '[CDATA[EmployeeName'#9'21'#9'Employee Name'#9'F'
      'ClassName'#9'21'#9'Department Name'#9'F'
      'StartTime'#9'20'#9'Start Time'#9'F'
      'End Time'#9'22'#9'End Time'#9'F'
      'ClockedOff'#9'9'#9'Clocked Off'#9'F'
      'StartedLate'#9'12'#9'Started Late'#9'F'
      
        'FinishedEarly'#9'12'#9'Finished Early'#9'F]]></GridFields><TitleFont><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsB' +
        'old</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Co' +
        'lor>-2147483640</Color><Style></Style></Font><ShowGridLines>True' +
        '</ShowGridLines><AlternatingRowColor>536870911</AlternatingRowCo' +
        'lor><CustomColumns></CustomColumns></grdMain></TRosterListGUI>")' +
        ';'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TFixedAssetsListGUI", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TFixedAssetsListGUI><grdMain><Gri' +
        'dFields><![CDATA[AssetName'#9'18'#9'Asset Name'#9'F'
      'Colour'#9'7'#9'Colour'#9'F'
      'BrandName'#9'11'#9'Brand Name'#9'F'
      'Manufacture'#9'11'#9'Manufacture'#9'F'
      'Model'#9'7'#9'Model'#9'F'
      'AssetCode'#9'10'#9'Asset Code'#9'F'
      'AssetType'#9'9'#9'Asset Type'#9'F'
      'Class'#9'11'#9'Department'#9'F'
      'PurchDate'#9'10'#9'Purch Date'#9'F'
      'PurchCost'#9'12'#9'Purch Cost'#9'F'
      'Serial'#9'9'#9'Serial'#9'F'
      'Qty'#9'10'#9'Qty'#9'F'
      'AssetCondition'#9'14'#9'Asset Condition'#9'F'
      'LocationDescription'#9'19'#9'Location Description'#9'F'
      'Notes'#9'15'#9'Notes'#9'T'
      'Size'#9'5'#9'Size'#9'F'
      'Shape'#9'7'#9'Shape'#9'F'
      'Status'#9'8'#9'Status'#9'F'
      'BusinessUse (%)'#9'14'#9'Business Use (%)'#9'F'
      'EstimatedValue'#9'13'#9'Estimated Value'#9'F'
      'ReplacementCost'#9'14'#9'Replacement Cost'#9'F'
      'WarrantyType'#9'12'#9'Warranty Type'#9'F'
      'WarrantyExpiresDate'#9'18'#9'Warranty Expires Date'#9'F'
      'InsuredBy'#9'9'#9'Insured By'#9'F'
      'InsurancePolicy'#9'14'#9'Insurance Policy'#9'F'
      'InsuredUntil'#9'10'#9'Insured Until'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TFixedAssetsListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TFixedAssetTypeListGUI", NULL, "<?xml vers' +
        'ion=""1.0"" encoding=""UTF-8"" ?><TFixedAssetTypeListGUI><grdMai' +
        'n><GridFields><![CDATA[AssetTypeName'#9'20'#9'Asset Type Name'#9'F'
      'AssetTypeCode'#9'14'#9'Asset Type Code'#9'F'
      'Notes'#9'40'#9'Notes'#9'T'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TFixedAssetTypeListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TServiceLogListGUI", NULL, "<?xml version=' +
        '""1.0"" encoding=""UTF-8"" ?><TServiceLogListGUI><grdMain><GridF' +
        'ields><![CDATA[AssetName'#9'29'#9'AssetName'#9'F'
      'ServiceProvider'#9'29'#9'ServiceProvider'#9'F'
      'AssetCode'#9'11'#9'AssetCode'#9'F'
      'ServiceDate'#9'12'#9'ServiceDate'#9'F'
      'NextServiceDate'#9'13'#9'NextServiceDate'#9'F'
      'ServiceNotes'#9'23'#9'ServiceNotes'#9'F'
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor><CustomColumns></CustomColumn' +
        's></grdMain></TServiceLogListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TCheckWarranty_InsurancePolicyGUI", NULL, ' +
        '"<?xml version=""1.0"" encoding=""UTF-8"" ?><TCheckWarranty_Insu' +
        'rancePolicyGUI><grdMain><GridFields><![CDATA[AssetName'#9'20'#9'Asset ' +
        'Name'#9'F'
      'Colour'#9'7'#9'Colour'#9'F'
      'BrandName'#9'13'#9'Brand Name'#9'F'
      'Manufacture'#9'13'#9'Manufacture'#9'F'
      'Model'#9'6'#9'Model'#9'F'
      'AssetCode'#9'10'#9'Asset Code'#9'F'
      'InsuredBy'#9'11'#9'Insured By'#9'F'
      'InsurancePolicy'#9'14'#9'Insurance Policy'#9'F'
      'InsuredUntil'#9'10'#9'Insured Until'#9'F'
      'WarrantyType'#9'10'#9'Warranty Type'#9'F'
      'WarrantyExpiresDate'#9'18'#9'Warranty Expires Date'#9'F'
      'AssetType'#9'9'#9'Asset Type'#9'F'
      'Class'#9'9'#9'Department'#9'F'
      'PurchDate'#9'10'#9'Purch Date'#9'F'
      'Branch'#9'6'#9'Branch'#9'F'
      'Serial'#9'7'#9'Serial'#9'F'
      'Notes'#9'27'#9'Notes'#9'F'
      'Qty'#9'10'#9'Qty'#9'F'
      'AssetCondition'#9'13'#9'Asset Condition'#9'F'
      'Size'#9'6'#9'Size'#9'F'
      'Shape'#9'6'#9'Shape'#9'F'
      'Status'#9'8'#9'Status'#9'F'
      'PurchCost'#9'10'#9'Purch Cost'#9'F'
      'EstimatedValue'#9'13'#9'Estimated Value'#9'F'
      'ReplacementCost'#9'14'#9'Replacement Cost'#9'F'
      
        'BusinessUse (%)'#9'14'#9'Business Use (%)'#9'F]]></GridFields><TitleFont>' +
        '<Name>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style' +
        '>fsBold</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size' +
        '><Color>-2147483640</Color><Style></Style></Font><ShowGridLines>' +
        'True</ShowGridLines><AlternatingRowColor>536870911</AlternatingR' +
        'owColor><CustomColumns></CustomColumns></grdMain></TCheckWarrant' +
        'y_InsurancePolicyGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TShippingListGUI", NULL, "<?xml version=""' +
        '1.0"" encoding=""UTF-8"" ?><TShippingListGUI><grdMain><GridField' +
        's><![CDATA[ShippingMethod'#9'41'#9'Shipping Method'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TShippingListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TLocationListGUI", NULL, "<?xml version=""' +
        '1.0"" encoding=""UTF-8"" ?><TLocationListGUI><grdMain><GridField' +
        's><![CDATA[Suburb'#9'33'#9'Suburb'#9'F'
      'State'#9'6'#9'State'#9'F'
      'Postcode'#9'11'#9'Postcode'#9'F'
      
        'Country'#9'9'#9'Country'#9'F]]></GridFields><TitleFont><Name>Arial</Name>' +
        '<Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></T' +
        'itleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214748364' +
        '0</Color><Style></Style></Font><ShowGridLines>True</ShowGridLine' +
        's><AlternatingRowColor>536870911</AlternatingRowColor><CustomCol' +
        'umns></CustomColumns></grdMain></TLocationListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TClassListGUI", NULL, "<?xml version=""1.0' +
        '"" encoding=""UTF-8"" ?><TClassListGUI><grdMain><GridFields><![C' +
        'DATA[ClassName'#9'19'#9'Department Name'#9'F'
      'Description'#9'29'#9'Description'#9'F'
      'HeaderClass'#9'20'#9'Header Department'#9'F'
      'FullClassName'#9'20'#9'Full Department Name'#9'F'
      'ClassTree'#9'17'#9'Department Tree'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TClassListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TTermsListGUI", NULL, "<?xml version=""1.0' +
        '"" encoding=""UTF-8"" ?><TTermsListGUI><grdMain><GridFields><![C' +
        'DATA[Terms'#9'20'#9'Terms'#9'F'
      'Description'#9'50'#9'Description'#9'F'
      'TermsAmount'#9'12'#9'Terms Amount'#9'F'
      'EOM'#9'8'#9'EOM'#9'F'
      'EOMPlus'#9'9'#9'EOM Plus'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TTermsListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TForeignExchangeRatesListGUI", NULL, "<?xm' +
        'l version=""1.0"" encoding=""UTF-8"" ?><TForeignExchangeRatesLis' +
        'tGUI><grdMain><GridFields><![CDATA[Country'#9'40'#9'Country'#9'F'
      'Currency'#9'13'#9'Currency'#9'F'
      'Code'#9'10'#9'Code'#9'F'
      'BuyRate'#9'11'#9'Buy Rate'#9'F'
      'SellRate'#9'10'#9'Sell Rate'#9'F'
      'RateLastModified'#9'15'#9'Rate Last Modified'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TForeignExchangeRatesListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TMemTransListGUI", NULL, "<?xml version=""' +
        '1.0"" encoding=""UTF-8"" ?><TMemTransListGUI><grdMain><GridField' +
        's><![CDATA[DateDue'#9'10'#9'Date Due'#9'F'
      'Company'#9'27'#9'Company'#9'F'
      'Type'#9'26'#9'Type'#9'F'
      
        'AutoPost'#9'7'#9'Auto Post'#9'F]]></GridFields><TitleFont><Name>Arial</Na' +
        'me><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style>' +
        '</TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214748' +
        '3640</Color><Style></Style></Font><ShowGridLines>True</ShowGridL' +
        'ines><AlternatingRowColor>536870911</AlternatingRowColor><Custom' +
        'Columns></CustomColumns></grdMain></TMemTransListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TPickSlipGUI", NULL, "<?xml version=""1.0"' +
        '" encoding=""UTF-8"" ?><TPickSlipGUI><grdMain><GridFields><![CDA' +
        'TA[Sale Date'#9'10'#9'Sale Date'#9'F'
      'Product Name'#9'17'#9'Product'#9'F'
      'FirstColumn'#9'12'#9'Manufacture'#9'F'
      'SecondColumn'#9'12'#9'Type'#9'F'
      'ThirdColumn'#9'14'#9'Dept'#9'F'
      'Sales Description'#9'31'#9'Sales Description'#9'F'
      'Shipping'#9'13'#9'Shipping'#9'F'
      'Comments'#9'10'#9'Comments'#9'F'
      'PickPrintFlag'#9'11'#9'Pick Print Flag'#9'F'
      'Area'#9'13'#9'Area'#9'F'
      
        'Type'#9'8'#9'Type'#9'F]]></GridFields><TitleFont><Name>Arial</Name><Size>' +
        '9</Size><Color>-2147483640</Color><Style>fsBold</Style></TitleFo' +
        'nt><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</Col' +
        'or><Style></Style></Font><ShowGridLines>True</ShowGridLines><Alt' +
        'ernatingRowColor>536870911</AlternatingRowColor><CustomColumns><' +
        '/CustomColumns></grdMain></TPickSlipGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TStockAdjustEntryListGUI", NULL, "<?xml ve' +
        'rsion=""1.0"" encoding=""UTF-8"" ?><TStockAdjustEntryListGUI><gr' +
        'dMain><GridFields><![CDATA[CreationDate'#9'12'#9'Creation Date'#9'F'
      'Accountname'#9'20'#9'Accountname'#9'F'
      'Notes'#9'41'#9'Notes'#9'F'
      'Employee'#9'16'#9'Employee'#9'F'
      'IsStocktake'#9'10'#9'Is Stocktake'#9'F'
      'Deleted'#9'6'#9'Deleted'#9'F'
      'Processed'#9'8'#9'Processed'#9'F'
      
        'Adjustmentdate'#9'12'#9'Adjustmentdate'#9'F]]></GridFields><TitleFont><Na' +
        'me>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fs' +
        'Bold</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><C' +
        'olor>-2147483640</Color><Style></Style></Font><ShowGridLines>Tru' +
        'e</ShowGridLines><AlternatingRowColor>536870911</AlternatingRowC' +
        'olor><CustomColumns></CustomColumns></grdMain></TStockAdjustEntr' +
        'yListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TStockTransferEntryListGUI", NULL, "<?xml ' +
        'version=""1.0"" encoding=""UTF-8"" ?><TStockTransferEntryListGUI' +
        '><grdMain><GridFields><![CDATA[TransferFromClassName'#9'26'#9'Transfer' +
        ' From Department Name'#9'F'
      'EmployeeName'#9'16'#9'Employee Name'#9'F'
      'Notes'#9'30'#9'Notes'#9'F'
      'DateTransferred'#9'13'#9'Date Transferred'#9'F'
      'Processed'#9'8'#9'Processed'#9'F'
      'Deleted'#9'6'#9'Deleted'#9'F'
      
        'Accountname'#9'24'#9'Accountname'#9'F]]></GridFields><TitleFont><Name>Ari' +
        'al</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</' +
        'Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-' +
        '2147483640</Color><Style></Style></Font><ShowGridLines>True</Sho' +
        'wGridLines><AlternatingRowColor>536870911</AlternatingRowColor><' +
        'CustomColumns></CustomColumns></grdMain></TStockTransferEntryLis' +
        'tGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TSerialNumbersGUI", NULL, "<?xml version="' +
        '"1.0"" encoding=""UTF-8"" ?><TSerialNumbersGUI><grdMain><GridFie' +
        'lds><![CDATA[ProductName'#9'20'#9'Product Name'#9'F'
      'Serialnumber'#9'11'#9'Serial Number'#9'F'
      'allocType'#9'15'#9'Status'#9'F'
      'Classname'#9'17'#9'Department'#9'F'
      'TransDate'#9'18'#9'Last Transaction Date'#9'F'
      'Batchnumber'#9'15'#9'Batch Number'#9'F'
      'binLocation'#9'15'#9'Bin Location'#9'F'
      'Binnumber'#9'10'#9'Bin Number'#9'F'
      
        'UOM'#9'10'#9'UOM'#9'F]]></GridFields><TitleFont><Name>Arial</Name><Size>9' +
        '</Size><Color>-2147483640</Color><Style>fsBold</Style></TitleFon' +
        't><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</Colo' +
        'r><Style></Style></Font><ShowGridLines>True</ShowGridLines><Alte' +
        'rnatingRowColor>536870911</AlternatingRowColor><CustomColumns></' +
        'CustomColumns></grdMain></TSerialNumbersGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBarcodePickingListGUI", NULL, "<?xml vers' +
        'ion=""1.0"" encoding=""UTF-8"" ?><TBarcodePickingListGUI><grdMai' +
        'n><GridFields><![CDATA[InvoiceNo'#9'10'#9'InvoiceNo'#9'F'
      'PickingEmployee'#9'16'#9'PickingEmployee'#9'F'
      'StartPickingTime'#9'18'#9'StartPickingTime'#9'F'
      'FinishedPickingTime'#9'18'#9'FinishedPickingTime'#9'F'
      'PickingDuration'#9'12'#9'PickingDuration'#9'F'
      'PickingToPackingDuration'#9'21'#9'PickingToPackingDuration'#9'F'
      'PackingEmployee'#9'17'#9'PackingEmployee'#9'F'
      'StartPackingTime'#9'18'#9'StartPackingTime'#9'F'
      'FinishedPackingTime'#9'18'#9'FinishedPackingTime'#9'F'
      'PackingDuration'#9'13'#9'PackingDuration'#9'F'
      'ConNote'#9'14'#9'Con Note'#9'F'
      'Via'#9'14'#9'Via'#9'F'
      
        'ShipCost'#9'13'#9'Ship Cost'#9'F]]></GridFields><TitleFont><Name>Arial</N' +
        'ame><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style' +
        '></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474' +
        '83640</Color><Style></Style></Font><ShowGridLines>True</ShowGrid' +
        'Lines><AlternatingRowColor>536870911</AlternatingRowColor><Custo' +
        'mColumns></CustomColumns></grdMain></TBarcodePickingListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBatchesGUI", NULL, "<?xml version=""1.0""' +
        ' encoding=""UTF-8"" ?><TBatchesGUI><grdMain><GridFields><![CDATA' +
        '[PARTNAME'#9'20'#9'Product Name'#9'F'
      'classname'#9'12'#9'Department'#9'F'
      'TransactionNo'#9'9'#9'Trans No'#9'F'
      'Transtype'#9'14'#9'Transaction Type'#9'F'
      'Alloctype'#9'8'#9'Alloctype'#9'F'
      'QtyDescription'#9'24'#9'Description'#9'F'
      'UOM'#9'13'#9'Units of Measure'#9'F'
      'Batchno'#9'11'#9'Batch No'#9'F'
      'Quantity'#9'7'#9'Quantity'#9'F'
      
        'ExpiryDate'#9'10'#9'Expiry Date'#9'F]]></GridFields><TitleFont><Name>Aria' +
        'l</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</S' +
        'tyle></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2' +
        '147483640</Color><Style></Style></Font><ShowGridLines>True</Show' +
        'GridLines><AlternatingRowColor>536870911</AlternatingRowColor><C' +
        'ustomColumns></CustomColumns></grdMain></TBatchesGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmProcResourceList", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TfmProcResourceList><grdMain><Gri' +
        'dFields><![CDATA[ResourceName'#9'19'#9'Resource Name'#9'F'
      'Description'#9'17'#9'Description'#9'F'
      'CapacityHoursDay'#9'15'#9'Capacity Hours Day'#9'F'
      'BreakdownHoursDay'#9'18'#9'Breakdown Hours Day'#9'F'
      'HourlyLabourRate'#9'15'#9'Hourly Labour Rate'#9'F'
      'HourlyOverheadRate'#9'17'#9'Hourly Overhead Rate'#9'F'
      'ResourceAvailable'#9'15'#9'Resource Available'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TfmProcResourceList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmProcCapacityPlanning", NULL, "<?xml ver' +
        'sion=""1.0"" encoding=""UTF-8"" ?><TfmProcCapacityPlanning></Tfm' +
        'ProcCapacityPlanning>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmProcResourceUnavailabilityList", NULL, ' +
        '"<?xml version=""1.0"" encoding=""UTF-8"" ?><TfmProcResourceUnav' +
        'ailabilityList><grdMain><GridFields><![CDATA[ResourceName'#9'17'#9'Res' +
        'ource Name'#9'F'
      'Description'#9'25'#9'Description'#9'F'
      'TimeStart'#9'13'#9'Start'#9'F'
      'TimeEnd'#9'13'#9'End'#9'F'
      'CapacityHoursDay'#9'15'#9'Capacity Hours Day'#9'F'
      'SetupHoursDay'#9'13'#9'Setup Hours Day'#9'F'
      'BreakdownHoursDay'#9'18'#9'Breakdown Hours Day'#9'F'
      'HourlyLabourRate'#9'15'#9'Hourly Labour Rate'#9'F'
      'HourlyOverheadRate'#9'17'#9'Hourly Overhead Rate'#9'F'
      
        'ResourceAvailable'#9'15'#9'Resource Available'#9'F]]></GridFields><TitleF' +
        'ont><Name>Arial</Name><Size>9</Size><Color>-2147483640</Color><S' +
        'tyle>fsBold</Style></TitleFont><Font><Name>Arial</Name><Size>9</' +
        'Size><Color>-2147483640</Color><Style></Style></Font><ShowGridLi' +
        'nes>True</ShowGridLines><AlternatingRowColor>536870911</Alternat' +
        'ingRowColor><CustomColumns></CustomColumns></grdMain></TfmProcRe' +
        'sourceUnavailabilityList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmProcJobListing", NULL, "<?xml version="' +
        '"1.0"" encoding=""UTF-8"" ?><TfmProcJobListing><grdMain><GridFie' +
        'lds><![CDATA[CustomerName'#9'17'#9'Customer Name'#9'F'
      'LineProductName'#9'14'#9'Line Product'#9'F'
      'LineProductDescription'#9'23'#9'Line Product Description'#9'F'
      'SaleDocNumber'#9'14'#9'Sale Doc Number'#9'F'
      'SaleDate'#9'10'#9'Sale Date'#9'F'
      'SaleShipDate'#9'11'#9'Sale Ship Date'#9'F'
      'LineQty'#9'10'#9'Line Qty'#9'F'
      'LineShipDate'#9'11'#9'Line Ship Date'#9'F'
      'StepStatus'#9'11'#9'Step Status'#9'F'
      
        'Finalized'#9'7'#9'Finalized'#9'F]]></GridFields><TitleFont><Name>Arial</N' +
        'ame><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style' +
        '></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474' +
        '83640</Color><Style></Style></Font><ShowGridLines>True</ShowGrid' +
        'Lines><AlternatingRowColor>536870911</AlternatingRowColor><Custo' +
        'mColumns></CustomColumns></grdMain></TfmProcJobListing>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TMarketingContactListGUI", NULL, "<?xml ve' +
        'rsion=""1.0"" encoding=""UTF-8"" ?><TMarketingContactListGUI><gr' +
        'dMain><GridFields><![CDATA[COMPANY'#9'20'#9'COMPANY'#9'F'
      'Phone'#9'14'#9'Phone'#9'F'
      'FirstName'#9'9'#9'FirstName'#9'F'
      'LastName'#9'10'#9'LastName'#9'F'
      'Email'#9'24'#9'Email'#9'F'
      'SUBURB'#9'18'#9'SUBURB'#9'F'
      'STATE'#9'9'#9'STATE'#9'F'
      'Country'#9'11'#9'Country'#9'F'
      'POSTCODE'#9'11'#9'POSTCODE'#9'F'
      'DateEntered'#9'11'#9'DateEntered'#9'F'
      'Source'#9'14'#9'Source'#9'F'
      'URL'#9'20'#9'URL'#9'F'
      
        'ActionDate'#9'10'#9'ActionDate'#9'F]]></GridFields><TitleFont><Name>Arial' +
        '</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</St' +
        'yle></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21' +
        '47483640</Color><Style></Style></Font><ShowGridLines>True</ShowG' +
        'ridLines><AlternatingRowColor>536870911</AlternatingRowColor><Cu' +
        'stomColumns></CustomColumns></grdMain></TMarketingContactListGUI' +
        '>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TMarketingContactSelectionRangeListGUI", N' +
        'ULL, "<?xml version=""1.0"" encoding=""UTF-8"" ?><TMarketingCont' +
        'actSelectionRangeListGUI><grdMain><GridFields><![CDATA[RangeDesc' +
        'ription'#9'23'#9'Description'#9'F'
      'XMLData'#9'100'#9'XML Data'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TMarketingContactSelectionRangeLi' +
        'stGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TMarketingGUI", NULL, "<?xml version=""1.0' +
        '"" encoding=""UTF-8"" ?><TMarketingGUI><grdMain><GridFields><![C' +
        'DATA[COMPANY'#9'20'#9'COMPANY'#9'F'
      'FirstName'#9'10'#9'First Name'#9'F'
      'LastName'#9'10'#9'Last Name'#9'F'
      'Phone'#9'12'#9'Phone'#9'F'
      'ActionDate'#9'10'#9'Action Date'#9'F'
      'ActionType'#9'11'#9'Action Type'#9'F'
      'Duration'#9'10'#9'Duration'#9'F'
      'EmployeeName'#9'16'#9'Employee Name'#9'F'
      'Street'#9'15'#9'Street'#9'F'
      'SUBURB'#9'20'#9'SUBURB'#9'F'
      'STATE'#9'6'#9'STATE'#9'F'
      'Country'#9'7'#9'Country'#9'F'
      'POSTCODE'#9'9'#9'POSTCODE'#9'F'
      'IsLead'#9'5'#9'Is Lead'#9'F'
      'FaxNumber'#9'13'#9'Fax Number'#9'F'
      'AltPhone'#9'17'#9'Alt Phone'#9'F'
      'Mobile'#9'12'#9'Mobile'#9'F'
      
        'Email'#9'20'#9'Email'#9'F]]></GridFields><TitleFont><Name>Arial</Name><Si' +
        'ze>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Titl' +
        'eFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</' +
        'Color><Style></Style></Font><ShowGridLines>True</ShowGridLines><' +
        'AlternatingRowColor>536870911</AlternatingRowColor><CustomColumn' +
        's></CustomColumns></grdMain></TMarketingGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmSalesRatioReport", NULL, "<?xml versio' +
        'n=""1.0"" encoding=""UTF-8"" ?><TfrmSalesRatioReport><grdMain><G' +
        'ridFields><![CDATA[EmployeeName'#9'20'#9'EmployeeName'#9'F'#9
      'Leads'#9'10'#9'Leads'#9#9
      'Overdue'#9'10'#9'Overdue'#9#9
      'FollowUps'#9'10'#9'FollowUps'#9'F'#9
      'Approved'#9'10'#9'Approved'#9#9
      'NotApproved'#9'10'#9'NotApproved'#9#9
      'LeadsApprovedRatio'#9'10'#9'LeadsApprovedRatio'#9'F'#9
      'Sales'#9'10'#9'Sales'#9#9
      'LeadsSalesRatio'#9'10'#9'LeadsSalesRatio'#9'F'#9
      'ApprovedSalesRatio'#9'10'#9'ApprovedSalesRatio'#9'F'#9
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor></grdMain></TfrmSalesRatioRep' +
        'ort>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TMarketingLeadsGUI", NULL, "<?xml version=' +
        '""1.0"" encoding=""UTF-8"" ?><TMarketingLeadsGUI><grdMain><GridF' +
        'ields><![CDATA[Company'#9'14'#9'Company'#9'F'
      'ContactName'#9'13'#9'Contact Name'#9'F'
      'LeadStatus'#9'10'#9'Lead Status'#9'F'
      'Phone'#9'13'#9'Phone'#9'F'
      'Mobile'#9'11'#9'Mobile'#9'F'
      'AltPhone'#9'16'#9'Alt Phone'#9'F'
      'Rep'#9'10'#9'Rep'#9'F'
      'Street'#9'13'#9'Street'#9'F'
      'SUBURB'#9'19'#9'SUBURB'#9'F'
      'STATE'#9'8'#9'STATE'#9'F'
      'Country'#9'8'#9'Country'#9'F'
      'POSTCODE'#9'9'#9'POSTCODE'#9'F'
      
        'FaxNumber'#9'20'#9'Fax Number'#9'F]]></GridFields><TitleFont><Name>Arial<' +
        '/Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Sty' +
        'le></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214' +
        '7483640</Color><Style></Style></Font><ShowGridLines>True</ShowGr' +
        'idLines><AlternatingRowColor>536870911</AlternatingRowColor><Cus' +
        'tomColumns></CustomColumns></grdMain></TMarketingLeadsGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TCustPrepaymentListGUI", NULL, "<?xml vers' +
        'ion=""1.0"" encoding=""UTF-8"" ?><TCustPrepaymentListGUI><grdMai' +
        'n><GridFields><![CDATA[CompanyName'#9'20'#9'Company Name'#9'F'
      'PaymentDate'#9'11'#9'Payment Date'#9'F'
      'Amount'#9'11'#9'Amount'#9'F'
      'ReferenceNo'#9'12'#9'Reference No'#9'F'
      'Notes'#9'33'#9'Notes'#9'F'
      'PaymentMethod'#9'14'#9'Payment Method'#9'F'
      'Department'#9'13'#9'Department'#9'F'
      'ReceiptNo'#9'9'#9'Receipt No'#9'F'
      
        'Deleted'#9'6'#9'Deleted'#9'F]]></GridFields><TitleFont><Name>Arial</Name>' +
        '<Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></T' +
        'itleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214748364' +
        '0</Color><Style></Style></Font><ShowGridLines>True</ShowGridLine' +
        's><AlternatingRowColor>536870911</AlternatingRowColor><CustomCol' +
        'umns></CustomColumns></grdMain></TCustPrepaymentListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TCustPaymentListGUI", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TCustPaymentListGUI><grdMain><Gri' +
        'dFields><![CDATA[Customer Name'#9'15'#9'Customer Name'#9'F'
      'Receipt No'#9'8'#9'Receipt No'#9'T'
      'Payment Date'#9'11'#9'Payment Date'#9'F'
      'Opening Balance'#9'13'#9'Opening Balance'#9'F'
      'Payment Amount'#9'13'#9'Payment Amount'#9'F'
      'Payment Method'#9'14'#9'Payment Method'#9'F'
      'Reference No'#9'11'#9'Reference No'#9'F'
      'Notes'#9'16'#9'Notes'#9'F'
      'Bank Account'#9'16'#9'Bank Account'#9'F'
      
        'Department'#9'10'#9'Department'#9'F]]></GridFields><TitleFont><Name>Arial' +
        '</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</St' +
        'yle></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21' +
        '47483640</Color><Style></Style></Font><ShowGridLines>True</ShowG' +
        'ridLines><AlternatingRowColor>536870911</AlternatingRowColor><Cu' +
        'stomColumns></CustomColumns></grdMain></TCustPaymentListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TSuppPrepaymentListGUI", NULL, "<?xml vers' +
        'ion=""1.0"" encoding=""UTF-8"" ?><TSuppPrepaymentListGUI><grdMai' +
        'n><GridFields><![CDATA[PaymentDate'#9'11'#9'Payment Date'#9'F'
      'SupplierName'#9'20'#9'Supplier Name'#9'F'
      'ReceiptNo'#9'10'#9'Receipt No'#9'F'
      'ReferenceNo'#9'12'#9'Reference No'#9'F'
      'Notes'#9'39'#9'Notes'#9'F'
      'Amount'#9'13'#9'Amount'#9'F'
      'PaymentMethod'#9'14'#9'Payment Method'#9'F'
      
        'Department'#9'11'#9'Department'#9'F]]></GridFields><TitleFont><Name>Arial' +
        '</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</St' +
        'yle></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21' +
        '47483640</Color><Style></Style></Font><ShowGridLines>True</ShowG' +
        'ridLines><AlternatingRowColor>536870911</AlternatingRowColor><Cu' +
        'stomColumns></CustomColumns></grdMain></TSuppPrepaymentListGUI>"' +
        ');'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TSuppPaymentListGUI", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TSuppPaymentListGUI><grdMain><Gri' +
        'dFields><![CDATA[SupplierName'#9'19'#9'Supplier Name'#9'F'
      'PaymentDate'#9'11'#9'Payment Date'#9'F'
      'PaymentAmount'#9'13'#9'Payment Amount'#9'F'
      'Payment Method'#9'14'#9'Payment Method'#9'F'
      'ReceiptNo'#9'9'#9'Receipt No'#9'T'
      'ReferenceNo'#9'14'#9'Chq / Reference #'#9'F'
      'BankAccount'#9'15'#9'Bank Account'#9'F'
      'Notes'#9'20'#9'Notes'#9'F'
      'OpeningBalance'#9'13'#9'Opening Balance'#9'F'
      
        'Department'#9'9'#9'Department'#9'F]]></GridFields><TitleFont><Name>Arial<' +
        '/Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Sty' +
        'le></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214' +
        '7483640</Color><Style></Style></Font><ShowGridLines>True</ShowGr' +
        'idLines><AlternatingRowColor>536870911</AlternatingRowColor><Cus' +
        'tomColumns></CustomColumns></grdMain></TSuppPaymentListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TPayListingGUI", NULL, "<?xml version=""1.' +
        '0"" encoding=""UTF-8"" ?><TPayListingGUI><grdMain><GridFields><!' +
        '[CDATA[LastName'#9'11'#9'LastName'#9'F'
      'FirstName'#9'11'#9'FirstName'#9'F'
      'G/L'#9'3'#9'G/L'#9'F'
      'Date Paid'#9'10'#9'Date Paid'#9'F'
      'Gross'#9'10'#9'Gross'#9'F'
      'Tax'#9'10'#9'Tax'#9'F'
      'Net'#9'10'#9'Net'#9'F'
      'Wages'#9'10'#9'Wages'#9'F'
      'Commission'#9'10'#9'Commission'#9'F'
      'Deductions'#9'10'#9'Deductions'#9'F'
      'Allowances'#9'10'#9'Allowances'#9'F'
      'CDEP'#9'8'#9'CDEP'#9'F'
      'Sundries'#9'10'#9'Sundries'#9'F'
      'Superannuation'#9'12'#9'Superannuation'#9'F'
      'ClassName'#9'10'#9'ClassName'#9'F'
      'PayPeriod'#9'8'#9'PayPeriod'#9'F'
      'PayNo'#9'5'#9'PayNo'#9'F'
      'Splits'#9'6'#9'Splits'#9'F'
      
        'Deleted'#9'6'#9'Deleted'#9'F]]></GridFields><TitleFont><Name>Arial</Name>' +
        '<Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></T' +
        'itleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214748364' +
        '0</Color><Style></Style></Font><ShowGridLines>True</ShowGridLine' +
        's><AlternatingRowColor>536870911</AlternatingRowColor><CustomCol' +
        'umns></CustomColumns></grdMain></TPayListingGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmPayRateList", NULL, "<?xml version=""1' +
        '.0"" encoding=""UTF-8"" ?><TfrmPayRateList><grdMain><GridFields>' +
        '<![CDATA[Description'#9'29'#9'Description'#9'F'
      'Multiplier'#9'10'#9'Multiplier'#9'F'
      'MultiplierOf'#9'23'#9'Multiplier Of'#9'F'
      'IsPayRate'#9'13'#9'Is Pay Rate'#9'T'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TfrmPayRateList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmAllowanceList", NULL, "<?xml version="' +
        '"1.0"" encoding=""UTF-8"" ?><TfrmAllowanceList><grdMain><GridFie' +
        'lds><![CDATA[Description'#9'30'#9'Description'#9'F'
      'Based On'#9'12'#9'Based On'#9'F'
      'Display In'#9'13'#9'Display In'#9'F'
      'Super'#9'7'#9'Super'#9'F'
      'Tax Exempt'#9'9'#9'Tax Exempt'#9'F'
      'Payroll Tax Exempt'#9'15'#9'Payroll Tax Exempt'#9'F'
      'Workcover Exempt'#9'15'#9'Workcover Exempt'#9'F'
      'Amount'#9'10'#9'Amount'#9'F'
      'Percentage'#9'10'#9'Percentage'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TfrmAllowanceList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmDeductionList", NULL, "<?xml version="' +
        '"1.0"" encoding=""UTF-8"" ?><TfrmDeductionList><grdMain><GridFie' +
        'lds><![CDATA[Description'#9'50'#9'Description'#9'F'
      'Union Fees'#9'1'#9'Union Fees'#9'F'
      'TaxExempt'#9'1'#9'Tax Exempt'#9'F'
      
        'Active'#9'1'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TfrmDeductionList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TPAYGPaymentSummaryListGUI", NULL, "<?xml ' +
        'version=""1.0"" encoding=""UTF-8"" ?><TPAYGPaymentSummaryListGUI' +
        '><grdMain><GridFields><![CDATA[EmployeeName'#9'20'#9'Employee Name'#9'F'
      'GrossPayments'#9'13'#9'Gross Payments'#9'T'
      'TotalTaxWithheld'#9'15'#9'Total Tax Withheld'#9'T'
      'Deductions'#9'10'#9'Deductions'#9'T'
      'Allowances'#9'10'#9'Allowances'#9'T'
      'Other'#9'10'#9'Other'#9'T'
      'CDEP'#9'10'#9'CDEP'#9'T'
      'UnionFees'#9'10'#9'Union Fees'#9'T'
      'UnionDescription'#9'14'#9'Union Description'#9'F'
      'LumpA'#9'10'#9'Lump A'#9'T'
      'LumpB'#9'10'#9'Lump B'#9'F'
      'LumpD'#9'10'#9'Lump D'#9'F'
      'LumpE'#9'10'#9'Lump E'#9'F'
      
        'SalarySacrifice'#9'15'#9'Salary Sacrifice'#9'F]]></GridFields><TitleFont>' +
        '<Name>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style' +
        '>fsBold</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size' +
        '><Color>-2147483640</Color><Style></Style></Font><ShowGridLines>' +
        'True</ShowGridLines><AlternatingRowColor>536870911</AlternatingR' +
        'owColor><CustomColumns></CustomColumns></grdMain></TPAYGPaymentS' +
        'ummaryListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmEmployeeTerminationList", NULL, "<?xml' +
        ' version=""1.0"" encoding=""UTF-8"" ?><TfrmEmployeeTerminationLi' +
        'st><grdMain><GridFields><![CDATA[EmployeeName'#9'30'#9'Employee Name'#9'F'
      'StartDate'#9'18'#9'Start Date'#9'F'
      'EndDate'#9'18'#9'End Date'#9'F'
      'ReasonLeft'#9'32'#9'Reason Left'#9'F'
      
        'IsPayEntitled'#9'1'#9'Is Pay Entitled'#9'F]]></GridFields><TitleFont><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsB' +
        'old</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Co' +
        'lor>-2147483640</Color><Style></Style></Font><ShowGridLines>True' +
        '</ShowGridLines><AlternatingRowColor>536870911</AlternatingRowCo' +
        'lor><CustomColumns></CustomColumns></grdMain></TfrmEmployeeTermi' +
        'nationList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TTaxScaleList", NULL, "<?xml version=""1.0' +
        '"" encoding=""UTF-8"" ?><TTaxScaleList><grdMain><GridFields><![C' +
        'DATA[Description'#9'50'#9'Description'#9'F'
      'ScaleID'#9'10'#9'Scale ID'#9'F'
      'Last Updated'#9'10'#9'Last Updated'#9'F'
      
        'Active'#9'15'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><' +
        'Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Ti' +
        'tleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640' +
        '</Color><Style></Style></Font><ShowGridLines>True</ShowGridLines' +
        '><AlternatingRowColor>536870911</AlternatingRowColor><CustomColu' +
        'mns></CustomColumns></grdMain></TTaxScaleList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmPriceListsList", NULL, "<?xml version="' +
        '"1.0"" encoding=""UTF-8"" ?><TfmPriceListsList><grdMain><GridFie' +
        'lds><![CDATA[ListNumber'#9'12'#9'List Number'#9'F'
      'ListName'#9'24'#9'List Name'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TfmPriceListsList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmPriceSchemeList", NULL, "<?xml version=' +
        '""1.0"" encoding=""UTF-8"" ?><TfmPriceSchemeList><grdMain><GridF' +
        'ields><![CDATA[SchemeName'#9'25'#9'Scheme Name'#9'F'
      'SchemeTypeName'#9'17'#9'Scheme Type Name'#9'F'
      'SchemeNumber'#9'14'#9'Scheme Number'#9'F'
      'RelatedSchemeName'#9'19'#9'Related Scheme Name'#9'F'
      'Price'#9'15'#9'Price'#9'F'
      'DiscountOrQtyFree'#9'16'#9'Discount Or Qty Free'#9'F'
      'Credit'#9'11'#9'Credit'#9'F'
      'DateFrom'#9'14'#9'Date From'#9'F'
      'DateTo'#9'10'#9'Date To'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TfmPriceSchemeList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TSupplierListGUI", NULL, "<?xml version=""' +
        '1.0"" encoding=""UTF-8"" ?><TSupplierListGUI><grdMain><GridField' +
        's><![CDATA[SupplierName'#9'26'#9'Supplier Name'#9'F'
      'ContactName'#9'13'#9'Contact Name'#9'T'
      'Phone'#9'14'#9'Phone'#9'F'
      'Mobile'#9'13'#9'Mobile'#9'F'
      'FaxNumber'#9'14'#9'Fax Number'#9'F'
      'AR Balance'#9'12'#9'AR Balance'#9'F'
      'AP Balance'#9'12'#9'AP Balance'#9'F'
      'Balance'#9'12'#9'Balance'#9'F'
      'Street'#9'17'#9'Street'#9'F'
      'Suburb'#9'19'#9'Suburb'#9'F'
      'State'#9'10'#9'State'#9'F'
      'Postcode'#9'7'#9'Postcode'#9'F'
      'Country'#9'7'#9'Country'#9'F'
      'BankAccountName'#9'17'#9'Bank Account Name'#9'F'
      'BankAccountBSB'#9'15'#9'Bank Account BSB'#9'F'
      'BankAccountNo'#9'13'#9'Bank Account No'#9'F'
      'CreationDate'#9'11'#9'Creation Date'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TSupplierListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TSmartOrderListGUI", NULL, "<?xml version=' +
        '""1.0"" encoding=""UTF-8"" ?><TSmartOrderListGUI><grdMain><GridF' +
        'ields><![CDATA[Name'#9'10'#9'Name'#9'T'
      'SmartOrderDesc'#9'40'#9'Smart Order Desc'#9'F'
      'No'#9'10'#9'No'#9'T'
      'CreationDate'#9'11'#9'Creation Date'#9'F'
      
        'Done'#9'4'#9'Done'#9'F]]></GridFields><TitleFont><Name>Arial</Name><Size>' +
        '9</Size><Color>-2147483640</Color><Style>fsBold</Style></TitleFo' +
        'nt><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</Col' +
        'or><Style></Style></Font><ShowGridLines>True</ShowGridLines><Alt' +
        'ernatingRowColor>536870911</AlternatingRowColor><CustomColumns><' +
        '/CustomColumns></grdMain></TSmartOrderListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TPurchaseOrderListGUI", NULL, "<?xml versi' +
        'on=""1.0"" encoding=""UTF-8"" ?><TPurchaseOrderListGUI><grdMain>' +
        '<GridFields><![CDATA[Company'#9'23'#9'Company'#9'F'
      'Phone'#9'13'#9'Phone'#9'F'
      'Contact'#9'16'#9'Contact'#9'F'
      'OrderDate'#9'10'#9'Order Date'#9'F'
      'P/O Num'#9'9'#9'P/O Num'#9'F'
      'CustPONumber'#9'13'#9'Cust PO Number'#9'F'
      'TotalAmount'#9'10'#9'Total Amount'#9'F'
      'Comments'#9'24'#9'Comments'#9'F'
      'WarehouseNotes'#9'20'#9'Warehouse Notes'#9'F'
      'ETADate'#9'10'#9'ETA Date'#9'F'
      'InvoiceNumber'#9'13'#9'Invoice Number'#9'F'
      'Deleted'#9'6'#9'Deleted'#9'F'
      'ConNote'#9'19'#9'Con Note'#9'F'
      
        'InvoiceDate'#9'10'#9'Invoice Date'#9'F]]></GridFields><TitleFont><Name>Ar' +
        'ial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold<' +
        '/Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>' +
        '-2147483640</Color><Style></Style></Font><ShowGridLines>True</Sh' +
        'owGridLines><AlternatingRowColor>536870911</AlternatingRowColor>' +
        '<CustomColumns></CustomColumns></grdMain></TPurchaseOrderListGUI' +
        '>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TPurchaseGUI", NULL, "<?xml version=""1.0"' +
        '" encoding=""UTF-8"" ?><TPurchaseGUI><grdTransactions><GridField' +
        's><![CDATA[ProductName'#9'17'#9'Name'#9'F'
      'UnitofMeasureQtySold'#9'7'#9'Ordered'#9'F'
      'UnitofMeasureShipped'#9'7'#9'Received'#9'F'
      'UnitofMeasureBackorder'#9'7'#9'BO'#9'F'
      'PQA'#9'8'#9'Allocation'#9'F'
      'OriginalQtyOrdered'#9'7'#9'Orig Qty'#9'F'
      'Product_Description'#9'20'#9'Description'#9'F'
      'LineCost'#9'10'#9'Cost (Ex)'#9'F'
      'LineTaxCode'#9'6'#9'Code'#9'F'
      'LineTax'#9'10'#9'Tax'#9'F'
      'TotalLineAmountInc'#9'10'#9'Amount (Inc)'#9'F'
      'ETADate'#9'13'#9'ETA Date'#9'F'
      'ReceivedDate'#9'12'#9'Received Date'#9'F'
      'Class'#9'9'#9'Department'#9'F'
      'UnitofMeasurePOLines'#9'9'#9'Units'#9'F'
      'ForeignTotalLineAmount'#9'10'#9'Foreign Total'#9'F'
      
        'ForeignCurrencyLineCost'#9'10'#9'Foreign Cost'#9'F]]></GridFields><TitleF' +
        'ont><Name>Arial</Name><Size>9</Size><Color>-2147483640</Color><S' +
        'tyle>fsBold</Style></TitleFont><Font><Name>Arial</Name><Size>9</' +
        'Size><Color>-2147483640</Color><Style></Style></Font><ShowGridLi' +
        'nes>True</ShowGridLines><AlternatingRowColor>536870911</Alternat' +
        'ingRowColor><CustomColumns></CustomColumns></grdTransactions></T' +
        'PurchaseGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TReturnAuthListGUI", NULL, "<?xml version=' +
        '""1.0"" encoding=""UTF-8"" ?><TReturnAuthListGUI><grdMain><GridF' +
        'ields><![CDATA[Company'#9'20'#9'Company'#9'F'
      'Contact'#9'19'#9'Contact'#9'F'
      'Phone'#9'12'#9'Phone'#9'F'
      'RA Number'#9'9'#9'RA Number'#9'F'
      'Status'#9'12'#9'Status'#9'T'
      'OrderDate'#9'10'#9'Order Date'#9'F'
      'ETADate'#9'10'#9'ETA Date'#9'F'
      'Supplier RA Number'#9'16'#9'Supplier RA Number'#9'F'
      'Comments'#9'40'#9'Comments'#9'F'
      
        'Deleted'#9'6'#9'Deleted'#9'F]]></GridFields><TitleFont><Name>Arial</Name>' +
        '<Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></T' +
        'itleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214748364' +
        '0</Color><Style></Style></Font><ShowGridLines>True</ShowGridLine' +
        's><AlternatingRowColor>536870911</AlternatingRowColor><CustomCol' +
        'umns></CustomColumns></grdMain></TReturnAuthListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBillListGUI", NULL, "<?xml version=""1.0"' +
        '" encoding=""UTF-8"" ?><TBillListGUI><grdMain><GridFields><![CDA' +
        'TA[Company'#9'20'#9'Company'#9'F'
      'Contact'#9'15'#9'Contact'#9'F'
      'Phone'#9'13'#9'Phone'#9'F'
      'BillNumber'#9'10'#9'Bill Number'#9'F'
      'Total Amount (Ex)'#9'14'#9'Total Amount (Ex)'#9'F'
      'Total Tax'#9'10'#9'Total Tax'#9'F'
      'Total Amount (Inc)'#9'14'#9'Total Amount (Inc)'#9'F'
      'OrderDate'#9'11'#9'Order Date'#9'F'
      'Type'#9'11'#9'Type'#9'F'
      'Comments'#9'25'#9'Comments'#9'F'
      
        'InvoiceNumber'#9'12'#9'Invoice Number'#9'F]]></GridFields><TitleFont><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsB' +
        'old</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Co' +
        'lor>-2147483640</Color><Style></Style></Font><ShowGridLines>True' +
        '</ShowGridLines><AlternatingRowColor>536870911</AlternatingRowCo' +
        'lor><CustomColumns></CustomColumns></grdMain></TBillListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmShippingContainerList", NULL, "<?xml v' +
        'ersion=""1.0"" encoding=""UTF-8"" ?><TfrmShippingContainerList><' +
        'grdMain><GridFields><![CDATA[ContainerName'#9'31'#9'Container Name'#9'F'
      'ETDeparture'#9'12'#9'ETDeparture'#9'F'
      'ShippingContainerStatus'#9'15'#9'Status'#9'F'
      'DeparturePoint'#9'21'#9'Departure Point'#9'F'
      'VesselName'#9'21'#9'Vessel Name'#9'F'
      'ETA'#9'12'#9'ETA'#9'F'
      'ArrivalPoint'#9'14'#9'Arrival Point'#9'F'
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor><CustomColumns></CustomColumn' +
        's></grdMain></TfrmShippingContainerList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBackOrderSOGUI", NULL, "<?xml version=""1' +
        '.0"" encoding=""UTF-8"" ?><TBackOrderSOGUI><grdMain><GridFields>' +
        '<![CDATA[CustomerName'#9'25'#9'Customer Name'#9'F'
      'BackOrder'#9'10'#9'Back Order'#9'F'
      'ProductName'#9'16'#9'Product'#9'F'
      'Product_Description'#9'25'#9'Product Description'#9'F'
      'Date Entered'#9'10'#9'Date Entered'#9'F'
      'SalesOrderNumber'#9'16'#9'Sales Order Number'#9'F'
      'SaleDate'#9'10'#9'Sale Date'#9'F'
      'PONumber'#9'12'#9'PO Number'#9'F'
      'LinePrice'#9'10'#9'Line Price'#9'F'
      'LinePriceInc'#9'11'#9'Line Price Inc'#9'F'
      'DueDate'#9'10'#9'Due Date'#9'F'
      
        'Converted'#9'8'#9'Converted'#9'F]]></GridFields><TitleFont><Name>Arial</N' +
        'ame><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style' +
        '></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474' +
        '83640</Color><Style></Style></Font><ShowGridLines>True</ShowGrid' +
        'Lines><AlternatingRowColor>536870911</AlternatingRowColor><Custo' +
        'mColumns></CustomColumns></grdMain></TBackOrderSOGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBackOrdersListGUI", NULL, "<?xml version=' +
        '""1.0"" encoding=""UTF-8"" ?><TBackOrdersListGUI><grdMain><GridF' +
        'ields><![CDATA[CustomerName'#9'20'#9'Customer Name'#9'F'
      'SaleDate'#9'10'#9'Sale Date'#9'F'
      'BackOrder'#9'10'#9'Back Order'#9'F'
      'ProductName'#9'14'#9'Product'#9'F'
      'Product_Description'#9'40'#9'Product Description'#9'F'
      'OriginalNo'#9'9'#9'Original No'#9'F'
      'InvoiceDocNumber'#9'16'#9'Invoice Doc Number'#9'F'
      'PONumber'#9'9'#9'PO Number'#9'F'
      'ConvertFromSO'#9'13'#9'Convert From SO'#9'F'
      'LinePrice'#9'10'#9'Line Price'#9'F'
      'LinePriceInc'#9'11'#9'Line Price Inc'#9'F'
      'Deleted'#9'6'#9'Deleted'#9'F'
      'Converted'#9'8'#9'Converted'#9'F'
      
        'CreationDate'#9'18'#9'Creation Date'#9'F]]></GridFields><TitleFont><Name>' +
        'Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBol' +
        'd</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style></Style></Font><ShowGridLines>True</' +
        'ShowGridLines><AlternatingRowColor>536870911</AlternatingRowColo' +
        'r><CustomColumns></CustomColumns></grdMain></TBackOrdersListGUI>' +
        '");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBackOrderPurchaseListGUI", NULL, "<?xml v' +
        'ersion=""1.0"" encoding=""UTF-8"" ?><TBackOrderPurchaseListGUI><' +
        'grdMain><GridFields><![CDATA[SupplierName'#9'17'#9'Supplier Name'#9'F'
      'Phone'#9'14'#9'Phone'#9'F'
      'BackOrder'#9'10'#9'Back Order'#9'F'
      'PartName'#9'17'#9'Part Name'#9'F'
      'PurchaseDesc'#9'29'#9'Purchase Desc'#9'F'
      'EmployeeName'#9'14'#9'Employee Name'#9'F'
      'PartCostAmount'#9'14'#9'Part Cost Amount'#9'F'
      'LineCostAmount'#9'14'#9'Line Cost Amount'#9'F'
      'P/O Num'#9'9'#9'P/O Num'#9'F'
      'OriginalNo'#9'11'#9'Original No'#9'F'
      'OriginalQty'#9'11'#9'Original Qty'#9'F'
      'Deleted'#9'6'#9'Deleted'#9'F'
      'PartCost'#9'10'#9'Part Cost'#9'F'
      'UnitofMeasurePOLines'#9'20'#9'Unitof Measure PO Lines'#9'F'
      'PurchaseLineID'#9'13'#9'Purchase Line ID'#9'F'
      'LineCost'#9'10'#9'Line Cost'#9'F'
      'OrderDate'#9'10'#9'Order Date'#9'F'
      'Comments'#9'14'#9'Comments'#9'F'
      'ETADate'#9'10'#9'ETA Date'#9'F'
      'Class'#9'10'#9'Department'#9'F'
      'CustomerJob'#9'18'#9'Customer Job'#9'F'
      'CustPONumber'#9'14'#9'Cust PO Number'#9'F'
      
        'Approved'#9'7'#9'Approved'#9'F]]></GridFields><TitleFont><Name>Arial</Nam' +
        'e><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style><' +
        '/TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483' +
        '640</Color><Style></Style></Font><ShowGridLines>True</ShowGridLi' +
        'nes><AlternatingRowColor>536870911</AlternatingRowColor><CustomC' +
        'olumns></CustomColumns></grdMain></TBackOrderPurchaseListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TFaxSpoolListingGUI", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TFaxSpoolListingGUI><grdMain><Gri' +
        'dFields><![CDATA[SpooledAt'#9'13'#9'Spooled At'#9'F'
      'SentOk'#9'6'#9'Sent Ok'#9'F'
      'Cancelled'#9'8'#9'Cancelled'#9'F'
      'CurrentStatus'#9'11'#9'Current Status'#9'F'
      'FaxBy'#9'10'#9'Fax By'#9'F'
      'FaxTo'#9'10'#9'Fax To'#9'F'
      'FaxNumber'#9'10'#9'Fax Number'#9'F'
      'StartedSending'#9'13'#9'Started Sending'#9'F'
      'CompletedSending'#9'15'#9'Completed Sending'#9'F'
      'DialAttempts'#9'10'#9'Dial Attempts'#9'F'
      
        'Priority'#9'5'#9'Priority'#9'F]]></GridFields><TitleFont><Name>Arial</Nam' +
        'e><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style><' +
        '/TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483' +
        '640</Color><Style></Style></Font><ShowGridLines>True</ShowGridLi' +
        'nes><AlternatingRowColor>536870911</AlternatingRowColor><CustomC' +
        'olumns></CustomColumns></grdMain></TFaxSpoolListingGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TAuditTrailListGUI", NULL, "<?xml version=' +
        '""1.0"" encoding=""UTF-8"" ?><TAuditTrailListGUI><grdMain><GridF' +
        'ields><![CDATA[AuditDate'#9'23'#9'Audit Date'#9'F'
      'ChangesDetails'#9'26'#9'Changes Details'#9'T'
      'Transaction ID'#9'11'#9'Transaction ID'#9'F'
      'TransType'#9'20'#9'Trans Type'#9'F'
      'DataDescription'#9'18'#9'Data Description'#9'F'
      
        'EmployeeName'#9'17'#9'Employee Name'#9'F]]></GridFields><TitleFont><Name>' +
        'Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBol' +
        'd</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style></Style></Font><ShowGridLines>True</' +
        'ShowGridLines><AlternatingRowColor>536870911</AlternatingRowColo' +
        'r><CustomColumns></CustomColumns></grdMain></TAuditTrailListGUI>' +
        '");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TJobListGUI", NULL, "<?xml version=""1.0""' +
        ' encoding=""UTF-8"" ?><TJobListGUI><grdMain><GridFields><![CDATA' +
        '[JobName'#9'15'#9'Job Name'#9'F'
      'JobNumber'#9'10'#9'Job Number'#9'F'
      'CompanyName'#9'15'#9'Company Name'#9'T'
      'ContactName'#9'14'#9'Contact Name'#9'T'
      'Phone'#9'20'#9'Phone'#9'F'
      'Mobile'#9'14'#9'Mobile'#9'F'
      'Balance'#9'10'#9'Balance'#9'F'
      'Total Balance'#9'11'#9'Total Balance'#9'F'
      'StopCredit'#9'9'#9'Stop Credit'#9'F'
      'CreditLimit'#9'10'#9'Credit Limit'#9'F'
      'Rep'#9'17'#9'Rep'#9'F'
      'Terms'#9'7'#9'Terms'#9'F'
      'GracePeriod'#9'10'#9'Grace Period'#9'F'
      'AccountNo'#9'13'#9'Account No'#9'F'
      'Email'#9'18'#9'Email'#9'F'
      'FaxNumber'#9'20'#9'Fax Number'#9'F'
      'PickingPriority'#9'12'#9'Picking Priority'#9'F'
      'Street'#9'15'#9'Street'#9'F'
      'Suburb'#9'12'#9'Suburb'#9'F'
      'State'#9'5'#9'State'#9'F'
      'Postcode'#9'8'#9'Postcode'#9'F'
      'AltPhone'#9'20'#9'Alt Phone'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TJobListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmMessagesListGUI", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TfrmMessagesListGUI><grdMain><Gri' +
        'dFields><![CDATA[EmployeeName'#9'17'#9'Employee Name'#9'F'
      'Company'#9'21'#9'Company'#9'F'
      'DateAndTime'#9'14'#9'Date/Time'#9'F'
      'Phone'#9'15'#9'Phone'#9'F'
      'Mobile'#9'15'#9'Mobile'#9'F'
      'Telephoned'#9'9'#9'Telephoned'#9'F'
      'PleaseRing'#9'9'#9'Please Ring'#9'F'
      'WillRingBack'#9'11'#9'Will Ring Back'#9'F'
      'CalledIn'#9'6'#9'Called In'#9'F'
      'Done'#9'4'#9'Done'#9'F'
      'DoneDateTime'#9'18'#9'Done Date/Time'#9'F'
      'Details'#9'10'#9'Details'#9'F'
      'Fax'#9'15'#9'Fax'#9'F'
      'Email'#9'30'#9'Email'#9'F'
      'Name'#9'15'#9'Name'#9'F'
      
        'LastName'#9'20'#9'Last Name'#9'F]]></GridFields><TitleFont><Name>Arial</N' +
        'ame><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style' +
        '></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474' +
        '83640</Color><Style></Style></Font><ShowGridLines>True</ShowGrid' +
        'Lines><AlternatingRowColor>536870911</AlternatingRowColor><Custo' +
        'mColumns></CustomColumns></grdMain></TfrmMessagesListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmCashFlowStatement", NULL, "<?xml versi' +
        'on=""1.0"" encoding=""UTF-8"" ?><TfrmCashFlowStatement><grdMain>' +
        '<GridFields><![CDATA[Activity'#9'64'#9'Activity'#9#9
      'Description'#9'32'#9'Description'#9'F'#9
      'Amount'#9'10'#9'Amount'#9'F'#9
      'EndDate'#9'18'#9'EndDate'#9'F'#9
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor></grdMain></TfrmCashFlowState' +
        'ment>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBalanceSheetGUI", NULL, "<?xml version=""' +
        '1.0"" encoding=""UTF-8"" ?><TBalanceSheetGUI></TBalanceSheetGUI>' +
        '");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBalTransListGUI", NULL, "<?xml version=""' +
        '1.0"" encoding=""UTF-8"" ?><TBalTransListGUI><grdMain><GridField' +
        's><![CDATA[Date'#9'10'#9'Date'#9'F'
      'Global #'#9'8'#9'Global #'#9'F'
      'Account Name'#9'16'#9'Account Name'#9'F'
      'Type'#9'15'#9'Type'#9'F'
      'ClientName'#9'18'#9'Client Name'#9'F'
      'Amount (Ex)'#9'12'#9'Amount (Ex)'#9'T'
      'Amount (Inc)'#9'11'#9'Amount (Inc)'#9'T'
      'Notes'#9'30'#9'Notes'#9'F'
      
        'Account Type'#9'11'#9'Account Type'#9'F]]></GridFields><TitleFont><Name>A' +
        'rial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold' +
        '</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color' +
        '>-2147483640</Color><Style></Style></Font><ShowGridLines>True</S' +
        'howGridLines><AlternatingRowColor>536870911</AlternatingRowColor' +
        '><CustomColumns></CustomColumns></grdMain></TBalTransListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TTransAccountDetailsGUI", NULL, "<?xml ver' +
        'sion=""1.0"" encoding=""UTF-8"" ?><TTransAccountDetailsGUI><grdM' +
        'ain><GridFields><![CDATA[Date'#9'10'#9'Date'#9'F'
      'GlobalRef'#9'11'#9'Global Ref'#9'F'
      'AccountName'#9'13'#9'Account Name'#9'F'
      'Class'#9'12'#9'Department'#9'F'
      'Type'#9'11'#9'Type'#9'F'
      'Amount (Ex)'#9'12'#9'Amount (Ex)'#9'T'
      'Tax Amount'#9'11'#9'Tax Amount'#9'F'
      'Amount (Inc)'#9'12'#9'Amount (Inc)'#9'T'
      'ClientName'#9'15'#9'Client Name'#9'F'
      'ProductName'#9'16'#9'Product'#9'F'
      'ProductDesc'#9'40'#9'Product Desc'#9'F'
      'TaxCode'#9'7'#9'Tax Code'#9'F'
      
        'Notes'#9'28'#9'Notes'#9'F]]></GridFields><TitleFont><Name>Arial</Name><Si' +
        'ze>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Titl' +
        'eFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</' +
        'Color><Style></Style></Font><ShowGridLines>True</ShowGridLines><' +
        'AlternatingRowColor>536870911</AlternatingRowColor><CustomColumn' +
        's></CustomColumns></grdMain></TTransAccountDetailsGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TTrialBalTransListGUI", NULL, "<?xml versi' +
        'on=""1.0"" encoding=""UTF-8"" ?><TTrialBalTransListGUI><grdMain>' +
        '<GridFields><![CDATA[Date'#9'10'#9'Date'#9'F'
      'Account Name'#9'22'#9'Account Name'#9'F'
      'Type'#9'26'#9'Type'#9'F'
      'Account Type'#9'14'#9'Account Type'#9'F'
      'Credits (Ex)'#9'12'#9'Credits (Ex)'#9'F'
      
        'Debits (Ex)'#9'12'#9'Debits (Ex)'#9'F]]></GridFields><TitleFont><Name>Ari' +
        'al</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</' +
        'Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-' +
        '2147483640</Color><Style></Style></Font><ShowGridLines>True</Sho' +
        'wGridLines><AlternatingRowColor>536870911</AlternatingRowColor><' +
        'CustomColumns></CustomColumns></grdMain></TTrialBalTransListGUI>' +
        '");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TJournalEntryGUI", NULL, "<?xml version=""' +
        '1.0"" encoding=""UTF-8"" ?><TJournalEntryGUI></TJournalEntryGUI>' +
        '");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TAppointmentGUI", NULL, "<?xml version=""1' +
        '.0"" encoding=""UTF-8"" ?><TAppointmentGUI><subfrmEquipment><Gri' +
        'dFields><![CDATA[EquipmentName'#9'15'#9'Equipment Name'#9'F'
      'Description'#9'30'#9'Description'#9'F'
      
        'Notes'#9'40'#9'Notes'#9'F]]></GridFields><TitleFont><Name>Arial</Name><Si' +
        'ze>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Titl' +
        'eFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</' +
        'Color><Style></Style></Font><ShowGridLines>True</ShowGridLines><' +
        'AlternatingRowColor>536870911</AlternatingRowColor></subfrmEquip' +
        'ment></TAppointmentGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBudVsActListGUI", NULL, "<?xml version=""' +
        '1.0"" encoding=""UTF-8"" ?><TBudVsActListGUI></TBudVsActListGUI>' +
        '");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TRepServicesListGUI", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TRepServicesListGUI><grdMain><Gri' +
        'dFields><![CDATA[Description'#9'50'#9'Description'#9'F'
      'Ranking'#9'10'#9'Ranking'#9'F'
      'Rate'#9'10'#9'Rate'#9'F'
      'IsFixedRate'#9'10'#9'Is Fixed Rate'#9'F'
      'Hardware'#9'8'#9'Hardware'#9'F'
      'Software'#9'7'#9'Software'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TRepServicesListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TUnbalancedBinQtyGUI", NULL, "<?xml versio' +
        'n=""1.0"" encoding=""UTF-8"" ?><TUnbalancedBinQtyGUI><grdMain><G' +
        'ridFields><![CDATA[Product Name'#9'19'#9'Product'#9'F'
      'Firstcolumn'#9'15'#9'Manufacture'#9'F'
      'Secondcolumn'#9'15'#9'Type'#9'F'
      'thirdcolumn'#9'15'#9'Dept'#9'F'
      'Sales Description'#9'31'#9'Sales Description'#9'F'
      'In Stock'#9'10'#9'In Stock'#9'F'
      
        'In Bins'#9'10'#9'In Bins'#9'F]]></GridFields><TitleFont><Name>Arial</Name' +
        '><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></' +
        'TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474836' +
        '40</Color><Style></Style></Font><ShowGridLines>True</ShowGridLin' +
        'es><AlternatingRowColor>536870911</AlternatingRowColor><CustomCo' +
        'lumns></CustomColumns></grdMain></TUnbalancedBinQtyGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmProcProductionPartsList", NULL, "<?xml ' +
        'version=""1.0"" encoding=""UTF-8"" ?><TfmProcProductionPartsList' +
        '><grdMain><GridFields><![CDATA[CustomerName'#9'18'#9'Customer Name'#9'F'
      'PartName'#9'17'#9'Part Name'#9'F'
      'PartDescription'#9'26'#9'Part Description'#9'F'
      'Process'#9'11'#9'Process'#9'F'
      'TotalQty'#9'10'#9'Total Qty'#9'F'
      'ProjectedQty'#9'11'#9'Projected Qty'#9'F'
      'LeadTime'#9'10'#9'Lead Time'#9'F'
      'ProcessStatus'#9'12'#9'Process Status'#9'F'
      'CriticalOrderDate'#9'15'#9'Critical Order Date'#9'F'
      'Uom'#9'8'#9'Uom'#9'F'
      'ProcessStart'#9'11'#9'Process Start'#9'F'
      'LineQuantity'#9'10'#9'Line Quantity'#9'F'
      'LineShipDate'#9'11'#9'Line Ship Date'#9'F'
      'SaleDocNumber'#9'14'#9'Sale Doc Number'#9'F'
      
        'SaleShipDate'#9'11'#9'Sale Ship Date'#9'F]]></GridFields><TitleFont><Name' +
        '>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBo' +
        'ld</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Col' +
        'or>-2147483640</Color><Style></Style></Font><ShowGridLines>True<' +
        '/ShowGridLines><AlternatingRowColor>536870911</AlternatingRowCol' +
        'or><CustomColumns></CustomColumns></grdMain></TfmProcProductionP' +
        'artsList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TMarketingContactListDetailGUI", NULL, "<?' +
        'xml version=""1.0"" encoding=""UTF-8"" ?><TMarketingContactListD' +
        'etailGUI><grdMain><GridFields><![CDATA[COMPANY'#9'17'#9'Company'#9'F'
      'Phone'#9'14'#9'Phone'#9'F'
      'FirstName'#9'10'#9'First Name'#9'F'
      'LastName'#9'10'#9'Last Name'#9'F'
      'Action'#9'14'#9'Action'#9'F'
      'FollowUpDate'#9'10'#9'Action~Date'#9'F'
      'EmployeeName'#9'15'#9'Employee Name'#9'F'
      'SUBURB'#9'15'#9'Suburb'#9'F'
      'STATE'#9'9'#9'State'#9'F'
      'Country'#9'10'#9'Country'#9'F'
      'POSTCODE'#9'10'#9'Post Code'#9'F'
      'Source'#9'8'#9'Source'#9'F'
      'Notes'#9'10'#9'Notes'#9'F'
      
        'ISLEad'#9'5'#9'Is Lead'#9'F]]></GridFields><TitleFont><Name>Arial</Name><' +
        'Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Ti' +
        'tleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640' +
        '</Color><Style></Style></Font><ShowGridLines>True</ShowGridLines' +
        '><AlternatingRowColor>536870911</AlternatingRowColor><CustomColu' +
        'mns></CustomColumns></grdMain></TMarketingContactListDetailGUI>"' +
        ');'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmBankCodeList", NULL, "<?xml version=""' +
        '1.0"" encoding=""UTF-8"" ?><TfrmBankCodeList><grdMain><GridField' +
        's><![CDATA[Bank Name'#9'61'#9'Bank Name'#9'F'
      
        'Bank Code'#9'13'#9'Bank Code'#9'F]]></GridFields><TitleFont><Name>Arial</' +
        'Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Styl' +
        'e></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147' +
        '483640</Color><Style></Style></Font><ShowGridLines>True</ShowGri' +
        'dLines><AlternatingRowColor>536870911</AlternatingRowColor><Cust' +
        'omColumns></CustomColumns></grdMain></TfrmBankCodeList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmPriceSchemeBestPriceList", NULL, "<?xml' +
        ' version=""1.0"" encoding=""UTF-8"" ?><TfmPriceSchemeBestPriceLi' +
        'st><grdMain><GridFields><![CDATA[SchemeName'#9'20'#9'Scheme Name'#9'F'
      'SchemeNumber'#9'17'#9'Scheme Number'#9'F'
      'SchemeType'#9'15'#9'Scheme Type'#9'F'
      'ProductName'#9'16'#9'Product'#9'F'
      'ProductDescription'#9'29'#9'Product Description'#9'F'
      'ListPrice'#9'12'#9'List Price'#9'F'
      'SalePrice'#9'11'#9'Sale Price'#9'F'
      
        'SaveUpTo'#9'11'#9'Save Up To'#9'F]]></GridFields><TitleFont><Name>Arial</' +
        'Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Styl' +
        'e></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147' +
        '483640</Color><Style></Style></Font><ShowGridLines>True</ShowGri' +
        'dLines><AlternatingRowColor>536870911</AlternatingRowColor><Cust' +
        'omColumns></CustomColumns></grdMain></TfmPriceSchemeBestPriceLis' +
        't>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TPurchaseOrderDetailListGUI", NULL, "<?xml' +
        ' version=""1.0"" encoding=""UTF-8"" ?><TPurchaseOrderDetailListG' +
        'UI><grdMain><GridFields><![CDATA[Company'#9'20'#9'Company'#9'F'
      'OriginalNo'#9'11'#9'Original No'#9'F'
      'OrderDate'#9'10'#9'Order Date'#9'F'
      'ProductName'#9'17'#9'Product'#9'F'
      'Product_Description'#9'20'#9'Product Description'#9'F'
      'TotalLineAmount'#9'14'#9'Total Line Amount'#9'F'
      'TotalLineAmountInc'#9'17'#9'Total Line Amount Inc'#9'F'
      'CustomerJob'#9'18'#9'Customer Job'#9'F'
      'Class'#9'11'#9'Department'#9'F'
      'UnitofMeasurePOLines'#9'20'#9'Unitof Measure PO Lines'#9'F'
      'UnitofMeasureQtySold'#9'19'#9'Unitof Measure Qty Sold'#9'F'
      
        'UnitofMeasureShipped'#9'19'#9'Unitof Measure Shipped'#9'F]]></GridFields>' +
        '<TitleFont><Name>Arial</Name><Size>9</Size><Color>-2147483640</C' +
        'olor><Style>fsBold</Style></TitleFont><Font><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style></Style></Font><Sho' +
        'wGridLines>True</ShowGridLines><AlternatingRowColor>536870911</A' +
        'lternatingRowColor><CustomColumns></CustomColumns></grdMain></TP' +
        'urchaseOrderDetailListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TRelatedCustomerListGUI", NULL, "<?xml ver' +
        'sion=""1.0"" encoding=""UTF-8"" ?><TRelatedCustomerListGUI><grdM' +
        'ain><GridFields><![CDATA[CompanyName'#9'20'#9'CompanyName'#9'T'
      'ContactName'#9'15'#9'ContactName'#9'T'
      'Related Company'#9'17'#9'Related Company'#9'F'
      'RelatedBalance'#9'13'#9'Related Balance'#9'F'
      'AR Balance'#9'10'#9'AR Balance'#9'F'
      'AP Balance'#9'10'#9'AP Balance'#9'F'
      'Balance'#9'10'#9'Balance'#9'F'
      'Total Balance'#9'11'#9'Total Balance'#9'F'
      'Phone'#9'15'#9'Phone'#9'F'
      'FaxNumber'#9'15'#9'FaxNumber'#9'F'
      'Rep'#9'14'#9'Rep'#9'F'
      'CreditLimit'#9'10'#9'CreditLimit'#9'F'
      'Terms'#9'10'#9'Terms'#9'F'
      'Active'#9'5'#9'Active'#9'F'
      'Email'#9'24'#9'Email'#9'F'
      'Street'#9'20'#9'Street'#9'F'
      'Suburb'#9'20'#9'Suburb'#9'F'
      'State'#9'9'#9'State'#9'F'
      'Postcode'#9'10'#9'Postcode'#9'F'
      'AltPhone'#9'20'#9'AltPhone'#9'F'
      'Country'#9'12'#9'Country'#9'F'
      
        'Mobile'#9'20'#9'Mobile'#9'F]]></GridFields><TitleFont><Name>Arial</Name><' +
        'Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Ti' +
        'tleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640' +
        '</Color><Style></Style></Font><ShowGridLines>True</ShowGridLines' +
        '><AlternatingRowColor>536870911</AlternatingRowColor><CustomColu' +
        'mns></CustomColumns></grdMain></TRelatedCustomerListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TApprovalReminderListGUI", NULL, "<?xml ve' +
        'rsion=""1.0"" encoding=""UTF-8"" ?><TApprovalReminderListGUI><gr' +
        'dMain><GridFields><![CDATA[Company'#9'23'#9'Company'#9'F'
      'ApprovalType'#9'20'#9'Approval Type'#9'F'
      'ItemType'#9'10'#9'Type'#9'F'
      'PurchaseOrderNumber'#9'19'#9'Purchase Order Number'#9'F'
      'OrderDate'#9'10'#9'Order Date'#9'F'
      'Approved'#9'7'#9'Approved'#9'F'
      'Paid'#9'3'#9'Paid'#9'F'
      'TotalAmountInc'#9'14'#9'Total Amount (Inc)'#9'F'
      'ExpenseClaimEmployeeName'#9'21'#9'Expense Claim Employee'#9'F'
      
        'Invoiced'#9'6'#9'Invoiced'#9'F]]></GridFields><TitleFont><Name>Arial</Nam' +
        'e><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style><' +
        '/TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483' +
        '640</Color><Style></Style></Font><ShowGridLines>True</ShowGridLi' +
        'nes><AlternatingRowColor>536870911</AlternatingRowColor><CustomC' +
        'olumns></CustomColumns></grdMain></TApprovalReminderListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmCashFlowForecast", NULL, "<?xml versio' +
        'n=""1.0"" encoding=""UTF-8"" ?><TfrmCashFlowForecast><grdMain><G' +
        'ridFields><![CDATA[TimePeriod'#9'30'#9'Time Period'#9'F'
      'AccntsRec'#9'13'#9'Accnts Rec'#9'F'
      'AccntsPay'#9'13'#9'Accnts Pay'#9'F'
      'BankAccnts'#9'13'#9'Bank Accnts'#9'F'
      'NetInFlow'#9'12'#9'Net In Flow'#9'F'
      
        'ProjBalance'#9'12'#9'Proj Balance'#9'F]]></GridFields><TitleFont><Name>Ar' +
        'ial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold<' +
        '/Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>' +
        '-2147483640</Color><Style></Style></Font><ShowGridLines>True</Sh' +
        'owGridLines><AlternatingRowColor>536870911</AlternatingRowColor>' +
        '<CustomColumns></CustomColumns></grdMain></TfrmCashFlowForecast>' +
        '");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TGeneralLedgerReportGUI", NULL, "<?xml ver' +
        'sion=""1.0"" encoding=""UTF-8"" ?><TGeneralLedgerReportGUI><grdM' +
        'ain><GridFields><![CDATA[Date'#9'12'#9'Date'#9'F'
      'AccountName'#9'18'#9'Account Name'#9'F'
      'Type'#9'14'#9'Type'#9'F'
      'ProductName'#9'15'#9'Product'#9'F'
      'ProductDescription'#9'27'#9'Product Description'#9'F'
      'Class'#9'11'#9'Department'#9'F'
      'DebitsEx'#9'13'#9'Debits Ex'#9'F'
      'CreditsEx'#9'13'#9'Credits Ex'#9'F'
      'Client Name'#9'20'#9'Client Name'#9'F'
      
        'RepName'#9'17'#9'Rep Name'#9'F]]></GridFields><TitleFont><Name>Arial</Nam' +
        'e><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style><' +
        '/TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483' +
        '640</Color><Style></Style></Font><ShowGridLines>True</ShowGridLi' +
        'nes><AlternatingRowColor>536870911</AlternatingRowColor><CustomC' +
        'olumns></CustomColumns></grdMain></TGeneralLedgerReportGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TTaxSummaryReportGUI", NULL, "<?xml versio' +
        'n=""1.0"" encoding=""UTF-8"" ?><TTaxSummaryReportGUI><grdMain><G' +
        'ridFields><![CDATA[TaxCode'#9'15'#9'TaxCode'#9#9
      'INPUT_AmountEx'#9'10'#9'INPUTS Ex (Purchases)  '#9#9
      'INPUT_AmountInc'#9'10'#9'INPUTS Inc (Purchases)  '#9#9
      'OUTPUT_AmountEx'#9'10'#9'OUTPUTS Ex  (Sales) '#9#9
      'OUTPUT_AmountInc'#9'10'#9'OUTPUTS Inc (Sales)  '#9#9
      'TotalNet'#9'15'#9'Total Net'#9'F'#9
      'TotalTax'#9'15'#9'Total Tax'#9'F'#9
      'TaxRate'#9'10'#9'TaxRate'#9'F'#9
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor><CustomColumns></CustomColumn' +
        's></grdMain></TTaxSummaryReportGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TTransactionListGUI", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TTransactionListGUI><grdMain><Gri' +
        'dFields><![CDATA[Date'#9'10'#9'Date'#9'F'
      'GlobalRef'#9'11'#9'Global Ref'#9'F'
      'AccountName'#9'23'#9'Account Name'#9'F'
      'Account Type'#9'18'#9'Account Type'#9'F'
      'Client Name'#9'13'#9'Client Name'#9'F'
      'DebitsEx'#9'13'#9'Debits Ex'#9'F'
      'CreditsEx'#9'13'#9'Credits Ex'#9'F'
      'ProductName'#9'18'#9'Product'#9'F'
      
        'ProductDesc'#9'35'#9'Product Desc'#9'F]]></GridFields><TitleFont><Name>Ar' +
        'ial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold<' +
        '/Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>' +
        '-2147483640</Color><Style></Style></Font><ShowGridLines>True</Sh' +
        'owGridLines><AlternatingRowColor>536870911</AlternatingRowColor>' +
        '<CustomColumns></CustomColumns></grdMain></TTransactionListGUI>"' +
        ');'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmUnassignedTaxCodeList", NULL, "<?xml v' +
        'ersion=""1.0"" encoding=""UTF-8"" ?><TfrmUnassignedTaxCodeList><' +
        'grdMain><GridFields><![CDATA[Date'#9'10'#9'Date'#9'F'
      'Company'#9'24'#9'Company'#9'F'
      'Customer Name'#9'20'#9'Customer Name'#9'F'
      'Type'#9'14'#9'Type'#9'F'
      'Class Name'#9'15'#9'Department Name'#9'F'
      'Employee Name'#9'20'#9'Employee Name'#9'F'
      'Ship Date'#9'12'#9'Ship Date'#9'F'
      
        'Paid'#9'3'#9'Paid'#9'F]]></GridFields><TitleFont><Name>Arial</Name><Size>' +
        '9</Size><Color>-2147483640</Color><Style>fsBold</Style></TitleFo' +
        'nt><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</Col' +
        'or><Style></Style></Font><ShowGridLines>True</ShowGridLines><Alt' +
        'ernatingRowColor>536870911</AlternatingRowColor><CustomColumns><' +
        '/CustomColumns></grdMain></TfrmUnassignedTaxCodeList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TUnpaidBillGUI", NULL, "<?xml version=""1.' +
        '0"" encoding=""UTF-8"" ?><TUnpaidBillGUI><grdMain><GridFields><!' +
        '[CDATA[Name'#9'25'#9'Name'#9'F'
      'Type'#9'20'#9'Type'#9'F'
      'PONumber'#9'13'#9'PO Number'#9'F'
      'InvoiceNumber'#9'12'#9'Invoice Number'#9'F'
      'DueDate'#9'10'#9'Due Date'#9'F'
      
        'AmountDue'#9'14'#9'Amount Due'#9'F]]></GridFields><TitleFont><Name>Arial<' +
        '/Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Sty' +
        'le></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214' +
        '7483640</Color><Style></Style></Font><ShowGridLines>True</ShowGr' +
        'idLines><AlternatingRowColor>536870911</AlternatingRowColor><Cus' +
        'tomColumns></CustomColumns></grdMain></TUnpaidBillGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TAppointmentListReportGUI", NULL, "<?xml v' +
        'ersion=""1.0"" encoding=""UTF-8"" ?><TAppointmentListReportGUI><' +
        'grdMain><GridFields><![CDATA[Date'#9'12'#9'Date'#9'F'
      'Customer Name'#9'20'#9'Customer Name'#9'F'
      'Rep'#9'13'#9'Rep'#9'T'
      'Source'#9'14'#9'Source'#9'F'
      'Service'#9'11'#9'Service'#9'F'
      'Hours'#9'10'#9'Hours'#9'T'
      'Hourly Rate'#9'11'#9'Hourly Rate'#9'F'
      'Callout Fee'#9'11'#9'Callout Fee'#9'F'
      'TotalInc'#9'11'#9'Total Inc'#9'F'
      'TotalCost'#9'10'#9'Total Cost'#9'F'
      'Nett'#9'10'#9'Nett'#9'T'
      
        'Converted'#9'8'#9'Converted'#9'F]]></GridFields><TitleFont><Name>Arial</N' +
        'ame><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style' +
        '></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474' +
        '83640</Color><Style></Style></Font><ShowGridLines>True</ShowGrid' +
        'Lines><AlternatingRowColor>536870911</AlternatingRowColor><Custo' +
        'mColumns></CustomColumns></grdMain></TAppointmentListReportGUI>"' +
        ');'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmActionAuthorisationsList", NULL, "<?xm' +
        'l version=""1.0"" encoding=""UTF-8"" ?><TfrmActionAuthorisations' +
        'List><grdMain><GridFields><![CDATA[Type'#9'29'#9'Type'#9'F'
      'Who'#9'17'#9'Who'#9'F'
      'Date'#9'25'#9'Date'#9'F'
      
        'ActionSuccess'#9'14'#9'Action Success'#9'F]]></GridFields><TitleFont><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsB' +
        'old</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Co' +
        'lor>-2147483640</Color><Style></Style></Font><ShowGridLines>True' +
        '</ShowGridLines><AlternatingRowColor>536870911</AlternatingRowCo' +
        'lor><CustomColumns></CustomColumns></grdMain></TfrmActionAuthori' +
        'sationsList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TCombinedAnalysisListGUI", NULL, "<?xml ve' +
        'rsion=""1.0"" encoding=""UTF-8"" ?><TCombinedAnalysisListGUI><gr' +
        'dMain><GridFields><![CDATA[EmployeeName'#9'20'#9'Employee Name'#9'F'
      'ProductName'#9'20'#9'Product'#9'F'
      'ClassName'#9'15'#9'Department Name'#9'F'
      'ChargeableHours'#9'14'#9'Chargeable Hours'#9'F'
      'ChargedValue'#9'11'#9'Charged Value'#9'F'
      'NonChargeableHours'#9'18'#9'Non Chargeable Hours'#9'F'
      'NonChargedValue'#9'15'#9'Non Charged Value'#9'F'
      
        'RecoveryRate'#9'13'#9'Recovery Rate'#9'F]]></GridFields><TitleFont><Name>' +
        'Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBol' +
        'd</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style></Style></Font><ShowGridLines>True</' +
        'ShowGridLines><AlternatingRowColor>536870911</AlternatingRowColo' +
        'r><CustomColumns></CustomColumns></grdMain></TCombinedAnalysisLi' +
        'stGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TEmployeeAnalysisListGUI", NULL, "<?xml ve' +
        'rsion=""1.0"" encoding=""UTF-8"" ?><TEmployeeAnalysisListGUI><gr' +
        'dMain><GridFields><![CDATA[Company'#9'16'#9'Company'#9'F'
      'Jobname'#9'13'#9'Jobname'#9'F'
      'EmployeeName'#9'15'#9'Employee Name'#9'F'
      'ClassName'#9'14'#9'Department Name'#9'F'
      'ChargeableHours'#9'14'#9'Chargeable Hours'#9'F'
      'ChargedValue'#9'11'#9'Charged Value'#9'F'
      'ChargedTime'#9'11'#9'Charged Time'#9'F'
      'NonChargeableHours'#9'18'#9'Non Chargeable Hours'#9'F'
      
        'RecoveryRate'#9'11'#9'Recovery Rate'#9'F]]></GridFields><TitleFont><Name>' +
        'Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBol' +
        'd</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style></Style></Font><ShowGridLines>True</' +
        'ShowGridLines><AlternatingRowColor>536870911</AlternatingRowColo' +
        'r><CustomColumns></CustomColumns></grdMain></TEmployeeAnalysisLi' +
        'stGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TEmployeesFixedAssetsList", NULL, "<?xml v' +
        'ersion=""1.0"" encoding=""UTF-8"" ?><TEmployeesFixedAssetsList><' +
        'grdMain><GridFields><![CDATA[Title'#9'5'#9'Title'#9#9
      'EmployeeName'#9'25'#9'EmployeeName'#9'F'#9
      'Position'#9'25'#9'Position'#9'F'#9
      'AssetName'#9'25'#9'AssetName'#9'F'#9
      'AssetCode'#9'15'#9'AssetCode'#9'F'#9
      'AssetType'#9'15'#9'AssetType'#9'F'#9
      'PurchaseDate'#9'15'#9'PurchaseDate'#9'F'#9
      'PurchaseCost'#9'15'#9'PurchaseCost'#9'F'#9
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor><CustomColumns></CustomColumn' +
        's></grdMain></TEmployeesFixedAssetsList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TEmployeeReportByPeriodGUI", NULL, "<?xml ' +
        'version=""1.0"" encoding=""UTF-8"" ?><TEmployeeReportByPeriodGUI' +
        '><grdMain><GridFields><![CDATA[EmployeeName'#9'40'#9'EmployeeName'
      'SalesTarget'#9'10'#9'SalesTarget'
      'Total Amount (Ex)'#9'10'#9'Total Amount (Ex)'
      'Total Amount (Inc)'#9'10'#9'Total Amount (Inc)'
      'LineCostInc'#9'10'#9'LineCostInc'
      'LineCost'#9'10'#9'LineCost'
      'EmployeeID'#9'15'#9'EmployeeID'
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor></grdMain></TEmployeeReportBy' +
        'PeriodGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmSalesCommissionList", NULL, "<?xml vers' +
        'ion=""1.0"" encoding=""UTF-8"" ?><TfmSalesCommissionList><grdMai' +
        'n><GridFields><![CDATA[SaleDate'#9'9'#9'Sale Date'#9'F'
      'CustomerName'#9'18'#9'Customer Name'#9'F'
      'InvoiceDocNumber'#9'10'#9'Invoice Doc Number'#9'F'
      'CommissionOn'#9'7'#9'Commission On'#9'F'
      'ProductName'#9'18'#9'Product'#9'F'
      'QtyShipped'#9'6'#9'Qty Shipped'#9'F'
      'RunName'#9'15'#9'Run Name'#9'F'
      'SalesRep'#9'10'#9'Sales Rep'#9'F'
      'CommissionAmount'#9'10'#9'Commission Amount'#9'F'
      'CommissionPercent'#9'7'#9'Commission Percent'#9'F'
      'OnInvoice'#9'1'#9'On Invoice'#9'F'
      'IsPaid'#9'1'#9'Is Paid'#9'F'
      
        'PaidDate'#9'18'#9'Paid Date'#9'F]]></GridFields><TitleFont><Name>Arial</N' +
        'ame><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style' +
        '></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474' +
        '83640</Color><Style></Style></Font><ShowGridLines>True</ShowGrid' +
        'Lines><AlternatingRowColor>536870911</AlternatingRowColor><Custo' +
        'mColumns></CustomColumns></grdMain></TfmSalesCommissionList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmCommissionReportGUI", NULL, "<?xml ver' +
        'sion=""1.0"" encoding=""UTF-8"" ?><TfrmCommissionReportGUI><grdM' +
        'ain><GridFields><![CDATA[Company'#9'20'#9'Company'#9'F'
      'Job Name'#9'13'#9'Job Name'#9'F'
      'Job Number'#9'11'#9'Job Number'#9'F'
      'Sales Rep'#9'12'#9'Sales Rep'#9'F'
      'Invoice #'#9'10'#9'Invoice #'#9'F'
      'Invoice Date'#9'10'#9'Invoice Date'#9'F'
      'Invoice Total'#9'10'#9'Invoice Total'#9'F'
      'GP'#9'10'#9'GP $'#9'F'
      'GP %'#9'10'#9'GP %'#9'F'
      'Commission Rate'#9'14'#9'Commission Rate'#9'F'
      'Commission'#9'15'#9'Commission'#9'F'
      'Type'#9'11'#9'Type'#9'F'
      
        '(Ex)'#9'3'#9'(Ex)'#9'F]]></GridFields><TitleFont><Name>Arial</Name><Size>' +
        '9</Size><Color>-2147483640</Color><Style>fsBold</Style></TitleFo' +
        'nt><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</Col' +
        'or><Style></Style></Font><ShowGridLines>True</ShowGridLines><Alt' +
        'ernatingRowColor>536870911</AlternatingRowColor><CustomColumns><' +
        '/CustomColumns></grdMain></TfrmCommissionReportGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBarcodePickingManifest", NULL, "<?xml ver' +
        'sion=""1.0"" encoding=""UTF-8"" ?><TBarcodePickingManifest><grdM' +
        'ain><GridFields><![CDATA[Sale Date'#9'10'#9'Sale Date'#9'F'
      'Invoice Number'#9'13'#9'Invoice Number'#9'F'
      'Customer Name'#9'22'#9'Customer Name'#9'F'
      'ShipTo'#9'19'#9'Ship To'#9'F'
      'Suburb'#9'16'#9'Suburb'#9'T'
      'State'#9'9'#9'State'#9'T'
      'PostCode'#9'9'#9'Post Code'#9'T'
      'FinishedPackingTime'#9'18'#9'Finished Packing Time'#9'F'
      
        'Boxes'#9'15'#9'Boxes'#9'T]]></GridFields><TitleFont><Name>Arial</Name><Si' +
        'ze>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Titl' +
        'eFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</' +
        'Color><Style></Style></Font><ShowGridLines>True</ShowGridLines><' +
        'AlternatingRowColor>536870911</AlternatingRowColor><CustomColumn' +
        's></CustomColumns></grdMain></TBarcodePickingManifest>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBinLocationListGUI", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TBinLocationListGUI><grdMain><Gri' +
        'dFields><![CDATA[ClassName'#9'15'#9'Department'#9'F'
      'BinLocation'#9'17'#9'Bin Location'#9'F'
      'BinNumber'#9'13'#9'Bin Number'#9'F'
      'volume'#9'13'#9'Volume Total'#9'F'
      'Volume_used'#9'10'#9'Volume Used'#9'F'
      'VolumeAvailable'#9'13'#9'Volume Available'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TBinLocationListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmBinUsageReport", NULL, "<?xml version=' +
        '""1.0"" encoding=""UTF-8"" ?><TfrmBinUsageReport><grdMain><GridF' +
        'ields><![CDATA[Department Name'#9'21'#9'Department Name'#9'F'
      'Bin Location'#9'20'#9'Bin Location'#9'F'
      'Bin Number'#9'20'#9'Bin Number'#9'F'
      'DaysUsed'#9'15'#9'DaysUsed'#9'F'
      
        'Usage %'#9'10'#9'Usage %'#9'F]]></GridFields><TitleFont><Name>Arial</Name' +
        '><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></' +
        'TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474836' +
        '40</Color><Style></Style></Font><ShowGridLines>True</ShowGridLin' +
        'es><AlternatingRowColor>536870911</AlternatingRowColor><CustomCo' +
        'lumns></CustomColumns></grdMain></TfrmBinUsageReport>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmPriceListGUI", NULL, "<?xml version=""' +
        '1.0"" encoding=""UTF-8"" ?><TfrmPriceListGUI><grdMain><GridField' +
        's><![CDATA[PriceType'#9'15'#9'Price Type'#9'F'
      'AllClients'#9'8'#9'All Clients'#9'T'
      'Customer Type'#9'15'#9'Customer Type'#9'F'
      'Part Name'#9'19'#9'Part Name'#9'F'
      'Part Description'#9'40'#9'Part Description'#9'F'
      'DateFrom'#9'11'#9'Date From'#9'T'
      'DateTo'#9'11'#9'Date To'#9'T'
      'QtyPercent1'#9'10'#9'Qty Percent1'#9'T'
      'Discount 1'#9'10'#9'Discount 1'#9'T'
      'QtyPercent2'#9'10'#9'Qty Percent2'#9'T'
      'Discount 2'#9'10'#9'Discount 2'#9'T'
      'QtyPercent3'#9'10'#9'Qty Percent3'#9'T'
      'Discount 3'#9'10'#9'Discount 3'#9'T'
      'Original Price'#9'11'#9'Original Price'#9'F'
      'LinePrice'#9'10'#9'Line Price'#9'F'
      'Col1'#9'15'#9'Manufacture'#9'F'
      'Col2'#9'15'#9'Type'#9'F'
      'Col3'#9'15'#9'Dept'#9'F'
      'Discount %'#9'12'#9'Discount %'#9'F'
      'Permanent Discount'#9'16'#9'Permanent Discount'#9'F'
      'Special Product Discount'#9'20'#9'Special Product Discount'#9'F'
      
        'ExtraSellDesc'#9'17'#9'Extra Sell Desc'#9'T]]></GridFields><TitleFont><Na' +
        'me>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fs' +
        'Bold</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><C' +
        'olor>-2147483640</Color><Style></Style></Font><ShowGridLines>Tru' +
        'e</ShowGridLines><AlternatingRowColor>536870911</AlternatingRowC' +
        'olor><CustomColumns></CustomColumns></grdMain></TfrmPriceListGUI' +
        '>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmProductCommissionList", NULL, "<?xml ve' +
        'rsion=""1.0"" encoding=""UTF-8"" ?><TfmProductCommissionList><gr' +
        'dMain><GridFields><![CDATA[PartName'#9'20'#9'Part Name'#9'F'
      'Manufacturer'#9'17'#9'Manufacturer'#9'F'
      'Type'#9'15'#9'Type'#9'F'
      'Dept'#9'16'#9'Dept'#9'F'
      'IsPercentage'#9'11'#9'Is Percentage'#9'F'
      'CommissionRate'#9'14'#9'Commission Rate'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TfmProductCommissionList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmProductformulaList", NULL, "<?xml versi' +
        'on=""1.0"" encoding=""UTF-8"" ?><TfmProductformulaList><grdMain>' +
        '<GridFields><![CDATA[FormulaName'#9'40'#9'Formula Name'
      'Formula'#9'70'#9'Formula'#9'F'
      'Active'#9'1'#9'Active'
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor></grdMain></TfmProductformula' +
        'List>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TProductMovementForm", NULL, "<?xml versio' +
        'n=""1.0"" encoding=""UTF-8"" ?><TProductMovementForm><grdMain><G' +
        'ridFields><![CDATA[Period'#9'10'#9'Period'#9#9
      'TransType'#9'20'#9'TransType'#9#9
      'TransactionNo'#9'10'#9'TransactionNo'#9'F'#9
      'FirstColumn'#9'10'#9'FirstColumn'#9#9
      'SecondColumn'#9'10'#9'SecondColumn'#9#9
      'ThirdColumn'#9'10'#9'ThirdColumn'#9#9
      'Qty'#9'10'#9'Quantity'#9'F'#9
      'Total Cost'#9'10'#9'Total Cost'#9#9
      'RunningTotal'#9'10'#9'Running Total'#9'F'#9
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor><CustomColumns></CustomColumn' +
        's></grdMain></TProductMovementForm>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TProductSalesListGUI", NULL, "<?xml versio' +
        'n=""1.0"" encoding=""UTF-8"" ?><TProductSalesListGUI><grdMain><G' +
        'ridFields><![CDATA[PartType'#9'16'#9'PartType'#9'F'
      'PartName'#9'16'#9'PartName'#9'F'
      'Description'#9'40'#9'Description'#9'F'
      'FirstColumn'#9'15'#9'FirstColumn'#9'F'
      'SecondColumn'#9'15'#9'SecondColumn'#9'F'
      'ThirdColumn'#9'15'#9'ThirdColumn'#9'F'
      'Shipped'#9'8'#9'Shipped'#9'F'
      'InStockQty'#9'8'#9'InStockQty'#9'F'
      'On Order'#9'8'#9'On Order'#9'F'
      'Avg Price'#9'10'#9'Avg Price'#9'T'
      'Avg Cost'#9'10'#9'Avg Cost'#9'T'
      'Markup'#9'8'#9'Markup'#9'F'
      'Margin'#9'8'#9'Margin'#9'F'
      'Sales Orders'#9'10'#9'Sales Orders'#9'F'
      'Invoice BO'#9'8'#9'Invoice BO'#9'F'
      'Reorder Point'#9'11'#9'Reorder Point'#9'F'
      'PreferredLevel'#9'12'#9'Preferred Level'#9'F'
      'Reorder Amount'#9'13'#9'Reorder Amount'#9'F'
      'Attrib1Sale'#9'10'#9'Attrib1Sale'#9'F'
      'Attrib2Sale'#9'10'#9'Attrib2Sale'#9'F'
      'Attrib1SaleRate'#9'12'#9'Attrib1SaleRate'#9'F'
      
        'MonthlyAverageActivityQuantity'#9'26'#9'Monthly Average Activity Quant' +
        'ity'#9'F'
      'ProjectedWeeklyUnits'#9'18'#9'ProjectedWeeklyUnits'#9'F'
      'ProjectedMonthlyUnits'#9'18'#9'ProjectedMonthlyUnits'#9'F'
      'ProjectedAnnualUnits'#9'17'#9'ProjectedAnnualUnits'#9'F'
      'ProjectedWeeklyProfit'#9'18'#9'ProjectedWeeklyProfit'#9'F'
      'ProjectedMonthlyProfit'#9'18'#9'ProjectedMonthlyProfit'#9'F'
      
        'ProjectedAnnualProfit'#9'17'#9'ProjectedAnnualProfit'#9'F]]></GridFields>' +
        '<TitleFont><Name>Arial</Name><Size>9</Size><Color>-2147483640</C' +
        'olor><Style>fsBold</Style></TitleFont><Font><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style></Style></Font><Sho' +
        'wGridLines>True</ShowGridLines><AlternatingRowColor>536870911</A' +
        'lternatingRowColor><CustomColumns></CustomColumns></grdMain></TP' +
        'roductSalesListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TProductSummaryGUI", NULL, "<?xml version=' +
        '""1.0"" encoding=""UTF-8"" ?><TProductSummaryGUI><grdMain><GridF' +
        'ields><![CDATA[ProductName'#9'19'#9'ProductName'#9'F'
      'FirstColumn'#9'10'#9'FirstColumn'#9'F'
      'SecondColumn'#9'12'#9'SecondColumn'#9'F'
      'ThirdColumn'#9'12'#9'ThirdColumn'#9'F'
      'ProductDescription'#9'20'#9'ProductDescription'#9'F'
      'Qty'#9'10'#9'Qty'#9'T'
      'Line Cost (Ex)'#9'11'#9'Line Cost (Ex)'#9'F'
      'Total Amount (Ex)'#9'14'#9'Total Amount (Ex)'#9'F'
      'Total Amount (Inc)'#9'14'#9'Total Amount (Inc)'#9'F'
      'CustomerName'#9'24'#9'CustomerName'#9'F'
      'InvoiceNo'#9'9'#9'InvoiceNo'#9'F'
      'Transactiontype'#9'9'#9'Type'#9'F'
      'UnitOfMeasure'#9'12'#9'UnitOfMeasure'#9'F'
      'TransactionNo'#9'12'#9'Transaction No'#9'F'
      'EmployeeName'#9'13'#9'EmployeeName'#9'F'
      
        'IsSpecial'#9'10'#9'Is Special'#9'F]]></GridFields><TitleFont><Name>Arial<' +
        '/Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Sty' +
        'le></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214' +
        '7483640</Color><Style></Style></Font><ShowGridLines>True</ShowGr' +
        'idLines><AlternatingRowColor>536870911</AlternatingRowColor><Cus' +
        'tomColumns></CustomColumns></grdMain></TProductSummaryGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TProductSalesSummaryByColumnGUI", NULL, "<' +
        '?xml version=""1.0"" encoding=""UTF-8"" ?><TProductSalesSummaryB' +
        'yColumnGUI><grdMain><GridFields><![CDATA[ProductName'#9'20'#9'Product'#9 +
        'F'
      'ProductDescription'#9'46'#9'Product Description'#9'F'
      'TotalCost'#9'12'#9'Total Cost'#9'F'
      'TotalPrice'#9'13'#9'Total Price'#9'F'
      'TotalTax'#9'11'#9'Total Tax'#9'F'
      'Margin'#9'12'#9'Margin'#9'F'
      
        'Margin (%)'#9'11'#9'Margin (%)'#9'F]]></GridFields><TitleFont><Name>Arial' +
        '</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</St' +
        'yle></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21' +
        '47483640</Color><Style></Style></Font><ShowGridLines>True</ShowG' +
        'ridLines><AlternatingRowColor>536870911</AlternatingRowColor><Cu' +
        'stomColumns></CustomColumns></grdMain></TProductSalesSummaryByCo' +
        'lumnGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TStockStatusRoling", NULL, "<?xml version=' +
        '""1.0"" encoding=""UTF-8"" ?><TStockStatusRoling><grdMain><GridF' +
        'ields><![CDATA[ProductName'#9'25'#9'Product'#9'F'
      'Firstcolumn'#9'15'#9'Manufacture'#9'F'
      'Secondcolumn'#9'15'#9'Type'#9'F'
      'Thirdcolumn'#9'15'#9'Dept'#9'F'
      'Qty'#9'10'#9'Qty'#9'F'#9'Quantity'
      'RunningQty'#9'10'#9'Running Qty'#9'F'#9'Quantity'
      'TotalCost'#9'12'#9'Total Cost'#9'F'
      
        'Avgcost'#9'11'#9'Avgcost'#9'F]]></GridFields><TitleFont><Name>Arial</Name' +
        '><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></' +
        'TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474836' +
        '40</Color><Style></Style></Font><ShowGridLines>True</ShowGridLin' +
        'es><AlternatingRowColor>536870911</AlternatingRowColor><CustomCo' +
        'lumns></CustomColumns></grdMain></TStockStatusRoling>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TStockQtysLocationsReportGUI", NULL, "<?xm' +
        'l version=""1.0"" encoding=""UTF-8"" ?><TStockQtysLocationsRepor' +
        'tGUI><grdMain><GridFields><![CDATA[ProductName'#9'23'#9'Product'#9'F'
      'PartsDescription'#9'19'#9'PartsDescription'#9'F'
      'UOM'#9'8'#9'UOM'#9'F'
      'ProductColumn1'#9'13'#9'Manufacture'#9'F'#9'Product Group'
      'ProductColumn2'#9'14'#9'Type'#9'F'#9'Product Group'
      'ProductColumn3'#9'13'#9'Dept'#9'F'#9'Product Group'
      'Classname'#9'10'#9'Classname'#9'F'
      'Batchnumber'#9'10'#9'Number'#9'F'#9'Batch'
      'ExpiryDate'#9'10'#9'Expiry Date'#9'F'#9'Batch'
      'Binlocation'#9'10'#9'Location'#9'F'#9'Bin'
      'Binnumber'#9'12'#9'Binnumber'#9'F'#9'Bin'
      'Serialnumber'#9'11'#9'Serialnumber'#9'F'
      'Cost'#9'10'#9'Cost'#9'F'
      'Value'#9'10'#9'Value'#9'F'
      'SOUOMQty'#9'10'#9'Sales Order'#9'F'#9'UOM Quantity'
      'InstockUOMQty'#9'10'#9'In-Stock'#9'F'#9'UOM Quantity'
      
        'UOMQty'#9'12'#9'iIf read as UOM'#9'F'#9'Unit of Measure Quantities as Bought' +
        ' and Sold'
      
        'UOMMultiplierDesc1'#9'10'#9'Multiplier'#9'F'#9'Unit of Measure Quantities as' +
        ' Bought and Sold'
      
        'Qty'#9'16'#9'If read as Units'#9'F'#9'Unit of Measure Quantities as Bought a' +
        'nd Sold'
      'AvailableQty'#9'12'#9'If read as Units'#9'F'#9'Product'#39's Total Available Qty'
      'UOMMultiplierDesc2'#9'10'#9'Multiplier'#9'F'#9'Product'#39's Total Available Qty'
      
        'AvailableUOMQty'#9'11'#9'If read as UOM'#9'F'#9'Product'#39's Total Available Qt' +
        'y'
      
        'UnAllocatedInstockUOMQty'#9'10'#9'In-Stock'#9'F'#9'Bin/Batch Un Allocated Qu' +
        'antity'
      'UnAllocatedSOUOMQty'#9'10'#9'SO'#9'F'#9'Bin/Batch Un Allocated Quantity'
      
        'UnAllocatedUOMQty'#9'10'#9'Available'#9'F'#9'Bin/Batch Un Allocated Quantity' +
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor><CustomColumns></CustomColumn' +
        's></grdMain></TStockQtysLocationsReportGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TStockStatusReportGUI", NULL, "<?xml versi' +
        'on=""1.0"" encoding=""UTF-8"" ?><TStockStatusReportGUI><grdMain>' +
        '<GridFields><![CDATA[Product'#9'15'#9'Product'#9'F'
      'Firstcolumn'#9'12'#9'Manufacture'#9'F'
      'Secondcolumn'#9'11'#9'Type'#9'F'
      'Thirdcolumn'#9'11'#9'Dept'#9'F'
      'Trans Type'#9'16'#9'Trans Type'#9'F'
      'TransactionNo'#9'16'#9'Transaction Number'#9'F'
      'Qty'#9'10'#9'Qty'#9'F'
      'Total Cost'#9'12'#9'Total Cost'#9'F'
      'ClassName'#9'14'#9'Department Name'#9'F'
      
        'Period'#9'11'#9'Period'#9'F]]></GridFields><TitleFont><Name>Arial</Name><' +
        'Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Ti' +
        'tleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640' +
        '</Color><Style></Style></Font><ShowGridLines>True</ShowGridLines' +
        '><AlternatingRowColor>536870911</AlternatingRowColor><CustomColu' +
        'mns></CustomColumns></grdMain></TStockStatusReportGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TUnAllocatedBinsReportGUI", NULL, "<?xml v' +
        'ersion=""1.0"" encoding=""UTF-8"" ?><TUnAllocatedBinsReportGUI><' +
        'grdMain><GridFields><![CDATA[ProductName'#9'18'#9'Product'#9'F'
      'ClassName'#9'18'#9'Department Name'#9'F'
      'InStock'#9'10'#9'In Stock'#9'F'
      'BinsTotal'#9'10'#9'Bins Total'#9'F'
      
        'UnAllocated'#9'10'#9'Un Allocated'#9'F]]></GridFields><TitleFont><Name>Ar' +
        'ial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold<' +
        '/Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>' +
        '-2147483640</Color><Style></Style></Font><ShowGridLines>True</Sh' +
        'owGridLines><AlternatingRowColor>536870911</AlternatingRowColor>' +
        '<CustomColumns></CustomColumns></grdMain></TUnAllocatedBinsRepor' +
        'tGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TUnitsOfMeasureListGUI", NULL, "<?xml vers' +
        'ion=""1.0"" encoding=""UTF-8"" ?><TUnitsOfMeasureListGUI><grdMai' +
        'n><GridFields><![CDATA[Product'#9'18'#9'Product'#9'F'
      'UnitName'#9'15'#9'Unit Name'#9'F'
      'UnitDescription'#9'20'#9'Unit Description'#9'F'
      'SalesDefault'#9'10'#9'Sales Default'#9'F'
      'PurchasesDefault'#9'15'#9'Purchases Default'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TUnitsOfMeasureListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmCustomerJobFollowupList", NULL, "<?xml' +
        ' version=""1.0"" encoding=""UTF-8"" ?><TfrmCustomerJobFollowupLi' +
        'st><grdMain><GridFields><![CDATA[Company'#9'30'#9'Company'
      'Follow Up Date'#9'12'#9'Follow Up Date'
      'Notes'#9'30'#9'Notes'
      'Done'#9'1'#9'Done'
      'Hours'#9'10'#9'Hours'
      'Title'#9'5'#9'Title'
      'FirstName'#9'15'#9'FirstName'
      'MiddleName'#9'15'#9'MiddleName'
      'LastName'#9'15'#9'LastName'
      'Street'#9'15'#9'Street'
      'Street2'#9'15'#9'Street2'
      'Suburb'#9'15'#9'Suburb'
      'State'#9'7'#9'State'
      'PostCode'#9'8'#9'PostCode'
      'Phone'#9'15'#9'Phone'
      'Mobile'#9'15'#9'Mobile'
      'Fax'#9'15'#9'Fax'
      'Email'#9'20'#9'Email'
      'Customer'#9'1'#9'Customer'
      'Supplier'#9'1'#9'Supplier'
      'Other Contact'#9'1'#9'Other Contact'
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor><CustomColumns></CustomColumn' +
        's></grdMain></TfrmCustomerJobFollowupList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TJobAnalysisReportGUI", NULL, "<?xml versi' +
        'on=""1.0"" encoding=""UTF-8"" ?><TJobAnalysisReportGUI><grdMain>' +
        '<GridFields><![CDATA[Company'#9'16'#9'Company'#9'F'
      'JobName'#9'14'#9'Job Name'#9'F'
      'JobNumber'#9'9'#9'Job Number'#9'F'
      'ServiceName'#9'13'#9'Service Name'#9'F'
      'ServiceDate'#9'10'#9'Service Date'#9'F'
      'Qty'#9'7'#9'Qty'#9'F'
      'Hours'#9'10'#9'Hours'#9'F'
      'ChargeRate'#9'11'#9'Charge Rate'#9'F'
      'TotalCharge'#9'12'#9'Total Charge'#9'F'
      'TotalInvoiced'#9'11'#9'Total Invoiced'#9'F'
      'BeenInvoiced'#9'11'#9'Been Invoiced'#9'F'
      'Difference'#9'11'#9'Difference'#9'F'
      'EmployeeName'#9'15'#9'Employee Name'#9'F'
      'ClassName'#9'14'#9'Department Name'#9'F'
      'Notes'#9'26'#9'Notes'#9'F'
      'Invoice Date'#9'10'#9'Invoice Date'#9'F'
      
        'Invoice Ref #'#9'13'#9'Invoice Ref #'#9'F]]></GridFields><TitleFont><Name' +
        '>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBo' +
        'ld</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Col' +
        'or>-2147483640</Color><Style></Style></Font><ShowGridLines>True<' +
        '/ShowGridLines><AlternatingRowColor>536870911</AlternatingRowCol' +
        'or><CustomColumns></CustomColumns></grdMain></TJobAnalysisReport' +
        'GUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TPayJobListGUI", NULL, "<?xml version=""1.' +
        '0"" encoding=""UTF-8"" ?><TPayJobListGUI><grdMain><GridFields><!' +
        '[CDATA[EmpName'#9'19'#9'Emp Name'#9'F'
      'PayDate'#9'11'#9'Pay Date'#9'F'
      'DatePaid'#9'11'#9'Date Paid'#9'F'
      'Job'#9'21'#9'Job'#9'F'
      'Wages'#9'12'#9'Wages'#9'T'
      'Allowances'#9'13'#9'Allowances'#9'T'
      'Sundries'#9'12'#9'Sundries'#9'T'
      
        'Total'#9'12'#9'Total'#9'T]]></GridFields><TitleFont><Name>Arial</Name><Si' +
        'ze>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Titl' +
        'eFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</' +
        'Color><Style></Style></Font><ShowGridLines>True</ShowGridLines><' +
        'AlternatingRowColor>536870911</AlternatingRowColor><CustomColumn' +
        's></CustomColumns></grdMain></TPayJobListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TProfitLossSummaryGUI", NULL, "<?xml versi' +
        'on=""1.0"" encoding=""UTF-8"" ?><TProfitLossSummaryGUI></TProfit' +
        'LossSummaryGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TMarketingContactRawListGUI", NULL, "<?xml' +
        ' version=""1.0"" encoding=""UTF-8"" ?><TMarketingContactRawListG' +
        'UI><grdMain><GridFields><![CDATA[COMPANY'#9'20'#9'COMPANY'
      'Title'#9'10'#9'Title'
      'FirstName'#9'20'#9'First~Name'#9'F'
      'MiddleName'#9'20'#9'Middle~Name'#9'F'
      'LastName'#9'20'#9'Last~Name'#9'F'
      'Street'#9'20'#9'Street'#9'F'#9'Address'
      'Street2'#9'20'#9'Street2'#9'F'#9'Address'
      'Street3'#9'20'#9'Street3'#9'F'#9'Address'
      'SUBURB'#9'20'#9'SUBURB'#9'F'#9'Address'
      'STATE'#9'20'#9'STATE'#9'F'#9'Address'
      'Country'#9'20'#9'Country'#9'F'#9'Address'
      'POSTCODE'#9'20'#9'POSTCODE'#9'F'#9'Address'
      'FaxNumber'#9'20'#9'Fax Number'#9'F'#9'Contact'
      'Phone'#9'20'#9'Phone'#9'F'#9'Contact'
      'AltPhone'#9'20'#9'Alt Phone'#9'F'#9'Contact'
      'Mobile'#9'20'#9'Mobile'#9'F'#9'Contact'
      'EmployeeSize'#9'20'#9'Employee Size'
      'Notes'#9'20'#9'Notes'
      'JobTitle'#9'10'#9'Job Title'
      'DateOfBirth'#9'10'#9'Date Of Birth'#9'F'
      'Duration'#9'10'#9'Duration'
      'Source'#9'20'#9'Source'
      'Active'#9'1'#9'Active'
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor></grdMain></TMarketingContact' +
        'RawListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBarTabListGUI", NULL, "<?xml version=""1.' +
        '0"" encoding=""UTF-8"" ?><TBarTabListGUI><grdMain><GridFields><!' +
        '[CDATA[CustomerName'#9'22'#9'Customer Name'#9'F'
      'BarTabEntrys'#9'19'#9'Bar Tab Entrys'#9'F'
      'Details'#9'15'#9'Details'#9'F'
      'Amount'#9'14'#9'Amount'#9'F'
      'SaleDate'#9'10'#9'Sale Date'#9'F'
      'TimeOfSale'#9'11'#9'Time Of Sale'#9'F'
      'TillName'#9'15'#9'Till Name'#9'F'
      'EmployeeName'#9'19'#9'Employee Name'#9'F'
      
        'Class'#9'14'#9'Department'#9'F]]></GridFields><TitleFont><Name>Arial</Nam' +
        'e><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style><' +
        '/TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483' +
        '640</Color><Style></Style></Font><ShowGridLines>True</ShowGridLi' +
        'nes><AlternatingRowColor>536870911</AlternatingRowColor><CustomC' +
        'olumns></CustomColumns></grdMain></TBarTabListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmBlindBalanceReport", NULL, "<?xml vers' +
        'ion=""1.0"" encoding=""UTF-8"" ?><TfrmBlindBalanceReport><grdMai' +
        'n><GridFields><![CDATA[PeriodNumber'#9'12'#9'Period~Name'#9'F'#9'Period'
      'StartDate'#9'18'#9'Start Date'#9'F'#9'Period'
      'EndDate'#9'18'#9'End Date'#9'F'#9'Period'
      'PeriodTotal'#9'10'#9'PeriodTotal'#9'F'#9'Period'
      'TillName'#9'13'#9'Till~Name'#9'F'
      'EmployeeName'#9'15'#9'Employee'#9'F'
      'Variation'#9'10'#9'Variation'#9'F'
      'TotalLineAmount'#9'10'#9'Amount(Ex)'#9'F'
      'TotalAmountinc'#9'10'#9'Amount(Inc)'#9'F'
      'TotalCash'#9'10'#9'TotalCash'#9'F'#9'Till Collection - Amount'
      'CreditCard'#9'10'#9'CreditCard'#9'F'#9'Till Collection - Amount'
      'EFTPOS'#9'10'#9'EFTPOS'#9'F'#9'Till Collection - Amount'
      'Visa'#9'10'#9'Visa'#9'F'#9'Till Collection - Amount'
      'MasterCard'#9'10'#9'MasterCard'#9'F'#9'Till Collection - Amount'
      'Cheques'#9'10'#9'Cheques'#9'F'#9'Till Collection - Amount'
      'DinersClub'#9'10'#9'DinersClub'#9'F'#9'Till Collection - Amount'
      'Bankcard'#9'10'#9'Bankcard'#9'F'#9'Till Collection - Amount'
      'Amex'#9'10'#9'Amex'#9'F'#9'Till Collection - Amount'
      'Hundreds'#9'10'#9'Hundreds'#9'F'#9'Cash Collected'
      'Fifties'#9'10'#9'Fifties'#9'F'#9'Cash Collected'
      'Twenties'#9'10'#9'Twenties'#9'F'#9'Cash Collected'
      'Tens'#9'10'#9'Tens'#9'F'#9'Cash Collected'
      'Fives'#9'10'#9'Fives'#9'F'#9'Cash Collected'
      'Twos'#9'10'#9'Twos'#9'F'#9'Cash Collected'
      'Ones'#9'10'#9'Ones'#9'F'#9'Cash Collected'
      'FiftyCents'#9'10'#9'FiftyCents'#9'F'#9'Cash Collected'
      'TwentyCents'#9'10'#9'TwentyCents'#9'F'#9'Cash Collected'
      'TenCents'#9'10'#9'TenCents'#9'F'#9'Cash Collected'
      'FiveCents'#9'10'#9'FiveCents'#9'F'#9'Cash Collected'
      'InvoicePayments'#9'13'#9'InvoicePayments'#9'F'#9'Sales Details'
      'ProductName'#9'16'#9'Product~Name'#9'F'#9'Sales Details'
      'QtySold'#9'15'#9'Qty~Sold'#9'F'#9'Sales Details'
      'SaleDateTime'#9'19'#9'SaleDateTime'#9'F'#9'Sales Details'
      
        'InvoiceDocNumber'#9'15'#9'InvoiceDocNumber'#9'F'#9'Sales Details]]></GridFie' +
        'lds><TitleFont><Name>Arial</Name><Size>9</Size><Color>-214748364' +
        '0</Color><Style>fsBold</Style></TitleFont><Font><Name>Arial</Nam' +
        'e><Size>9</Size><Color>-2147483640</Color><Style></Style></Font>' +
        '<ShowGridLines>True</ShowGridLines><AlternatingRowColor>53687091' +
        '1</AlternatingRowColor><CustomColumns></CustomColumns></grdMain>' +
        '</TfrmBlindBalanceReport>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmHourlySalesReport", NULL, "<?xml versio' +
        'n=""1.0"" encoding=""UTF-8"" ?><TfmHourlySalesReport><grdMain><G' +
        'ridFields><![CDATA[SaleDateTime'#9'18'#9'Sale Date Time'#9'F'
      'DocNumber'#9'10'#9'Doc Number'#9'F'
      'CustomerName'#9'15'#9'Customer Name'#9'F'
      'Department'#9'11'#9'Department'#9'F'
      'Sales 00:00'#9'10'#9'Sales 00:00'#9'F'
      'Sales 07:00'#9'10'#9'Sales 07:00'#9'F'
      'Sales 08:00'#9'10'#9'Sales 08:00'#9'F'
      'Sales 09:00'#9'10'#9'Sales 09:00'#9'F'
      'Sales 10:00'#9'10'#9'Sales 10:00'#9'F'
      'Sales 11:00'#9'10'#9'Sales 11:00'#9'F'
      'Sales 12:00'#9'10'#9'Sales 12:00'#9'F'
      'Sales 13:00'#9'10'#9'Sales 13:00'#9'F'
      'Sales 14:00'#9'10'#9'Sales 14:00'#9'F'
      'Sales 15:00'#9'10'#9'Sales 15:00'#9'F'
      'Sales 16:00'#9'10'#9'Sales 16:00'#9'F'
      'Sales 17:00'#9'10'#9'Sales 17:00'#9'F'
      'Sales 18:00'#9'10'#9'Sales 18:00'#9'F'
      
        'Sales 19:00'#9'10'#9'Sales 19:00'#9'F]]></GridFields><TitleFont><Name>Ari' +
        'al</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</' +
        'Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-' +
        '2147483640</Color><Style></Style></Font><ShowGridLines>True</Sho' +
        'wGridLines><AlternatingRowColor>536870911</AlternatingRowColor><' +
        'CustomColumns></CustomColumns></grdMain><TimeList></TimeList></T' +
        'fmHourlySalesReport>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmEndOfPeriodPOS", NULL, "<?xml version=' +
        '""1.0"" encoding=""UTF-8"" ?><TfrmEndOfPeriodPOS><grdMain><GridF' +
        'ields><![CDATA[StartDate'#9'22'#9'Start Date'#9'F'
      'EndDate'#9'25'#9'End Date'#9'F'
      
        'TillName'#9'10'#9'Till Name'#9'F]]></GridFields><TitleFont><Name>Arial</N' +
        'ame><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style' +
        '></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474' +
        '83640</Color><Style></Style></Font><ShowGridLines>True</ShowGrid' +
        'Lines><AlternatingRowColor>536870911</AlternatingRowColor><Custo' +
        'mColumns></CustomColumns></grdMain></TfrmEndOfPeriodPOS>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TTillSummaryReportGUI", NULL, "<?xml versi' +
        'on=""1.0"" encoding=""UTF-8"" ?><TTillSummaryReportGUI><grdMain>' +
        '<GridFields><![CDATA[SaleDate'#9'10'#9'Sale Date'#9'F'
      'TillName'#9'11'#9'Till Name'#9'F'
      'Class'#9'11'#9'Department'#9'F'
      'SaleType'#9'10'#9'Sale Type'#9'F'
      'Cash'#9'11'#9'Cash'#9'T'
      'EFTPOS'#9'11'#9'EFTPOS'#9'T'
      'Cheque'#9'11'#9'Cheque'#9'T'
      'DinersClub'#9'11'#9'Diners Club'#9'T'
      'MasterCard'#9'11'#9'Master Card'#9'T'
      'VISA'#9'11'#9'VISA'#9'T'
      'Amex'#9'11'#9'Amex'#9'T'
      'AmericanExpress'#9'15'#9'American Express'#9'T'
      'BankCard'#9'11'#9'Bank Card'#9'T'
      'CreditCard'#9'11'#9'Credit Card'#9'T'
      'DirectDebt'#9'11'#9'Direct Debt'#9'T'
      'DirectDeposit'#9'13'#9'Direct Deposit'#9'T'
      'MoneyOrder'#9'12'#9'Money Order'#9'T'
      'Layby'#9'11'#9'Layby'#9'T'
      'Voucher'#9'11'#9'Voucher'#9'T'
      'VoucherReversal'#9'14'#9'Voucher Reversal'#9'T'
      'Invoice'#9'12'#9'Invoice'#9'F'
      'Total'#9'12'#9'Total'#9'F'
      'SalesCount'#9'9'#9'Sales Count'#9'F'
      
        'TotalsAvg'#9'15'#9'Totals Avg'#9'F]]></GridFields><TitleFont><Name>Arial<' +
        '/Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Sty' +
        'le></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214' +
        '7483640</Color><Style></Style></Font><ShowGridLines>True</ShowGr' +
        'idLines><AlternatingRowColor>536870911</AlternatingRowColor><Cus' +
        'tomColumns></CustomColumns></grdMain></TTillSummaryReportGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TTrafficListGUI", NULL, "<?xml version=""1' +
        '.0"" encoding=""UTF-8"" ?><TTrafficListGUI><grdMain><GridFields>' +
        '<![CDATA[Branch'#9'40'#9'Branch'
      'BranchDescription'#9'40'#9'BranchDescription'#9'F'
      'Recorder'#9'10'#9'Recorder'
      'Date'#9'10'#9'Date'
      'Hour'#9'10'#9'Hour'
      'Count'#9'10'#9'Count'
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor></grdMain></TTrafficListGUI>"' +
        ');'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TTrafficMonitoringSummaryGUI", NULL, "<?xm' +
        'l version=""1.0"" encoding=""UTF-8"" ?><TTrafficMonitoringSummar' +
        'yGUI><grdMain><GridFields><![CDATA[Period'#9'10'#9'Date'#9'F'
      'Hour'#9'10'#9'Hour'#9'F'
      'Branch'#9'16'#9'Branch'#9'F'
      'BranchDescription'#9'20'#9'Branch Description'#9'F'
      
        'Count'#9'10'#9'Count'#9'F]]></GridFields><TitleFont><Name>Arial</Name><Si' +
        'ze>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Titl' +
        'eFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</' +
        'Color><Style></Style></Font><ShowGridLines>True</ShowGridLines><' +
        'AlternatingRowColor>536870911</AlternatingRowColor><CustomColumn' +
        's></CustomColumns></grdMain></TTrafficMonitoringSummaryGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TVoucherListGUI", NULL, "<?xml version=""1' +
        '.0"" encoding=""UTF-8"" ?><TVoucherListGUI><grdMain><GridFields>' +
        '<![CDATA[VoucherNo'#9'13'#9'Voucher No'#9'F'
      'Issuing Class'#9'15'#9'Issuing Department'#9'F'
      'Company'#9'19'#9'Company'#9'F'
      'Value'#9'10'#9'Value'#9'F'
      'Inv No'#9'10'#9'Inv No'#9'F'
      'Other Store'#9'13'#9'Other Store'#9'F'
      'DateCreated'#9'13'#9'Date Created'#9'F'
      'IsIssued'#9'9'#9'Is Issued'#9'F'
      'DateIssued'#9'13'#9'Date Issued'#9'F'
      'IsRedeemed'#9'10'#9'Is Redeemed'#9'F'
      'DateRedeemed'#9'12'#9'Date Redeemed'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TVoucherListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TAccountsPayableNotes", NULL, "<?xml versi' +
        'on=""1.0"" encoding=""UTF-8"" ?><TAccountsPayableNotes><grdMain>' +
        '<GridFields><![CDATA[SupplierName'#9'18'#9'Supplier Name'#9'F'
      'APNotes'#9'38'#9'AP Notes'#9'F'
      'PONumber'#9'14'#9'PO Number'#9'F'
      'OrderDate'#9'10'#9'Order Date'#9'F'
      'TotalAmountInc'#9'13'#9'Total Amount Inc'#9'F'
      
        'EmployeeName'#9'16'#9'Employee Name'#9'F]]></GridFields><TitleFont><Name>' +
        'Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBol' +
        'd</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style></Style></Font><ShowGridLines>True</' +
        'ShowGridLines><AlternatingRowColor>536870911</AlternatingRowColo' +
        'r><CustomColumns></CustomColumns></grdMain></TAccountsPayableNot' +
        'es>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TChequeDetailsListGUI", NULL, "<?xml versi' +
        'on=""1.0"" encoding=""UTF-8"" ?><TChequeDetailsListGUI><grdMain>' +
        '<GridFields><![CDATA[Company'#9'19'#9'Company'#9'F'
      'ChequeNumber'#9'14'#9'Cheque Number'#9'F'
      'ReferenceNo'#9'13'#9'Reference No'#9'F'
      'Amount (Ex)'#9'12'#9'Amount (Ex)'#9'F'
      'Amount (Inc)'#9'12'#9'Amount (Inc)'#9'F'
      'Comments'#9'45'#9'Comments'#9'F'
      'AccountName'#9'17'#9'Account Name'#9'F'
      'Memo'#9'10'#9'Memo'#9'F'
      'Contact1'#9'14'#9'Contact1'#9'F'
      'Phone'#9'12'#9'Phone'#9'F'
      'CustomerJob'#9'14'#9'Customer Job'#9'F'
      
        'Department'#9'13'#9'Department'#9'F]]></GridFields><TitleFont><Name>Arial' +
        '</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</St' +
        'yle></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21' +
        '47483640</Color><Style></Style></Font><ShowGridLines>True</ShowG' +
        'ridLines><AlternatingRowColor>536870911</AlternatingRowColor><Cu' +
        'stomColumns></CustomColumns></grdMain></TChequeDetailsListGUI>")' +
        ';'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TExpenseClaimListGUI", NULL, "<?xml versio' +
        'n=""1.0"" encoding=""UTF-8"" ?><TExpenseClaimListGUI><grdMain><G' +
        'ridFields><![CDATA[EmployeeName'#9'15'#9'Employee Name'#9'F'
      'Company'#9'23'#9'Company'#9'F'
      'Comments'#9'24'#9'Comments'#9'F'
      'OrderDate'#9'10'#9'Claim Date'#9'F'
      'ClaimNumber'#9'11'#9'Claim Number'#9'F'
      'Total Amount (Ex)'#9'14'#9'Total Amount (Ex)'#9'F'
      'Total Tax'#9'10'#9'Total Tax'#9'F'
      'Total Amount (Inc)'#9'14'#9'Total Amount (Inc)'#9'F'
      'Type'#9'11'#9'Type'#9'F'
      'Approved'#9'7'#9'Approved'#9'F'
      'Paid'#9'5'#9'Paid'#9'F'
      'Invoiced'#9'6'#9'Invoiced'#9'F'
      'InvoiceNumber'#9'12'#9'Invoice Number'#9'F'
      'Contact'#9'17'#9'Contact'#9'F'
      
        'Phone'#9'13'#9'Phone'#9'F]]></GridFields><TitleFont><Name>Arial</Name><Si' +
        'ze>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Titl' +
        'eFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</' +
        'Color><Style></Style></Font><ShowGridLines>True</ShowGridLines><' +
        'AlternatingRowColor>536870911</AlternatingRowColor><CustomColumn' +
        's></CustomColumns></grdMain></TExpenseClaimListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmPayAllowancesReport", NULL, "<?xml ver' +
        'sion=""1.0"" encoding=""UTF-8"" ?><TfrmPayAllowancesReport><grdM' +
        'ain><GridFields><![CDATA[EmpName'#9'22'#9'Emp Name'#9'F'
      'ClassName'#9'17'#9'Department Name'#9'F'
      'Description'#9'23'#9'Description'#9'F'
      'DatePaid'#9'10'#9'Date Paid'#9'F'
      
        'Amount'#9'13'#9'Amount'#9'F]]></GridFields><TitleFont><Name>Arial</Name><' +
        'Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Ti' +
        'tleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640' +
        '</Color><Style></Style></Font><ShowGridLines>True</ShowGridLines' +
        '><AlternatingRowColor>536870911</AlternatingRowColor><CustomColu' +
        'mns></CustomColumns></grdMain></TfrmPayAllowancesReport>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmPayDeductionsReportList", NULL, "<?xml ' +
        'version=""1.0"" encoding=""UTF-8"" ?><TfmPayDeductionsReportList' +
        '><grdMain><GridFields><![CDATA[EmpName'#9'20'#9'Emp Name'#9'F'
      'Amount'#9'10'#9'Amount'#9'F'
      'ClassName'#9'20'#9'Department Name'#9'F'
      'Description'#9'26'#9'Description'#9'F'
      'DatePaid'#9'10'#9'Date Paid'#9'F'
      
        'TaxExempt'#9'9'#9'Tax Exempt'#9'F]]></GridFields><TitleFont><Name>Arial</' +
        'Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Styl' +
        'e></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147' +
        '483640</Color><Style></Style></Font><ShowGridLines>True</ShowGri' +
        'dLines><AlternatingRowColor>536870911</AlternatingRowColor><Cust' +
        'omColumns></CustomColumns></grdMain></TfmPayDeductionsReportList' +
        '>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmETPReport", NULL, "<?xml version=""1.0' +
        '"" encoding=""UTF-8"" ?><TfrmETPReport><grdMain><GridFields><![C' +
        'DATA[EmployeeName'#9'25'#9'Employee Name'#9'F'
      'GrossTermination'#9'20'#9'Gross Termination'#9'F'
      'StartDate'#9'18'#9'Start Date'#9'F'
      
        'EndDate'#9'18'#9'End Date'#9'F]]></GridFields><TitleFont><Name>Arial</Nam' +
        'e><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style><' +
        '/TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483' +
        '640</Color><Style></Style></Font><ShowGridLines>True</ShowGridLi' +
        'nes><AlternatingRowColor>536870911</AlternatingRowColor><CustomC' +
        'olumns></CustomColumns></grdMain></TfrmETPReport>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TLeaveAccrualsReportGUI", NULL, "<?xml ver' +
        'sion=""1.0"" encoding=""UTF-8"" ?><TLeaveAccrualsReportGUI><grdM' +
        'ain><GridFields><![CDATA[Type'#9'20'#9'Type'#9'F'
      'EmployeeName'#9'20'#9'Employee Name'#9'F'
      'OpenningBalanceHrs'#9'18'#9'Openning Balance Hrs'#9'F'
      'DateAccrued'#9'11'#9'Date Accrued'#9'F'
      'AccruedHours'#9'12'#9'Accrued Hours'#9'F'
      'Rate'#9'10'#9'Rate'#9'F'
      'LeaveLoading'#9'11'#9'Leave Loading'#9'F'
      'AmountAccrued'#9'13'#9'Amount Accrued'#9'F'
      
        'ClassName'#9'14'#9'Department Name'#9'F]]></GridFields><TitleFont><Name>A' +
        'rial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold' +
        '</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color' +
        '>-2147483640</Color><Style></Style></Font><ShowGridLines>True</S' +
        'howGridLines><AlternatingRowColor>536870911</AlternatingRowColor' +
        '><CustomColumns></CustomColumns></grdMain></TLeaveAccrualsReport' +
        'GUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TLeaveAccruedDetailsListGUI", NULL, "<?xml' +
        ' version=""1.0"" encoding=""UTF-8"" ?><TLeaveAccruedDetailsListG' +
        'UI><grdMain><GridFields><![CDATA[AccruedDate'#9'11'#9'Accrued Date'#9'F'
      'LeaveType'#9'15'#9'Leave Type'#9'F'
      'Employee'#9'15'#9'Employee'#9'F'
      'PayNo'#9'8'#9'Pay No'#9'F'
      'AccruedType'#9'14'#9'Accrued Type'#9'F'
      'Hours'#9'12'#9'Hours'#9'F'
      
        'Value'#9'12'#9'Value'#9'F]]></GridFields><TitleFont><Name>Arial</Name><Si' +
        'ze>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Titl' +
        'eFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</' +
        'Color><Style></Style></Font><ShowGridLines>True</ShowGridLines><' +
        'AlternatingRowColor>536870911</AlternatingRowColor><CustomColumn' +
        's></CustomColumns></grdMain></TLeaveAccruedDetailsListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TLeaveListGUI", NULL, "<?xml version=""1.0' +
        '"" encoding=""UTF-8"" ?><TLeaveListGUI><grdMain><GridFields><![C' +
        'DATA[EmployeeName'#9'40'#9'Employee Name'#9'F'
      'PayDate'#9'13'#9'Pay Date'#9'F'
      'DateTaken'#9'13'#9'Date Taken'#9'F'
      'LeaveType'#9'40'#9'Leave Type'#9'F'
      'Hours'#9'10'#9'Hours'#9'F'
      
        'IsCertified'#9'8'#9'Is Certified'#9'F]]></GridFields><TitleFont><Name>Ari' +
        'al</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</' +
        'Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-' +
        '2147483640</Color><Style></Style></Font><ShowGridLines>True</Sho' +
        'wGridLines><AlternatingRowColor>536870911</AlternatingRowColor><' +
        'CustomColumns></CustomColumns></grdMain></TLeaveListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmPayrollReconciliationReportListGUI", N' +
        'ULL, "<?xml version=""1.0"" encoding=""UTF-8"" ?><TfrmPayrollRec' +
        'onciliationReportListGUI><grdMain><GridFields><![CDATA[MonthName' +
        #9'27'#9'Month'#9'F'
      'MonthlyGrossTax'#9'20'#9'Gross Tax'#9'F'
      
        'MonthlyGrossWage'#9'23'#9'Gross Wages'#9'F]]></GridFields><TitleFont><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsB' +
        'old</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Co' +
        'lor>-2147483640</Color><Style></Style></Font><ShowGridLines>True' +
        '</ShowGridLines><AlternatingRowColor>536870911</AlternatingRowCo' +
        'lor><CustomColumns></CustomColumns></grdMain></TfrmPayrollReconc' +
        'iliationReportListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmSuperFundListGUI", NULL, "<?xml versio' +
        'n=""1.0"" encoding=""UTF-8"" ?><TfrmSuperFundListGUI><grdMain><G' +
        'ridFields><![CDATA[FundName'#9'18'#9'Fund Name'#9'F'
      'Account No'#9'15'#9'Account No'#9'F'
      'Date'#9'12'#9'Date'#9'F'
      'Name'#9'22'#9'Name'#9'T'
      'Description'#9'24'#9'Description'#9'F'
      
        'Amount'#9'12'#9'Amount'#9'F]]></GridFields><TitleFont><Name>Arial</Name><' +
        'Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Ti' +
        'tleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640' +
        '</Color><Style></Style></Font><ShowGridLines>True</ShowGridLines' +
        '><AlternatingRowColor>536870911</AlternatingRowColor><CustomColu' +
        'mns></CustomColumns></grdMain></TfrmSuperFundListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TWagesJournalReportGUI", NULL, "<?xml vers' +
        'ion=""1.0"" encoding=""UTF-8"" ?><TWagesJournalReportGUI><grdMai' +
        'n><GridFields><![CDATA[GlobalRef'#9'15'#9'GlobalRef'#9'F'#9
      'Date'#9'10'#9'Date'#9#9
      'EmpName'#9'20'#9'Employee'#9'F'#9
      'Description'#9'25'#9'Description'#9#9
      'Type'#9'22'#9'Type'#9#9
      'Debit'#9'15'#9'Debit'#9'F'#9
      'Credit'#9'15'#9'Credit'#9#9
      'ClassName'#9'20'#9'Department'#9#9
      'AccountDescription'#9'50'#9'AccountDescription'#9'F'#9
      'PayID'#9'15'#9'PayNo'#9'F'
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor></grdMain></TWagesJournalRepo' +
        'rtGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBillDetailsListGUI", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TBillDetailsListGUI><grdMain><Gri' +
        'dFields><![CDATA[Company'#9'19'#9'Company'#9'F'
      'OrderDate'#9'12'#9'Bill Date'#9'F'
      'BillNumber'#9'11'#9'Bill Number'#9'F'
      'AccountName'#9'21'#9'Account Name'#9'F'
      'Amount (Ex)'#9'12'#9'Amount (Ex)'#9'F'
      'Tax'#9'11'#9'Tax'#9'F'
      'Amount (Inc)'#9'12'#9'Amount (Inc)'#9'F'
      'Comments'#9'26'#9'Comments'#9'F'
      'Type'#9'12'#9'Type'#9'F'
      'Memo'#9'10'#9'Memo'#9'F'
      'Contact'#9'16'#9'Contact'#9'F'
      'Phone'#9'15'#9'Phone'#9'F'
      'CustomerJob'#9'18'#9'Customer Job'#9'F'
      'Department'#9'11'#9'Department'#9'F'
      
        'Deleted'#9'6'#9'Deleted'#9'F]]></GridFields><TitleFont><Name>Arial</Name>' +
        '<Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></T' +
        'itleFont><Font><Name>Arial</Name><Size>9</Size><Color>-214748364' +
        '0</Color><Style></Style></Font><ShowGridLines>True</ShowGridLine' +
        's><AlternatingRowColor>536870911</AlternatingRowColor><CustomCol' +
        'umns></CustomColumns></grdMain></TBillDetailsListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmForeignPurchaseList", NULL, "<?xml vers' +
        'ion=""1.0"" encoding=""UTF-8"" ?><TfmForeignPurchaseList><grdMai' +
        'n><GridFields><![CDATA[OrderDate'#9'10'#9'Order Date'#9#9
      'PurchaseOrderNumber'#9'10'#9'Order Number'#9#9
      'SupplierName'#9'20'#9'Supplier Name'#9#9
      'ProductName'#9'20'#9'Product Name'#9#9
      'QtyOrdered'#9'10'#9'Qty Ordered'#9#9
      'QtyShipped'#9'10'#9'Qty Shipped'#9#9
      'LineCost'#9'10'#9'Line Cost'#9#9
      'LineCostInc'#9'10'#9'LineCost Inc'#9#9
      'LineCostForeign'#9'10'#9'Line Cost Foreign'#9#9
      'LineTotal'#9'10'#9'Line Total'#9#9
      'LineTotalInc'#9'10'#9'Line Total Inc'#9#9
      'CurrentLineTotal'#9'10'#9'Current Line Total'#9#9
      'ForeignExchangeCode'#9'3'#9'Code'#9'F'
      'ForeignExchangeRate'#9'10'#9'Exchange Rate'#9#9
      'CurrentExchangeRate'#9'10'#9'Current Rate'#9#9
      'LineTotalForeign'#9'10'#9'Line Total Foreign'#9#9
      'LineTotalCurrencyVariation'#9'10'#9'Line Currency Variation'#9#9
      'TotalAmount'#9'10'#9'Total Amount'#9#9
      'TotalTax'#9'10'#9'Total Tax'#9#9
      'TotalAmountInc'#9'10'#9'Total Amount Inc'#9#9
      'TotalCurrencyVariation'#9'10'#9'Total Variation'#9#9
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor><CustomColumns></CustomColumn' +
        's></grdMain></TfmForeignPurchaseList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TSupplierReportGUI", NULL, "<?xml version=' +
        '""1.0"" encoding=""UTF-8"" ?><TSupplierReportGUI><grdMain><GridF' +
        'ields><![CDATA[Name'#9'19'#9'Name'#9'F'
      'Type'#9'17'#9'Type'#9'F'
      'OrderDate'#9'11'#9'Order Date'#9'F'
      'InvoiceDate'#9'10'#9'Invoice Date'#9'F'
      'DueDate'#9'12'#9'Due Date'#9'F'
      'Total Amount (Ex)'#9'14'#9'Total Amount (Ex)'#9'F'
      'Comments'#9'25'#9'Comments'#9'F'
      
        'WareHouse Notes'#9'24'#9'Ware House Notes'#9'F]]></GridFields><TitleFont>' +
        '<Name>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style' +
        '>fsBold</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size' +
        '><Color>-2147483640</Color><Style></Style></Font><ShowGridLines>' +
        'True</ShowGridLines><AlternatingRowColor>536870911</AlternatingR' +
        'owColor><CustomColumns></CustomColumns></grdMain></TSupplierRepo' +
        'rtGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TSupplierStatementGUI", NULL, "<?xml versi' +
        'on=""1.0"" encoding=""UTF-8"" ?><TSupplierStatementGUI><grdMain>' +
        '<GridFields><![CDATA[SupplierName'#9'17'#9'SupplierName'#9'F'
      'Type'#9'16'#9'Type'#9'F'
      'Date'#9'10'#9'Date'#9'F'
      'Transaction No'#9'14'#9'Transaction No'#9'F'
      'Total Amount (Ex)'#9'14'#9'Total Amount (Ex)'#9'F'
      'Total Amount (Inc)'#9'14'#9'Total Amount (Inc)'#9'F'
      'Comments'#9'36'#9'Comments'#9'F'
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor><CustomColumns></CustomColumn' +
        's></grdMain></TSupplierStatementGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmUnInvoicedPurchItemList", NULL, "<?xml ' +
        'version=""1.0"" encoding=""UTF-8"" ?><TfmUnInvoicedPurchItemList' +
        '><grdMain><GridFields><![CDATA[SupplierName'#9'20'#9'SupplierName'#9'F'
      'ProductDescription'#9'19'#9'ProductDescription'#9'F'
      'QtyOrdered'#9'10'#9'QtyOrdered'#9'F'
      'QtyReceived'#9'10'#9'QtyReceived'#9'F'
      'OrderDate'#9'10'#9'OrderDate'#9'F'
      'PurchaseOrderNumber'#9'19'#9'PurchaseOrderNumber'#9'F'
      'OrderedValue'#9'11'#9'OrderedValue'#9'F'
      'QtyInvoiced'#9'10'#9'QtyInvoiced'#9'F'
      
        'OrderedFor'#9'18'#9'OrderedFor'#9'F]]></GridFields><TitleFont><Name>Arial' +
        '</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</St' +
        'yle></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21' +
        '47483640</Color><Style></Style></Font><ShowGridLines>True</ShowG' +
        'ridLines><AlternatingRowColor>536870911</AlternatingRowColor><Cu' +
        'stomColumns></CustomColumns></grdMain></TfmUnInvoicedPurchItemLi' +
        'st>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmUnInvoicedPurchasesList", NULL, "<?xml ' +
        'version=""1.0"" encoding=""UTF-8"" ?><TfmUnInvoicedPurchasesList' +
        '><grdMain><GridFields><![CDATA[OrderDate'#9'10'#9'PO Date'#9#9
      'PurchaseOrderNumber'#9'10'#9'PO Number'#9#9
      'SupplierName'#9'30'#9'Supplier Name'#9#9
      'ProductName'#9'30'#9'Product Name'#9#9
      'QtySold'#9'10'#9'Qty Ordered'#9#9
      'Shipped'#9'10'#9'Shipped'#9#9
      'OrderedValue'#9'13'#9'Line Value'#9#9
      'Company'#9'30'#9'Ordered For'#9#9
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor></grdMain></TfmUnInvoicedPurc' +
        'hasesList>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TCustomerBalanceDetailGUI", NULL, "<?xml v' +
        'ersion=""1.0"" encoding=""UTF-8"" ?><TCustomerBalanceDetailGUI><' +
        'grdMain><GridFields><![CDATA[CustomerName'#9'50'#9'CustomerName'#9#9
      'Type'#9'50'#9'Type'#9#9
      'Date'#9'10'#9'Date'#9#9
      'Transaction Number'#9'30'#9'Transaction Number'#9#9
      'Debits'#9'10'#9'Debits'#9#9
      'Credits'#9'10'#9'Credits'#9#9
      'SaleID'#9'15'#9'SaleID'#9#9
      'Details'#9'15'#9'Details'#9#9
      'PaymentID'#9'10'#9'PaymentID'#9#9
      'ClientID'#9'10'#9'ClientID'#9#9
      'PrepaymentID'#9'10'#9'PrepaymentID'#9#9
      'Name'#9'40'#9'Name'#9'F'
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor><CustomColumns></CustomColumn' +
        's></grdMain></TCustomerBalanceDetailGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TCustomerDetailsListGUI", NULL, "<?xml ver' +
        'sion=""1.0"" encoding=""UTF-8"" ?><TCustomerDetailsListGUI><grdM' +
        'ain><GridFields><![CDATA[CompanyName'#9'18'#9'Company Name'#9'F'
      'Rep'#9'13'#9'Rep'#9'F'
      'DiscountType'#9'24'#9'Discount Type'#9'T'
      'Discount'#9'10'#9'Discount'#9'F'
      'SpecialDiscount'#9'13'#9'Special Discount'#9'F'
      'OrigPrice'#9'11'#9'Orig Price'#9'F'
      'LinePrice'#9'11'#9'Line Price'#9'F'
      'ProductName'#9'17'#9'Product'#9'F'
      'Description'#9'27'#9'Description'#9'F'
      'Col1'#9'12'#9'Manufacture'#9'F'
      'Col2'#9'11'#9'Type'#9'F'
      
        'Col3'#9'10'#9'Dept'#9'F]]></GridFields><TitleFont><Name>Arial</Name><Size' +
        '>9</Size><Color>-2147483640</Color><Style>fsBold</Style></TitleF' +
        'ont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</Co' +
        'lor><Style></Style></Font><ShowGridLines>True</ShowGridLines><Al' +
        'ternatingRowColor>536870911</AlternatingRowColor><CustomColumns>' +
        '</CustomColumns></grdMain></TCustomerDetailsListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TCustomerSummaryListingGUI", NULL, "<?xml ' +
        'version=""1.0"" encoding=""UTF-8"" ?><TCustomerSummaryListingGUI' +
        '><grdMain><GridFields><![CDATA[Name'#9'15'#9'Name'#9'F'
      'Phone'#9'14'#9'Phone'#9'F'
      'REP'#9'12'#9'REP'#9'F'
      'Type'#9'13'#9'Type'#9'F'
      'Invoice Number'#9'12'#9'Invoice Number'#9'F'
      'SaleDate'#9'10'#9'SaleDate'#9'F'
      'DueDate'#9'10'#9'DueDate'#9'F'
      'Total Amount (Ex)'#9'14'#9'Total Amount (Ex)'#9'F'
      'Total Amount (Inc)'#9'14'#9'Total Amount (Inc)'#9'F'
      'Gross Profit'#9'12'#9'Gross Profit'#9'F'
      'Margin'#9'10'#9'Margin'#9'F'
      'Address'#9'20'#9'Address'#9'F'
      'Address 2'#9'24'#9'Address 2'#9'F'
      'Suburb'#9'18'#9'Suburb'#9'F'
      'Postcode'#9'10'#9'Postcode'#9'F'
      'State'#9'6'#9'State'#9'F'
      
        'FaxNumber'#9'15'#9'FaxNumber'#9'F]]></GridFields><TitleFont><Name>Arial</' +
        'Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Styl' +
        'e></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147' +
        '483640</Color><Style></Style></Font><ShowGridLines>True</ShowGri' +
        'dLines><AlternatingRowColor>536870911</AlternatingRowColor><Cust' +
        'omColumns></CustomColumns></grdMain></TCustomerSummaryListingGUI' +
        '>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TClientTypeListGUI", NULL, "<?xml version=' +
        '""1.0"" encoding=""UTF-8"" ?><TClientTypeListGUI><grdMain><GridF' +
        'ields><![CDATA[TypeName'#9'14'#9'Type Name'#9'F'
      'TypeDescription'#9'26'#9'Type Description'#9'F'
      'Terms'#9'19'#9'Terms'#9'F'
      'CreditLimit'#9'10'#9'Credit Limit'#9'F'
      'GracePeriod'#9'10'#9'Grace Period'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TClientTypeListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmForeignSalesList", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TfmForeignSalesList><grdMain><Gri' +
        'dFields><![CDATA[SaleDate'#9'10'#9'Sale Date'#9#9
      'InvoiceDocNumber'#9'10'#9'Doc Number'#9#9
      'CustomerName'#9'20'#9'Customer Name'#9#9
      'ProductName'#9'20'#9'Product Name'#9#9
      'QtySold'#9'10'#9'Qty Sold'#9#9
      'QtyShipped'#9'10'#9'Shipped'#9#9
      'LinePrice'#9'10'#9'Line Price'#9#9
      'LinePriceInc'#9'10'#9'Line Price Inc'#9#9
      'LinePriceForeign'#9'10'#9'Line Price Foreign'#9#9
      'LineTotal'#9'10'#9'Line Total'#9#9
      'LineTotalInc'#9'10'#9'Line Total Inc'#9#9
      'CurrentLineTotal'#9'10'#9'Current Line Total'#9#9
      'ForeignExchangeCode'#9'3'#9'Currency'#9#9
      'ForeignExchangeRate'#9'10'#9'Foreign Rate'#9#9
      'CurrentExchangeRate'#9'10'#9'Current Rate'#9#9
      'LineTotalForeign'#9'10'#9'Line Total Foreign'#9#9
      'LineTotalForeignHedged'#9'10'#9'Line Total Foreign Hedged'#9#9
      'LineTotalCurrencyVariation'#9'10'#9'Line Total Variation'#9#9
      'TotalAmount'#9'10'#9'Total Amount'#9#9
      'TotalTax'#9'10'#9'Total Tax'#9#9
      'TotalAmountInc'#9'10'#9'Total Amount Inc'#9'F'#9
      'TotalCurrencyVariation'#9'10'#9'Total Currency Variation'#9#9
      'DetailType'#9'15'#9'DetailType'#9'F'
      'QtyBackOrder'#9'10'#9'Back Order'#9'F'
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor></grdMain></TfmForeignSalesLi' +
        'st>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TQuoteDetailsReport", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TQuoteDetailsReport><grdMain><Gri' +
        'dFields><![CDATA[CustomerName'#9'18'#9'Customer Name'#9'F'
      'EmployeeName'#9'16'#9'Employee Name'#9'F'
      'InvoiceDocNumber'#9'19'#9'Invoice Doc Number'#9'F'
      'Converted'#9'8'#9'Converted'#9'F'
      'LinePrice'#9'10'#9'Line Price'#9'F'
      'PartName'#9'16'#9'Product'#9'F'
      'Description'#9'25'#9'Description'#9'F'
      'FirstColumn'#9'14'#9'Manufacture'#9'F'
      'SecondColumn'#9'40'#9'Type'#9'F'
      
        'ThirdColumn'#9'10'#9'Dept'#9'F]]></GridFields><TitleFont><Name>Arial</Nam' +
        'e><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style><' +
        '/TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483' +
        '640</Color><Style></Style></Font><ShowGridLines>True</ShowGridLi' +
        'nes><AlternatingRowColor>536870911</AlternatingRowColor><CustomC' +
        'olumns></CustomColumns></grdMain></TQuoteDetailsReport>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TSalesListReportGUI", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TSalesListReportGUI><grdMain><Gri' +
        'dFields><![CDATA[Customer Name'#9'21'#9'Customer Name'#9'F'
      'Employee Name'#9'13'#9'Employee Name'#9'F'
      'Shipped'#9'10'#9'Shipped'#9'F'
      'BackOrder'#9'10'#9'Back Order'#9'F'
      'Product Name'#9'18'#9'Product'#9'F'
      'Line Cost (Ex)'#9'13'#9'Line Cost (Ex)'#9'F'
      'Line Price (Ex)'#9'13'#9'Line Price (Ex)'#9'F'
      'Line Total (Ex)'#9'11'#9'Line Total (Ex)'#9'F'
      'Line Tax'#9'13'#9'Line Tax'#9'F'
      'Line Total (Inc)'#9'11'#9'Line Total (Inc)'#9'F'
      'Product Description'#9'30'#9'Product Description'#9'F'
      'Sale Date'#9'10'#9'Sale Date'#9'F'
      'Transaction Type'#9'14'#9'Transaction Type'#9'F'
      'Class Name'#9'15'#9'Department Name'#9'F'
      'Source'#9'12'#9'Source'#9'F'
      'Department'#9'11'#9'Dept'#9'F'
      'Type'#9'11'#9'Type'#9'F'
      'Manufacturer'#9'12'#9'Manufacture'#9'F'
      
        'CustomerType'#9'13'#9'Customer Type'#9'F]]></GridFields><TitleFont><Name>' +
        'Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBol' +
        'd</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style></Style></Font><ShowGridLines>True</' +
        'ShowGridLines><AlternatingRowColor>536870911</AlternatingRowColo' +
        'r><CustomColumns></CustomColumns></grdMain></TSalesListReportGUI' +
        '>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TSalesOrderStatusReportGUI", NULL, "<?xml ' +
        'version=""1.0"" encoding=""UTF-8"" ?><TSalesOrderStatusReportGUI' +
        '><grdMain><GridFields><![CDATA[Customer Name'#9'17'#9'Customer Name'#9'F'
      'Employee Name'#9'16'#9'Employee Name'#9'T'
      'Product Name'#9'18'#9'Product'#9'F'
      'Shipped'#9'10'#9'Shipped'#9'F'
      'Backorder'#9'10'#9'Backorder'#9'F'
      'Line Total (Ex)'#9'13'#9'Line Total (Ex)'#9'F'
      'Line Tax'#9'11'#9'Line Tax'#9'F'
      'Line Total (Inc)'#9'13'#9'Line Total (Inc)'#9'F'
      'Product Description'#9'25'#9'Product Description'#9'F'
      'Line Cost (Ex)'#9'11'#9'Line Cost (Ex)'#9'F'
      'Line Price (Ex)'#9'11'#9'Line Price (Ex)'#9'F'
      'Sale Date'#9'11'#9'Sale Date'#9'F'
      'Sales Order Number'#9'16'#9'Sales Order Number'#9'F'
      'Class Name'#9'14'#9'Department Name'#9'F'
      'Manufacturer'#9'13'#9'Manufacture'#9'T'
      'Type'#9'12'#9'Type'#9'T'
      
        'Department'#9'12'#9'Dept'#9'T]]></GridFields><TitleFont><Name>Arial</Name' +
        '><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></' +
        'TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474836' +
        '40</Color><Style></Style></Font><ShowGridLines>True</ShowGridLin' +
        'es><AlternatingRowColor>536870911</AlternatingRowColor><CustomCo' +
        'lumns></CustomColumns></grdMain></TSalesOrderStatusReportGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TCustSalesOrdersReportGUI", NULL, "<?xml v' +
        'ersion=""1.0"" encoding=""UTF-8"" ?><TCustSalesOrdersReportGUI><' +
        'grdMain><GridFields><![CDATA[Name'#9'17'#9'Name'#9'F'
      'REP'#9'13'#9'REP'#9'F'
      'Type'#9'13'#9'Type'#9'F'
      'SaleDate'#9'13'#9'SaleDate'#9'F'
      'DueDate'#9'12'#9'DueDate'#9'F'
      'Invoice Number'#9'14'#9'Invoice Number'#9'F'
      'Total Cost (Ex)'#9'14'#9'Total Cost (Ex)'#9'T'
      'Total Amount (Ex)'#9'14'#9'Total Amount (Ex)'#9'F'
      'GrossProfit'#9'12'#9'GrossProfit'#9'F'
      'PercentProfit'#9'11'#9'% Profit'#9'F'
      'Address'#9'15'#9'Address'#9'F'
      'Address 2'#9'19'#9'Address 2'#9'F'
      'Suburb'#9'16'#9'Suburb'#9'F'
      'Postcode'#9'10'#9'Postcode'#9'F'
      'State'#9'4'#9'State'#9'F'
      'Phone'#9'13'#9'Phone'#9'F'
      
        'FaxNumber'#9'14'#9'FaxNumber'#9'F]]></GridFields><TitleFont><Name>Arial</' +
        'Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Styl' +
        'e></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147' +
        '483640</Color><Style></Style></Font><ShowGridLines>True</ShowGri' +
        'dLines><AlternatingRowColor>536870911</AlternatingRowColor><Cust' +
        'omColumns></CustomColumns></grdMain></TCustSalesOrdersReportGUI>' +
        '");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TSoldProductsReport", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TSoldProductsReport><grdMain><Gri' +
        'dFields><![CDATA[Department'#9'20'#9'Department'#9#9
      'QuantitySold'#9'10'#9'QuantitySold'#9#9
      'ProductName'#9'23'#9'ProductName'#9#9
      'Description'#9'20'#9'Description'#9#9
      'FirstColumn'#9'20'#9'FirstColumn'#9#9
      'SecondColumn'#9'20'#9'SecondColumn'#9#9
      'ThirdColumn'#9'20'#9'ThirdColumn'#9#9
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor></grdMain></TSoldProductsRepo' +
        'rt>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TEmailedReportsList", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TEmailedReportsList><grdMain><Gri' +
        'dFields><![CDATA[Date'#9'10'#9'Date'#9'F'
      'User'#9'12'#9'User'#9'F'
      'Report Type'#9'16'#9'Report Type'#9'F'
      'Transaction Description'#9'71'#9'Transaction Description'#9'F'
      
        'Transaction'#9'10'#9'Transaction'#9'F]]></GridFields><TitleFont><Name>Ari' +
        'al</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</' +
        'Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-' +
        '2147483640</Color><Style></Style></Font><ShowGridLines>True</Sho' +
        'wGridLines><AlternatingRowColor>536870911</AlternatingRowColor><' +
        'CustomColumns></CustomColumns></grdMain></TEmailedReportsList>")' +
        ';'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TLaybyListGUI", NULL, "<?xml version=""1.0' +
        '"" encoding=""UTF-8"" ?><TLaybyListGUI><grdMain><GridFields><![C' +
        'DATA[Company'#9'22'#9'Company'#9'F'
      'InvoiceDocNumber'#9'17'#9'Invoice Doc Number'#9'F'
      'SaleDate'#9'10'#9'Sale Date'#9'F'
      'EmpName'#9'18'#9'Emp Name'#9'F'
      'TotalAmountInc'#9'13'#9'Total Amount Inc'#9'F'
      
        'Balance'#9'14'#9'Balance'#9'F]]></GridFields><TitleFont><Name>Arial</Name' +
        '><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style></' +
        'TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21474836' +
        '40</Color><Style></Style></Font><ShowGridLines>True</ShowGridLin' +
        'es><AlternatingRowColor>536870911</AlternatingRowColor><CustomCo' +
        'lumns></CustomColumns></grdMain></TLaybyListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfmMarketing", NULL, "<?xml version=""1.0"' +
        '" encoding=""UTF-8"" ?><TfmMarketing><grdFollowups><GridFields><' +
        '![CDATA[ActiontypeName'#9'30'#9'Action Type'#9'F'
      'ActionDate'#9'18'#9'Action Date'#9'F'
      'EmployeeName'#9'30'#9'Employee'#9'F'
      'Done'#9'4'#9'Done'#9'F'
      
        'Notes'#9'39'#9'Notes'#9'F]]></GridFields><TitleFont><Name>Arial</Name><Si' +
        'ze>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Titl' +
        'eFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640</' +
        'Color><Style></Style></Font><ShowGridLines>True</ShowGridLines><' +
        'AlternatingRowColor>536870911</AlternatingRowColor><CustomColumn' +
        's></CustomColumns></grdFollowups><grdContacts><GridFields><![CDA' +
        'TA[CompanyTypeName'#9'20'#9'Company Type'#9'F'
      'Title'#9'7'#9'Title'#9'F'
      'COMPANY'#9'20'#9'COMPANY'#9'F'
      'Phone'#9'15'#9'Phone'#9'F'
      'FirstName'#9'13'#9'FirstName'#9'F'
      'LastName'#9'13'#9'LastName'#9'F'
      'EmployeeSize'#9'20'#9'EmployeeSize'#9'F'
      'Duration'#9'18'#9'Duration'#9'F'
      
        'DoNotQualify'#9'10'#9'DoNotQualify'#9'F]]></GridFields><TitleFont><Name>A' +
        'rial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold' +
        '</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color' +
        '>-2147483640</Color><Style></Style></Font><ShowGridLines>True</S' +
        'howGridLines><AlternatingRowColor>536870911</AlternatingRowColor' +
        '><CustomColumns></CustomColumns></grdContacts></TfmMarketing>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TfrmPaySummary", NULL, "<?xml version=""1.' +
        '0"" encoding=""UTF-8"" ?><TfrmPaySummary><grdMain><GridFields><!' +
        '[CDATA[FirstName'#9'11'#9'First Name'#9'F'
      'LastName'#9'12'#9'Last Name'#9'F'
      'PayDate'#9'10'#9'Pay Date'#9'T'
      'Pay'#9'6'#9'Pay'#9'F'
      'Class'#9'10'#9'Department'#9'T'
      'DatePaid'#9'10'#9'Date Paid'#9'F'
      'PayPeriod'#9'11'#9'Pay Period'#9'T'
      'Wages'#9'11'#9'Wages'#9'T'
      'Commission'#9'11'#9'Commission'#9'T'
      'Deductions'#9'10'#9'Deductions'#9'T'
      'Allowances'#9'10'#9'Allowances'#9'T'
      'Sundries'#9'10'#9'Sundries'#9'T'
      'Superannuation'#9'12'#9'Superannuation'#9'T'
      'CDEPGross'#9'10'#9'CDEP'#9'T'
      'Gross'#9'10'#9'Gross'#9'T'
      'Tax'#9'10'#9'Tax'#9'T'
      'Net'#9'10'#9'Net'#9'T'
      'Paid'#9'8'#9'Paid'#9'T'
      
        'PayPeriods'#9'10'#9'Pay Periods'#9'T]]></GridFields><TitleFont><Name>Aria' +
        'l</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</S' +
        'tyle></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2' +
        '147483640</Color><Style></Style></Font><ShowGridLines>True</Show' +
        'GridLines><AlternatingRowColor>536870911</AlternatingRowColor><C' +
        'ustomColumns></CustomColumns></grdMain></TfrmPaySummary>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TReturnAGUI", NULL, "<?xml version=""1.0""' +
        ' encoding=""UTF-8"" ?><TReturnAGUI><grdTransactions><GridFields>' +
        '<![CDATA[ProductName'#9'17'#9'Name'#9'F'
      'UnitofMeasurePOLines'#9'10'#9'Units'#9'F'
      'UnitofMeasureQtySold'#9'6'#9'Ordered'#9'F'
      'PQA'#9'8'#9'Allocation'#9'F'
      'Product_Description'#9'17'#9'Fault Description'#9'F'
      'ETADate'#9'10'#9'ETA Date'#9'F'
      'LineCost'#9'10'#9'Cost (Ex)'#9'F'
      'LineTaxCode'#9'7'#9'Code'#9'F'
      'LineTax'#9'10'#9'Tax'#9'F'
      'TotalLineAmountInc'#9'10'#9'Amount (Inc)'#9'F'
      
        'Class'#9'10'#9'Department'#9'F]]></GridFields><TitleFont><Name>Arial</Nam' +
        'e><Size>9</Size><Color>-2147483640</Color><Style>fsBold</Style><' +
        '/TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483' +
        '640</Color><Style></Style></Font><ShowGridLines>True</ShowGridLi' +
        'nes><AlternatingRowColor>536870911</AlternatingRowColor><CustomC' +
        'olumns></CustomColumns></grdTransactions></TReturnAGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TCreditGUI", NULL, "<?xml version=""1.0"" ' +
        'encoding=""UTF-8"" ?><TCreditGUI><grdTransactions><GridFields><!' +
        '[CDATA[AccountName'#9'18'#9'Account Name'#9'F'
      'LineTaxCode'#9'8'#9'Code'#9'F'
      'LineTax'#9'10'#9'Tax'#9'F'
      'LineCost'#9'10'#9'Amount (Ex)'#9'F'
      'Product_Description'#9'23'#9'Memo'#9'F'
      'CustomerJob'#9'17'#9'Customer Job'#9'F'
      'Class'#9'10'#9'Departments'#9'F'
      
        'RelatedPOID'#9'10'#9'Related PO'#9'F]]></GridFields><TitleFont><Name>Aria' +
        'l</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</S' +
        'tyle></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-2' +
        '147483640</Color><Style></Style></Font><ShowGridLines>True</Show' +
        'GridLines><AlternatingRowColor>536870911</AlternatingRowColor><C' +
        'ustomColumns></CustomColumns></grdTransactions></TCreditGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TBillGUI", NULL, "<?xml version=""1.0"" en' +
        'coding=""UTF-8"" ?><TBillGUI><grdTransactions><GridFields><![CDA' +
        'TA[AccountName'#9'19'#9'Account Name'#9'F'
      'LineTaxCode'#9'8'#9'Code'#9'F'
      'LineCost'#9'10'#9'Amount (Ex)'#9'F'
      'LineTax'#9'10'#9'Tax'#9'F'
      'Product_Description'#9'28'#9'Memo'#9'F'
      
        'CustomerJob'#9'25'#9'Customer Job'#9'F]]></GridFields><TitleFont><Name>Ar' +
        'ial</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold<' +
        '/Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>' +
        '-2147483640</Color><Style></Style></Font><ShowGridLines>True</Sh' +
        'owGridLines><AlternatingRowColor>536870911</AlternatingRowColor>' +
        '<CustomColumns></CustomColumns></grdTransactions></TBillGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TShipAddressListGUI", NULL, "<?xml version' +
        '=""1.0"" encoding=""UTF-8"" ?><TShipAddressListGUI><grdMain><Gri' +
        'dFields><![CDATA[Company Name'#9'19'#9'Company Name'#9'F'
      'Address'#9'20'#9'Address'#9'F'
      'Address 2'#9'16'#9'Address 2'#9'F'
      'Address 3'#9'16'#9'Address 3'#9'F'
      'City'#9'16'#9'City'#9'F'
      'PostCode'#9'12'#9'Post Code'#9'F'
      'State'#9'9'#9'State'#9'F'
      'Country'#9'18'#9'Country'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TShipAddressListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TCommentsListGUI", NULL, "<?xml version=""' +
        '1.0"" encoding=""UTF-8"" ?><TCommentsListGUI><grdMain><GridField' +
        's><![CDATA[Comments'#9'135'#9'Comments'#9'F]]></GridFields><TitleFont><Na' +
        'me>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style>fs' +
        'Bold</Style></TitleFont><Font><Name>Arial</Name><Size>9</Size><C' +
        'olor>-2147483640</Color><Style></Style></Font><ShowGridLines>Tru' +
        'e</ShowGridLines><AlternatingRowColor>536870911</AlternatingRowC' +
        'olor><CustomColumns></CustomColumns></grdMain></TCommentsListGUI' +
        '>");'
      ''
      
        'delete from tblpreferences  where PrefName = '#39'TfrmBlindBalanceRe' +
        'port'#39';'
      
        'INSERT INTO tblpreferences  (PackageID, UserID, PrefGroup, PrefN' +
        'ame, PrefType, PrefValue, PrefDesc)   VALUES  ( 0, 0, '#39'GuiPrefs'#39 +
        ', '#39'TfrmBlindBalanceReport'#39', '#39#39', '#39'<?xml version="1.0" encoding="U' +
        'TF-8" ?><TfrmBlindBalanceReport><grdMain><GridFields><![CDATA[Ti' +
        'llName'#9'12'#9'Till Name'#9'F'
      'EmployeeName'#9'18'#9'Employee Name'#9'F'
      'Variation'#9'10'#9'Variation'#9'F'
      'InvoiceDocNumber'#9'16'#9'Invoice Doc Number'#9'F'#9'Sales Details'
      'SaleDateTime'#9'12'#9'Sale Date Time'#9'F'#9'Sales Details'
      'ProductName'#9'13'#9'Product'#9'F'#9'Sales Details'
      'QtySold'#9'11'#9'Qty Sold'#9'F'#9'Sales Details'
      'InvoicePayments'#9'14'#9'Invoice Payments'#9'F'#9'Sales Details'
      'TotalLineAmount'#9'14'#9'Amount (Ex)'#9'F'#9'Total '
      'TotalAmountinc'#9'14'#9'Amount (Inc)'#9'F'#9'Total '
      'StartDate'#9'10'#9'Start Date'#9'F'#9'Period'
      'EndDate'#9'9'#9'End Date'#9'F'#9'Period'
      'PeriodNumber'#9'12'#9'Period Number'#9'F'#9'Period'
      'PeriodTotal'#9'10'#9'Period Total'#9'F'#9'Period'
      'Hundreds'#9'11'#9'Hundreds'#9'F'#9'Cash Collected'
      'Fifties'#9'11'#9'Fifties'#9'F'#9'Cash Collected'
      'Twenties'#9'11'#9'Twenties'#9'F'#9'Cash Collected'
      'Tens'#9'11'#9'Tens'#9'F'#9'Cash Collected'
      'Fives'#9'11'#9'Fives'#9'F'#9'Cash Collected'
      'Twos'#9'11'#9'Twos'#9'F'#9'Cash Collected'
      'Ones'#9'11'#9'Ones'#9'F'#9'Cash Collected'
      'FiftyCents'#9'11'#9'Fifty Cents'#9'F'#9'Cash Collected'
      'TwentyCents'#9'11'#9'Twenty Cents'#9'F'#9'Cash Collected'
      'TenCents'#9'11'#9'Ten Cents'#9'F'#9'Cash Collected'
      'FiveCents'#9'11'#9'Five Cents'#9'F'#9'Cash Collected'
      'EFTPOS'#9'10'#9'EFTPOS'#9'F'#9'Till Collection - Amount'
      'Visa'#9'10'#9'Visa'#9'F'#9'Till Collection - Amount'
      'MasterCard'#9'10'#9'Master Card'#9'F'#9'Till Collection - Amount'
      'DinersClub'#9'10'#9'Diners Club'#9'F'#9'Till Collection - Amount'
      'Bankcard'#9'10'#9'Bankcard'#9'F'#9'Till Collection - Amount'
      'Amex'#9'10'#9'Amex'#9'F'#9'Till Collection - Amount'
      'CreditCard'#9'10'#9'Credit Card'#9'F'#9'Till Collection - Amount'
      'Cheques'#9'10'#9'Cheques'#9'F'#9'Till Collection - Amount'
      
        'TotalCash'#9'10'#9'Total Cash'#9'F'#9'Till Collection - Amount]]></GridField' +
        's><TitleFont><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style>fsBold</Style></TitleFont><Font><Name>Arial</Name>' +
        '<Size>9</Size><Color>-2147483640</Color><Style></Style></Font><S' +
        'howGridLines>True</ShowGridLines><AlternatingRowColor>536870911<' +
        '/AlternatingRowColor><TitleLines>2</TitleLines><CustomColumns></' +
        'CustomColumns></grdMain></TfrmBlindBalanceReport>'#39', '#39#39');'
      
        'delete from tblpreferences  where PrefName = '#39'TStockQtysLocation' +
        'sReportGUI'#39';'
      
        'INSERT INTO tblpreferences  (PackageID, UserID, PrefGroup, PrefN' +
        'ame, PrefType, PrefValue, PrefDesc)   VALUES  ( 0, 0, '#39'GuiPrefs'#39 +
        ', '#39'TStockQtysLocationsReportGUI'#39', '#39#39', '#39'<?xml version="1.0" encod' +
        'ing="UTF-8" ?><TStockQtysLocationsReportGUI><grdMain><GridFields' +
        '><![CDATA[ProductName'#9'20'#9'Product'#9'F'
      'PartsDescription'#9'19'#9'Parts Description'#9'F'
      'Classname'#9'10'#9'Department'#9'F'
      'UOM'#9'8'#9'UOM'#9'F'
      'ProductColumn1'#9'13'#9'Manufacture'#9'F'#9'Product Group'
      'ProductColumn2'#9'14'#9'Type'#9'F'#9'Product Group'
      'ProductColumn3'#9'13'#9'Dept'#9'F'#9'Product Group'
      'Batchnumber'#9'10'#9'No'#9'F'#9'Batch'
      'ExpiryDate'#9'10'#9'Expiry Date'#9'F'#9'Batch'
      'Binlocation'#9'10'#9'Location'#9'F'#9'Bin'
      'Binnumber'#9'12'#9'No'#9'F'#9'Bin'
      'Serialnumber'#9'11'#9'Serial~No'#9'F'
      'Cost'#9'10'#9'Cost'#9'F'
      'Value'#9'10'#9'Value'#9'F'
      'SOUOMQty'#9'10'#9'Sales Order'#9'F'#9'UOM Quantity'
      'InstockUOMQty'#9'10'#9'In-Stock'#9'F'#9'UOM Quantity'
      
        'UOMQty'#9'12'#9'If read as UOM'#9'F'#9'Unit of Measure Quantities as Bought ' +
        'and Sold'
      
        'UOMMultiplierDesc1'#9'10'#9'Multiplier'#9'F'#9'Unit of Measure Quantities as' +
        ' Bought and Sold'
      
        'Qty'#9'16'#9'If read as Units'#9'F'#9'Unit of Measure Quantities as Bought a' +
        'nd Sold'
      
        'AvailableQty'#9'12'#9'If read as Units'#9'F'#9'Product'#39#39's Total Available Qt' +
        'y'
      
        'UOMMultiplierDesc2'#9'10'#9'Multiplier'#9'F'#9'Product'#39#39's Total Available Qt' +
        'y'
      
        'AvailableUOMQty'#9'11'#9'If read as UOM'#9'F'#9'Product'#39#39's Total Available Q' +
        'ty'
      
        'UnAllocatedInstockUOMQty'#9'10'#9'In-Stock'#9'F'#9'Bin/Batch Un-Allocated Qu' +
        'antity'
      
        'UnAllocatedSOUOMQty'#9'10'#9'Sales Order'#9'F'#9'Bin/Batch Un-Allocated Quan' +
        'tity'
      
        'UnAllocatedUOMQty'#9'10'#9'Available'#9'F'#9'Bin/Batch Un-Allocated Quantity' +
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor><CustomColumns></CustomColumn' +
        's></grdMain></TStockQtysLocationsReportGUI>'#39', '#39#39');'
      ''
      'delete from tblpreferences where PrefName = "TGlobalListFrm";'
      'INSERT INTO tblpreferences'
      '  (PackageID, UserID, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TGlobalListFrm", NULL, "<?xml version=""1.' +
        '0"" encoding=""UTF-8"" ?><TGlobalListFrm><grdMain><GridFields><!' +
        '[CDATA[Name'#9'20'#9'Name'#9'F'
      'ContactName'#9'15'#9'ContactName'#9'F'
      'Type'#9'13'#9'Type'#9'F'
      'Phone'#9'14'#9'Phone'#9'F'
      'Mobile'#9'14'#9'Mobile'#9'F'
      'Balance'#9'13'#9'Balance'#9'F'
      'Rep'#9'14'#9'Rep'#9'F'
      'Street'#9'20'#9'Street'#9'F'
      'Suburb'#9'17'#9'Suburb'#9'F'
      'State'#9'11'#9'State'#9'F'
      'Postcode'#9'7'#9'Postcode'#9'F'
      'Country'#9'7'#9'Country'#9'F'
      'Email'#9'20'#9'Email'#9'F'
      'FaxNumber'#9'14'#9'FaxNumber'#9'F'
      
        'Active'#9'5'#9'Active'#9'F]]></GridFields><TitleFont><Name>Arial</Name><S' +
        'ize>9</Size><Color>-2147483640</Color><Style>fsBold</Style></Tit' +
        'leFont><Font><Name>Arial</Name><Size>9</Size><Color>-2147483640<' +
        '/Color><Style></Style></Font><ShowGridLines>True</ShowGridLines>' +
        '<AlternatingRowColor>536870911</AlternatingRowColor><CustomColum' +
        'ns></CustomColumns></grdMain></TGlobalListFrm>");')
  end
end
