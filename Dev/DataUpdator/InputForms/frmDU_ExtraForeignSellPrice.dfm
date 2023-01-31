inherited fmDU_ExtraForeignSellPrice: TfmDU_ExtraForeignSellPrice
  Left = 342
  Top = 388
  Caption = 'fmDU_ExtraForeignSellPrice'
  ExplicitLeft = 342
  ExplicitTop = 388
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 981001
  inherited pnlMain: TDNMPanel
    HelpContext = 981009
    BevelOuter = bvNone
    Font.Height = -16
    TabStop = True
    Transparent = False
    inherited pnlTop: TDNMPanel
      Left = 0
      Top = 0
      Width = 824
      HelpContext = 981002
      BevelOuter = bvNone
      Transparent = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 824
      inherited Shader1: TShader
        Left = 0
        Top = 0
        Width = 824
        Height = 47
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 824
        ExplicitHeight = 38
        HelpContext = 981003
        inherited lblCaption: TLabel
          Width = 824
          Height = 47
          Caption = '  Foreign Sell Price'
          ExplicitLeft = -1
          ExplicitTop = -3
          ExplicitWidth = 824
          ExplicitHeight = 38
          HelpContext = 981004
        end
      end
    end
    inherited pnlDEtails: TDNMPanel
      Left = 0
      Top = 47
      Width = 824
      Height = 334
      TabOrder = 2
      ExplicitWidth = 824
      ExplicitHeight = 352
      HelpContext = 981005
      inherited grdmain: TwwDBGrid
        Width = 822
        Height = 332
        HelpContext = 981006
        ControlType.Strings = (
          'UsePrice;CheckBox;T;F'
          'Code;CustomEdit;cboSellCurrency;F'
          'UOM;CustomEdit;cboUOMESFP;F'
          'VariationOption;CustomEdit;OptVariation;F'
          'Variationtype;CustomEdit;opttype;F')
        Selected.Strings = (
          'Code'#9'10'#9'Currency'#9'F'
          'UOM'#9'10'#9'Unit of Measure'#9'F'
          'Price1'#9'10'#9'Price~(Ex)'#9'F'
          'VariationOption'#9'40'#9'Variation Option'#9'F'
          'Variationtype'#9'25'#9'Variation Type'#9'F'
          'VariationAmt'#9'15'#9'Variation~Amt'#9'F')
        ExplicitLeft = 1
        ExplicitWidth = 822
        ExplicitHeight = 341
        inherited btnDelete: TwwIButton
          OnClick = btnDeleteClick
        end
      end
    end
    object cboUOMESFP: TwwDBLookupCombo
      Left = 108
      Top = 70
      Width = 109
      Height = 26
      HelpContext = 981007
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Unitname'#9'15'#9'Unit Name'#9'F'
        'multiplier'#9'10'#9'Multiplier'#9'F')
      DataField = 'UOM'
      DataSource = dsmain
      LookupTable = QryUOM
      LookupField = 'Unitname'
      AutoSelect = False
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboSellCurrency: TwwDBLookupCombo
      Left = 37
      Top = 70
      Width = 73
      Height = 26
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Code'#9'3'#9'Code'#9'F')
      DataField = 'Code'
      DataSource = dsmain
      LookupTable = qryBuyCurrencyLookup
      LookupField = 'Code'
      TabOrder = 3
      AutoDropDown = False
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      HelpContext = 981008
    end
  end
  inherited dsmain: TDataSource
    DataSet = fmDataUpdator.qryExtraFxSellPrice
  end
  object qryBuyCurrencyLookup: TERPQuery
    SQL.Strings = (
      
        'SELECT CurrencyId, Code FROM tblCurrencyConversion WHERE BuyRate' +
        ' > 0')
    Left = 139
    Top = 232
  end
  object QryUOM: TERPQuery
    SQL.Strings = (
      'SELECT  '
      'distinct U.UnitName'
      'FROM tblunitsofmeasure U'
      'WHERE U.ACTIVE = '#39'T'#39'  '
      'Order By UnitName;')
    Options.LongStrings = False
    Left = 98
    Top = 176
    object QryUOMUnitname: TWideStringField
      DisplayLabel = 'Unit Name'
      DisplayWidth = 15
      FieldName = 'Unitname'
      Origin = '.UnitName'
      Size = 15
    end
  end
end
