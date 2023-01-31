inherited fmInventoryAssetVsStockStautsDetails: TfmInventoryAssetVsStockStautsDetails
  Left = 338
  Top = 254
  HelpContext = 1554002
  Caption = 'fmInventoryAssetVsStockStautsDetails'
  ClientHeight = 565
  ClientWidth = 996
  OnResize = FormResize
  ExplicitLeft = 338
  ExplicitTop = 254
  ExplicitWidth = 1012
  ExplicitHeight = 604
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 507
    Width = 996
    HelpContext = 1554003
    ExplicitTop = 507
    ExplicitWidth = 996
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 0
    Top = 507
    Width = 996
    Height = 58
    HelpContext = 1554004
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      996
      58)
    object cmdClose: TDNMSpeedButton
      Left = 455
      Top = 16
      Width = 87
      Height = 27
      Hint = '"Close The List"'
      HelpContext = 1554005
      Anchors = [akBottom]
      Caption = '&Close'
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
      AutoDisableParentOnclick = True
    end
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 996
    Height = 58
    HelpContext = 1554006
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      996
      58)
    object pnlHeader: TPanel
      Left = 165
      Top = 5
      Width = 666
      Height = 49
      HelpContext = 1554007
      Anchors = [akLeft, akTop, akRight, akBottom]
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
        Width = 664
        Height = 47
        HelpContext = 1554008
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
          Width = 664
          Height = 47
          HelpContext = 1554009
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Inv. Asset Vs Balance Sheet - Details'
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
        end
      end
    end
    object btnExpressDetail: TDNMSpeedButton
      AlignWithMargins = True
      Left = 896
      Top = 12
      Width = 96
      Height = 34
      HelpContext = 1554010
      Margins.Top = 11
      Margins.Bottom = 11
      Align = alRight
      Caption = 'Summary'
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
      TabOrder = 1
      AutoDisableParentOnclick = True
      OnClick = btnExpressDetailClick
    end
  end
  object pgeControl: TPageControl [6]
    Left = 0
    Top = 58
    Width = 996
    Height = 449
    HelpContext = 1554011
    ActivePage = tabBal
    Align = alClient
    TabOrder = 2
    object tabSummary: TTabSheet
      HelpContext = 1554012
      Caption = 'Summary'
    end
    object tabPQa: TTabSheet
      HelpContext = 1554013
      Caption = 'PQA'
      ImageIndex = 1
    end
    object tabBal: TTabSheet
      HelpContext = 1554014
      Caption = 'Balance Sheet'
      ImageIndex = 2
      OnResize = tabBalResize
      ExplicitTop = 22
    end
  end
end
