inherited fmBarcodeAfterPacked: TfmBarcodeAfterPacked
  Left = 78
  Top = 143
  HelpContext = 686000
  Caption = 'After Packing'
  ClientHeight = 211
  ClientWidth = 595
  Font.Charset = ANSI_CHARSET
  Font.Name = 'Arial'
  Position = poOwnerFormCenter
  ExplicitLeft = 78
  ExplicitTop = 143
  ExplicitWidth = 611
  ExplicitHeight = 250
  PixelsPerInch = 96
  TextHeight = 14
  inherited lblSkingroupMsg: TLabel
    Top = 167
    Width = 595
    HelpContext = 686011
    ExplicitTop = 167
    ExplicitWidth = 355
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 0
    Top = 167
    Width = 595
    Height = 44
    HelpContext = 686017
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      595
      44)
    object btnSelectAll: TDNMSpeedButton
      Left = 59
      Top = 8
      Width = 97
      Height = 29
      HelpContext = 686018
      Anchors = []
      Caption = '&Select All'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      TabOrder = 0
      OnClick = btnSelectAllClick
    end
    object btnPrint: TDNMSpeedButton
      Left = 248
      Top = 8
      Width = 97
      Height = 29
      HelpContext = 686019
      Anchors = []
      Caption = '&Print'
      Default = True
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnPrintClick
    end
    object btnclose: TDNMSpeedButton
      Left = 439
      Top = 8
      Width = 97
      Height = 29
      HelpContext = 686020
      Anchors = []
      Cancel = True
      Caption = '&Close'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
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
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 2
      OnClick = btncloseClick
    end
  end
  object DNMPanel3: TDNMPanel [5]
    Left = 0
    Top = 0
    Width = 595
    Height = 52
    HelpContext = 686021
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      595
      52)
    object pnlTitle: TDNMPanel
      Left = 37
      Top = 4
      Width = 521
      Height = 39
      HelpContext = 686022
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -25
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object TitleShader: TShader
        Left = 2
        Top = 2
        Width = 517
        Height = 35
        HelpContext = 686023
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
          Width = 517
          Height = 35
          HelpContext = 686024
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'After Packing'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 277
        end
      end
    end
  end
  object DNMPanel2: TDNMPanel [6]
    Left = 0
    Top = 52
    Width = 595
    Height = 115
    HelpContext = 686012
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object bPrintDeldocket: TDNMPanel
      Left = 119
      Top = 0
      Width = 119
      Height = 115
      HelpContext = 686013
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object chkPrintDeldocket: TCheckBox
        AlignWithMargins = True
        Left = 52
        Top = 96
        Width = 15
        Height = 15
        HelpContext = 686004
        Margins.Left = 51
        Margins.Right = 51
        Align = alBottom
        TabOrder = 0
      end
    end
    object bPrintCNote: TDNMPanel
      Left = 238
      Top = 0
      Width = 119
      Height = 115
      HelpContext = 686014
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object chkPrintCNote: TCheckBox
        AlignWithMargins = True
        Left = 52
        Top = 96
        Width = 15
        Height = 15
        HelpContext = 686003
        Margins.Left = 51
        Margins.Right = 51
        Align = alBottom
        TabOrder = 0
      end
    end
    object bPrintsale: TDNMPanel
      Left = 0
      Top = 0
      Width = 119
      Height = 115
      HelpContext = 686015
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      object chkPrintsale: TCheckBox
        AlignWithMargins = True
        Left = 52
        Top = 96
        Width = 15
        Height = 15
        HelpContext = 686006
        Margins.Left = 51
        Margins.Right = 51
        Align = alBottom
        TabOrder = 0
      end
    end
    object pnlPrintPick: TDNMPanel
      Left = 357
      Top = 0
      Width = 119
      Height = 115
      HelpContext = 686016
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      object chkPrintPick: TCheckBox
        AlignWithMargins = True
        Left = 52
        Top = 96
        Width = 15
        Height = 15
        HelpContext = 686025
        Margins.Left = 51
        Margins.Right = 51
        Align = alBottom
        TabOrder = 0
      end
    end
    object pnlPrintBarcode: TDNMPanel
      Left = 476
      Top = 0
      Width = 119
      Height = 115
      HelpContext = 686028
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      object chkPrintBarcode: TCheckBox
        AlignWithMargins = True
        Left = 52
        Top = 96
        Width = 15
        Height = 15
        HelpContext = 686032
        Margins.Left = 51
        Margins.Right = 51
        Align = alBottom
        TabOrder = 0
      end
    end
  end
  object ActionList: TActionList
    Left = 212
    Top = 153
    object actPrintDeldocket: TDNMAction
      Category = 'General'
      Caption = 'Print Del Docket'
      HelpContext = 686008
      ImageIndex = 111
      OnExecute = OptionSelected
      buttoncolor = clWhite
    end
    object actPrintCNote: TDNMAction
      Category = 'General'
      Caption = 'Print C'#39'Note'
      HelpContext = 686026
      ImageIndex = 188
      OnExecute = OptionSelected
      buttoncolor = clWhite
    end
    object actPrintPick: TDNMAction
      Category = 'General'
      Caption = 'Print Pick'
      HelpContext = 686027
      ImageIndex = 211
      OnExecute = OptionSelected
      buttoncolor = clWhite
    end
    object actPrintsale: TDNMAction
      Category = 'General'
      Caption = 'Print Sale'
      HelpContext = 686010
      ImageIndex = 150
      OnExecute = OptionSelected
      buttoncolor = clWhite
    end
    object actPrintDespatchBarcode: TDNMAction
      Category = 'General'
      Caption = 'Print Dispatch'
      HelpContext = 686031
      ImageIndex = 134
      OnExecute = OptionSelected
      buttoncolor = clWhite
    end
  end
end
