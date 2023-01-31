object IntegrationPrefsUSPSGUI: TIntegrationPrefsUSPSGUI
  Left = 0
  Top = 0
  HelpContext = 1289002
  Caption = 'IntegrationPrefsUSPSGUI'
  ClientHeight = 988
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlUSPSConfig: TDNMPanel
    Left = 16
    Top = 28
    Width = 545
    Height = 941
    HelpContext = 1289003
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
      545
      941)
    object Bevel8: TBevel
      Left = 3
      Top = 5
      Width = 539
      Height = 934
      HelpContext = 1289004
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
      ExplicitHeight = 862
    end
    object Label7: TLabel
      Left = 14
      Top = 14
      Width = 32
      Height = 15
      HelpContext = 1289005
      Caption = 'USPS'
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
      Top = 48
      Width = 80
      Height = 15
      HelpContext = 1289006
      Caption = 'USPS Enabled'
      Transparent = True
    end
    object lblUSPSEnabled: TLabel
      Left = 14
      Top = 73
      Width = 110
      Height = 88
      HelpContext = 1289007
      AutoSize = False
      Caption = 'lblUSPSEnabled'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object GroupBox1: TGroupBox
      Left = 130
      Top = 14
      Width = 394
      Height = 147
      HelpContext = 1289008
      Caption = 'USPS Account Settings'
      TabOrder = 1
      object Label11: TLabel
        Left = 11
        Top = 32
        Width = 58
        Height = 15
        HelpContext = 1289009
        Caption = 'Password'
        Transparent = True
      end
      object Label81: TLabel
        Left = 11
        Top = 61
        Width = 41
        Height = 15
        HelpContext = 1289010
        Caption = 'User ID'
        Transparent = True
      end
      object Label5: TLabel
        Left = 11
        Top = 122
        Width = 99
        Height = 15
        HelpContext = 1289011
        Caption = 'USPS Server URL'
        Transparent = True
      end
      object Label15: TLabel
        Left = 11
        Top = 90
        Width = 95
        Height = 15
        HelpContext = 1289030
        Caption = 'Account Number'
        Transparent = True
      end
      object USPSPassword: TEdit
        Left = 118
        Top = 27
        Width = 265
        Height = 23
        HelpContext = 1289012
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 0
      end
      object USPSUserID: TEdit
        Left = 118
        Top = 56
        Width = 265
        Height = 23
        HelpContext = 1289013
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object ShipServer: TEdit
        Left = 118
        Top = 117
        Width = 265
        Height = 23
        HelpContext = 1289014
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object USPSAccountNumber: TEdit
        Left = 118
        Top = 85
        Width = 265
        Height = 23
        HelpContext = 1289031
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
      end
    end
    object USPSEnabled: TwwCheckBox
      Left = 19
      Top = 47
      Width = 16
      Height = 17
      HelpContext = 1289015
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
      OnClick = USPSEnabledClick
    end
    object GroupBox2: TGroupBox
      Left = 130
      Top = 167
      Width = 394
      Height = 146
      HelpContext = 1289017
      Caption = 'USPS Default Settings'
      TabOrder = 2
      object Label3: TLabel
        Left = 11
        Top = 29
        Width = 86
        Height = 15
        HelpContext = 1289018
        Caption = 'Default Service'
        Transparent = True
      end
      object Label4: TLabel
        Left = 11
        Top = 58
        Width = 93
        Height = 15
        HelpContext = 1289019
        Caption = 'Default Package'
        Transparent = True
      end
      object Label2: TLabel
        Left = 13
        Top = 87
        Width = 83
        Height = 15
        HelpContext = 1289020
        Caption = 'Default Weight'
        Transparent = True
      end
      object Label23: TLabel
        Left = 13
        Top = 116
        Width = 131
        Height = 15
        HelpContext = 1289032
        Caption = 'Default Size (L x W x H)'
      end
      object DefaultService: TComboBox
        Left = 118
        Top = 26
        Width = 265
        Height = 23
        HelpContext = 1289021
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = DefaultServiceChange
      end
      object DefaultPackage: TComboBox
        Left = 118
        Top = 55
        Width = 265
        Height = 23
        HelpContext = 1289022
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = DefaultPackageChange
      end
      object DefaultWeight: TAdvEdit
        Left = 118
        Top = 84
        Width = 81
        Height = 23
        HelpContext = 1289023
        EditType = etFloat
        Precision = 1
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
        TabOrder = 2
        Text = '0.0'
        Visible = True
        Version = '2.8.6.9'
      end
      object DefaultLength: TAdvEdit
        Left = 170
        Top = 113
        Width = 56
        Height = 23
        HelpContext = 1289033
        EditType = etFloat
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object DefaultHeight: TAdvEdit
        Left = 294
        Top = 113
        Width = 56
        Height = 23
        HelpContext = 1289034
        EditType = etFloat
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object DefaultWidth: TAdvEdit
        Left = 232
        Top = 113
        Width = 56
        Height = 23
        HelpContext = 1289035
        EditType = etFloat
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
    end
    object GroupBox3: TGroupBox
      Left = 130
      Top = 319
      Width = 394
      Height = 122
      HelpContext = 1289024
      Caption = 'Endicia Account Settings'
      TabOrder = 3
      object Label6: TLabel
        Left = 11
        Top = 32
        Width = 95
        Height = 15
        HelpContext = 1289025
        Caption = 'Account Number'
        Transparent = True
      end
      object Label9: TLabel
        Left = 11
        Top = 61
        Width = 58
        Height = 15
        HelpContext = 1289026
        Caption = 'Password'
        Transparent = True
      end
      object Label1: TLabel
        Left = 11
        Top = 88
        Width = 58
        Height = 15
        HelpContext = 1289036
        Caption = 'Test Mode'
        Transparent = True
      end
      object EndiciaAccountNumber: TEdit
        Left = 118
        Top = 27
        Width = 265
        Height = 23
        HelpContext = 1289027
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object EndiciaPassword: TEdit
        Left = 118
        Top = 56
        Width = 265
        Height = 23
        HelpContext = 1289028
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 1
      end
      object cboEndiciaTestMode: TComboBox
        Left = 118
        Top = 85
        Width = 265
        Height = 23
        HelpContext = 1289037
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 2
        Text = 'Live Requests to Production Server'
        OnChange = cboEndiciaTestModeChange
        Items.Strings = (
          'Live Requests to Production Server'
          'Test Requests to Sandbox Server'
          'Test Requests to Production Server')
      end
    end
    object btnTestAccount: TDNMSpeedButton
      Left = 8
      Top = 167
      Width = 116
      Height = 27
      HelpContext = 1289029
      Anchors = [akTop, akRight]
      Caption = 'Load Test Settings'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Style = bsModern
      TabOrder = 4
      AutoDisableParentOnclick = True
      OnClick = btnTestAccountClick
    end
    object btnUSPSTest: TDNMSpeedButton
      Left = 19
      Top = 477
      Width = 87
      Height = 27
      HelpContext = 1289016
      Anchors = [akTop, akRight]
      Caption = 'Test'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Style = bsModern
      TabOrder = 5
      Visible = False
      AutoDisableParentOnclick = True
      OnClick = btnUSPSTestClick
    end
    object cboTestType: TComboBox
      Left = 19
      Top = 448
      Width = 75
      Height = 23
      HelpContext = 1289038
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 6
      Text = 'Test USPS'
      Visible = False
      Items.Strings = (
        'Test USPS'
        'Test Endicia'
        'Test Stamps')
    end
    object GroupBox4: TGroupBox
      Left = 130
      Top = 599
      Width = 394
      Height = 178
      HelpContext = 1289039
      Caption = 'Stamps Account Settings'
      TabOrder = 7
      object Label10: TLabel
        Left = 11
        Top = 58
        Width = 95
        Height = 15
        HelpContext = 1289040
        Caption = 'Account Number'
        Transparent = True
      end
      object Label12: TLabel
        Left = 11
        Top = 145
        Width = 64
        Height = 15
        HelpContext = 1289041
        Caption = 'Server URL'
        Transparent = True
      end
      object Label13: TLabel
        Left = 11
        Top = 29
        Width = 41
        Height = 15
        HelpContext = 1289042
        Caption = 'User ID'
        Transparent = True
      end
      object Label14: TLabel
        Left = 11
        Top = 87
        Width = 58
        Height = 15
        HelpContext = 1289043
        Caption = 'Password'
        Transparent = True
      end
      object Label16: TLabel
        Left = 11
        Top = 114
        Width = 58
        Height = 15
        HelpContext = 1289044
        Caption = 'Test Mode'
        Transparent = True
      end
      object StampsAccountNumber: TEdit
        Left = 118
        Top = 53
        Width = 265
        Height = 23
        HelpContext = 1289045
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
      end
      object StampsServer: TEdit
        Left = 118
        Top = 140
        Width = 265
        Height = 23
        HelpContext = 1289046
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object StampsUserID: TEdit
        Left = 118
        Top = 24
        Width = 265
        Height = 23
        HelpContext = 1289047
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object StampsPassword: TEdit
        Left = 118
        Top = 82
        Width = 265
        Height = 23
        HelpContext = 1289048
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 3
      end
      object cboStampsTestMode: TComboBox
        Left = 118
        Top = 111
        Width = 265
        Height = 23
        HelpContext = 1289049
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 4
        Text = 'Live Requests to Production Server'
        OnChange = cboStampsTestModeChange
        Items.Strings = (
          'Live Requests to Production Server'
          'Test Requests to Sandbox Server')
      end
    end
    object GroupBox5: TGroupBox
      Left = 130
      Top = 447
      Width = 394
      Height = 146
      HelpContext = 1289050
      Caption = 'Endicia Default Settings'
      TabOrder = 8
      object Label17: TLabel
        Left = 11
        Top = 29
        Width = 86
        Height = 15
        HelpContext = 1289051
        Caption = 'Default Service'
        Transparent = True
      end
      object Label18: TLabel
        Left = 11
        Top = 58
        Width = 93
        Height = 15
        HelpContext = 1289052
        Caption = 'Default Package'
        Transparent = True
      end
      object Label19: TLabel
        Left = 13
        Top = 87
        Width = 83
        Height = 15
        HelpContext = 1289053
        Caption = 'Default Weight'
        Transparent = True
      end
      object Label24: TLabel
        Left = 13
        Top = 116
        Width = 131
        Height = 15
        HelpContext = 1289054
        Caption = 'Default Size (L x W x H)'
      end
      object EndiciaDefaultService: TComboBox
        Left = 118
        Top = 26
        Width = 265
        Height = 23
        HelpContext = 1289055
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = EndiciaDefaultServiceChange
      end
      object EndiciaDefaultPackage: TComboBox
        Left = 118
        Top = 55
        Width = 265
        Height = 23
        HelpContext = 1289056
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = EndiciaDefaultPackageChange
      end
      object EndiciaDefaultWeight: TAdvEdit
        Left = 118
        Top = 84
        Width = 81
        Height = 23
        HelpContext = 1289057
        EditType = etFloat
        Precision = 1
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
        TabOrder = 2
        Text = '0.0'
        Visible = True
        Version = '2.8.6.9'
      end
      object EndiciaDefaultLength: TAdvEdit
        Left = 170
        Top = 113
        Width = 56
        Height = 23
        HelpContext = 1289058
        EditType = etFloat
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object EndiciaDefaultWidth: TAdvEdit
        Left = 232
        Top = 113
        Width = 56
        Height = 23
        HelpContext = 1289059
        EditType = etFloat
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object EndiciaDefaultHeight: TAdvEdit
        Left = 294
        Top = 113
        Width = 56
        Height = 23
        HelpContext = 1289060
        EditType = etFloat
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
    end
    object GroupBox6: TGroupBox
      Left = 130
      Top = 783
      Width = 394
      Height = 146
      HelpContext = 1289061
      Caption = 'Stamps Default Settings'
      TabOrder = 9
      object Label20: TLabel
        Left = 11
        Top = 29
        Width = 86
        Height = 15
        HelpContext = 1289062
        Caption = 'Default Service'
        Transparent = True
      end
      object Label21: TLabel
        Left = 11
        Top = 58
        Width = 93
        Height = 15
        HelpContext = 1289063
        Caption = 'Default Package'
        Transparent = True
      end
      object Label22: TLabel
        Left = 13
        Top = 87
        Width = 83
        Height = 15
        HelpContext = 1289064
        Caption = 'Default Weight'
        Transparent = True
      end
      object Label25: TLabel
        Left = 13
        Top = 116
        Width = 131
        Height = 15
        HelpContext = 1289065
        Caption = 'Default Size (L x W x H)'
      end
      object StampsDefaultService: TComboBox
        Left = 118
        Top = 26
        Width = 265
        Height = 23
        HelpContext = 1289066
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = StampsDefaultServiceChange
      end
      object StampsDefaultPackage: TComboBox
        Left = 118
        Top = 55
        Width = 265
        Height = 23
        HelpContext = 1289067
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = StampsDefaultPackageChange
      end
      object StampsDefaultWeight: TAdvEdit
        Left = 118
        Top = 84
        Width = 81
        Height = 23
        HelpContext = 1289068
        EditType = etFloat
        Precision = 1
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
        TabOrder = 2
        Text = '0.0'
        Visible = True
        Version = '2.8.6.9'
      end
      object StampsDefaultLength: TAdvEdit
        Left = 170
        Top = 113
        Width = 56
        Height = 23
        HelpContext = 1289069
        EditType = etFloat
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object StampsDefaultWidth: TAdvEdit
        Left = 232
        Top = 113
        Width = 56
        Height = 23
        HelpContext = 1289070
        EditType = etFloat
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
      object StampsDefaultHeight: TAdvEdit
        Left = 294
        Top = 113
        Width = 56
        Height = 23
        HelpContext = 1289071
        EditType = etFloat
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        Lookup.Separator = ';'
        Color = clWindow
        Enabled = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        Text = '0'
        Visible = True
        Version = '2.8.6.9'
      end
    end
  end
end
