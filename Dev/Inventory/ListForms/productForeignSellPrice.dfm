inherited productForeignSellPriceGUI: TproductForeignSellPriceGUI
  Caption = 'Product Foreign Sell Price'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FooterPanel: TDnMPanel
    inherited barStatus: TAdvOfficeStatusBar
      Panels = <
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          Text = 'Current Filter'
          TimeFormat = 'hh:mm:ss'
          Width = 80
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psText
          TimeFormat = 'hh:mm:ss'
          Width = 700
          OfficeHint.Picture.Data = {}
        end
        item
          AppearanceStyle = psLight
          DateFormat = 'mm/dd/yyyy'
          Progress.BackGround = clNone
          Progress.Indication = piPercentage
          Progress.Min = 0
          Progress.Max = 100
          Progress.Position = 0
          Progress.Level0Color = clLime
          Progress.Level0ColorTo = 14811105
          Progress.Level1Color = clYellow
          Progress.Level1ColorTo = 13303807
          Progress.Level2Color = 5483007
          Progress.Level2ColorTo = 11064319
          Progress.Level3Color = clRed
          Progress.Level3ColorTo = 13290239
          Progress.Level1Perc = 70
          Progress.Level2Perc = 90
          Progress.BorderColor = clBlack
          Progress.ShowBorder = False
          Progress.Stacked = False
          Style = psOwnerDraw
          TimeFormat = 'hh:mm:ss'
          Width = 50
          OfficeHint.Picture.Data = {}
        end>
    end
  end
  inherited HeaderPanel: TPanel
    inherited lblFrom: TLabel
      Visible = False
    end
    inherited lblTo: TLabel
      Visible = False
    end
    inherited pnlHeader: TPanel
      inherited TitleShader: TShader
        inherited TitleLabel: TLabel
          Caption = 'Product Foreign Sell Price'
        end
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      Visible = False
    end
    inherited dtTo: TwwDBDateTimePicker
      Visible = False
    end
  end
  inherited Panel1: TPanel
    inherited grdMain: TwwDBGrid
      Selected.Strings = (
        'Company'#9'15'#9'Customer'
        'PartName'#9'15'#9'Product'
        'Buy1'#9'10'#9'Quantity'
        'Price1'#9'10'#9'Price'
        'UOM'#9'20'#9'UOM'
        'Currency'#9'20'#9'Currency'
        'Country'#9'20'#9'Country')
    end
  end
  inherited qryMain: TERPQuery
    SQL.Strings = (
      'SELECT'
      '`C`.`Company`,'
      '`FP`.`ForeignPriceID`,'
      '`FP`.`PartName`,'
      '`FP`.`Buy1`,'
      '`FP`.`Price1`,'
      '`FP`.`PartsId`,'
      '`FP`.`SupplierProductCode`,'
      '`FP`.`SupplierProductName`,'
      'concat(`FP`.`UOM`,'#39'('#39', `FP`.`UOMMultiplier`,'#39')'#39') as UOM,'
      '`CC`.`Currency`,'
      '`CC`.`Country`'
      'FROM `tblforeignprice` AS `FP`'
      
        'Inner Join `tblclients` AS `C` ON `FP`.`ClientID` = `C`.`ClientI' +
        'D`'
      
        'Inner Join `tblcurrencyconversion` AS `CC` ON `FP`.`CurrencyId` ' +
        '= `CC`.`CurrencyID`'
      'WHERE `FP`.`IsSellPrice` =  '#39'T'#39)
    object qryMainCompany: TWideStringField
      DisplayLabel = 'Customer'
      DisplayWidth = 15
      FieldName = 'Company'
      Origin = 'C.Company'
      Size = 160
    end
    object qryMainPartName: TWideStringField
      DisplayLabel = 'Product'
      DisplayWidth = 15
      FieldName = 'PartName'
      Origin = 'tblforeignprice.PartName'
      Size = 60
    end
    object qryMainBuy1: TIntegerField
      DisplayLabel = 'Quantity'
      DisplayWidth = 10
      FieldName = 'Buy1'
      Origin = 'tblforeignprice.Buy1'
    end
    object qryMainPrice1: TFloatField
      DisplayLabel = 'Price'
      DisplayWidth = 10
      FieldName = 'Price1'
      Origin = 'tblforeignprice.Price1'
    end
    object qryMainUOM: TWideStringField
      DisplayWidth = 20
      FieldName = 'UOM'
      Origin = '.UOM'
      Size = 114
    end
    object qryMainCurrency: TWideStringField
      DisplayWidth = 20
      FieldName = 'Currency'
      Origin = 'CC.Currency'
      Size = 255
    end
    object qryMainCountry: TWideStringField
      DisplayWidth = 20
      FieldName = 'Country'
      Origin = 'CC.Country'
      Size = 255
    end
    object qryMainForeignPriceID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'ForeignPriceID'
      Origin = 'tblforeignprice.ForeignPriceID'
      Visible = False
    end
    object qryMainSupplierProductCode: TWideStringField
      DisplayWidth = 50
      FieldName = 'SupplierProductCode'
      Origin = 'tblforeignprice.SupplierProductCode'
      Visible = False
      Size = 50
    end
    object qryMainSupplierProductName: TWideStringField
      DisplayWidth = 50
      FieldName = 'SupplierProductName'
      Origin = 'tblforeignprice.SupplierProductName'
      Visible = False
      Size = 50
    end
    object qryMainPartsId: TIntegerField
      FieldName = 'PartsId'
    end
  end
end
