inherited fmConvertProductPicture: TfmConvertProductPicture
  Left = 2561
  Top = 302
  Caption = 'Convert Image'
  ClientHeight = 277
  Position = poMainFormCenter
  ExplicitLeft = 2561
  ExplicitTop = 302
  ExplicitWidth = 307
  ExplicitHeight = 304
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1213002
  inherited lblSkingroupMsg: TLabel
    Top = 227
    ExplicitTop = 227
  end
  object DNMPanel1: TDNMPanel [3]
    Left = 0
    Top = 59
    Width = 299
    Height = 168
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitTop = 57
    ExplicitHeight = 175
    HelpContext = 1213003
    object Label2: TLabel
      Left = 29
      Top = 65
      Width = 63
      Height = 15
      Caption = 'Convert  To'
      HelpContext = 1213004
    end
    object Label1: TLabel
      Left = 10
      Top = 24
      Width = 82
      Height = 15
      Caption = 'Convert  From '
      HelpContext = 1213005
    end
    object Label3: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 101
      Width = 291
      Height = 60
      Margins.Bottom = 6
      Align = alBottom
      Alignment = taCenter
      Caption = 
        'Please note that this will convert all selected Product pictures' +
        ' of the type '#39'Convert from'#39' to '#39'convert to'#39' type. It will not be' +
        ' able to revert this change '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      WordWrap = True
      ExplicitWidth = 268
      HelpContext = 1213006
    end
    object cbofrom: TComboBox
      Left = 112
      Top = 24
      Width = 145
      Height = 23
      TabOrder = 0
      Text = 'Bitmap'
      Items.Strings = (
        'BMP'
        'JPG'
        'GIF'
        'PNG')
      HelpContext = 1213007
    end
    object cboTo: TComboBox
      Left = 112
      Top = 61
      Width = 145
      Height = 23
      TabOrder = 1
      Text = 'Gif'
      Items.Strings = (
        'BMP'
        'JPG'
        'GIF'
        'PNG')
      HelpContext = 1213008
    end
  end
  object DNMPanel2: TDNMPanel [4]
    Left = 0
    Top = 227
    Width = 299
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
      299
      50)
    HelpContext = 1213009
    object btnClose: TDNMSpeedButton
      Left = 166
      Top = 13
      Width = 87
      Height = 27
      HelpContext = 1213010
      Anchors = []
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object btnCompleted: TDNMSpeedButton
      Left = 46
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 1213011
      Anchors = []
      Caption = '&Ok'
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
      OnClick = btnCompletedClick
    end
  end
  object DNMPanel3: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 299
    Height = 59
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      299
      59)
    HelpContext = 1213012
    object pnlHeader: TPanel
      Left = 23
      Top = 7
      Width = 253
      Height = 44
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      HelpContext = 1213013
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 251
        Height = 42
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
        HelpContext = 1213014
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 251
          Height = 42
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Convert Image'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 5
          ExplicitHeight = 49
          HelpContext = 1213015
        end
      end
    end
  end
end
