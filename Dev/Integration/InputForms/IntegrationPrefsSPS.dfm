object IntegrationPrefsSPSGUI: TIntegrationPrefsSPSGUI
  Left = 0
  Top = 0
  HelpContext = 1687002
  Caption = 'IntegrationPrefsSPSGUI'
  ClientHeight = 437
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
  object pnlSPSConfig: TDNMPanel
    Left = 16
    Top = 28
    Width = 545
    Height = 173
    HelpContext = 1687003
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
      173)
    object Bevel8: TBevel
      Left = 3
      Top = 3
      Width = 539
      Height = 167
      HelpContext = 1687004
      Anchors = [akLeft, akTop, akRight, akBottom]
      Shape = bsFrame
      ExplicitHeight = 335
    end
    object Label7: TLabel
      Left = 14
      Top = 14
      Width = 24
      Height = 15
      HelpContext = 1687005
      Caption = 'SPS'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      Transparent = True
    end
    object lblAmazonEnabled: TLabel
      Left = 19
      Top = 116
      Width = 100
      Height = 117
      HelpContext = 1687006
      AutoSize = False
      Caption = 'lblAmazonEnabled'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      Visible = False
      WordWrap = True
    end
    object GroupBox1: TGroupBox
      Left = 139
      Top = 14
      Width = 394
      Height = 139
      HelpContext = 1687007
      Caption = 'SPS Account Settings'
      TabOrder = 2
      object Label10: TLabel
        Left = 11
        Top = 39
        Width = 83
        Height = 15
        HelpContext = 1687008
        Caption = 'FTP Username'
        Transparent = True
      end
      object Label11: TLabel
        Left = 11
        Top = 68
        Width = 82
        Height = 15
        HelpContext = 1687009
        Caption = 'FTP Password'
        Transparent = True
      end
      object Label5: TLabel
        Left = 11
        Top = 97
        Width = 47
        Height = 15
        HelpContext = 1687010
        Caption = 'FTP URL'
        Transparent = True
      end
      object edtFTPUsername: TEdit
        Left = 112
        Top = 36
        Width = 266
        Height = 23
        HelpContext = 1687011
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnChange = edtChange
      end
      object edtFTPPassword: TEdit
        Left = 112
        Top = 65
        Width = 266
        Height = 23
        HelpContext = 1687012
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
      object edtFTPSite: TEdit
        Left = 112
        Top = 94
        Width = 266
        Height = 23
        HelpContext = 1687013
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnChange = edtChange
      end
    end
    object chkSPSEnabled: TwwCheckBox
      Left = 19
      Top = 47
      Width = 116
      Height = 17
      HelpContext = 1687014
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
      Caption = 'SPS Enabled'
      TabOrder = 0
      OnClick = chkSPSEnabledClick
    end
    object btnUPSTest: TDNMSpeedButton
      Left = 19
      Top = 78
      Width = 87
      Height = 27
      HelpContext = 1687015
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
      AutoDisableParentOnclick = True
    end
    object btnTestAccount: TDNMSpeedButton
      Left = 17
      Top = 134
      Width = 116
      Height = 27
      HelpContext = 1687016
      Anchors = [akTop, akRight]
      Caption = 'Load Test Settings'
      DisableTransparent = False
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Style = bsModern
      TabOrder = 3
      Visible = False
      AutoDisableParentOnclick = True
    end
  end
end
