object fmFormGuiPrefsEdit: TfmFormGuiPrefsEdit
  Left = 207
  Top = 143
  Width = 566
  Height = 589
  Caption = 'Customise'
  Color = 15527129
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object pnlBottom: TPanel
    Left = 0
    Top = 506
    Width = 558
    Height = 56
    Align = alBottom
    BevelOuter = bvNone
    Color = 15527129
    TabOrder = 0
    DesignSize = (
      558
      56)
    object rgUserType: TRadioGroup
      Left = 16
      Top = 8
      Width = 129
      Height = 40
      Caption = ' Save Settings For '
      Columns = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      Items.Strings = (
        'User'
        'Global')
      ParentFont = False
      TabOrder = 2
      OnClick = rgUserTypeClick
    end
    object btnOK: TDNMSpeedButton
      Left = 354
      Top = 17
      Width = 87
      Height = 27
      Hint = 'Save changes and close'
      Anchors = [akRight, akBottom]
      Caption = 'O&K'
      Color = clWhite
      Default = True
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
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 455
      Top = 17
      Width = 87
      Height = 27
      Hint = 'Cancel any changes you have made and close'
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancel'
      Color = clWhite
      Default = True
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
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      SlowDecease = True
      Style = bsModern
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnDefaults: TDNMSpeedButton
      Left = 250
      Top = 17
      Width = 87
      Height = 27
      Hint = 'Revert back to default '
      Anchors = [akRight, akBottom]
      Caption = 'Defaults'
      Color = clWhite
      Default = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      SlowDecease = True
      Style = bsModern
      TabOrder = 3
      OnClick = btnDefaultsClick
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 558
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    Color = 15527129
    TabOrder = 1
    OnDblClick = pnlTopDblClick
    DesignSize = (
      558
      65)
    object pnlHeader: TPanel
      Left = 25
      Top = 7
      Width = 512
      Height = 49
      HelpContext = 2697
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 'Users List'
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
        Width = 510
        Height = 47
        Align = alClient
        BevelOuter = bvNone
        Caption = 'TitleShader'
        Color = 15527129
        TabOrder = 0
        FromColor = 15527129
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = 15527129
        Steps = 10
        Direction = False
        Version = '1.2.1.1'
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 510
          Height = 47
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Color = 15527129
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          Layout = tlCenter
        end
      end
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 65
    Width = 558
    Height = 441
    Align = alClient
    BevelOuter = bvNone
    Color = 15527129
    TabOrder = 2
    object pcMain: TPageControl
      Left = 0
      Top = 0
      Width = 558
      Height = 441
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabHeight = 25
      TabOrder = 0
    end
  end
end
