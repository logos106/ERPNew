inherited IntegrationPrefsGUI: TIntegrationPrefsGUI
  Left = 4201
  Top = 129
  HelpContext = 1064002
  Caption = 'Credentials'
  ClientHeight = 741
  ClientWidth = 1062
  ExplicitWidth = 1078
  ExplicitHeight = 780
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 741
    Width = 1062
    HelpContext = 1064003
    ExplicitTop = 879
    ExplicitWidth = 701
  end
  object Label37: TLabel [4]
    Left = 135
    Top = 171
    Width = 55
    Height = 15
    HelpContext = 1064140
    Alignment = taRightJustify
    Caption = 'Base URL'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  inherited sbpanels: TAdvScrollBox
    Width = 1062
    Height = 741
    HelpContext = 1064096
    VertScrollBar.Position = 2837
    ExplicitWidth = 1062
    ExplicitHeight = 741
    object pnlWooCommerceOptions: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 669
      Width = 1037
      Height = 76
      HelpContext = 1064135
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 17
      DesignSize = (
        1037
        76)
      object Bevel1: TBevel
        Left = 6
        Top = 47
        Width = 1023
        Height = -467
        HelpContext = 1064136
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitHeight = 34
      end
      object Label1: TLabel
        Left = 14
        Top = 11
        Width = 89
        Height = 15
        HelpContext = 1064137
        Caption = 'WooCommerce'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object lbWooCommerce: TLabel
        Left = 252
        Top = 37
        Width = 221
        Height = 15
        HelpContext = 504027
        Caption = 'Please contact ERP to enable Magento.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object chkEnableWooCommerce: TwwCheckBox
        Left = 10
        Top = 35
        Width = 154
        Height = 17
        HelpContext = 1064142
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
        Alignment = taLeftJustify
        Caption = 'Enable WooCommerce'
        DataField = 'EnableWooCommerce'
        DataSource = dsPrefs
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnClick = chkEnableWooCommerceClick
      end
      object chkShowWooCommerceonMainmenubyDefault: TwwCheckBox
        Left = 11
        Top = 58
        Width = 288
        Height = 17
        HelpContext = 1064143
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
        Alignment = taLeftJustify
        Caption = 'Show On Main Menu By Default When Enabled'
        DataField = 'ShowWooCommerceonMainmenubyDefault'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
      object bnRefreshWooCommerce: TDNMSpeedButton
        Left = 170
        Top = 31
        Width = 71
        Height = 24
        Hint = 'Click this button to verify if WooCommerce is enabled'
        HelpContext = 1064075
        Caption = 'Refresh'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Style = bsModern
        TabOrder = 2
        AutoDisableParentOnclick = True
        OnClick = bnRefreshWooCommerceClick
      end
    end
    object pnlShipment: TDNMPanel
      Left = 0
      Top = 50
      Width = 1043
      Height = 131
      HelpContext = 1064077
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      object Bevel10: TBevel
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 1029
        Height = 117
        HelpContext = 1064068
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Align = alClient
        Shape = bsFrame
        ExplicitLeft = 0
        ExplicitTop = 12
        ExplicitWidth = 1051
      end
      object Label16: TLabel
        Left = 14
        Top = 14
        Width = 54
        Height = 15
        HelpContext = 1064069
        Caption = 'Shipment'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object chkTNTEnabled: TwwCheckBox
        Left = 19
        Top = 101
        Width = 333
        Height = 17
        HelpContext = 1064055
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
        Caption = 'Enabled TNT'
        DataField = 'UseTNTFreight'
        DataSource = dsPrefs
        TabOrder = 0
        OnClick = chkTNTEnabledClick
      end
      object chkAllowShipmentsFromSalesOrder: TwwCheckBox
        Left = 19
        Top = 46
        Width = 333
        Height = 17
        HelpContext = 1064079
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
        Caption = 'Allow Processing Shipments from Sales Order'
        DataField = 'AllowShipmentsFromSalesOrder'
        DataSource = dsPrefs
        TabOrder = 1
        OnClick = chkTNTEnabledClick
      end
      object chkAusEParcel: TwwCheckBox
        Left = 19
        Top = 73
        Width = 333
        Height = 17
        HelpContext = 1064091
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
        Caption = 'Enable Australian E-Parcel'
        DataField = 'EnableAusEparcel'
        DataSource = dsPrefs
        TabOrder = 2
      end
    end
    object pnlErpApiConfig: TDNMPanel
      Left = 0
      Top = -331
      Width = 1043
      Height = 117
      HelpContext = 1064097
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      object Bevel11: TBevel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 1035
        Height = 109
        HelpContext = 1064098
        Align = alClient
        Shape = bsFrame
        ExplicitTop = 2
        ExplicitWidth = 1064
      end
      object Label15: TLabel
        Left = 14
        Top = 14
        Width = 78
        Height = 15
        HelpContext = 1064099
        Caption = 'ERP Link / API'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label17: TLabel
        Left = 22
        Top = 47
        Width = 57
        Height = 15
        HelpContext = 1064100
        Caption = 'HTTP Port'
        Transparent = True
      end
      object lblERPLinkNote: TLabel
        Left = 198
        Top = 6
        Width = 334
        Height = 97
        HelpContext = 1064101
        AutoSize = False
        Caption = 'Enabled'
        Transparent = True
        Layout = tlCenter
        Visible = False
        WordWrap = True
      end
      object chkEnableErpApi: TwwCheckBox
        Left = 22
        Top = 77
        Width = 120
        Height = 17
        HelpContext = 1064102
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
        Caption = 'Enabled'
        DataField = 'ErpApiEnabled'
        DataSource = dsPrefs
        TabOrder = 0
        OnClick = chkEnableErpApiClick
      end
      object edtErpApiPort: TDBAdvEdit
        Left = 89
        Top = 44
        Width = 88
        Height = 23
        HelpContext = 1064103
        EditType = etNumeric
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = '0'
        Visible = True
        OnChange = edtErpApiPortChange
        Version = '2.8.6.9'
        DataField = 'ErpApiPort'
        DataSource = dsPrefs
      end
    end
    object pnlModUserUtils: TDNMPanel
      Left = 0
      Top = 181
      Width = 1043
      Height = 161
      HelpContext = 1064093
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 14
      inline ModUserUtilsConfig: TfrModUserUtilsConfigBasic
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 1035
        Height = 153
        HelpContext = 1064094
        Align = alClient
        Color = 16770790
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = 4
        ExplicitTop = 4
        ExplicitWidth = 1035
        ExplicitHeight = 153
        DesignSize = (
          1035
          153)
        inherited Bevel1: TBevel
          Top = 2
          Width = 1029
          Height = 149
          HelpContext = 1064095
          ExplicitTop = 2
          ExplicitWidth = 1051
          ExplicitHeight = 149
        end
        inherited rgLoggingLevel: TwwRadioGroup
          Left = 16
          Top = 44
          ExplicitLeft = 16
          ExplicitTop = 44
        end
        inherited btnShowLog: TDNMSpeedButton
          Left = 939
          ExplicitLeft = 939
        end
        inherited btnLogFile: TDNMSpeedButton
          Left = 939
          ExplicitLeft = 939
        end
        inherited DNMSpeedButton1: TDNMSpeedButton
          Left = 16
          Top = 114
          ExplicitLeft = 16
          ExplicitTop = 114
        end
      end
    end
    object pnlWebAPI: TDNMPanel
      Left = 0
      Top = -214
      Width = 1043
      Height = 264
      HelpContext = 1064036
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 13
      inline ModWebAPIConfig: TfrModWebAPIConfig
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 1035
        Height = 256
        HelpContext = 1064037
        Align = alClient
        Color = 16770790
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = 4
        ExplicitTop = 4
        ExplicitWidth = 1035
        ExplicitHeight = 256
        DesignSize = (
          1035
          256)
        inherited Bevel1: TBevel
          AlignWithMargins = True
          Width = 1028
          Height = 251
          HelpContext = 1064038
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          ExplicitWidth = 1057
          ExplicitHeight = 251
        end
        inherited lblRestartMessage: TLabel
          Left = 197
          Top = 140
          Width = 318
          Height = 74
          HelpContext = 1064092
          ExplicitLeft = 197
          ExplicitTop = 140
          ExplicitWidth = 318
          ExplicitHeight = 74
        end
        inherited btnShowLog: TDNMSpeedButton
          Left = 753
          Top = 222
          ExplicitLeft = 753
          ExplicitTop = 222
        end
        inherited rgLoggingLevel: TwwRadioGroup
          Left = 170
          Width = 332
          HelpContext = 1064039
          ExplicitLeft = 170
          ExplicitWidth = 332
        end
        inherited btnTest: TDNMSpeedButton
          Left = 846
          Top = 222
          ExplicitLeft = 846
          ExplicitTop = 222
        end
        inherited chkUseSSL: TCheckBox
          Left = 22
          Width = 115
          HelpContext = 1064104
          ExplicitLeft = 22
          ExplicitWidth = 115
        end
        inherited chkActive: TCheckBox
          Left = 22
          Width = 115
          HelpContext = 1064105
          OnClick = ModWebAPIConfigchkActiveClick
          ExplicitLeft = 22
          ExplicitWidth = 115
        end
        inherited btnRESTClient: TDNMSpeedButton
          Left = 939
          Top = 222
          ExplicitLeft = 939
          ExplicitTop = 222
        end
        inherited btnLogFile: TDNMSpeedButton
          Left = 939
          Top = 70
          Visible = False
          ExplicitLeft = 939
          ExplicitTop = 70
        end
      end
    end
    object pnlIntegrationSites: TDNMPanel
      Left = 0
      Top = -605
      Width = 1043
      Height = 190
      HelpContext = 1064059
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 11
      DesignSize = (
        1043
        190)
      object Bevel4: TBevel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1034
        Height = 184
        HelpContext = 1064060
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 1063
      end
      object Label4: TLabel
        Left = 14
        Top = 14
        Width = 128
        Height = 15
        HelpContext = 1064061
        Caption = 'Site Integration Config '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object rgSiteStatus: TRadioGroup
        Left = 192
        Top = 14
        Width = 337
        Height = 40
        HelpContext = 1064062
        Caption = ' Show '
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Active'
          'Inactive'
          'Both')
        TabOrder = 0
        OnClick = rgSiteStatusClick
      end
      object lvIntegrationConfig: TListView
        Left = 26
        Top = 60
        Width = 436
        Height = 109
        HelpContext = 1064063
        Columns = <
          item
            AutoSize = True
            Caption = 'Name'
          end
          item
            Caption = 'State'
            Width = 60
          end>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        GridLines = True
        RowSelect = True
        ParentFont = False
        TabOrder = 1
        ViewStyle = vsReport
        OnDblClick = lvIntegrationConfigDblClick
      end
      object btnAddSite: TButton
        Left = 981
        Top = 86
        Width = 49
        Height = 25
        HelpContext = 1064064
        Anchors = [akRight, akBottom]
        Caption = 'Add'
        TabOrder = 2
        OnClick = btnAddSiteClick
      end
      object btnDeleteSite: TButton
        Left = 981
        Top = 148
        Width = 49
        Height = 25
        HelpContext = 1064065
        Anchors = [akRight, akBottom]
        Caption = 'Delete'
        TabOrder = 4
        OnClick = btnDeleteSiteClick
      end
      object btnEditSite: TButton
        Left = 981
        Top = 117
        Width = 49
        Height = 25
        HelpContext = 1064066
        Anchors = [akRight, akBottom]
        Caption = 'Edit'
        TabOrder = 3
        OnClick = btnEditSiteClick
      end
    end
    object pnlEBayInt: TDNMPanel
      Left = 0
      Top = -1488
      Width = 1043
      Height = 342
      HelpContext = 1064044
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 15
      object lblEbayConfig: TLabel
        AlignWithMargins = True
        Left = 12
        Top = 4
        Width = 1027
        Height = 15
        HelpContext = 1064106
        Margins.Left = 11
        Align = alTop
        Caption = 'Ebay Integration is Disabled.  Contact ERP to Enable'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        ExplicitWidth = 290
      end
      inline ModEbayConfig: TfrModEbay
        AlignWithMargins = True
        Left = 4
        Top = 25
        Width = 1035
        Height = 313
        HelpContext = 1064045
        Align = alClient
        Color = 16770790
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = 4
        ExplicitTop = 25
        ExplicitWidth = 1035
        ExplicitHeight = 313
        DesignSize = (
          1035
          313)
        inherited Bevel1: TBevel
          AlignWithMargins = True
          Width = 1030
          Height = 307
          HelpContext = 1064046
          ExplicitWidth = 1059
          ExplicitHeight = 307
        end
        inherited pnlShowEbayonMainMenubyDefault: TDNMPanel
          HelpContext = 1064150
          inherited Shape1: TShape
            ExplicitWidth = 233
            ExplicitHeight = 35
          end
          inherited Label1: TLabel
            Width = 236
            Height = 33
          end
        end
        inherited btnShowLog: TDNMSpeedButton
          Left = 977
          Top = 9
          OnClick = ModEbayConfigbtnShowLogClick
          ExplicitLeft = 977
          ExplicitTop = 9
        end
        inherited btnAddSite: TButton
          Left = 977
          Top = 88
          Anchors = [akTop, akRight]
          OnClick = ModEbayConfigbtnAddSiteClick
          ExplicitLeft = 977
          ExplicitTop = 88
        end
        inherited btnEditSite: TButton
          Left = 977
          Top = 124
          Anchors = [akTop, akRight]
          OnClick = ModEbayConfigbtnEditSiteClick
          ExplicitLeft = 977
          ExplicitTop = 124
        end
        inherited btnDeleteSite: TButton
          Left = 977
          Top = 160
          Anchors = [akTop, akRight]
          ExplicitLeft = 977
          ExplicitTop = 160
        end
        inherited lvIntegrationConfig: TListView
          Left = 11
          Width = 960
          Height = 213
          HelpContext = 1064047
          ExplicitLeft = 11
          ExplicitWidth = 960
          ExplicitHeight = 213
        end
        inherited btnHelp: TDNMSpeedButton
          Left = 977
          Top = 278
          Height = 25
          HelpContext = 1064107
          Anchors = [akRight, akBottom]
          ExplicitLeft = 977
          ExplicitTop = 278
          ExplicitHeight = 25
        end
        inherited btnTestAccount: TDNMSpeedButton
          Left = 277
          ExplicitLeft = 277
        end
        inherited chkShowEbayonMainMenubyDefault: TwwCheckBox
          HelpContext = 1064108
          Caption = 'Show On Main Menu By Default When Enabled'
          OnClick = nil
        end
      end
    end
    object pnlYodlee: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = -1143
      Width = 1037
      Height = 275
      HelpContext = 1064048
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 19
      DesignSize = (
        1037
        275)
      object Bevel16: TBevel
        AlignWithMargins = True
        Left = 4
        Top = 2
        Width = 1066
        Height = 300
        HelpContext = 1064049
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 1068
        ExplicitHeight = 250
      end
      object Label46: TLabel
        AlignWithMargins = True
        Left = 11
        Top = 17
        Width = 141
        Height = 15
        HelpContext = 1064050
        Margins.Left = 10
        Margins.Top = 10
        Caption = 'Yodlee (Bank Integration)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object lbYodlee: TLabel
        Left = 291
        Top = 43
        Width = 209
        Height = 15
        HelpContext = 504027
        Caption = 'Please contact ERP to enable Yodlee.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object wwYodleeEnabled: TwwCheckBox
        Left = 14
        Top = 43
        Width = 110
        Height = 17
        HelpContext = 1064016
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'True'
        ValueUnchecked = 'False'
        DisplayValueChecked = 'True'
        DisplayValueUnchecked = 'False'
        NullAndBlankState = cbUnchecked
        Caption = 'Yodlee Enabled'
        DataField = 'YodleeEnabled'
        DataSource = dsPrefs
        Enabled = False
        TabOrder = 0
      end
      object pnlYodleeControls: TDNMPanel
        Left = 1
        Top = 74
        Width = 1035
        Height = 200
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        object dbgYodlee: TwwDBGrid
          AlignWithMargins = True
          Left = 4
          Top = 51
          Width = 1027
          Height = 145
          HelpContext = 1064021
          ControlType.Strings = (
            'Active;CheckBox;T;F'
            'SourceID;CustomEdit;;F'
            'Sourcename;CustomEdit;cbosource;F'
            'isDefaultSource;CheckBox;T;F'
            'YodleeAccountId;CustomEdit;wwdbYodleeAccounts;F')
          Selected.Strings = (
            'TrueERPAccountNumber'#9'13'#9'ERP~Account Number'
            'TrueERPAccountName'#9'22'#9'ERP~Account Name'
            'YodleeAccountId'#9'12'#9'Yodlee~Account Id'
            'YodleeProviderName'#9'21'#9'Yodlee~Provider Name')
          IniAttributes.Delimiter = ';;'
          TitleColor = clWhite
          FixedCols = 0
          ShowHorzScrollBar = True
          EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
          Align = alClient
          Color = clWhite
          DataSource = dsYodlee
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          KeyOptions = []
          ParentFont = False
          TabOrder = 0
          TitleAlignment = taCenter
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Arial'
          TitleFont.Style = [fsBold]
          TitleLines = 2
          TitleButtons = False
          FooterColor = clWhite
        end
        object pnlYodleeButtons: TDNMPanel
          AlignWithMargins = True
          Left = 4
          Top = 4
          Width = 1027
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 1
          object bnLinkAccounts: TDNMSpeedButton
            Left = 12
            Top = 7
            Width = 157
            Height = 27
            Hint = 
              'Click this button to refresh your list of  bank accounts to be l' +
              'inked up'
            HelpContext = 1064075
            Caption = 'Refresh Yodlee Accounts'
            DisableTransparent = False
            Enabled = False
            HotTrackFont.Charset = DEFAULT_CHARSET
            HotTrackFont.Color = clWindowText
            HotTrackFont.Height = -11
            HotTrackFont.Name = 'MS Sans Serif'
            HotTrackFont.Style = []
            Style = bsModern
            TabOrder = 0
            AutoDisableParentOnclick = True
            OnClick = bnLinkAccountsClick
          end
          object wwBankReconRemember: TwwCheckBox
            Left = 193
            Top = 13
            Width = 352
            Height = 17
            HelpContext = 1064149
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
            Caption = 'Remember Bank Reconciliation Deposit/Payment Details'
            DataField = 'RememberLastReconDeposit'
            DataSource = dsPrefs
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            Visible = False
          end
        end
      end
      object wwdbYodleeAccounts: TwwDBLookupCombo
        Left = 592
        Top = 72
        Width = 217
        Height = 23
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'YodleeAccountId'#9'15'#9'Yodlee Account ID'#9'F'
          'YodleeProviderName'#9'30'#9'Yodlee Provider Name'#9'F')
        DataField = 'YodleeAccountId'
        DataSource = dsYodlee
        LookupTable = kbmYodleeAccounts
        LookupField = 'YodleeAccountId'
        Options = [loColLines, loRowLines, loTitles]
        Style = csDropDownList
        TabOrder = 2
        AutoDropDown = False
        ShowButton = True
        SeqSearchOptions = []
        PreciseEditRegion = False
        AllowClearKey = True
      end
      object bnYodleeCheck: TDNMSpeedButton
        Left = 133
        Top = 36
        Width = 150
        Height = 27
        Hint = 'Click this button to verify Yodlee Credentials'
        HelpContext = 1064075
        Caption = 'Verify Yodlee Credentials'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Style = bsModern
        TabOrder = 3
        AutoDisableParentOnclick = True
        OnClick = bnYodleeCheckClick
      end
    end
    object pnlCoreEDIService: TDNMPanel
      Left = 0
      Top = -2837
      Width = 1043
      Height = 200
      HelpContext = 1064048
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 18
      DesignSize = (
        1043
        200)
      object Bevel15: TBevel
        AlignWithMargins = True
        Left = 4
        Top = 6
        Width = 1053
        Height = 189
        HelpContext = 1064049
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 1063
        ExplicitHeight = 117
      end
      object Label39: TLabel
        Left = 14
        Top = 14
        Width = 94
        Height = 15
        HelpContext = 1064050
        Caption = 'Core EDI Service'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label40: TLabel
        Left = 18
        Top = 41
        Width = 87
        Height = 30
        HelpContext = 1064052
        Caption = 'User Name / Company Email'
        Transparent = True
        WordWrap = True
      end
      object Label41: TLabel
        Left = 48
        Top = 96
        Width = 58
        Height = 15
        HelpContext = 1064053
        Caption = 'Password'
        Transparent = True
      end
      object CoreEDIServiceHint: TLabel
        Left = 342
        Top = 95
        Width = 170
        Height = 15
        HelpContext = 504027
        Caption = '(Password is  Case-Sensitive)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label45: TLabel
        Left = 82
        Top = 169
        Width = 24
        Height = 15
        HelpContext = 1064139
        Alignment = taRightJustify
        Caption = 'Port'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label42: TLabel
        Left = 80
        Top = 134
        Width = 26
        Height = 15
        HelpContext = 1064053
        Caption = 'Host'
        Transparent = True
      end
      object CompanyEmailLabel: TLabel
        Left = 115
        Top = 70
        Width = 206
        Height = 15
        HelpContext = 1064050
        Caption = 'Click here to Change Company Email'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsUnderline]
        ParentFont = False
        Transparent = True
        OnClick = CompanyEmailLabelClick
      end
      object edtCoreEDIServiceUserName: TEdit
        Left = 116
        Top = 45
        Width = 212
        Height = 23
        HelpContext = 1064144
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
      end
      object edtCoreEDIServicePassword: TwwDBEdit
        Left = 115
        Top = 92
        Width = 212
        Height = 23
        HelpContext = 1064144
        DataField = 'CoreEDIServicePassword'
        DataSource = dsPrefs
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
      object pnlCoreEDIServiceCredentials: TPanel
        AlignWithMargins = True
        Left = 883
        Top = 31
        Width = 137
        Height = 123
        Margins.Left = 0
        Margins.Top = 30
        Margins.Right = 22
        Margins.Bottom = 45
        Align = alRight
        BevelEdges = [beRight, beBottom]
        BevelOuter = bvNone
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        object Label43: TLabel
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 135
          Height = 88
          Cursor = crHandPoint
          HelpContext = 1686005
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Align = alClient
          Alignment = taCenter
          Caption = 'Please contact CoreEDI for Username and Password'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          Layout = tlCenter
          WordWrap = True
          OnMouseDown = lblcoreEDiCredentilsHintMouseDown
          ExplicitWidth = 133
          ExplicitHeight = 45
        end
        object Label44: TLabel
          AlignWithMargins = True
          Left = 1
          Top = 92
          Width = 135
          Height = 30
          Cursor = crHandPoint
          HelpContext = 1686005
          Margins.Left = 1
          Margins.Top = 0
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alBottom
          Alignment = taCenter
          AutoSize = False
          Caption = '( CTRL + Left Click to Send Email to CoreEDI)'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = False
          WordWrap = True
          ExplicitTop = 55
        end
      end
      object btnTestCoreEDIService: TDNMSpeedButton
        Left = 120
        Top = 11
        Width = 208
        Height = 27
        HelpContext = 1064075
        Caption = 'Test CoreEDI Service Connection'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Style = bsModern
        TabOrder = 3
        AutoDisableParentOnclick = True
        OnClick = btnTestCoreEDIServiceClick
      end
      object spCoreEDIServicePort: TwwDBSpinEdit
        Left = 115
        Top = 166
        Width = 85
        Height = 23
        Increment = 1.000000000000000000
        DataField = 'CoreEDIServicePort'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        UnboundDataType = wwDefault
      end
      object edtCoreEDIServiceHost: TwwDBEdit
        Left = 115
        Top = 130
        Width = 212
        Height = 23
        HelpContext = 1064144
        DataField = 'CoreEDIServiceHost'
        DataSource = dsPrefs
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
    end
    object pnlCyTrackIntegration: TDNMPanel
      Left = 0
      Top = -415
      Width = 1043
      Height = 84
      HelpContext = 1064031
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 12
      DesignSize = (
        1043
        84)
      object Bevel7: TBevel
        Left = 3
        Top = 3
        Width = 1035
        Height = 78
        HelpContext = 1064032
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 1064
      end
      object Label5: TLabel
        Left = 14
        Top = 14
        Width = 110
        Height = 15
        HelpContext = 1064033
        Caption = 'CyTrack Integration'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label6: TLabel
        Left = 48
        Top = 42
        Width = 161
        Height = 15
        HelpContext = 1064034
        Caption = 'CyTrack Integration  Enabled'
        Transparent = True
      end
      object chkCyTrackIntegrationEnabled: TwwCheckBox
        Left = 26
        Top = 41
        Width = 16
        Height = 17
        HelpContext = 1064035
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
        DataField = 'CyTrackIntegrationEnabled'
        DataSource = dsPrefs
        TabOrder = 0
        OnClick = chkSiteIntegrationEnabledClick
      end
    end
    object pnlSiteIntegration: TDNMPanel
      Left = 0
      Top = -716
      Width = 1043
      Height = 111
      HelpContext = 1064011
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      DesignSize = (
        1043
        111)
      object Bevel3: TBevel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1034
        Height = 105
        HelpContext = 1064012
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 1063
      end
      object Label3: TLabel
        Left = 14
        Top = 14
        Width = 86
        Height = 15
        HelpContext = 1064013
        Caption = 'Site Integration'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object lblSiteIntegrationEnabled: TLabel
        Left = 48
        Top = 42
        Width = 137
        Height = 15
        HelpContext = 1064014
        Caption = 'Site Integration  Enabled'
        Transparent = True
      end
      object lblSiteIntegrationVersion: TLabel
        Left = 26
        Top = 80
        Width = 87
        Height = 15
        HelpContext = 1064015
        Caption = 'Module Version'
      end
      object chkSiteIntegrationEnabled: TwwCheckBox
        Left = 26
        Top = 41
        Width = 16
        Height = 17
        HelpContext = 1064016
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
        TabOrder = 0
        OnClick = chkSiteIntegrationEnabledClick
      end
      object rgSiteIntegrationLoggingLevel: TRadioGroup
        Left = 219
        Top = 26
        Width = 302
        Height = 48
        HelpContext = 1064017
        Caption = ' Logging Level '
        Columns = 4
        ItemIndex = 0
        Items.Strings = (
          'Error'
          'Warning'
          'Info'
          'Detail')
        TabOrder = 1
        OnClick = rgSiteIntegrationLoggingLevelClick
      end
    end
    object pnpGoolgeProfileSources: TDNMPanel
      Left = 0
      Top = -865
      Width = 1043
      Height = 149
      HelpContext = 1064018
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 9
      DesignSize = (
        1043
        149)
      object Bevel6: TBevel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1034
        Height = 143
        HelpContext = 1064019
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 1063
      end
      object lblsources: TLabel
        Left = 14
        Top = 14
        Width = 144
        Height = 15
        HelpContext = 1064020
        Caption = 'Google Profiles - Sources'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object grdgoogleProfilesources: TwwDBGrid
        Left = 14
        Top = 35
        Width = 515
        Height = 97
        HelpContext = 1064021
        ControlType.Strings = (
          'Active;CheckBox;T;F'
          'SourceID;CustomEdit;;F'
          'Sourcename;CustomEdit;cbosource;F'
          'isDefaultSource;CheckBox;T;F')
        Selected.Strings = (
          'Sourcename'#9'45'#9'Sourcename'#9'F'
          'Active'#9'1'#9'Active'#9#9
          'isDefaultSource'#9'1'#9'Is Default Source?'#9'F'#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
        Anchors = [akLeft, akTop, akBottom]
        Color = clWhite
        DataSource = dsgaProfilesource
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = [dgAllowInsert]
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        FooterColor = clWhite
      end
      object cbosource: TwwDBLookupCombo
        Left = 136
        Top = 72
        Width = 121
        Height = 23
        HelpContext = 1064022
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'mediatype'#9'50'#9'mediatype'#9'F')
        DataField = 'Sourcename'
        DataSource = dsgaProfilesource
        LookupTable = Qrysource
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = cbosourceCloseUp
      end
    end
    object pnlGoogleProfiles: TDNMPanel
      Left = 0
      Top = -1669
      Width = 1043
      Height = 181
      HelpContext = 1064040
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      DesignSize = (
        1043
        181)
      object Bevel2: TBevel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1035
        Height = 175
        HelpContext = 1064041
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 1064
      end
      object lblProfile: TLabel
        Left = 14
        Top = 14
        Width = 86
        Height = 15
        HelpContext = 1064042
        Caption = 'Google Profiles'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object grdProfiles: TwwDBGrid
        Left = 14
        Top = 36
        Width = 1014
        Height = 127
        HelpContext = 1064043
        ControlType.Strings = (
          'Active;CheckBox;T;F')
        Selected.Strings = (
          'Title'#9'39'#9'Title'#9'T'
          'TimeZone'#9'22'#9'Time Zone'#9'T'#9
          'Active'#9'1'#9'Active'#9#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Anchors = [akLeft, akTop, akRight, akBottom]
        Color = clWhite
        DataSource = dsGaProfiles
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = []
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        FooterColor = clWhite
      end
    end
    object pnlGoogleAccounts: TDNMPanel
      Left = 0
      Top = -2215
      Width = 1043
      Height = 251
      HelpContext = 1064023
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
      DesignSize = (
        1043
        251)
      object Bevel5: TBevel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1035
        Height = 245
        HelpContext = 1064024
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 1064
      end
      object Label9: TLabel
        Left = 14
        Top = 14
        Width = 96
        Height = 15
        HelpContext = 1064025
        Caption = 'Google Accounts'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label2: TLabel
        Left = 15
        Top = 43
        Width = 226
        Height = 15
        HelpContext = 1064026
        Caption = 'Supplier for Auto Posting of Google Cost'
        Transparent = True
      end
      object grdGaAccounts: TwwDBGrid
        Left = 15
        Top = 123
        Width = 515
        Height = 113
        HelpContext = 1064027
        ControlType.Strings = (
          'Active;CheckBox;T;F'
          'ERPAccountName;CustomEdit;cboAccountName;F')
        Selected.Strings = (
          'AccountName'#9'20'#9'Account Name'#9'T'
          'EmailAddress'#9'21'#9'Email Address'#9'T'
          'ERPAccountName'#9'20'#9'ERP Account Name'#9'F'
          'Active'#9'1'#9'Active'#9'T'#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clWhite
        FixedCols = 0
        ShowHorzScrollBar = True
        Color = clWhite
        DataSource = dsGaAccounts
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        KeyOptions = [dgAllowInsert]
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Arial'
        TitleFont.Style = [fsBold]
        TitleLines = 1
        TitleButtons = False
        OnDblClick = grdGaAccountsDblClick
        FooterColor = clWhite
      end
      object rgFilter: TRadioGroup
        Left = 15
        Top = 77
        Width = 515
        Height = 40
        HelpContext = 1064028
        Caption = ' Show '
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          'Active'
          'Inactive'
          'Both')
        TabOrder = 1
        OnClick = rgFilterClick
      end
      object wwDBLookupCombo1: TwwDBLookupCombo
        Left = 247
        Top = 40
        Width = 283
        Height = 23
        HelpContext = 1064029
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'company'#9'30'#9'company'#9'F')
        DataField = 'SupplierforautoPostingGoogle'
        DataSource = dsPrefs
        LookupTable = qrySupplier
        LookupField = 'company'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 2
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
      end
      object cboAccountName: TwwDBLookupCombo
        Left = 227
        Top = 184
        Width = 283
        Height = 23
        HelpContext = 1064030
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'AccountName'#9'25'#9'Account Name'#9'F')
        DataField = 'ERPAccountName'
        DataSource = dsGaAccounts
        LookupTable = QryAccount
        LookupField = 'AccountName'
        Style = csDropDownList
        ParentFont = False
        TabOrder = 3
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = cboAccountNameCloseUp
      end
    end
    object pnlGoogleCalendar: TDNMPanel
      Left = 0
      Top = -1964
      Width = 1043
      Height = 195
      HelpContext = 1064067
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      DesignSize = (
        1043
        195)
      object Bevel9: TBevel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1036
        Height = 189
        HelpContext = 1064080
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 1058
      end
      object Label12: TLabel
        Left = 14
        Top = 76
        Width = 136
        Height = 15
        HelpContext = 1064081
        Caption = 'Master Google Calendar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label14: TLabel
        Left = 23
        Top = 111
        Width = 82
        Height = 15
        HelpContext = 1064070
        Caption = 'Email Address'
        Transparent = True
      end
      object Label18: TLabel
        Left = 14
        Top = 15
        Width = 188
        Height = 15
        HelpContext = 1064082
        Caption = 'Google Calendar Synchronisation'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object lblSynchWithGoogleCalendar: TLabel
        Left = 179
        Top = 42
        Width = 161
        Height = 15
        HelpContext = 1064084
        Caption = 'lblSynchWithGoogleCalendar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object edtGoogleEmail: TEdit
        Left = 143
        Top = 109
        Width = 373
        Height = 23
        HelpContext = 1064073
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        OnChange = edtGoogleEmailChange
        OnExit = edtGoogleEmailExit
      end
      object btnGoogleTest: TDNMSpeedButton
        Left = 407
        Top = 147
        Width = 87
        Height = 27
        HelpContext = 1064075
        Anchors = [akTop, akRight]
        Caption = 'Test'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Style = bsModern
        TabOrder = 1
        AutoDisableParentOnclick = True
        OnClick = btnGoogleTestClick
      end
      object chkSynchWithGoogle: TwwCheckBox
        Left = 26
        Top = 147
        Width = 134
        Height = 17
        HelpContext = 1064076
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Caption = 'Synch with Google'
        DataField = 'SynchWithGoogle'
        TabOrder = 2
        OnClick = chkSynchWithGoogleClick
      end
      object chkSynchWithGoogleCalendar: TwwCheckBox
        Left = 23
        Top = 41
        Width = 137
        Height = 17
        HelpContext = 1064085
        DisableThemes = False
        AlwaysTransparent = False
        ValueChecked = 'T'
        ValueUnchecked = 'F'
        DisplayValueChecked = 'T'
        DisplayValueUnchecked = 'F'
        NullAndBlankState = cbUnchecked
        Alignment = taLeftJustify
        Caption = 'Synch with Google'
        DataField = 'SynchWithGoogle'
        TabOrder = 3
        OnClick = chkSynchWithGoogleCalendarClick
      end
    end
    object pnlGoogleAnalytics: TDNMPanel
      Left = 0
      Top = -1769
      Width = 1043
      Height = 100
      HelpContext = 1064004
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      object lblAnalyticsModuleVersion: TLabel
        Left = 14
        Top = 78
        Width = 142
        Height = 15
        HelpContext = 1064109
        Caption = 'Analytics Module Version'
      end
      inline ModGoogleConfig: TfrModGoogleConfig
        Left = -2
        Top = 1
        Width = 546
        Height = 74
        HelpContext = 1064110
        Color = 16770790
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentBackground = False
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        ExplicitLeft = -2
        ExplicitTop = 1
        ExplicitWidth = 546
        ExplicitHeight = 74
        DesignSize = (
          546
          74)
        inherited Bevel1: TBevel
          Width = 540
          Height = 69
          HelpContext = 1064111
          ExplicitWidth = 538
          ExplicitHeight = 69
        end
        inherited rgLoggingLevel: TwwRadioGroup
          Left = 115
          Width = 347
          HelpContext = 1064112
          ExplicitLeft = 115
          ExplicitWidth = 347
        end
        inherited btnShowLog: TDNMSpeedButton
          Left = 475
          Top = 12
          Width = 57
          HelpContext = 1064113
          Visible = False
          ExplicitLeft = 475
          ExplicitTop = 12
          ExplicitWidth = 57
        end
        inherited chkActive: TwwCheckBox
          Width = 76
          HelpContext = 1064114
          ExplicitWidth = 76
        end
      end
    end
    object pnlSMSConfig: TDNMPanel
      Left = 0
      Top = -2332
      Width = 1043
      Height = 117
      HelpContext = 1064048
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      DesignSize = (
        1043
        117)
      object Bevel8: TBevel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 1036
        Height = 111
        HelpContext = 1064049
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 1065
      end
      object Label7: TLabel
        Left = 14
        Top = 14
        Width = 26
        Height = 15
        HelpContext = 1064050
        Caption = 'SMS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label8: TLabel
        Left = 41
        Top = 47
        Width = 74
        Height = 15
        HelpContext = 1064086
        Caption = 'SMS Enabled'
        Transparent = True
      end
      object Label10: TLabel
        Left = 154
        Top = 17
        Width = 63
        Height = 15
        HelpContext = 1064052
        Caption = 'User Name'
        Transparent = True
      end
      object Label11: TLabel
        Left = 159
        Top = 46
        Width = 58
        Height = 15
        HelpContext = 1064053
        Caption = 'Password'
        Transparent = True
      end
      object Label20: TLabel
        Left = 133
        Top = 75
        Width = 84
        Height = 15
        HelpContext = 1064054
        Caption = 'Phone Number'
        Transparent = True
      end
      object lblSMSEnabled: TLabel
        Left = 21
        Top = 68
        Width = 106
        Height = 32
        HelpContext = 1064087
        AutoSize = False
        Caption = 'lblSMSEnabled'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object chkSMSEnabled: TwwCheckBox
        Left = 19
        Top = 46
        Width = 16
        Height = 17
        HelpContext = 1064088
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
        TabOrder = 0
        OnClick = chkSMSEnabledClick
      end
      object edtSMSUserName: TEdit
        Left = 247
        Top = 15
        Width = 274
        Height = 23
        HelpContext = 1064056
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = edtSMSUserNameChange
      end
      object edtSMSPassword: TEdit
        Left = 247
        Top = 44
        Width = 274
        Height = 23
        HelpContext = 1064057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 2
        OnChange = edtSMSPasswordChange
      end
      object edtPhoneNumber: TEdit
        Left = 247
        Top = 73
        Width = 274
        Height = 23
        HelpContext = 1064058
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnChange = edtPhoneNumberChange
      end
      object btnSMSrates: TDNMSpeedButton
        Left = 61
        Top = 11
        Width = 79
        Height = 23
        HelpContext = 1064089
        Caption = 'SMS Rates'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        TabOrder = 4
        AutoDisableParentOnclick = True
        OnClick = btnSMSratesClick
      end
    end
    object pnlWalmartOptions: TDNMPanel
      Left = 0
      Top = 466
      Width = 1043
      Height = 200
      HelpContext = 1064115
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 16
      DesignSize = (
        1043
        200)
      object Bevel12: TBevel
        Left = 3
        Top = 11
        Width = 1029
        Height = 189
        HelpContext = 1064116
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 1058
        ExplicitHeight = 566
      end
      object Label13: TLabel
        Left = 43
        Top = 76
        Width = 111
        Height = 15
        HelpContext = 1064117
        Alignment = taRightJustify
        Caption = 'Walmart Customer '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label19: TLabel
        Left = 29
        Top = 107
        Width = 125
        Height = 15
        HelpContext = 1064118
        Alignment = taRightJustify
        Caption = 'Walmart Consumer ID'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label21: TLabel
        Left = 14
        Top = 14
        Width = 49
        Height = 15
        HelpContext = 1064119
        Caption = 'Walmart'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label22: TLabel
        Left = 38
        Top = 138
        Width = 116
        Height = 15
        HelpContext = 1064120
        Alignment = taRightJustify
        Caption = 'Walmart Private Key'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label23: TLabel
        Left = 17
        Top = 290
        Width = 137
        Height = 15
        HelpContext = 1064121
        Alignment = taRightJustify
        Caption = 'WALMART Channel Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label24: TLabel
        Left = 40
        Top = 345
        Width = 110
        Height = 30
        HelpContext = 1064122
        Alignment = taRightJustify
        Caption = 'ERP Product Name on Walmart '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object chkEnableWalmart: TwwCheckBox
        Left = 59
        Top = 45
        Width = 125
        Height = 17
        HelpContext = 1064123
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
        Alignment = taLeftJustify
        Caption = 'Enable Walmart'
        DataField = 'EnableWalmart'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        OnClick = chkEnableWalmartClick
      end
      object cboWalmartcustomer: TwwDBLookupCombo
        Left = 169
        Top = 72
        Width = 198
        Height = 23
        HelpContext = 1064124
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        DropDownAlignment = taLeftJustify
        Selected.Strings = (
          'company'#9'50'#9'company'#9'F')
        DataField = 'Walmartcustomer'
        DataSource = dsPrefs
        LookupTable = qryCustomers
        LookupField = 'company'
        ParentFont = False
        TabOrder = 0
        AutoDropDown = True
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = cbosourceCloseUp
      end
      object memWALMART_PrivateKey: TDBMemo
        Left = 169
        Top = 136
        Width = 350
        Height = 136
        HelpContext = 1064125
        DataField = 'WALMART_PrivateKey'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
      end
      object EDTWALMART_ConsumerId: TwwDBEdit
        Left = 169
        Top = 103
        Width = 350
        Height = 23
        HelpContext = 1064126
        DataField = 'WALMART_ConsumerId'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 8
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnChange = edtErpApiPortChange
      end
      object EDTWALMART_ChannelType: TwwDBEdit
        Left = 169
        Top = 286
        Width = 350
        Height = 23
        HelpContext = 1064127
        DataField = 'WALMART_ChannelType'
        DataSource = dsPrefs
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
        OnChange = edtErpApiPortChange
      end
      object optWALMART_ProductNameField: TDBRadioGroup
        Left = 169
        Top = 320
        Width = 347
        Height = 76
        HelpContext = 1064128
        DataField = 'WALMART_ProductNameField'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Items.Strings = (
          'Product Name'
          'SKU (Stock Keeping Unit)')
        ParentBackground = True
        ParentFont = False
        TabOrder = 2
        Values.Strings = (
          'P'
          'S')
      end
      object chk_AutocheckforOrdersinList: TwwCheckBox
        Left = 167
        Top = 407
        Width = 339
        Height = 17
        HelpContext = 1064129
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
        Caption = 'Auto Check for Orders in List'
        DataField = 'WALMART_AutocheckforOrdersinList'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 11
      end
      object chk_WALMART_AutoUpdateProductQty: TwwCheckBox
        Left = 167
        Top = 475
        Width = 314
        Height = 17
        HelpContext = 1064130
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
        Caption = 'Update Walmart Inventory After Orders Check'
        DataField = 'WALMART_AutoUpdateProductQty'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 10
      end
      object chk_WALMART_IgnoreTaxonSale: TwwCheckBox
        Left = 167
        Top = 441
        Width = 314
        Height = 17
        HelpContext = 1064131
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
        Caption = 'Ignore Tax on Sales(Walmart Pays the Tax)'
        DataField = 'WALMART_IgnoreTaxonSale'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object wwCheckBox2: TwwCheckBox
        Left = 167
        Top = 510
        Width = 343
        Height = 17
        HelpContext = 1064132
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
        Caption = 'Creating ERP Order, Creates and Process Shipment '
        DataField = 'WALMARTOrderSilentProcessShipment'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object chkShowWalmartonMainmenubyDefault: TwwCheckBox
        Left = 231
        Top = 45
        Width = 288
        Height = 17
        HelpContext = 1064133
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
        Alignment = taLeftJustify
        Caption = 'Show On Main Menu By Default When Enabled'
        DataField = 'ShowWalmartonMainmenubyDefault'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
      end
      object chkWalmart_EnableInvFeed: TwwCheckBox
        Left = 167
        Top = 545
        Width = 343
        Height = 17
        HelpContext = 1064134
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
        Caption = 'Walmart Inventory Updated From this Database '
        DataField = 'Walmart_EnableInvFeed'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
      end
    end
    object pnlCoreEDI: TDNMPanel
      Left = 0
      Top = -2460
      Width = 1043
      Height = 128
      HelpContext = 1064048
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      DesignSize = (
        1043
        128)
      object Bevel13: TBevel
        AlignWithMargins = True
        Left = 4
        Top = 6
        Width = 1034
        Height = 117
        HelpContext = 1064049
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 1063
      end
      object Label29: TLabel
        Left = 14
        Top = 14
        Width = 45
        Height = 15
        HelpContext = 1064050
        Caption = 'CoreEDI'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label30: TLabel
        Left = 43
        Top = 46
        Width = 63
        Height = 15
        HelpContext = 1064052
        Caption = 'User Name'
        Transparent = True
      end
      object Label31: TLabel
        Left = 48
        Top = 78
        Width = 58
        Height = 15
        HelpContext = 1064053
        Caption = 'Password'
        Transparent = True
      end
      object Label32: TLabel
        Left = 116
        Top = 103
        Width = 257
        Height = 15
        HelpContext = 504027
        Caption = '(User Name and Password is Case-Sensitive)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtCoreEDIUSerName: TwwDBEdit
        Left = 116
        Top = 45
        Width = 257
        Height = 23
        HelpContext = 1064144
        DataField = 'CoreEDIUSerName'
        DataSource = dsPrefs
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
      object edtCoreEDIPassword: TwwDBEdit
        Left = 115
        Top = 74
        Width = 257
        Height = 23
        HelpContext = 1064144
        DataField = 'CoreEDIPassword'
        DataSource = dsPrefs
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
        OnChange = edtErpApiPortChange
      end
      object pnlcoreEDiCredentilsHint: TPanel
        AlignWithMargins = True
        Left = 883
        Top = 31
        Width = 137
        Height = 85
        Margins.Left = 0
        Margins.Top = 30
        Margins.Right = 22
        Margins.Bottom = 11
        Align = alRight
        BevelEdges = [beRight, beBottom]
        BevelOuter = bvNone
        Color = clBlack
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        object lblcoreEDiCredentilsHint: TLabel
          AlignWithMargins = True
          Left = 1
          Top = 1
          Width = 135
          Height = 50
          Cursor = crHandPoint
          HelpContext = 1686005
          Margins.Left = 1
          Margins.Top = 1
          Margins.Right = 1
          Align = alClient
          Alignment = taCenter
          Caption = 'Please contact CoreEDI for Username and Password'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          Layout = tlCenter
          WordWrap = True
          OnMouseDown = lblcoreEDiCredentilsHintMouseDown
          ExplicitWidth = 133
          ExplicitHeight = 45
        end
        object lblHintAvalaraLink: TLabel
          AlignWithMargins = True
          Left = 1
          Top = 54
          Width = 135
          Height = 30
          Cursor = crHandPoint
          HelpContext = 1686005
          Margins.Left = 1
          Margins.Top = 0
          Margins.Right = 1
          Margins.Bottom = 1
          Align = alBottom
          Alignment = taCenter
          AutoSize = False
          Caption = '( CTRL + Left Click to Send Email to CoreEDI)'
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          Transparent = False
          WordWrap = True
          ExplicitTop = 55
        end
      end
      object btnTestCoreEDI: TDNMSpeedButton
        Left = 219
        Top = 12
        Width = 154
        Height = 27
        HelpContext = 1064075
        Caption = 'Test CoreEDI Connection'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Style = bsModern
        TabOrder = 3
        AutoDisableParentOnclick = True
        OnClick = btnTestCoreEDIClick
      end
    end
    object pnlCloneDatabase: TDNMPanel
      Left = 0
      Top = -2637
      Width = 1043
      Height = 177
      HelpContext = 1064135
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      DesignSize = (
        1043
        177)
      object Bevel14: TBevel
        Left = 6
        Top = 7
        Width = 1034
        Height = 165
        HelpContext = 1064136
        Margins.Left = 6
        Margins.Top = 6
        Margins.Right = 6
        Margins.Bottom = 6
        Anchors = [akLeft, akTop, akRight, akBottom]
        Shape = bsFrame
        ExplicitWidth = 1036
        ExplicitHeight = 238
      end
      object Label33: TLabel
        Left = 14
        Top = 14
        Width = 137
        Height = 15
        HelpContext = 1064137
        Caption = 'NonERP Clone Database'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label36: TLabel
        Left = 41
        Top = 50
        Width = 63
        Height = 15
        HelpContext = 1064140
        Alignment = taRightJustify
        Caption = 'User Name'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label38: TLabel
        Left = 49
        Top = 92
        Width = 58
        Height = 15
        HelpContext = 1064140
        Alignment = taRightJustify
        Caption = 'Password'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label34: TLabel
        Left = 275
        Top = 50
        Width = 243
        Height = 15
        HelpContext = 504027
        Caption = '(User Name is "TrueERP" When Left Blank)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object Label35: TLabel
        Left = 275
        Top = 92
        Width = 238
        Height = 15
        HelpContext = 504027
        Caption = '(Password is "TrueERP" When Left Blank)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edtUser: TwwDBEdit
        Left = 116
        Top = 46
        Width = 150
        Height = 23
        HelpContext = 1064146
        DataField = 'NonERPClone_User'
        DataSource = dsPrefs
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
        OnChange = edtErpApiPortChange
      end
      object wwCheckBox4: TwwCheckBox
        Left = 120
        Top = 130
        Width = 255
        Height = 17
        HelpContext = 1064149
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
        Caption = 'Enable NonERP clone After Restart'
        DataField = 'NonERPCloneAfterRestart'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      object edtPass: TwwDBEdit
        Left = 116
        Top = 88
        Width = 150
        Height = 23
        HelpContext = 1064146
        DataField = 'NonERPClone_Password'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 1
        UnboundDataType = wwDefault
        WantReturns = False
        WordWrap = False
        OnChange = edtErpApiPortChange
      end
      object btnHelp: TDNMSpeedButton
        Left = 381
        Top = 125
        Width = 49
        Height = 27
        Caption = 'Help'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Style = bsModern
        TabOrder = 3
        AutoDisableParentOnclick = True
        OnClick = btnHelpClick
      end
    end
    object pnlMagento: TDNMPanel
      Left = 0
      Top = 336
      Width = 1043
      Height = 130
      HelpContext = 1064115
      Align = alBottom
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 20
      object Bevel17: TBevel
        Left = 1
        Top = 10
        Width = 1043
        Height = 116
        HelpContext = 1064116
        Shape = bsFrame
      end
      object Label49: TLabel
        AlignWithMargins = True
        Left = 14
        Top = 14
        Width = 49
        Height = 15
        HelpContext = 1064119
        Caption = 'Magento'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsUnderline]
        ParentFont = False
        Transparent = True
      end
      object Label51: TLabel
        Left = 17
        Top = 290
        Width = 137
        Height = 15
        HelpContext = 1064121
        Alignment = taRightJustify
        Caption = 'WALMART Channel Type'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label52: TLabel
        Left = 40
        Top = 345
        Width = 110
        Height = 30
        HelpContext = 1064122
        Alignment = taRightJustify
        Caption = 'ERP Product Name on Walmart '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object lbMagento: TLabel
        Left = 228
        Top = 35
        Width = 221
        Height = 15
        HelpContext = 504027
        Caption = 'Please contact ERP to enable Magento.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object wwCheckBoxMagento: TwwCheckBox
        Left = 13
        Top = 35
        Width = 125
        Height = 17
        HelpContext = 1064123
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
        Alignment = taLeftJustify
        Caption = 'Enable Magento'
        DataField = 'MagentoEnabled'
        DataSource = dsPrefs
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 5
      end
      object wwDBEdit2: TwwDBEdit
        Left = 169
        Top = 286
        Width = 350
        Height = 23
        HelpContext = 1064127
        DataField = 'WALMART_ChannelType'
        DataSource = dsPrefs
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
        OnChange = edtErpApiPortChange
      end
      object DBRadioGroup1: TDBRadioGroup
        Left = 169
        Top = 320
        Width = 347
        Height = 76
        HelpContext = 1064128
        DataField = 'WALMART_ProductNameField'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Items.Strings = (
          'Product Name'
          'SKU (Stock Keeping Unit)')
        ParentBackground = True
        ParentFont = False
        TabOrder = 1
        Values.Strings = (
          'P'
          'S')
      end
      object wwCheckBox3: TwwCheckBox
        Left = 167
        Top = 407
        Width = 339
        Height = 17
        HelpContext = 1064129
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
        Caption = 'Auto Check for Orders in List'
        DataField = 'WALMART_AutocheckforOrdersinList'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
      end
      object wwCheckBox5: TwwCheckBox
        Left = 167
        Top = 475
        Width = 314
        Height = 17
        HelpContext = 1064130
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
        Caption = 'Update Walmart Inventory After Orders Check'
        DataField = 'WALMART_AutoUpdateProductQty'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
      end
      object wwCheckBox6: TwwCheckBox
        Left = 167
        Top = 441
        Width = 314
        Height = 17
        HelpContext = 1064131
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
        Caption = 'Ignore Tax on Sales(Walmart Pays the Tax)'
        DataField = 'WALMART_IgnoreTaxonSale'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      object wwCheckBox7: TwwCheckBox
        Left = 167
        Top = 510
        Width = 343
        Height = 17
        HelpContext = 1064132
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
        Caption = 'Creating ERP Order, Creates and Process Shipment '
        DataField = 'WALMARTOrderSilentProcessShipment'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object chkShowMagentoonMainmenubyDefault: TwwCheckBox
        Left = 8
        Top = 64
        Width = 288
        Height = 17
        HelpContext = 1064133
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
        Alignment = taLeftJustify
        Caption = 'Show On Main Menu By Default When Enabled'
        DataField = 'ShowMagentoOnMainMenu'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
      end
      object wwCheckBox9: TwwCheckBox
        Left = 167
        Top = 545
        Width = 343
        Height = 17
        HelpContext = 1064134
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
        Caption = 'Walmart Inventory Updated From this Database '
        DataField = 'Walmart_EnableInvFeed'
        DataSource = dsPrefs
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object bnRefreshMagento: TDNMSpeedButton
        Left = 145
        Top = 31
        Width = 71
        Height = 24
        Hint = 'Click this button to verify if Magento is enabled'
        HelpContext = 1064075
        Caption = 'Refresh'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Style = bsModern
        TabOrder = 9
        AutoDisableParentOnclick = True
        OnClick = bnRefreshMagentoClick
      end
      object bnChangePassword: TDNMSpeedButton
        Left = 16
        Top = 88
        Width = 120
        Height = 24
        Hint = 
          'Click this button to synchronize your website password with the ' +
          'CoreEDI service'
        HelpContext = 1064075
        Caption = 'Synch Password'
        DisableTransparent = False
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        Style = bsModern
        TabOrder = 10
        AutoDisableParentOnclick = True
        OnClick = bnChangePasswordClick
      end
      object gbPassword: TDNMPanel
        Left = 142
        Top = 83
        Width = 334
        Height = 35
        Ctl3D = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentCtl3D = False
        ParentFont = False
        TabOrder = 11
        Visible = False
        object imNewShow: TImage
          Left = 221
          Top = 7
          Width = 27
          Height = 20
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000001190000
            00B40803000000973BA8A10000008D504C5445000000FEFEFEEDEDEDFFFFFFEC
            ECECF2F2F2FAFAFAF5F5F5FBFBFBF7F7F7E8E8E8E3E3E32F2F2FE1E1E1BBBBBB
            CACACA9E9E9ED4D4D4505050C3C3C3686868DADADAD0D0D0707070ABABABB5B5
            B52626268080804040408989895858582121217878789494941A1A1A9C9C9C39
            39398686864646466060601313130B0B0B2B2B2B3B3B3B3333336B6B6B4A4A4A
            36FC3F1E00001B3B4944415478DAED5D097BDABAD296251B0321EC64DF9B3649
            B7FFFF3BBE73CFF69D9EDE346DD3EC01120860245FDB32C4B246DE2069CF79AA
            A74FA8B1D1C8AFE5D1CC68168D30841026CCFD403AF58E6CF7FF887F8775CB3D
            C0143B479879972373E49DC2D4BB50F30E7243C4BFF38EBCEF425DD8DE81310E
            762190F2BBD02DFFC7EE5F7EB948CABF1C478C16C9A4A0D14691D2BC0F83F76B
            0C904C8BD3E7979BFCC7441E2ECA5BFC3B3E3401191F131A472AC7BBD087683A
            5C9094DF854F2A76B446F0214C908927F52CC850143DDC9FC8FC44E65F814C90
            034FFBF0B8AD26D2F2BE3344646C8F2B0BB4821C78D285CF67821C18243519AE
            F5C8EC4152220716480591014989A30D72608194834C8E8336F63E740E174777
            F230F8293EB7FC537AF009FAA722BA487ADD73904ADE851E3CF2CFF1BF06FFB1
            31E2DF61F72FE3FDE62CDEAFF7C1489096D005F1BBA58131F9A4FC31519C8694
            D805444AE80222058D562435192DF6FB9DF75B3A034310050F9954887DD94152
            119C3276B402A7FC89CC4F647E2233476482BCEA7B716084DD7F6CCC0F7486E8
            F4F2EFC78173FC4A6F508C2F54D45F36F93811930E42D7D919BA70052434C4CE
            08F30B237BA1C8F43E32AC221AE8B8A7F5B4DC2D1999EE5D30E1479948C58F16
            1ADFA3A4E723EECB441C717F2EFA8873F1CB47DC978938E2FEB4F7EF980B5E28
            D0C5F4E14E8445A797312AEA5A6B58A6BF23B0ED154F0BF936EBF8E40552D3A9
            289312463B9DF581BB12473B112AE5D1B2E7D60EDCD706EB796A56FE1F256A1B
            FA60D81F236E35F8B7EA4D5EB7A6BE58FD3519280178B4F1E01E33FAEF44C6E5
            19E57CE73E2D2A93566A0EBBCE2DB27F193204E1CA42E7262B2A93F6BED7BD09
            74FBC4BAF6E3A9698FB16B9EBF36426B1EB4BC92F162F936F36411DBEBBBFBAE
            C3CBF1E368E7A68E89724748D2E317F25326EFD0E4F3880FC3B717E739D413B6
            18A01F92F4C6EE5B54AA5ECE0916DED6C8C099396C424A90BE4C79D68BA3F5EF
            0A1AAD7F9D1E948121EB46D6B918B0C520C3C6B9A5E19779C2C2DB9BAF5D0D89
            A4983CDA7432F0D4C2F4F4DA0146462E77357F58786B5A03466564FE017A1346
            B8713FD7B728DC5E9F5A6346FF71C8A03A3E7F4A58785BB63B8C3D2532F3B6A2
            1254AC9C3C3D2E6EDB6AF75C55276CC906EE4ACD15437CC6573A0CC43BF13E6C
            7F95F5FE32DF10CB3F38B8FE296D1C80D53FF5D8853E5C2A7D781E5CDCB6D1BD
            C346E2D1C65FE79FCA26CF44E8F0CE3C5AAEFF96E2C64A6BDAD0CADDE6B59E61
            2D38B407B53131EDD3341CAA54BA2068767946346ECC5B0626B8667E4A763F7B
            ED02650FECC1015BE763279CB0DB0FCBD122AE96477F24EB6BADDFF314871F56
            3B207429192E7567D91A8FA6FDCA3B719E290B33A344F4DAFF25C2C63EC38EF4
            F76322A3A144CBF496DD7FB010B1BC671CB747E9BE1E7ABE9E44E52A2D5E4CBD
            397E2464B0410B9BB1E6857DEDA28F5CC69766F7D6E50FA6BE18AFA66FDCDDFB
            5DCC5DA39CC58A5A2FC4ADD37546EF7156F3B273697DC18833771D5CF42D8CE6
            C18199664E087B8D058F58C2538E34618F97BF468FF9FD8965390B3B9B8114C5
            C36699C480B373F1909FDA7271565248B177900E7146345A5E559873792BB5CE
            87515351241561DCB01DCDBD146DD038BA3DC73FC8EE2DC6C5E5C807F9EEA48B
            BD89959054CC7E13B12B7AA4E2B131BA1696BCEFA437396BEBFA71C430DF0C2E
            469AA5340D64DA8933477679E33F1144772E47F47B2383D152E1A37A885BBDAE
            338B4157C3ECC870536AD58E58C90FDBD7CE02F81D91B190B9F9A77A7CCBA37B
            57337992DD5B67DC2523C2F8B3F5D0B566436616FF191BB5CED4635B6F0F7C76
            F744FE33B9712917C1705E9CF88B8DDF452C070EED356B4114B815D51FB5FF63
            C88AEA5E670E719408B3DE1D8FA97FABB9A079392529BF0BC1396A6AB0C5C8AC
            A9A5853AB91FD368521C709014ECA7E741A745CBC0386AC26CB6471602FDF4B2
            7A30060D29013F3D8CF2AD63E530AA3D9A4106F64965D50EB0FD52C961762E86
            42174FEBDBA9178992DF6C3DB4E9B3EA4DCEBC5B585319080E4EFB935B781EAF
            5782F34A0BE2D1ED35359F1119E74D52BDDE8E56E74A75CFEB0F4C50614B25DF
            EC5C302B133259F80C293514D6CCBD9B01B72E40FEC04A64C2FEC029F8CC8414
            418D9A42412919DD80C123059F7155CAE174C1F08E265CDC3BF01716EE378C46
            AED9AED0563C9FF573625BDEAF26FB96C12EEC385293B5694AEAB18BC9DA14BC
            4E17488DD5B278F58E993029DE05448A64906772658510512737A12E9ED51F98
            197995FE76F06564A79667D2CAC0A8FE00ABBA879D0B97C164F3601C79E67B22
            2ABB11DA41907D3DEEC411B4A098CD6BBD81957B52ED80309510F3EE77EE6C96
            1A196E2F3073D85A403D639CEBD9EE05349B6F27318A8A15BCDAE3B3E4899021
            74155E934AF84197959E78649C39681052D14A817D983DBD33B42D87916740C6
            F9AE5A826DF4CBDD117B326448B506BFC8EBE71A35922CAF22298269255F0397
            DBED9E7E3B765D41D2FA038F9456918DDB014B854C629B1E334A2D50BA2B99F7
            164EED0F6C11545EC411160CB43CB8CFE60F5C354FC10E1BED3436BD82D76302
            E32CA24598BDAD5F78E26252FBAE7F608F96F458C79A0D7AA3692CBA3FE0D480
            6C1C83FD55075AC4904276E0A47B07365A0159CCDE952528D4D0FC9085018D2E
            61F8B986DAEB9B4BB98B586180690BEBA0DCB77C4904CB84B04D11DA3B48A81D
            10B4089AD09A0F239A3A5A90E07A23CA5829344FDD48BDE4A914DEF77F0FE6AB
            379192054A312BD714E45F51C88C48B51E610894DBCE57863208038BE0CBBF66
            DDB0392263985D88CA9BCB8E855223431B118640B0ED75DAE905488CCAEBE0C4
            74F8309B1732460DBC97F56F843E0E372132585FCCE0BAB7799641B4C60A3D66
            E5D2E533F1BAF6E32904FBCF5864E53344A0DC8B5AF3023722B0CFFC6A26A7A3
            FA7064A3B4EA18D3E1E9B9799AC47F26D6E74AB39620E4DF5CDC8F153E578F5D
            885E4CCE75FA6223723353DD5E7FEE1B51A4605F2A0BD6F2DEFD91C0E72ACE4F
            CF591C207BD9BBDF351A11EDECFF0DA7B62005905F256B2D87758A1A25402A6C
            F6C1B92D88DBD7DB9A6CF609F9E9C56807245F81E4B11727348B5972166010AA
            7559FA68418C76FE06FADA38B325FD3795DE44AA2DC8E7AE716FA1F4C8E06247
            79D76B83F53BCB0D185C8E70405BEC6BA99171A059809EC7F6D580CD800CA9D5
            8171EE7FEB9358CE0E2053BF846FF875FFC6930A18B7CF1417C665589D3AFA4B
            0BEEE4278D30350A9030767475C3B2F9033BC868E56B607C0727A3C47107013E
            83732F40F162BDDFC67CCDE14C0223DDE1476BBF40D7EE1FABF84C64DC01CB35
            205EB9740D1AC9427386B3656133D1B44B1030EB6788A96355C43C0EBEBAEEAD
            8DF83574B3BB9F9C5F33292C86E8A51CA4A61D9C0C11BC6F09C6AA4CF6230902
            2D1395FBA85815B53C63142160AA0F0E3B4819DFE45EA74186C89D137388A52E
            FC48E53AA44354EF507279266847017585D50B14E82214DFA4948161C1B73CB4
            92D87D6419B821331977BB2362BF4923859A6C9E73D7EE0CD1820A3EBC7AA1B6
            F3A9900181D9BBBDA72803323623B2AABE7366B1E89D38C8AAFBF657CCB2C551
            965681D584439306191098B77FD85A325B6118194D16D39DF782C5EE511A6BFF
            0DFF6EF72423327A1992873D6852200302537F18857216257E9BF0D647694489
            3CA50D79D7AF38CC18614A72EB80197BE592A1C8DD5B0E90DF07084CD311EF7C
            9E9636C61F493AA9A3EF7252C1740250E03D5D0E0FE5DD6F5963FC591EF21073
            9E1190918069057E3A6802A5B80A00B3DC71C70A985E1378DD5AE330306D2D69
            172369556975B42CA370B1A235403B5EBDE0DB04A1BC10C0DE8106A9372F8FDD
            95305B2E117B2BC42D364F53ECDE92D563F1D7CD7B4B492AD60B7EEF2F089AE0
            5DA9776F41BDEFC5175F4E496A450D08A6C8D8134D0F5B5F23432724C1742F64
            D25918A4D20E821E8C18AD01C6A646DBBD224E6F22904A50BD8BDD6C562343C2
            0B5371C8D2F87692B026EA2C4F59917166C606A07B57EE592C320452889DE936
            43CE22F3A518A1E4AE06A9BC5E8D2DF115D8FB14D8424F1D7B6B9880385CEBB2
            E8786D8B946E2160586A8FA5C0702B62976F7F47299141F92D5148F31E71E66C
            4EE0CAEBBCA191FEC0B4D19005C5720FCD92CD490B2DD90DEF91A5F29F092B5D
            3B9F615209E3900800CDE1073BA48E093918B57151161357AF5DDAD91323D25D
            81816E5C8FE1EB903A0723664D6147F3F0D358D185302471B4811C8C1450A24A
            0343BC2B2173B2B9290B899E0E3943DE4E7FB64F9BB779179FB733F492864C96
            4B5710298412469C63B4F44DBAD1579FD4FEC0645536F0347AA3C014CB907F06
            879E8FCE5070B868725D34FB2ADE099DB82ED033E59F61CBF20B75F041F08D0A
            206334656351B9376B661EBC791CECB079AB298D6F11C8E40A82AE7E706CCD98
            998701BC66FD0C46C65C93177A67B99E199923C1C859EE6543465C6AB74F679C
            3339CBA8C8D054EF18800C24FABAFB9C332283730F429706C9E6295D152D5F8B
            BD99B33999805CE308C3D2EEAD0608322E3033677312770C36BE412BF4242C27
            4A18581256A7CA1D9ED99996C8C61FB4D89FDED5449EC92D4996C5DD531AD12F
            4A26CF684D6115D8F90A257010018749ED0B060457C68AF55E160107FC81651D
            6AFB72A007354A67F2EF4B968BF52B6FB99E31A3291185B46A0F658B89B3447D
            DDE108B36734C5485C1DDCF6EABF9AEF75CAB503B32AADEFCB57814DA01990D9
            11749E46372B32A204B2793A07649C8FB26468E6EAEA14196325FC2E1D7C3022
            F95752640CD1BA52E96745A62A9800763ECF05194CAB61CBFDDEA9159833B282
            BD7165CD0999AA60455BBACA18616A9584212E5FCD0999FC5E78E774B11F4426
            BC626F5F8CD00CD99C309ABA6E18A28B55AD1376350C281D13646C8854E322D8
            4FF396457A8900750914C502F22B1FC57BF714F94936275DDA8E6CB4497CFA7D
            E19442CBD4C437B935DD7C4B99C17F5016E6CCBBDFC87C8A0568F9B01857E97A
            98F8F28C6F93089EEF472CAF093CB0A7F7D814DEA6D64DC65C22B424DCC1729B
            CE2738A82C8971AD6BBEE47B1762B42EE992B5FE58C910D2C8C0A283F5D2B591
            4D064621B9E89B358F8CA676485375DAAB637F8A7108CDF245F88ABDF3C15C90
            11A5A9463B2B32A25CB47946E7800C31B62443DDD2DD30888CA1C99272C9F2A4
            A1599111B78B5E1C67456649987B2BD7734086E4B6258FB2DD93B07D86C86EBA
            1BD723363B32A279A6799B15995DC1A8567E980332F95D29FD54F31685354A86
            F392A1B3DEB766E7C0A246B97D6266E3C0465F185AAD33B346C99024E5A1FD2F
            D6633627C6EF91D8B81FBE0E6D5D32A65377887ED805F672E2D3E912E98D7E02
            53E03A8EB87B1D2662B7AD7B2A7521F6079222A6288B1A1A9148C574218CD645
            7045B6602EB0C71BC6D32D772C2F60E8E0E334423E2E27BEE0053095F49C476F
            0A7371F7CCF7D9506FCD438E04B6C8C8DD9D198954A08B04750990AC433BA28A
            8D10E00F8CABF2EE64B3A3CF583D24A41EBCF9388A6308807680727B02AF74D4
            A6D9AA8718A39A1CFEB07A6321C54E1CE0CCD6BCCF963B603ADCF0DE6DAD9B01
            195213A50AD71F681664900E3845F0BD7B1819B62F7B0A2C5FA5CB1D20ED5186
            3CF45E7ECC804C68E2B93BE33321432AF28CD93CD502AB6B78F796D565283D68
            6640C6D8145D19BC153D253221745FFFC9D02CC840C0EC7C165CB942BBB73AD5
            F664BEF4CE7DC5E7B77BBB7EC6497907C9AC9D243465364F255229AC9D0C02E6
            E04358EE08EEC479698D2A72BCA4B342090F37A25EAA8F56D04F2FBC8B866AAE
            83A8BABA2B0AA629F06C21925F7EA54F1F4989F343F0F506478BD82BF9E9BFFF
            4F4C75D711C3B9861C9CB275CA82B4E273E28B5BAA2FC43DE1AD6F69339ABE11
            DD4CF63F5B2A5209646002C8311B3783F86C4E189BF2AE7F7D3064D1C844F976
            863791576EAD54C884974C2F7D55C6FD26A2BF94F30D97EC114DE0F58AED1539
            947AE39C3B0965F37ADD0F05C2B5DA7672649014E3C29D16322103C66BADDD0D
            284AE40F5C376468DEFEE14EB26CC890F59022FFF6E3C04C8C0C6E8546B37B12
            5C5E532143F2DB72C0CCF6A50579C643D99C7075F1A3FC7B37542A844CC2EAAE
            3A09AB64F5F6A494779C9788410FC3B3DFD4C66A52915E22A454962319F6CE07
            9A74570E32790E90180A8ACB80EBD5D1F5B59131D33F969C09B6CEBDD449B1E9
            F731930216764F72E1C0D5002916E82F3C5A6D71498E6F3DFCDA37A02E54D99C
            8A2D79D6B846918CB505D96AF8FDAC0F0649923FEB07E119B3FD79DA6D5A6F34
            402F74834CEC54D99C707E1980A63A1CA597815D86000C6AA333A0713230CEEF
            4A6C61F5CA5665738A948191D65246DFA48AA3C4660BC8FDE3089F2C03329461
            58B58D4406413E63CD3B0B6742068CC7DFEEB7294A898C03CD0E1076BBDCF1CC
            84A95302CA2BB7DB597F305622439809E4AC3A3A79481D61EA3D477C04042B96
            0A6D55FE86A8D85B5C5F064242EB772C51BE891032A0F1071D8D3E53C440640C
            B22C7BB778AC2E3D32434472269024E6ED1F24103390A2BAEBA8B003143058BB
            EB67ABEEBA05DDA957F623ECB04409CE354D286E7BF3E271F2A7E0C05AA900E4
            0172A4D7C86C4EFC2A9F9678406D301D4FA3E76F844687CC3C1EF05026B40027
            1179F7895A966B8EF6039A30228B1538414DF33A9F8454F8D460118AA1AC770D
            16D1454C3627B20B0D71F75B308C26692E11966BAA125B6D14CE6D6AE98C9AC5
            711E2FA832E1BFFA002EAF4152F2DE014376058ABB3DF8DBC1257B36271CDA96
            F61BE7C3A96B9842BA6AA01D8E9019956964FF749032B5A397D982B6C05BB889
            CB6C119399078E0742AFBE4667558033F3602D3F43E1B8FDF3014D8F8C2207E0
            CB634F3499296791B10A71CE23B7F4545A649C9EC3415CC9DBC6ED2843DD5B45
            0EC0EA807BC6CF840CE86D8D5CF5253932D3FCC0615FF0E46DEB54A3282D3223
            B2013D56B47A319FEAAE70E20C74F0D1E75FE9D2D5AEC494A681DBCBBFBDA523
            5D3627545C83161047354E92CD09CA98C10DB18F39287071114A0BB877EDF96D
            45A4DF1733F87BF489564F9B1A0DF130BAC75B48562C80E84530B9E9EB6F7D2B
            BA58400099382B2AB6DF8225C9B81A953C9B1327555C4D58757CD2EAA44DA0FC
            C0D1D99C1489CBEAC3A065337B36A7495218A30226607BFFF700B144DA418021
            28127B285BB587ECC4B95E279C925429C8D1763CF3F83CB3E06298977911F229
            9171242C73E938292ECBAC6BA5C882EBA7B051256C7F716CCF1D195CFF069142
            CD0E52E617512E22189549A284836E7933845223632A524B37DA11333C453627
            F1CD25B526588173EFE1269893269ECFF0977A5CAD8EE22A34EE5CF77D5B2EB7
            0D83C502243E839122AF7449EB23067045457557978B5331FD3E8F3A652EB727
            749A7E9F601D4C17E54CF83BCA28907E7FDA858789778AD069B100A25BC5424D
            9D09EDFDC595ED268E727E4291CEE7F608C9A30D93B2F4D56378FE7D64C6A40B
            A0A800D286DE299F54CAEAAEA0AA80D0F67D3BB13C23DA7C4D7DF901D0335F93
            CBBB91473375AA6AC3ACC153D175077DB2EAAE60CCAAD79A6D9BBF2C49F203A3
            C04B4A30CBE95A0BDBA74BCE83B3BBB56F46A9FDC02C949EB17B979B3BBFC023
            6CF4878F5DCCBFAE0AD24B6B7039CEA3DBEB607DAF5475550876260621CC2A20
            7BC087C25032536198B1B7AAF0EBB9D1E9A7CD6C91B6E28C6637142532DE9F75
            AC6CC8F8060F5FF6CE507106F9C240B1A6A8C9B37366A5CE6C91BE168F225B30
            72EB9F8DA89E159964C38D122073CDCF8A81B9A9A39EA1BA2B23B596A2C0ED5E
            FFC2F6397BE046D2BA00A9CDCB4C6DD333460B0ACEEBBE498FA4227CA34236BD
            024ADFA8AD2C7BF3EABC6B900C5DAADAC4521B776AD01AABCC1B2FBFD02C23CA
            58DD755C5857D9259B5AD7C2E0F23A87EAAEAAA9A8D6360E2FDB496B0BCEA5BA
            EB90E4D7FE548C05AD77475606836DBA7A9401ED00A9743AA71DFCA5A1C868C1
            00D473AAD4A9AE08E4B4DDF3A1B737F11CC810925797237693D32566EC73AB61
            6A14379575E4F76E1EC6285382CD94C8102357516A5FF5E120901EE919ABBBA2
            5C5E3D6D0ECF86A3E92D3C153291B8A06A2F41ECAD1A9959AABB525C34D406EF
            C3E117C67F35978047B90B622C691F95E4EBF67DCA48D09030E06F87C6FA52C1
            5E4C982D4499E7D6BB7D64244ABF1F2405B96DC9D729722B4FDACA2533337A88
            F1D166AFEEEA5B378CB21D65825A1E75A72614FE170A034F5B75714CE8E2D62F
            1164BDDA6C788688F34CDA41F82D354A6654C1A18D7187DA14A1B96907CE63CE
            1BA5A8DA4FAF6FBD44B289ABCACF4B6F02348CF5FFA2A8B673774BE87C9071FF
            946AC791E436BF696325A9E745C679888568AB6EA9D5BB751EA3EA41A640A6D8
            BC8CDE1B3FB8E95A4957D714C84039F193C4DE62545DF93572C068C3B8707167
            99AB483BACB3541FC654507BF3D94B943E1332229F913713C17D4B21FDBEB0C3
            878D6A51BD84F2B63F1C4E931640A4D495C7718ED14AB11C03BEA3EB77BC5AE3
            93581560B41029B82E4128BEE9F156130B19530921B712CD6EDC76685C768701
            5209E419A77F5AC9B38538DC1D06736D6980F29AB15AFD0C32B0143A81EC1740
            5E62A9959AC36EDFB03DE368B4D7AB77273562B79254957315D9287EF08CDA81
            4C0B234D51EF30DCF6C6E63DBD99D440F45F99003204E13122A6D6C80DE236A5
            78F3B6323364E6792664DC8FCA42326CDCF6CAFC5CE88F87441B79737C521138
            571C63638196ADC455B0762E073EB7FB7191C1D4285793BC538176D45F1C5D95
            0AE81A351EEE9BB9BB62CABA60EBB7C3A987D81C910946C34F6D7A0CC939F1DD
            834431FECCD0EB463CBF9C57DBFCEABC94E963FC03370CD72530F9914F85058F
            808344B9F3DD91D14633712DCE59DA1ABBD008996DB4F0A90C7B07288915D526
            A850556CFECCAF6DF5DAF3376EA4ACEE9A21FF0CD14B55A2DED09FB91D8D4F07
            08B1C406B1EFA137C1C8B88F04E5F58CBE9C71AD6E768628992EF32322E3522C
            368789AA22A769A556BBCFA89ECE88FA8321E3ED57370C3D99B896A8AD2D743A
            2CE05CF054C83C110716785A6E4C17977A739939CE6CE94E38EB13999743D55D
            E372E24FBC4404DD58B84EECC237F24F5227E12146F5F2ED8C3C67AB9BEBB8B5
            B5A0D10A3918E3472BA67B0C8D969F8AABEE9ACD8A0AF8E961F7B3087A582569
            1B5AF78122C1423D9FBC9D4815713E7FED20F030A49D388299515AD4B5548BF9
            619F74BD44472C853FB07C57DF5F6F8A426672B559A8DE2F26085B79ABDD0FC6
            6DCC682E303DFFBDC878EB95E1E857556614FA668E493AD6A17E8A0BD6C3B88F
            11D3A540A4E7442645F69664C884AABBAA9657C255156257B5A16B5C74563E4B
            EFDB6840304F7C076FD7A7ADEE9A55D76653F163E24F31B176FAB4BCA30907F6
            0EA61CD83D60DEFDE1E94AEE715B616853FF9910293C1506341715EAAF0A5E20
            14824821CFD485A7CBAB8C8230DAA9B5933F6F5FEEF091098C766AED54CB33B1
            2E4019EA1D3C0E3EF9767980545A7FE019E499A4D55DE725033F4EFB27F660FC
            C769078FBCE727323F9199ED6D52A5B6F8B19099D6FC82D63C4E3F987E3F229F
            9E906209123C425D00F9F404313E9CE42EB0B008C141E1D122152971B441FD26
            44EA7F001AF5581E7662670000000049454E44AE426082}
          Stretch = True
          OnClick = imNewShowClick
        end
        object imNewHide: TImage
          Left = 48
          Top = 4
          Width = 27
          Height = 23
          Picture.Data = {
            0954506E67496D61676589504E470D0A1A0A0000000D49484452000003480000
            035B080600000078A5BFEE0000FFFF4944415478DAECBD099855D595BFBD5111
            11C5460444405404149CC5489C279CE348138D024E214A1B45A3C609E729C656
            9B36B6B3C6D8364D08418206871883334145445144A4911045A4FE884A0862BE
            FC96DF2115ACAA734ED5BEB5F739F77D9FE73EB7EAD6F4D6B9779DBBD7597BAF
            DDE26F7FC779E4FFFDBFFFE77CFDCA162D5AB87FF9977FF1A9871F7E41FD8AE0
            881F7E21FD8AE0881F7E21FD8AE48A1F7E21FD9AE2DAE26F5F134CA041B92A7C
            32F18BCF4FF7C4087EF8D5EF478CE0875F363F62053FFCB2F9858E151224FCF0
            4BF10B1DA4591C7D821F7E79FD8811FCF0CBE647ACE0875F36BFD0B14282841F
            7E297EA183348BA34FF0C32FAF1F31821F7ED9FC8815FCF0CBE6173A564890F0
            C32FC52F74906671F4097EF8E5F52346F0C32F9B1FB1821F7ED9FC42C70A0912
            7EF8A5F8850ED22C8E3EC10FBFBC7EC4087EF865F32356F0C32F9B5FE8582141
            C20FBF14BFD0419AC5D127F8E197D78F18C10FBF6C7EC40A7EF865F30B1D2B24
            48F8E197E2173A48B338FA043FFCF2FA1123F8E197CD8F58C10FBF6C7EA16385
            04093FFC52FC42076916479FE0875F5E3F62043FFCB2F9112BF8E197CD2F74AC
            9020E1875F8A5FE820CDE2E813FCF0CBEB478CE0875F363F62053FFCB2F9858E
            151224FCF04BF10B1DA4591C7D821F7E79FD8811FCF0CBE647ACE0875F36BFD0
            B14282841F7E297EA183348BA34FF0C32FAF1F31821F7ED9FC8815FCF0CBE617
            3A564890F0C32FC52F74906671F4097EF8E5F52346F0C32F9B1FB1821F7ED9FC
            42C70A09127EF8A5F8850ED22C8E3EC10FBFBC7EC4087EF865F32356F0C32F9B
            5FE8582141C20FBF14BFD0419AC5D127F8E197D78F18C10FBF6C7EC40A7EF865
            F30B1D2B2448F8E197E2173A48B338FA043FFCF2FA1123F8E197CD8F58C10FBF
            6C7EA16325EA04698D35D6706DDBB6B583841F7EA1FC744F8CE0875FFD7EC408
            7EF865F30B3DE8CBE38A1F7E21FD42C74AD40952D1B25DFCCAE9173A48B338FA
            043FFCF2FA1123F8E197CD8F58C10FBF6C7EA1638504093FFC52FC4207691647
            9FE0875F5E3F62043FFCB2F9112BF8E197CD2F74AC784D90F47B3EFDF453AF07
            6B830D36F07670F0C3AF317E3E83B45A8F217EE5F62346F0C32F9B1FB1821F7E
            D9FC42C74A8B9A9A1A6F0992FE19DFF31B972C59E2F5E0E3875F5E3F11BB237E
            F885F413B13BE2875F0C7E3E077DD57E2CF12BB75FE85869B178F162AF095291
            CA77F8E197C54FC4EE881F7E21FD44EC8EF8E117839FEF415F351F4BFCCAED17
            3A564890F0C32FC54FC4EE881F7E21FD44EC8EF8E117835FE8415F1E57FCF00B
            E9173A56A24E909239835F7DF5157EF805F3D33D31821F7EF5FB1123F8E197CD
            2FF4A02F8F2B7EF885F40B1D2B512748A248D92E7EE5F413B13BE2875F483F11
            BB237EF8C5E0177AD097C7153FFC42FA858E151224FCF04BF113B13BE2875F48
            3F11BB237EF8C5E0177AD097C7153FFC42FA858E151224FCF04BF113B13BE287
            5F483F11BB237EF8C5E0177AD097C7153FFC42FA858E151224FCF04BF113B13B
            E2875F483F11BB237EF8C5E0177AD097C7153FFC42FA858E151224FCF04BF113
            B13BE2875F483F11BB237EF8C5E0177AD097C7153FFC42FA858E151224FCF04B
            F113B13BE2875F483F11BB237EF8C5E0177AD097C7153FFC42FA858E151224FC
            F04BF113B13BE2875F483F11BB237EF8C5E0177AD097C7153FFC42FA858E1512
            24FCF04BF113B13BE2875F483F11BB237EF8C5E0177AD097C7153FFC42FA858E
            151224FCF04BF113B13BE2875F483F11BB237EF8C5E0177AD097C7153FFC42FA
            858E151224FCF04BF113B13BE2875F483F11BB237EF8C5E0177AD097C7153FFC
            42FA858E151224FCF04BF113B13BE2875F483F11BB237EF8C5E0177AD097C715
            3FFC42FA858E151224FCF04BF113B13BE2875F483F11BB237EF8C5E0177AD097
            C7153FFC42FA858E151224FCF04BF113B13BE2875F483F11BB237EF8C5E0177A
            D097C7153FFC42FA858E152F09927E5E7F3CD627133FFC9AE297FC8D981DF1C3
            2FA45FF2376276C40FBF18FC7C0CFA3896F855835FE858A182841F7E297E2276
            47FCF00BE9276277C40FBF18FC425F15CFE38A1F7E21FD42C74A8B9A9A1AAF09
            D2061B6CE0F5602D59B2C4EB01C20FBFBC7E227647FCF00BE9276277C40FBF18
            FC7C0FFAAAF958E2576EBFD0B1D2E26F5F53917F2EC43F841F7EBEFD7C0669A5
            1C7D821F7E79FD8811FCF0CBE647ACE0875F36BFD0B1E23D412A52F90E3FFCB2
            F8F90ED26A3C86F895DB8F18C10FBF6C7EC40A7EF865F30B1D2B154B90928551
            3E0F167EF885F0AB549056D331C4AFDC7EC4087EF865F32356F0C32F9B5FE858
            A182841F7E297EA1AF626471F4097EF8E5F52346F0C32F9B1FB1821F7ED9FC42
            C70A09127EF8A5F8850ED22C8E3EC10FBFBC7EC4087EF865F32356F0C32F9B5F
            E8582141C20FBF14BFD0419AC5D127F8E197D78F18C10FBF6C7EC40A7EF865F3
            0B1D2B2448F8E197E2173A48B338FA043FFCF2FA1123F8E197CD8F58C10FBF6C
            7EA1638504093FFC52FC42076916479FE0875F5E3F62043FFCB2F9112BF8E197
            CD2F74AC9020E1875F8A5FE820CDE2E813FCF0CBEB478CE0875F363F62053FFC
            B2F9858E151224FCF04BF10B1DA4591C7D821F7E79FD8811FCF0CBE647ACE087
            5F36BFD0B14282841F7E297EA183348BA34FF0C32FAF1F31821F7ED9FC8815FC
            F0CBE6173A564890F0C32FC52F74906671F4097EF8E5F52346F0C32F9B1FB182
            1F7ED9FC42C70A09127EF8A5F8850ED22C8E3EC10FBFBC7EC4087EF865F32356
            F0C32F9B5FE8582141C20FBF14BFD0419AC5D127F8E197D78F18C10FBF6C7EC4
            0A7EF865F30B1D2B2448F8E197E2173A48B338FA043FFCF2FA1123F8E197CD8F
            58C10FBF6C7EA1638504093FFC52FC42076916479FE0875F5E3F62043FFCB2F9
            112BF8E197CD2F74AC449D20ADB1C61AAE6DDBB67690F0C32F949FEE8911FCF0
            ABDF8F18C10FBF6C7EA1077D795CF1C32FA45FE858893A412A5AB68B5F39FD42
            076916479FE0875F5E3F62043FFCB2F9112BF8E197CD2F74AC9020E1875F8A5F
            E820CDE2E813FCF0CBEB478CE0875F363F62053FFCB2F9858E15AF09927ECFA7
            9F7EEAF5606DB0C106DE0E0E7EF835C6CF679056EB31C4AFDC7EC4087EF865F3
            2356F0C32F9B5FE85869515353E32D41D23FE37B7EE392254BBC1E7CFCF0CBEB
            276277C40FBF907E227647FCF08BC1CFE7A0AFDA8F257EE5F60B1D2B2D162F5E
            EC35412A52F90E3FFCB2F889D81DF1C32FA49F88DD113FFC62F0F33DE8ABE663
            895FB9FD42C70A09127EF8A5F889D81DF1C32FA49F88DD113FFC62F00B3DE8CB
            E38A1F7E21FD42C74AD409523267F0ABAFBEC20FBF607EBA2746F0C3AF7E3F62
            043FFCB2F9851EF4E571C50FBF907EA16325EA04491429DBC5AF9C7E227647FC
            F00BE9276277C40FBF18FC420FFAF2B8E2875F48BFD0B14282841F7E297E2276
            47FCF00BE9276277C40FBF18FC420FFAF2B8E2875F48BFD0B14282841F7E297E
            227647FCF00BE9276277C40FBF18FC420FFAF2B8E2875F48BFD0B14282841F7E
            297E227647FCF00BE9276277C40FBF18FC420FFAF2B8E2875F48BFD0B1428284
            1F7E297E227647FCF00BE9276277C40FBF18FC420FFAF2B8E2875F48BFD0B142
            82841F7E297E227647FCF00BE9276277C40FBF18FC420FFAF2B8E2875F48BFD0
            B14282841F7E297E227647FCF00BE9276277C40FBF18FC420FFAF2B8E2875F48
            BFD0B14282841F7E297E227647FCF00BE9276277C40FBF18FC420FFAF2B8E287
            5F48BFD0B14282841F7E297E227647FCF00BE9276277C40FBF18FC420FFAF2B8
            E2875F48BFD0B14282841F7E297E227647FCF00BE9276277C40FBF18FC420FFA
            F2B8E2875F48BFD0B14282841F7E297E227647FCF00BE9276277C40FBF18FC42
            0FFAF2B8E2875F48BFD0B14282841F7E297E227647FCF00BE9276277C40FBF18
            FC420FFAF2B8E2875F48BFD0B14282841F7E297E227647FCF00BE9276277C40F
            BF18FC420FFAF2B8E2875F48BFD0B1E22541D2CFEB8FC7FA64E2875F53FC92BF
            11B3237EF885F44BFE46CC8EF8E117839F8F411FC712BF6AF00B1D2B5490F0C3
            2FC54FC4EE881F7E21FD44EC8EF8E117835FE8ABE2795CCBEA575353E3E6CE9D
            EBDAB66DEBFAF5EB179D5F42ACC7AFB9FC42C74A8BBFBF50BC26481B6CB081D7
            83B564C912AF07083FFCF2FA89D81DF1C32FA49F88DD113FFC62F0F33DE8ABE6
            63D9583EF9E4133767CE1C4B9076DD75D7E8FC12623D7ECDE5173A565AFCED6B
            2AF2CF85F887F0C3CFB79FCF20AD94A34FF0C32FAF1F31821F7ED9FC8895E6F3
            FBCB5FFEE2FEFAD7BFBA499326B9A79E7ACA7DF8E18796187DF9E597F6F85A6B
            ADE5D65C734DD7AE5D3BF79DEF7CC7B569D3C60D193284E317895FE858F19E20
            15A97C871F7E59FC7C0769351E43FCCAED478CE0875F363F62A5F9FCBEF8E20B
            4B84C68C19E3C68D1BE7E6CD9BE7DE7EFBED6F7CDF461B6DE44E38E104AB288D
            183182E317895FE858A95882942C8CF279B0F0C32F845FA582B49A8E217EE5F6
            2346F0C32F9B1FB152793F558E54251A3D7AB47BE185172C299A356B963DAEA4
            69755AB66CE93A76ECE8D65E7B6DB7C71E7BB835D658C35D75D555F6B5F5D65B
            AFEA8E5F2C7EA163850A127EF8A5F885BE8A91C5D127F8E197D78F18C10FBF6C
            7EC44AE5FD92CAD1CD37DFEC264E9C6853EB744B43D3EDB6DE7A6B9B7AA78A93
            C83325AD2CC72F16BFD0B14282841F7E297EA183348BA34FF0C32FAF1F31821F
            7ED9FC8895CAF9A942F4D5575FB9871F7ED8CD9831C3BDF4D24BAB2A47BA65F9
            FDEBAFBFBE5590060D1A648F5D70C105AE55AB566E9D75D6B1C7CB7CFC62F30B
            1D2B2448F8E197E2173A48B338FA043FFCF2FA1123F8E197CD8F58A99CDF679F
            7D6653EBAEB8E20A3779F264377FFE7CB768D1A246FDAD6DB6D9C6EE956C699A
            5D923895F9F8C5E6173A564890F0C32FC52F74906671F4097EF8E5F52346F0C3
            2F9B1FB1E2DFAF76E5484991BAD6A95B9D12A62C95A3BAD870C30DED7EF0E0C1
            B63669E8D0A136DDAEA14A52518F5FAC7EA1638504093FFC52FC42076916479F
            E0875F5E3F62043FFCB2F9112BFEFD3EFDF4534B90D4816EFAF4E9B6096CB281
            7553E9D3A78F2544FFF55FFFE5BA74E962ADC0B546A94CC72F56BFD0B1428284
            1F7E297EA183348BA34FF0C32FAF1F31821F7ED9FC88157F7E497548DDEAF477
            920A923E6E6CE56875D4025C095252413AECB0C35675BC5BBD9254B4E317BB5F
            E8582141C20FBF14BFD0419AC5D127F8E197D78F18C10FBF6C7EC48A3FBFA472
            74D24927D91E47B367CFB6697595A077EFDED60EFC273FF98975BAABAB9254B4
            E317BB5FE8582141C20FBF14BFD0419AC5D127F8E197D78F18C10FBF6C7EC44A
            D3FDD4C25B8C1D3BD63E1E356A94356358B870E1AAAFF946552325445A93D4B5
            6B57B7DB6EBBB94D36D9C41E4B2A4945397E45F10B1D2B2448F8E197E2173A48
            B338FA043FFCF2FA1123F8E197CD8F5869BA5FB2BEE8A8A38EB22A923682F535
            A52E8D1E3D7AB8D6AD5BBB4B2EB9C4EDBAEBAEF6B1A6DB15E9F815C52F74AC90
            20E1875F8A5FE820CDE2E813FCF0CBEB478CE0875F363F62A5F1AC58B1C2FC1E
            7BEC31FBFCD24B2FB54D61B5EE48EDBD9B035592B42FD289279E6853EDFAF6ED
            BBAA92A48D66633E7EB13FBFB1C50A09127EF8A5F8850ED22C8E3EC10FBFBC7E
            C4087EF865F323561A87D61A697D91F6233AE08003EC316D06DB5C89D1EA74EF
            DEDD5C7EF8C31FBA01030658D2A46A52ACC74FC4FCFCD6E5173A564890F0C32F
            C52F74906671F4097EF8E5F52346F0C32F9B1FB1921F25415A5BF4DA6BAFB975
            D75DD79D7EFAE9F6B8F63A52E214025592D4A8E1B8E38E73FDFBF7779B6EBAA9
            B501D7FE49691BCA36F7F14B88F5F9ADCF2F74AC9020E1875F8A5FE820CDE2E8
            13FCF0CBEB478CE0875F363F62251F4A80962E5DEA6A6A6AACD5B6A6B24D9B36
            CDAB63535052D4AE5D3B3764C810F7AFFFFAAFAE53A74EB699AC2FCAFEFC36E4
            173A56A24E909485B76DDBD60E127EF885F2D33D31821F7EF5FB1123F8E197CD
            2FF4A02F8F6B683F25476ABEF0EEBBEF5A9274DE79E799E33BEFBCE3CDAFA9A8
            92A4FD91D430E2D0430F755B6CB185254DC24725A9CCCF6F9A5FE858893A412A
            5AB68B5F39FD42076916479FE0875F5E3F62043FFCB2F9112BD9D0B4BACF3FFF
            DCF6373AF3CC33DDCA952BDDCC9933BDBAF964E38D37B64D6535E56EF8F0E1D6
            D94ED3019B4A599FDF2C7EA1638504093FFC52FC42076916479FE0875F5E3F62
            043FFCB2F9112BE9249523ED6BA40E75175E78A1254CAA24C58A92A30E1D3AB8
            A38F3EDA9D72CA296EBDF5D6B3C744532A49657C7EB3FA858E15AF09927E8F7A
            D2FB3C582A5DFA023FFC1AE3E73348ABF518E2576E3F62043FFCB2F9112B0DA3
            660CCB962D736FBCF186BBF8E28BDDF2E5CBA34E8C564753EED4F65B9DF6E4AF
            35534A961A43199FDF3C7EA163A5454D4D8DB70449FF8CEFF98D4B962CF17AF0
            F1C32FAF9F88DD113FFC42FA89D81DF1C32F063F9F83BE321E4B25486AE7AD46
            0C5A73A44A9236822D0AAA1A69BADD3EFBECE3CE39E71CD7B265CB462748657C
            7EF3F8858E95168B172FF69A2015A97C871F7E59FC44EC8EF8E117D24FC4EE88
            1F7E31F8F91EF495E5582A31D2A6AFCF3CF38CBBEAAAAB2C499A3D7BB6D7FFAD
            39D1FFDDB56B57B7F3CE3BBBCB2FBFDC3691CD9B2895E9F96D8C5FE8582141C2
            0FBF143F11BB237EF885F413B13BE2875F0C7EA1077D795C9BD38F04E99B94E9
            F96D8C5FE858893A414AE60CFADA080C3FFC1AE3A77B62043FFCEAF72346F0C3
            2F9B5FE8415F1ED7E6F0D3143A254713274E7477DD75975BB468919B356B9639
            84DA04D6D7FFAEE60C5A53D3BB776FB7D9669BB9EBAEBBCEBEA6A95EBE8E5F1E
            8895122548A248D92E7EE5F413B13BE2875F483F11BB237EF8C5E0177AD097C7
            B539FC9420E9367EFC78376AD428FBFB73E7CEF5FA3F8564FDF5D777DDBB7777
            5B6EB9A5BBF9E69B57AD85C942199EDFA6F8858E151224FCF04BF113B13BE287
            5F483F11BB237EF8C5E0177AD097C7B5927E49E568DCB871961C69BF23356350
            3B6FDDCA828E81F64452A2D4AF5F3FD7AE5DBBCC95A4223FBF3EFC42C70A0912
            7EF8A5F889D81DF1C32FA49F88DD113FFC62F00B3DE8CBE35A493FAD375282F4
            C0030FB8071F7CD0A6D669CFA3B2D2BA756BD7A3470FDB2BE9DE7BEFB5C7D25A
            6E17F9F9F5E1173A564890F0C32FC54FC4EE881F7E21FD44EC8EF8E117835FE8
            415F1ED74AF8A972A40AD1983163DCE4C993DD5B6FBD659523254BBA95151D8B
            75D75DD7B56AD5CA0D1830C0F6474A2A49F5356F28E2F3EBD32F74AC9020E187
            5F8A9F88DD113FFC42FA89D81DF1C32F06BFD083BE3CAE95F04B2A475A6FA4A9
            751F7EF8A1DDAA05ED8BA4A60D9A763776EC587BACBE4A52119F5F9F7EA16385
            04093FFC52FC44EC8EF8E117D24FC4EE881F7E31F8851EF4E571F5E9A7CA91BA
            933DFCF0C36EC68C19EEA5975EB26E754993866A41C744EB91D4E16ED0A041F6
            D805175C6095A575D659C71EAFEBF8F98258C9F1332448F8E1D7B09F88DD113F
            FC42FA89D81DF1C32F06BFD083BE3CAE3EFDB4AF91A6D6698F23ED75A4F5465A
            7754ADE8D8F4EDDBD73E1E3D7AB44DBF4B12A7DADF5394E7B7127EA163850409
            3FFC52FC44EC8EF8E117D24FC4EE881F7E31F8851EF4E571F5E1A7AA48523952
            A7BA279E78C2CD9933C712A66AAA1CD5C5861B6E68F783070FB63549279F7CB2
            4DB74B2A4945787ECB1C2B2448F8E197E2276277C40FBF907E227647FCF08BC1
            2FF4A02F8FAB0F3F0DF495209D7BEEB96EDAB469B6C75172CE80AFE9D3A78F1D
            A73BEFBCD375EEDCD9B569D3C612A6223CBF658E151224FCF04BF113B13BE287
            5F483F11BB237EF8C5E0177AD097C7B529A83A24BF499326B9BF8F336D1A99A6
            D5E9F7577BE5687536DA68234B9054495205E9C8238FB4C7B42E29A932F98258
            C9F1332448F8E1D7B09F88DD113FFC42FA89D81DF1C32F06BFD083BE3CAE4DE1
            D34F3FB5FB73CE39C7AA46B367CFB66975503FEA6EA72E7737DD7493EBD5AB97
            B5FF56A2E4136225C7CF9020E1875FC37E227647FCF00BE9276277C40FBF18FC
            420FFAF2B83686642FA3091326B8E5CB97DB46B00B172EB45B99F739F241C78E
            1D6D6A9D2A499B6CB289DB73CF3D6DFA9D1EABDDBCA129102B397E8604093FFC
            1AF613B13BE2875F483F11BB237EF8C5E0177AD097C7B5312C59B2C4EE35C8D7
            C7AA1C31A52E1F3D7AF470AD5BB776975D76993BE08003ACC39DF64DF201B192
            E3677C2448FA79FDF11883153FFC9AEA97FC8D981DF1C32FA45FF2376276C40F
            BF18FC7C0CFA623C964975E8F1C71FB79FBFF1C61B6D4ADD471F7D44E52827AA
            2469FDD189279EE876DE7967B7C30E3BB8AE5DBB7AA924112BD9A182841F7E29
            7E227647FCF00BE9276277C40FBF18FC425F15CFE39A1575A95BBA74A97D7CC4
            1147D8FDCC9933DDCA952BBDBA551BDDBB7777EDDAB5B38D640F3EF8606BFFAD
            5B53205672FC4C4D4D8DD704491D387CA2122D7EF885F413B13BE2875F483F11
            BB237EF8C5E0E77BD017FA586AF3575588A64E9D6A9FAB2983D09E4724484D43
            95A4B66DDBBA214386B8DD76DBCD6DB1C51656495215A9B195246225C7CFFCED
            6B2AF2CF85F887F0C3CFB79FCF20AD94A34FF0C32FAF1F31821F7ED9FCCA142B
            AA1CA95B9D6E471D75943DA6BD8EC02F4A8A54FD38E9A493DCB1C71E6BD3EF1A
            53492256F2B97A4F908A54BEC30FBF2C7EBE83B41A8F217EE5F62346F0C32F9B
            5F596245C9919A2FBCFDF6DB96200D1F3EDC1ED7E7E017559294381C73CC31EE
            A0830EB2D6DFDA5056E4A924112BF95C2B9620250BA37C1E2CFCF00BE157A920
            ADA663885FB9FD8811FCF0CBE6578658D1B43A3560D0343A5535F4F98C1933BC
            FD4F50371B6FBCB12547471F7DB43BF9E4936DCF2475B8CB0AB192CF950A127E
            F8A5F885BE8A91C5D127F8E197D78F18C10FBF6C7E458F95A472B460C102377F
            FE7C77D65967598244E5A8F2A892D4BE7D7B77E8A187BAE38E3BCEADBFFEFAF6
            B9C85249225622A92055E260E1875F08BFD0419AC5D127F8E197D78F18C10FBF
            6C7E458E153563F8E28B2FDCF4E9D3DD881123564DB183E64555245593F6DF7F
            7F77F6D967BB35D75CD3ADB7DE7AA93F47AC9020E1879F57BFD0419AC5D127F8
            E197D78F18C10FBF6C7E458E1525485A6FA4E974E79E7B2E095220920469BFFD
            F673679E79A64DB553B7BB3488151224FCF0F3EA173A48B338FA043FFCF2FA11
            23F8E197CDAF88B192548E264F9EECAEB8E20A5B7F347BF66C6FFF03340E3D57
            EA70B7CB2EBBB8912347A6569288151224FCF0F3EA173A48B338FA043FFCF2FA
            1123F8E197CDAF88B142821427244895752541C20FBF14BFD0419AC5D127F8E1
            97D78F18C10FBF6C7E458A154DA15372F4D8638FB9DB6FBFDD2D5EBCD8CD9A35
            CB1A35E80661D1F3A5E60C6A01DEB3674FB7E5965BBA6BAEB9C6BE56D7943B62
            8504093FFCBCFA850ED22C8E3EC10FBFBC7EC4087EF865F32B52AC2841D26DC2
            8409EED65B6FB5BF3577EE5C6FEEE00775B3EBDEBDBBEBD5AB97BBE9A69BEC79
            24416ABA2B09127EF8A5F8850ED22C8E3EC10FBFBC7EC4087EF865F32B42AC24
            95A3F1E3C7BBB163C75A3B6F3563503B6FDD202EF4BCADBDF6DA9628EDB4D34E
            D6FAFBBAEBAEB3AFD54E9488151224FCF0F3EA173A48B338FA043FFCF2FA1123
            F8E197CDAF08B1A2F5464A901E7AE82177DF7DF7B9458B1659920471D3BA756B
            D7A3470FD7A9532777F7DD77DB639A7E9740AC9020E1879F57BFD0419AC5D127
            F8E197D78F18C10FBF6C7E31C7CAF2E5CB6D91FF983163DC33CF3C635523DD94
            2CE90671A3D7D6BAEBAE6B89D2BEFBEE6B55A5A492A4E795582141C20F3FAF7E
            A183348BA34FF0C32FAF1F31821F7ED9FC628E9565CB96D900FBB6DB6E73E3C6
            8D731F7EF8A1DDA058685FA4DEBD7BBB75D659C7925DA14A12B14282841F7E5E
            FD42076916479FE0875F5E3F62043FFCB2F9C5182B5A73A4AE74BFFAD5AFAC7D
            F7942953AC5B5DD2A4018A855E635A8FB4D65A6BB9638E39C61EBBF8E28BADA2
            A40D66D5F9CE17658E151224FCF04BF10B1DA4591C7D821F7E79FD8811FCF0CB
            E61763AC685FA3952B575A07B4175E78C1D61B69DD11141BBDD6FAF6ED6B1FAB
            92A4A977DDBA752341CAEA137382A427511D387490F0C32F949FEE8911FCF0AB
            DF8F18C10FBF6C7EA1077DB5492A479A4E376FDE3CF7873FFCC1BDF7DE7B36D5
            8ECA513948128EA14387DAD4BB73CE39C7A6DB69FA9D8F44A9CCB112758254B4
            2B43F895D32F74906671F4097EF8E5F52346F0C32F9B5F4CB1F2E9A79FDACF8E
            1C39D2BDFEFAEB9624E931281F7DFAF4B104446DDB3B76EC684D1B3405AFA994
            39564890F0C32FC52F74906671F4097EF8E5F52346F0C32F9B5F0CB192548754
            39FAE4934F6C235825474B972EB54E76503E36DA6823BB3FFDF4D3AD4A3368D0
            204B94B42EA92995A432C78AD70449BF27B922E1EB60D5EEE18E1F7E21FC7C06
            69B51E43FCCAED478CE0875F36BF186225F9991FFEF0876EEEDCB9EEFDF7DF77
            9F7FFEB9B76308F1A24A9292A23BEEB8C3F5EAD5AB4995A4B2C74A8B9A9A1A6F
            0992FE19DF7381972C59E2F5E0E3875F5E3F11BB237EF885F413B13BE2875F0C
            7E3E077D795DB59751B2E6489BC16A90AC36DE8B172F66CD5195A0AA912A465A
            93D4B97367B7FFFEFBBB2E5DBA34EA77953956EC67FE1E185E13A42295BAF1C3
            2F8B9F88DD113FFC42FA89D81DF1C32F063FDF83BE3CAE49AC0E1C38D092226D
            024B62549DF4E8D1C3BADADD78E38D6ED75D776DD4EF2873ACD8CF9020E1875F
            C37E227647FCF00BE9276277C40FBF18FC420CFA54391213274EB40AD255575D
            65D38D543D4ABE06D5852A49EA6A77C10517B8EDB7DFDE75EDDAD5B56BD72ED7
            EF2863ACFCD3CFC49C2025730615D0F8E117CA4FF7C4087EF8D5EF478CE0875F
            36BFE61EF4E9EF269DE90E3CF040F7E5975FBA193366D83DC051471DE5BA77EF
            EE8E3CF2484B94F250B658F9C6CFC49C2089225D19C2AF9C7E227647FCF00BE9
            276277C40FBF18FC9A73D0A72448B7E79E7BCE3E3FF3CC33ED7375AC234102F1
            ED6F7FDBD6229D7CF2C96EB7DD76CBF5B3658A953A7F8604093FFC1AF613B13B
            E2875F483F11BB237EF8C5E0D75C83BEA472F4D9679FB9238E38C21E9B366D9A
            D7FF0BCAC3CF7EF63377DC71C7E5FA99B2C44ABD3F4382841F7E0DFB89D81DF1
            C32FA49F88DD113FFC62F06B8E419FAA435A5BF4D65B6F59B7BA61C386D9E3B3
            66CDF2FA7F4179B8E5965BAC79875A80676DFB5D865869F0674890F0C3AF613F
            11BB237EF885F413B13BE2875F0C7E951EF4293952D568FEFCF96EC89021ABD6
            1C0134C4F9E79F6F2DBFD5AC4153EEB250F45849FD191224FCF06BD84FC4EE88
            1F7E21FD44EC8EF8E117835F25077D9A56A7B6DD0B162CB0DBF0E1C3ED31B5F3
            0668888B2EBAC80D1830C06DB2C926AE43870E997EA6C8B192E9674890F0C3AF
            613F11BB237EF885F413B13BE2875F0C7E951AF4259523558BCE3AEB2C4B9448
            8C202BAC41AAE3674890F0C3AF613F11BB237EF885F413B13BE2875F0C7E951A
            F469CD91FE8ED61D8D1831C23E27418234F41A12B7DF7EBB1B346850EE9F2D62
            AC64FE191224FCF06BD84FC4EE881F7E21FD44EC8EF8E117839FEF41DFBAEBAE
            6B8D18D4CAFBB2CB2EB32AD2ECD9B3BDFA4379D96EBBED5CFBF6EDAD05FC3EFB
            EC93EB678B162B2448F8E1E7D94FC4EE881F7E21FD44EC8EF8E117831F0912C4
            040952033F4382841F7E0DFB89D81DF1C32FA49F88DD113FFC62F0F335E8D31A
            234DA37BF9E597DDA851A3EC6F2453EAD49801A021BA77EFEED659671D3772E4
            48B7C30E3BB80D36D8C092ED3C1425561AEB4A82841F7E297E227647FCF00BE9
            276277C40FBF18FC7C2748CF3FFFBCBBE9A69B6C53D83973E678F586F2B2F9E6
            9B5B8274C51557B85D76D9C5B56EDDDAF640CA435162A5B1AE2448F8E197E227
            6277C40FBF907E227647FCF08BC1AFA983BE24319A3469921B376E9CFBF8E38F
            AD3183AA46EA6407D010AA1C6923D82BAFBCD29224B5F55E6FBDF5DC1A6BAC91
            FB77C51E2B4D752541C20FBF143F11BB237EF885F413B13BE2875F0C7E3E12A4
            E5CB97BBB163C7BA071F7CD02A47F3E6CDF3EA0BE5A5478F1E5629BAE5965B5C
            AF5EBD5C9B366D2C616A0CB1C74A535DBD2448FA79FDF1584F7CF8E1D714BFE4
            6FC4EC881F7E21FD92BF11B3237EF8C5E0D7D8419F12235588C68F1FEF264F9E
            ECDE7BEF3DF7CE3BEFB8952B575A4509A02136DB6C33AB125D75D5556EC30D37
            745B6FBDB5AD39D26379AB47B1C78A2F572A48F8E197E2276277C40FBF907E22
            7647FCF08BC1AFB1833E75AA5BB16285BBF7DE7BDD238F3CE2162D5AE43EFCF0
            43AF9E505EFAF4E96389D03DF7DCE33A76ECD8A4CA5142ACB1E2CBB5454D4D8D
            D704499D307CB264C912AF07083FFCF2FA89D81DF1C32FA49F88DD113FFC62F0
            CB3BE84B2A475A6FF4C61B6FB8D75E7BCDBDFBEEBB5635D2543B80FA5042D4B5
            6B57FBF8D65B6FB5A975DB6EBBAD3564686A7224628B15DFAE2DFEF63515F9E7
            42FC43F8E1E7DBCF679056CAD127F8E197D78F18C10FBF6C7E796345FB1A2941
            BAEEBAEBDC534F3DE5162C58E0162E5CE8F5FF8572A2D7DA565B6D651F2BC156
            D7BA6EDDBA35AA21437DC4142BBE5DBD2748452A75E3875F163FDF415A8DC710
            BF72FB1123F8E197CD2F6BACA872A4CE74A3478FB6F6DD4F3FFDB49B356B964D
            B5D3D700EA63CD35D7741D3A7470AD5AB572175F7CB13D76E8A187BA962D5BDA
            F43A9FC4102B9572AD5882942C8CF279B0F0C32F845FA582B49A8E217EE5F623
            46F0C32F9B5FD658492A47175C70819B3A75AA75AA5BBC78B1D7FF13CA8912A1
            2DB7DCD21224558E4452E92F63AC54CA950A127EF8A5F885BE8A91C5D127F8E1
            97D78F18C10FBF6C7E69B19254875439522306B5F39E3B77AEB5F3A672040DA1
            CA51FBF6ED2D19FAFEF7BF6F9F1F77DC71F6354DAF2B5BAC54DA9504093FFC52
            FC42076916479FE0875F5E3F62043FFCB2F9A5C58A12214DAD1B366C989B3D7B
            B64DAFD3630069A8F982DA796B1ADDFDF7DF6F8FADBEA6A74CB15269571224FC
            F04BF10B1DA4591C7D821F7E79FD8811FCF0CBE6575FACA82B9D12234D89D2F4
            3AB5635643064DABA372040DA12975EBAFBFBEEBD4A9933BEAA8A32C291A3C78
            B07D4D95A384B2C44A73B99220E1875F8A5FE820CDE2E813FCF0CBEB478CE087
            5F36BFFA6225D94F4C53A2D4A52E69C8009086F634DA74D34D5DCF9E3DAD9DB7
            5E636DDBB6FDC6F79525569ACB9504093FFC52FC42076916479FE0875F5E3F62
            043FFCB2F9AD1E2BAA1C89091326580549EDBCF5F7B5096CF23580BA50E548D3
            EABA74E9E2F6DD775FB7C9269BB8A143875A1BEFDA95A384A2C74A73BB9220E1
            875F8A5FE820CDE2E813FCF0CBEB478CE0875F36BFD56325A91C1D7CF0C19610
            BDF5D65B244690095589941CF5EBD7CF5D79E595D69461BDF5D6ABF7FB8B1E2B
            CDED4A82841F7E297EA183348BA34FF0C32FAF1F31821F7ED9FC9258510B6FDD
            264F9E6C8F9F75D659F6B9DA79EB1EA03E54395A7BEDB56D5ADD4E3BEDE47AF7
            EEBDAA72B4EEBAEBD6FB73458D9550AE2448F8E197E2173A48B338FA043FFCF2
            FA1123F8E197CD4F9FAF5CB9D23AD3698DD1E1871F6E8F4F9F3EDDA6D801A4B1
            E1861B5A4386FDF7DFDF9D7BEEB9A995A38422C60A0952C683851F7E21FC4207
            6916479FE0875F5E3F62043FFCB2F9A93AA429743366CCB0EE746AE72DD4D29B
            04091A4289D05A6BAD65ADBCD590A17FFFFED6AD2EAD729450B45809FDBE4282
            841F7E297EA183348BA34FF0C32FAF1F31821F7EE97E4A8ED4C25BEDBB4F3CF1
            444B88543902C882F637D246B0C71C738C3BF5D4536DAA5D96C428A148B1927C
            4E8294F160E1875F08BFD0419AC5D127F8E197D78F18C10FBF86FD940CA96234
            7FFE7CEB50377CF8707BECEDB7DFF6EA0EE54395235589B4E6489DEA0E3BEC30
            F7DDEF7ED7D621D5D5ADAE3E8A122BB53F2741CA78B0F0C32F845FE820CDE2E8
            13FCF0CBEB478CE0875FFD7E5A1FA2CA913AD49D79E699ABBAD5016441499136
            7F3DF9E493DDC081035DAB56AD7225460945881512A4461E2CFCF00BE1173A48
            B338FA043FFCF2FA1123F8E157BF9F06B36ACAA06A91BAD52941A2720469A86A
            A4D761D7AE5D5DBB76EDAC53DDD1471F4D82D44CAE5127487A71A8CFBB0E127E
            F885F24B4E52313BC67E0CF12BB71F31821F7EDF448990A6D5A95A74C9259758
            D7BA59B36679F38472A329756DDAB47123468C7003060C687462941073ACD4E5
            4782D4905CC1B25DFCCAE9173A48B338FA043FFCF2FA1123F8E1F74D920469E6
            CC99EEE28B2F2641825CF84E90628E95BAFC42BFAF9020E1875F8A5FE820CDE2
            E813FCF0CBEB478CE087DF3F5052B47CF972F7CC33CFB8DB6FBFDDD61F258911
            ADBC210DB5F15677BA6BAEB9C636815555254FB7BAFA8831561AF20BFDBEE235
            41D2EFD13C5B9F074B0BD37C811F7E8DF1F319A4D57A0CF12BB71F31821F7EFF
            2049909E7AEA29376AD428F7F9E79FBB3973E678738472B3C5165B584274FDF5
            D7BB6DB6D9C6B56EDDDA3AD635951863A521BFD0EF2B2D6A6A6ABC2548FA677C
            CF6F5CB26489D7838F1F7E79FD44EC8EF8E117D24FC4EE881F7E95F65362A469
            7513264C700F3FFCB0B5F3D6FAA3952B57DA0DA021BA77EF6E1BC15E79E59596
            2475E9D2C53AD8A9CDB72F6289952C7E3E13A4C6B8B658BC78B1D704A948E53B
            FCF0CBE2276277C40FBF907E227647FCF0ABB49F1224DD468F1EEDEEBAEB2EF7
            F7F1959B376F9ED7FF15CA4B8F1E3DAC52F4EFFFFEEF6EABADB6B2F6F01B6DB4
            91D7BF114BAC64F1F39D20E5752541C20FBF143F11BB237EF885F413B13BE287
            5FA5FC94147DF9E5976EECD8B1EE89279E70B367CFB6CA911E534509A021BA75
            EB661DDCAEBDF65AB7E1861BBAADB7DEDAA6D8A972A4CF7D123A56F2F8912035
            403267D0D7A246FCF06B8C9FEE8911FCF0ABDF8F18C1AF9AFDD49D4E89D01D77
            DCE1C68C19E3162E5CE8162C58E0ED7F8472A3460C4A90EEB9E71ED7B97367EB
            5CA7A976658C953C7E2448291429DBC5AF9C7E227647FCF00BE9276277C40F3F
            DF7E49E54849D1D4A953DDABAFBE6A1BC026EDBD01EA43AF336D002B54396AD9
            B2A5EBDFBFBF558E942CE956A658698C1F09528E83851F7E21FC44EC8EF8E117
            D24FC4EE881F7EBEFDD4BE5B09D20D37DC6053EB543552F508200DBDCEB4CE48
            FCF297BFB4C468FDF5D7B7C4A8F6F79425561AE3478294E360E1875F083F11BB
            237EF885F413B13BE2879F2F3F5587340D48CD18B4DE48FB1D699F234DB5A372
            040DA175459D3A75B2FB4B2FBDD41E3BF4D0436D4ADDEAADBCCB102B4DF12341
            CA71B0F0C32F849F88DD113FFC42FA89D81DF1C3CF975F5239BAF0C20BDD9429
            53AC539D3AD601A4A1A9745B6EB9A5DD8F1F3FDE1EAB6F6FA232C44A53FC4890
            721C2CFCF00BE1276277C40FBF907E428E1A346AEF97A6D2D4CD0C9379FC6A93
            ABABB2453886F8C5EF9754875439D254BA71E3C6B9B973E7DAC2722A47D010AA
            18B56FDFDEA6D1FDE0073FB0CF8F3BEE38FBDA3AEBAC53E7CF1439567CF89120
            E53858F8E117C24FC4EE881F7E21FD841CB538FDF5D75F6FB2A306114D41AD71
            356565E38D37B664A908C710BFF8FD920E5BC3870FB7660C73E6CCB1C700D268
            D5AA956DFEAA7D8D7EFEF39FDB636917828A1C2B3EFC4890721C2CFCF00BE127
            6277C40FBFFA5055E7E38F3F5EE5A737E56450B768D1A23A5BBEEA6FD6DEBF45
            1FEBF7688D85A617D566D9B265762FC7952B57BA3FFFF9CF4D3E861A4C3485D5
            2B4872AC7D0CF5F5A495AEA6BA24E867F4B775AFEFA94DB261A37E67BB76EDEC
            AA6FF237F47B9A42D95F8345F74BAA43AA18E9F5AF76CC6AC8A06975548EA021
            747ED1059F0E1D3AB8810307DAC783070FB6AFD557394A2862ACF8F42341CA71
            B0F0C32F849F88DD113FFCEA4349CD9B6FBEB9CA4F6FD09A162466CC98516782
            A42BE3C96B5F6850A8DF5396FD5D94ECA8BAA4014AED6A9506334A7E94F0ACBE
            837D9F3E7DECF875E9D2C5BE67F52A555328FB6BB0E87E492C7CEF7BDFB329A4
            4943068034742166D34D37753D7AF470A3468DB2D757DBB66D33FD6C1163C5A7
            1F09528E83851F7E21FC44EC8EF895D74F4989FC3EFFFC734B66540DD1BD9296
            152B56587547951B557874D3E7C9F7E85E9F27498DFC9414A87224E6CF9F5FEF
            DFAC3D00D45572FD1E559E6A274E454549910629AA2ED5BE8AAB7501C90EF6AB
            4FF3536224941CE97B5439520549CFB71225FD9EE43EF938B9E9EFE87B75AF9B
            7E469F2BC912B1BF06ABD52FA9A24E9830C162EBC61B6FB4AA9192A4DA155680
            D5D1C596D6AD5BDB7963FFFDF7B70B2943870EB5B84FAB1C251429562AE14782
            94E360E1875F083F11BB237EE5F553872C253B4A6694B428B9D1BD929E9A9A1A
            B774E9524B9E940CE963DD34CD6DF9F2E5AB1221A83CAA382971EAD8B1A3253E
            4AA074D3637A4D6850A4A44C3755A3F4F90E3BEC603F1BFB6BB05AFD92F3BFDA
            30EB22C15B6FBD45620499509C2B39DA69A79DDCD5575F6D175D743EC8439162
            A5127E2448390E167EF885F013B13BE2572C3F5D8D560548894FB28621591754
            FB5E5F57B2A30A91921D0DCE962C596295A34F3EF9C49221FD7C5229D2BD6E4A
            9C928A0F340F1A1029E9D1F3AF81505249D24D49922A47BAD74D536EF4B9166D
            0BBD1EF41AD4741C9154AFF47972C559F7BA22BDFA5E29AB53961809E9A7E74F
            CF89F63712E79E7BAEC5932E56E87180FA50E54831AA18EFD7AF9FEBD9B3E7AA
            CA51DEA9B845881512A4480E167EF885F013B13BE2572C3F252EC9D568558234
            E8D2E7E2D5575FB5FBA953A7DAE34A827CF9417C68E0B4C9269BD873DCAB572F
            7BAC6FDFBE76C559FBA5A869843696D4BD3ED714BF86284B8C84F2D3EFD173A2
            0B0FAA1C89E9D3A7D7B9560F6075543D56BCEEBBEFBEEEBCF3CE6B54E52821F6
            5821418AE860E1875F083F11BB237E61FD3478D24D951EBD196A0A9C921F3D56
            7B6D505231D2D7D508418FAB32A47B7D2EB4005C2861D2F76BFA1C095279D160
            3C6908A1ABCE62F3CD37B7C7BB76EDBAAA2AA5ABD2FA5CD5A5646D5372B53AF9
            385903A5DF97759D4316AA218685E250D559558A14AFC3860DB3C767CF9E4D82
            040D92AC35ECD6AD9BEBDDBBB7FBD6B7BE65DDEA1A53394A8839569AC3AF1409
            927E5E7F3CD627133FFC9AE297FC8D981DF10BEBA72A8F0650C926A9BAE29C6C
            20A9A9744A825429D2DF4A3AC8013416C540D21D4B376D40D9B97367BB7AAD2A
            93D63E689D932FAA21869518259D1A4F3FFD748B67C5314016D484411726BEF3
            9DEFB8EF7FFFFB76C1A2B18951ECB1D25C7E3E12A4A6B85241C20FBF143F11BB
            237E95F54BD61D24EB8554294A3ED7404AEB82F4980657429B48264D159420E9
            6F287952C2545FE73880AC68BD93065F9A9AA79BA6DDA93984F6B8EADEBDBB25
            4B4A9492CE79C9BD48F66C4A2A4C59F6702A430C374452D9556CEA62C68F7FFC
            637B4C710CD0108A1FC5D7669B6D66172BF6DB6F3F77FCF1C77FA34366638831
            569AD32F7805A9A6A6C66B8294B633705E34F0C00FBF907E227647FC2AE7A781
            92A6DC88575E79C5EEDF79E71D4B9A5E7AE9254B80DE7FFF7D9B0A0710139AEE
            B9DB6EBBD9206EBBEDB6B3C7927B75D7D2E39AB697D6F8A1E831DC108A63C5AE
            A6D19D73CE395649527C036441172854B9D574CC134F3CD1BA873675A3EB84D8
            62A5B9FD7C2748795D5BFCED6B2AF2CF85F887F0C3CFB79FCF20AD94A34FAACD
            AFF67E37C93A83A46294AC2D4AA6C5A97182D095E5DA0992D60FE91E2026340D
            2F4984B6DE7A6B7B2C997AB7EDB6DBDA02724DC7D374205D0517494529F95CDF
            137B0C37C54F95235DB5D6DABFB3CE3ACBD61E51398234F4BA13BAC0A029AE4A
            8E8E3DF6586BD0E073FD5F4CB1D2DC7EA1C75EDE13A42295EFF0C32F8B9FEF20
            ADC66318B39F06444A7092F507DA0872CA9429F6B9EE933D8800CA88D64E2809
            52C2A4C189EE355D4FD3853A74E86057C7356DCF27319C6314F7498C5F78E185
            F671D22005200D5D58D0545725D5071D7490558DD4863FF6F7BB22F9851E7B55
            2C414A1646F93C58F8E117C2AF52415A4DC730663F1224A86642264821CF3124
            48D0149A3B41AA96F7E3E64890B2BA5241C20FBF14BFD05731B238FAA46C7E9A
            FAA6060A3367CE741F7DF4917BF7DD772DE1D19A83F7DE7BCF064A49F385648A
            5D7DF7006544719A4CA95BFD5E499362586B2DD4F8410995D63129714AA6EFE5
            DDE725E43926498C9E7AEA2977F3CD37AF9A5E27887348436DBCD520E5A28B2E
            B256DE9AA29D74AB8BE1FDAE218AE6177AEC4582841F7E297EA183348BA34FCA
            E69724486FBCF18625485A80AD044989926E5A949D244800F0CFE82AB962586B
            2D920469871D76B0044903442552FA9E3C843CC728D6757BE28927DC0D37DC60
            9D25933DC800D250355509D1C891235DFFFEFDAD6A94343989E1FDAE218AE617
            7AEC4582841F7E297EA183348BA34F8AEAA7044857805F78E105BB4A3C6DDA34
            EB4EA50E74BA4F366CD54D0993BE471FCB912BC70075A3F8D014BCD55B8627F7
            5A90AEC449F71A30EA71B53A16AA34D5D5463CC439464991627EE2C489EEC107
            1FB4B6FB6AC6906CE60CD0104A8CF45ABEFCF2CB5DCF9E3DED42812AA749A555
            F07EECD72FF4D88B04093FFC52FC42076916479F14D5EF8F7FFCA3DDFFFEF7BF
            B7C1903ACC2931A2053740E55062B4D5565BD9FD3EFBEC6303C6C30F3FDCBED6
            AF5FBFA81224DDC68C19E3EEB8E30E5B6B98B4EF0748A3478F1E7641E0A69B6E
            B28E90EA10B9FA6B9BF763BF7EA1C75E2448F8E197E2173A48B338FA24463F5D
            E1D5E046D36194F8E8E3D75F7F7D55AB6DA10D1EC5D2A54BEDAAB092A2640348
            9FCF1F00FC0325444A8E749FAC454A627E8B2DB6B0C7D55A5CDFB3CD36DBD874
            BCCD37DFDC6DB4D1465EFE7EDA3946F1AFF3C4D8B163DDA449936C3ADD5B6FBD
            658FA9A204D0105A73A444E8CA2BAFB4E625BD7AF5B2E448AFEBDAD523512DEF
            C7CDE5177AEC4582841F7E297EA183348BA34F62F44B1656CBED77BFFB9D7DAC
            A9745A3FF4E4934FDAF72831028078D0BA250D22B55649EB3634054FE70375CA
            53D3071FA49D6374AED0F9E3AEBBEE72A3478FB64E950B162C087D68A020F4EE
            DDDB5EC37AFDA8735D5D95A3846A793F6E2EBFD0632F1224FCF04BF10B1DA459
            1C7D12BAC3946E5A1FA0418C9A29E86A6FD2694A577D5529D21AA29A9A1AFB99
            8F3FFED8EEF51800C443B261A6CE011A64EA5ED39434C8D4D79440A9D9832A4D
            9B6DB6995595943869009A75B3CDFACE3149E54853EAD4CA7BFAF4E9762EA9DD
            B512A03E543912D75E7BADB5F04E92FCBA2A4709657B3F0EED177AEC4582841F
            7E297EA183348BA34F62E830A569304A887453A548577DD5740100CA83AECE2B
            21523387BE7DFBDADE4B9AC2D4B265CB55AD93D3A8EF1CA3EE954A906EBCF146
            9B5AA70B2E3A8F006441EB8CC4FFFEEFFFDAD451B5F3AE2F314A28DBFB7168BF
            D0632F1224FCF04BF10B1DA4591C7DD21C7E4A82B43E48899006324A84347851
            C548F77A4CEB8D74D3E7FA7E2DAA0680F2A0F5484A84DAB56B67E7097D9CECBB
            A464491F6BA0AAC7B56E2959EF549BD5CF31C9B945D3E9745E993C79B2DD6BAA
            1D95236808BD963A77EE6CF7EA56270E39E410AB6826ADBCD37EBE88EFC7B1FA
            851E7B9120E1875F8A5FE820CDE2E893E6F04BAEEE4E9D3AD5A6CC6910A36449
            6D77E92C0550DD6831BC2A4A6AA5BCEFBEFBDAD5FB5D77DDD5CE27ABEFB9B4FA
            392639B75C7AE9A5567DD6F9848B2B9005B5B3570553F713264CB0C794A467A5
            A8EFC7B1FA851E7B9120E1875F8A5FE820CDE2E8139F7ECB972F373F253E42D3
            E43478D1155D5DCDD55A235DD9D5F417FD5D0D6454350280EA456B94B4364953
            9BB44E496B40942CE92ABE36A95525497B2F0975C6D3F726D521558E745ED100
            57175D743EA172040DA184A87DFBF696889F7EFAE9F6FA3AEEB8E3EC6B59D7C2
            89D8DF8F8BE6177AEC4582841F7E297EA183348BA34F7CFA6970A22B70DAB55E
            D35EB4605A09915A73930801401E5AB76EED8E38E2081BC0AAB2248E3AEA286B
            EEA0F389CE31679E79A6356348922380349480AB518812ED5FFCE217F6589ECA
            5142ECEFC745F30B3DF62241C20FBF14BFD0419AC5D1278DF55377A84F3EF9C4
            5A6FAB62A4AE72EFBCF38E0D6A66CC986183177592520549D35EB8AA0B007950
            F306AD495282A401ADD871C71DADE294F0D0430F590549D568CE31D010AA48AA
            4AD9A143073768D0207B1D0D1E3CD8BE96A7729410D3FB7119FC428FBDA24E90
            7412D47C631D24FCF00BE5A77B62241DCDFD9F3973A6ED47A44D199508A97224
            D8A308002A81A645095DF1D7F950C9111BC04216941CA99DB71A80DC76DB6D75
            AE71CB434CEFC765F023416A48AE60D92E7EE5F40B1DA4591C7D92E697EC23A2
            A4471DE6962D5BE63EFAE823BBD7B416AD3B52F305558CDE78E30D73E44A2E00
            54024D8FD23926690BAE6975BA3803501FAA1CE9F5A2F56DFBEDB79F3505193A
            74689D5D12F35094314D51FC428FBD4890F0C32FC52F74906671F4499ADF9225
            4B6C93D6D9B3675B97283558D0BDA6D6B1CF080000C48CDE33951CF5EBD76F55
            3BEFA6548E128A32A6298A5FE8B197D70449BF47576F7C1EACC62C94C30F3F9F
            7E3E83B448C730B90AAB4A912A404A8CF4B1D61929115262A4B546FA5C53EBF4
            FD2C8A0600801851E5481522EDB1B5DB6EBBB99E3D7B5AB7BADA15C8A6509431
            4D51FC428FBD5AD4D4D4784B9092F99B3EE7376A50861F7E21FD44EC8E95F04B
            F61351630525439A36A7660B73E7CEB536DD0000004541D5096D04BBF7DE7BBB
            1FFFF8C7B601EC269B6C5288F7E36AF4F3992035C6B5C5E2C58BBD2648452ADF
            E1875F163F11BBA30F3FAD2D4A7E8F3E4EF6285232A48A51D23A578FB3992B00
            001401ED73A4EA912A47EA82B8D34E3BD99A233DAE04C9274518D314C5CF7782
            94D79504093FFC52FC44EC8E3EFCE6CF9F6FADB99F7EFA69B768D1223771E2C4
            55EDB8E90A0500004544FB64A995B7F6D0FAC10F7E60EDE235A52EE6F76351ED
            7E24480D90CC1954372CFCF00BE5A7FB32C688A6D089CF3FFFDCEEDF7FFF7D4B
            90B489ABF61051A2A4A9754A90E80A0500004542152275A6DB6CB3CDAC29C380
            0103DCF1C71F6F53EB2A912015654C53143F12A4148A94EDE2574E3F11BB635E
            3F253C8F3CF2887DFCCB5FFED23E57273AB5E8060000283A1B6FBCB16BD7AE9D
            6DFEAA660C49E5282196F7E3FAA8763F12A41C070B3FFC42F889D81DD3FC7445
            26A90269BA9C2A458F3EFAA87D3E6EDC38FBDA94295348900000A0D0240BF1B5
            E6A87DFBF656353AF6D8636DCFACDAFB1C55EB98A6287E2448390E167EF885F0
            13B13BD6E7A7C44753E8D48AFBF1C71FB736DD0F3DF4907DBFA6CF0100009489
            2E5DBA58C7B233CF3CD31D72C821DF488C12AA754C53143F12A41C070B3FFC42
            F889D81D49900000004890CAE2478294E360E1875F083F11BB63E2A7058EFAFC
            CD37DF74BFFDED6FAD25F773CF3D6753EC92858F9A5E0700005026BA75EB666B
            8C2EBAE822D7BF7F7FD7A64D9B063780ADD6314D51FC4890721C2CFCF00BE127
            62774CFCB4C95A4D4D8D25485A63A42AD1B3CF3EEBF5EF010000C446F7EEDD2D
            21BAE4924BDC6EBBEDE65AB76E6DFB1FD547B58E698AE2478294E360E1875F08
            3F11ABA3F629527BEE175F7CD1BDF2CA2BB697913ED7D4BA65CB9659D588C60B
            000050565439D214BA912347BADEBD7BBB8E1D3BBAF5D65BCF5A7C3744B58E69
            8AE2478294E360E1875F083F11ABE39C3973DC7BEFBDE79E79E619DBBF480993
            3E070000A8067AF4E86195A21B6FBCD1F5EDDB37B5729450AD639AA2F89120E5
            3858F8E117C24FC4E2A82448EB8C74BF70E142F7D65B6FB90F3EF8C01A31E8A6
            16DE548C0000A0ECA872A44D5FAFBCF24ADBF368CB2DB7B47547AA1CA5558F44
            B58E698AE2478294E360E1875F083F118BE3534F3DE5162D5A64F79A4E3763C6
            0CBAD1010040D5D1B3674F4B90EEBCF34ED7B56B574B8EF47956AA754C53143F
            12A41C070B3FFC42F889508EEA40A7F54463C78EB5CAD1ECD9B3DD175F7CE1FE
            1EB7EE2F7FF98BFBECB3CFEC1E0000A01A50E5485C7DF5D59614F5EBD7CF9A33
            64AD1C2554EB98A6287E2448390E167EF885F013A11C95182941D2DC6A25456A
            DBAD6974000000D5C8D65B6F6DF7A3478F76EBAFBFBEDDF2244609D53AA6298A
            1F09528E83851F7E21FC44251DD5694E5520DD34754E9F6B8D9198366D9A7DAE
            B546C9F724FB1901000054034A8036D96413FBF88A2BAEB0FB0103065833862C
            0D19EAA25AC73445F12B4582A49FD71F8FF5C9C40FBFA6F8257FA3528EAA1069
            AA9CA6D0DD71C71D9600E9CA98D03A2312220000A866B4B668ABADB6B2F7D2DF
            FCE637F658632B47D53EA6298A9F8F04A929AE5490F0C32FC54F54C2315953A4
            BFF1D8638F597568EAD4A99610CD9A356BD5F700000054234A8C36DA6823DBD7
            E8BCF3CEB335B8DFFDEE77ED6BDAFBA82954EB98A6287EC12B483535355E13A4
            0D36D8C0EBC15AB26489D703841F7E79FD44251CB59E48FB1769EFA2EBAEBBCE
            12235592000000E0EB2448EDBB37DC7043377EFC787B4FF6F53E5FAD639AA2F8
            F94E90F2BAB6F8DBD754E49F0BF10FE1879F6F3F5F419A3459D0E6AE6FBFFDB6
            ABA9A971EFBCF38E39AB5B9D12A4152B56783D1E00000045A365CB963685AE7D
            FBF6EE7BDFFB9E6DFE3A74E8507B4F6E6AE5A836D538A6298A9FCF04A931AEDE
            13A42295EFF0C32F8B9FAF20D5B4B9575F7DD51A30FCEA57BFB20D5DB5A71100
            0000FC03B5EFDE74D34D5DF7EEDDDDEDB7DFBE6AF05C8431037E7EFC7C274879
            5D2B9620250BA37C1E2CFCF00BE1D7D82055F2A335446AB4A0CD5C75AF24E9FD
            F7DF77AFBCF28A5BB972A55BBA74A9D7FF1F0000A0A8A872A4E4A873E7CEEEC0
            030F741D3A74B0CA919A31A88A548431037E7EFC2A95206575A582841F7E297E
            8D0DD22953A6D874BA499326D95A23254B49D307000000F86734ADAE6BD7AE6E
            BBEDB673D75F7FBDBDFFB66DDBD6BE569431037E7EFC4A5B41AAC4C1C20FBF10
            7E598374E1C285B689AB2A454A86B477913ED65E46D3A74FB72E753461000000
            F8675439D2DA222547FDFBF7779B6FBEF9AACAD1BAEBAE6BDF539431037E7EFC
            4890721C2CFCF00BE1973548B5C9ABA6D53DF8E083961CA929030911000040C3
            E8BD56D3EAF6DC734F77E18517BA35D75CD35A7BD7A6286306FCFCF89120E538
            58F8E117C2AFBE204D921F4DA3D366AF2FBCF08225459A523777EE5CAB2269CF
            06000000F826AA1C69AF233564E8DBB7AFDB61871DBE51394A28CA98013F3F7E
            2448390E167EF885F0AB2F48B5A9AB12A311234658FB6EDD34C50E000000D2D1
            26B06AC470F8E187BB33CE38C312A6D513A384A28C19F0F3E3478294E360E187
            5F083FDDABE35C92FCA84A24D4844109D235D75C6353EB74234102000068184D
            A1539568B3CD36B3EAD1BEFBEEEB4E38E104AB269120E1977C4E8294F160E187
            5F083F6DE0AAC447CD16F4F155575D655F7FFAE9A72D4102000080EC6CBCF1C6
            AE5DBB7696146923D8862A4709451933E0E7C78F0429C7C1C20FBFE6F4D3EF51
            7B51AD235222A44D5E9520DD78E38DF6F5C9932793200100006424D97F465523
            4DAD1B3468901B3870A06BD5AA9575B14BFBD998C70CF8F9F52341CA71B0F0C3
            AFB9FCD492FBA38F3EB2460BD75D779D5590B49711000000348E2E5DBAD885C7
            E1C387BBC30E3B2C53629410F398013FFF7E2448390E167EF835971F09120000
            805F4890F0CBEA478294E360E1875FA5FC94002D5BB6CCBDF1C61B6ECC9831D6
            914E09911C35AD4E24F7000000909D6EDDBAD9BE46E79F7FBEDB638F3D5C9B36
            6D32274609318D19F0ABBC1F09528E83851F7E95F24B12A4D75F7FDD8D1E3DDA
            2D5CB8D0FDFEF7BFF7EA060000508D2409D245175D640952EBD6ADDDDA6BAF9D
            EB77C43466C0AFF27E2448390E167EF8F9F67BEDB5D7AC6A347DFA746BBAA024
            A9A6A6C6AA45CB972FF7EA060000504D283152A568E4C8916EEBADB7B67D8F94
            28A9C5775E621833E0D77C7E24480DA000D25CD5A4EB097EF8F9F67BF9E597AD
            3B9D6E4F3EF9A475A55392040000004D63F3CD37B704E9861B6E70DB6EBB6DA3
            2A4709318C19F06B3E3F12A486E40A96EDE217AF5FB27E68FEFCF96EE9D2A5EE
            D1471F7553A74EB5460CDAE055ADBCF5B8F0190F000000D5863680D5A6AF975F
            7EB9EBDCB9B3DB628B2DDCFAEBAFDFA8CA5102639AEAF22341CA71B0F0C3AFB1
            7E49823467CE1C9B42F78B5FFCC29A30A84B5D921801000040D3D96AABAD2C41
            FAD9CF7E66D3ECD494419F3705C634D5E557AA0449BF47034E9F076B830D36F0
            7670F0AB3EBF4F3EF9C4A6CD3DF2C8236EC182056EE6CC99F6983E56A2A4AFAD
            5CB9D29B03000040B5A2CA91B8E9A69BAC62D4AB572F4B8E54396A4AF54830A6
            A92E3F9F0952635C5BFC7D90E82D41D23FE37B7EE392254BBC1E7CFCAACB4F53
            EAD4A1EEE69B6F76B367CF76D3A64DB30E75000000E017356210FFF33FFF6383
            DDAE5DBBBA35D75CD3DBEFAFF6314D35F9F94C901AE3DA62F1E2C55E13A42295
            EFF02B9F5FB2F873D2A449561D9A3871A25D3578FBEDB7ED5E7F4F9BC0020000
            40D3D17BAFD619896BAEB9C6EEF7DF7F7FDB04B663C78E5EFF56B58D69AAD9CF
            778294D7950409BF52F925DC76DB6DD678E19E7BEEB1260C000000E01F558834
            954EA80192D0F43A3D1EFB9801BF78FD48901A209933982CB0C70FBFBA50A5E8
            CD37DF34BFC71F7FDC1ED39E469A5A3763C60C2A460000009E5102D4BE7D7B6B
            DD3D62C4087B6CD0A041B6D648B339621D3324E017B71F09520A45CA76F10BE3
            A7044857ADE477F5D557DB635A7BE4EB2400000000FF8CA6D025EDBB478F1E6D
            8FADBEC83EC631037EC5F02341CA71B0F0C34FA862F4F9E79FBBCF3EFBCCBDF8
            E28B5629FADDEF7E675F53EB6EE1F32A090000007C4DCB962D2D116AD7AE9D3B
            E184136C23D8C18307DBD7F471422C6386FAC02F6E3F12A41C070B3FFC842A46
            1F7EF8A1DDD44A5409D2F3CF3FEFD50B000000BE89A6D4A99DB73AD4DD79E79D
            AB3A84AD4E2C6386FAC02F6E3F12A41C070BBFEAF653FBC73FFDE94FF633AFBC
            F28A7DFED8638F5945E9BDF7DEF3EA05000000FF409523ED69D4A9532777E8A1
            87DAFAA3A14387DA9AA3DA95A384D0638634F08BDB8F0429C7C1C2AFBAFDB48F
            D1934F3EE9E6CD9B677B2C680A9DA6DA0100004065D15A23558DFAF4E9E37EFA
            D39FD65B394A083D664803BFB8FD4890721C2CFCAACB4F6DBA972F5FEE3EF9E4
            13B760C1026BBCF0C20B2F58DBEEE79E7BCE12247D1D0000002A832A47AA1029
            39FAF6B7BF6DD3EB4E3EF964FBDABAEBAE5BEFCF31A6C1AF297E2448390E167E
            D5E1973457F8F39FFF6C899192A271E3C6D994BA0F3EF8C0EBDF07000080FAD1
            FBBE3682557274E9A5975A7BEFF5D65B2FF5E718D3E0D7143F12A41C070BBF72
            FB2931D24D89D0D2A54BDDDCB973EDA6BD8CD49D4ED3E9162E5CE8F5EF030000
            C03751E568ADB5D6729B6EBAA9DB669B6DDCF6DB6FBF6ACD514395A3846A1FD3
            E0D7343F12A41C070BBF72FB694ADD8A152B2C197AFDF5D7DD4B2FBDE45E7EF9
            65AF7F0F000000D2D968A38D5C870E1DDCC1071FEC7EF8C31F5AC29425314AA8
            F6310D7E4DF32341CA71B0F02BA79FD611A972A4B6DDAA1C29319A3973A67BED
            B5D7DCF4E9D3BDFE3D000000A81F4DA15395486B8D74DB7BEFBD6DBF23559348
            90F06B2E3F12A41C070BBF72F9292992DF3BEFBC6389D11D77DCE1FEF8C73FDA
            6374A7030000687E36DE7863DB04F6BBDFFDAE1B326448EECA5142B58D69F0F3
            EB478294E360E1570EBFA40983367CFDFBEBCFBDF5D65B9620DD7FFFFD6EDAB4
            69B6068904090000A0F950D548EFF3EA56A7BD8E8E39E6184B92D65E7BED3AF7
            394AA35AC634F855C68F0429C7C1C2AF1C7E9F7EFAA92549F7DD779FB5EEFEE5
            2F7F691BC00200004018941869AFA361C386B9238F3CD2B56AD5AA51895142B5
            8C69F0AB8C5F291224FDBCFE78AC4F267E71F99120010000C485AF04A9DAC634
            F855C6CF4782D414572A48F8359BDF983163ECFE9A6BAE719F7DF699ED71A4AE
            75BEFC000000201F6AC4A07D8D2EBBEC32B7F3CE3B5B52D494CA5142D9C734F8
            C59F2035C5B5454D4D8DD70469830D36F07AB0B41E05BF72F88D1E3DDAEE9304
            495DEBFEFAD7BF7AFD7F010000203BB513A45D76D9C5B56EDDDAD61D3595B28F
            69F0ABAC9FEF0429AF6B8BBF7D4D45FEB910FF107E71F8690A9D9220355B1839
            72A43DF6D4534FD9BD1ED3D7A91C01000084A15BB76E5629BAF4D24BDDB6DB6E
            6B7B1E75EEDCD99A35F8A22C631AFC9ADFCF6782D41857EF095291CA77F855CE
            4F09903AD329493AFBECB3EDB1DFFFFEF75E5D000000A0716CBEF9E696206956
            C78E3BEE68ADBC3B76ECE8F56F94654C835FF3FBF94E90F2BA562C414A1646F9
            3C58F8C5EF575353E35E79E5156BDF7DF7DD77BB2FBFFCD2BDF7DE7BF6355A77
            030000844595236DFA7AE595575A63064DB15373066D10CB9806BF58FC2A9520
            6575A582849F57BF8F3FFED84D9E3CD92D5CB8D0FDE4273FB14A128911000040
            1CF4ECD9D312A4FFFCCFFF745B6CB1856BD3A68D7DCE9806BF98FC4A5B41AAC4
            C1C22F3E3F5588B4E1AB3AD2BDF4D24BD67861C28409F6D8BC79F3EC7B56AE5C
            E9D501000000F2A1CA91B8FAEAAB6DADC7F6DB6F6FC991D61C259BC456FB9806
            BF78FC4890721C2CFCE2F35317BA65CB96B9D9B367BB471F7DD41225ED6B0400
            0000F1B0F5D65BDBFD830F3EE8DAB76F6FD3EA6A3764604C835F4C7E2448390E
            167EF1F869AD916E6FBCF186FBC31FFEE03EF9E413F7EEBBEFBA2FBEF8C27DF0
            C1075EFF26000000E447E30075A6136AC6A08468EFBDF7B6E60CABB7F22ECB98
            E6EDB7DFB675D0D3A74F7773E7CE75FDFAF5733BECB083FDEC461B6D14DC2FF6
            E3178B1F09528E83855F3C7E7FFAD39FAC5AA4E44857A35445D20909000000E2
            40E380ADB6DACA3E7EE491476CADD1EA95A3DADF5B8631CD73CF3DE7E6CF9FEF
            9E78E209376DDA3477C41147B8830F3ED86DBCF1C6D69022B45FECC72F163F12
            A41C070BBFF07E2FBCF0825D91993973A6558F9424E963AD455ABE7CB9D7BF05
            000000F951473AED6BD4AA552B77EEB9E7DA6303070EB4C4A8BE4D608B3EA679
            F5D557DDA79F7EEAC68D1BE766CD9A65EBA0172D5AE4FAF4E9634962AF5EBDDC
            4E3BED64ADCCF5B98E45EC63AE6AF62341CA71B0F00BEF377AF468F7F2CB2FBB
            2953A6B8175F7CD1EBEF06000080A6D3B2654BB7E5965B5A13863163C6D86369
            9B84167D4CA3FF53176D1F78E0019B5E97A09F69DBB6AD4DB3DB679F7D2C5152
            454928A18A79CC15FB989004299283855FF3FBE9EA8B3AD2A94CAD13CFF3CF3F
            6F5766F4316B8D000000E24195A376EDDAD96DF0E0C1562DD2BDD0BAA38628EA
            98461D74B5FE59177035B54EE31575D44DD0FFAD5B32C54EB7DD76DBCDD62325
            8D2B944055CA2FF6E317AB1F09528E83855FF3FBBDF5D65B7685E5BEFBEE7353
            A74EB592356B8D000000E2A375EBD696006CB2C926B659BBC6015907FF451DD3
            DC7AEBADB6F7E2430F3D6409521A4A94B6DB6E3B9B6677D24927D9BAAC2E5DBA
            54CC2FF6E317AB1F09528E83855FF3F92911520B6F2D7254B5488B1EE7CC9963
            9DEBD8F8150000201E34A54ED3E93A75EAE40E3FFC70AB200D1D3AD4D6D9A455
            8E128A36A6D1055CAD7FBEE9A69B2C41D2D47FFDBD34943076EDDAD592C87DF7
            DDD7ADB7DE7A565152A2B4E9A69B7AF38BFDF8C5EE478294E360E1D77C7E9326
            4D32175D9951CB4C95AF752202000080B850673A0DFA35654C09439ECA5142D1
            C63477DC71872D01B8E1861B2C41CA8B12474DB3534569D8B061F6F921871C62
            5FABABCB5FD98E5FEC7E2448390E167E95F353B54868EEAE3E7EEAA9A76C6ADD
            C48913AD82A4C74890A02EF43A4BAE52EA8ADC575F7DE5962C59625FD31A3600
            00A80CAA1CE9DCABE468F7DD77B7FB534F3DD5BEB6EEBAEBE6FA5D4519D36863
            7A71F3CD375B82347EFCF84C95A3D5D1FA2C558F546D1B30608075FC3BECB0C3
            ECFDAC6FDFBEABBEA76CC7AF287E2448390E167E95F34B4E2EC3870FB735466A
            E7FDD9679F79FDDFA09C6851B0DE88D53A55533B56AC58B1AAF5FBB3CF3E1B5A
            0F00A0B4E83D5E1BC1F6EFDFDF8D1C39D2CEC71AF43786A28C6934B3455C7AE9
            A536BBC5175ABFA53D9394205D7BEDB5F6585AE7BFBAFC7C52CD635612A406D0
            8B5425621D24FC2AE3A72A9150030671DD75D7D9639ADBEBF3C403E5416FC09A
            ABADF9EEEDDBB7B73715EDB7A13712B551D51AB5C71F7FDC2A49B55BAD020080
            1F54D9D079B85BB76ED67040158F934F3ED9DEF7F3568E12621ED3E8FDE4A38F
            3EB2A9843FFDE94FEDB17BEEB9C72A48BE500529598BA48BC562DB6DB75D9574
            A64DBB8BF9F815D18F04A921B98265BB45F3D315FE24313AF1C413ED734DA763
            2A1D3484DEA07412DB71C71DED6A9BAE5EEA4D451547558EF41A3AE59453426B
            0200949664EDCC01071CE0CE3AEBAC26558E12621ED3E882ED830F3E6849CC79
            E79DE7D5B12E92AE76B7DD769B5D0454A254D636E9B1FA9120E53858F8F9F153
            02A46974BA9F3C79B23D76C10517D8151AED1DA07B8004BD21E98A9AEE75D572
            C30D37B4CA911603AB0390AA474A96D4E15053337595EFFCF3CF0FAD0D00503A
            742ED64DADBCB511ECAEBBEE6A1738F558632B4709318E69344ED17BCBB265CB
            DCFDF7DF6F49CA8D37DEE8D5B12E947C0A4D5B4C2A4B4A94748C75AC8B72FC8A
            EC57AA0449BFC7F7AEC479E67FE297CD4F0BE793C58DC95C5E80FA5022A4370B
            2541FAB877EFDE6E9B6DB6F9C6F7CD9831C3A625680DD23BEFBC135A1B00A074
            E85CACEA9192A2EF7FFFFBF63EAE81BB0F621CD3E882DB9D77DE690992EE9B1B
            CD9810175D74915D0CDC6BAFBDEC02615DD3ED623C7E45F6F3992035C6B5C5DF
            33736F0952D256D2E7FC4675C3C2AFE97EAA0AE9A632B5AA473AD1A8339DAEC8
            00D4465D91345D43D522BD092819D29BF24E3BED641BEBE9AA65ED0449AF2BBD
            96B4DEE8B4D34EB38F67CD9A15FADF0000280D49B75075A9D3B4E6A38E3ACA1D
            7FFCF1962CF94A90442C639AE47D45B35A7421576317AD396A6E92698B175E78
            A11DEB030F3CD0EE55C9D2F3B17AA214CBF1AB8F22F9F94C901AE3DAE2EF8365
            AF095291CA77D5E2A72BFA5A38AFD698D75F7FBD9D685E7EF965AF7F07CAC3A1
            871E6A6F00BAD7A6794A88F4797D6803E1091326B8B973E7BA51A34685D60700
            281DDA424157D77511EAE8A38FB6695F4A8CCA3AA6993F7FBE1B3B76AC2548CD
            31A52E2BAADC29493DE69863ECBD5153EE6AB7028FE5F8D54791FC7C2748795D
            4990AAC08F0409F24082040010172448714082D47C7E24480D90CC19F4D534A0
            9AFC9296986FBEF9A69B32658AFBC94F7E628F295102A8CDB1C71E6B8B4E7FF0
            831FD8EB4FD3E8347D20795DD7D7DA54D31F946C6B5361BD69EBFBD93B0B00C0
            1F6AE3AD695E3FFAD18FDC7EFBED678951D24DAD8C631A4DCF7EECB1C7EC82EE
            EDB7DFEEEF407A46170F35656BC890216E8F3DF6B0CF35F531F4F16B88189EDF
            3C7E2448291429DB8DC94F2FB0850B17BA37DE78C3FDF18F7FB40449DD60B4D0
            11A036AB27487DFAF4B12B62791324BDBED83B0B00C01FCD992089D0639A2227
            48AAF2853E7E6914C98F0429C7C1C22F1BD3A64DB3AA916E2A51AF5CB9D206AE
            3EDB254231D1948C830E3AC89A309C71C619F6D8165B6C61AF3D4D15D0E36AE3
            9D85975E7AC93DF4D04336B56ED2A449B4870700F08412232542975C7289DB7E
            FBEDEDBCAC7374ED0B56651AD36873FAE79E7BCEC62F7A5F499A4AC54AD2A041
            CF912E300E1C38D0A6A577ECD8D1BABD36F7F1CB4A8C63D6FAFC4890721C2CFC
            B2A1C448FBD168003B66CC18AFFF2F149B366DDAB8C30F3FDC2A4423468CB0C7
            74E52B79D3CDF31AD41E5AF7DD779FCD157FFAE9A743FF6B0000A561F3CD37B7
            C1F755575DE576DE7967BBB8557BAD8B28D398465D50F53EA204491BC2168DE3
            8E3BCE364ED706B3756D83D118CAF4FC36C68F0429C7C1C2AF6EB40F82A63B69
            A1BC06AD2A4DBFFDF6DB76F545F339A17A5173857EFDFAD9FE0D3A79EB4A57CF
            9E3DED6BDACB41D47ED3CDF21AD46B4AB7F1E3C7BBCB2EBBCCA6D6B1F60800A0
            E9A872A4F3F4E5975F6E9BC1EA0296F6E2A96FDF9DA28F69742157B7575F7DD5
            A66B6B3C2387A2A1E976BA6DBBEDB66EF7DD77B79919DFFEF6B79BB4816F199E
            DFA6F89120E53858F8D58D12212548BAEAA2B9BBEA2AA624094073A2F7DC734F
            DBC74873A575B256079EFAC8F21AD46B5E7B6969FAA6F6860000003FE80296CE
            D3FFF11FFF615DD254F5D7E7755186318D9222558E94203DF1C4135EFF971068
            BF40BDE7AAD951329D3DD94B292F65787E9BE2478294E360E1F7CFCC9B37CFAE
            DC8F1B37CECAD24A8A34DD495760629EBB0B9543F39F9514F5EEDDDB16F4EA8A
            96AE42AA4AA42449240B7CEB22CB6B50F3C4F5A6A6D79CAA960000D034543912
            575F7DB56BD7AE9D5522941CD5B519694291C7345A06A075479AF5A29BC632BA
            F0567454EDD3FBAE2E44EEB8E38EF67EBCFFFEFBDBFBAEDE8B7D1DBFC652A431
            3509528E8385DF3FA36974FAFBB7DD769B0D5AF53153EAAA1BBDC9EAAAA3A6D5
            694EB4E6AD77EAD429F3CF67790DAA4AA9B56D4AC8F5260700004D4317B59408
            3DF0C0033625BAA1CA514291C734BAB8A6A9751ABBE85636744152CD1AB4966C
            D0A041F67CAA436C1E8AFCFCFAF02341CA71B0AADD2FE912A6C58CAA10694A9D
            06A9BA2D5AB4C8A6D9693D08540FBA4AA5CD0375E2EDD5AB975DADD29C75753C
            D2D7F406DB50C568751A7A0DEA0A5FF2BA53FB557DAED71D0000E447E75B9DB3
            852A473A5F6B7A56D219ADBECA51ED9F2FDA984653E9B4F9AB66BEE8029BDE43
            CAF83EA276EC7A6FD6AD6FDFBEB61E589BCB6A36872A4B8D3D7E4DA548636A12
            A41C07ABDAFD920449F374F5776FB8E1064B96A07A51B71C5D6DDC7BEFBD5DFF
            FEFD6DA3BA86D618A5D1D06B50D31FF4BABBEBAEBBA2DAD91C00A088E87CABB5
            2AE2D7BFFEB50D9EEB6BC850DFCF176D4CA31908DAEB480952192B47ABA34449
            C991DE9B870D1B660D1B0E39E4904C3F5BC4E7D7A71F09528E8355ED7E5A14AF
            2BF83AC1E8EFEA4A4C19AFBC40FD686EB3AE2C2A19D27A232D08D5C9575721F5
            B9A6D4E97B1A4B43AFC1648F0AAD3F62ED110040E3D0C27D5DD86AD9B2A5BBE0
            820BECB1A38E3ACACEEDABB7F26E88228D69F4DEA18B6C9A9EADB5479AF9A24A
            52D9D173AD8AA0A6D8A992A47B4D7F5712AC260E598F9F2F8A34A62641CA71B0
            AADDEFDC73CFB513CCC489134BB19811F2A379CD7A033DE9A493ECCAE3B7BEF5
            2D9B4EA7CD8013B25E7DAC8B865E83A3478FB60D6167CC9861C9390000E44789
            91D68AEA82962E7C0A4DC5CA4B91C634FA3FD5444A53B4952C552BAA109E72CA
            29960C5F7CF1C50D7E6F919EDF4AF89120E53858D5E6A76E7442BB4A6B6D91EE
            B5EE43575EE852571D281952C2A34448A579DDEB35B2C30E3B58E528994E57C9
            18D16B4DAFC53BEEB8C3AEFEA96AB960C182D0870600A050A89AA00E754A864E
            3EF9641B240F1E3CD8BE9667AD6842EC631AFD1E25457A0F51F389B973E7DAB2
            806AA81CD5879263CDFCD0737FE28927DA63871E7AE8AAEA61ED0B9CB13FBF24
            48111DAC6AF34B364B3BF8E083AD0183CAD2BA87EA21992E77D6596759A548A5
            F9A45D7742A56364E1C28596986BCDDB3DF7DC13FA9000001412558CD4EA59E7
            F07BEFBDD71E6B4CE52821E6318DD64CCB2F99F1A2C63EECCFF80F746CF6D967
            1FFBF8673FFB9925C8ABAF3F8BF9F96D0EBF522448FA79FDF1589FCC22F96943
            315DA157C5488B18C5ADB7DE6A9FEBAA0B5DEACA8F4E90AA1009558C7465E9C0
            030FB40A92DA77AFBEC6A8D231A2E910BA0A78DF7DF7B9F1E3C7873E3C000085
            425503AD3DD1960B471E79A49DC3870E1D6AE7FAC6548E8A30A6D1FBC68A152B
            ACF984C634DAEB8835D3FF40CF9DA6598AD34F3FDDAA47DA2F4949B46E7ACDC4
            FCFC36C7EBCF4782D414572A4891F9E964A9138B4AD26A0929D8DBA8BA504274
            DE79E7D9C723468CB013A7DE50EB5B5B54E918D1DC71AD39D26EE753A64C097D
            7800000A852A039A0EADBD8E6EB9E5167BAC29CD7412621ED3DC7CF3CDEEF3CF
            3FB7A50124460DA36D3AF4FE7ED34D3759F30E551835168CF9F9154548909AE2
            DAA2A6A6C66B82D49472715D2C59B2C4EB018AD54F53E734954941A2ABF4FA5C
            C122586F546E9410693D911221B5EDD66BE07BDFFB9E7D2D999BAC93657D0952
            A56244D54A4D93D0DA2375B0D3DC71B56705008074744ED7B9BB4B972E6EAFBD
            F6B26EA3A79D769A9DAF3523A0A9C438A649A6D169FCA204E9D9679FE5226F0A
            4A9EF55CAA0DB89E4FAD515252ADCEB479367ACF4291C6D4BE13A4BCAE2DFEF6
            3515F9E742FC4345F4D320547374D53EF9FFFEEFFFDC45175DE4F57F86B8D189
            5053E7F45ABAECB2CB2C11D266AF59A8648C68DD91BAE3A9D38EE691AB5183A6
            4C0000403AAA122939D2E6AF5AC3A98B5D3ADF9771CC95ECD3386AD428BBD77B
            99DE43203B4AA0F51A193E7CB88D0194546B6A660CCF6F7D54F2F5E733416A8C
            ABF704A948E5BB18FC740299376F9E2548DA00F6A38F3E7277DF7DB7D7FF19E2
            42AF1B5D59D4894F578EF486A99DB5757FC20927588294F5AA51256344AFC565
            CB96B96BAFBDD6FDF6B7BFB5AA66ED76E20000F04DB47E44E7789DDF756E5745
            40EB4C746EF739E015318C69941C699DAA48361157D73A66BFE4433349F41AD1
            9E58AA1E1D70C0019664ABF361D9A764D6E5E73B41CAEB5AB104295918E5F360
            95D14FEB8DD484417374B5012C941F2DC054473A6D1AA7BDAD34D5421F37864A
            C6C8F3CF3F6F8D41EEBFFF7EF7E28B2F863E6C00008540E7775DE41A3060803B
            E79C735CFBF6EDAD0193A8D4A02FE49826D90642E83D0DFC3070E0404BB20F3F
            FC70B7DD76DB599BF8A650B43175E858A182D4CC7E49195A9523558DD4BAFBAE
            BBEE322F757981F291AC1DD25C7425432A21EBA4D7A3470FDBF0B555AB56ABBA
            D9E4A59231F2E8A38F5A75534D1AAA79633F00802C6800AB29529A1EA5F3FB6E
            BBEDE6860C1962958164CD51E8ABE20D91F7FD44EB54F5F79520DD76DB6DF658
            524182A6A3EEB54AB4D5DD4E1751933DB4446336842FDA983A74AC902035B39F
            4E24BA3DF3CC3376C5459523750883F2A2C448D32D7405688F3DF6703D7BF6B4
            12BA4812E6C69CEC44256344F3A0D59C419F6BB12D0000D48FA645A95AA42BFF
            DA083669EF1DD3A0AF21F2BE9FE822EF830F3E6853E92EBDF4527F0712FE09AD
            635372A4D6F0C71E7BAC5D542DE3C6C224484D385845F6D34058377573D14D03
            4FED2BA30469C68C195EFF47888364576C4DADD04D1DEAFAF7EF6F1B051E72C8
            21F63D3126487A4D260992A6D6D5D4D4D85A240000F8263A0F27CD75D4A2F93B
            DFF98E3BFEF8E3AD9A54C60449EF5B4A8A6A27486A42019541CD1B5439D26BEA
            B0C30EB3F5CAFA5CAFB93C6387A28DA943C70A095233F969AAD282050BAC1183
            DA78EBC4A2C7A0BC2819EAD5AB97DB6FBFFDAC72A4D78AE6A6C71E232FBCF082
            4D01D515C1A953A78638740000852119C09E72CA29DFB8C21FDBA0AF21B2BE9F
            CC9D3BD79606E862DA3DF7DCE3F968427D24154A6DFFA1AD40947C6BDFA4AC14
            6D4C1D3A5648909AC94F271425486AE54D82547E7455470992D616152D415275
            33993241820400D0304A90741ED6B4BA6A4890E6CC996389110952F3523B413A
            EEB8E3AC92448254395712A40AF92553A77422494E225AECAE56C95A8304E543
            532B34ADEEBCF3CEB37D8DB6D8620B3BA1AD4EEC3172E18517DA7E5C7FF8C31F
            AC8B1D00007C936EDDBAD9F46975AA534BE6BAD686C436E86B88B4318D368155
            B75D8D6B92A60CD0FC283152DB6FBDE6CE3AEB2CEB8C9B656B90A28DA943C70A
            095285FC4890AA0F12240080EA810409424082D43CAE244815F2D33A0E0D2ED5
            88411F2B29527294244E501ED4C655AF83418306D9540BB574D59B647D0B2863
            8F917DF7DDD7BDF1C61B6EE9D2A56EC58A15CD720C01008A8212239DE32FBAE8
            22B7F3CE3BDB39586DBCEB3ADFC736E86B88FADE4FB41D89B6215143296D00AB
            710C177AC391ECE1A3D79C9EAFADB6DACA0D1E3CD83ADDA9B5BCC8F25AF40109
            522407AB487E3A9968CD915A79B3BF51B919366C98AD2DD2A249ED6FA42B8AEA
            5E541FB1C7C89E7BEEE9A64F9F6EEB9056AE5C59D16307005034BA77EF6E83D3
            2BAEB8C2EDB2CB2E76055FB307EA22B6415F43D4F77EA2F783A79F7EDAEE9520
            411CA88DBC12F5ADB7DEDA9D76DA699620EDB3CF3EF63512A4A6BB922079F24B
            2A43A3478F760B172E74E3C68DB332B4FE9E069A500E92E60B428991DE14F579
            72254789515ADBCD5863447B73E9B57AF6D967DB6BD7E7790100A0E8A872A473
            FCE5975F6E53A875414CD39D1A3AE7C736E86B88D55D95106993F0975E7AC9C6
            349A05A3BF07F1A0E74C4992BA286A06CBA9A79E6ADDEDD46ABEAEEF2DCA983A
            F99C0429E3C18AD92F499054319A3F7FBEAD37D27C5D28177A23D4BC5FA1B53A
            3A31EDB0C30EB9366D8B3546264C98600992A68D680D120000FC831E3D7AD845
            B15B6EB9C5B670D040B4A1D90222B6415F1ED72953A6D81201DD34A681B8D186
            B2679C718625ED279E78E237BE5EA43175F2390952C68315A35F727254D9591B
            C0EA2A8B9A32A88AC41CDDE2A38448C98F2A446AABA9CF55CA16BA7A986C049B
            67B3B65863E4AAABAE32B7871E7AC85EC30000F075E548E7F82BAFBCD2DA2CF7
            EDDBD792A32C1B75C636E8CBE2AAAA912EF06A5A9DF66ED4D886F784F8519310
            358BD278456B893505EFDC73CFB5AF699C528431754CB14282D444BF040D2EB5
            B7913ABC7022290F4902A49BBAD3E973758D690AB1C688FE3FBD76274E9C68AF
            65000070AE77EFDE76EE57D325750BCB52394A886DD097C555D3AD952429399A
            346992DF8309154789929A35E8FEF6DB6FB7C73405AF0863EA986225EA044927
            24B532AC9D88C4E2A7A948F2BBF9E69BADD3974E247A4C9DEB344F178A8DDE00
            35C75C1DE98E3FFE789B56917487D1E6AF4D21D618D1D441351679FFFDF7DDF2
            E5CBBDF8010014119D53B5A643A872A49904BBEFBEBBDD67596B9AB0FA393AF4
            A0AF3EB44CE0E38F3F36BFFFFEEFFFB64DEDB55C403728167A0E55E9D4B845E3
            17A14D8CF5F9E69B6FEED65C734D6F7FAB92E399D0B11275821473B6BB64C912
            F3D38B4F53E9D40693C4A83CE875B7E38E3BDAC9E4E28B2FB637C44D37DDD4CB
            EF8E3546B6DB6E3B376FDE3C6BEF4D830600A866746E55FB64F1AB5FFDCA12A3
            B4860CF5FD9E98AE8AD745B2865A17C7BEFCF24BAB3A684D2AFB36161B25427B
            EDB5977D7CDD75D75945699B6DB6C95CFDCC0215A4480E56683F9D38743545F7
            3FFFF9CFED31AD39D2E79A92C41E47C54527129D34347F77FBEDB7B7FBFDF6DB
            CF367ADD69A79D564DB5F3416C31F2EAABAFDA6B77E0C0815601554594040900
            AA11BD0F68E680D66FA8118F38E28823ECF1FA5A7937446C83BE8650D7BACF3F
            FFDC3DFCF0C3B6FEE8B3CF3EB31B1413BDD63A77EE6C1F1F75D451F61A3EE594
            536C2CA335D48D793DAF0E095246F47BB498CFE7C1D2BC495F34D54F57535E7F
            FD75BB57A710A129492446C5A7F67E02471E79A49D3CF4A698CCDB2D738CA83B
            91927CADAD62FD1C0054337A2FD0346A5D6DFFF5AF7F6D8F35E51CBBFA393AE6
            F71375ADD3C55E558FD4B94EBF9BB6DEE5408D4574A1F7FAEBAFB77D1B55496A
            EA45DF4A8F6742C74A8B9A9A1A6F0992FE19DF6B8634952DB49F122275A5D389
            42A5670D26C78C19635FD30187E2A213856E7A4354BB6ECD39FFD6B7BE65AF13
            4DAFD0EB4F847E0D36445363E4AEBBEEB20D617FFAD39FF26608005589661168
            A34D0DD0CE3CF34C4B9474B55DE4D9C6A12E6A9FA37D0EFA7CBF9F6886CC071F
            7C6095244DB7D3D28137DF7CD3A65D73F1ACD868368C12246D24AB8D8DB5B1BD
            66CA68AD52635FDF951ECF848E95168B172FF69A20C53425CE979F4ACC3366CC
            B02469C89021F6188951395062A4660C3A690C1A34C8AEA8E8449290240CA15F
            830DD1D418B9E1861BEC22803A34E98D1000A0DA50C548EF053AFF2795235FE7
            EADAE768DF83BE4ABC9F2819D27BC1934F3EE91E7FFC719B29F3CE3BEF78FD3B
            1086A43DBDDEF7B5AF97F6F36A6C85B4D2E399D0B14282D400EA4AA72B2A49EB
            6325451A440A162E1693A4FBD0669B6D666F846A4CD0A74F1F3B49241BBED62E
            3B574382347CF8705B77F4DBDFFED62D5BB6CCAB1B0040CCA852A44163870E1D
            6C9D86CECF679F7DF6AA3DF07C10D3A02F8BAB9223753255523473E64C3767CE
            1CF7DA6BAFD9D7F4B1961568D601140F5D08105A42A0D7FC8001036CE68CC643
            AAB0E4810429E0C14AE60CFA5AE393D74F574D264F9E6C9DBDD401441E2C582C
            36DA404D49D2E1871FEEFAF5EB67ADBB35A5AE2E6ACF592D738CECBFFFFEF666
            A88D0195280100540B4A8ED4A1B467CF9EEED65B6FB5C4C857C752B1FA393AF4
            A02F8F6B82A6D9692CA48469FCF8F1B6CC808B69E5406B8FB51E69975D76C9FD
            BAAFF4EB2F74AC449D208910152425415AA8A82B25EA52A70A92162DEA49A372
            544CB4CE481D5B542D5287A2FEFDFB5BD548B786F6352A730529694BBFC71E7B
            D89BDD471F7DC4554100A80A5439D25A0C75F9DA7BEFBDED2AFAA9A79EFA4FFB
            1FF922A6ABE2795C13349346EB91B43E49DDEDD4E96EEEDCB9F67EA10BC9505C
            0E3EF8606B4AA54A92D65DAB8A94B5924405A9C202790E5673F8290952E0AB9B
            8B7692BEF1C61BBDFE3F10065589F4DC0F1B36CCA6D22949CA72122873829434
            A050771BAE06024035A1F37F972E5D6C268136825593064DAF2EFBA02F8FEBEA
            D4D4D4D84C036D07A129D97A0F99346992D7BF0F615043125D38DE76DB6DEDC2
            7116CA1E2B2448ABFD2D558B740278EEB9E7AC82347AF468AFFF0F342FBA12A8
            CA91F6345252A4A9755A88ABD781A6DBA551D604491702347554689AA1A6D801
            00941D558EF49EA0ABE6BA58A6AD1D4E3EF9649B5AA7F784B20FFAF2B8AE8EA6
            3FA962A4EF511B7025484A94923D2205B3108A892A498A054DB5D345536D8A9C
            D6BCA1ECB14282540B25458F3DF69875AC535306283EA79D769A2546AA1CA931
            435ECA9A20E90DED91471EB18FFFEDDFFE8DB54700501568BA75A74E9D6CEDE5
            B9E79EBBAA729450F6415F1ED7FAD0FB87A6D929417AF4D1476D06C2A851A3EC
            6B74422D364A9434ED7EC71D77B48A5243943D564890FEFFBFA17547BA22F2C4
            134F5805490B12A178245D875439D21541F5FAD71BE2C081031B35AFBCCC0992
            764B17175C7001091200941A25426AD0A385E86A6FACC1DFD0A143EDB1DAB309
            CA3EE8CBE35A1F7AFF50975F2549CF3EFBAC7DACFDF4C4AC59B3ECDED7FF08CD
            CBEEBBEF6EC951D2C44A5DEFEADB50B6ECB14282F477C68E1D6B15232D429C3A
            75AA577F685E34654268ED98823A69DDDD58CA9A20A941C3881123EC63BDFE99
            16010065466D8CB529E631C71C63CD1834D5AEAE69D6651FF4E571CD8ADE4F7E
            F39BDFD8C73FFAD18FEC5E179D49928ACB9E7BEEE90E3AE8209B76A77D22EBA2
            ECB152D50992AE7A28B0D5A94E0B0D75E5433B4843B1D0F39ABCD1EDBAEBAE76
            7FD965975982A4AE752448DF44AF7BED162FD4B695040900CA88CEB949EBEE8D
            37DED81D76D861EE84134EF846E5A8F6F79779D097C7352B7A3FD1A6B2E2F2CB
            2FB77BADE7D65A574DBFF3B5550B341F1A4B2931EADDBBB7DB6BAFBDEC82C2EA
            95A4B2C74A552748DAF45553E95E7DF5555B7704C544AD5AB5C648CFAF1223A1
            0E457A536C2A654D90D4AE5E578784F6B8E04A1F0094114DADD662733562D054
            6B4D196AE8A259D9077D795C1B43D21DF5EEBBEFB6E4E8A1871EB264098A89E2
            4749D24E3BED646BF634AE52931351F658A9CA04495733747BE081072C41523B
            6F12A46292548F9204E9D24B2FB5C749901A86040900AA01B5F2568274D24927
            9120E5746D0C498274EFBDF7FE53824415A998A8EABA7A8294C44FD963A5AA12
            242D2854895083683564509B636D080BC5428B6D95142970CF3FFF7C0B564D9B
            A8D4EB4F942D4634BDB45BB76E5E3D0000624189912E9469ADA536C14C4B8C12
            CA3EE8CBE3DA186A2742F27BE9A597AC3DB89A3868EB14254B7AFF8162A14A92
            D62569AAEA19679C61CFAD2E3C943956489048900A0709D2371D49900000FE01
            0952D35D1B0309523921410A2090E7603516755351D06A7DCAFBEFBFEFDE7EFB
            6DFBBDC9543B2806DACF481D55B6DC724B77D65967D9A2417525129A134B8294
            8E16D36A4A9D368655520900502674E14717D07EFCE31FBB9D77DE79D5A6E059
            A75C9320F95DD6A08BD2C9C6E44A8C6EBBED364B9AB4E12C17A88B839E4B3536
            E9D0A1834DCFD7EBEEECB3CFB67B5D88F0454CB152150992AE5EE87768BF17ED
            71A4AB187A0C8A85DAB46A8767CD87D573A9D75BEDC024414A4709D2EBAFBF6E
            09D291471EE9D503002034DDBB77B784481744D5894B4D7C9245E5592041AA4C
            632C25445AFB7AF3CD37DB0C9EF9F3E7D3BCA180685F49556475715A33787C57
            91628A152F09927E5E7F3CB6604D2A4723478E740B172EB46E757A4C83C4FF8F
            BD330196AABAF6F7B1DEB352962F2F85437C962202A2CC0A3289209332CB2CA2
            22A380221A82880A8A80884A948788489020CEA848885350C4E018E5E16C5034
            467DFE8D21C6DCA208A1288ACA3FDFF2ED9BE6DAB7FB9CEE7DFAEC7DCEFAAA6E
            75DFBED3BA7DCE1E7E6BDA1A39F207041187FAF1D8BF7F7F59EC4CE408AF60DC
            F71FA4658CE0C1A31D2B07C34E9A34C9AA1D8AA2284941E488B581F5BE418306
            C1B1C71E1BFCF0873F0C1D39AAD41C6D63D3E7CA7A12C53E0E9765DF8528621F
            F6C20B2F48832C8E56A14916FB323E14B731250E8C2DCE14C3498DC31A6C4492
            5C1A2BA98E20996E2A6C04BFFEFAEBE0D34F3F95AE2A8A5FB46CD932E8D6AD9B
            9C694417A2DA705920C56D631481F4EB5FFF5A2248975D7699553B14455192A2
            61C38622906EBBEDB6A071E3C6C1A1871E2A294151F1412055CAD638EC330EEA
            679E7926D8BA756BB065CB1679E475224C8A1F209048D34714DD7CF3CDF29A8D
            7BD1A5B17250555595558144B8CD26889CA8F62186808BC646104F05C288CDA1
            B633761F6A8B58D87AF4E81174EFDE5D3C81279E78A22C782672948FB8EE3F48
            CB18E17B2996E560D8850B175AB5435114A5D21C7FFCF132FFCD993347EA549B
            376F2E6B0591A3528E7A887B8EB6BDE97361CF15C53E93BD43FD119124224826
            8AC4B12B8824E39854DC8548529D3A75C429C181B2B060C102D9BBD140ABD463
            565C1A2B07FDE33BACBD69710FAE30506304A3468D1251B46DDB360DDD7A049D
            86187423478E940F061B8B6018E2B8FF6C0ED2B86C0C0B0B0FC288F1402EB8A2
            288ACF907A8D536DCD9A35D2698BA600A5448E7289738E4ED37A528E7D4628B1
            3FDBBE7DBB44919E7EFA69D9B369F3067FE09E21620BF7DE7BAF8C3D9CDAA546
            6F5D1A2BD60552DCE1D9DA20BF1561C4A3392C146F048390860C5A73E43E8820
            AE77CF9E3DE55032F2C8F9403091F31A8638EE3FDB8334A93162F2BFE900C838
            59B76E9DB5FF495114A592D0C61BE6CD9B27990578B1592BD898957B48789C73
            745AD6135BF6B13FDBB56B977C1FD93F9F7CF289A481B39925AAA4B80FE97670
            FAE9A7CBD8E340595E43288569AD6F706DACC426904C6154394419AC78C469C2
            C0C68F427ED04E757E41AD11D1A271E3C68948626045195C10C7FD17D720ADF4
            184120D1AC8413E579FEFCF3CF5BFB9F1445512A45AED77AEDDAB5C1D1471F2D
            B510E50A23439C73745AD69338EC635D7AF3CD37837BEEB947D6AADFFCE63756
            6D51E2C508A59FFFFCE7D2ED8EAEC3619DDBE0DA58F13E828430A25D246288D4
            2106D8FAF5EBABBFA6B84FBB76ED6430F5EEDD5BCE3862E1C3F3C06217354CAB
            11A4C2D06AB56FDFBE324ED43BA7288A4F30DF1D75D45152FF3073E64C79EDEC
            B3CF962320A2B4F22E864690EC11D5BE6FBEF94652EED8D791E540CA1DCE6FA0
            A65C7117525D81EE76D4010E1F3E5CCE4D627C86114AAE8D15EF05128387023F
            5287A857018D1CF9C5F9E79F2FA7338F183142A248E5A002A9302C3A9D3A7512
            81C4734551145F4018D1B0878D98718432FF25BDA92F846B9BBE28B626651FEB
            D3E79F7F1E3CF0C003F2F308255EDBBD7BB755DB947868D4A89138B7AFB8E28A
            EA265B616ADB5C1B2BDE0A243A9D1082E563E5CA9522941E7DF451F99A468EDC
            86C58DE8101B7572C7070C1820C5B5B4F1C6D3500E2A900AC369E64684AA2341
            51141F301DB348E1993061826CBE2EB8E002F91A07C1BAB0A9AF0DD7367D516C
            4DCA3EC4103548EFBFFFBE3CD2BC81B3FBE848CCDE41BBDCB90DF71063B44F9F
            3E326EC90EA266904CA1429124D7C68AB70289BFF3D1471F496386C99327CB80
            A265A4E23EA6052B878B717605ADBCCB154606154885C12B47E30B4551145FF8
            C10F7E20F3166DBCE99405C623EDCAA6BE365CDBF445B13529FB729B6AD1C081
            7A59A2479C71C5DE01479FE23EF5EBD7973AF28B2FBE58BA4D32868B1DD5E2D2
            58F14E20991EF90C10C2AE449068EF69BEA6B80BDE03E8D5AB970C9A81030756
            875F69CD6A031548F961C1A1810902C914372B8AA2B80CD906448DD85451D7C0
            F3D1A347CB26D934F07165535F1BAE6DFAA2D89A947DB902897D1D9DED787CEC
            B1C7E49E301D586907AE1D8ADD853D1F91A4B3CE3A4B1A70D16912A738E3385F
            24C9B5B1E29D40A2D6E8F7BFFFBD14ED51A4A991237F68D2A4893CDE79E79DE2
            FD23E46A2B72645081941FC411E304C7C229A79C62ED7F511445890BB20DA84F
            6553B564C91299EFE856978B2B9BFADA706DD317C55697ECA374827A73EE0922
            124016116B9BE236447E8902931EDBA1430719D3345BA9896B63C51B8184F780
            0D1EE2883C543CE10F3DF49008248D1CB90BD790C100E4A3C2A44993246F1CEF
            0203C7262A90F2C3E2F2A73FFDA9BA4983A2288AAB1025608DA07D77B76EDDC4
            FB3C7EFC78F95A4DCFB3CB9BFA7CF6A5613D49C23E84D0975F7E290279C58A15
            F2DA534F3D55DDC9586BCFDD85881163BA478F1E923144E7621CE68CF1DCF1EC
            DA58F14620B1B94314218E68E7CD60A13183E236780D060D1A24CF6FBCF14649
            8D60B0F0E8F2640C69114826CACA89E58C2352551445515C854D3019061C187E
            C30D37489386DAD2B07D5947723FF7793D71C13EE3149F3E7DBAAC6D7434D4A6
            43EE832022E56EECD8B172DC080E10CA2C0CAE8D15E7051279C60C868F3FFE38
            D8BA756BF0CE3BEF68E4C803F01610394220D10B1F181480C7400552650512CE
            04CE3D5281A4288AABB06E709E119B26C411ED82891CB15ED4D6FDCA977524F7
            739FD71317EC33D1222249EC03392C98BF4324491DE7EEC2F84620218E3A76EC
            28F5D04492789DF1EDDA58715E20E115E0704B3C04CB972FD7C89127903A3775
            EA541148E3C68DCBFB3DBE4CC6490FD2303616032F9B0A2445515C86B46B6A13
            48AB233A50287264F0651DC9FDDCF7F5C435FBEEBBEF3E69D8B074E952E96CAC
            B80D11623289FAF5EB27FB110E933DFEF8E39D1B2BCE0A243C04FBF7EF177144
            F488368F780910481A39721313F1E34C23BA0EE1F9C33340B7BADABEDF87C938
            E9411AC6C662E06878FDF5D745208D1933C6DAFFA2288A522E08213CCB641D10
            35A246818C83429123832FEB48EEE7BEAF27AED9472D126B1C11251A11D1CCCB
            38D2B5CB9D7B208E48B7C31142873B22C6CD9A359379807A4343D263C5598144
            BD1137F9E38F3F2E6DBC114C2A8CDC851B9B858C70E9BC79F34428B568D1A2E0
            CFF83219273D48C3D8580C520F962D5B268B088F8AA228AE40C6015E64EA55E9
            7465526EC2E0CB3A92FBB9EFEB89ABF651A3CED12F641B518EC19E519B37B88B
            19F7A79D769A946210416ED3A64DF5D7931E2BCE0924224428FEEDDBB74BF4E8
            99679E91F43A8D1CB90937B0F1F271B3E3FDBBFAEAAB25B5AED8793BBE4CC649
            0FD2303616430592A228AE61D60F2247641ED0E9F4820B2E9068920AA4E46DF5
            CDBE575E794552ED56AF5E2D2DC1794E24C9EC2B15B7E05A2290104503060C90
            635F4E3FFD7499139803921E2BCE0924DA7857555549A874E3C68D228AF6EDDB
            67CD3EC52EDCE07422E1063735477C1E060601B9A80C025BD89C8C8D7D3CBA34
            46F2D958EC3D5481A4288A6B904E53A74E1D39FC150F32EB873900362CBEAC23
            C6BEA4377D516CF5D53ECA32104734F44234915ACE87E2269C6DC55E927DE48C
            1933E49CCCA64D9B263E569C114846DD7363F33BEEBEFBEE60D3A64DC1DEBD7B
            3544EA28DCBC2C6E78FEDAB66D1B4C9932259240F2C55B95F4200D6363315420
            298AE212CC5DAC1DAC21A3468D0A860D1B569240F2651DC9FDDCF7F5C475FBCC
            3E92F20C0412D94808248D22B9891148AD5AB5128184086EDEBCB97C0D516C0B
            6F05122722EFDAB52BF8D9CF7E166CD9B24523478E53AF5EBDA041830641972E
            5D64718B92336EF065324EC382A60249511457A0289B42EDCB2FBF3CE8D5AB57
            49C2C8E0CB3A92FBB9EFEB892FF6915E8783FDD1471F0DD6AD5B270D1CD86B2A
            6E42E30652EE28CF9833678ECC09A79C728AB5DF9FA840E2F7B0012B47207108
            AC0A24F73102A96BD7AE65092442A9B628E7FE2B649FCD052D2E1B8BA1024951
            1457C81548BD7BF72E5B20F9B08EE47EEEFB7AE28B7D2A90FC224E8154CABD78
            505555953581C4CD1B357F95B359104314F66FDBB64D149E3663701722468441
            1146679E79A614D271B05FA9ECDCB9D3EAE4693B7F1AFBC0751B8BD9F7D5575F
            05BFF8C52FC409C1A3A2284AA5A95BB7AE38D2D8FC508C4D34A0D8394761F061
            1D31F6D9144849AD27BED98750A25CE3CD37DF944E779F7EFAA9D4B82BEE618E
            8BC189C2996873E7CE9534BB934F3EB9ECDF1BF55E3CE8AF7FFDAB558114353C
            6B5A3172281C62C9741C51DC045144215DF7EEDDE579B9F8901E00AEDB184520
            AD5AB5CAEADF5714450903990708A45B6EB925E8D4A9933C2FC7C166F0611D89
            4B20A529252E2EFBD853F2F1D65B6FC9999A7449DEB0618355BB147B1051A62B
            32F5ECF3E7CF17473C8EF97228E55E4C4C202186B861114614D011FA44286911
            9D5B70A37273D28291A2392248843F51F85153EAF2E1C3640CAEDBA802495114
            57217284109A356B5670E289274A872AD321D4063EAC232A9092B58FBD25E976
            7BF6EC9173363938FD8B2FBE081E7EF861F99A3958567103CED6649F79D24927
            49EADD8D37DE28AF173B5FB336BC12485BB76E158174D14517497D84468EDC84
            1B1381C4D914A79E7A6AD0B9736759E06C6072426D8962DB93716ECEAAAB0B46
            D8F7500592A22849D1B061431148B7DE7AAB88233CC3362247E0CB3A62EC7359
            20F9F65E960A7BCE37DE78438E95E150597EDFDFFEF6376B762A764024711400
            69B8B7DF7EBBBC46C7E452F04220112D823163C6C80D696A90541CB9059123BC
            7B9C6ACEE246789345ED98638E29B998361F3E78ABC0751B8BD9478476D1A245
            C1EEDDBBA558555114256E881CB18E5C7FFDF5524FD0A44913D9EC1C76D86189
            B6EF2D844690FC792F4B854812CE42CE4A620F4A0BF0A54B97CA3EF42F7FF98B
            557B95D2E1FE3175EE38E761E6CC99F23A8E7ABE16E577392F90FEF0873FC823
            45FE780210499A56E71EF4A56701BBEEBAEB82962D5B4AC73A72425D9CEC0C2A
            906A8794023A4422909E7AEA29AB7F5F5114251FA4C7B08EFCFCE73F97A26BD6
            153A9E66711D5181E49E7D88249CF6AC8F340A43201927BEE20E44924CE6D26D
            B7DD56DDB4214A14DA5981949BDF396DDA3479E4002F8D1CB90707F7711DC78D
            1B2782A843870EC1E1871F2E0B1B512597273B1548F961FCE198C08B4BFEF58B
            2FBE68F5EF2B8AA2E442A601D0818A5A55D611E37463B393C5754405927BF6ED
            DFBF5FEE499CF51C28CB231D164123496EC1B100D0B3674FB966347AE1B5B091
            68A70592C91B359DCF4C9306C52D1A356A2461CB050B1604C71D775CF0E31FFF
            B8BA1983EB939D0AA4FC30EEC8B526348D53E2B7BFFDADD5BFAF288A920BA974
            8023944D4CEE4626ABEB880A2477ED23E58EBA2444D1F0E1C3E56BA4A52BEE61
            E6965FFEF297E2BCF75620B1316343461ADD92254BE4F3152B56C8D7B8C935B5
            CE1D4885009A669023CE19152C6A882393E7E9CB6467DB3E70DDC662F6219048
            215081A4284A1C30B751676452B3A16FDFBE9206939B0A93D575440592BBF699
            260DAC8F1C2A9BBB57E56059DDABBA83E97E79C925974813B161C386550BA542
            62C9498144E4884238FE09E0DC23C53D68DFCDCD4597A13A75EAE40D5DFA32D9
            D9B60F5CB7510592A2284962EA0498E34C9DA3AE23DFB74F0592BBF691D544E4
            88BDEB942953E4350E96D56C27F7C0898FE3C5643BF1DC0B8164FACD13AE24C4
            8E32A79522FCF9CF7F4EEE1D550E8005AD59B366F2FCD24B2F95CF3900965AA3
            7C379B6F939D2DFBC0751BC374B1334D1A9E78E209AB7F5F5194ECC2BA61EA54
            274D9A24EB06C74240BE8EA7BEAF2326651967D3F1C71F2F1EED28F6A94072D7
            BEDC7210B34EB287653FBB65CB163D2BC921A87324BB894ECB9482B46FDF5EEA
            E66B134ACE0824D436A288C27052B6F89C9A23C52DE8263464C810794E0A64B1
            9689BE4D76B6EC03D76DD48362154549021C6A7439655E7BF0C107E5B51FFDE8
            47B57EBFCFEB8849B57AFEF9E72533E68C33CE90C64651EC5381E4877D66ED67
            6F841826E58E6BAEB845EFDEBD65BE193F7E7C70C2092748DA5DBEEE76CE0824
            7ACA1396A45DE2E2C58B6552E135C50D58D0881C2190B8A960F0E0C1458BDD7C
            9EECCAB10F5CB7510592A2289584F583143AA247A4D013411A3B76AC7CADD059
            793EAF23448E70F8124D20D2D0BF7F7F892245B14F05921FF6218A60F3E6CD72
            CD293F202B8A660EA603B3D626250FF5F3A6168954BB162D5A484409877FAED3
            DF1981449D11F50E44915E7BEDB5A4DF3FA5065CA3D1A347CB223663C68CD03F
            E7F364578E7DE0BA8D2A901445A92408223624F5EAD50B962D5B26735B987433
            9FD711D2AE48B34228F1C881F7E67C96B0F6A940F2CB3E2382D8D35222F2D24B
            2F492489EBAFB549EED0AD5B37114623468C9033926A4692121748DC343B76EC
            90AE1F448E50D94C248A1BE0ED6BDAB4A984236965C9CDD3AF5FBFD03F9F86C9
            AE14FBC0751B5520298A5209881CB1F938FAE8A3831E3D7AC8A6C46422982321
            0AE1E33A620AF749B3227244A757322E5420A5DF3E2390E86EC7B57FEEB9E744
            285142822DD427A9504A1EDA7FE3A0193A7468D0BC797389ECD255D390B8407A
            EBADB782FBEFBF5FD2E9B88914B768D8B06170D55557C9E4DEAB57AFC83F9F86
            C9AE14FBC0751B5520298A5209D8845020DDB265CBE0A69B6E0A1D3932F8B48E
            98CDF1BA75EB64137CF9E5974B9A15C2E8BFFEEBBF542065D03E8412E5234413
            11490406C89652DC80A30538CFB34F9F3E41DBB66DAB5F4F4C20EDDCB933F8E6
            9B6F82F7DE7B2F78E49147E486412C29C982878B9B82C81185A4286ABA0CE1FD
            3BF5D45323FFBE344E7661EC03D76D5481A4284A9C103922EBE0D8638F0DDAB4
            69230E372247AC33612247065FD691DCDA69BAF022904825248A40F329D6D491
            23474A617814FB5420F96D9F49B1A35107F548EC7B79E47ED19AA4E4616E628E
            4220B56BD74E32A6F8484C2051B0B861C386E0934F3E099E79E699A4DF1FE5FF
            6031A32103E1468A6729A6EDDAB56BE4DFC3FDC1CDE5EA6417B77DE66FB86CA3
            0A244551E284798BB4BACE9D3B4B3D06EDBDC946084BD2736054FB10446BD7AE
            95AF8D1B37AEBA681FA64E9D2AF55783060D4AA449836FEF651AEDFBF8E38F45
            28514EC2FE97FB83743BC50D68A0D2A14307090620942A2E90B821F6ECD92302
            E9C9279F943CDD575F7D35E9F725F3986E74F484270D802E1FD41CA1A24B891C
            195C9DECE2B60F5CB7510592A22871402728C4108280B5A475EBD625458E0CAE
            AF23E6F72090CC5C3967CE9C0336BFD3A74F97F743BBD865D7BECF3FFF5CA289
            AB57AF96A8127549A45FEEDBB72FD8BF7FBFD5FF59890E8E1C3ADA21923A76EC
            284DC9C2B4E4CFE5A0AAAAAAC802C98411B76DDB166CDFBE5D5A7A3FFCF0C349
            BF1FCAFF41E4889B81FEF0A402300184490328069349A1F32D4A81F44C9B935D
            1CF681EB364611483C2A8AA28481260C641F9C7DF6D9C125975C22A976A50823
            83CBEB087B1B9CBE2FBFFCB208226A8CF2317FFE7C39FB29EC3948B9F6D91648
            AEBE9769B5AF661A1D420971449D1A91249EF3A1B8014E8C8103074A4A70D40C
            AA83FEF11D917E08CF0A1FD419F1817A36A168253918EC78F5A839AA53A78E4C
            DE975D7699082426731B243D3925619FCD052D2E1B8B418E3479F478BC962E5D
            6AED7F5114259D30B7103D229FBF7EFDFA52FC8CC38DD7CA1148E0E23AC2C697
            D6CD14DCD36C8A3DCEAC59B3F27E2FAF1339C2334DDA6114FBD2B09E64D9BE9A
            0209E7A3A94942589B0E777C9F76B74B1E0205CC5D747026A264E6B530942490
            50CC142FAE5CB952D3751C824E4288235A770F1932443C7FA79C728AD5BFE14A
            78BB92F6D95ED092780F19AF6BD6AC91891CEFA7A2284A2148CFC6D146230222
            476426942B8C0C2EAE23CC8D74DF254D8A6E7585402071FE535881946B5F1AD6
            13B5EF5F18C1640E8FDDB871A334F3E07EA2EC447103F6C434298B9251559240
            E26C23DA1C927BC987923C4C1CA4412090E8DE41F128028956AC363193892972
            2CD7E6B8263B9BF6C5B5A055F23DC4AB6504D2BC79F3ACFD2F8AA2A40FE61552
            C75853CE3FFFFC60E2C48992B6CD870D5C5B47D8E4228C4891E2911AA3422090
            88AA51DFE08A4072E5BDCC9A7D3505D2A64D9BE4BC2CD65A2249B9DFA324077B
            E2091326C8FD431B70EA2A8B114920117E262F77C18205D20B9E1B8B941D2559
            58C8083B93FE3078F060E95CC742E6A2B725175FECF3DDE3C7E44CDA08358344
            92F0A4288AA2E483338EC846983C79B26423B096104DB2892BEB8869E54D9900
            9BD96BAFBD36D4CFDD71C71DB2C9E20CA462295F1A41CA867DDC4BD8479415B1
            44CA1D7B65F6C8462829C9619A967136D2942953649F5CD4B9A102C97F5420C5
            6B9FEF0B9A0A244551C2A202A9382A90D4BE9AA840729BD80512A2884D16671D
            D19C41C386C9C242C63914E44B77E9D245D2EB72CFA5707932F1C9BE342C684C
            D8346A2035B694B3B01445493775EBD695CDDD95575E29A9636CFCF9DC97793A
            2AD487704409077DDE7AEBADB29F097B8ECD7DF7DD173469D244365CC5EAB254
            2065CB3E9C0BC09ACBEF66AF8CF026C040798A921C5C1F9C1A03060C90E633D4
            5716FCFE2802E9A1871E0A3EF8E0032964E4A22BC9C2828620BAE28A2B82EEDD
            BB57478E0C3E4C263ED89786058DC91A7184485281A4284A4D683AC066FF9A6B
            AE093A75EA141C72C821D298C197793A2A349B7AFDF5D78377DE792758B87061
            A49F4520356BD64CEA7C5520A97D35ED33629B751711CEC1CA08240E97559285
            C82F5DEDE842396AD4A882DF5B5020990811AA978BCB616984A24DAA9D920CCD
            9B370F0E3DF450E9C8C1C17D8409891E9903620DBE4C26AEDB9796058D025236
            05785014455100471B4288C603F9D6135FE6E930B0A721DDE9A38F3E0A5E7BED
            35E9C2CB5EC61C081E16B2685AB56A25ED826BAEBBC5EC4BCB7AA2F615B7CFB4
            8EA749126BAF397018D1A424038E1FBA731201BEEEBAEB24B050DB9E28944062
            32218F92302187C22AC9D2A64D1B59C0A64D9B265E2CE3E9AB896F9389ABF6A5
            69416392B6752696A228FE433736320F6EBEF9663927A4E67AE2CB3C5D0CB39F
            C18B4FD408672F67C39502593408A462E2289F7D695A4FD4BEE2F6996812C29C
            3D1B5125EE3D2519E85E47D4977391E6CE9D2BCFD947E723548A1DE1672615C4
            111B2C25193A77EE2C0BD9C5175F2C8D194CFE339374BE89DAC7C9C445FBD2B4
            A09162D7AE5D3B99B4F5B46F45C92E448E5837AEBFFE7A594B1A376E2C990935
            D7135FE6E962B08761FFC23E66DDBA75E2F48D3A071E76D8611235A21E1B3159
            8A7D695A4FD4BE70F6B1DE228CC8C6E2EFB1A7E635DACA2B950791441489BD10
            7BE95B6EB925EFF78512483366CC9042463EE8F8A22403856578F7C8673DEEB8
            E38A7EBFAF93896BF6A569414320515FC0E4CC734551B209B9F86CF6EFBAEB2E
            594F1047F94E98F7659E2E06FB17D364EA81071E28E96F2124D95C3DFCF0C3B5
            7A9D8BD997A6F544ED0B6F9F8924713ED2CC993325E59DBA7E251998EF889E53
            8B74EFBDF7E6FD9E82028903D3B888E3C68D0BB66EDD2A1E17AD3DAA3CA79F7E
            BA78F438BC8ECE420D1B360C75A2B9CF93894BF6A56541332D6D870F1F2ECF29
            505614255BD0FD14482F6193D0BE7DFBBC9123832FF3743E98E7F0DA33EF3DF5
            D453123D226A54AA738883D7C9E2B8FDF6DB43D772AA4052FB0C462451B6C2DE
            1A67379072C7E74AE530A97688A4356BD6C8DC77E491471EF03D050512930817
            9393B4B5A82C39860E1D2A9EBD1B6FBC51C28261F17D3271C5BEB42C6826AD6E
            CC9831F29C731A1445C916142703DE6B1C6EF91AFCE4E2CB3C5D135373847397
            FA0F36414F3CF144597FEBB4D34EABAED73AE184134AB22F2DEB89DA579E7DEC
            AD274E9C28CF198B2A90920181B476ED5A99036B6666151448B4B2241CB86CD9
            32EDDF5E6118681C6805B45DA568B675EBD6799B3114FA1D69994C92B42F4D0B
            1A028943D2D83C9087AF284AFA619E308722527304BD7BF796F5A4D89AE2CB3C
            5D136A8ED8BF30CF1991C4D947E570D65967499A3BDDAFC236BB5181A4F6E583
            35F895575E91E7A6BB1DC7E750ABA4540E5AF5739628E31AE7712E0505127992
            9C9D42C716AD3DAA2C84FF860D1B26CF172F5E1C491819D2349924695F9A1634
            D26649D5D4FC6745C90EAC272625ECE9A79F96C7629123832FF3744D485B62FF
            B262C58A60F3E6CD56FE56FFFEFD251D91BA6C6A174AB12F4DEB89DA579E7D26
            CA3979F264114688F9BFFDED6F56FF3FA5301CECDBA74F1F990F6B366B282890
            A855A0EB0BF9927AD12AC3C1071F2C291008220E808533CF3C33D4425693B44D
            2649D997A6050D8F2ADE2A0452A92D6E1545F10384D1E1871F2EDED14B2FBD54
            5EBBE0820BE431F750F142F8324F83A939E2EC191C40EC5D68CE506EE4C83076
            EC58D9508D1F3FBEBA962BEAFB97A6F544EDB3631FDDEC5893972C59226B34F7
            2DF7B0123F9C83C49E9B746352EDA0FA0CB84202A943870ED5174AF3232B03DE
            29BC542C5E8B162D2AEB77719199CC19B4B6B03999F8621F8FAE2E6851DF43D3
            6294707EB9F797A2286EC3E24F2A1873049DD7808D40147C99A7CDEFA3B6924D
            E6ADB7DE2A294B36C169491DF090214382A38E3AAAA4F7CF6581E4CBB54E9B7D
            26924464922C0F3A2DF2A8C40FD7EA3FFEE33FA4853FA9B8505020914EC70523
            47196F0C9B2973019578A09B06217B06175D0389209D7DF6D965FDCEB47A5B2A
            6D9FCB0B5AD4F7904830677810CEA716495194F441E40821C4667EC488111241
            22FA01612347065FE669B357A1769A0653A4D8D93ECA80E60C471C7144D0B56B
            D7D00D933482A4F615C3ECAF1146ACD1AB57AF967B97C8A7666FC50BD78CFD36
            E3F9B5D75E93D78C1329AF4042451131A27B9D1E0C5B199874FBF6ED2B0289F6
            AB3648EB645269FBD2B4A0E5168276EFDEDDDAFFA4288A3B208870B871182CA9
            B4CC13AC2DA5E0CB3C4D1B6F3693B367CF8EADA914E28BA26E5272F03A47B12F
            F7F3B4AC276A9F5DFB8C509A3F7FBE3415A12DBD9E575819B86E9B366D92E7A6
            BE30AF40A229031B293CCCB6727795FC1039E2F0394EF3BDF0C20BC5F347F8DE
            060CD6A8E91485E03EE12C2C9B93890FF6D95CD0927E0F19D76C1E10486DDAB4
            B16283A2286E80271471C49A42C735CEF5A05E06C29C9D970FD7E76936908815
            9A31B0D9A5D09D6E9D71C0EFE6BD650315A5862BF7FD4BD37AA2F6D9B5CF0824
            DAD1730F3FFEF8E3D5DD1877EDDA65EDFF56BE0F0EA4071F7C509E73F6281C54
            5555F53D8144786FCF9E3D72185A5C138DF21D08A333CE3823A857AF9E1C1A66
            3BBF76E7CE9D56077F16ED03D76D0C6B1F1330132D7585614F825714C50FE8C4
            74ECB1C7CA911077DC7147754D44B9B8384F9BCD24A2854D2EEB67DC751BEFBC
            F38E9C958220E36CC2B0E4BE7F360552D2EB89DA178F7DE6DEBEEBAEBB4420FD
            F6B7BFD5A3766286313D6FDE3C793E75EA54793CE89FCAF47B0289E26D3650F7
            DE7BAF2857C53E78F9C8792405A25FBF7E52F079CE39E7A43A7CECAB7DE0BA8D
            510412631B07C8C9279F2CAFEDDDBBD7AA3D8AA25416BA9F123D421CB56BD74E
            9C1FB40E4620951A39CAC5C5799A16DE400A210209C72E8F7160A245A427F31E
            F39E46E92C9BFBFED91648595C93D36E9F114874B7DBB1638764756DDBB64D7E
            B7D624C50302E9DA6BAF95E734CB80BC0289903C2A78CB962DC1EEDDBB93B63B
            95707A2F0B598B162D824B2EB9445E7375B01AB26A1FB86E6354FB104974A904
            361A3673E21545A92CCC291C044B6AC8AC59B3A4B577D81A9930B8364FB381A4
            D90C5C74D145B1B7444614218838D893E7515181A4F69502BF07FB56AD5A25F7
            1E02FD830F3EB06AAFF21D383D383016162C58208F2A902A0C6D5769E5DDA851
            23E984430B567320ACEDC16AF26B6D7520CCAA7D3CBA3A2197FA1E5283C4F95A
            402B7F15488AE21FD4AC9AC8118D034E39E514110CB4ACB511390297E6696C60
            034A13A9952B57CA6B37DC7043EC51F0A64D9B8A40C2A34F5A7C39EF9FCB02C9
            A56BADF6FD4B205193447A275DD678C421A0E724D985F992B913162F5E2C8F07
            082473511148D429A840B20F8B58CB962DC57B3F6AD4A803BEE6BA3723ABF681
            EB3646B58F660D26CF96C3D1F6EFDF6FD5264551E287EEA73462A0032A07C192
            6A8703CE8539A636CA6985CCA6906E7508A49AEB679CD0D1979A23CE56E23D8F
            8A4690D4BE72EC337B73A2A68874D2EDCC993D8A1D703411B400DE63C82B9046
            8F1E2D02890B40AD82523E26479CDC70BA87E1E91B3A74E801DFE3CB60CD9A7D
            E0BA8DA508249367CB89F32A9014C51F881C11D1207244D3801E3D7A48175436
            F1691448461C517F81430781346DDA34ABFF6321C68C1923EF2DA9372A90D4BE
            4ADB977B4ED2E6CD9B83F7DE7B4F02188C038D24D981FD390DD3809A2FC89B62
            D7A54B97A0AAAA4A0E8CD58D931D1044279D7492B45E1D3C7870DEEFF165B066
            CD3E70DDC6A8F631B1DE7DF7DDF29C73B7F6EDDB67D5264551E28356D334F939
            EFBCF3829123478A03CEA4D4B932C7D44629F6F1F7F1EAD2342A8903AE392096
            0D1487B897D215500592DA67C33E2394A847623C508F444455291F1C20CD9B37
            97E7D47A41AD02898988EE192A90CA831B1C4F5FAB56AD24BD0E4FDFD9679F5D
            EBF7FA3458B3621FB86E632902E917BFF8853CBFFEFAEB5520298A079876C4D4
            C1905A377CF8F060C4881152DB6A3AADB932C714FA1FC2DAC786900FF6234620
            5532726458B870A1082422492A90D4BEA4EC3302895A24A21C44928C40B255F7
            94551048D41A02755E905720D14040DB7BDB814E7574AC1B346850D0B367CF82
            DFEBDB60CD8A7DE0BA8D51ED63327DF3CD37E5F9C08103B5D5B7A278C031C71C
            231BF48B2FBE581C6DB9C2C8E0CA1C531B61ED638E228BE5A5975E0A3EFFFCF3
            60E6CC9956FFA728BCF0C20BF23E73BE1442292A2A90D43E1BF61911448A3C8D
            96701A20DE690CF1873FFCC1EAFF9135086498CE9F66DFA70229665420F96F1F
            B86EA30A2445493F2A9092410592DAE7827D2A90E243055202A840F2DF3E70DD
            C652EC33932DA99F08240AA0B5DDB7A2B807078A536374C51557049D3A750A7E
            F8C31FD6DAC6DBA539A654FBFEF77FFF578AD049216203086C0A2B8D49A7FB7F
            FFEFFF453E1C361715486A9F4DFB10472A90ECA20229015420F96F1FB86E6339
            F62190E856A9024951DC0481C4E27DD5555749A7A5430E39A4D648868B734C54
            FB8818BDFEFAEB229068909014462071987639E74AA94052FB6CDAA702C93EA1
            0552E7CE9D45207DF3CD37DAA4A14C4881A0F88BD6DEB4F8C6FBD7AB57AFBCDF
            EBEB604DBB7DE0BA8DE5D83771E24469D2B071E3466DEBAF280E813042085D73
            CD35B27ED0BD8E45BC5024C3C539268C7D44B4114674E6227AB462C50A891AB1
            F94B02D66D1C9B70DF7DF77D2F95B1D4F74F0592DA57AE7D8C0FD23E6926B07E
            FD7A193B345E524A87F1DEB87163798E6306B4CD7785D036DFFEDA07AEDB588E
            7D1C18CB46846E387A30B4A2B803D9076CCC397FE7E4934F2E183932B838C714
            B3CFA4FB7EFCF1C7B2E9A38DF1B265CBACFE0F5161C3C401B180582BA5F6C8A0
            0249EDB3691F7579DAE6DB2EA1DB7C5F70C105C1CE9D3B65A2528FB21D58D8F8
            609123EDAE458B16419F3E7D0EF81E5F076BDAED03D76D2CC7BE071E7840BC4F
            37DC7043F5FFAB284A721039224A440B7E5A7A9F78E28972002CAF15AB837171
            8E2966DFEF7FFF7B4911C22BCE41B0A4FBFEF9CF7FB6FBA6460441B464C91279
            CEF9476CA04A450592DA67C33EDA7BB32F27FDF4F9E79F97343B5DB3EDC07827
            C30B786F21AF401A3F7EBC0824C278EA51B60BF51E2D5BB60C3A74E8108C1A35
            EA80AFF93658B3621FB86E6339F6FDEA57BF128174F5D5576BEDA1A2380075C0
            6CC8EFBCF3CEE0F8E38F1771147683EEE21C53CC3E525AB66DDB265E71D2D95C
            800DD3EAD5ABE5F9B061C35420A97D89DBC7F8207A6452EC147B30DEBB76ED2A
            CF799FE1008164C2DC13264C508114132C743FFAD18F24DDAE5BB76EB2F8F5EB
            D74FBEE6DB60CD8A7DE0BA8DE5D8678A3B691B4C5AADA228C9401B6F1339A253
            5DDBB66D43478E0C2ECE31B5D9474A1D730E6942786D891AD110C105486D34B5
            080D1A3428B9831DA84052FBCAB18F436149A7237244FA177F439D997661BC13
            2986A54B97CA635E81440469D7AE5D2A906284DC72936AC799160C0457072B3F
            9F65FBCCDF70D9C672ECC319C2CFD31DEBABAFBEB26A9BA228E121C300487BAD
            53A78E88A4B01B7397E798DAEC638F8183E6D1471F95627397A06B1DEDBDA1DC
            F7D3B640F2F15AAB7DA5DBB772E54AA9CB431C219414FB30DE2FBFFC72794ECD
            27E44DB1A3AD26B5474CD29ADF180F2C7C871D769878A6060C18101C79E49141
            DFBE7D9D1CAC06572793B8ED03D76D2CC73E73BEC8881123C483FBD9679F496E
            B3A228F18300A23B1D1039628EA0990F1E4DD2BAA2462E5C9C636ADAC73C8307
            7CDDBA752292E85EC7D9472E70F0C1074B8607EF3F9B5228A74103680449ED2B
            85DFFCE637324E9E79E6198966F25CF7E4F1407750731835E50670505555D5F7
            041279B708A4DB6FBF3DF142C9B443012E9EFB7AF5EAC94521FDCE26263A6003
            26932CDA07AEDB68C33E2299B4F67FF3CD37136BADAB2859031144CD11906A86
            208A1239AA89CB738CB1EFFDF7DF97E80C9E71D76A29389A834EBE08245B51AD
            DCF7CFB64072FD5AAB7DA573D75D7705DBB76F97E60C343251E20381346FDE3C
            794E675F38E81FDF71C037A256F120F34D26C4ACC40317E5B8E38E0B8E3DF6D8
            60CC983132606B3B27292AAE0F7E5FECB3B9A0C565A30DE6CC9923DEA9871E7A
            28F8CB5FFE62EDFF5514E5FBFCDBBFFD5B70F8E1874B77530E8005D60028E7CC
            1D70758E61934787BA7BEEB947EA8F7EF7BBDF39B7C7E070D8F3CE3B4F224966
            C3540E35DFBFACAC276A5FE9508FC71A4CEAE9871F7E187CFDF5D7EAB48C199C
            52A6F6887A6CC82B90B66EDD2A5DAD380380D0B7123F471C7184A4D83139CF9D
            3BD7CAEF743D7CEC8B7DB6173457DFC355AB56C924BC68D122E7362D8A9236D8
            809F70C209B2309BAE49B6C6B2AB738CD9F82D5CB850DA15BB08A9EF575C7185
            08581A56954BCDF72F2BEB89DA573A0873D3F65ED7E2CAC0DE1B410A34C781BC
            02890B42C30636EC787C104BA68183120F1488718A2F8B25A94E4CCE3D7AF428
            EB77C639999822C22CD817D782E6DA7BC864FCF7BFFF3DF8C94F7E2275488AA2
            D887B91D2F334D187042122DFAE94F7F2A5F2B377264706D8E61B347AD23E9FB
            EC2F366FDEEC4CB7BA9AFCF8C73F0E162F5E5CBD06DB7EFFB2B29EA87DD1A11E
            8FEC2DEE3F6AF2D87F6BE4285EB866647271DDCCA1BB6474C9D7F209240367F5
            7CF4D147B269422429F1434BD7FEFDFBCB428927BF1CB2E26D89DBBEAC78FC98
            9019E7849709EB2B8A621F52EA38DE8145F8E73FFFB9D41A91666D13D7E618D2
            F6D9E891C64B6A9DCB5017CC4689FFDBC675D10892DA17965B6FBD551A317016
            98AB0E84B4812384263938AC688A01A6FEB3A0401A346890787EF8402429F143
            81E8C9279F2CE917A6A306EDC04B29D84DFB645229FBB2B2A031312390CE3DF7
            5C290CADAAAA0AF6EEDD6BEDFF56942CC39C8E383AEAA8A3823E7DFA482A1747
            6A3086D994DBC4953986147DB24F68C6C0FCF2C4134F387BD61A9DEA4875E75A
            3CF8E083F27F5323562E2A90D4BE62D0848171B27CF972B187CFB55B5D6560CF
            DDAC593389EA9B14BB5002890D3A2A9643AA5C9DD4D20AAA96D3BB81706B296D
            46D33A9954DABEAC2D6893264D92D0FEBBEFBEAB87D1298A25489F266AD4B469
            D3E0673FFB998C5DF2DE7D99074B8136DEA4D64D9B36CDF93D04D782AC1952EC
            962C5912DBFB97B5F544ED2B0E6515A4D6315E6862A2540EC63D0E2BE6E75B6E
            B9E580AF1514482B56AC90824ABC3FDAACA1B220903A76EC28CF391B8356B09C
            CD104528A57532A9B47D595BD066CD9A25E976849B35CCAF28E541E488946922
            136CC039D281C8115E4A6A4F7D9907A360E60D3CE26CFC6800E3BAB385E81167
            12F2C8911B2A90D4BE38ED2362C4D946403002470291233D83B03270AD988339
            8394F998E8FE25975C72E0F7141248145372D12824A5784C4986A143878A40BA
            F1C61B254F322C699A4C92B42F6B0B1A5E2C36337851F5D46E45290FC6E7D147
            1F1D9C76DA69C1B5D75E2BCE2F8A820DBECC836161E3675255264E9CE88D479C
            43DBE7CF9F2FA295B3095520A97D71DAC7DE9AF1011CADA175FE95857998B18E
            C3EADE7BEFCD5B0B5A502071482C178DB31968FDCD44A717B1F2D049878BC759
            19082452008824219A0A91A6C92449FBB2B6A06DDAB4496C24DCFCF6DB6FCB86
            C7E6FFAF2859800598799AB43A72DC5BB66C7940E4C8E0CB3C580CE609FEAEA9
            A580050B1678E111672DA5E53AE9EC5C9BE6CD9BAB4052FB62B18F3D34191A08
            A4E9D3A7CB6B94B1E8DEBAB2507BC45E1A51649AE5501F9A4B41816498316386
            8402F9703D8F38CD10FE270C3865CA94E098638E918E778544521A261317ECCB
            EA82367AF4E8E0C5175F940DCEBE7DFBACFE0D45493BA46A91BED1BB77EFE0B2
            CB2E9354BB5C6164F0651E2C06F3C4FAF5EB45208D1C39D2EAFF1327ACA15C97
            534E39458E3A003AEEA94052FB6CDBC7D8203B036184202272A42403E2A85BB7
            6ED2C16EF6ECD979BF279440E2D0AA6DDBB6497EA41E5A951C4492104863C78E
            958B4A4E3BA91AB575B8F37D3271C5BEAC2E68148EBEFAEAABD2CD6ECF9E3D56
            FF86A2A4152247CCC9448E68E7DDA54B177136988D784D7C99076B834D1F5D6E
            F958B3668D7C4E53065FA03E0C314B848F2E7BA002C91E6ADF77103122C0C0DF
            634F8D4032F79B5259B84EA43D73D62B51A3DAE6AB50020971C48441FEB4F1B0
            28C9D1B06143114A346F38F5D453E579BEE60D3E4F262ED997D5050DEF16DDEC
            08FFEBB9488A120E3C93B487A65DFEA851A36A8D1C197C99070BFDAD0D1B36C8
            E3E4C993ADFE1F9580DAA3E1C3878BA035F6C7F9FE65753DC9B27D380D385394
            C82A42893DB5920CA6F6886EA273E7CE95E7A440E7239440E2C2229008437102
            36CA970BAE2443FDFAF545142158F17AD1BF3D8D9E4957ECCBEA8246A13567A0
            3DFDF4D33AA12B4A11188BC0469BD43A8E69183162446A05127B005377C4C1AA
            3CFA143932507BC475222383A839A840B247D6ED63BF4CFA2907248F1B374E04
            127B6A2519988F69E9DDA449130932B097462CE5A3A040AA2982089FD3D50A8F
            F25B6FBD95F4FF9979E8BEC1856651EADAB5AB149D912E60F0713271D1BEAC2D
            68E44863DF37DF7C23A9754C226C801445A91D36D838ABE84C3570E0C0EFCDC7
            B5E1CB3C5813D285709852704E5B6C5FA1F5FAA2458B245D9DE60CA002C91E59
            B58FFD336288BD32297504195E7FFD75ABB62BD169D4A891A4D691FE4C84BF10
            2A903C46055265ECCBDA82A6024951A2A302C94F5420D56EABDA57BA7D2A90DC
            C49A40AA0917980B4E2B4CBAD570882CADC0956430291D5C68DA7F53087CF6D9
            67572FCC3E4D262EDB97E5058D49FE8E3BEE906E76D4237DF5D55756FF96A2F8
            4EDDBA752585EE8A2BAE90F373E82E5A28A5AE26BECC830604111B3DD26E6FBE
            F96699237C6C514CA32304519B366DE4FC23300D8F5420D9236BF631F6695842
            5333DADDB34F36E7886A694A72D08885860C8C776A0D49ADA31B74212209242E
            3A02096F0B020971A4022979B8C80824CED8C8F55C32D9FFE77FFE67B590B281
            CDC9C417FB78747541ABC47B982B90BEFCF24B6B7F4751D2000289E8C395575E
            2991FCDA9AE6D4862FF3A0B10F81C4E68F6C12CE39F215227E35059221CEF7CF
            6581E4DBBDE8A27D8CFDBD7BF706AFBCF24AB074E95211489A71953C08249C22
            6DDBB695A372D827D3C9AE1091049251BF788E9824E972A57DDC93C7B4954524
            91E2D1A74F9F60D0A041D249A9458B1656FF56D6BC41598E2099F14E07BB1D3B
            76C869D39A6AA728DF8130623374CD35D7C83C4BF7BA42C72ED4862FF3200D5B
            104578C357AC5821CE52B24A7CA563C78EC1983163E4A0C89E3D7B1EF0358D20
            D9232BF6EDDCB933D8B56B57F0FEFBEF07CF3CF38CEC91B76EDD5A9D6AA7240B
            6975A4D4314FD3B58E79BAD85C1D4920193EFFFC73C93F5EB97265B06AD5AAA4
            FF6FE5FF4011B3600F19322438EFBCF3E446E0F03B9B6465B2CBB52FAB0B9A11
            488CF76FBFFD36B8FBEEBB83C71F7FDCEADF52145FA19B28917AA20FAD5AB58A
            1C3932F8320FD2850B4F38D1233CE3BE433A245DEB8824F13C171548F6C88A7D
            9C1788C30051B476EDDAE08F7FFCA338141437605F3C69D224B97FE85C198692
            04126A980F3C497C3061AA6739794CD8993C4BC4D1E9A79F1E5C72C925E2D5A4
            4EA95CB84F6C1FA047C4CB1671D9677341F3F13DA44529350644907EF5AB5F89
            73440F8C56B20ACD71F03C72CC02D107165BEA8EC27824F3E1FA3CF8D9679F49
            C3161A32D0A889547B9F53EB0F3BEC3049B7C1A3CC3544D4B2461AE29EA3B3BE
            9EA4CD3EEA72891E3DF9E493C1C68D1BE5F7313ED823B3762AC9D2BD7BF7E0CC
            33CF94A851EBD6AD25E32A4CF31C38E89FAA37B24032906A47FA0D87C73EFCF0
            C349BF0FCAFFC184CF0DD0BB77EFE0A28B2E8AA4980BC1E4643BFF9789C5E6E4
            19877DE0BA8D95B08F88319E31224A789315258BD0058939F69E7BEE917995CD
            F5BFFFFBBF97F53B5D9E074D5ADDA64D9B52B1CE9B5A04D6C79933677EEFEB71
            CFD1360592CFEB495AEC23F51441B47AF56A7120507FC487E206FDFBF797DAFC
            860D1B065DBA748974AD0FFAEB5FFF5AB2404229EFDEBD5B3ADA1041C2AB4C78
            514916E3C96411200D84459C9A243C2FE5D424B91CDE8ED33E70DDC64A1C0A49
            7A0D07DC31D639445651B204CD709857E7CC9923CFDBB56B575D73544AE42817
            17E7419C20A4096DD8B0410E8B26CD96E8B1EFB46FDFBEDAA3DCAB57AFEF7D3D
            EE39DAB640F2713D49837DEC77FFF6B7BF491D3E5954380EA93BDABF7FBFD514
            4AA5345AB66C193468D020E8D6AD5B70D6596749774122FE51284B20991A85FF
            F99FFF099E7DF6D9E0934F3E91E234C50DF072529744A79EB163C74AD306BA2C
            954A9A27BB42F681EB36C6699F19E74CFE6C901E78E08160D9B26556FF074571
            1D4E5E87FBEFBF5F165ED3E1D2062ECE83383BE95C49D478DDBA75566C730136
            4BE79C738E6C96E86855131548EEDD8B2EDA870381330339F6062702E974DA8C
            C11D10468824EA0BD9F79672ADCB124806F293F134BDF7DE7B329972036B715A
            F2704390FA41E488F0220B02ADC049BF2B2592647BB233F9BFB6CE0688CB3E1E
            5D98900BD95889F7106F198B00690474B1629C6B2D929266180FA6152C072693
            BF4EF481E83C73AB0D81E4DA3C68367E8822B243BEF8E28B54B4F747D072B0FA
            D0A143C56148DD184EC39AC43D47BB2C905CBB175DB48F31C1DAF7DC73CF49D4
            887D2FEB2075BA7ACE51F210213EF6D86345189D7CF2C9528F4F5D7E6202094C
            0ACE830F3E285E666E1EC52D1049575D7595A485E44B2D28469ABD4185EC03D7
            6DACA47DA4D7D1BD52BBF4286987F1D0B87163794E831244111B6D0AFD6DE2D2
            3CC8F92D6CF818E3CF3FFFBCD5FF334910B5D41F0D1F3E3CB8F4D24B6BFD3E8D
            20B9732FBA681FEB1F6B1F8E4252CE3572E416E79E7BAE04003A75EA74402020
            51810414AAD1F186B03C6D40B96950D88A1BB0B0A3AE791C366C982CF674F808
            4B1A27BB30F681EB3656CA3E1C21A4DEB089A2705B6B91943442A488E80229CA
            53A74E95D7D8581331A29DB7CF63B83658B74D4D050D98707E90569B1658FB4E
            3DF55439FF88B3026B430552F2F7A24BF699A8D04B2FBD241D1CC992220840E4
            8843603572E406040088105F70C1051239228A44E4C890B8403206BCF3CE3BC1
            D5575F2D932DC56B8A5B708D468F1E2DA9763366CC08FD736998EC4AB10F5CB7
            B112F6994500EF191E669A352C58B0C0EAFFA2282E70F0C10757B7EF364E00D3
            5ED8E7315C08BAD1E2E4A4A602E747DAE01C143AD79D78E2890553CC5520257F
            2FBA649F59F718170822524F11488825C491E206D41C914EC761B09CFF490020
            B7BBA83302C96C9EB88928E6E60623A75971033CA0F483A789C3840913E4350A
            578B9E2A9C82C9AE14FBC0751B2B1941C2F1C1DFA421CBADB7DE2A0B451ABA5B
            290A912384509D3A75C413C91C49BD0A98B3337C1FC335A14D316942F7DD779F
            448C4C8A5D5A201D12CF3211C0B3CF3E5B3E377565F95081E4FE9A5C09FB8CF8
            A1E688E76445B18F25B2CA1A488694468E9287839E7168E100A1CE9E0831E77E
            D6EC2EEA8C40E266E20662E21D33668C7C4EAEA6E216E6A682254B96143DCBC3
            E7C9AE1CFBC0751B93B08F3AC3458B1689D799A8B1A2F80ECE23165716DDBBEF
            BE5B5EAB7930659AC630E0E8A0F07DDEBC79A95CA7E93E48FD118277F0E0C145
            BF5F0592FB6B7225EC3387BC2E5CB8509ED398481DFDEEC1710B44FA2FBEF862
            89FA5367987BF0B3C1198184AAE68662E3C44D858799D6C0BC6E369C4AF2E02D
            25271B264F9E2C6ABB73E7CEE229CDD7A1C9E7C9AE1CFBC0751B93B08F5A24D2
            0D4C2B6045F1159C452CB2471E7964D0B76F5F8920D1F113383F2397B48C61EA
            83599339009A8DDF134F3C91CA4830D9114D9B3695EE8378978BA102C9FD3539
            4EFB4C6488482A9005C56B9B376F96BDACE206A4D3B14FC5C94F54D87417651E
            37D1FE5C9C1148066E323C534CBE1C540ADAF5CA4D382B09381D9EE264521254
            20A940AA0DC636F9D844895948A2D4B2298A6B30DF51D44BB481B451C601CD6C
            F2919631BC7EFD7A71644E9F3E5DEA0AD3CA4F7FFA53E9DACAF52D945A675081
            E4FE9A1CF79E95C769D3A6C96B74ABD32E75EE71FAE9A74B0AF4DCB973656C23
            8C0A654139299050DCA4DB11BEE7736E36E02654DCA16EDDBA228866CE9C291B
            034E19C773CAC6C1DC74BE4D76B6EC03D76D4C422031868912D38865F6ECD9B2
            88F0B9A2F8029123BC8DA4D4115D60A1BDE8A28B642EAC193932F83E868D185A
            BE7CB90824DA79A7317508AF32D776CA9429418F1E3DC4F14764B0182A90DC5F
            93E3CA7AE283F58CCF293B00BAD76933067720850EA82924257AE4C89132D699
            AF0BD5D13B27900CB9AA9C136D815C67BDE9DC030F2AA977784FD8349C74D249
            D59E545F263BDBF681EB3626691FF547A6C30FF50C8AE20BDCEB44153A74E810
            5C77DD7532F7E5CB5FCFC5F7316C9C94E4ECA7D95149BA386B181B28C46F6E41
            BDED8D54315420B96D1FCE3D1A93E02818376E9C7C4DB39DDC846E7570E79D77
            4A7D2851A43007763B2D908824F1C8A40CE43B7353AA48728B7AF5EA49C4E8FC
            F3CF17A5CEC242AE279E38BCAD3E4C76B6ED03D76D4CD2BE8F3FFE58CE4EC133
            BD7AF56A19E7DADD47711984100B2B11235A3E13312F163932F83886733BC952
            5301149FA7B9A682B4FEFAF5EB4BE73ACE4531EF43D2DD5A5520B963DFFEFDFB
            656F43961335B5FCEE3973E6C8D7481F57DC81681198F3E8AEB9E69AEA0C27AF
            05522E66C3499F729E7363EA66CA3DC8E7E4A6C3ABDAB265CBA041830622985C
            9EEC542025639FE95AF9D65B6F49C1A46905AE28AE424A068708F6ECD933F8C9
            4F7E122A7264F0710C933A44CD11E0FCCA02FFFDDFFF1D9C71C61972AD6BAB27
            CB870A24F7D7645BF6EDDAB54B1C7B342CE1EC4ED6B234D7E3F90AF333D94D40
            9D3C7B539C5BC53A2FE7E2854032217D16269E73636A3F79F740AD731392BF4D
            9A1D1E5652518826E179B5850F9331B86E63D202094F342909B4F5673C739E8A
            A2B8060BAD595C71FA9086C5A1D92CB4C52247069FC6B0C9DE4020D149164CF1
            795A410C713D6FBAE926499DE4BD082B7E410592FB6B72B9F6312E58A788AA6E
            DFBE5DD2EB88A8F27A1A3B39FA0C7336E3D974A0E46811E670D267C3448E0C5E
            082403E14C3656A4357073EAA9C46EC3756ADFBEBD6C283889DC163E4CC6E0BA
            8D2ED8470DD2F3CF3F2F8D1AA64E9D6AF57F54141BE0E0A158FF9C73CE11314F
            DA70586164F0690CE38434E71C99F4F6B43371E2443930B24F9F3E72A6555454
            20B9B19EC469DFB7DF7E2B2974EFBDF75E307FFE7CCD7A7014C411ADBB7170DC
            7EFBEDF25ADBB66D4BFA5D8909247E9E3F1EC500D271B829397FC714C7692B45
            77C1CBCA9949A42C209050F451C29BB56163B22BE5FE8B629FF91B2EDBE8827D
            8C61CE8AC0036704923A3D1417E0BE062247A4D6519F42AA591481E4D318268A
            C2D8431851EFCB63DA2347E61A5F7AE9A5229038FF88C7B054EAFADA10483EDD
            8B2ED9C79E937181138FF3FBB66DDB16FCEC673FABCE8250DC82F9192707251F
            1CBF00AD5AB58AF43BCAB917138B2019E88065CE6220454723496EC3615C6DDA
            B409BA77EF2ECFCBC5076F15B86EA32BF69914053A01318E5F78E105ABFFABA2
            9402E918743C22123E78F0E0E0073FF841DEC304C3E0C318C6D9C8D8C3F99895
            33CA4805674345130A52C24BC5078154295BD3629F29E178FFFDF7A58DF7BBEF
            BE1B3CF6D86356ED52EC41E408C715F33691239CF15185514D4A124855555556
            05128B50145420F9856D81B473E74EAB9371D4FB2F8C7DE0BA8DAED8A7024971
            112390264C98604520B93E86F7EEDD9B6981640E3E2F85B8AFAF6D81E4FABDE8
            827DF904D2A38F3E6AD52EC51EB90289F3A86C09A4A8F7E241FFF80E6BFF58D4
            9BD7DCB8843AE92842188DFA2444D3BE7DFBACD9A5D8C1A43150E0CC0729779C
            33516A2EBF0B936731FB6C2E6871D9689372ED63ECBEFDF6DBC19E3D7B8261C3
            8659B54D51A2604E58A71B278D8198A3A2CE53F970750C2388D800E278247508
            68659C0538DF890D155D57A374ADCB479CD757D793CAD987C39D68EA860D1BA4
            3E96F337B76CD9A24751380AC288F9BA69D3A6D234032756EBD6AD0FF89E288D
            196A12F55EB42E904A0DCF72E3229098D4B9815520B90DE7252190BA74E9128C
            1A352AD5C5CEB617B434A630E4C2D8C5538740C25BAF284951B76E5D29F0BDFE
            FAEB4520B1E0961A39CAC5D5314CF748041235BE26673F2B10114010133D8AD2
            B52E1F715E5F5D4F2A679F1148342A79EEB9E7AA0592E2264620318699BF98AB
            3912088CA02D472045BD17631348A6302A2CA4E3F006B0B1A21BD67DF7DD17BC
            FCF2CB2292B479837B98D68B748542287110DFF8F1E3452851041D863827E3A8
            F75F21FBE25AD06CDA68131BF63166114A0B162C907426D25ED463A7540A8411
            8BEB55575D250BEC09279C209BE67216D75C5C1BC31C9741472EB22F186BAC9B
            381CB3000D84383092736C38AB2FECC1918588F3FAEA7A129F7D668D610FC9FA
            B36EDD3A114408230E34679FA9FB49F7E0581922831CDA7DD96597C9356ED7AE
            9D7C2D8E6365C2DE8BCE44900C7416A9AAAA0A56AC58116CDCB85172A9F58676
            170EE123AD81D68B9C99C46698F392C2E08BB74A3D7EA5C1024544988D2ADE20
            AD2D542A45FDFAF5E5BE9B376F9ED44C3227A5F9FC36D64DC4D1EBAFBF2E39FB
            59824EB8A4D451C7CC7A64038D20D9A392F6198144973AA2470F3DF450F0CA2B
            AFC8F8A0ADB7E226448DB8AE744AC6D1C17826CD2EE9B1E29C4062536522495F
            7EF9A58824F24711492A94DC8348121B0F3C7808A5860D1BCAC9F40825BCB685
            F065324E7A9086B1D126B6EC631CB350E119A2A532E397D41F1DC74A5C103922
            82306BD62C690F4B749BC8111B675BD12370650CB3F1E3E3A5975E921A1CCE72
            C17B9E7678CFB8B6F0C8238FC859296433D8387A025420D9A392F621821803AB
            57AF96882A9155134DD275C73D10467CD075B25BB76E52BA3174E85099AB8D43
            2BC979DB3981643037F6E38F3F2E13BF49D951DCC4741D69D2A489786DF1DE12
            2E2D842F93B12E68E5DB3760C00019C36CE4741C2B718183868595D6B0386858
            7C49FBF5618C94029D5FF9A0007DD5AA5556FF4797E13D33ADBCA92FA1F6C826
            2A90EC5149FB68F6C5995F8B162D92D43ACEE6D30360DD05C73AD1222247FDFB
            F70F8E39E61839E0196CD41CD5243502C9B4FBFEE28B2F6401204CCA81779A43
            EA264C5CDCC86C48D898D4A95327B8F0C20B65B3D2AB57AF5A7FC687C95817B4
            F2ED63FC32E1D1D0C378F4B42649B1050B2BF30FCD18987BA88964F1E5359C37
            3E8C9128504FF1C73FFE51B22BF8604CF17956E09A2E5EBC589E9F73CE39123D
            B2890A247B54C23EC4107B462247342A617C208ED82F6A6AB77BE0B422DA4B93
            2F73A0330E0F6A91882219921E2BCE0A24F3E6E00D60E25FBF7E7DB07CF9723D
            F1D81328969D3A75AAA4DA71264E3E7C998C931EA4616CB4491CF69903773B74
            E820E724E1D55381A4D882337010436C908E3CF24871D498742B5FC648144855
            65134811FADAB56BADFE6F3EC006EBC9279F94E7B40166BDB1890A247B54C23E
            A288EC15A97525E554CFD3741BF68538CF870C19129C77DE7932679312EDDA58
            715E20F12672B31345A27D292154C4924692DC8601C0A685543B3C7C307CF870
            D9C49876E0BE4CC6490FD23036DA240EFBCC58BDF9E69BE5F7533C4B7D92A294
            0AF796690843E4884D3379ECCC39B99DCC7C192361309E71D640A2B29C7B84C7
            3C2BE061261587EB3B77EE5C798DFA325BCD190C2A90EC11877DC6B94656116B
            CB030F3C20E3826E7508253DE7C84D722347A4D571661907C0B25F645F5833DA
            9FF458715E2099370BAF3375499C0ECE01521A49F2036EFC418306C9F31B6FBC
            51362D26F5C597C938E9411AC6469BC4691F0B1AE376E6CC99329E15A554B8B7
            1A376E2CCF7FF9CB5F56378BA999B3EEDB1829044E4204119132CE75C91AD42B
            CC983143365913264C90D77CBBBEBA9E946F9F113F1C23C17A42D7630492E236
            383818BB63C78E0DFAF6ED2B0E2E533FC835E5FAE63A3B921E2BDE082406019E
            013C04E45CB348E045E34DD54892BBE01130DDEC08A70205FB7879191C3EE48E
            273D48C3D8689338EDA3CB10CE0D224978BF4915D2854D890273CAE1871F2EDE
            485A3BC3B061C364E1CDD7CADBB731920FD28658FF380C95EE5C6452642D7244
            4602F565440BC13401F2EDFAEA7A521AECF5BEFAEA2B11C926AD943D20FB3F32
            8CB4F98FBB90F2CCBC7DC6196748F7C9D34E3B4DEA44793DF75067D7C68A3702
            C940312A8B051B2BBCD00C1AED52E2079C8E0C2C70787AF99CD6E0365181E487
            7D4B972E95DA423A546A24498902C208A70B9B66B351A2957C6DF83A46722173
            829454CE38E2ACA3ACC1FB43B31F04129908B9F8767D753D290D8410CE0136D5
            9CB9080823AD35721F6A04C92622EA4B1D324D198E3AEAA8EF7D9F6B63C53B81
            44240991C4A68A3A06BCCFA4ED804692DCC6448B68E3C860193870A0742CA138
            CFD425958B0A24B7ED638CE2D4983D7BB678C069FB4DFAACA214030F241B649C
            2BA3478FAE4ED50022D2B5E1DB18C985882B9EF1FBEEBB4FD63CC45196224788
            61AE398EB4CB2FBF5C4471CF9E3D0FF81EDFAEAFAE27D1E0FEE7DEDFBB77AF34
            6360ACAF5CB952BE86D3406B8DDC05314BCA33B5A19C5546C7BA134F3C51EEB1
            DCC891C1B5B1E29D40CAFD3BA4DBB1807092B64692FCC10C1A72C939B7A47BF7
            EED652ED5420B96D9F29A09D387162F5E9E6BCA628C560738C338585F617BFF8
            85BC56287264F06D8CE4423A397F6BFEFCF99256973510C338D1D854DD7DF7DD
            79BFC7B7EBABEB493476EEDC29E77CEDD9B3473A19E3282172A4B80FFB3A9C1C
            D3A64D9336DEA4D7911E5D1BAE8D156F051291243CCF7C90AEC3E72C26A09124
            B7217A04A44C3080E84AC4A687B49972BB11A94072D33E33269F7AEA2919AB26
            C5CE9C89A428B5C1028B538556B0CC1588A2F1E3C7CBD7C2449E7D1923B9E031
            277588C35F192378CEB374CE11EF0911420AB8FBF5EB27EBC325975C52EBF7FA
            747D753D09078EB34F3EF94404D2AF7FFD6B89206DDAB4499CAB591A0B3E8233
            8BEBD4AE5D3B7172702626E28854BB7C9123836B63C55B816460B3455E2A8BC8
            C89123E535F548FBC5F9E79F2F39A923468C90B68FE5A002C94DFBCC3948B47A
            67ACD2AE58BB502A61401C313F50A4BF68D122B9A728D40E8B2F6324178ACF71
            1C1065A79949D6204A80F86DD3A68D9C6D8348E630E07CF8767D753D09074E02
            524BF979CEFB22F360F7EEDD566D53E20187066378D2A449F2BC53A74E796B8E
            6AE2DA58715A20A140590879936A8345849C6CFEEE9C39736410713E04E806CC
            0FE86C8267A177EFDEE2652092C4A0CA3DCB242C71DC7F3CFA3C4692B40F2F38
            F6E1F933B547FC7E3C801AE9550AC1A6987A03E682CE9D3BCB0699D44C8852B3
            E8FA18C9B5CF8821DA16B37EB141C4A19035B8E6A4E43469D24452E8E94E482D
            523E7CBABE90F4A62F8AAD95B4CF9C6D49C4883D1D6381FA724411B577AC1F44
            911477215A0474A963EEA67331917FC671987468D7C68AD302298A3783814567
            3B0699892431C0B480CF1FA82FE07A538CCBD9490CB042C5D7F9D008925BF611
            CD656244FC3246A9A35061A48481851251449A069D2FF148164ACFA80DD7C748
            AE7D747504448189BA66118ABAAFBAEA2A993BA83F2A844FD7D77CAEEBC9F761
            ADA0E9D6BBEFBE1BDC7FFFFD41555555F0CE3BEF58B5458917A2FC881C82158C
            5D9C1C519C59AE8D95D408248411693B3CE2A586CD9B37CBE744995428B90F5E
            433640A4DA1155E2733E10496137462A90DCB08F71C798C3698157E9E28B2F16
            61646A2B14A536881C133DA2FE8494DBA64D9B06175D74912CBCA574BB74758C
            18F83D667D5AB66C993C925696C5A64388623CCE1D3B76943983EB4D7A65215C
            BFBEAE6DFAA2D85A09FB8894D28061C78E1DC1175F7C116CDFBE3D78FAE9A783
            5DBB76490D92E23E26E5992E75CCD3D488B2EEE3F48EE2E4766DAC581548FC1E
            BC0036076B98B05CBE370138A9974506E1A45E6B7F604091524141361FA4DC91
            8B5E8CB8EE3F9B83D4953112A77D6CF658DC58F810BB78FEA9135427851206BA
            1CD1BC85C5F6A73FFD69C99123838B6324977DFBF6490A2A90FD90E571D2A347
            0F993310456DDBB60DF533AE5FDF9AF6E97A722064157CF8E187C1D6AD5B4518
            B16EE8E1E1FE600E80857BEFBD571C5C51337F0CAE8D9583AAAAAAAC0924533C
            6B337F957CD4A8F699260D1C2646CEEA1B6FBC211E0A3CD736D5A8120F788F11
            4814F631F068057EEAA9A7CAEB858AB3E3BAFF206D63242EFBD8DCE18CA08537
            0BDD98316382FDFBF7CBE73AF69442B0D0E27D64734C5A55972E5D248AC0825B
            EE39692E8D1183399A82F1625A585F7BEDB5991C270860AEF199679E294D7B38
            F7E894534E09FDF32E5EDFDAECB3B9E9F3793DE1DE27BB07E7196DBBC936A09D
            37EB4696D34B7D816B6A9CD983070F96D7E84ECB7CCD6BA5E2D25839E89F4ADD
            AA407229D46D36B79CDE4B5138E93D0825C52F48B321279D549B61C386D5FA7D
            71DD7F90D63162D33E1C102C7A8C35E30967F15394301035227AC4182772C422
            EBF201D2E582238FF6DD8C19D37C22AB90ED81386ADDBA75B537DA44D2C234EA
            71F1FAD6669FED4D9F6FEB89B9AE3460D8B2658B7C103DC251A0473EF803ADBC
            3B74E820111F8E23001BF7A24B6325D502C944922EBBEC323971998365598CB2
            9CC2E0230823164D0A0069DE905B8B90BB78AA404ACE3E1339A2E31602899A11
            5ECBE2E1964A348C478F9AA3A38F3E3A38FBECB365CEB6113932B830460C8C0B
            9C09AC4FB4F3C6633E75EA542BB6F906D7980F23907086517F64DE275081949C
            ADB6EDE39A2282B8FF710E208E881CD18C4105921F9833CA104864F9707D4DED
            6494E3176AC3A5B1E2B440323983E50A1A9377387DFA74A947A285A49E95E41F
            0C3ED26F681979F5D5577FEF6C8CB8EE3F1ED33E46CAB1CF448E1043A4B59A6E
            758A1206D2A9F0428E1D3B56A247A6B5B72D5C1823B9E04420950847026B5296
            A1BB25A9743D7BF60CBA76ED5AD2EF70EDFA16B32FE94D5F145B6DD86736CD38
            02582B162F5E2C6DBB7158B31753FCE2B0C30E93FA50DAEE13F9E6FEA319830D
            5C1B2B4E0B24B0E1CD5081940E2A2D90402348C55181A49443DC0209921E23B9
            A840FA17360412B8747D8BD997F4A62F8AAD36EC5381942EE21448E0D258C984
            4032D0598B62505AA892F3CA268E454AF10B8AB96921C9C9CC575E79A5D42AF4
            EBD74F055285ED4308B1E8B1D8515CCE73163D450903CE0D364F9C7BC6824BCA
            06E2284D632417CEE57BEDB5D7648CCC9B374F5ECB6ABA370748D29D949469CE
            B98A7A20784D5CB8BE61ED4B7AD317C5D672E0DEC63ED2E8704873F83175E094
            3BB05664F5DEF71584518B162DA469D6CC993365CC72EFA579AC644A20712273
            4D81644E2E57FC0181446D025E6604129B2A1548C90924367D462011A1559430
            D4AD5B57E663EA6F10483FF8C10F522F905E79E595030452564120D1A9D008A4
            7271E1FA86B52FE94D5F145BCBC108241C684620FDE10F7F90082A6B85E21747
            1C71C40102C9B4E44EF358C99440E2F7601F8393CDDD030F3C200B162D26D5F3
            ED17DC6B78300E3DF450D954B1D0F2DA2DB7DC225F67E355AE571254207D1F53
            4CFBC20B2F485B4FCEAC600C811E02AB140361C498C5B941FB7E3C93B9E3350D
            632417BCE614A1538CCE783129A95964C0800112F9E720C9C68D1B57B7092E17
            1548F1D85A0AA6D1C23DF7DC235D831F79E4916A51640E1057FC81F9BA55AB56
            52DA70E18517CA7825BD0E7056A779AC644A20D5B48FD6842FBDF4922C5C6683
            A7F8079E67239072BBA9A8408AC73E16403E366CD8102C5CB850BC8378061525
            0CF5EAD59308F0ECD9B383F6EDDB4B6A5DEE26390D632417CE002363818F458B
            1659FDBF7CE39C73CE91D44ABA5CD29DD4162A90E2B1B5148C40C2198040C211
            8D4052FCA47EFDFA12E56DD6AC993836D85799F93AED6325D30209CF375E0D5A
            AD5234CB42A6C5E5FEC175A5268981DBA64D1B798D14163661A471947AAA33A8
            40FA172C7C448F68CFBA76ED5A4919E29C23D3E25B510A812792F6B0B366CD0A
            1A3468200D57CCA9E99568D75FE9318CD38094539C700F3DF490AC3559DD2812
            39628E1E3D7AB4DC0788643659369C58A002291E5BC3426468FBF6EDF2FCFAEB
            AF973581CF799DDFA79905FEC19964B4DCE778150EED661F652247958AF6273D
            56322D900C6CF69E7AEA29114778F9147F61D3052B57AE94B41D3A24A940B263
            9F891CAD59B346F2C97130681722252CE4AEB329BEEDB6DB24BD8AF45804534D
            7C1E23B9B09EE040201595F928CB208C78CFC68C1923E2C874365381E4B6AD61
            4100BDFDF6DBF29C2803D000CBD6FFA9549ECE9D3B07BD7AF592D4BADA3A4CA6
            7DACA840FA277455C1B3479E38354978FD58D414FF3062880D189BAFE1C3874B
            8D03071196D23A580552507DB01F279F332EA8D763E3C76B7AB09F520C52AAD8
            08E3593EFCF0C3A5D0D7447CF36D907D1C23B990894074951454A2AD3812B2DA
            2DB57FFFFE228A2FBEF862F13ED3D29D944A9FAF6FB9F625BDE98B626B6D98C3
            8E49A17BFFFDF7253ABA64C912F91A250BB077EF5EAB762995C1A4D3918DC341
            B038B24CE4A826691F2B2A90726060930E4114899408C57FC875A7FB0AFDFA4B
            E9D5AF0229A86E6AB27CF9F2E0D1471F15874256377C4A7448D14008114539FA
            E8A36B8D1C197C1C23B9B08EE06423759BF192651046D4885E7AE9A5228EC1F7
            EB5BAE7D496FFAA2D85A1B26AD9ACEC09B376F96476A0A81E354147FE16C3284
            118D193A74E850F07BD33E565420E580A78F48121E726A92481FC26BAEF80BB5
            0E4495C8A54528E1D1E4FC0DD2EFA8512A46960512D12116C275EBD6497495F3
            2C68666252ED14A536B88F104340E4884DF219679C21D103C451A1D42A9FC648
            2E8822D60FD60C3211882265310595F787037F61C2840932FF366AD4A86285DD
            36EC4FF3A62F8AAD3561DE47007DFBEDB7C1CB2FBF2CCF376EDC28D1A477DF7D
            57BE67FFFEFD56ED512A039123D25F49A7237A44D4C838356A23ED634505521E
            68CB4AEF7E368574E952FCC788224EAEC72B82583279F085C8B240A215310BDF
            CD37DF1C3CF7DC731235227AA428C5E03E22CD151E7BEC31714698B4BA303FEB
            CB18C985F3C01044F7DD779FA4D76515DE9F1B6EB8419E8F1D3BF67B35A0BE5E
            5F5BF625BDE98B626B4D5813700220FEC9B2D9B97367A6EFF5343174E850891A
            E14C3EF9E49343FD4CDAC78A0AA43CD0B6F84F7FFA937421A2201D1BD820827A
            CEFD84EB8EE71A71441E3C1E12441369778552EFB22890D8D098C811CE02EE7D
            A2AAA4DAE9017F4A21B87F38E786F33166CC9821AFD1829FE841D8F36E7C1823
            B9F65173C49A413A1DB5793467C862E488E820DDEA10C193264D92D728F0AE99
            4EE9DBF5B56D5FD29BBE28B61ABEFEFAEBE0D34F3F957D11CD18AAAAAA249594
            34BB2FBEF8C2EADF572A0B593534B72282C45E885AED238F3C32D4CFA67DACA8
            402A001E736A9258EC162C58209BC6AC1EF09716F064B36033292092F096143A
            C93D8B0289F787C8D1D5575F2D6975DCFFA49F2A4A310E3EF860713CF0480D0E
            9856DE61F1618CE4DA470D061B47CE7D218A945588C8DF7AEBAD2290060F1E5C
            EBF7F9767D6DDB97F4A62F8AAD86DFFDEE77B217C269FCECB3CF4A0386ACB6AC
            4F1BF3E7CF97BD10E508C552EA6A92F6B1624520F1F3FC715727BE52ED430CE1
            4127AD8856E07C6E8A6EF5DC173F61F3CF07E7231149A20D78F3E6CDC573C2C1
            8578B9736B936C09241FC6C8BE7DFBE4910D9FB9E78D775C23474A21881891B3
            6ECEBA618C915E0561DBECFB304672ED636C9051C041986C1C8D33212B70CD99
            2B1146D497D17C836B0FF90E81F5EDFAC6659F8D4D5FDCB6D27481F580FB9AC8
            11F73A112322473CA7CE88EF51FC03E715F4E8D143E66C3AFD720403CFC3D465
            4356C68A4690428030A2389D4DE3A851A3E435368D8AFFE0EDC6734261221305
            754A3FFEF18FABBF9EA50892B9A7AFBAEA2A29386771D4FB5C09034D181847D4
            F6DD7BEFBDF25AD4C891C1E531926B1FB517FC5EB20B581FB206D79CEB7DECB1
            C70673E7CE15E75298DA055FAE6F5CF625ED150F632BD121D380818811D934E6
            2058C56F706410E5A5B6186184B3D8D5B93AE9B17250555595558154EA1B5D1B
            1401266D1FD1228A12D92C924641FA1107CB82A61EF90D6288459E827252ED88
            2AB56CD95284121B3EEE3F48FA1E2C44B963C444435908F10A5264CEFDCE22A9
            35774A214CC495D48C810307CABD6D0E8A0CEB8DAC898B632417A244FC6FAB56
            AD12A71942294B6DEFA935C2DBCCBCD9BE7D7B3967EEDC73CF958852DDBA758B
            FEBCEBD7376EFB6C6FFA6CDACABDFDE5975F4A94887B9A338E4CCD9136E8F11B
            C629C288318B7383799A4EA3EC815C9DAB931E2B07FDE33B62F9E792F887E2B4
            0F61C4C6910DA5491FC1AB426D92E237849D4905A2A8988D1E5E510A8EB9FF6C
            0E52706D8C9828D9F9E79F2FB514DCD31C00A828C5C01B59BF7E7DF14272CE11
            0B7098EE90C5706D8CE4421B6F9C07444DD84C660D8AB87122E154BAFCF2CB45
            24335F46C1E5EB1BB77D2EAE27660FB369D3A6E0ABAFBE92346BBAF8E21436EB
            83E2371CFECAFC7CD34D378958A2B4004770B9A479AC5817483E85BAA3C22442
            FF7F04D2E2C58BC5BE5FFEF297229C48C353A1E42F783FCD424FC1229B8033CF
            3C533A72B1F9636229D5CB521357C688891C71E617F7F0BC79F32422CA0249FE
            B9A2D4867128304ECE3AEB2C19376C96C1C63871658CE482730C56AC58210289
            7AD42C6510F01EE26DA65E93832489B6D3EC867A33365C5170F1FA56CA3EDB9B
            BE726C65DE67DFF2C9279FC8E691262374AC236594FA6BED5CEA37DC6BA6F142
            9F3E7D64AC5E72C925E2C4A2735DD8FAD042A479ACC426904C6194CD37CB25FB
            984CF8F973CE3947D290A8D9D0C60DE981FB8E3301F08ECF9C3953261626141B
            B832468C67B06FDFBE720FD39E58EF61250C2CB0C71C734CD0BA75EBE08E3BEE
            90F161C31B6970658CE4822062333965CA944C0923038E239C46448F468C1851
            D6EF72F1FA56CABEB8367DA5D84A84889FA3FBE0871F7E28DDEA34952E3DE0F8
            A5810A502B496A1D91A39AADF7CB21CD634523482542C408FB6891C8E6921698
            785A5838F1CA287E43372E4E7FC7433E66CC18892EB1318042E7268521E93162
            BC861C860C93274F166184C750EF5DA510B99156C603DDCAAEBCF24AAB115648
            7A8C181827A69DF1F2E5CBE573B207B2D0BC84F78DEB6AEA8DE8F849331B1ADB
            74EFDEBDACDFEDCAF54DC2BEA4BDE240260CF7328D7868D97DFFFDF7CBFCCFE7
            9A52E73FCCD3EC5D18BF448EE0D24B2F1561C4BE260E816403D7C68A0A244BF6
            4D9F3E5D16D2679E7946CF0748114C3078C6D9FC2194F81C515C0E498E111645
            3677887A2247C0E1969A1EAA8481542AD24EBB75EB26731E0B2D6229E985AC10
            E5A6A1726032D0C1344B0E04BCCD886136581CF64BAA3111431BB8727D93B02F
            C9B162E6F95FFFFAD7B20620FA77ECD8217B168492920E88F05327CFF825A50E
            4C3DB58E15154815B76FE1C285F2BB391C91C9864DA8A62BF98FF18C93ABCB26
            81CF394015C8C7E77326211EC392D4186171E49E241D94C511C1077CAE024929
            041E492386E8EE78DA69A7C9024C2D12B528492F648528651D318782335EE8EA
            088CFB2C08248491A92B22924ED408678A392BCE06495FDF24ED4B62AC98BD88
            499FA363296BC09A356B24EB858892D69DFA0FF3344288713B61C20419C77498
            0444938E15154889DAB76CD93229E635876C2AE9835413206F1BF1C4E7518A1D
            931823A691085DEAE856C70690C891A284016700C5BE380958781146DCFBE6FE
            4B7A212B4429EB086385A31C489BBEE8A28BACBE97AE438DC291471E190C1932
            24E8D8B1A308A57AF5EA59FD1B495FDF24EDABF45861AE370718CF9831433E7F
            E595575410A510D2EA1044A4C55E76D965F29A717EE2C4D5B1A2022951FB381B
            83F30348CB3027AD67C1EB9825D840005DDF1046142FB3593491A462D1A44A8F
            111339C27BC8C7B871E3E4359A32284A214C1D0A5122CECCA06BD985175E289E
            C9340A24C605F335190064032090A64E9D1ACB7BEB1A448EB8D6D4969146C9B5
            6EDBB6ADBC772A90ECD95789B16236C5CCFBDCCF9F7EFAA97C4E6B7A3EDFB265
            8B0AA49460E668D3559403EF8922E1C8021548A5DBAA022926FB68DA805022C7
            97E74A7A993871A2785989CC908244CD52A122C84A8E111339FAE8A38FAA9B31
            A83052C2C2828B3772F4E8D1B2F0B289CE8D96A64D20911E4DDB7B22ADD3A64D
            B3FB663A0E9132D2E87AF5EA256994069FD76117ED8B7BAC30E773E0F7AE5DBB
            82279F7C526A8B682C02BCA6A487DCF31B19BFCCD5A4C4423E47AD8E1515484E
            D8A702293BA84052D28A0AA4ECA002A932F6A940526CA102295E5B5520C5649F
            096BD23693B42652EFA84B62834ADA9D923ED84C32598D1C39528A99DBB56B77
            C046C350897B90FB8CF420522938C789E78824450903671C51D4CBE1AF1C047B
            C82187E4ADB34B8B40C29985238BB4E8D9B367DB7D331DE5F4D34F97B460BA11
            5263C6FC95AF55BBCFEBB08BF6C53156F6EFDF2F07BC727403F7326776218C4C
            6A9D922E68C2C0FC4C8D20CD721046749984DC94BA9AE8585181E4847DB90209
            AFE4CA952B5520A51C36186C386807EC9240A2FB16CFE956A72861C815484414
            6A468E0C6913488C913973E6587D2F5DC50824CEB1A2E6C838786AE2F33AECA2
            7D9510488F3CF288AC012A90D249AE401A3F7EBCD41CA940B26FAB0AA498ED33
            0D1A98B48824714E12AD35B183340E253D9809894D062976347320E5AE77EFDE
            72B022A977A4E2C5790F1A01FEC20B2F044B962C91BFF5C1071FC8D7B4598852
            8CBA75EBCAFDCBA6F9D4534F95FB95FBB6B6C623BE0B240EC77CE79D7782B7DE
            7A4BC68B69EF9D36780F880E711D8D00E47C23AE35D141D35C260D9B2AD7EDB3
            35566824829DAFBDF69ACCF774CF7DF5D557E51E364E588493921E10467CD076
            9F947E84117B0C0873F86B56C74AA9B6AA40AA907D9C35C0DFA6BB1DE76AF09C
            094D492F449198BC060C182022897B256E81C4C2C8C773CF3D17DC7CF3CDB288
            12C5549430D0AD8C8DF475D75D1774E8D04136CF44196AC37781C4D820CA8A40
            A26D7F5AE13D40E8C26DB7DD268FFDFAF5138154C8E36C7E362DEBB00BF6D91A
            2BD8C8BEE2E5975F0E366CD8502D9094F442D408813478F06049AD3BF4D043A5
            257F58B23A564AB555055285ECC37BCF4244BA1D912316E5071E78402638AD0D
            49272692C4A4C6E684F6B984C4114D3D7AF4B0F237CC3D8828227AC442498492
            8825E71C9916DF8A52082247DCABB366CD92B4508AF55988A150DB7A5F0512C2
            88743ACE83C161C5F8616E4E1BCC3D03070E9414496A23E1B8E38E93C730D7B7
            B6F7AF5CB2BC4F2877AC6CDDBA55F60CEC21881E555555C941AF448B68CEA0A4
            0F938D72C6196748EA3EA2C81C546FC66F98C3EAB33656CAB555055285ED331E
            FECD9B374B873B1665BC974AFAE1BCA433CF3C3368D4A8911CB869835C81C407
            C5B9DC57086F7338A0A214A361C3861229228A4247243C93515236925EC8C2D8
            980B9D1C7120300FAF58B1C2EE9BE91044AC39B78AA8E0942953E4355367542C
            726448E33A9CA47DE58E156AE5D83320EEE9B84833063E94F48228AA5FBFBEA4
            C52292726B42C38E63C8DA5829D756A70512171C0F186F525AECE366E6033BF0
            F2D33589B43B841269514A7AE15E61F0F381979EC337E9108627B755AB5625FD
            4EA2436C7E68E7CA6289579C8D1F114B6D06A21483660CCC63A4D4E1956CD1A2
            85DC8F610E3C063307F2E8C33AC27C8BE380B1F2C4134F54CFC36981460B44AA
            1146DDBA759314C966CD9AC97B606A15C25CD7DADE3F5B24BD0E27695FD84D9F
            D9F8923A475D1CD901448EB887790D1B4D83069B634F7107C4109122324E18C7
            471C714470F8E187879E9F6B92D6B11297AD4E0B24DFD46E2930E191E2C122CD
            A3927ED8B4B08139E18413820B2EB8405A74D2C4A114F6ECD92302092F38A975
            340249D3864F8997934E3A491625EE1FC452D8C891C1B708120D19987311478C
            97B4416A249B2A84D2B9E79E2BE7A4705DCB210BEB7025ED8B2A90B85FA9255D
            BD7AB5A4D599864F4AFA19366C5875A3279C57CCCD51E6E79AA475ACC465AB0A
            A484ED63E2A39312112416ED6FBEF92658BF7EBD4C8E1A364F27FFF66FFF26E9
            4C6C464DAD07B5490827224A6C58F3B507CF85E810F7C8534F3D156CDFBE5DF2
            D2E9566752ED14A51066D3CC993FA46BB0A9E6FE63F18DE299F44520B1A13473
            AC39C43B0D29A8D4133187B089A2290CDE6622484490A92BE35AE63BDB28EAFB
            97F675B892F6151B2BDCA7CCED6496981A65EC213B80FB58E7F8F442DA1C6396
            C64E8C6552F2B977CC81DD504AE4C890B6B112B7AD560512BF870DBFCD378B36
            86B670D93E26C2679F7D5642E7F3E7CF97D7F4D4EB6C8040A23E89C74B2FBD54
            26405A2C1782940B522B6EBFFD76A9A350AFA21205EA8C809A351A8898B4BAA8
            9839D0E64216C73CFDE1871F8A238AC6381CB590161043A79C728A147177EAD4
            4922D3D438F2FE9916CFE56CA8204BEB7025EC2B365610EE085CBA90F2DC0824
            D38847492FE64805CE2EC4F1C15965BC662B252E6D63256E5B0FAAAAAAB22690
            F8676CE737EEDCB9D3EA9BEFAA7D4C7E1CF486E7E8F1C71F970972D5AA55F235
            C493925E8826994366D9F0E0C5EFDFBFBF7C0D4F129F1BCF92891CE15DA41317
            E75F103922D58E0F45A90DE63D0E0425823977EE5C796DF8F0E172DF156AE55D
            0CE64070719EA65E83CDE5830F3E28B5797CFEE5975F5AB1330928D4C6934C84
            9939834D14CFA94BC0E3CC3C8107D6D5750E5C5E872B619FD9F499143A130DA2
            F102AF31A7933D42A41327295DEA1046EC09B4D6289D309659DF69BD4F660987
            735313CA7C4DAD72D6C74A52B61EF4CFCDB75581E453F8CE45FB58E0C89367D2
            1C33668CBC9E865410253C4C94A6252F5E44EE0953084FE4888572E6CC99726A
            3AF7860A68250C08234E5B27A58E4D18D8980F9903C1C5799AE82AC72A70082C
            E3C5774E3BED3449ABE38C2AA2806C9E6AD618F9B0CE65D9BE9A02C9648A5013
            C76BF7DF7FBFCCF36404ECDBB7CFAA1D8A9B901ECBFACEBA4E1498B16D22473A
            5692B355059263F6312858D0D9049B22628A33F9DC84DE9574C3444924093831
            9B08123522D412D09E98C573EDDAB5E20D2764FCF7BFFF3D6993158741181175
            C03379D14517493ADDC48913E56BA6556C39B82890181B38991E7AE821798E38
            F2E9606E9A2B001B256AC3881271DD68AA8167999A233A5AF11ACE13DBEF5F4D
            B2B60EC7BDE92342C47D491A24EDBAE1C5175F1481F4EEBBEF4AC408E1A411A3
            F4C27D60CE24E3D057D679BAD599C35F89EAEB585181542B2667D0785AB2669F
            D9788C1A354A264C42EE5A9C992DCCE6E7F2CB2F17CF12F51314F1925EC7BDA7
            28C52062C4069BFB871A1C72BC6DCD83B979DD2EAD231C99406495082CA975BE
            C1260947C9902143E4BDE8D9B3A7A4E1208A70A215C2B7752E6BF6F1FB113FD4
            1C13215ABA74A9BC4EAD910AA2ECC07DD0B56B57797EE79D778AB3AA662DA88E
            15154805F149EDDAB6CF440668FF4DE488826A5E6322D5A84136301E7E26D2DC
            08122249C5B2520822472CB8D4A7703031CF892031C794DBD92C179722483462
            30F59B44E239EFC8F5C8111B2252E578FF4897E3FF372D7D391F0DB1442489EB
            C747B17A31DFD6B92CD847131D6A8C77EFDE1D7CFAE9A7B27EBFF6DA6BB21124
            7204DCAF4AFA213ACC78667C53030AB4E4CFAD35366471AC6804A9C4372BEBF6
            2D5CB850FE1E29773A992A8A520836D6A47050D88F97DA74088A630E0417E669
            DA78B3F9BCF6DA6B25CAEA03081EBA5501293670E185178A882DB5B3A0CFEB5C
            1AEDA38BE2ABAFBE2AEB368E4E22471CCFA0640F9C1CE3C68D134144B73AA86D
            9C6771ACA8402AF1CDCABA7D9C8FC4E24F6D121104CE4530E1485B21534551FC
            060F259E4852B2BA74E9121C7DF4D1D5354788A6340A24A244CC812B57AE9439
            D11C9AEC126C8810435C1B3ACEF1B9796CDBB6AD7C4FB366CDE4FFA7E690EF55
            81E4A77D44F759ABB18B7B93A8D11B6FBC211DBA881C517BA4077A6703D37C8B
            54670E87670E3EFFFCF325C23F70E040F91E1548F9ED538114E1CD52FBBEC3E4
            D7D39989942B3D1F41511403756BA46A713ECE8D37DE58DDDE14E29A0321C979
            9AA625A4D651AB87F3C84588085143640E80A496A87BF7EE2290D838E93A971E
            FBCC41C474A4C5B149E4C8C75A38A57C10468C7BE3A8621EE8D3A74FA89FCDC2
            5829649F0AA4086F96DAF71D5BB76E152F2905D774C221EFDE1C24A75DEE1425
            9BE091C453493D0BE28896DE2CC878274DCD519A041211232386962F5F2E731F
            4EA3A49B979873A5B816BCEF3C2286F820AAC7FFC6C1D0BCDEBA75EBEA4892AE
            73FEDA878392FB11C725F71F5123523CC9F2A0B9D2B7DF7E1B7CF6D96756FF67
            C56D88E4132D22A58EB918913462C408114CEDDBB70FF53BD23856A2D8A70229
            C29BA5F61D8839619B8264DAD8E2A572D57BAA284ABCD0A58E830549AB9B3163
            8608A69A1DCFD224901044448E8033E35C89A29B6E7344851A376E2C87B9D2B6
            9FEBC346A9B6F750D739FFEC33A9EDACBB34CFA1290829740823B23BB827B599
            4E36611EA0190335A03463402C71DE5114D234564AB14F055284374BED3B103C
            54E64C1C42F94493F05C3129BBB2595014255E10424421381BA761C386E29D34
            45C035BBD5A54120B12965DE638EA3610D70C062A5A2E7D867EA0A88CEF1683A
            50F16804120D32104744F4104AA439F2796DEFA1AE73FED8C7BDC67DC8DFE53E
            24A58EC811671AB116935EC77ACCF7A940CA164488F8603EA60B258FFDFAF5AB
            AE418A421AC64A39F6A9408AF066A97DF9A11894499A76E09C93837062725614
            25FDB019E760C10103060493264D92D48EDADA78A74120218E9E7AEA29D97822
            042B0D9E6044295121DE67D2E5B806A4CB99035C4DCD57CDE639B51563BBB08E
            1442ED3B100451EE41C46FBDF5968822AD075638CC991467C41191A37C91FCB0
            A461AC94639F0AA4086F96DA971F0492392789103F1336217EF55E294A7A61BE
            60C3CDA69CA80585BFA3478FCE1B39CAFD195F05126283CD270269DDBA7532B7
            4D9D3AD5F2BBFA5D440E781F731FCDEBB44A4784922EC3FBCC6688F4390413D7
            81E72A90D2659FB98EACB53C376288FB1087240D18347B23DB5077C85C41B418
            67096799E1B42A341F17C3C7B162D33E154811DE2CB52F1C5BB66C913C68EA92
            104D8AA2A40F36E375EAD491337328FE2D143932F82C902880A78327EDBBE310
            4670C82187481A1CE93078821134B4DE06363D7C8E20A2A9424DCC26BA94D6DC
            2EAE236ADFBFA01112D7972620FC2D3235B4DE57C985C3DC3B74E820F3C35967
            9D25AF953327808F63C5A67D2A9022BC596A5F38E872472EB40A2445492F2A90
            EC535320E1FDA5D01A542065D73E73E8B00A24A5365420D9B74F055284374BED
            8B061B8977DF7D3778FBEDB7833BEEB8434EEF76EDF0444551A2C11947A4704D
            993245D2EAD8CCD320200C3E0A24EA3D68954CEAF0ECD9B30BFE2CB9FE6C4610
            8FA4BC90EE66DA6DF33ED172971A226AB610397C3FDF43DA9C29A02EB699C9DA
            3A9235FB58271144A4A873F030506BA4476828B9506BC8BCC2510A9C67465316
            1AB26469ACA84072E8CD52FBA2A1024951D2870AA4DA5181A4F6958B0A24250C
            2A90542085829F37AD4F5DBC9859B5CF1C5CB77BF76EB193C2D27BEEB9473EDF
            B871A3D5F7415194784118B1204F9F3E3D68D7AE9DCC1546101423EE39D0FC8D
            72A869A3394386F6C9CC5D6C502992E7FF45D4E48220022314F91EF3BEF0888D
            FCDE7C5F33CF4D3386A4DE4357D791B4DA67EE2FD643CE10E430D7679F7D36D8
            BB776FF0E28B2FCAF798343A6D76A418104388A32143868853852639CC47662E
            49E35849CA3E1B02A91C5B35829401FBF088B108B0C9B8EBAEBB825DBB76490E
            B5A228FE50AF5E3D1148B366CD0A3A76EC28F5324449A2E0B240AA69231B5804
            115DEBE810666013C20625173CB7505B24CD87795AEDABAC7DDC5F7BF6EC91FB
            8B282562E8C9279F94D7366FDE2CDF833857945C7AF7EE2DD167EA3E39F839B7
            AD3FA471AC24655FE211A4AAAA2AAB028954059BECDCB9D3EA1B9455FB4C8BDC
            7F5E6F114B78CAF08A2D5EBC58BE8FD71445710F52376831CD61A82CC87C4EAA
            18442DFE8D6B8E8138E641E62D33771972A33E0613FDA9EDFDF0659E56FBE2B5
            8F7B8948D18E1D3B82EDDBB78B10E2673FFDF453B9C7BEF9E61BF93D663DACD9
            A65DC91E38A598574869460C9908129B6DD3DA3B77DE49CB5871C13EDB0229AA
            AD07FDE33B62F9E792F887D4BEE2F6998316F1CE4E9B364D5E534F99A2B809A2
            888578E9D2A5D58793468D1CE512C71C637321CB676339DDA07C9DA7D53EBBF6
            997B88743AB229DE79E79D60FDFAF5E2B1FEE8A38FE4EBAC8D8A928B71465D73
            CD3552BB78C6196704871F7E78DEB9282D63C515FBE25E578ADA635B20F914BE
            CBAA7DE4F2539BC42342096EBDF5D6EA03F0B418555192879A23BC9337DD7493
            D4D8208E48E5C8174189421C738CED854CE769B5CF967DA4CFF1F738FE82035D
            59E368F8811832EBA039005623468A811466B8EEBAEBA4C10B6DBC69F0C206BE
            360795EF63C535FB925E57621348A630CAE69BA5F6D9B58F85814503264F9E2C
            9FE3495381A428C9D3A8512311480F3FFCB0A4D5D190A158238130C431C7C4B5
            90E93CADF6956B1F1DE9E8DEFAFCF3CFCBF9801CFAFAF1C71F5BFD7F94F46122
            47AB57AF1661D4A2458BA2DD427D1F2BAED997F4BAA211A40CDB87B7CC1458B3
            70F0F9DAB56BC59BF6C20B2F68DA9DA224009123A0A535E974FDFAF593C79AB9
            EEA5A21124B52F8DF6B16E014E3FD62E1E1146A4D4F1F7784E2306D3F843516A
            C261DB7408659E1D3972A4BCD6A54B17997B891CE9110095B52FE975450592DA
            57FD7761D9B265B278AC5AB54ACF4C52940468D2A4893CAE59B34652EAEAD6AD
            6B4518195420A97D69B40F5184938F0EADAC5D4F3CF184448F48A35341A48481
            B4BA010306C87C7BE38D37CA6B516A767C192BBED897F4BAA20249ED13CC390F
            DBB66D93143B22492C2C4492F0C0D1E147F3B315251E18AB471D75942CCC1403
            030B35B9EF744C528154BE8D3651FB92B3CFAC43D412C1962D5B64634B7D11EB
            18E973448948A54334F19AA68D2BF9605E256A84083AEBACB3E43E22620F1D3A
            7490C7280D715C1B2BBEDB97F4BAA20249ED136A7689DAB06183D8421B70EA92
            58707491519478A08D37DDEA18B3A6710A39F0BCEEC31C93F44216C6469BA87D
            C9D9679A29BCFDF6DBF2F9830F3E28363EF7DC73B24EE95AA58485D4394411E7
            A85D71C5155263D4A74F1FF95AA91D335D1A2BBEDB97F4BAA20249EDCB0B5D7E
            F0BC519B44BA82296EE5B9D626298A1D104075EAD49122E0091326C8A23C7AF4
            68F91A8BB52F734CD20B59181B6DA2F655C63E7306D6DEBD7B83AFBEFA4A0E3D
            FFF0C30FE5F5DFFDEE77F23DAFBDF69A3C924EC7F7228E34DB4129040D6FE80C
            CA81AF6DDAB491FB9B081282094755A9E858B66B5FD2EB8A0A24B5AF20E46EB3
            E02C59B244162252F0724FB55714A57448A16BD0A0818C533CE150F31C081FE6
            98A417B23036DA44EDAB8C7DAC3D1CDABA6BD7AEE08D37DE08F6ECD923671721
            8070E2016DBC6DDE7B4AFA31C726346EDC381833668C0823D31CA71C742CDBB5
            2FE975450592DA5710E3917BE9A597C443F7DBDFFE56162644121E3D4551A243
            E488143A0E1C1C3264884490C68F1F2F5FA3639DC1973926E9852C8C8D3651FB
            E2B18FF438C41011230E75E439990B88A477DF7D57D6236A8DE09B6FBEA9FE5D
            8A5208D301947A4EC4114E29CE352282D4AA552B998F6D1CA0AA63D9AE7D49AF
            2B2A90D4BE48501FC102F59BDFFC26D8B46993D5DFAD28590141C4D946F5EAD5
            93CE918C553AD6D5C4973926E9852C8C8D3651FBECDA6752E276ECD821CE371A
            04E190A341D0E6CD9B2572F4E9A79F5AB541C90EA42BD36C81A851A74E9DE471
            F8F0E1F2354A067C1A2B59B22FE975450592DA1789D75F7F3DF8E28B2F82B7DE
            7A4BBA07E1C5634123379C454C5194DAA1631245C174ACEBD6AD9B3C4E9C3851
            BE961B3932F832C724BD9085B1D1266A5F792080B0AFAAAA4AD60D1E89182188
            4CC408B1C4EBD41CB1BEF035458902C2880F9C517C9052D7BA756B794E973AA2
            4AAE8F952CDB97F4BAA20249ED2BC93ED2EBC8FDA62EE9B1C71E132F8CA6DC29
            4A6148AB3BF6D863C58379D34D37D51A3932F832C724BD9085B1D1266A5F79D0
            EC67FFFEFDC1FBEFBF2FEDBAC94AA0E902CEB64F3EF9C4EADF52B20BDDE90E3B
            ECB060D0A04141DFBE7D25BDEEF8E38F3FE07B5C1F2B59B62FE975450592DA57
            927DDF7EFBAD448F58D45E7CF145798EA78FDC713D6056510E841C773C992CD8
            78304F38E104891CE1C1CC173932F832C724BD9085B1D1266A5F384CBB6DEC21
            8D8E475E230B812EA9A4CD7DFDF5D7C1679F7D269123D61175B429A5C27CCA07
            A28879958E7438A43A76EC2811235E4724E5E2CA58A98D2CDB97F4BAA20249ED
            2BDB3E163ECE4AE27059A24A44941445F9178CC3A38F3E3AE8DCB97370F5D557
            8B60A2D56C317C9963925EC8C2D86813B52F1C6416B03ED0E487060CA468631B
            CD7E48994324913EA728364014D190A177EFDED28881C3B6DBB56B57F04C2357
            C68ADAA702A9AC374BED73D33E1640BC7F1B376E9445EFC9279F946E434492F8
            1AA9148A924510422CD878311B356A14B46DDB3618376E9CBC56287264F0658E
            497A210B63A34DD4BE033187B732EF83392B8FF580D749C546207DF0C107F235
            0E79A50E0981A4EB83522E44E781083DCD187AF6EC59DDA9AE79F3E62A903CB5
            2FE975C56981C44D4D7E3E6F92DAE7BE7D2C849C9BB47DFBF6FFDFDEB9004B59
            9CE9BF591164BD50A8DC44404440F182A089C6780B18EFB728B28AC6282A4163
            11A2465D50E2BAAEA5AE9B3256C2A28BAE1AD7A86B28D7109750966B5CD722AE
            6B8CBA8410422121DEE514DE5997E4EFF35ACD7F3C7BCE4C7F73FAD0FD7DF37B
            AAA6BE39DF9C33F39BEFCCDBD34FBFDD6FDB17E39C3973EC77955542A815A5B2
            B2FDFBF777C71F7FBCBBF0C20BAD48438831F22A4B1BA323DF23ADC9A7765FA6
            4753E7B405847E56B55369C99225669A56AC58B1C93C21145B2ABE20933475EA
            541B8C52A53A1D43442CE7CB8741AA075732B7DBEA7CDE20693EB90CD20D37DC
            B069BEB9A4CA4408B582147B6AECF525AD514DEDD27EEEB9E706678E6A9FA70C
            6D4CEA2FB210C6986A553E5F8EDBAF2DD25137658374941192162F5E6C4795E8
            D67995ECC620A1D8F299A37DF7DDD7EE4F9E3CD9DA5B4DABD33144AD1ACB65E0
            4BFDBD8241822F3A9F9F6E2143A42914B7DD769B9DFFDEF7BE179505A15CA585
            C0FDFAF573679E79A68D6A16CD1C7995A58D49FD4516C21853ADC4A7E7119F0C
            8EDA73658B342B40C765CB96D9A0D8534F3D658F6BFB07C94FB143A83BA5BD8C
            648C2EBAE822CBD6CB1479D314AA568AE5B2F1A5FE5E896A90F43CB137DD8AB1
            BB317C9B97AFBD41FA877FF8073B2F83A4F3313FF008E5287D51CB20C91C75D5
            2095A18D89F945569576B02A7C7A1E95A7AF6790B4C60883843697FC9A226F90
            66CC98D194416AB5582E1B5FEAEF951E6D6D6DD10C92DFD323E6FC466D1E075F
            B9F9FCB40C6D2C2BA9319393D7343CA65DA02A4953EAD4C05F7AE9A5B6F786DF
            A8B02BCA21861BF149B933C21726DF5EABF08E0AED3CFBECB36680547E5BD3A7
            556C4153EA10DA9CD2F464155C509CDC74D34D766EFCF8F176BE59553D96CBCE
            17D32035C3DAE393862EAA412A53FA0EBECDC3874142AD221924C5C825975C12
            CD20E510C38DF8A4DC19E10B533D83A4B5441F7EF82106096D767983A4CF674C
            8354E5582E3B5F6C835494158304DF66E3F366C897FFBEE79E7B6CAAC6238F3C
            42A53B546A0D1932C4A6D05D76D965EEA8A38EDAB45161BDF2B2A1CA29863BE3
            93726784EFB35AB3668DB5C35A3FA469729A1E270EB5C5FAF9ADB7DEB2A38A2C
            68AF223F755A629A34DA5CD2D4B9B3CE3ACBDAD39933675A86C17FBEBB628EA4
            AAC47255F9304875E4E70CFA4619BE72F3790E7DE9EAFE1D77DC61A392DA5896
            DDD35199357CF870FB029F3D7BB63BEEB8E3ECBEF6E3E8AA728BE1CEF874E47B
            A45C7CCA10E9351F7FFC716B9395E15766C8AF2FD27D9D4728A56490CE3FFF7C
            DB58FB5BDFFA967D3663B4AD525562B9AA7C18A4062A93DB852F4CFEC32FB6B7
            DF7EDBBDF0C20B362AF4C0030FB8175F7CD1EE6B1A0742B96BE8D0A1F6657DC5
            1557D85E1CFA59372946F648CA3186DBF349B933B6129FA6752A03A4A20A7E0F
            A2A54B97DAE32AAC20AD5DBBD6DA62FD9EB244FA5D5FB6DB678B6275A4100A95
            D689A8D8C22EBBECE2CE39E71C1B6C3AF0C003AD3D55DC295662AD7929432CB7
            321F06A9C0C582AF5A7CFAF2159F36967DF7DD77DDFCF9F3DD7FFEE77FDA39F6
            4C4265D0881123AC33AA3DBFF6DE7B6FFB321F306040D4D7C839863D9F943B63
            2BF1E933A94C900A2ABCF4D24B66909429927CA5396F907C461FA11CA4D89239
            1A3D7AB49B356B96B5A9FBECB3CFA6C75B2D965B990F8354E062C1574D3E9923
            7D41AB68838C91E6C4FFF77FFFB7DDFC68274239496B8E34FF7DCE9C396EF0E0
            C16E8F3DF6B052C85B6CB185AD3F8AA932C4B0943B6399F9BC8191D1518667C3
            860D765F47657EF4F7AFBEFAAAB59F5AE3B971E3469B42A7DFF153E9FC3A4F3F
            6DCEAF09F59BBE229442CAC0AB2DDD75D75D6DC3571D8F38E2089B52A7FBED37
            D72E7B2CC317CE87412A70B1E0AB269FBECC253F25E95FFFF55F2D93A42921BF
            F8C52FA2BE1E4231346AD428FBE2FEFBBFFF7B376CD830B7F5D65BDBCFAD1AC3
            52EE8C65E6F306491921B5973ACA1CE9E84D918A2E687AF2EF7FFF7B333FAA38
            A7636DA608A1DCA46CA74C922AD41D7AE8A13655F9C4134FB4F65426A9BDCA1E
            CBF085F361900A5C2CF85A83EFF5D75F776D6D6DF685AF2F774DC19359F25FFE
            08A5923247D2DCB973CD14696EBC374732F8AD1AC352EE8C39F3A92082F87C36
            476D9D4C8DDA3F5590539B2843E4B344CAB6AB8DF419246F96F4BB5ABFA9BFD5
            CFFE2891294239495B22A80083A6CFE9A681A6B163C79A291A346890B5A71D55
            A9CB3D96E18BC787412A70B1E06B2D3E7512D409D01E1C0B172EB44E0253EE50
            4A692A9D74DF7DF7D986B09A56575B8CA1556358CA9D31673E6F90DA6F85F0EB
            5FFFDA0CCECB2FBF6C19201DD52E6AF048BFE3A7D92154362953245374F8E187
            DB4DA6486B8F249F31EDA8D04DEEB10C5F3C3E0C52818B055F6BF1E9CB5FA3A3
            1A2DD50EEE1A3D7DFEF9E7CD28FDFCE73FB7465423A60875A7F4B91F3870A0DD
            BFFAEAABED78ECB1C7DAD4109F39AAFDDD568C612977C6547CCADCF8B543B56D
            9A8E2B57AEB476ECB7BFFDADFDAEAA7A4A1A1812AF8EFA3BADD3F447B579324B
            CA14E91C7B12A13248D3E8D4561E7CF0C166849435D21A2355ACD34DEDA92AD8
            355219DA43F8E2F061900A5C2CF85A97CF2F32D69AA4DFFDEE776EDEBC79768E
            6A77A8BBA5C20BAAA824FDF4A73FB563FBCC9157ABC6B0943B632A3E99226581
            7494B1D14D99701D55904626E797BFFCA5FDAEA6D4497A0CE383AA24155AD080
            D2F4E9D3DD840913DCFEFBEFEF76DB6DB7C2CF5386F610BE387C18A402170BBE
            D6E6D306623249DAB7436B92349AFAC4134FD8A2654D454128A6648CFAF5EBE7
            FAF4E9E32EBCF0423BF7B5AF7DCD8E1AEDEC48A963A4913048CDCBAFE151FB23
            83ACF648E7F4DCCA06F97D84745E86C8678CBC41D2808ECF20A91DAB2DA0A08C
            92A4E9731299715415692A9DDACBCF7FFEF356E1D3679034A5AE998A9F65680F
            E18BC387412A70B1E0834F52C74399234DB5BBE5965B6C0EFEC30F3F1C950BA1
            DEBD7BDB14104DFBF8D18F7E64E7B4EEA89E728991CDCD27E5CED8553E191B49
            1BAFEAB3E14D8EAAC529E3A3D79011F28338FA7D9F39F2851224B55FB53F2354
            65A9229DE2F9ECB3CF3663A47DE23AAA4E17AA32B487F0C5E1C32015B858F0C1
            2769C4559D0F6590B416491D907FFBB77FB3C7346545D2A267363F44CD489923
            1921DDA64C996219A4F3CE3BCF1EABDD8FA323E5122345F9FC9E397E6D8C5F5F
            D55E3AE7F72DD15152C6446ACFA82C8BA4E7D2EB7AF9A93631AEA1CFEA78C3E1
            8FED373F15632D9FD6EF746452F43BFEBC7EA7566A6F2415489041D2FF45AFA1
            9FF5373E6BE48D92CF1EF9CC9157FB9F11AA927C56481B672BCEBFF295AFD820
            93CF20E9BE6F3B9A5115FB34F075CC87412A70B1E083AFBDD4D950A7E457BFFA
            95F15D7AE9A5767EF9F2E594B5454D498648239D43870E75F3E7CFB7CF55C8E2
            6129C71809E15BB46891990A4D5DD5EBA923D3D13442991B8DFEEA31FF3C7E1D
            602DA3D667A98CAFB4C30E3B7C66BD96A6D6F805DB5DBD863EABE3374155E6C6
            AF57AC352162ACE5D3EF2903DD5E9ADAA642096A3B34C852AB37DF7CD38E9A06
            576BF8544DCE7320D4EAD27E46D205175C60EDC5A9A79E6AED6767F15E5455EF
            D3C087416AEA62C1075F7BA933E44771C577EFBDF7DAF93BEFBC73D3882E4221
            DA72CB2DCD1CA962DDA449935CFFFEFD6D41B1D42873E495638CD4E3531535C5
            C8830F3E68AFA38105C58DDE6F47A3BC3AE73776F4D7C497996ECF2863248D1C
            39F2339D2365E66AABFFE9BEB2765A4B281631CA84E971BD4E4719176FDE7CF6
            CA4FF39331EAC82089B1964FD920BFDEA756629051F4C75AF90C92CC56EDFB11
            031921D4AA52EC2A86C78C19633F6B8D9174D4514759FC1E72C82116AF1824F8
            8AF255C220E9EFF5E2B9FE33E16B1D3E2F55C9D10870FBA9360875264D0953D6
            4323A037DE7863A1CC519962A4964FD520D5B9BFF5D65B2D5EBA6350411DA47A
            53EA74DD654C653C7C364A6655064CD75FD9196F80243D973698545C2B7B532B
            6FF8345510D38250F7CA0F66287E67CE9C69E7A64E9D6AED8D6257E6A94CED21
            7C79F1C530485D612583045F25F8FCC8B3F64992B4205423BBEA5C6190503DE9
            4B5C239CDA8B43A56755984199238D7886668EBC728E915A3E655C251539518C
            A8C84977C58B0C673D83A4CE95469AF5DA3E1BE5D738E9FA2BB66BB339FABF78
            E35A6B9C24658EFCF438B2C708758F3480A10CB18E2AD5AD3579A79F7EBA3DF6
            A52F7DC98E8ADD5C0D925759DAEB56E54B9E416A6B6B8B6A901A55792A2A4D83
            800FBE7A5287CE4F7FD18250E9A5975EA2838482A44673F0E0C1363564F6ECD9
            F6A5DE6C95A55C63A4964F191B658C24BD5FD6CF20848A4819DC238E38C2D62A
            9E7FFEF93668316CD8B0FFF37B65680FE1CB972FB6412ACADAE34F9FAA5BDE5C
            8A37045F6BF1F9F5093244D299679E694795DED53A02843A939F3B3F7CF87037
            76EC58CB1E5D7CF1C576AE68E6A856B9C5889762459915DDBEFFFDEFDBB9DB6E
            BB8D3D77104275A536D1B78B32452AD53D71E2441B5C52A54F192465E03B52AE
            ED217CF9F3C53448CDB0463748654ADFC1576E3E75F8342D484CA79C728A9DF3
            53EC106A248D82AA1083AA2C5D72C9259F293CD015E51423B5D234B5050B1658
            B6F53BDFF94E94E74408555F6A2BB53E73DF7DF7B5E9C79AE2AA41A510E5DA1E
            C2973F5F6C835494B5DB0C925F1815F362C1079F97CF1C69277A99A473CE39C7
            CE2D5BB62CEAFB45D5933E77BE0CB56E279C70829B3163469733475EB9C48897
            E242E6C81B241D6FBEF9E6A8D71421541DA97DD4CDAF0554C6485B1F683DE159
            679D655390478F1E1DF45CB9B587F09587AFBB0C52282B1924F84AC7E7176D6B
            73CB69D3A6D9CF7E8A1D428DA47D78FAF5EBE7CE38E30CF7D5AF7ED5B248318C
            91570E31522B152ED0943AC58C9F5A8710429D49D3E86482B4B9EB41071D64D9
            A2430F3D7453E9FD22CAAD3D84AF3C7C95CD2075C7C5820F3E499923658D6490
            94EED7CF648E50A834575E1D00555DD29AB52A1B24BF279037482AEB8D10421D
            C9974356FBA869743248071E78A0192415B1C120C1B739F93048052E167CADCD
            2723A47D5AB4CE486B46547D4B1B5B22142219232D00D5743A4DAB53695A9598
            AE528CD44A7B0269C364ED15A42342087524B5839A4EA7354623468C70471F7D
            B49923B53D324B5D512EED217CE5E3C32015B858F0B5361F0609754518248410
            FABFC220C197231F06A9C0C582AF35F9BC317AFAE9A7DD0D37DC60D3EBFC9A23
            3681458D3464C8109B4F3F6BD62CF7C52F7ED14C92DFE7A82A31522B19A3254B
            96B8152B56B8DB6FBF7D5341138410AAD5A44993AC3D541558ED633470E0406B
            2F7D596F49D3EABAA2D4ED217CE5E5C32015B858F0B5269F37484F3CF184BBF6
            DA6B6D2D853A81088568E8D0A16688AEB8E20A5B68ACD1523F8FBE2A31522B65
            55172F5E6C0669FEFCF951DF1B42A83A3AF2C823AD608DF63252953AADC75465
            CF984ADD1EC2575E3E0C52818B055F6BF1C918691ADD638F3DE6EEBAEB2EF7DA
            6BAFB9175E7861D36308D5934642B7DA6A2B77F9E597DB2263FDBCEDB6DB7E66
            44B4EC31522B152A79E699676C0AEA7DF7DDB7A998094208499A36A73645A5BA
            B7DE7A6B376EDC381B3052BBA841236D9EDDD52975ED459F06BE66F93048052E
            167CADC52773A4DBC30F3FEC6EBDF5567B6D55AE4328449A4B2F8374FDF5D76F
            EA08B4AFC054F618A9958C91B2ACCF3DF79CBBF7DE7BA3BE278450F975D86187
            D900D1C5175F6C0669CF3DF7FC4C05CF2AB587F0959F0F8354E062C1D71A7C32
            45DADB68D1A245EED1471F75AB56ADB2CE9FD652E83184EAC9CFA19F33678EDD
            1F3366CCA6CC51FBF9F4658D112FC584D6E3695ADD534F3D6531A329A86FBDF5
            56FC0B8B102A8D5484460668CB2DB7B42D0D246590A4C183075BB648E6A8AA19
            75F8CACF87412A70B1E06B0D3EAD37D2F4A07BEEB9C7A6D6A9B3B776EDDAA8EF
            035557A3468D3283F4831FFCC0E6D56BA4D42F386EAFB2C688E40B942C5DBAD4
            A6D63DF9E493966D45082165CCB587918C920AD4489FFBDCE7EAFE4D99DB43F8
            AAC787412A70B1E0AB369FCF1C3DF2C82356B14EEB8D74F36B9110AA27658BA4
            B973E75AC648A3A59D658EBCCA1623B59231522106658E745F03095AA787106A
            3DC9100D1830C0DA3C4D29D6C0D051471D658343CA24492AC8504F656E0FE1AB
            1E1F06A9C0C582AFDA7C3E73A4F5461A0957678F0E1F0AD51E7BEC6147ADBF51
            47A07D41868E54B618A99562C4678E34A080106A5DA9BD1B3E7CB855A253F96E
            FDACFDDED4866CB7DD7641CF51E6F610BEEAF161900A5C2CF8AAC9A7EC90A60B
            A9C3A74A5C1A11D7BA0A9D976942A833E933A4BD3BA4ABAFBEDA0C9136395471
            068D9C56CD20F93547DAFCF5A1871E3283F4CA2BAFD8CF08A1D691B62E90F1D9
            71C71DDDAEBBEE6AD9A3FDF6DBCF32492A50A38234DADB486A5F9CA63395AD3D
            84AFDA7C18A43A52E7460D802E127CD5E57BFFFDF76D6A9DF63852152EAD3762
            91390A913EDBBBEFBEBBDDFFC94F7E629FA990CC91575962447C7ECD910A9768
            1F301924324708B5A6648C060D1A64EB2CB5D648FB17699F37155FF01B611755
            99DA43F8AACF8741AA075732B70B5F317DFCF1C7160CCA1CC914A90297AA71A9
            0A179923544FEA04ECB0C30EB600F91BDFF8869D3BF3CC33AD8155F62854B9C7
            482D9FD6E3695FA3071F7CD0E244378A9720D41A52C5396582648876DA6927B7
            DB6EBBD9E09032467E8F37658CD40686668CDAAB4CED217CD5E7C32015B858F0
            558BEFDD77DF358374C9259758196FED71A4E747A89154BA561D04750AEEBFFF
            7E3BD7B76FDFC2CF937B8CD4F2C918693A9D2A3BFA0D931142AD21658C649294
            259A306182DD548846038A1A30927C96393483DE5E656A0FE1AB3E5FA50C929E
            47239C312F56339D1EF8F2E653210635E43FFBD9CF2C8BA472DEDAEB481F5E32
            47A89ED411D0675A37EDEDA16CD105175C608F15C91C79E51A23B57C7FF8C31F
            6C3D9E8C9132467EDD1142A8BA9219D23ACAB163C7BAEDB7DFDE324732491A18
            52A64853EA860E1D6A06C94F49D2F76AB3E6482A437B085FEBF0C53448CDB0F6
            686B6B8B66907CB59498F31BD7AF5F1FF5E2C3979E4F1F5235E4D3A64D73BFFB
            DDEFCC1C691D12428DA4E9245A90AC6A4DAA56E7E72C774539C688E447836FBF
            FD76F7493B6DC7975F7E390A2742286FA9E882A6CA69EAB04CD1F8F1E36D6A9D
            4C93DFD7AD55FA0CF0B5265F4C83D40C6B8F75EBD6453548654ADFC1B779F994
            3992162F5E6CF76FBEF9661B097FF3CD37DD860D1BA2BE6F542D2973A47D3D54
            C2F6A4934EB291D4993367DA631A69ED8A728A915A691A9D8A97DC76DB6DEE93
            76DAFDFCE73FA778094215953A6F1AF0D10090A610EBA8ACF861871D66C51894
            35D2F605B5D539ABDE6780AFB5F9621BA4A2AC1824F8361B9F5F5F3479F264EB
            F06991391BC0A21069AD91A69468AFA3050B1644C91C79E51423B5BAEEBAEB6C
            CAE9FCF9F3599B8750C5A5A9746AD7CE3DF75C6BEF0E38E0003B6A6048A6A8A3
            F54555EF33C0D7DA7C18A43AF273067DC3005F39F9340A2EA984B774F9E5971B
            D7EF7FFF7B5B8384506752E648A3A89A5AA205C99A877FC515575827A1AB9923
            299718A9958A95482A7BAFA9A7CAB8AAA00942A8FC529BE6B72390941D92F6DE
            7B6F3B7FE289275ADB3666CC189B52ECF77493DAAF31AA6A9F013EF8FCF36390
            EAA84C6E17BEFF2B7DD0F581978E38E2884D1B5D7AD384503DE9F33678F060DB
            E7431BC1AAA3A04C524CA58E112FC5866EDFFFFEF7EDE7ABAEBA8AA225085548
            3247323FDA9E40864853E934A342D21A23991FB56F9D658CDAAB8A7D06F8E023
            83D4C4C582AF5C7C32416AE47D49E2B3CF3EDB7E5651060C12AA277524BC19D2
            B4BA71E3C6B9E9D3A7DB796593622A8718565CBCF1C61B765F6BF3A479F3E631
            0515A10AC81B2319A28103079A4152996EB57193264DB2DF513B27E9710C127C
            F061900A5D2CF8CAC3E73347BA9D7CF2C9764E7B1D2114221561504186238F3C
            D27DF39BDFB48E853A18558A915A2953A42A758A9BCB2EBB2CEAFB4308A595CA
            746B9047C7A38F3EDAD6151D75D451F65857F62EAA6A7B081F7CFEF931488117
            0BBE72F0A9C15795BA356BD6D81E0DCA1C49CB962D8BFADE50F5A4CF989F66A2
            AA4D871F7EB89583D7886A150D926245E64871A2620CFA59C5191042E594DA2F
            5F8A5B37AD2152F5B9BDF6DACBEDB0C30EB6D1ABD616A96D933048F0C1D7311F
            06A9C0C5822F7F3E4D9D53674FE6E89C73CEB19FB5E608A11069EF0F75224E3B
            ED34FBFCF8CC91571562A4562ADBADFD9C9469BDE69A6BA2BE2F84D0E695CC90
            F62E1A3D7AB455A5DB7DF7DDCD08C9FC8C1A35CA7E2775A7AF91E8D3C0970B5F
            EA58C120C117954F9923BDE6DAB56B6DE4DF176540A891F4F95241064DAFD3C2
            E5B3CE3AABB206C91764F00649830AAA5A87102A8F6AB33EBA2F83A49B3676F5
            064919233D3672E448FBBDD49DBE46A24F035F2E7CA9630583045F143E19234D
            1552418659B366D9E272ED738450885478A16FDFBEEEFCF3CF775FF9CA576C11
            B33A1AED55E618A9950A95683F2719241D1142E5933673D57E6CFBECB3CFA6AD
            08745FE7B4DE489239CAA9D3D748F469E0CB852F75AC6090E08BC28741425D11
            06092154366190E0830F8394C5C5822F3F3E6F8C9E7EFA6977FDF5D7DB5A0A5F
            8C21D66664A8BA1A326488DB669B6DCC541F72C821B679A27EEE4C658C112FC5
            C3CA952BDD638F3D664795F196144308A1FCA5A9735A6374ECB1C79A019A3871
            A21594519BA5F32ACAE0A7DDD54EBFCBA9D3D748ADDEA7812F1FBED4B1824182
            AF4B7CDE203DF9E493B6C85C6B29D4F943284443870EB5CEC5A5975E6A9D8DCE
            32475E658C112F19A4152B56B8C58B177FC6202184CA21155F90113AF1C4136D
            ADA4363F9741D23A499DEF4C3975FA1AA9D5FB34F0E5C3973A563048F035C527
            63A469741A0DBFF3CE3B6D934B4DAF5327904D6051232973242374F9E5975BF9
            5B156750F6A851A9DB32C548AD34DD545956C5C87DF7DD67F1A36C2B42282F29
            86B54F91DA224D9793B4979FB243071F7CB0B55BAAB6E94B78779635AA554E9D
            BE466AD53E0D7CF9F1A58E150C127C4DF1C91CE9B668D122F7DDEF7ED75E67F5
            EAD551D951753562C408EB5CA872DB7EFBED67FB82D41B81F52A538CD44A9B24
            3FF1C41376BCE79E7BA2F22384E24931EC076BB4A64852454D192195EC56BBA5
            ACB77E6E3F8D1C83041F7CF1F852C70A0609BE427CFA725086E8D1471F758F3C
            F288992275FAF44521C384503D2973A48EC5ECD9B36D7A9DA6ACF8CE48C84689
            6588915A3E95B8D76DE9D2A5EEE1871FB6E9A82ACC8010CA43DA4A401BB9AA1D
            DA7FFFFD6DBADC49279D648FA97D92349D4E52F105BF116C11E5D4E92BC20A1F
            7C29F952C74A1483A4BFD78BE7FACF842F1E9F46F9353D487BB7686A9D3A7BDA
            F308A11069B344752EBEF7BDEFD982674D6509E96C9429466AF9648C747BEAA9
            A7DCC2850BBBE7A222849A96D63DCA00C9244D9A34C9B243E79E7BAE19A15D76
            D925CA6BC4EEF495B53D840FBE227CA963850C127C41527668E3C68D568C416B
            29342AAECC915F8B84503D297324CD9D3BD746613FF7B9CF15CA1C79E51C23B5
            7C5A6BA4ECAAD6E83DFEF8E3EE9376D6BDF6DA6B51B91142C5A5B648E5B9070D
            1AE4F6DC734F1BA419366C980DFEE99C324ADAE055AADDA4BA2BCA6954BC082B
            7CF0A5E44B1D2B3DDADADAA21A24ED651253EBD7AF8F7A81E06B4E9A1AF4F1C7
            1FBB1FFEF0873612AECE1E1D3E14AA3163C69811BAFBEEBB5DFFFEFD833347ED
            95738CD4F2C914C924A962DD92254BA2F222849A97DAA2F1E3C7BB912347BA43
            0F3DD4066A942952FB2493D4DD6D4CEC4E5F19DA43F8E06B862F75ACF4F8D3A7
            EA963797E20DC117974FD921AD2FD2FA09658D9441D23E471B366C701F7EF861
            D4F78EAA257DFE549D4E1D8FEBAEBBCE0C91F60FD1A86C6DE5A7A2CA2D466AA5
            E974BFFDED6FCD20BDF8E28B3688F0CA2BAF447B7E84507DC9E4A86DD168B1EE
            6B2AAFAACE6923571D9525922152265BE7F43B9A56579BCDEECE362666A7AFBB
            59E1832F255FEA58896E90CA94BE83AFB1B4AF918A32A883AB4EDF9A356B6CBA
            10428DA4CF9FA6AA6CB1C51636D54C1D11BFC8B92BCA2D466AA512DECF3EFBEC
            A60C124268F3CA0FC0C808E9FE41071D642669ECD8B176541BA44D5EA590AA73
            5D55FB362676A72FE7F6103EF8BAC2973A56BACD20F98551312F167C9B8F4F6B
            8B7CE648A64855EBB497CBBBEFBE4BE608D5950CD10E3BEC6073F9BFF9CD6F5A
            27E59C73CEB1CE48BD4D6043954B8CD44AD95571A978C973CF3D6731A3BDC110
            42DD2B3FE822D323632443A4985676489921658B548441379F556AB4B6A83BDB
            98EEEAF4E5D41EC2075F0CBED4B1420609BE0EA54D2C65902EBBEC32EBF069C1
            B9D8106A2419238DD46A6FA31FFFF8C796328F1927B9C448AD1E7AE821ABE6A8
            3D8E54BC0421B47924232463A4C20B323FE79F7FBEDB79E79DED2683243314B2
            C75AADAA3C2A5E84153EF852F2A58E150C127C9F91CF1C6903584DA5D388F8AA
            55AB8C4B851A10EA4CCA1CC90CE93675EA54334AD3A74FB7CF608CCC9157EA18
            A995D6E3699D9E8C91061134BD8E354708758FD4C6C81049BED2DCB871E3CC08
            697D918C9236775556C9678B74EBCABE455D556E9DBE22ACF0C197922F75AC60
            90E0FB8C7CE6481DDB952B57DA4DEB90106A24658C349D4573FFEFB8E30E3BA7
            CF5FD562A45632461A4898376F9EC50A42A8FBA43D8B34854E53EAFEE22FFEC2
            CE1D7DF4D1367DCE1767D0F757AD9A59F3586B3C41750000372449444154E54E
            5F1156F8E04BC9973A563048F09994399254965823E2B7DC728B8D846B1D05FB
            1CA17AD2A8AECA76AB7CF731C71C631B2ECA604B3A5F9518A9D58A152BAC78C9
            EDB7DF6E9B25AB08056B8E10EA9A148FCAF668B045ED8832CF7E6D91DA1765A5
            F7D8630F333DCA1449FBECB38FFD4EED34BA5A9384416A9E153EF852F2A58E15
            0C127C9B5E579A32658A75F8549001638442A47D4434DF5FFB8B7CF7BBDFB5CF
            9DA6B848558A915AC91869CAE94D37DDC47E600845920C904C91A6D1EDBBEFBE
            56EC4547B531071C70C067DA166F827C0C77B53A66ADAADCE92BC20A1F7C29F9
            52C70A06A9C5F9340A2EA92CB1347BF66C63D082739F5542A8232973A4CE8CA6
            D469DA8B4CD28C1933ACA3E2AB445521466AA5CC91347FFE7C33480F3EF820C5
            4B102A284D95F399221D9569D67DB51B32435A4FA44C91EEFB822FA3468DFA4C
            DB8241EA7E56F8E04BC9973A5630482DCEE73B77471E79A49925952BF6A609A1
            7AD248EE9021436CAACB77BEF31D334C5A2C5DAB2AC448AD348020DD7AEBAD14
            2D41A8496930C5679E353D4E2668F8F0E16EE0C081764E8649D923A991F1295B
            1B93BAD35784153EF852F2A58E150C528BF2C9046904CE97249E366D9A9D53C5
            3A0C12AA2719218DFAAA23B3E79E7BBABDF7DEDBD61CD58EEE7A953946BC1427
            BE32DDDCB973ED78FFFDF7330515A14EE44D8DAF5EE9ABC829D6745F032B3248
            9A4AA7B5466A4BFC7D658FD48EA81A66ED7375A6B2B531A93B7D4558E1832F25
            5FEA58C120B5209F3A7CAA56A7EA74279E78A29D63EF16142A8DF86AA4F7CB5F
            FEB29B356B56879923AFB2C648AD9429BAEEBAEBECFE0D37DC10F5BD205445F9
            7542AA6A59BB89EBB1C71E6B0668F0E0C1F63B3AAF63578A2A94AD8D49DDE92B
            C20A1F7C29F952C70A06A9C5F8F445A4B5456BD6AC318374F6D967DB79EDE782
            503DF90A531AE955C7E7D0430FB5CCA3CE75B6337D1963C44BB1A218A935482A
            E78D10FA54DECCF812DB3E5324132469F3566F90749C3871A2DD57596E659014
            7B7E7045F1D6CC3AA2B2B531A93B7D4558E1832F255FEA58C120B5109FA6CEA9
            C3A7020C3246FA427AE18517A2F2A3EA4A9D1EAD0B983C79B23BF7DC73ADE254
            67C6C8AB6C31522BED6FA47D8E14337E6A1D42E853F98111DD546A5B3FEB2893
            73FCF1C7DBEFECB5D75E76DE1B282FC5966238466185B2B531A93B7D4558E183
            2F255FEA58C120B5109F3247FA62D27A0A8DFCCB20A9280342F5A4CF91A46931
            3249279F7CB219EC2A1B240D262856EEBAEB2ECB205D7BEDB551DF0342659237
            32FE28D3D3914192219234954ED2CFFA1B0C523E9DBE22ACF0C197922F75AC60
            905A80CF678E648666CE9C694689297528549A52A705D332D5A79E7AAA95E8F5
            8BAF1BA92C31522B6DF8AAB2F71A48B8ECB2CBA2B2235436698D906244851454
            6D4EB7238E38C28CD1B061C3CCE4F83547A16AC5EFE1DA9FE973C1075F63BED4
            B192B541F20DAF1FC186AF39BE8D1B37629050D3EA8A412A4B8CD4F2619010FA
            FF52EC2B46860E1D9AA5412A5B1B93BAD35784153EF852F2A58E95AC0D52D9DC
            6E6E7C1F7FFCB14D6D58BA74A94D119249F2C6A8B66A10421D49A578B5805AA6
            FA4B5FFA92ED4DD259B5BACE947B8CD4CB20295E9E78E2894DFB83490C2CA0AA
            69E4C89136E8317EFC7833437E8FA23163C6D8E0881E53D54A755E6A6F922FCA
            5054ADF43D9CDBA8781156F8E04BC9973A56304815E6F306E9E9A79F76575D75
            95ADA558B16245545E545D69C45886E85BDFFA968D1817C91C79E51E238D0CD2
            534F3D6506C9173361CD1EAA9A468D1A65B1BDDF7EFB6D9A4A27A3B4FBEEBBDB
            7DC5BCAF4AE78D911F606B760D512B7D0FE7D6E92BC20A1F7C29F952C74A5483
            A4E7D1FE3A312F96DF2C0EBE70690A9D36B1FCF77FFF77F74FFFF44FEEADB7DE
            B20E9EBED4D8041635923A45EA305D7EF9E56EDCB871367AAC11E5664BF0E618
            23F5F814238A1F5FA84171A318929E7DF659FBD99FD7C6CAFA5D95CDD700C4FB
            EFBFEF366CD8E0D6AF5FEF3EFCF0C368EF1BA11029A3A3D8550115559CD4CF3A
            EA733E7AF468FB9DC30F3FDC8EDA9455E775D4EF290E34A0A67DCD7C61059DAF
            8D911845155AE57BB833BE989DBE56BF96F0559B2F75ACF4686B6B8B6690F466
            62CF6F544703BE6252874DB7471F7DD4DD78E38DF6A178F9E597A3BD67546D69
            CA4D9F3E7DDC4D37DDE40E3CF0405B6BA0CE52B3CA31461AF1C9FCE826C3A3A3
            7E47FAAFFFFA2F3BBEF9E69BF637CAC8CA10AD5EBDDA324EFA7D19AB4FDA55FB
            19A1CD29991BC5ABB23E1AD890C151F6C797E096FCE6E0DA8B48864723B63AEA
            EFF47BED4D90FFFCC7AC3AD70ADFC39DF1C5ECF4B5FAB584AFDA7CA963A5C7BA
            75EBA21AA432A5EFAAC6E747BD658C1E7EF8611BD5FEE52F7F69E734DD0EA17A
            D29A237590FEE66FFEC63678D488B31A94DA3507CD28A71829CAE733AEFEE8B3
            42CAD2FA9FD5817CF7DD77ED9C374EDA6B4C53F5946952F649AFA1A39E479926
            9FA5F2D273E83C42B5D240456DEC293BA4185586C8678774539CF6EFDFDF1ED7
            7D6585060D1A644669ECD8B1F6B7BE24BF2FA8E0CD50476B8BDAABCC319C1B5F
            EC4E5F2B5F4BF8AACD973A56304815E2F399A3FBEEBBCF2D58B0C03A67324908
            85489923658AEEB8E30E5B7FA0F547CD2EC2AE554E31129BCFAFC590B951B5C8
            D75E7BCD7E564649F7FD4DE64855F164A29459F2A5F76B9F878C136A2F1546A9
            352D324C3247323E8A556587648464927C4105C5877ED679BF4751AD3A2BD053
            6F10A4CA31BCB9F95277FA8AB0C2075F4ABED4B192B541F2730663555CAB2A9F
            CF1C2D5AB4C83DF9E4935669EBF9E79FB7A93FBA21544FCA1CA973347BF66CEB
            584D9C38314AE648CA2546BA9B4FF1A7E750BCC9582A26FD5A401DFD7DBF0E50
            F7659A745E664AE7B49E49D2C086A4F3325DFAD9FF4DCC05AB281FC9F8482A98
            20F9357F7BEEB9A73DE6D707C9F4C834F9F541BE708AA6D6E9E8D70E2983E47F
            2E5A82BBBD5A258637175FEA4E5F1156F8E04BC9973A56B236485299DC6E2A3E
            8D5EABA3356FDE3CF7D0430FD9D41E8D5623142295F35547EACE3BEFB40E989F
            6A174B39C44877F3D536E87E4D47BDDF95D9516649B1ABCA783240BE84B88F5D
            1556D1794DD79351F2592A542DE9B322D323EDBFFFFE76F4EB83B406508F693D
            91CC90F61D9259527CB68F51FF199459CA3146BC728DE1CDC597BAD35784153E
            F852F2A58E150C5289F9FC88B4D61BA993A572DE3AEA3CEB19503DE9B33678F0
            60BB3F67CE1C9BB6E3377FF49DB35822863FABDA2C928E7EC44C1C928F5D5F29
            EFF5D75FB7A30A3FE8F7B5EE49C7DA8A799A9EA7FB7A4CEBA15E7DF5D54D192D
            894C72F749191BC58B3287CADAF89B3237DB6FBFBDC5948E5E7A4CD3E1F437FE
            BCFFFFF8D8F3E5F4F5B39EDFAF3D5236C93FD6598C562146AACC97BAD3578415
            3EF852F2A58E150C5289F9FC5A86EBAFBFDE3DF6D86336F2ACEC11428DA4CF9A
            D619493FFEF18FADD3A5693D8C3E773F5FFBE90D9D7574FDEF29A6C5F7F6DB6F
            5BB1151920992B1928B5017A5CC5216498F498A6EE2D5FBEDCB24DBE0A9F8EA8
            7BE4ABBFC9CCE8BE8C91CC92B2B1324232412A9DEFA5C75438417FE3CFFBCF60
            AC2A71658F912AF3A5EEF41561850FBE947CA963058354423E4DA7F39923AD53
            58BC78B17588D459227384EA499F3155BB52C668D6AC59766ECA9429D6599349
            AA4A8C54894F86477C3245323D3E73AC6C91DA02991FDD74DF6790649AF43BBE
            ADD0408A9E438F2B1BE1D739F9E980BA067EBFA7DABDD26A2BEEE9B9F4B3DA19
            FFDC5267D72E45D6CA6773DA4B9F77FD6F644EFC7A1FFFFBB5D9995AF9696FFE
            A8753D929E477FE3A5E7D4F3E85AFAE209BAE9BCCC924C53ED67428FC934D5AE
            0FCAFD33085F3CBED49DBE22ACF0C197922F75AC60904AC8E73347575E79A57B
            E69967AC529DEFF020544FEA28EEB6DB6ED6C15BB870A19D6BBF315B1562A4CA
            7CED3350BE40848E3250DE34B597DFE05699420DAC485AD3A28EBAD639E9EF57
            AE5CF9994116BDB63745BAE9EF65BEBC59923ABB76326A9B5B32251D19241917
            7DF63538E08D8E2453A4EBA1C76BFF6F324CFA3D3D973243FE5A49FA1FEB6FBC
            F477DE10D5EE17E6D70975B45EA8D1FFB82B2246F2E64BDDE92BC20A1F7C29F9
            52C70A06A9447C7E3458D5EA34D2AB72DEAA7CE53B310875264D9D931152C7EE
            ECB3CFB69F2FB8E0027BCCAF6990CA1E23ADC2D7DE24F98D6DBD51F2FB9EB5FF
            3D6590F439A8CD20497E1D94CEFBCC902453A49FF5B8DA18B1E8A6D7F0BFD759
            A6C83F2EA354CBA1DF6F54454966A688FC1E3F9DAD9FD3F5D3675ED9209FE5D1
            6BC820C908D56690C4E6D714493E83E40712FC8683FE757CB5387F9442F717AA
            F73F6E56C448DE7CA93B7D4558E1832F255FEA58C1209588CF776266CC98E156
            AC5861E648E7106A2475FE76D96517DB37E51FFFF11FED5C6DE6C8ABEC3102DF
            67D5DE88B45F63D6683D948C902F24E1A7F0B6DFAFC9678A3A635476AAF675F4
            7E6A4D5847D7B0FD74B746D27A1F496B7A3ACAD688B1964F864AC64703062A6D
            DFD1356B7F2D3AAB5418BAA6AC9EAAFC19842FAF4E5F1156F8E04BC9973A5630
            4825E0F39D09AD355207E5D65B6FDD5490416B0310EA4C7ED45C538B8E3BEE38
            3345D3A74FB7C7FCA87BADCA1A23F075AC18064952BB53BBA753ADFC204D678C
            2A2E512B4DFFAB5DE7D4D135F4D99B50F98C8EDE5B4706498CB57CCA1E298B24
            23D6FEB58A1AA4F6D71183045F3DBED49DBE22ACF0C197922F75AC60904AC0E7
            CBFF9E7EFAE9668A943D624A1D0A91CC91D64E6803CA5B6EB965D3F4A0CE54D6
            18812F2D9F943B237CF0E5C097BAD35784153EF852F2A58E150C52C67C7E94F5
            F1C71FB711CAABAEBACA5E4F5356EA4D5141489902AD89D0D4A3830F3ED8CA0D
            6B6AA646B73BCA1C79952D46E0CB834FCA9D113EF872E04BDDE92BC20A1F7C29
            F952C70A0629633EDFF138FAE8A3CD102D5BB60C638482A42CD1902143DCFEFB
            EFEFFEEAAFFECA0C53C8B4A5B2C5087C79F049B933C2075F0E7CA93B7D4558E1
            832F255FEA58C12065C8E7CBF63EF7DC7376FEFCF3CFB7732ACA506FEE3E4232
            425A5BA18CD1DE7BEFEDF6D8638FA0CC9157596204BEBCF8A4DC19E1832F07BE
            D49DBE22ACF0C197922F75AC609032E3D3C8BF2FA97BFCF1C7DBF9175E78A161
            595C84246D403970E0403769D22477C9259704678EBCCA1023F0E5C727E5CE08
            1F7C39F0A5EEF41561850FBE947CA963258A41D2DFEBC573FD6796854F478DF2
            6B13471924ED57232D5FBE1C8384EA4A46485922658E76DD755777D0410759E6
            5115BD423247658911F8F2E4F3AF9133237CF0E5C017A3D3C7B584AF15F852C7
            0A19A44CF834754EA6482570CF3AEB2C3344CA1C211422ED6FA4FD5C4E39E514
            77DE79E75919E31063D45E39C7087CF9F249B933C2075F0E7CA947C58BB0C207
            5F4ABED4B1D2A3ADAD2DAA41EA68F3C9AE68FDFAF5512F50AE7C2ABEA00F8636
            619C366D9A19A4975E7A292A2BAA9E9435D2E74F051964924E3AE924CB3C76C5
            20E51A23F0E5CB27E5CE081F7C39F0C5EEF4B5F2B584AFDA7CA963A5C79F3E55
            B7BCB9146FA86C7CCA1CC914691ADD45175DE43EFCF043F79BDFFC26EA7B46D5
            95A6D469DD910A314C9D3AD54A7BEBD615E51623F0E5CF17F38BACBB18630A3E
            F89AE52356E0832F8C2F75AC443748654ADFE5C08741425D517718A4DC6204BE
            FCF9627F91B5E23584AF35F88815F8E00BE34B1D2BDD6690FCC2A89817AB4A7C
            9A52A73547CF3CF38C9B3B77AEDDD73E479E0DA17AD2943A55A79B3973A63BF5
            D453ED7E3353EA3A522E31025F79F8BAEB8BAC95AE217CADC147ACC0075F185F
            EA5821839488CF1BA4A54B97BAD9B367DBFD152B56447DAFA8BA92415249F859
            B366B9D34E3B2D4AE6C82B971881AF3C7CA947FA4218630A3EF89AE52356E083
            2F8C2F75AC609036339F8CD1471F7DE49E78E209376FDE3CB76EDDBA4DFB1CB1
            092C6A24192319A1CB2EBBCC4D9830C10A330C1D3AD48A35C452EA1881AF7C7C
            A9BFC84218630A3EF89AE52356E0832F8C2F75AC609036339FCC916E8B172F76
            37DD74936D0ABB6AD5AAA8EF115557C3870FB7A9749A9679C00107D87D99A498
            4A1D23F0958F2FF5175908634CC1075FB37CC40A7CF085F1A58E150CD266E253
            E6483719A3871E7AC8AD5DBBD63DFFFCF39635D27984EA4999A35EBD7AB92BAF
            BCD28D1831C23683DD76DB6D6D8358156988296218BEA27CA9BFC84218630A3E
            F89AE52356E0832F8C2F75AC609036139FCF1CDD7FFFFDEEF6DB6FB7A9756BD6
            AC89FADE50753572E44833487FF7777FE776DF7D77B7F5D65BBB9E3D7B562A46
            E02B2F5FEA2FB210C698820FBE66F98815F8E00BE34B1D2B18A46EE693295296
            68D1A245B6EE48E5BC9539F26B9110AA27658EB4BE48853C76DC7147377EFC78
            CB1CE99C6E558811F8CACF97FA8B2C8431A6E083AF593E62053EF8C2F852C70A
            06A99BF9549D4E6668FEFCF9EEC1071F746FBCF1867BE59557A2BE27545D8D19
            33C68CD082050BDCE0C18337658EBCAA1023F0959F2FF5175908634CC1075FB3
            7CC40A7CF085F1A58E150C5237F1293BA4CA740F3FFCB055A9D37E473AEABC4C
            1342F5A40D60A53973E6B8DEBD7BBB891327BA3E7DFA9839AAAD5857E61881AF
            3A7CA9BFC84218630A3EF89AE52356E0832F8C2F75AC6090BA89EFBDF7DEB3A9
            75AA54A7C20CCA1A297B845023E973A57546D23FFFF33F5BA53A3FADAEA3DF2D
            6B8CC0571DBED45F64218C31051F7CCDF2112BF0C117C6973A56304891F9349D
            CE678E56AF5EED962C59E2962D5B668689CC11AA277D9EFAF7EF6F59A24B2FBD
            D4CE4D9E3CD97EEE6C13D832C6087CD5E34BFD4516C21853F0C1D72C1FB1021F
            7C617CA96305831499CF678EB4A87EE9D2A556A94E15EB106A2495EC1E3D7AB4
            DB72CB2DCD604B7DFBF6ADFB37658C11F8AAC797FA8B2C8431A6E083AF593E62
            053EF8C2F852C70A0629129FCF1CA95A9DA6D2A920C3CA952BEDF5C81CA17A92
            319211D234BAB3CF3EDB7EBEE0820BECB1CE32475E658A11F8AACB97FA8B2C84
            31A6E083AF593E62053EF8C2F852C70A062912DF3BEFBC6306E9A28B2EB252DE
            AB56ADB2730835928A3068E35795F1BEFBEEBBED5CA3CC9157996204BEEAF2A5
            FE220B618C29F8E06B968F58810FBE30BED4B192B541D2A2F4EDB6DBCE2E52AE
            7C1AE1179F0A31687ADDBC79F3DCDAB56B2D8BC43E47A89E942952D6A85FBF7E
            EE84134E3053347DFA747B4C85194254861881AFFA7C3AF23D021F7C8DF95277
            FA8AB0C2075F4ABED4B192B5412A83DBF59A3A75AA7BEDB5D7DC8A152B985287
            82A43D8D860D1BE6468E1CE96EBDF556FB3CA97128A232C4087CD5E74BFD4516
            C21853F0C1D72C1FB1021F7C617CA9630583D4A45488417CCF3DF79CDDBFE69A
            6BAC1883B2475A8F84506752E64819A2010306B8830F3ED8F63C9A3163868D9E
            84668EBC728E11F85A872FF5175908634CC1075FB37CC40A7CF085F1A58E95A8
            0649CFA37537312F56E85A8CCDCDB77EFD7A3B9E71C61936954EA5BC31462844
            FA4CCB144D9830C15D77DD756698B6D9669BA69E2BE71881AF75F8627E91B5EA
            3584AF35F88815F8E00BE34B1D2B3DDADADAA219243F4528E6FC4619919CF894
            2D523186679F7DD67E56B5311923ED79B471E3C668EF1B554F3242BD7AF5723B
            EFBCB31B3F7EBCDB6BAFBDDCAC59B39ACA1CD52AB71881AFF5F8A4DC19E1832F
            07BE989DBE56BF96F0559B2F75ACF458B76E5D548354A6F45D51C918C9812A63
            74ECB1C7DAB95FFDEA57515380A8BADA7EFBEDDDC08103DD31C71CE3AEBAEA2A
            DB00B6D9CC51AD728A11F85A934FCA9D113EF872E08BDDE96BE56B095FB5F952
            C70A0629503247CA14A97CB78E679D75969DFFF5AF7F8D414275A5CC91B2449A
            56A772DE93264D72175F7CB119A4AE648EBC728911F85A974FCA9D113EF872E0
            4BDDE92BC20A1F7C29F952C74AD606C9CF19943949C9A769752AE1ADD2DDA79F
            7EBAF1BCF0C20BD1DE27AAB6548C61871D7670279F7CB295F1EEDFBF7F146324
            E51223F0B5369F8E7C8FC0075F63BED49DBE22ACF0C197922F75AC646D90A41C
            DCAE32466FBDF59619A473CE39C7FE792FBDF452D4F789AA273FD75599234DAD
            3BFEF8E3DDB9E79E1BD5204939C4087CADCD27E5CE081F7C39F0A5EEF4156185
            0FBE947CA963058354473E73A4BD8D5486594649D5EA100AD1A041836C13D8AF
            7DED6B6ECA9429AE77EFDEAE4F9F3E958A11F8E0C320C1075F385FEA4E5F1156
            F8E04BC9973A563048758441425D110609BE56E1937267840FBE1CF85277FA8A
            B0C2075F4ABED4B18241AA2395F2D606B09A13F9F4D34FDBB958733751753564
            C810AB4EA7420C5FFEF297DDD65B6FBD694A5DD562043EF83048F0C117CE97BA
            D35784153EF852F2A58E150C521DC920A91CB30CD2D2A54BA3BE2F545DC920A9
            DEFECC9933DD51471D6599A3ADB6DACA1EAB5A8CC0071F06093EF8C2F95277FA
            8AB0C2075F4ABED4B18241AAA3254B9658E5315FE21BA17A923152A6E8924B2E
            7113264CB0620CDB6EBBAD95F8F6AA5A8CC0071F06093EF8C2F95277FA8AB0C2
            075F4ABED4B18241AAA3C58B176FDA1016A1461A3E7CB819A4ABAFBEDA1D78E0
            81B6DEA857AF5E9FF99DAAC5087CF06190E0832F9C2F75A7AF082B7CF0A5E44B
            1D2B18A44E5E73CD9A35B6EEE8A28B2E8AFA7E50F5A4CC918CD0E5975FEE468E
            1C699BC1FACC516DF648AA4A8CC0075F2D9F943B237CF0E5C097BAD35784153E
            F852F2A58E150C5207D29E472B57AEB475479A2E85503DC914C920DD7CF3CD6E
            8F3DF6B0A20C3D7BF6ECF077AB1223F0C157CB27E5CE081F7C39F0A5EEF41561
            850FBE947CA9630583D481B4DEE8830F3E708F3DF698956746A8232973A40CD1
            ECD9B3DD8E3BEEE8C68D1BE7FAF6EDDB61E6C8AB2A31021F7CB57C52EE8CF0C1
            97035FEA4E5F1156F8E04BC9973A56304875C41A24544F63C68C312374FBEDB7
            9B59AA9739F2AA5A8CC0071F06093EF8C2F95277FA8AB0C2075F4ABED4B18241
            AAA3E79E7BCE5D7BEDB5C6F0E4934F467D5FA8BCDA69A79DEC3867CE1C2BE17D
            F8E1876F32479D658EBCAA1623F0C18741820FBE70BED49DBE22ACF0C197922F
            75AC6090EA68C58A15EEAEBBEE72AFBDF69A1D1192B4CE487AE081076C43D8F6
            A5BCEBA96A31021F7C1824F8E00BE74BDDE92BC20A1F7C29F952C74A1483A4BF
            D78BE7FACF6C964FAFBD6CD9322BD870E59557DA7E486FBCF146D4F787CA217D
            76B4AF918CD0B7BFFD6D3B77CA29A7587106DD1A19A4AAC6087CF0C53248AD7E
            0DE16B0DBE189D3EAE257CADC0973A56C820054826E9F4D34FB7E20DCA2AA1D6
            D3165B6CE1468F1E6DC7471E79C4CE15C91C79553546E06B6D3E297746F8E0CB
            812FF5A8781156F8E04BC9973A567AB4B5B5453548AAE21553EBD7AF8F7A819A
            E1D314BB7BEEB9C7BDF3CE3B6EC182059649522970547DC910F5EBD7CF367D9D
            366D9A19A20B2EB8C01EDB6AABAD0A3F5F556304BED6E6937267840FBE1CF862
            77FA5AF95AC2576DBED4B1D2E34F9FAA5BDE5C8A37D41D7CFFFBBFFFEBDE7FFF
            7DF7FAEBAFBB73CF3DD70CD26F7EF39BA85C284FC904EDB6DB6E56C67BE1C285
            76AEAB2326558C11F85A9B2FE617597731C6147CF035CB47ACC0075F185FEA58
            896E90CA94BE0B950CD1471F7DE4DE7DF75D77DB6DB7B98D1B37BA7BEFBD77D3
            F3A1EA4999234DA193319A3C79B2DB6EBBEDDCCC9933EDB13FFFF33FEFD27357
            3146E06B6DBED85F64AD780DE16B0D3E62053EF8C2F852C74AB71924BF302AE6
            C54ACD27A3249324B374EAA9A7DA396592741E554B2ADB3D6CD830DBEBE8CE3B
            EFB4A97532493154E51881AF35F9BAEB8BAC95AE217CADC147ACC0075F185FEA
            58218354403E93F4F1C71FBBBFFEEBBFB673FFF22FFF6253F0DE7BEF3D8C5205
            A4CC91324403060C70871E7AA81B316284BBE4924BECB1AE668EBCAA1C23F0B5
            265FEA91BE10C698820FBE66F98815F8E00BE34B1D2B18A426A5B98CE23BEDB4
            D3CC34A9BA9DAADCA1724B59A2214386B87DF7DDD75D7FFDF556A04173628911
            F8E0EB9C2FF5175908634CC1075FB37CC40A7CF085F1A58E150C529352C6487C
            73E7CE3583F4D8638FB90F3EF8C0EE93492A9F9439D27E463BEDB4931B376E9C
            4DADBBF0C20BDDF6DB6F6FD3ED8811F8E0EB9C2FF5175908634CC1075FB37CC4
            0A7CF085F1A58E150C5217F9BCA64C9962E5C057AD5A654609954BFA9C0D1E3C
            D81D76D861EEF2CB2FDF54A481CE1F7CF035E62346E0832F8C8F58810FBE30BE
            D4B18241EA229FDF285415CEDE78E30DF7ECB3CFDA7E495A974426297FC908E9
            7FA8CC91CA797FFEF39F77D3A74F773D7BF6B4CC119D3FF8E06BCC478CC0075F
            181FB1021F7C617CA963058314894FA64886489DEBE5CB97BBD5AB57DB343C94
            B754C6BB7FFFFEEEC4134F745FFFFAD7DD965B6EB9A918039D3FF8E00BE32346
            E0832F8C8F58810FBE30BED4B182418AC42783242993A4820DBAF93D92C824E5
            273F3D5299234DAD3BE69863DCB469D32C738441820FBE627CC4087CF085F111
            2BF0C117C6973A56304891F99435D2F43AAD6359BA74A95BBB762D9BC966A841
            83065985BAAF7EF5ABEEF4D34FFF4CE6C88BCE1F7CF085F11123F0C117C647AC
            C0075F185FEA58C12045E6C32095431824F8E08BC7478CC0075F181FB1021F7C
            617CA9630583D44D7C9A72A77D916EB8E106B764C912AB70F7D65B6F457D2FA8
            B8B4C791F63A9A3163864DABEBD3A74FA71BC0D2F9830FBE303E62043EF8C2F8
            8815F8E00BE34B1D2B18A46EE2F399246D36BA78F1620C5226F206E9E28B2F36
            83D4BB776FB7D5565B75F8BB74FEE0832F8C8F18810FBE303E62053EF8C2F852
            C70A06A99BF87C610699226593EEBAEB2EB770E142B76EDD3A2B078E36AF648C
            94299A356B9695F2DE61871D6C9F235FA6BD23D1F9830FBE303E62043EF8C2F8
            8815F8E00BE34B1D2B18A46EE6D3A6B19A6A376FDE3C77FFFDF79B615236096D
            5E0D1F3EDC0CD29C3973DC41071D6453EB7AF5EA55F76FE8FCC1075F181F3102
            1F7C617CC40A7CF085F1A58E95AC0D9246F7351DCA97642E239FCF24A9588332
            478B162D72F7DD779F6595C82475BF9439921152D18C51A346B95D76D9C5F5ED
            DBD71EAB973DF28FEBFFAB2331021F7C9DF31123F0C117C697BAD35784153EF8
            52F2A58E95AC0D52D9DC6E3D7DF4D1477693399A3F7FBE71C834A1EED5881123
            6C8DD14D37DDE4F6DC73CFA0CC9117A3E3F0C117C6478CC0075F181FB1021F7C
            617CA9630583B499F89449D26DCD9A356ED5AA55EEE9A79FB675499A82472629
            BE9439D268C4ECD9B3DD800103DCDE7BEF6D99239D6B9439F2A2F3071F7C617C
            C4087CF085F1112BF0C117C6973A56A21A243D8FA68EC5BC587E3A5455F87C26
            E9D1471FB512E0E291694271A5E9743D7BF674B7DD769B1B3A74A8DB7AEBADED
            E722F2FFDF98419AC367103EF862F31123F0C117C647ACC0075F185FEA58E9D1
            D6D616CD20E9CDC49EDFB87EFDFAA8173F359FB2482AFFADE9752FBEF8A25BBE
            7CB9FBE10F7F68851C2803DE752973A4FFEF75D75D674519264E9CE8B6D9661B
            3347A199A35AE9FF2B55E933081F7CB1F9A4DC19E1832F07BE989DBE56BF96F0
            559B2F75ACF458B76E5D548354A6F45D4A3E19A20F3FFCD0FDE217BF70D75E7B
            AD4DB57BF9E597A3B2B5A2F6DA6B2F3BAA188682C12F206F56FAFF4A55FC0CC2
            075F2C3E297746F8E0CB812F76A7AF95AF257CD5E64B1D2B18A4447C3E93F4CA
            2BAFB8279F7CD28ECA24E93C6B928A49FFD7810307DA7D994D69CA9429569CA1
            D9CC91179D3FF8E06BCC27E5CE081F7C39F0A5EEF41561850FBE947CA963256B
            83E4E70CFA52D955E493497AFFFDF76DAADDA5975EEA366EDCE856AC58118DB1
            15B4C5165BB8D1A347DBFDFFF88FFFB06357334752ED9C5562043EF83AE72346
            E0832F8C2F75A7AF082B7CF0A5E44B1D2B591B24A94C6EB719E983A0E976CA1A
            3DF2C8236EC3860D6EC18205769E3549F52563D4AF5F3F2BDD7DDE79E7D9FFF7
            DBDFFEB63DA6EC510C313A0E1F7C8DF9A4DC19E1832F07BED49DBE22ACF0C197
            922F75AC609032E1532649EB90944D3AFDF4D3CD202D5BB62C2A6BD5D4BB776F
            B7EBAEBB5AB6E8473FFA91FD7F870F1F1EF535E8FCC1075F633E297746F8E0CB
            812F75A7AF082B7CF0A5E44B1D2B18A44CF86488943D92E6CD9B6786499924E9
            93FF5154E6B24B99A36DB7DDD6B247279F7CB255A99B3E7DBAFD7F77DA69A7A8
            AF45E70F3EF81AF349B933C2075F0E7CA93B7D4558E1832F255FEA58C12065C6
            A76C88E6602A9B74F4D147DB79659262CD19AD82B4A7D1B061C36C7FA3F9F3E7
            7FA67C239D3FF8E0DBFC7C52EE8CF0C197035FEA4E5F1156F8E04BC9973A5630
            4899F1A9A3EF37939D3B77AE9DBFFFFEFB2DA3F4DE7BEFB5B45152E6487B1B0D
            1830C01D76D86156B9EEA28B2EB2C7749ECE1F7CF0A5E1937267840FBE1CF852
            77FA8AB0C2075F4ABED4B18241CA98CF773C8E38E2082BE4A0EA763AB6AA34AD
            6EE79D77B6BD8E6EBCF1C64D86D28BCE1F7CF0A5E1937267840FBE1CF85277FA
            8AB0C2075F4ABED4B18241CA984F192369E6CC99668C962C596253EF945D6AA5
            4C923247BD7AF5B2F545FBEEBBAFDB6DB7DD2C73A432DECA1C7576FD6288CE1F
            7CF035E6937267840FBE1CF85277FA8AB0C2075F4ABED4B182412A019FEF804C
            9E3CD9CA81AF5CB9D24C52AB48D764F0E0C1EE8B5FFCA29B3D7BB61926156668
            2F3A7FF0C197864FCA9D113EF872E04BDDE92BC20A1F7C29F952C70A06A9047C
            2ADA202993A4BD919E79E6193BA7754955CE24C908294BA4CC913682DD7FFFFD
            AD5A5DCF9E3D3F93396A74FDBA223A7FF0C1D7984FCA9D113EF872E04BDDE92B
            C20A1F7C29F952C70A06A9447C7E87E1F3CF3FDFD623AD5EBD7AD334BC2A6AC7
            1D7774FDFBF777C71E7BACFBC637BEE1B6DC72CB0E8D91179D3FF8E04BC327E5
            CE081F7C39F0A5EEF41561850FBE947CA96305835422BEDA4C92A6D92D5FBE7C
            9369AA522649D74199A3418306B9214386B8A38E3ACA4D9B36ADD3CC51E8F56B
            4674FEE083AF319F943B237CF0E5C097BAD35784153EF852F2A58E150C5209F9
            9435D2F4BACB2EBBCCA6DBAD5DBB765327A50A9231D226B0679C71863BEBACB3
            1A668EBCE8FCC1075F1A3E297746F8E0CB812F75A7AF082B7CF0A5E44B1D2B18
            A412F261903A169D3FF8E04BC327E5CE081F7C39F0A5EEF41561850FBE947CA9
            63258A41D2DFEBC573FD6756954F4649E5BFAFBFFE7A2B01FEDA6BAF591187B2
            4AC518FAF6EDEB66CC98E18E3BEE38D7A74F1FB7D5565B75DBF50B51ACCE5F55
            3F83F0C1478CC0075F385F8C4E1FD712BE56E04B1D2B64904ACCE73349D75D77
            5D250C92D61B69E35719A4134E38C1F5EEDD3BC82079E5DCF9EB6E46F8E04BC9
            27E5CE081F7C39F0A51E152FC20A1F7C29F952C74A8FB6B6B6A806491980985A
            BF7E7DD40B54253E5F9841A6486669C18205EEE1871F769F985EDB2FA92CDA79
            E79D2D5B346BD62CF7852F7CC16DBFFDF6B6CF910A3574E7F50B91FEBF129F41
            F8E0EB9C4FCA9D113EF872E08BDDE96BE56B095FB5F952C74A8F3F7DAA6E7973
            29DE502BF27DF0C107EEE38F3F76B7DF7EBB19A4B7DF7EBB540669975D763143
            74CD35D7B8891327DA7AA35EBD7A35F55CDDF1FF8D19A4DDC51853F0C157948F
            18810FBE303E62053EF8C2F852C74A748354A6F45D55F87C26E9D5575FB56CD2
            4F7FFA53B770E142F7EEBBEF663DE54E99234DA19B3B77AE1B3B76AC19257F3D
            8B668FBA72FD3A93FFFFC60ED22A7E06E16B6D3E62043EF8C2F88815F8E00BE3
            4B1D2BDD6690FCC2A898170BBEFAFAE8A38FDC860D1BDC830F3EE8EEBEFB6ED7
            D6D666EB9272D5881123DCD65B6FED6EB9E5163761C2842E658E625CBFF6EAEE
            CE5F153F83F0B5261F31021F7C617CC40A7CF085F1A58E15324815E2F31BC6AA
            ECF79A356BDCD2A54BDD030F3C6053F0729A72A7620CCA10CD9E3DDB8D1A35CA
            EDB3CF3E761D75AED9CC518CEBD75E8C8EC3075F181F31021F7C617CC40A7CF0
            85F1A58E150C5205F97C26E9673FFB99FBC10F7EE0DE79E71D334CB948A6A867
            CF9E6EDEBC796EDCB871B6FE483FC7109D3FF8E0DBFC7CC4087CF085F1112BF0
            C117C6973A56304815E4531649E5BFFFF0873FB8D5AB57BB975E7AC9DD79E79D
            669C526692B4CF91AE9932479A5A77C82187583649E6A8AB99A398D7CF8BCE1F
            7CF085F11123F0C117C647ACC0075F185FEA58C12055984F95EDB4A6E7A9A79E
            3253A2A976AB56AD8ACA5B447BECB1871DEFBDF75ED7AF5F3FDBF34825BD638A
            CE1F7CF06D7E3E62043EF8C2F88815F8E00BE34B1D2B18A40AF3E979347D4D6B
            929E78E2099B66A7BD92945DDA5C99245DA3810307DAFDBFFCCBBFB4E389279E
            68D5EBB6DC724B0C5224C698820FBEA27CC4087CF085F1112BF0C117C6973A56
            30482DC02743A48D6435D5EEA28B2E72FFF33FFFE356AC581195BB336DB1C516
            6EF4E8D176FF273FF9894DA5DB76DB6DED5896EB973A484318630A3EF88AF211
            23F0C117C647ACC0075F185FEA58C120B5009FD624C914A9E4B7F647D26B6853
            599DEFAE7D92648C348DAE77EFDEEEEB5FFFBA9D3BEFBCF3ECA8EC5199AE5FEA
            200D618C29F8E02BCA478CC0075F181FB1021F7C617CA9630583D4427C3E93A4
            297753A74E3583B46CD9B2A8FC5E9A3EB7DB6EBB59B6E8FEFBEFB773ED77702E
            CBF54B1DA4218C31051F7C45F98811F8E00BE32356E0832F8C2F75AC60905A88
            4F864895ECF41AF3E7CFB7AC92D62449EBD6AD8BF29ACA1CC914C90C4D9E3CD9
            367F9D3E7DBA3DA6FB65BC7EA983348431A6E083AF281F31021F7C617CC40A7C
            F085F1A58E150C520BF2C928696F2465938E3DF6583BA7F54931D4A74F1FB7CB
            2EBBB89D77DED9DD76DB6DC6A06A7565BE7EA983348431A6E083AF281F31021F
            7C617CC40A7CF085F1A58E150C520BF2F94C92CA7E5F7BEDB5764EA5B7755EA6
            49C7A252E64819A21D77DCD14D9A34C9F5EFDFDF0A4248ED334765BB7EA98334
            8431A6E083AF281F31021F7C617CC40A7CF085F1A58E150C528BF3E9F5A48913
            27DA1AA5E5CB97DBB1A834AD4E59A3B163C7BABFFDDBBFAD9B392ADBF54B1DA4
            218C31051F7C45F98811F8E00BE32356E0832F8C2F75AC60905A9C4F192369E6
            CC99668C162F5E6C99256598423249CA1C6933DA9D76DAC94D9830C1EDBAEBAE
            96395219EFCE324765BB7EA983348431A6E083AF281F31021F7C617CC40A7CF0
            85F1A58E95AC0D923AD9CA42E822C1D7BD7C3E9374CA29A758E9EF952B579A49
            6A247D98070F1EECBEF0852FB8ABAEBACA0C9336A7ADD2F5D39118810FBECEF9
            8811F8E00BE34BDDE92BC20A1F7C29F952C74AD606A96C6EB7CC7C2ADA20CD9A
            35CB2ADA3DFFFCF39649D27955BB6B2F95F156E668D0A0416EE4C8916EFCF8F1
            6EC68C19AE67CF9E0D334765BB7EA983348431A6E083AF281F31021F7C617CC4
            0A7CF085F1A58E150C127C1DEAD65B6FB58D65B587D1EAD5ABFFCFE3C3870FB7
            E974871D76983BFBECB3CD30851AA3B25DBFD4411AC21853F0C157948F18810F
            BE303E62053EF8C2F852C74A5483A4E751C621E6C56ABFB9287C9B874FFB23BD
            F1C61B6EE1C2856ECD9A35B61E69E3C68DF69C4A830E1B36CCCA791F74D0416E
            CA942985324765BB7E318334A7FF317CF0C5E22346E0832F8C8F58810FBE30BE
            D4B1D2A3ADAD2D9A41F295CB62CE6F5CBF7E7DD48B0F5F735AB56A954DBDDB73
            CF3D6DCD516E7C52775D3F297746F8E04BC927E5CE081F7C39F0C5ECF4B5FAB5
            84AFDA7CA963A5C7279DDEA806A94CE93BF8C2E50DD2DE7BEF6DEB8E72E393BA
            EBFA49B933C2075F4A3E297746F8E0CB812F76A7AF95AF257CD5E64B1D2B1824
            F8E06BC027E5CE081F7C29F9A4DC19E1832F07BED49DBE22ACF0C197922F75AC
            646D90FC9CC190FD78E083AFBBF8742446E083AF733E62043EF8C2F85277FA8A
            B0C2075F4ABED4B192B54192CAE476E1AB269F943B237CF0A5E4937267840FBE
            1CF85277FA8AB0C2075F4ABED4B18241820FBE067C52EE8CF0C197924FCA9D11
            3EF872E04BDDE92BC20A1F7C29F952C70A06093EF81AF049B933C2075F4A3E29
            7746F8E0CB812F75A7AF082B7CF0A5E44B1D2B1824F8E06BC027E5CE081F7C29
            F9A4DC19E1832F07BED49DBE22ACF0C197922F75AC6090E083AF019F943B237C
            F0A5E4937267840FBE1CF85277FA8AB0C2075F4ABED4B18241820FBE067C52EE
            8CF0C197924FCA9D113EF872E04BDDE92BC20A1F7C29F952C70A06093EF81AF0
            49B933C2075F4A3E297746F8E0CB812F75A7AF082B7CF0A5E44B1D2B1824F8E0
            6BC027E5CE081F7C29F9A4DC19E1832F07BED49DBE22ACF0C197922F75AC6090
            E083AF019F943B237CF0A5E4937267840FBE1CF85277FA8AB0C2075F4ABED4B1
            8241820FBE067C52EE8CF0C197924FCA9D113EF872E04BDDE92BC20A1F7C29F9
            52C70A06093EF81AF049B933C2075F4A3E297746F8E0CB812F75A7AF082B7CF0
            A5E44B1D2B1824F8E06BC027E5CE081F7C29F9A4DC19E1832F07BED49DBE22AC
            F0C197922F75AC6090E083AF019F943B237CF0A5E4937267840FBE1CF85277FA
            8AB0C2075F4ABED4B112C520E9EFF5E2B9FE33E183AF2B7CFE357266840FBE94
            7CFE357266840FBE1CF86274FAB896F0B5025FEA582183041F7C0DF8A4DC19E1
            832F259F943B237CF0E5C0977A54BC082B7CF0A5E44B1D2B3DDADADAA21AA4BE
            7DFB46BD58EBD7AF8F7A81E083AF289F943B237CF0A5E4937267840FBE1CF862
            77FA5AF95AC2576DBED4B1D2E34F9FAA5BDE5C8A37041F7CB1F96206697731C6
            147CF015E52346E0832F8C8F58810FBE30BED4B112DD2095297D071F7C217CB1
            83B415AF217CD5E62346E0832F8C8F58810FBE30BED4B1D26D06C92F8C8A79B1
            E0832F055F7705692B5D43F8AACD478CC0075F181FB1021F7C617CA963850C12
            7CF035E04B3D8A11C21853F0C157948F18810FBE303E62053EF8C2F852C70A06
            093EF81AF0A50ED210C698820FBEA27CC4087CF085F1112BF0C117C6973A5630
            48F0C1D7802F75908630C6147CF015E52346E0832F8C8F58810FBE30BED4B182
            41820FBE067CA983348431A6E083AF281F31021F7C617CC40A7CF085F1A58E15
            0C127CF035E04B1DA4218C31051F7C45F98811F8E00BE32356E0832F8C2F75AC
            6090E083AF015FEA200D618C29F8E02BCA478CC0075F181FB1021F7C617CA963
            0583041F7C0DF852076908634CC1075F513E62043EF8C2F88815F8E00BE34B1D
            2B1824F8E06BC0973A484318630A3EF88AF21123F0C117C647ACC0075F185FEA
            58C120C1075F03BED4411AC21853F0C157948F18810FBE303E62053EF8C2F852
            C70A06093EF81AF0A50ED210C698820FBEA27CC4087CF085F1112BF0C117C697
            3A563048F0C1D7802F75908630C6147CF015E52346E0832F8C8F58810FBE30BE
            D4B18241820FBE067CA983348431A6E083AF281F31021F7C617CC40A7CF085F1
            A58E150C127CF035E04B1DA4218C31051F7C45F98811F8E00BE32356E0832F8C
            2F75AC646D90FEECCFFECC6DB7DD767691E0832F159F8EC4087CF075CE478CC0
            075F185FEA4E5F1156F8E04BC9973A56B236486573BBF055932F75908630C614
            7CF015E52346E0832F8C8F58810FBE30BED4B18241820FBE067CA983348431A6
            E083AF281F31021F7C617CC40A7CF085F1A58E95A80649CFF3CE3BEF44BD587D
            FBF68D7671E083AF19BE9841DAAAD710BE6AF31123F0C117C647ACC0075F185F
            EA58E9D1D6D616CD20E9CDC49EDFB87EFDFAA8171F3EF88AF249B933C2075F4A
            3E297746F8E0CB812F66A7AFD5AF257CD5E64B1D2B3DD6AD5B17D52095297D07
            1F7C217C52EE8CF0C197924FCA9D113EF872E08BDDE96BE56B095FB5F952C70A
            06093EF81AF049B933C2075F4A3E297746F8E0CB812F75A7AF082B7CF0A5E44B
            1D2B591B243F67F08F7FFC237CF025E3D39118810FBECEF98811F8E00BE34BDD
            E92BC20A1F7C29F952C74AD606492A93DB85AF9A7C52EE8CF0C197924FCA9D11
            3EF872E04BDDE92BC20A1F7C29F952C70A06093EF81AF049B933C2075F4A3E29
            7746F8E0CB812F75A7AF082B7CF0A5E44B1D2B1824F8E06BC027E5CE081F7C29
            F9A4DC19E1832F07BED49DBE22ACF0C197922F75AC6090E083AF019F943B237C
            F0A5E4937267840FBE1CF85277FA8AB0C2075F4ABED4B18241820FBE067C52EE
            8CF0C197924FCA9D113EF872E04BDDE92BC20A1F7C29F952C70A06093EF81AF0
            49B933C2075F4A3E297746F8E0CB812F75A7AF082B7CF0A5E44B1D2B1824F8E0
            6BC027E5CE081F7C29F9A4DC19E1832F07BED49DBE22ACF0C197922F75AC6090
            E083AF019F943B237CF0A5E4937267840FBE1CF85277FA8AB0C2075F4ABED4B1
            8241820FBE067C52EE8CF0C197924FCA9D113EF872E04BDDE92BC20A1F7C29F9
            52C70A06093EF81AF049B933C2075F4A3E297746F8E0CB812F75A7AF082B7CF0
            A5E44B1D2B1824F8E06BC027E5CE081F7C29F9A4DC19E1832F07BED49DBE22AC
            F0C197922F75AC6090E083AF019F943B237CF0A5E4937267840FBE1CF85277FA
            8AB0C2075F4ABED4B18241820FBE067C52EE8CF0C197924FCA9D113EF872E04B
            DDE92BC20A1F7C29F952C74A1483A4BFD78BE7FACF840FBEAEF0F9D7C899113E
            F852F2F9D7C899113EF872E08BD1E9E35AC2D70A7CA963850C127CF035E09372
            67840FBE947C52EE8CF0C197035FEA51F122ACF0C197922F75ACF4686B6B8B6A
            90FAF6ED1BF562AD5FBF3EEA05820FBEA27C52EE8CF0C197924FCA9D113EF872
            E08BDDE96BE56B095FB5F952C74A8F3F7DAA6E797329DE107CF0C5E68B19A4DD
            C51853F0C157948F18810FBE303E62053EF8C2F852C74A748354A6F41D7CF085
            F0C50ED256BC86F0559B8F18810FBE303E62053EF8C2F852C74AB71924BF302A
            E6C5820FBE147CDD15A4AD740DE1AB361F31021F7C617CC40A7CF085F1A58E15
            3248F0C1D7802FF5284608634CC1075F513E62043EF8C2F88815F8E00BE34B1D
            2B1824F8E06BC0973A484318630A3EF88AF21123F0C117C647ACC0075F185FEA
            58C120C1075F03BED4411AC21853F0C157948F18810FBE303E62053EF8C2F852
            C70A06093EF81AF0A50ED210C698820FBEA27CC4087CF085F1112BF0C117C697
            3A563048F0C1D7802F75908630C6147CF015E52346E0832F8C8F58810FBE30BE
            D4B18241820FBE067CA983348431A6E083AF281F31021F7C617CC40A7CF085F1
            A58E150C127CF035E04B1DA4218C31051F7C45F98811F8E00BE32356E0832F8C
            2F75AC6090E083AF015FEA200D618C29F8E02BCA478CC0075F181FB1021F7C61
            7CA9630583041F7C0DF852076908634CC1075F513E62043EF8C2F88815F8E00B
            E34B1D2B1824F8E06BC0973A484318630A3EF88AF21123F0C117C647ACC0075F
            185FEA58C120C1075F03BED4411AC21853F0C157948F18810FBE303E62053EF8
            C2F852C70A06093EF81AF0A50ED210C698820FBEA27CC4087CF085F1112BF0C1
            17C6973A563048F0C1D7802F75908630C6147CF015E52346E0832F8C8F58810F
            BE30BED4B1D2E38F7FFC63BC57FF446D6D6D319FCEF5EBD72FEAF3C1075F4ABE
            3230C2075F4ABE3230C2075F4ABE32B1C2075F4ABEAEB06290E0836F33F29581
            113EF852F29581113EF852F29589153EF852F27585B547D4F9754D003452ABFD
            33E1AB365F1918E1832F255F1918E1832F255F9958E1832F255F5758FF1F8968
            1E6BEAC14A4C0000000049454E44AE426082}
          Stretch = True
          Visible = False
          OnClick = imNewHideClick
        end
        object Label26: TLabel
          Left = 6
          Top = 9
          Width = 86
          Height = 15
          HelpContext = 1064117
          Alignment = taRightJustify
          Caption = 'New Password'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object bnSubmit: TDNMSpeedButton
          Left = 258
          Top = 5
          Width = 67
          Height = 24
          Hint = 'Click this button to verify if Magento is enabled'
          HelpContext = 1064075
          Caption = 'Submit'
          DisableTransparent = False
          HotTrackFont.Charset = DEFAULT_CHARSET
          HotTrackFont.Color = clWindowText
          HotTrackFont.Height = -11
          HotTrackFont.Name = 'MS Sans Serif'
          HotTrackFont.Style = []
          Style = bsModern
          TabOrder = 0
          AutoDisableParentOnclick = True
          OnClick = bnSubmitClick
        end
        object edNewPassword: TEdit
          Left = 98
          Top = 5
          Width = 121
          Height = 21
          TabOrder = 1
          Text = 'edOLdPassword'
          OnChange = edNewPasswordChange
        end
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 577
    Top = 39
  end
  inherited tmrdelay: TTimer
    Left = 577
    Top = 0
  end
  inherited popSpelling: TPopupMenu
    Left = 815
    Top = 71
  end
  inherited tmrdelayMsg: TTimer
    Left = 632
    Top = 80
  end
  object dsPrefs: TDataSourcePrefs
    Connection = MyConnection
    FieldDefs = <>
    FieldNames.Strings = (
      'AllowShipmentsFromSalesOrder'
      'CoreEDIPassword'
      'CoreEDIServiceHost'
      'CoreEDIServicePassword'
      'CoreEDIServicePort'
      'CoreEDIUSerName'
      'CyTrackIntegrationEnabled'
      'EnableAusEparcel'
      'EnableWalmart'
      'EnableWooCommerce'
      'ErpApiEnabled'
      'ErpApiPort'
      'GoogleAnalyticsEnabled'
      'GoogleAnalyticsLoggingLevel'
      'MagentoEnabled'
      'NonERPClone_Password'
      'NonERPClone_User'
      'NonERPCloneAfterRestart'
      'RememberLastReconDeposit'
      'ShowMagentoOnMainMenu'
      'ShowWalmartonMainmenubyDefault'
      'ShowWooCommerceonMainmenubyDefault'
      'SupplierforautoPostingGoogle'
      'UKGatewayIsLive'
      'UseElectronicVAT'
      'UseTNTFreight'
      'VATAuthentication'
      'VATCurrencyCode'
      'VATKeys'
      'VATKeyType'
      'VATMaxAttemptsPerSession'
      'VATSenderID'
      'VATVendorID'
      'WALMART_AutocheckforOrdersinList'
      'WALMART_AutoUpdateProductQty'
      'WALMART_ChannelType'
      'WALMART_ConsumerId'
      'Walmart_EnableInvFeed'
      'WALMART_IgnoreTaxonSale'
      'WALMART_PrivateKey'
      'WALMART_ProductNameField'
      'Walmartcustomer'
      'WALMARTOrderSilentProcessShipment'
      'YodleeEnabled')
    Left = 615
    Top = 12
  end
  object MyConnection: TERPConnection
    Database = 'aus_sample_company'
    Port = 3309
    Options.UseUnicode = True
    Options.KeepDesignConnected = False
    PoolingOptions.MinPoolSize = 1
    PoolingOptions.ConnectionLifetime = 180
    Pooling = True
    Username = 'P_One'
    Password = '1w$p&LD07'
    Connected = True
    LoginPrompt = False
    Left = 777
    Top = 86
  end
  object qryGaAccounts: TERPQuery
    SQL.Strings = (
      'select * from tblTGaAccount order by AccountName')
    BeforeOpen = qryGaAccountsBeforeOpen
    AfterInsert = qryGaAccountsAfterInsert
    AfterScroll = qryGaAccountsAfterScroll
    Left = 777
    Top = 203
    object qryGaAccountsAccountName: TWideStringField
      DisplayLabel = 'Account Name'
      DisplayWidth = 20
      FieldName = 'AccountName'
      Origin = 'tbltgaaccount.AccountName'
      Size = 255
    end
    object qryGaAccountsEmailAddress: TWideStringField
      DisplayLabel = 'Email Address'
      DisplayWidth = 21
      FieldName = 'EmailAddress'
      Origin = 'tbltgaaccount.EmailAddress'
      Size = 255
    end
    object qryGaAccountsERPAccountName: TWideStringField
      DisplayLabel = 'ERP Account Name'
      DisplayWidth = 20
      FieldName = 'ERPAccountName'
      Origin = 'tbltgaaccount.ERPAccountName'
      Size = 255
    end
    object qryGaAccountsActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      Origin = 'tbltgaaccount.Active'
      FixedChar = True
      Size = 1
    end
    object qryGaAccountsPassword: TWideStringField
      DisplayWidth = 10
      FieldName = 'Password'
      Origin = 'tbltgaaccount.Password'
      Visible = False
      Size = 50
    end
    object qryGaAccountsUId: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 10
      FieldName = 'UId'
      Origin = 'tbltgaaccount.UId'
      Visible = False
    end
    object qryGaAccountsERPAccountID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ERPAccountID'
      Origin = 'tbltgaaccount.ERPAccountID'
      Visible = False
    end
    object qryGaAccountsAccountId: TWideStringField
      DisplayWidth = 50
      FieldName = 'AccountId'
      Origin = 'tbltgaaccount.AccountId'
      Visible = False
      Size = 50
    end
    object qryGaAccountsAuth: TWideMemoField
      DisplayWidth = 10
      FieldName = 'Auth'
      Origin = 'tbltgaaccount.Auth'
      Visible = False
      BlobType = ftWideMemo
    end
    object qryGaAccountsProfiles: TWideStringField
      DisplayWidth = 50
      FieldName = 'Profiles'
      Origin = 'tbltgaaccount.Profiles'
      Visible = False
      Size = 50
    end
  end
  object dsGaAccounts: TDataSource
    DataSet = qryGaAccounts
    Left = 815
    Top = 122
  end
  object qryProfiles: TERPQuery
    SQL.Strings = (
      
        'select * from tblTGaProfile where Ref_TGaAccount = :GaAccountUId' +
        ' order by Title')
    BeforeOpen = qryProfilesBeforeOpen
    AfterPost = qryProfilesAfterPost
    AfterScroll = qryProfilesAfterScroll
    Left = 969
    Top = 250
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'GaAccountUId'
      end>
    object qryProfilesTitle: TWideStringField
      DisplayWidth = 39
      FieldName = 'Title'
      Size = 255
    end
    object qryProfilesTimeZone: TWideStringField
      DisplayLabel = 'Time Zone'
      DisplayWidth = 22
      FieldName = 'TimeZone'
      Size = 100
    end
    object qryProfilesActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object qryProfilesTableId: TWideStringField
      DisplayLabel = 'Table Id'
      DisplayWidth = 20
      FieldName = 'TableId'
      Visible = False
      Size = 50
    end
    object qryProfilesUId: TIntegerField
      DisplayWidth = 10
      FieldName = 'UId'
      Visible = False
    end
    object qryProfilesRef_TGAAccount: TIntegerField
      DisplayWidth = 10
      FieldName = 'Ref_TGAAccount'
      Visible = False
    end
    object qryProfilesProfileId: TWideStringField
      DisplayWidth = 50
      FieldName = 'ProfileId'
      Visible = False
      Size = 50
    end
    object qryProfilesWebPropertyId: TWideStringField
      DisplayWidth = 50
      FieldName = 'WebPropertyId'
      Visible = False
      Size = 50
    end
    object qryProfilesCurrency: TWideStringField
      DisplayWidth = 50
      FieldName = 'Currency'
      Visible = False
      Size = 50
    end
  end
  object dsGaProfiles: TDataSource
    DataSet = qryProfiles
    Left = 815
    Top = 173
  end
  object QrygaProfilesource: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select * from tbltga_erp_source where ga_ProfileId= :ga_ProfileI' +
        'd')
    BeforeOpen = QrygaProfilesourceBeforeOpen
    AfterInsert = QrygaProfilesourceAfterInsert
    BeforePost = QrygaProfilesourceBeforePost
    AfterPost = QrygaProfilesourceAfterPost
    Left = 977
    Top = 289
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ga_ProfileId'
      end>
    object QrygaProfilesourceSourcename: TStringField
      DisplayWidth = 45
      FieldKind = fkLookup
      FieldName = 'Sourcename'
      LookupDataSet = Qrysource
      LookupKeyFields = 'MedtypeID'
      LookupResultField = 'mediatype'
      KeyFields = 'SourceID'
      Size = 100
      Lookup = True
    end
    object QrygaProfilesourceActive: TWideStringField
      DisplayWidth = 1
      FieldName = 'Active'
      FixedChar = True
      Size = 1
    end
    object QrygaProfilesourceisDefaultSource: TWideStringField
      DisplayLabel = 'Is Default Source?'
      DisplayWidth = 1
      FieldName = 'isDefaultSource'
      OnChange = QrygaProfilesourceisDefaultSourceChange
      FixedChar = True
      Size = 1
    end
    object QrygaProfilesourceUID: TIntegerField
      DisplayWidth = 10
      FieldName = 'UID'
      Visible = False
    end
    object QrygaProfilesourceSourceID: TIntegerField
      DisplayWidth = 10
      FieldName = 'SourceID'
      Visible = False
    end
    object QrygaProfilesourceGlobalref: TWideStringField
      DisplayWidth = 255
      FieldName = 'Globalref'
      Visible = False
      Size = 255
    end
    object QrygaProfilesourcega_ProfileId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ga_ProfileId'
      Visible = False
    end
    object QrygaProfilesourcemsTimeStamp: TDateTimeField
      DisplayWidth = 18
      FieldName = 'msTimeStamp'
      Visible = False
    end
    object QrygaProfilesourcemsUpdateSiteCode: TWideStringField
      DisplayWidth = 3
      FieldName = 'msUpdateSiteCode'
      Visible = False
      Size = 3
    end
  end
  object dsgaProfilesource: TDataSource
    DataSet = QrygaProfilesource
    Left = 967
    Top = 208
  end
  object Qrysource: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select MedtypeID, mediatype from tblsource where ShowinGoogle='#39'T' +
        #39)
    BeforeOpen = QrysourceBeforeOpen
    Left = 921
    Top = 200
    object Qrysourcemediatype: TWideStringField
      DisplayWidth = 50
      FieldName = 'mediatype'
      Size = 50
    end
    object QrysourceMedtypeID: TIntegerField
      FieldName = 'MedtypeID'
      Visible = False
    end
  end
  object qrySupplier: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select ClientId, company from tblclients where Supplier ="T" ord' +
        'er by company')
    Left = 761
    Top = 133
    object qrySuppliercompany: TWideStringField
      DisplayWidth = 30
      FieldName = 'company'
      Size = 160
    end
    object qrySupplierClientId: TIntegerField
      DisplayWidth = 10
      FieldName = 'ClientId'
      Visible = False
    end
  end
  object QryAccount: TERPQuery
    SQL.Strings = (
      'SELECT'
      'tblChartofAccounts.AccountName,'
      'tblChartofAccounts.AccountID'
      'FROM tblChartofAccounts'
      
        'LEFT JOIN tblacctypedesc ON tblacctypedesc.AccType = tblChartofA' +
        'ccounts.AccountType'
      'WHERE tblChartofAccounts.Active = '#39'T'#39' and IsHeader = '#39'F'#39
      'ORDER BY AccountNumber')
    Options.LongStrings = False
    Left = 713
    Top = 172
    object QryAccountAccountName: TWideStringField
      DisplayLabel = 'Account Name'
      DisplayWidth = 25
      FieldName = 'AccountName'
      Origin = 'tblChartofAccounts.AccountName'
      FixedChar = True
      Size = 50
    end
    object QryAccountAccountID: TIntegerField
      DisplayWidth = 10
      FieldName = 'AccountID'
      Origin = 'tblChartofAccounts.AccountID'
      Visible = False
    end
  end
  object qryCustomers: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'select company from tblclients where active ="T" and customer ="' +
        'T" order by Company')
    BeforeOpen = qryGaAccountsBeforeOpen
    AfterInsert = qryGaAccountsAfterInsert
    AfterScroll = qryGaAccountsAfterScroll
    Left = 977
    Top = 347
    object qryCustomerscompany: TWideStringField
      DisplayWidth = 50
      FieldName = 'company'
      Size = 160
    end
  end
  object MyDump1: TMyDump
    Connection = MyConnection
    Objects = [doTables, doData]
    Left = 496
    Top = 152
  end
  object ExtConnection: TMyConnection
    Options.Compress = True
    Username = 'root'
    Left = 824
    Top = 280
  end
  object wsClient: TsgcWebSocketClient
    Port = 80
    ConnectTimeout = 0
    ReadTimeout = -1
    TLS = True
    Proxy.Enabled = False
    Proxy.Port = 8080
    Proxy.ProxyType = pxyHTTP
    HeartBeat.Enabled = False
    HeartBeat.Interval = 300
    HeartBeat.Timeout = 0
    IPVersion = Id_IPv4
    OnException = wsClientException
    Authentication.Enabled = False
    Authentication.URL.Enabled = True
    Authentication.Session.Enabled = False
    Authentication.Basic.Enabled = True
    Authentication.Token.Enabled = False
    Authentication.Token.AuthName = 'Bearer'
    Extensions.DeflateFrame.Enabled = False
    Extensions.DeflateFrame.WindowBits = 15
    Extensions.PerMessage_Deflate.Enabled = False
    Extensions.PerMessage_Deflate.ClientMaxWindowBits = 15
    Extensions.PerMessage_Deflate.ClientNoContextTakeOver = False
    Extensions.PerMessage_Deflate.MemLevel = 9
    Extensions.PerMessage_Deflate.ServerMaxWindowBits = 15
    Extensions.PerMessage_Deflate.ServerNoContextTakeOver = False
    Options.CleanDisconnect = False
    Options.FragmentedMessages = frgOnlyBuffer
    Options.Parameters = '/'
    Options.RaiseDisconnectExceptions = True
    Options.ValidateUTF8 = False
    Specifications.Drafts.Hixie76 = False
    Specifications.RFC6455 = True
    NotifyEvents = neAsynchronous
    LogFile.Enabled = False
    QueueOptions.Binary.Level = qmNone
    QueueOptions.Ping.Level = qmNone
    QueueOptions.Text.Level = qmNone
    WatchDog.Attempts = 0
    WatchDog.Enabled = False
    WatchDog.Interval = 10
    Throttle.BitsPerSec = 0
    Throttle.Enabled = False
    LoadBalancer.Enabled = False
    LoadBalancer.Port = 0
    TLSOptions.VerifyCertificate = False
    TLSOptions.Version = tlsUndefined
    TLSOptions.IOHandler = iohOpenSSL
    Left = 584
    Top = 96
  end
  object dsYodlee: TDataSource
    DataSet = kbmYodlee
    Left = 559
    Top = 162
  end
  object kbmYodlee: TkbmMemTable
    Active = True
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'TrueERPAccountNumber'
        DataType = ftString
        Size = 50
      end
      item
        Name = 'TrueERPAccountName'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'YodleeAccountId'
        DataType = ftInteger
      end
      item
        Name = 'YodleeProviderName'
        DataType = ftString
        Size = 300
      end
      item
        Name = 'TrueERPAccountId'
        DataType = ftInteger
      end
      item
        Name = 'YodleeProviderId'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'kbmYodleeIndex1'
        Fields = 'TrueERPAccountID'
        Options = [ixPrimary, ixUnique]
      end>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 584
    Top = 168
    object kbmYodleeTrueERPAccountNumber: TStringField
      DisplayLabel = 'ERP~Account Number'
      DisplayWidth = 13
      FieldName = 'TrueERPAccountNumber'
      Size = 50
    end
    object kbmYodleeTrueERPAccountName: TStringField
      DisplayLabel = 'ERP~Account Name'
      DisplayWidth = 22
      FieldName = 'TrueERPAccountName'
      Size = 200
    end
    object kbmYodleeYodleeAccountId: TIntegerField
      DisplayLabel = 'Yodlee~Account Id'
      DisplayWidth = 12
      FieldName = 'YodleeAccountId'
    end
    object kbmYodleeYodleeProviderName: TStringField
      DisplayLabel = 'Yodlee~Provider Name'
      DisplayWidth = 21
      FieldName = 'YodleeProviderName'
      Size = 300
    end
    object kbmYodleeTrueERPAccountId: TIntegerField
      DisplayLabel = 'ERP~ Account Id'
      DisplayWidth = 5
      FieldName = 'TrueERPAccountId'
      Visible = False
    end
    object kbmYodleeYodleeProviderId: TIntegerField
      DisplayLabel = 'Yodlee~Provider Id'
      DisplayWidth = 5
      FieldName = 'YodleeProviderId'
      Visible = False
    end
  end
  object qryChartOfAccounts: TERPQuery
    SQL.Strings = (
      'SELECT'
      'tblChartofAccounts.AccountName,'
      'tblChartofAccounts.AccountID,'
      'tblChartofAccounts.AccountNumber'
      'FROM tblChartofAccounts'
      
        'WHERE tblChartofAccounts.Active = '#39'T'#39' and IsHeader = '#39'F'#39' and Acc' +
        'ountType = '#39'Bank'#39
      'ORDER BY AccountNumber')
    Options.LongStrings = False
    Left = 865
    Top = 420
    object qryChartOfAccountsAccountName: TWideStringField
      FieldName = 'AccountName'
      Size = 50
    end
    object qryChartOfAccountsAccountID: TIntegerField
      FieldName = 'AccountID'
    end
    object qryChartOfAccountsAccountNumber: TWideStringField
      FieldName = 'AccountNumber'
      Size = 50
    end
  end
  object IdIPMCastClient1: TIdIPMCastClient
    Bindings = <>
    DefaultPort = 0
    MulticastGroup = '224.0.0.1'
    Left = 64
    Top = 16
  end
  object kbmYodleeAccounts: TkbmMemTable
    DesignActivation = True
    AttachedAutoRefresh = True
    AttachMaxCount = 1
    FieldDefs = <
      item
        Name = 'YodleeProviderId'
        DataType = ftInteger
      end
      item
        Name = 'YodleeProviderName'
        DataType = ftString
        Size = 300
      end>
    IndexDefs = <>
    SortOptions = []
    PersistentBackup = False
    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]
    LoadedCompletely = False
    SavedCompletely = False
    FilterOptions = []
    Version = '6.51.00 Standard Edition'
    LanguageID = 0
    SortID = 0
    SubLanguageID = 1
    LocaleID = 1024
    Left = 568
    Top = 136
    object kbmYodleeAccountsYodleeAccountID: TIntegerField
      DisplayLabel = 'Yodlee Account ID'
      DisplayWidth = 15
      FieldName = 'YodleeAccountID'
    end
    object StringField3: TStringField
      DisplayLabel = 'Yodlee Provider Name'
      DisplayWidth = 30
      FieldName = 'YodleeProviderName'
      Size = 300
    end
    object IntegerField3: TIntegerField
      DisplayLabel = 'Yodlee Provider ID'
      DisplayWidth = 5
      FieldName = 'YodleeProviderId'
      Visible = False
    end
  end
end
