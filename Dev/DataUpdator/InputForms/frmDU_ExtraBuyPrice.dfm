inherited fmDU_ExtraBuyPrice: TfmDU_ExtraBuyPrice
  Left = 79
  Top = 121
  HelpContext = 982001
  Caption = 'fmDU_ExtraBuyPrice'
  ClientHeight = 351
  ClientWidth = 756
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 772
  ExplicitHeight = 390
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 351
    Width = 756
    HelpContext = 982002
    ExplicitTop = 351
    ExplicitWidth = 840
  end
  inherited pnlMain: TDNMPanel
    Width = 756
    Height = 351
    HelpContext = 982003
    BevelOuter = bvNone
    Font.Height = -16
    Transparent = False
    ExplicitWidth = 756
    ExplicitHeight = 351
    inherited pnlTop: TDNMPanel
      Left = 0
      Top = 0
      Width = 756
      HelpContext = 982004
      BevelOuter = bvNone
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 756
      inherited Shader1: TShader
        Left = 0
        Top = 0
        Width = 756
        Height = 47
        HelpContext = 982005
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 756
        ExplicitHeight = 47
        inherited lblCaption: TLabel
          Width = 756
          Height = 47
          HelpContext = 982006
          Caption = '  Extra Buy Price'
          ExplicitTop = 17
          ExplicitWidth = 87
          ExplicitHeight = 38
        end
      end
    end
    inherited pnlDEtails: TDNMPanel
      Left = 0
      Top = 47
      Width = 756
      Height = 304
      HelpContext = 982007
      ExplicitLeft = 0
      ExplicitTop = 47
      ExplicitWidth = 756
      ExplicitHeight = 304
      inherited grdmain: TwwDBGrid
        Width = 754
        Height = 302
        HelpContext = 982008
        ControlType.Strings = (
          'SupplierName;CustomEdit;cboSupplier;F'
          'UsePrice;CheckBox;T;F'
          'UOM;CustomEdit;cboUOMEBP;F'
          'VariationOption;CustomEdit;OptVariation;F'
          'Variationtype;CustomEdit;opttype;F')
        Selected.Strings = (
          'SupplierName'#9'20'#9'Supplier'#9'F'
          'UOM'#9'10'#9'Unit Of Measure'#9'F'
          'Price'#9'10'#9'Price~(Ex)'#9'F'
          'UsePrice'#9'10'#9'Use'#9'F'
          'PrintedValue1'#9'10'#9'Printed~Value'#9'F'
          'MinimumOrderQty'#9'10'#9'Min Order Qty'#9'F'
          'VariationOption'#9'40'#9'Variation Option'#9'F'
          'Variationtype'#9'25'#9'Variation Type'#9'F'
          'VariationAmt'#9'15'#9'Variation~Amt'#9'F')
        ExplicitWidth = 754
        ExplicitHeight = 302
        inherited btnDelete: TwwIButton
          OnClick = btnDeleteClick
        end
      end
    end
    object cboSupplier: TwwDBLookupCombo
      Left = 32
      Top = 70
      Width = 121
      Height = 26
      HelpContext = 982009
      AutoSize = False
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Company'#9'30'#9'Company'#9'F')
      DataField = 'SupplierName'
      DataSource = dsmain
      LookupTable = cboClientLookup
      LookupField = 'ClientID'
      TabOrder = 2
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
    object cboUOMEBP: TwwDBLookupCombo
      Left = 172
      Top = 70
      Width = 109
      Height = 26
      HelpContext = 982010
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Unitname'#9'15'#9'Unit Name'#9'F'
        'multiplier'#9'10'#9'Multiplier'#9'F')
      DataField = 'UOM'
      DataSource = dsmain
      LookupTable = QryUOM
      LookupField = 'Unitname'
      AutoSelect = False
      TabOrder = 3
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
  end
  inherited dsmain: TDataSource
    DataSet = fmDataUpdator.qryExtraBuyPrice
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
end
