inherited fmMain: TfmMain
  Left = 368
  Top = 205
  Caption = 'ERP Data Update'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Script: TMyScript
    SQL.Strings = (
      
        'delete from  tblPreferences where (PrefName = "TTransPaymentList' +
        'GUI" or PrefName = "TStockAdjustEntryDetailListGUI");'
      'INSERT INTO tblPreferences'
      '  (PackageId, UserId, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TStockAdjustEntryDetailListGUI", NULL, "<?' +
        'xml version=""1.0"" encoding=""UTF-8"" ?><TStockAdjustEntryDetai' +
        'lListGUI><grdMain><GridFields><![CDATA[ProductName'#9'16'#9'Product Na' +
        'me'#9'F'
      'Description'#9'28'#9'Description'#9'F'
      'AvailableUOMQty'#9'9'#9'Available '#9'F'#9'Quantity'
      'FinalUOMQty'#9'8'#9'Final'#9'F'#9'Quantity'
      'AdjustUOMQty'#9'9'#9'Adjusted'#9'F'#9'Quantity'
      'UOM'#9'9'#9'UOM'#9'F'
      'UOMCost'#9'10'#9'Unit Cost'#9'F'
      'TotalCost'#9'11'#9'Total Cost'#9'F'
      'AccountName'#9'17'#9'Account Name'#9'F'
      'ClassName'#9'11'#9'ClassName'#9'F'
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor><CustomColumns></CustomColumn' +
        's></grdMain></TStockAdjustEntryDetailListGUI>");'
      ''
      'INSERT INTO tblPreferences '
      '  (PackageId, UserId, PrefGroup, PrefName, PrefType, PrefValue)'
      'VALUES'
      
        '  (0, 0, "GuiPrefs", "TTransPaymentListGUI", NULL, "<?xml versio' +
        'n=""1.0"" encoding=""UTF-8"" ?><TTransPaymentListGUI><grdMain><G' +
        'ridFields><![CDATA[Payment Date'#9'18'#9'Payment Date'#9'F'
      'Payment Amount'#9'13'#9'Payment Amount'#9'F'
      'Reference No'#9'11'#9'Reference No'#9'F'
      
        'Receipt No'#9'11'#9'Receipt No'#9'F]]></GridFields><TitleFont><Name>Arial' +
        '</Name><Size>9</Size><Color>-2147483640</Color><Style>fsBold</St' +
        'yle></TitleFont><Font><Name>Arial</Name><Size>9</Size><Color>-21' +
        '47483640</Color><Style></Style></Font><ShowGridLines>True</ShowG' +
        'ridLines><AlternatingRowColor>536870911</AlternatingRowColor><Cu' +
        'stomColumns></CustomColumns></grdMain></TTransPaymentListGUI>");'
      ''
      
        'delete from tblpreferences  where PrefName = '#39'TBinLocationListGU' +
        'I'#39';'
      
        'INSERT INTO tblpreferences  (PackageID, UserID, PrefGroup, PrefN' +
        'ame, PrefType, PrefValue, PrefDesc)   VALUES  ( 0, 0, '#39'GuiPrefs'#39 +
        ', '#39'TBinLocationListGUI'#39', '#39#39', '#39'<?xml version="1.0" encoding="UTF-' +
        '8" ?><TBinLocationListGUI><grdMain><GridFields><![CDATA[ClassNam' +
        'e'#9'30'#9'Department'#9'F'
      'BinLocation'#9'30'#9'Location'#9'F'#9'Bin'
      'BinNumber'#9'20'#9'No#'#9'F'#9'Bin'
      'volume'#9'15'#9'Total'#9'F'#9'Volume'
      'BinVolume'#9'15'#9'Used'#9'F'#9'Volume'
      'VolumeAvailable'#9'15'#9'Available'#9'F'#9'Volume'
      'Active'#9'8'#9'Active'#9'F'
      
        ']]></GridFields><TitleFont><Name>Arial</Name><Size>9</Size><Colo' +
        'r>-2147483640</Color><Style>fsBold</Style></TitleFont><Font><Nam' +
        'e>Arial</Name><Size>9</Size><Color>-2147483640</Color><Style></S' +
        'tyle></Font><ShowGridLines>True</ShowGridLines><AlternatingRowCo' +
        'lor>536870911</AlternatingRowColor><CustomColumns></CustomColumn' +
        's></grdMain></TBinLocationListGUI>'#39', '#39#39');')
  end
end
