inherited fmSubAssemUpdateAndCheck: TfmSubAssemUpdateAndCheck
  Caption = 'Sub Assemble  Check'
  ClientHeight = 459
  ClientWidth = 631
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  ExplicitWidth = 647
  ExplicitHeight = 498
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 1673002
  inherited lblSkingroupMsg: TLabel
    Top = 459
    Width = 631
    ExplicitTop = 459
    ExplicitWidth = 631
    HelpContext = 1673003
  end
  object lblNote: TLabel [4]
    Left = 24
    Top = 129
    Width = 577
    Height = 32
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'lblNote'
    WordWrap = True
    HelpContext = 1673004
  end
  object pnlTitle: TDNMPanel [5]
    Left = 84
    Top = 9
    Width = 464
    Height = 45
    HelpContext = 1673005
    Anchors = [akTop]
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
      Width = 460
      Height = 41
      HelpContext = 1673006
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
        Width = 460
        Height = 41
        HelpContext = 1673007
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'BOM Sub-Assembly Check'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 295
      end
    end
  end
  object btnOK: TDNMSpeedButton [6]
    Left = 213
    Top = 424
    Width = 87
    Height = 27
    HelpContext = 1673008
    Anchors = [akBottom]
    Caption = 'Start'
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
    HotTrackFont.Style = [fsBold]
    Kind = bkOK
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TDNMSpeedButton [7]
    Left = 330
    Top = 424
    Width = 87
    Height = 27
    HelpContext = 1673009
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
    HotTrackFont.Style = [fsBold]
    Kind = bkCancel
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    OnClick = btnCancelClick
  end
  object rgAction: TwwRadioGroup [8]
    Left = 60
    Top = 70
    Width = 511
    Height = 57
    DisableThemes = False
    Caption = 'Action'
    Columns = 2
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Items.Strings = (
      'Find and Link Sub-Assemblies'
      'Update Products from Sub-Assemblies')
    ParentFont = False
    TabOrder = 3
    OnChange = rgActionChange
    HelpContext = 1673010
  end
  object memLog: TMemo [9]
    Left = 24
    Top = 178
    Width = 585
    Height = 240
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 4
    HelpContext = 1673011
  end
  inherited popSpelling: TPopupMenu
    Left = 48
  end
  inherited tmrdelayMsg: TTimer
    Left = 184
    Top = 65520
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 265
    Top = 65520
  end
end
