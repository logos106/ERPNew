object IntegrationPrefsWalmartGUI: TIntegrationPrefsWalmartGUI
  Left = 147
  Top = 149
  Caption = 'IntegrationPrefsWalmartGUI'
  ClientHeight = 483
  ClientWidth = 623
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    623
    483)
  PixelsPerInch = 96
  TextHeight = 13
  object pnlWalmartConfig: TDNMPanel
    Left = 1
    Top = 1
    Width = 545
    Height = 477
    HelpContext = 1686003
    Anchors = []
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      545
      477)
    object Bevel1: TBevel
      Left = 6
      Top = 6
      Width = 533
      Height = 464
      HelpContext = 1686004
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
      ExplicitHeight = 468
    end
    object Bevel4: TBevel
      AlignWithMargins = True
      Left = 22
      Top = 248
      Width = 517
      Height = 85
      HelpContext = 1686004
      Shape = bsFrame
    end
    object Bevel3: TBevel
      AlignWithMargins = True
      Left = 22
      Top = 133
      Width = 517
      Height = 85
      HelpContext = 1686004
      Shape = bsFrame
    end
    object lblTitle: TLabel
      Left = 14
      Top = 14
      Width = 49
      Height = 15
      HelpContext = 1686005
      Caption = 'Walmart'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label7: TLabel
      Left = 101
      Top = 186
      Width = 73
      Height = 15
      HelpContext = 1686006
      Alignment = taRightJustify
      Caption = 'Client Secret'
      Transparent = True
    end
    object Label8: TLabel
      Left = 128
      Top = 148
      Width = 46
      Height = 15
      HelpContext = 1686007
      Alignment = taRightJustify
      Caption = 'Client ID'
      Transparent = True
    end
    object Label5: TLabel
      Left = 128
      Top = 264
      Width = 46
      Height = 15
      HelpContext = 1686007
      Alignment = taRightJustify
      Caption = 'Client ID'
      Transparent = True
    end
    object Label6: TLabel
      Left = 101
      Top = 302
      Width = 73
      Height = 15
      HelpContext = 1686006
      Alignment = taRightJustify
      Caption = 'Client Secret'
      Transparent = True
    end
    object Label9: TLabel
      Left = 22
      Top = 117
      Width = 92
      Height = 15
      HelpContext = 1686007
      Alignment = taRightJustify
      Caption = 'Sandbox Details'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label10: TLabel
      Left = 22
      Top = 233
      Width = 104
      Height = 15
      HelpContext = 1686007
      Alignment = taRightJustify
      Caption = 'Production Details'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Label3: TLabel
      Left = 22
      Top = 356
      Width = 101
      Height = 15
      HelpContext = 1686007
      Alignment = taRightJustify
      Caption = 'Account To Synch'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object Bevel5: TBevel
      AlignWithMargins = True
      Left = 184
      Top = 340
      Width = 325
      Height = 44
      HelpContext = 1686004
      Shape = bsFrame
    end
    object Label11: TLabel
      Left = 23
      Top = 428
      Width = 120
      Height = 15
      HelpContext = 1686010
      Alignment = taRightJustify
      Caption = 'Orders Synched Until'
      Transparent = True
    end
    object optsynchAccount: TwwRadioGroup
      Left = 203
      Top = 341
      Width = 287
      Height = 34
      DisableThemes = False
      Columns = 2
      Items.Strings = (
        '  Sandbox'
        '  Production')
      TabOrder = 5
      Values.Strings = (
        'S'
        'P')
      OnClick = optsynchAccountClick
    end
    object edtSandBoxclientSecret: TEdit
      Left = 184
      Top = 182
      Width = 325
      Height = 23
      HelpContext = 1686011
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 3
      OnChange = edtSandBoxclientSecretChange
    end
    object edtSandBoxclientID: TEdit
      Left = 184
      Top = 144
      Width = 325
      Height = 23
      HelpContext = 1686012
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnChange = edtSandBoxclientIDChange
    end
    object chkEnableWalmart: TwwCheckBox
      Left = 81
      Top = 82
      Width = 118
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Enable Walmart'
      TabOrder = 0
      OnClick = chkEnableWalmartClick
    end
    object chkShowWalmartOnMainMenu: TwwCheckBox
      Left = 239
      Top = 82
      Width = 270
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Show Walmart on Main Menu by Default'
      TabOrder = 1
      OnClick = chkShowWalmartOnMainMenuClick
    end
    object chkAutosynchList: TwwCheckBox
      Left = 48
      Top = 395
      Width = 148
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Auto Synch From List'
      TabOrder = 4
      OnClick = chkAutosynchListClick
    end
    object edtProductionClientID: TEdit
      Left = 184
      Top = 260
      Width = 325
      Height = 23
      HelpContext = 1686012
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnChange = edtProductionClientIDChange
    end
    object edtProductionclientSecret: TEdit
      Left = 184
      Top = 298
      Width = 325
      Height = 23
      HelpContext = 1686011
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 7
      OnChange = edtProductionclientSecretChange
    end
    object cmdExport: TDNMSpeedButton
      Left = 239
      Top = 45
      Width = 270
      Height = 27
      Hint = '"Export The List To An Excel Spreadsheet"'
      Caption = 'Open Walmart Page for Client Details'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 8
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = cmdExportClick
    end
    object dtOrdersSynchedUntil: TDateTimePicker
      Left = 181
      Top = 424
      Width = 100
      Height = 23
      Date = 43794.551431354160000000
      Time = 43794.551431354160000000
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 9
    end
  end
end
