inherited IntegrationPrefsGUI: TIntegrationPrefsGUI
  Left = 4201
  Top = 129
  HelpContext = 1064002
  Caption = 'Credentials'
  ClientHeight = 741
  ClientWidth = 1062
  ExplicitTop = -340
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
    VertScrollBar.Position = 2804
    ExplicitWidth = 1062
    ExplicitHeight = 741
    object pnlWooCommerceOptions: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 666
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
      Top = 83
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
      Top = -298
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
      Top = 214
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
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
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
      Top = -181
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
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
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
      Top = -572
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
      Top = -1455
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
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
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
      Top = -1110
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
      Top = -2804
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
      Top = -382
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
      Top = -683
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
      Top = -832
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
      Top = -1636
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
      Top = -2182
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
      Top = -1931
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
      Top = -1736
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
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
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
      Top = -2299
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
      Top = 463
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
      Top = -2427
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
      Top = -2604
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
      Top = 369
      Width = 1043
      Height = 94
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
        Height = 79
        HelpContext = 1064116
        Shape = bsFrame
      end
      object Label49: TLabel
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
        Left = 227
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
        Left = 9
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
        Top = 61
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
        Left = 140
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
    Left = 697
    Top = 428
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
