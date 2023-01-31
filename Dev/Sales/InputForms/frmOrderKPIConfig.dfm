inherited fmOrderKPIConfig: TfmOrderKPIConfig
  BorderStyle = bsSingle
  Caption = 'Order KPI Config'
  ClientHeight = 376
  ClientWidth = 477
  Font.Charset = ANSI_CHARSET
  Font.Height = -12
  Font.Name = 'Arial'
  Position = poScreenCenter
  ExplicitLeft = 8
  ExplicitTop = 8
  ExplicitWidth = 483
  ExplicitHeight = 404
  DesignSize = (
    477
    376)
  PixelsPerInch = 96
  TextHeight = 15
  HelpContext = 914001
  object Label1: TLabel
    Left = 175
    Top = 86
    Width = 126
    Height = 15
    Caption = 'Quote Letter Template'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 914002
  end
  object Label2: TLabel
    Left = 31
    Top = 158
    Width = 183
    Height = 15
    Caption = 'Delivery Confirmation Templates'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 914003
  end
  object Label3: TLabel
    Left = 311
    Top = 158
    Width = 76
    Height = 15
    Caption = 'All Templates'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
    HelpContext = 914004
  end
  object pnlTitle: TDNMPanel
    Left = 42
    Top = 16
    Width = 392
    Height = 41
    HelpContext = 914005
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
      Width = 388
      Height = 37
      HelpContext = 914006
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
        Width = 388
        Height = 37
        HelpContext = 914007
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Order KPI Config'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitLeft = 18
        ExplicitTop = -32
        ExplicitWidth = 285
      end
    end
  end
  object btnSave: TDNMSpeedButton
    Left = 133
    Top = 330
    Width = 87
    Height = 27
    HelpContext = 914008
    Anchors = [akBottom]
    Caption = 'Ok'
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
    TabOrder = 6
    OnClick = btnSaveClick
  end
  object btnCancel: TDNMSpeedButton
    Left = 256
    Top = 330
    Width = 87
    Height = 27
    HelpContext = 914009
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
    TabOrder = 7
  end
  object cboQuoteLetter: TwwDBComboBox
    Left = 106
    Top = 107
    Width = 265
    Height = 23
    ShowButton = True
    Style = csDropDownList
    MapList = False
    AllowClearKey = False
    DropDownCount = 8
    ItemHeight = 0
    Sorted = False
    TabOrder = 1
    UnboundDataType = wwDefault
    OnCloseUp = cboQuoteLetterCloseUp
    HelpContext = 914010
  end
  object lstSelected: TListBox
    Left = 29
    Top = 179
    Width = 191
    Height = 134
    ItemHeight = 15
    Sorted = True
    TabOrder = 2
    OnDblClick = lstSelectedDblClick
    HelpContext = 914011
  end
  object lstTemplates: TListBox
    Left = 256
    Top = 179
    Width = 191
    Height = 134
    ItemHeight = 15
    Sorted = True
    TabOrder = 5
    OnDblClick = lstTemplatesDblClick
    HelpContext = 914012
  end
  object btnAdd: TButton
    Left = 226
    Top = 216
    Width = 25
    Height = 25
    Caption = '<'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btnAddClick
    HelpContext = 914013
  end
  object btnRemove: TButton
    Left = 226
    Top = 247
    Width = 25
    Height = 25
    Caption = '>'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btnRemoveClick
    HelpContext = 914014
  end
end
