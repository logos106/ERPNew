inherited fmcustomAccountsReportOptions: TfmcustomAccountsReportOptions
  Left = 800
  Top = 438
  HelpContext = 1251002
  Caption = 'Accounts Report : Options'
  ClientHeight = 427
  ClientWidth = 542
  ExplicitLeft = 800
  ExplicitTop = 438
  ExplicitWidth = 558
  ExplicitHeight = 466
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 377
    Width = 542
    HelpContext = 1251003
    ExplicitTop = 376
    ExplicitWidth = 542
  end
  inherited shapehint: TShape
    Left = 34
    ExplicitLeft = 34
  end
  inherited shapehintextra1: TShape
    Left = 111
    ExplicitLeft = 111
  end
  inherited DNMPanel1: TDNMPanel
    Top = 65
    Width = 542
    HelpContext = 1251009
    Align = alTop
    ExplicitLeft = 8
    ExplicitTop = 22
    ExplicitWidth = 542
    inherited chkShowSubTotals: TwwCheckBox
      Left = 381
      Top = 3
      Width = 144
      Height = 26
      HelpContext = 1251010
      Caption = 'Hide totals'
      ExplicitLeft = 381
      ExplicitTop = 3
      ExplicitWidth = 144
      ExplicitHeight = 26
    end
    inherited chkshowinactive: TwwCheckBox
      TabOrder = 3
    end
    object chkBlankwhen0: TCheckBox
      AlignWithMargins = True
      Left = 199
      Top = 3
      Width = 144
      Height = 26
      HelpContext = 1251011
      Margins.Top = 0
      Margins.Bottom = 0
      Caption = 'Blank when Zero'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      WordWrap = True
    end
    object chkUseGroupcolors: TCheckBox
      AlignWithMargins = True
      Left = 17
      Top = 3
      Width = 144
      Height = 26
      HelpContext = 1251012
      Margins.Top = 0
      Margins.Bottom = 0
      Caption = 'Use Group Colors'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      State = cbChecked
      TabOrder = 2
      WordWrap = True
    end
  end
  object pnlTitle: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 542
    Height = 65
    HelpContext = 1251005
    Align = alTop
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      542
      65)
    object pnlHeader: TDNMPanel
      Left = 46
      Top = 9
      Width = 449
      Height = 48
      HelpContext = 1251006
      Anchors = []
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 447
        Height = 46
        HelpContext = 1251007
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        FromColor = clBtnFace
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = clBtnFace
        Steps = 10
        Direction = False
        Version = '1.4.0.0'
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 447
          Height = 46
          HelpContext = 1251008
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Accounts Report : Options'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 6
          ExplicitWidth = 467
          ExplicitHeight = 47
        end
      end
    end
  end
  inherited DNMPanel3: TDNMPanel
    Top = 377
    Width = 542
    HelpContext = 1251013
    TabOrder = 3
    ExplicitTop = 377
    ExplicitWidth = 542
    inherited DNMSpeedButton2: TDNMSpeedButton
      Left = 40
      Top = 11
      Width = 87
      HelpContext = 1251014
      ExplicitLeft = 40
      ExplicitTop = 11
      ExplicitWidth = 87
    end
    inherited DNMSpeedButton3: TDNMSpeedButton
      Left = 160
      Top = 11
      Width = 87
      HelpContext = 1251015
      ExplicitLeft = 160
      ExplicitTop = 11
      ExplicitWidth = 87
    end
    inherited DNMSpeedButton4: TDNMSpeedButton
      Left = 416
      Top = 11
      Width = 87
      HelpContext = 1251016
      ExplicitLeft = 416
      ExplicitTop = 11
      ExplicitWidth = 87
    end
    object btnCustomize: TDNMSpeedButton
      Left = 280
      Top = 11
      Width = 104
      Height = 27
      Hint = '"Customise the List"'
      HelpContext = 1251017
      Anchors = [akBottom]
      Caption = 'Choose Accounts'
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
      TabOrder = 3
      TabStop = False
      OnClick = btnCustomizeClick
    end
  end
  inherited chkDepartments: TCheckListBox
    Left = 0
    Top = 96
    Width = 542
    Height = 281
    HelpContext = 1251004
    Align = alTop
    ExplicitLeft = 0
    ExplicitTop = 100
    ExplicitWidth = 542
    ExplicitHeight = 281
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102008C00900010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
end