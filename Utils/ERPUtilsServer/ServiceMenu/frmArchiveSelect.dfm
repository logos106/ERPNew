object fmArchiveSelect: TfmArchiveSelect
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Backup Archive'
  ClientHeight = 367
  ClientWidth = 689
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  DesignSize = (
    689
    367)
  PixelsPerInch = 96
  TextHeight = 15
  object lbRestore: TLabel
    Left = 8
    Top = 56
    Width = 151
    Height = 15
    Caption = 'Choose Archive to restore '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel
    Left = 580
    Top = 56
    Width = 96
    Height = 15
    Anchors = [akTop, akRight]
    Caption = 'Show for all DB'#39's'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    ExplicitLeft = 570
  end
  object pnlTitle: TDNMPanel
    Left = 94
    Top = 7
    Width = 466
    Height = 41
    HelpContext = 189011
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 412
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 462
      Height = 37
      HelpContext = 189012
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
      ExplicitTop = 1
      ExplicitWidth = 408
      object TitleLabel: TLabel
        Left = 0
        Top = 0
        Width = 462
        Height = 37
        HelpContext = 189013
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Backup Archive'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitWidth = 326
      end
    end
  end
  object btnSave: TDNMSpeedButton
    Left = 157
    Top = 332
    Width = 87
    Height = 27
    HelpContext = 189015
    Anchors = [akBottom]
    Caption = 'OK'
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
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 1
    OnClick = btnSaveClick
    ExplicitLeft = 141
    ExplicitTop = 461
  end
  object btnCancel: TDNMSpeedButton
    Left = 392
    Top = 332
    Width = 87
    Height = 27
    HelpContext = 189017
    Anchors = [akBottom]
    Caption = 'Cancel'
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
    ModalResult = 2
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 2
    ExplicitLeft = 358
    ExplicitTop = 461
  end
  object lbArchive: TListBox
    Left = 2
    Top = 76
    Width = 684
    Height = 248
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 3
    OnClick = lbArchiveClick
  end
  object cbShowAllDBs: TCheckBox
    Left = 561
    Top = 56
    Width = 14
    Height = 14
    Anchors = [akTop, akRight]
    Caption = 'Show for all DB'#39's'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 4
    OnClick = cbShowAllDBsClick
    ExplicitLeft = 551
  end
end
