inherited fmBaselistingSelectionPopup: TfmBaselistingSelectionPopup
  Caption = 'Selection'
  ClientHeight = 211
  ClientWidth = 486
  Position = poMainFormCenter
  ExplicitWidth = 502
  ExplicitHeight = 250
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1627002
  inherited lblSkingroupMsg: TLabel
    Top = 161
    Width = 486
    ExplicitTop = 213
    ExplicitWidth = 486
    HelpContext = 1627003
  end
  object pnlDetails: TDNMPanel [4]
    AlignWithMargins = True
    Left = 55
    Top = 53
    Width = 376
    Height = 105
    Margins.Left = 55
    Margins.Right = 55
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    HelpContext = 1627004
  end
  object pnlBottom: TDNMPanel [5]
    Left = 0
    Top = 161
    Width = 486
    Height = 50
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      486
      50)
    HelpContext = 1627005
    object cmdClose: TDNMSpeedButton
      Left = 200
      Top = 11
      Width = 87
      Height = 27
      Hint = 'Close'
      Anchors = []
      Cancel = True
      Caption = 'Search'
      Default = True
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
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      OnClick = cmdCloseClick
      HelpContext = 1627006
    end
  end
  object pnltop: TDNMPanel [6]
    Left = 0
    Top = 0
    Width = 486
    Height = 50
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    HelpContext = 1627007
    object pnlHeader: TDNMPanel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 478
      Height = 42
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      HelpContext = 1627008
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 476
        Height = 40
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
        HelpContext = 1627009
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 476
          Height = 40
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Selection Options'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = 2
          ExplicitTop = 1
          ExplicitWidth = 467
          ExplicitHeight = 47
          HelpContext = 1627010
        end
      end
    end
  end
end
