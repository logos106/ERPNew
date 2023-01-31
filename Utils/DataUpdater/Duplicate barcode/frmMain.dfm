inherited fmMain: TfmMain
  Left = 368
  Top = 205
  Caption = 'ERP Data Update'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Script: TMyScript
    SQL.Strings = (
      
        'insert ignore  into  tblpartbarcodes(PartsId , barCode, IsPrimar' +
        'ybarcode , active) '
      'SELECT '
      '`tblparts`.`PARTSID`,`tblparts`.`BARCODE` , '#39'T'#39' , '#39'T'#39
      'FROM'
      '`tblparts`'
      
        'Left Join `tblpartbarcodes` ON `tblparts`.`PARTSID` = `tblpartba' +
        'rcodes`.`PartsID` AND `tblparts`.`barcode` = `tblpartbarcodes`.`' +
        'BarCode`'
      
        'where ifnull(tblPartBarcodes.PartsId  , 0) = 0 and  ifnull(`tblp' +
        'arts`.`BARCODE`  , '#39#39') <> '#39#39)
  end
end
