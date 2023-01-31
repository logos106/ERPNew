inherited PriceDiscountList: TPriceDiscountList
  Left = 245
  Top = 149
  HelpContext = 438000
  Caption = 'Discount Price List'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited FilterLabel: TLabel
    HelpContext = 438001
  end
  inherited FooterPanel: TPanel
    HelpContext = 438002
    Color = 15588572
    inherited Label3: TLabel
      HelpContext = 438003
    end
    inherited lblTotal: TLabel
      HelpContext = 438004
    end
    inherited Label121: TLabel
      HelpContext = 438005
    end
    inherited lblTimeLabel: TLabel
      HelpContext = 438006
    end
    inherited lblTime: TLabel
      HelpContext = 438007
    end
    inherited cmdClose: TDNMSpeedButton
      HelpContext = 438008
    end
    inherited cmdNew: TDNMSpeedButton
      HelpContext = 438009
      Enabled = False
    end
    inherited cmdPrint: TDNMSpeedButton
      HelpContext = 438010
    end
    inherited cmdExport: TDNMSpeedButton
      HelpContext = 438011
    end
    inherited btnCustomize: TDNMSpeedButton
      HelpContext = 438012
    end
    inherited pnlAdvPrinting: TDNMPanel
      HelpContext = 438013
      inherited LblChooseTemplate: TLabel
        HelpContext = 438014
      end
      inherited LblShowPreview: TLabel
        HelpContext = 438015
      end
      inherited ChkChooseRpt: TCheckBox
        HelpContext = 438016
      end
      inherited chkPreview: TCheckBox
        HelpContext = 438017
      end
    end
    inherited chkAdvancedPrinting: TCheckBox
      HelpContext = 438018
    end
    inherited barStatus: TAdvOfficeStatusBar
      HelpContext = 438019
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
    HelpContext = 438020
    Color = 15588572
    inherited lblFrom: TLabel
      HelpContext = 438021
    end
    inherited lblTo: TLabel
      HelpContext = 438022
    end
    inherited pnlHeader: TPanel
      Left = 288
      Width = 450
      HelpContext = 438023
      Caption = 'Discount Price List'
      inherited TitleShader: TShader
        Width = 448
        HelpContext = 438024
        inherited TitleLabel: TLabel
          Width = 448
          HelpContext = 438025
        end
      end
    end
    inherited Panel2: TPanel
      HelpContext = 438026
      inherited grpFilters: TRadioGroup
        HelpContext = 438027
      end
      inherited pnlButtons: TPanel
        HelpContext = 438028
        inherited lblcustomReport: TLabel
          HelpContext = 438029
        end
        inherited btnAddFilter: TDNMSpeedButton
          HelpContext = 438030
        end
        inherited btnExecute: TDNMSpeedButton
          HelpContext = 438031
        end
        inherited btnClear: TDNMSpeedButton
          HelpContext = 438032
        end
        inherited btnRequery: TDNMSpeedButton
          HelpContext = 438033
        end
        inherited cboCustomReports: TwwDBLookupCombo
          HelpContext = 438034
        end
      end
    end
    inherited Panel3: TPanel
      HelpContext = 438035
      inherited Label1: TLabel
        HelpContext = 438036
      end
      inherited Label2: TLabel
        HelpContext = 438037
      end
      inherited cboFilter: TComboBox
        HelpContext = 438038
      end
      inherited edtSearch: TEdit
        HelpContext = 438039
      end
    end
    inherited dtFrom: TwwDBDateTimePicker
      HelpContext = 438040
    end
    inherited dtTo: TwwDBDateTimePicker
      HelpContext = 438041
    end
    inherited cboDateRange: TComboBox
      HelpContext = 438042
    end
    object Panel4: TPanel
      Left = 6
      Top = 6
      Width = 245
      Height = 48
      HelpContext = 438043
      BevelInner = bvRaised
      BevelOuter = bvLowered
      ParentColor = True
      TabOrder = 6
      object lblCustomer: TLabel
        Left = 10
        Top = 18
        Width = 62
        Height = 15
        HelpContext = 438044
        Alignment = taCenter
        Caption = 'Customer :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cboClient: TwwDBLookupCombo
        Left = 80
        Top = 15
        Width = 153
        Height = 22
        HelpContext = 438045
        DropDownAlignment = taRightJustify
        Selected.Strings = (
          'Company'#9'80'#9'Company'#9'F'#9)
        DataField = 'Company'
        LookupTable = qryClientLookup
        LookupField = 'ClientID'
        Options = [loColLines, loTitles]
        Style = csDropDownList
        Color = clWhite
        DropDownWidth = 450
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        AllowClearKey = False
        OnCloseUp = cboClientCloseUp
      end
    end
  end
  inherited Panel1: TPanel
    HelpContext = 438046
    inherited grdMain: TwwDBGrid
      HelpContext = 438047
      Selected.Strings = (
        'Product'#9'60'#9'Product'#9'F'#9
        'UnitofMeasure'#9'10'#9'UnitofMeasure'#9#9
        'PriceLevel'#9'8'#9'PriceLevel'#9#9
        'DescAttrib1'#9'10'#9'DescAttrib1'#9#9
        'DescAttrib2'#9'10'#9'DescAttrib2'#9#9
        'U of M Price (Inc)'#9'10'#9'U of M Price (Inc)'#9'F'#9
        'Sell Qty 1'#9'10'#9'Sell Qty 1'#9'F'#9
        '% of Price 1'#9'10'#9'% of Price 1'#9'F'#9
        'Price 1 (Ex)'#9'10'#9'Price 1 (Ex)'#9'F'#9
        'Sell Qty 2'#9'10'#9'Sell Qty 2'#9'F'#9
        '% of Price 2'#9'10'#9'% of Price 2'#9'F'#9
        'Price 2 (Ex)'#9'10'#9'Price 2 (Ex)'#9'F'#9
        'Sell Qty 3'#9'10'#9'Sell Qty 3'#9'F'#9
        '% of Price 3'#9'10'#9'% of Price 3'#9'F'#9
        'Price 3 (Ex)'#9'10'#9'Price 3 (Ex)'#9'F'#9
        'BARCODE'#9'14'#9'BARCODE'#9#9
        'PriceMatrixDesc'#9'25'#9'PriceMatrixDesc'#9#9
        'UnitofMeasureID'#9'15'#9'UnitofMeasureID'#9'F'#9
        'TAXCODE'#9'11'#9'TAXCODE'#9'F'
        'PRICE1'#9'10'#9'PRICE1'#9'F'
        'PRICE2'#9'10'#9'PRICE2'#9'F'
        'PRICE3'#9'10'#9'PRICE3'#9'F')
      TitleColor = 15588572
      FooterColor = 15588572
    end
  end
  inherited qryMain: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT P.PartName AS Product,'
      
        'PriceLevel, DescAttrib1, DescAttrib2, PM.UnitofMeasure, P.TAXCOD' +
        'E,'
      'PM.UnitofMeasureID, '
      
        'P.SellQTY1 AS "Sell Qty 1", QtyPercent1 AS "% of Price 1", P.PRI' +
        'CE1,'
      
        'P.SellQTY2 AS "Sell Qty 2", QtyPercent2 AS "% of Price 2", P.PRI' +
        'CE2,'
      
        'P.SellQTY3 AS "Sell Qty 3", QtyPercent3 AS "% of Price 3", P.PRI' +
        'CE3,'
      'PM.BARCODE, PriceMatrixDesc'
      'FROM tblpricematrix PM'
      'INNER JOIN tblparts P ON PM.PARTSID = P.PARTSID'
      'ORDER BY DescAttrib1, DescAttrib2;')
    OnCalcFields = qryMainCalcFields
    object qryMainProduct: TStringField
      DisplayWidth = 60
      FieldName = 'Product'
      Size = 60
    end
    object qryMainUnitofMeasure: TStringField
      DisplayWidth = 10
      FieldName = 'UnitofMeasure'
      Origin = 'tblpricematrix.UnitofMeasure'
      Size = 75
    end
    object qryMainPriceLevel: TStringField
      DisplayWidth = 8
      FieldName = 'PriceLevel'
      Origin = 'tblpricematrix.PriceLevel'
      Size = 40
    end
    object qryMainDescAttrib1: TStringField
      DisplayWidth = 10
      FieldName = 'DescAttrib1'
      Origin = 'tblpricematrix.DescAttrib1'
      Size = 75
    end
    object qryMainDescAttrib2: TStringField
      DisplayWidth = 10
      FieldName = 'DescAttrib2'
      Origin = 'tblpricematrix.DescAttrib2'
      Size = 75
    end
    object qryMainUofMPriceInc: TCurrencyField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'U of M Price (Inc)'
      Calculated = True
    end
    object qryMainSellQty12: TIntegerField
      DisplayWidth = 10
      FieldName = 'Sell Qty 1'
    end
    object qryMainofPrice1: TFloatField
      DisplayWidth = 10
      FieldName = '% of Price 1'
      DisplayFormat = '#0.00'
    end
    object qryMainPrice1Ex: TCurrencyField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'Price 1 (Ex)'
      Calculated = True
    end
    object qryMainSellQty22: TIntegerField
      DisplayWidth = 10
      FieldName = 'Sell Qty 2'
    end
    object qryMainofPrice2: TFloatField
      DisplayWidth = 10
      FieldName = '% of Price 2'
      DisplayFormat = '#0.00'
    end
    object qryMainPrice2Ex: TCurrencyField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'Price 2 (Ex)'
      Calculated = True
    end
    object qryMainSellQty32: TIntegerField
      DisplayWidth = 10
      FieldName = 'Sell Qty 3'
    end
    object qryMainofPrice3: TFloatField
      DisplayWidth = 10
      FieldName = '% of Price 3'
      DisplayFormat = '#0.00'
    end
    object qryMainPrice3Ex: TCurrencyField
      DisplayWidth = 10
      FieldKind = fkCalculated
      FieldName = 'Price 3 (Ex)'
      Calculated = True
    end
    object qryMainBARCODE: TStringField
      DisplayWidth = 14
      FieldName = 'BARCODE'
      Origin = 'tblpricematrix.BARCODE'
      Size = 255
    end
    object qryMainPriceMatrixDesc: TStringField
      DisplayWidth = 25
      FieldName = 'PriceMatrixDesc'
      Origin = 'tblpricematrix.PriceMatrixDesc'
      Size = 255
    end
    object qryMainUnitofMeasureID: TIntegerField
      DisplayWidth = 15
      FieldName = 'UnitofMeasureID'
    end
    object qryMainTAXCODE: TStringField
      DisplayWidth = 11
      FieldName = 'TAXCODE'
      Size = 11
    end
    object qryMainPRICE1: TFloatField
      DisplayWidth = 10
      FieldName = 'PRICE1'
      Origin = 'P.PRICE1'
    end
    object qryMainPRICE2: TFloatField
      DisplayWidth = 10
      FieldName = 'PRICE2'
      Origin = 'P.PRICE2'
    end
    object qryMainPRICE3: TFloatField
      DisplayWidth = 10
      FieldName = 'PRICE3'
      Origin = 'P.PRICE3'
    end
  end
  object qryClientLookup: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT ClientID, Company, ClientTypeID'
      'FROM tblclients'
      'WHERE Active='#39'T'#39' AND Company IS NOT Null'
      'ORDER BY Company;')
    Left = 88
    Top = 64
  end
end
