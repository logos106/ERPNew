inherited fmMain: TfmMain
  Left = 368
  Top = 205
  Caption = 'ERP Data Update'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited Script: TMyScript
    SQL.Strings = (
      
        'delete from tblshipcontainerdetails where ifnull(`PurchaseLineID' +
        '` , 0) = 0')
  end
end
