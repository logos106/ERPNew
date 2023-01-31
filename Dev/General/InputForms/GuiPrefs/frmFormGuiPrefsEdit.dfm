inherited fmFormGuiPrefsEdit: TfmFormGuiPrefsEdit
  Left = 682
  Top = 116
  HelpContext = 169000
  Caption = 'Customise'
  ClientHeight = 563
  ClientWidth = 590
  Color = 15527129
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = [fsBold]
  OldCreateOrder = True
  Position = poScreenCenter
  OnPaint = FormPaint
  ExplicitLeft = 682
  ExplicitTop = 116
  ExplicitWidth = 606
  ExplicitHeight = 602
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 507
    Width = 590
    ExplicitTop = 506
    ExplicitWidth = 590
    HelpContext = 169012
  end
  object pnlTop: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 590
    Height = 65
    HelpContext = 169006
    Align = alTop
    BevelOuter = bvNone
    Color = 15527129
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnDblClick = pnlTopDblClick
    DesignSize = (
      590
      65)
    object pnlTitle: TDNMPanel
      Left = 11
      Top = 10
      Width = 566
      Height = 45
      HelpContext = 169007
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -29
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 562
        Height = 41
        HelpContext = 169008
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
          Width = 562
          Height = 41
          HelpContext = 169009
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Title'
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
  object pnlBottom: TDNMPanel [5]
    Left = 0
    Top = 507
    Width = 590
    Height = 56
    HelpContext = 169001
    Align = alBottom
    BevelOuter = bvNone
    Color = 15527129
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      590
      56)
    object btnOK: TDNMSpeedButton
      Left = 386
      Top = 17
      Width = 87
      Height = 27
      Hint = 'Save changes and close'
      HelpContext = 169002
      Anchors = [akRight, akBottom]
      Caption = 'O&K'
      Color = clWhite
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
      HotTrackColor = clBtnShadow
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentColor = False
      ParentFont = False
      Style = bsModern
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 487
      Top = 17
      Width = 87
      Height = 27
      Hint = 'Cancel any changes you have made and close'
      HelpContext = 169003
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = '&Cancel'
      Color = clWhite
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
      Style = bsModern
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnDefaults: TDNMSpeedButton
      Left = 282
      Top = 17
      Width = 87
      Height = 27
      Hint = 'Revert back to default '
      HelpContext = 169004
      Anchors = [akRight, akBottom]
      Caption = 'Defaults'
      Color = clWhite
      Default = True
      DisableTransparent = False
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
      Style = bsModern
      TabOrder = 3
      OnClick = btnDefaultsClick
    end
    object rgUserType: TwwRadioGroup
      Left = 16
      Top = 8
      Width = 129
      Height = 40
      HelpContext = 169005
      DisableThemes = False
      TransparentActiveItem = True
      Transparent = True
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
      TabStop = False
      OnClick = rgUserTypeClick
    end
    object chkReset: TCheckBox
      Left = 168
      Top = 6
      Width = 81
      Height = 43
      Alignment = taLeftJustify
      Caption = 'Reset all users to global'
      TabOrder = 4
      WordWrap = True
      OnClick = chkResetClick
      HelpContext = 169013
    end
  end
  object pnlMain: TDNMPanel [6]
    Left = 0
    Top = 65
    Width = 590
    Height = 442
    HelpContext = 169010
    Align = alClient
    BevelOuter = bvNone
    Color = 15527129
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    object pcMain: TPageControl
      AlignWithMargins = True
      Left = 18
      Top = 3
      Width = 554
      Height = 405
      HelpContext = 169011
      Margins.Left = 18
      Margins.Right = 18
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      OwnerDraw = True
      ParentFont = False
      TabHeight = 25
      TabOrder = 0
      OnDrawTab = pcMainDrawTab
    end
    object btnAddtoMainSwitch: TDNMSpeedButton
      AlignWithMargins = True
      Left = 386
      Top = 414
      Width = 186
      Height = 27
      HelpContext = 169014
      Margins.Left = 386
      Margins.Right = 18
      Margins.Bottom = 1
      Align = alBottom
      Caption = 'Add to Main Switch'
      Color = clWhite
      Default = True
      DisableTransparent = False
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
      Style = bsModern
      TabOrder = 1
      OnClick = btnAddtoMainSwitchClick
    end
  end
end
