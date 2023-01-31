inherited fmDU_ExtraSellPrice: TfmDU_ExtraSellPrice
  Left = 299
  Top = 190
  HelpContext = 980001
  Caption = 'fmDU_ExtraSellPrice'
  ExplicitLeft = 299
  ExplicitTop = 190
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TDNMPanel
    HelpContext = 980014
    BevelOuter = bvNone
    Font.Height = -16
    TabStop = True
    Transparent = False
    inherited pnlTop: TDNMPanel
      Left = 0
      Top = 0
      Width = 824
      HelpContext = 980002
      BevelOuter = bvNone
      TabOrder = 5
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 824
      inherited Shader1: TShader
        Left = 0
        Top = 0
        Width = 824
        Height = 47
        HelpContext = 980003
        TabOrder = 2
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 824
        ExplicitHeight = 47
        inherited lblCaption: TLabel
          Width = 824
          Height = 47
          HelpContext = 980004
          Caption = '  Extra Sell Price'
          ExplicitTop = 17
          ExplicitWidth = 87
          ExplicitHeight = 38
        end
      end
      object optLockExtraSellPrice: TRadioGroup
        Left = 245
        Top = -1
        Width = 288
        Height = 44
        HelpContext = 980005
        Caption = 'Lock Extra Sell Price'
        Columns = 3
        ItemIndex = 2
        Items.Strings = (
          'Yes'
          'No'
          'N/A')
        TabOrder = 0
      end
      object optExtraSellPriceOverrides: TRadioGroup
        Left = 536
        Top = -1
        Width = 288
        Height = 44
        HelpContext = 980006
        Caption = 'Extra Sell Price Overrides All Other Discounts'
        Columns = 3
        ItemIndex = 2
        Items.Strings = (
          'Yes'
          'No'
          'N/A')
        TabOrder = 1
      end
    end
    inherited pnlDEtails: TDNMPanel
      Left = 0
      Top = 47
      Width = 824
      Height = 334
      HelpContext = 980007
      ExplicitLeft = 0
      ExplicitTop = 47
      ExplicitWidth = 824
      ExplicitHeight = 344
      inherited grdmain: TwwDBGrid
        Width = 822
        Height = 332
        HelpContext = 980008
        ControlType.Strings = (
          'ClientTypeName;CustomEdit;cboClientType;F'
          'DefaultPrice;CheckBox;T;F'
          'InUse;CheckBox;T;F'
          'AllClients;CheckBox;T;F'
          'DateFrom;CustomEdit;wwDBDatefrom;F'
          'DateTo;CustomEdit;wwDBDateTo;F'
          'UOM;CustomEdit;cboUOMESP;F'
          'ExtraSellPriceOverridesAllDiscounts;CheckBox;T;F'
          'VariationOption;CustomEdit;OptVariation;F'
          'Variationtype;CustomEdit;opttype;F'
          'Terms;CustomEdit;cboTerms;F')
        Selected.Strings = (
          'ClientTypeName'#9'20'#9'Client ~Type'#9'F'
          'Terms'#9'10'#9'Terms'#9'F'
          'UOM'#9'10'#9'Unit Of Measure'#9'F'
          'AllClients'#9'10'#9'All ~Clients'#9'F'
          'QtyPercent1'#9'10'#9'% ~Discount'#9'F'
          'Price1'#9'10'#9'Price~(Ex)'#9'F'
          'ExtraSellDesc'#9'15'#9'Description'#9'F'
          'DateFrom'#9'12'#9'Date From'#9'F'
          'DateTo'#9'12'#9'DateTo'#9'F'
          'VariationOption'#9'40'#9'Variation Option'#9'F'
          'Variationtype'#9'25'#9'Variation Type'#9'F'
          'VariationAmt'#9'15'#9'Variation~Amt'#9'F')
        OnRowChanged = grdmainRowChanged
        KeyOptions = [dgEnterToTab, dgAllowInsert]
        OnEnter = grdmainEnter
        ExplicitLeft = 2
        ExplicitTop = 2
        ExplicitWidth = 822
        ExplicitHeight = 332
        inherited btnDelete: TwwIButton
          OnClick = btnDeleteClick
        end
      end
      object cboTerms: TwwDBLookupCombo
        Left = 32
        Top = 95
        Width = 125
        Height = 26
        HelpContext = 980013
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'TypeName'#9'30'#9'Type Name'#9'F'
          'TypeDescription'#9'50'#9'Description'#9'F')
        DataField = 'Terms'
        LookupTable = QryTerms
        LookupField = 'Terms'
        Options = [loColLines, loTitles]
        Style = csDropDownList
        Color = clWhite
        TabOrder = 3
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnNotInList = cboClientTypeNotInList
      end
    end
    object wwDBDateTo: TwwDBDateTimePicker
      Left = 263
      Top = 70
      Width = 121
      Height = 26
      HelpContext = 980009
      CalendarAttributes.Alignment = wwdtaRight
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      Epoch = 1950
      ShowButton = True
      TabOrder = 2
    end
    object wwDBDatefrom: TwwDBDateTimePicker
      Left = 415
      Top = 70
      Width = 121
      Height = 26
      HelpContext = 980010
      CalendarAttributes.Alignment = wwdtaRight
      CalendarAttributes.Font.Charset = DEFAULT_CHARSET
      CalendarAttributes.Font.Color = clWindowText
      CalendarAttributes.Font.Height = -11
      CalendarAttributes.Font.Name = 'MS Sans Serif'
      CalendarAttributes.Font.Style = []
      Epoch = 1950
      ShowButton = True
      TabOrder = 3
    end
    object cboClientType: TwwDBLookupCombo
      Left = 27
      Top = 70
      Width = 125
      Height = 26
      HelpContext = 980011
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'TypeName'#9'30'#9'Type Name'#9'F'
        'TypeDescription'#9'50'#9'Description'#9'F')
      DataField = 'ClientTypeName'
      DataSource = dsmain
      LookupTable = qryClientTypes
      LookupField = 'ClientTypeID'
      Options = [loColLines, loTitles]
      Style = csDropDownList
      Color = clWhite
      TabOrder = 0
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
      OnNotInList = cboClientTypeNotInList
    end
    object cboUOMESP: TwwDBLookupCombo
      Left = 148
      Top = 70
      Width = 109
      Height = 26
      HelpContext = 980012
      DropDownAlignment = taLeftJustify
      Selected.Strings = (
        'Unitname'#9'15'#9'Unit Name'#9'F'
        'multiplier'#9'10'#9'Multiplier'#9'F')
      DataField = 'UOM'
      DataSource = dsmain
      LookupTable = QryUOM
      LookupField = 'Unitname'
      AutoSelect = False
      TabOrder = 4
      AutoDropDown = True
      ShowButton = True
      PreciseEditRegion = False
      AllowClearKey = False
    end
  end
  inherited dsmain: TDataSource
    DataSet = fmDataUpdator.qryExtraSellPrice
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
  object qryClientTypes: TERPQuery
    SQL.Strings = (
      'SELECT '
      'ClientTypeID, TypeName, TypeDescription '
      'FROM tblClientType'
      'WHERE Active = '#39'T'#39)
    Left = 132
    Top = 176
  end
  object QryTerms: TERPQuery
    SQL.Strings = (
      'SELECT '
      '* '
      'FROM tblterms'
      'WHERE Active = '#39'T'#39
      'Order by Terms')
    Left = 246
    Top = 331
  end
end
