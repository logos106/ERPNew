object IntegrationPrefsUPSGUI: TIntegrationPrefsUPSGUI
  Left = 0
  Top = 0
  Caption = 'IntegrationPrefsUPSGUI'
  ClientHeight = 639
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
  object pnlUPSConfig: TDNMPanel
    Left = 16
    Top = 28
    Width = 545
    Height = 365
    HelpContext = 1064048
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
      365)
    object Bevel8: TBevel
      Left = 3
      Top = 3
      Width = 539
      Height = 359
      HelpContext = 1064049
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
      ExplicitHeight = 335
    end
    object Label7: TLabel
      Left = 14
      Top = 14
      Width = 24
      Height = 15
      HelpContext = 1064050
      Caption = 'UPS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object lblUPSEnabled: TLabel
      Left = 24
      Top = 70
      Width = 100
      Height = 117
      AutoSize = False
      Caption = 'lblUPSEnabled'
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
      Height = 186
      Caption = 'UPS Account Settings'
      TabOrder = 2
      object Label10: TLabel
        Left = 11
        Top = 39
        Width = 41
        Height = 15
        HelpContext = 1064052
        Caption = 'User ID'
        Transparent = True
      end
      object Label11: TLabel
        Left = 11
        Top = 68
        Width = 58
        Height = 15
        HelpContext = 1064053
        Caption = 'Password'
        Transparent = True
      end
      object Label81: TLabel
        Left = 11
        Top = 97
        Width = 95
        Height = 15
        HelpContext = 1064054
        Caption = 'Account Number'
        Transparent = True
      end
      object Label1: TLabel
        Left = 11
        Top = 126
        Width = 67
        Height = 15
        HelpContext = 1064054
        Caption = 'Access Key'
        Transparent = True
      end
      object Label5: TLabel
        Left = 11
        Top = 155
        Width = 91
        Height = 15
        HelpContext = 1064054
        Caption = 'UPS Server URL'
        Transparent = True
      end
      object edtUserID: TEdit
        Left = 112
        Top = 36
        Width = 266
        Height = 23
        HelpContext = 1064056
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = edtChange
      end
      object edtPassword: TEdit
        Left = 112
        Top = 65
        Width = 266
        Height = 23
        HelpContext = 1064057
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 1
        OnChange = edtChange
      end
      object edtAccountNumber: TEdit
        Left = 112
        Top = 94
        Width = 266
        Height = 23
        HelpContext = 1064058
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnChange = edtChange
      end
      object edtAccessKey: TEdit
        Left = 112
        Top = 123
        Width = 266
        Height = 23
        HelpContext = 1064058
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnChange = edtChange
      end
      object edtServerURL: TEdit
        Left = 112
        Top = 152
        Width = 266
        Height = 23
        HelpContext = 1064058
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnChange = edtChange
      end
    end
    object chkUPSEnabled: TwwCheckBox
      Left = 19
      Top = 47
      Width = 105
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
      Caption = 'UPS Enabled'
      TabOrder = 0
      OnClick = chkUPSEnabledClick
    end
    object btnUPSTest: TDNMSpeedButton
      Left = 14
      Top = 281
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
      Visible = False
      WordWrap = True
      AutoDisableParentOnclick = True
      OnClick = btnUPSTestClick
    end
    object GroupBox2: TGroupBox
      Left = 130
      Top = 206
      Width = 394
      Height = 147
      Caption = 'Default Settings'
      TabOrder = 3
      object Label3: TLabel
        Left = 11
        Top = 29
        Width = 86
        Height = 15
        HelpContext = 1064054
        Caption = 'Default Service'
        Transparent = True
      end
      object Label4: TLabel
        Left = 11
        Top = 58
        Width = 93
        Height = 15
        HelpContext = 1064054
        Caption = 'Default Package'
        Transparent = True
      end
      object Label2: TLabel
        Left = 13
        Top = 87
        Width = 83
        Height = 15
        HelpContext = 1064054
        Caption = 'Default Weight'
        Transparent = True
      end
      object Label23: TLabel
        Left = 13
        Top = 116
        Width = 131
        Height = 15
        Caption = 'Default Size (L x W x H)'
      end
      object cboServiceType: TComboBox
        Left = 112
        Top = 26
        Width = 266
        Height = 23
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = cboServiceTypeChange
      end
      object cboPackage: TComboBox
        Left = 112
        Top = 55
        Width = 266
        Height = 23
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = cboPackageChange
      end
      object edtDefaultWeight: TAdvEdit
        Left = 112
        Top = 84
        Width = 81
        Height = 23
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
        OnChange = edtChange
        Version = '2.8.6.9'
      end
      object DefaultLength: TAdvEdit
        Left = 170
        Top = 113
        Width = 56
        Height = 23
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
      object DefaultWidth: TAdvEdit
        Left = 232
        Top = 113
        Width = 56
        Height = 23
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
      object DefaultHeight: TAdvEdit
        Left = 294
        Top = 113
        Width = 56
        Height = 23
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
    object btnTestAccount: TDNMSpeedButton
      Left = 8
      Top = 248
      Width = 116
      Height = 27
      HelpContext = 1064075
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
      Visible = False
      AutoDisableParentOnclick = True
    end
    object chkTestMode: TwwCheckBox
      Left = 14
      Top = 322
      Width = 97
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Caption = 'Test Mode'
      TabOrder = 5
      OnClick = chkTestModeClick
    end
  end
end
