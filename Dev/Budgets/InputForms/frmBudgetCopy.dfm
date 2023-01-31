inherited fmBudgetCopy: TfmBudgetCopy
  Left = 465
  Top = 260
  HelpContext = 144000
  Caption = 'Budget Variation'
  ClientHeight = 286
  ClientWidth = 353
  OldCreateOrder = True
  ExplicitLeft = 465
  ExplicitTop = 260
  ExplicitWidth = 361
  ExplicitHeight = 313
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 144001
  end
  object DNMPanel3: TDNMPanel [3]
    Left = 0
    Top = 241
    Width = 353
    Height = 45
    HelpContext = 144012
    Align = alBottom
    BevelOuter = bvNone
    Color = 14153215
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      353
      45)
    object BitBtn3: TDNMSpeedButton
      Left = 69
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 144013
      Anchors = [akBottom]
      Caption = 'Copy'
      Default = True
      DisableTransparent = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TDNMSpeedButton
      Left = 208
      Top = 10
      Width = 87
      Height = 27
      HelpContext = 144014
      Anchors = [akBottom]
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 2
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 353
    Height = 53
    HelpContext = 144008
    Align = alTop
    BevelOuter = bvNone
    Color = 14153215
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentFont = False
    TabOrder = 2
    object pnlTitle: TDNMPanel
      Left = 56
      Top = 2
      Width = 247
      Height = 45
      HelpContext = 144009
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 245
        Height = 43
        HelpContext = 144010
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
          Width = 245
          Height = 43
          HelpContext = 144011
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Budget Variation'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
      end
    end
  end
  object pnlVariation: TDNMPanel [5]
    Left = 0
    Top = 53
    Width = 353
    Height = 188
    HelpContext = 144002
    Align = alClient
    BevelOuter = bvNone
    Color = 14153215
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentFont = False
    TabOrder = 0
    object Label9: TLabel
      Left = 42
      Top = 157
      Width = 98
      Height = 15
      HelpContext = 144003
      Caption = 'Variation Amount'
      Transparent = True
    end
    object lblCopy: TLabel
      Left = 0
      Top = 0
      Width = 353
      Height = 30
      HelpContext = 144004
      Align = alTop
      Alignment = taCenter
      Caption = 
        'This will delete all the  periods of the selected budget if any ' +
        'exist.'
      Transparent = True
      WordWrap = True
      ExplicitWidth = 335
    end
    object rdbVariationOption: TwwRadioGroup
      Left = 42
      Top = 99
      Width = 270
      Height = 45
      HelpContext = 144005
      DisableThemes = False
      ItemIndex = 0
      TransparentActiveItem = True
      Transparent = True
      Caption = ' Variation Option '
      Color = 14153215
      Columns = 2
      Items.Strings = (
        'Increase By'
        'Decrease By')
      ParentColor = False
      TabOrder = 1
    end
    object rdbVariationType: TwwRadioGroup
      Left = 42
      Top = 48
      Width = 270
      Height = 45
      HelpContext = 144006
      DisableThemes = False
      ItemIndex = 1
      TransparentActiveItem = True
      Transparent = True
      Caption = ' Variation Type '
      Color = 14153215
      Columns = 2
      Items.Strings = (
        'Dollars'
        'Percentage')
      ParentColor = False
      TabOrder = 0
    end
    object edtVariationAmt: TwwDBEdit
      Left = 223
      Top = 153
      Width = 89
      Height = 23
      HelpContext = 144007
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      UnboundDataType = wwDefault
      WantReturns = False
      WordWrap = False
      OnKeyPress = edtVariationAmtKeyPress
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 400
    Top = 256
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 336
    Top = 256
  end
  inherited MyConnection: TERPConnection
    Left = 432
    Top = 255
  end
  inherited DataState: TDataState
    Left = 336
    Top = 280
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 464
    Top = 256
  end
end
