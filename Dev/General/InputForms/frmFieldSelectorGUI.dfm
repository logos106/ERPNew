inherited frmFieldSelector: TfrmFieldSelector
  Left = 345
  Top = 148
  HelpContext = 283000
  BorderIcons = []
  Caption = 'Column Selector'
  ClientHeight = 487
  ClientWidth = 375
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 283001
  end
  object DNMPanel1: TDNMPanel [1]
    Left = 0
    Top = 0
    Width = 375
    Height = 487
    HelpContext = 283002
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      375
      487)
    object lstFields: TCheckListBox
      Left = 0
      Top = 41
      Width = 375
      Height = 406
      HelpContext = 283003
      TabStop = False
      OnClickCheck = lstFieldsClickCheck
      Align = alTop
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 15
      ParentFont = False
      TabOrder = 0
    end
    object btnOK: TDNMSpeedButton
      Left = 7
      Top = 456
      Width = 87
      Height = 25
      HelpContext = 283004
      Anchors = [akBottom]
      Caption = 'O&K'
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
    object btnCancel: TDNMSpeedButton
      Left = 282
      Top = 456
      Width = 87
      Height = 25
      Hint = '"Close and Cancel the column selector"'
      HelpContext = 283005
      Anchors = [akBottom]
      Cancel = True
      Caption = '&Cancel'
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
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnCancelClick
    end
    object DNMPanel2: TDNMPanel
      Left = 0
      Top = 0
      Width = 375
      Height = 41
      HelpContext = 283006
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      DesignSize = (
        375
        41)
      object pnlTitle: TDNMPanel
        Left = 67
        Top = 3
        Width = 242
        Height = 34
        HelpContext = 283007
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
          Width = 238
          Height = 30
          HelpContext = 283008
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          FromColor = clBtnFace
          ToColor = clWhite
          FromColorMirror = clWhite
          ToColorMirror = clBtnFace
          Steps = 10
          Direction = False
          Version = '1.2.1.1'
          object TitleLabel: TLabel
            Left = 0
            Top = 0
            Width = 238
            Height = 30
            HelpContext = 283009
            Align = alClient
            Alignment = taCenter
            AutoSize = False
            Caption = 'Column Selector'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = -27
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
            Transparent = True
            Layout = tlCenter
          end
        end
      end
    end
    object btnSelectAll: TDNMSpeedButton
      Left = 98
      Top = 456
      Width = 87
      Height = 25
      Hint = '"Select all Columns"'
      HelpContext = 283010
      Anchors = [akBottom]
      Caption = '&Select All'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnSelectAllClick
    end
    object btnUnselect: TDNMSpeedButton
      Left = 190
      Top = 456
      Width = 87
      Height = 25
      Hint = '"UnSelect all Columns"'
      HelpContext = 283011
      Anchors = [akBottom]
      Caption = '&Unselect All'
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnUnselectClick
    end
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 67
    Top = 74
  end
  inherited MyConnection: TERPConnection
    Left = 99
    Top = 73
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 131
    Top = 74
  end
  object qryNone: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblability LIMIT 0;')
    Left = 162
    Top = 76
  end
end
