inherited fmDU_ExtraForeignBuyPrice: TfmDU_ExtraForeignBuyPrice
  Left = 253
  Top = 482
  Caption = 'fmDU_ExtraForeignBuyPrice'
  ClientWidth = 860
  ExplicitLeft = 253
  ExplicitTop = 482
  ExplicitWidth = 868
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 983001
  inherited lblSkingroupMsg: TLabel
    Width = 860
    ExplicitWidth = 860
    HelpContext = 983002
  end
  inherited pnlMain: TDNMPanel
    Width = 860
    HelpContext = 983003
    BevelOuter = bvNone
    Font.Height = -16
    Transparent = False
    ExplicitWidth = 860
    inherited pnlTop: TDNMPanel
      Left = 0
      Top = 0
      Width = 860
      HelpContext = 983004
      BevelOuter = bvNone
      TabOrder = 3
      Transparent = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 860
      inherited Shader1: TShader
        Left = 0
        Top = 0
        Width = 860
        Height = 47
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 860
        ExplicitHeight = 38
        HelpContext = 983005
        inherited lblCaption: TLabel
          Width = 860
          Height = 47
          Caption = '  Foreign Buy Price'
          ExplicitTop = 17
          ExplicitWidth = 99
          ExplicitHeight = 38
          HelpContext = 983006
        end
      end
    end
    inherited pnlDEtails: TDNMPanel
      Left = 0
      Top = 47
      Width = 860
      Height = 334
      ExplicitWidth = 824
      ExplicitHeight = 357
      HelpContext = 983007
      inherited grdmain: TwwDBGrid
        Width = 858
        Height = 332
        HelpContext = 983008
        ControlType.Strings = (
          'SupplierName;CustomEdit;cboSupplierForeign;F'
          'UsePrice;CheckBox;T;F'
          'CurrencyCode;CustomEdit;cboBuyCurrency;F'
          'UOM;CustomEdit;cboUOMEBFP;F'
          'VariationOption;CustomEdit;OptVariation;F'
          'Variationtype;CustomEdit;opttype;F')
        Selected.Strings = (
          'SupplierName'#9'20'#9'Supplier'#9'F'
          'UOM'#9'10'#9'Unit Of Measure'#9'F'
          'CurrencyCode'#9'10'#9'Currency'#9'F'
          'Price1'#9'10'#9'Price~(EX)'#9'F'
          'VariationOption'#9'40'#9'Variation Option'#9'F'
          'Variationtype'#9'25'#9'Variation Type'#9'F'
          'VariationAmt'#9'15'#9'Variation~Amt'#9'F')
        ExplicitLeft = 1
        ExplicitWidth = 858
        ExplicitHeight = 341
        inherited btnDelete: TwwIButton
          Width = 25
          OnClick = btnDeleteClick
          ExplicitWidth = 25
          HelpContext = 983009
        end
      end
    end
    object cboSupplierForeign: TwwDBLookupCombo
      Left = 152
      Top = 70
      Width = 113
      Height = 26
      AutoSize = False
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'80'#9'Company'#9'F')
      DataField = 'SupplierName'
      DataSource = dsmain
      LookupTable = cboClientLookup
      LookupField = 'ClientID'
      TabOrder = 1
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      HelpContext = 983010
    end
    object cboUOMEBFP: TwwDBLookupCombo
      Left = 271
      Top = 70
      Width = 69
      Height = 26
      HelpContext = 983011
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Unitname'#9'15'#9'Unit Name'#9'F'
        'multiplier'#9'10'#9'Multiplier'#9'F')
      DataField = 'UOM'
      DataSource = dsmain
      LookupTable = QryUOM
      LookupField = 'Unitname'
      AutoSelect = False
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboBuyCurrency: TwwDBLookupCombo
      Left = 53
      Top = 70
      Width = 93
      Height = 26
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Code'#9'3'#9'Code'#9'F'#9)
      DataField = 'CurrencyCode'
      DataSource = dsmain
      LookupTable = qrySellCurrencyLookup
      LookupField = 'Code'
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      HelpContext = 983012
    end
  end
  inherited dsmain: TDataSource
    DataSet = fmDataUpdator.QryExtraFxBuyPrice
  end
  object cboClientLookup: TERPQuery
    SQLDelete.Strings = (
      'DELETE FROM tblclients'
      'WHERE'
      '  ClientID = :Old_ClientID')
    SQLUpdate.Strings = (
      'UPDATE tblclients'
      'SET'
      
        '  ClientID = :ClientID, Company = :Company, ForeignExchangeSellC' +
        'ode = :ForeignExchangeSellCode'
      'WHERE'
      '  ClientID = :Old_ClientID')
    SQLRefresh.Strings = (
      
        'SELECT tblclients.ClientID, tblclients.Company, tblclients.Forei' +
        'gnExchangeSellCode FROM tblclients'
      'WHERE'
      '  tblclients.ClientID = :Old_ClientID')
    SQL.Strings = (
      'SELECT ClientID, Company, ForeignExchangeSellCode'
      'FROM tblclients'
      
        'WHERE tblclients.Company Is Not Null And tblclients.Active <>'#39'F'#39 +
        ' And tblclients.Supplier = '#39'T'#39
      ''
      '')
    FetchRows = 1
    Left = 54
    Top = 176
    object cboClientLookupCompany: TWideStringField
      DisplayWidth = 80
      FieldName = 'Company'
      Origin = 'tblclients.Company'
      Size = 80
    end
    object cboClientLookupClientID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ClientID'
      Origin = 'tblclients.ClientID'
    end
    object cboClientLookupForeignExchangeSellCode: TWideStringField
      FieldName = 'ForeignExchangeSellCode'
      Origin = 'tblclients.ForeignExchangeSellCode'
      FixedChar = True
      Size = 3
    end
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
  object qrySellCurrencyLookup: TERPQuery
    SQL.Strings = (
      
        'SELECT CurrencyId, Code FROM tblCurrencyConversion WHERE SellRat' +
        'e > 0')
    Left = 103
    Top = 232
  end
end
