object AccountsPrefsHMRCGUI: TAccountsPrefsHMRCGUI
  Left = 0
  Top = 0
  Caption = 'AccountsPrefsHMRCGUI'
  ClientHeight = 580
  ClientWidth = 567
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1578002
  object pnlHMRC: TDNMPanel
    Left = 0
    Top = 0
    Width = 567
    Height = 262
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    HelpContext = 1578003
    object Bevel4: TBevel
      AlignWithMargins = True
      Left = 7
      Top = 7
      Width = 553
      Height = 248
      HelpContext = 1578004
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Align = alClient
      Shape = bsFrame
      ExplicitTop = 9
      ExplicitWidth = 1055
      ExplicitHeight = 186
    end
    object lblPanelCaption_HMRC: TLabel
      Left = 14
      Top = 14
      Width = 131
      Height = 15
      HelpContext = 1578005
      Caption = 'HMRC API (UK Gov VAT)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object Label37: TLabel
      Left = 26
      Top = 75
      Width = 99
      Height = 15
      Caption = 'Sandbox Client ID'
      HelpContext = 1578006
    end
    object Label38: TLabel
      Left = 26
      Top = 104
      Width = 126
      Height = 15
      Caption = 'Sandbox Client Secret'
      HelpContext = 1578007
    end
    object Label40: TLabel
      Left = 26
      Top = 195
      Width = 71
      Height = 15
      Caption = 'VAT Rego No'
      HelpContext = 1578008
    end
    object Label41: TLabel
      Left = 27
      Top = 133
      Width = 111
      Height = 15
      Caption = 'Production Client ID'
      HelpContext = 1578009
    end
    object Label42: TLabel
      Left = 27
      Top = 162
      Width = 138
      Height = 15
      Caption = 'Production Client Secret'
      HelpContext = 1578010
    end
    object HTMLabel1: THTMLabel
      Left = 27
      Top = 224
      Width = 432
      Height = 17
      HTMLText.Strings = (
        
          '<a href="https://www.tax.service.gov.uk/vat-through-software/sig' +
          'n-up/have-software">Click here to sign up with HM Revenue & Cust' +
          'oms</a>')
      Version = '1.8.1.0'
      HelpContext = 1578011
    end
    object chkHMRCActive: TwwCheckBox
      Left = 121
      Top = 45
      Width = 97
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Caption = 'Active'
      TabOrder = 0
      HelpContext = 1578012
    end
    object chkTestMode: TwwCheckBox
      Left = 296
      Top = 45
      Width = 145
      Height = 17
      DisableThemes = False
      AlwaysTransparent = False
      ValueChecked = 'True'
      ValueUnchecked = 'False'
      DisplayValueChecked = 'True'
      DisplayValueUnchecked = 'False'
      NullAndBlankState = cbUnchecked
      Caption = 'Test Mode (Sandbox)'
      TabOrder = 1
      HelpContext = 1578013
    end
    object edtHMRCSandboxClientID: TEdit
      Left = 176
      Top = 72
      Width = 284
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = 'edtHMRCSandboxClientID'
      HelpContext = 1578014
    end
    object edtHMRCSandboxClientSecret: TEdit
      Left = 176
      Top = 101
      Width = 284
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 3
      Text = 'edtHMRCSandboxClientSecret'
      HelpContext = 1578015
    end
    object edtVATRegistrationNumber: TEdit
      Left = 176
      Top = 192
      Width = 284
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      Text = 'edtVATRegistrationNumber'
      HelpContext = 1578016
    end
    object edtHMRCProductionClientID: TEdit
      Left = 176
      Top = 130
      Width = 285
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      Text = 'edtHMRCProductionClientID'
      HelpContext = 1578017
    end
    object edtHMRCProductionClientSecret: TEdit
      Left = 176
      Top = 159
      Width = 285
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 6
      Text = 'edtHMRCSandboxClientSecret'
      HelpContext = 1578018
    end
  end
end
