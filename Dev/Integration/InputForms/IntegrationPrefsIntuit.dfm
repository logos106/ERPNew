object ItegrationPrefsIntuitGUI: TItegrationPrefsIntuitGUI
  Left = 0
  Top = 0
  HelpContext = 1686002
  Caption = 'ItegrationPrefsIntuitGUI'
  ClientHeight = 509
  ClientWidth = 626
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object pnlIntuitConfig: TDNMPanel
    Left = 0
    Top = 0
    Width = 618
    Height = 353
    HelpContext = 1686003
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      618
      353)
    object Bevel8: TBevel
      Left = 6
      Top = 7
      Width = 606
      Height = 340
      HelpContext = 1686004
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
    end
    object lblTitle: TLabel
      Left = 14
      Top = 14
      Width = 108
      Height = 15
      HelpContext = 1686005
      Caption = 'Intuit (QuickBooks)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label11: TLabel
      Left = 47
      Top = 109
      Width = 126
      Height = 15
      HelpContext = 1686006
      Caption = 'Sandbox Client Secret'
      Transparent = True
    end
    object Label10: TLabel
      Left = 74
      Top = 78
      Width = 99
      Height = 15
      HelpContext = 1686007
      Caption = 'Sandbox Client ID'
      Transparent = True
    end
    object Label2: TLabel
      Left = 35
      Top = 217
      Width = 138
      Height = 15
      HelpContext = 1686009
      Caption = 'Quickbooks Company ID'
      Transparent = True
    end
    object Label4: TLabel
      Left = 77
      Top = 253
      Width = 96
      Height = 15
      HelpContext = 1686010
      Caption = 'Synch From Date'
      Transparent = True
    end
    object Label5: TLabel
      Left = 62
      Top = 139
      Width = 111
      Height = 15
      HelpContext = 1686007
      Caption = 'Production Client ID'
      Transparent = True
    end
    object Label6: TLabel
      Left = 35
      Top = 170
      Width = 138
      Height = 15
      HelpContext = 1686006
      Caption = 'Production Client Secret'
      Transparent = True
    end
    object edtSandboxClientSecret: TEdit
      Left = 183
      Top = 105
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
      OnChange = edtChange
    end
    object edtSandboxClientID: TEdit
      Left = 183
      Top = 74
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
      OnChange = edtChange
    end
    object edtCompanyId: TEdit
      Left = 183
      Top = 213
      Width = 325
      Height = 23
      HelpContext = 1686014
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnChange = edtChange
    end
    object chkSandboxMode: TwwCheckBox
      Left = 85
      Top = 282
      Width = 115
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Sandbox Mode'
      TabOrder = 8
      OnClick = chkSandboxModeClick
    end
    object chkEnableQuickbooks: TwwCheckBox
      Left = 61
      Top = 44
      Width = 139
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Alignment = taLeftJustify
      Caption = 'Enable Quickbooks'
      TabOrder = 0
      OnClick = chkEnableQuickbooksClick
    end
    object chkShowQuickbooksonMainmenubyDefault: TwwCheckBox
      Left = 239
      Top = 44
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
      Caption = 'Show Quickbooks on Main Menu by Default'
      TabOrder = 1
      OnClick = chkShowQuickbooksonMainmenubyDefaultClick
    end
    object chkAutoSynchFromList: TwwCheckBox
      Left = 49
      Top = 312
      Width = 151
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
      TabOrder = 9
      OnClick = chkAutoSynchFromListClick
    end
    object dtSynchFromDate: TDateTimePicker
      Left = 183
      Top = 249
      Width = 121
      Height = 23
      Date = 43794.551431354160000000
      Time = 43794.551431354160000000
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 7
      OnCloseUp = dtSynchFromDateCloseUp
      OnChange = dtSynchFromDateChange
    end
    object edtProductionClientID: TEdit
      Left = 183
      Top = 135
      Width = 325
      Height = 23
      HelpContext = 1686012
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnChange = edtChange
    end
    object edtProductionClientSecret: TEdit
      Left = 183
      Top = 166
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
      TabOrder = 5
      OnChange = edtChange
    end
  end
end
