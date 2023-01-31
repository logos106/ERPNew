inherited GeneralPrefsGUI: TGeneralPrefsGUI
  Left = 100
  Top = 100
  HelpContext = 1499002
  ClientHeight = 861
  ClientWidth = 1084
  ExplicitLeft = 100
  ExplicitTop = 100
  ExplicitWidth = 1100
  ExplicitHeight = 900
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 861
    Width = 1084
    HelpContext = 1499003
    ExplicitTop = 288
    ExplicitWidth = 908
  end
  inherited sbpanels: TAdvScrollBox
    Width = 1084
    Height = 861
    ExplicitWidth = 1084
    ExplicitHeight = 861
    HelpContext = 1499060
    object lblWidth: TLabel
      Left = 15
      Top = 8
      Width = 863
      Height = 22
      HelpContext = 1499004
      Caption = 
        'All panels should have a width of 545.  Panel TabOrder is used f' +
        'or panel placement sequence.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DNMPanel2: TDNMPanel
      Tag = 10
      Left = 0
      Top = 0
      Width = 1065
      Height = 314
      HelpContext = 1499023
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 878
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 300
        HelpContext = 1499024
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 17
        ExplicitTop = 11
        ExplicitWidth = 531
      end
      object Label7: TLabel
        Left = 14
        Top = 14
        Width = 125
        Height = 15
        HelpContext = 1499025
        Caption = 'Product List Headings'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label8: TLabel
        Left = 24
        Top = 40
        Width = 127
        Height = 15
        HelpContext = 1499026
        Caption = 'Product Column Name'
        Transparent = True
      end
      object Label9: TLabel
        Left = 24
        Top = 96
        Width = 107
        Height = 15
        HelpContext = 1499027
        Caption = 'First Column Name'
        Transparent = True
      end
      object Label10: TLabel
        Left = 24
        Top = 152
        Width = 125
        Height = 15
        HelpContext = 1499028
        Caption = 'Second Column Name'
        Transparent = True
      end
      object Label11: TLabel
        Left = 24
        Top = 208
        Width = 111
        Height = 15
        HelpContext = 1499029
        Caption = 'Third Column Name'
        Transparent = True
      end
      object Label13: TLabel
        Left = 296
        Top = 96
        Width = 60
        Height = 15
        HelpContext = 1499030
        Alignment = taRightJustify
        Caption = 'Equipment'
        Transparent = True
      end
      object Label94: TLabel
        Left = 296
        Top = 152
        Width = 23
        Height = 15
        HelpContext = 1499031
        Alignment = taRightJustify
        Caption = 'Hire'
        Transparent = True
      end
      object Label6: TLabel
        Left = 296
        Top = 40
        Width = 150
        Height = 15
        HelpContext = 1499019
        Caption = 'Description Name Heading'
        Transparent = True
      end
      object wwDBEdit3: TwwDBEdit
        Left = 24
        Top = 56
        Width = 170
        Height = 23
        HelpContext = 1499032
        DataField = 'PartColumnName'
        DataSource = dsColumnHeadings
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit4: TwwDBEdit
        Left = 24
        Top = 112
        Width = 170
        Height = 23
        HelpContext = 1499033
        DataField = 'FirstColumn'
        DataSource = dsColumnHeadings
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit5: TwwDBEdit
        Left = 24
        Top = 168
        Width = 170
        Height = 23
        HelpContext = 1499034
        DataField = 'SecondColumnName'
        DataSource = dsColumnHeadings
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit6: TwwDBEdit
        Left = 24
        Top = 224
        Width = 170
        Height = 23
        HelpContext = 1499035
        DataField = 'ThirdColumnName'
        DataSource = dsColumnHeadings
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit29: TwwDBEdit
        Left = 296
        Top = 112
        Width = 170
        Height = 23
        HelpContext = 1499036
        DataField = 'EquipmentName'
        DataSource = dsColumnHeadings
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit30: TwwDBEdit
        Left = 296
        Top = 168
        Width = 170
        Height = 23
        HelpContext = 1499037
        DataField = 'HireName'
        DataSource = dsColumnHeadings
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit2: TwwDBEdit
        Left = 296
        Top = 56
        Width = 170
        Height = 23
        HelpContext = 1499022
        DataField = 'ProductPrintNameHeading'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwCheckBox10: TwwCheckBox
        Left = 26
        Top = 271
        Width = 367
        Height = 17
        HelpContext = 1499059
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Copy '#39' Description Name'#39' To '#39'Product Name'#39
        DataField = 'CopyProductPrintNameToName'
        DataSource = dsPrefs
        TabOrder = 7
      end
    end
    object DNMPanel16: TDNMPanel
      Tag = 11
      Left = 0
      Top = 739
      Width = 1065
      Height = 158
      HelpContext = 1499038
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Bevel20: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 144
        HelpContext = 1499039
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 0
        ExplicitTop = 11
        ExplicitWidth = 531
        ExplicitHeight = 263
      end
      object Label85: TLabel
        Left = 14
        Top = 14
        Width = 160
        Height = 15
        HelpContext = 1499040
        Caption = 'Product Allocation Headings'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label86: TLabel
        Left = 51
        Top = 47
        Width = 84
        Height = 15
        HelpContext = 1499041
        Alignment = taRightJustify
        Caption = 'Batch Number '
        Transparent = True
      end
      object Label87: TLabel
        Left = 24
        Top = 122
        Width = 111
        Height = 15
        HelpContext = 1499042
        Alignment = taRightJustify
        Caption = 'Truck Load Number'
        Transparent = True
      end
      object Label88: TLabel
        Left = 71
        Top = 84
        Width = 64
        Height = 15
        HelpContext = 1499043
        Alignment = taRightJustify
        Caption = 'Expiry Date'
        Transparent = True
      end
      object wwDBEdit26: TwwDBEdit
        Left = 148
        Top = 43
        Width = 170
        Height = 23
        HelpContext = 1499044
        DataField = 'AllocationBatchnoName'
        DataSource = dsColumnHeadings
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit27: TwwDBEdit
        Left = 148
        Top = 118
        Width = 170
        Height = 23
        HelpContext = 1499045
        DataField = 'AllocationTruckLoadNoName'
        DataSource = dsColumnHeadings
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit28: TwwDBEdit
        Left = 148
        Top = 80
        Width = 170
        Height = 23
        HelpContext = 1499046
        DataField = 'AllocationExpiryDateName'
        DataSource = dsColumnHeadings
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
    end
    object DNMPanel3: TDNMPanel
      Tag = 11
      Left = 0
      Top = 314
      Width = 1065
      Height = 279
      HelpContext = 1499047
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      ExplicitWidth = 1082
      object Bevel3: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 265
        HelpContext = 1499048
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 0
        ExplicitTop = 11
        ExplicitWidth = 531
        ExplicitHeight = 263
      end
      object Label12: TLabel
        Left = 14
        Top = 14
        Width = 124
        Height = 15
        HelpContext = 1499049
        Caption = 'Client Name Headings'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label14: TLabel
        Left = 97
        Top = 47
        Width = 92
        Height = 15
        HelpContext = 1499050
        Alignment = taRightJustify
        Caption = 'Customer Name'
        Transparent = True
      end
      object Label15: TLabel
        Left = 101
        Top = 122
        Width = 88
        Height = 15
        HelpContext = 1499051
        Alignment = taRightJustify
        Caption = 'Prospect Name'
        Transparent = True
      end
      object Label16: TLabel
        Left = 106
        Top = 84
        Width = 83
        Height = 15
        HelpContext = 1499052
        Alignment = taRightJustify
        Caption = 'Supplier Name'
        Transparent = True
      end
      object Label3: TLabel
        Left = 35
        Top = 161
        Width = 150
        Height = 15
        HelpContext = 1499010
        Caption = 'Description Name Heading'
        Transparent = True
      end
      object wwDBEdit7: TwwDBEdit
        Left = 202
        Top = 43
        Width = 170
        Height = 23
        HelpContext = 1499053
        DataField = 'CustomerColumnName'
        DataSource = dsColumnHeadings
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit8: TwwDBEdit
        Left = 202
        Top = 118
        Width = 170
        Height = 23
        HelpContext = 1499054
        DataField = 'ProspectColumnName'
        DataSource = dsColumnHeadings
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit9: TwwDBEdit
        Left = 202
        Top = 80
        Width = 170
        Height = 23
        HelpContext = 1499055
        DataField = 'SupplierColumnName'
        DataSource = dsColumnHeadings
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwDBEdit1: TwwDBEdit
        Left = 202
        Top = 157
        Width = 170
        Height = 23
        HelpContext = 1499013
        DataField = 'ClientPrintNameHeading'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
      end
      object wwCheckBox1: TwwCheckBox
        Left = 26
        Top = 202
        Width = 287
        Height = 17
        HelpContext = 1499057
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Copy '#39' Description Name'#39' To Client Name'#39
        DataField = 'CopyClientPrintNameToName'
        DataSource = dsPrefs
        TabOrder = 4
      end
      object chkMakeMcforClients: TwwCheckBox
        Left = 26
        Top = 235
        Width = 287
        Height = 17
        HelpContext = 1499061
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Make '#39'Marketing Contact'#39' For Clients'
        DataField = 'MakeMcforClients'
        DataSource = dsPrefs
        TabOrder = 5
        OnClick = chkMakeMcforClientsClick
      end
    end
    object DNMPanel1: TDNMPanel
      Tag = 11
      Left = 0
      Top = 593
      Width = 1065
      Height = 146
      HelpContext = 1499062
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      ExplicitLeft = 385
      ExplicitTop = 348
      ExplicitWidth = 545
      DesignSize = (
        1065
        146)
      object Bevel1: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1051
        Height = 132
        HelpContext = 1499063
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 61
        ExplicitTop = 46
        ExplicitWidth = 531
        ExplicitHeight = 109
      end
      object Label1: TLabel
        Left = 14
        Top = 14
        Width = 44
        Height = 15
        HelpContext = 1499064
        Caption = 'Options'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object wwCheckBox2: TwwCheckBox
        Left = 36
        Top = 45
        Width = 270
        Height = 17
        HelpContext = 1499065
        DisableThemes = False
        AlwaysTransparent = True
        Frame.Enabled = True
        Frame.Transparent = True
        Frame.FocusBorders = []
        Frame.NonFocusBorders = []
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Caption = 'Show Multi-Select Selection List'
        DataField = 'ShowMultiSelectSelectionList'
        DataSource = dsPrefs
        TabOrder = 0
      end
      object DNMPanel4: TDNMPanel
        Left = 59
        Top = 65
        Width = 985
        Height = 67
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        BorderWidth = 1
        BorderStyle = bsSingle
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        HelpContext = 1499066
        object lblNote1: TLabel
          Left = 1
          Top = 1
          Width = 979
          Height = 61
          HelpContext = 1499067
          Align = alClient
          Caption = 
            'Options Options Options Options Options Options Options Options ' +
            'Options Options Options Options Options Options Options Options ' +
            'Options Options Options Options Options Options Options Options ' +
            'Options Options Options Options Options Options Options Options ' +
            'Options Options Options Options Options Options Options Options '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          Transparent = True
          WordWrap = True
          ExplicitWidth = 966
          ExplicitHeight = 30
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 668
    Top = 72
  end
  inherited tmrdelay: TTimer
    Left = 756
    Top = 72
  end
  inherited popSpelling: TPopupMenu
    Left = 800
    Top = 72
  end
  inherited tmrdelayMsg: TTimer
    Left = 712
    Top = 72
  end
  object dsPrefs: TDataSourcePrefs
    FieldDefs = <>
    FieldNames.Strings = (
      'ClientPrintNameHeading'
      'CopyClientPrintNameToName'
      'CopyProductPrintNameToName'
      'MakeMcforClients'
      'ProductPrintNameHeading'
      'ShowMultiSelectSelectionList')
    Left = 624
    Top = 72
  end
  object qryColumnHeadings: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblcolumnheadings')
    BeforePost = qryColumnHeadingsBeforePost
    Left = 664
    Top = 112
  end
  object dsColumnHeadings: TDataSource
    DataSet = qryColumnHeadings
    Left = 624
    Top = 112
  end
end
