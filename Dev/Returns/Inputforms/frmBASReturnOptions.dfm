inherited fmBASReturnOptions: TfmBASReturnOptions
  Left = 600
  Top = 165
  HelpContext = 921001
  Caption = 'BAS Return Options'
  ClientHeight = 286
  ClientWidth = 381
  Position = poMainFormCenter
  ExplicitLeft = 600
  ExplicitTop = 165
  ExplicitWidth = 389
  ExplicitHeight = 313
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 236
    Width = 381
    HelpContext = 921002
    ExplicitTop = 185
    ExplicitWidth = 381
  end
  object pnltop: TDNMPanel [3]
    Left = 0
    Top = 0
    Width = 381
    Height = 50
    HelpContext = 921003
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitLeft = 64
    ExplicitTop = 8
    ExplicitWidth = 150
    object pnlTitle: TDNMPanel
      Left = 35
      Top = 4
      Width = 302
      Height = 39
      HelpContext = 921004
      Caption = 'Invoice'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Locked = True
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 300
        Height = 37
        HelpContext = 921005
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
          Width = 300
          Height = 37
          HelpContext = 921006
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'BAS Return Options'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 171
        end
      end
    end
  end
  object pnlBottom: TDNMPanel [4]
    Left = 0
    Top = 236
    Width = 381
    Height = 50
    HelpContext = 921007
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      381
      50)
    object btnCompleted: TDNMSpeedButton
      Left = 146
      Top = 9
      Width = 87
      Height = 27
      HelpContext = 921008
      Anchors = [akBottom]
      Caption = 'Ok'
      Default = True
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
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
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btnCompletedClick
    end
    object btnClose: TDNMSpeedButton
      Left = 294
      Top = 12
      Width = 87
      Height = 27
      HelpContext = 921009
      Anchors = [akBottom]
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
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
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      Visible = False
      OnClick = btnCloseClick
    end
  end
  object pnlMain: TDNMPanel [5]
    Left = 0
    Top = 50
    Width = 381
    Height = 186
    HelpContext = 921010
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object chkGST: TCheckBox
      Left = 50
      Top = 24
      Width = 294
      Height = 17
      HelpContext = 921011
      Alignment = taLeftJustify
      Caption = 'Enable Goods and Services tax for the period'
      TabOrder = 0
    end
    object chkPaygw: TCheckBox
      Left = 36
      Top = 64
      Width = 308
      Height = 17
      HelpContext = 921012
      Alignment = taLeftJustify
      Caption = 'Enable Pay As You Go withholding for the period'
      TabOrder = 1
    end
    object chkPaygI: TCheckBox
      Left = 41
      Top = 104
      Width = 303
      Height = 17
      HelpContext = 921013
      Alignment = taLeftJustify
      Caption = 'Enable Pay As You Go instalment for the period  '
      TabOrder = 2
    end
    object chkWnL: TCheckBox
      Left = 88
      Top = 144
      Width = 256
      Height = 17
      HelpContext = 921014
      Alignment = taLeftJustify
      Caption = 'Enable Wine And Luxury for the Period'
      TabOrder = 3
    end
  end
end
