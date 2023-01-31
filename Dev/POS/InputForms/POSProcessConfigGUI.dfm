inherited POSProcessConfigFrm: TPOSProcessConfigFrm
  Left = 302
  Top = 228
  HelpContext = 428000
  Caption = 'Process List Configuration'
  ClientHeight = 430
  ClientWidth = 596
  OldCreateOrder = True
  ExplicitLeft = 302
  ExplicitTop = 228
  ExplicitWidth = 604
  ExplicitHeight = 457
  DesignSize = (
    596
    430)
  PixelsPerInch = 96
  TextHeight = 15
  object Bevel4: TBevel [0]
    Left = 272
    Top = 232
    Width = 307
    Height = 137
    HelpContext = 428002
    Anchors = [akTop, akRight]
    Shape = bsFrame
  end
  object Bevel3: TBevel [1]
    Left = 442
    Top = 88
    Width = 137
    Height = 137
    HelpContext = 428003
    Anchors = [akTop, akRight]
    Shape = bsFrame
  end
  object Bevel2: TBevel [2]
    Left = 272
    Top = 88
    Width = 153
    Height = 137
    HelpContext = 428004
    Anchors = [akTop, akRight]
    Shape = bsFrame
  end
  object Bevel1: TBevel [3]
    Left = 16
    Top = 88
    Width = 241
    Height = 280
    HelpContext = 428005
    Anchors = [akLeft, akTop, akRight, akBottom]
    Shape = bsFrame
  end
  object Label1: TLabel [4]
    Left = 54
    Top = 346
    Width = 49
    Height = 15
    HelpContext = 428006
    Anchors = [akLeft, akBottom]
    Caption = 'Show All'
    Transparent = True
  end
  object Label2: TLabel [5]
    Left = 33
    Top = 98
    Width = 90
    Height = 15
    HelpContext = 428007
    Caption = ' Process Steps '
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label3: TLabel [6]
    Left = 293
    Top = 98
    Width = 98
    Height = 15
    HelpContext = 428008
    Anchors = [akTop, akRight]
    Caption = 'Refresh Seconds'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel [7]
    Left = 322
    Top = 248
    Width = 89
    Height = 15
    HelpContext = 428009
    Anchors = [akTop, akRight]
    Caption = 'Show Complete'
    Transparent = True
  end
  object Label5: TLabel [8]
    Left = 322
    Top = 288
    Width = 111
    Height = 15
    HelpContext = 428010
    Anchors = [akTop, akRight]
    Caption = 'Show Not Complete'
    Transparent = True
  end
  object Label6: TLabel [9]
    Left = 322
    Top = 328
    Width = 110
    Height = 15
    HelpContext = 428011
    Anchors = [akTop, akRight]
    Caption = 'Show Prior Buttons'
    Transparent = True
  end
  object Label7: TLabel [10]
    Left = 461
    Top = 98
    Width = 77
    Height = 15
    HelpContext = 428012
    Anchors = [akTop, akRight]
    Caption = 'Display Order'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label8: TLabel [11]
    Left = 480
    Top = 128
    Width = 55
    Height = 15
    HelpContext = 428013
    Anchors = [akTop, akRight]
    Caption = 'Top Down'
    Transparent = True
  end
  object Label9: TLabel [12]
    Left = 480
    Top = 160
    Width = 59
    Height = 15
    HelpContext = 428014
    Anchors = [akTop, akRight]
    Caption = 'Bottom Up'
    Transparent = True
  end
  inherited imgGridWatermark: TImage
    HelpContext = 428001
  end
  inherited lblSkingroupMsg: TLabel
    Top = 380
    Width = 596
    HelpContext = 428032
  end
  object udRefresh: TUpDown [17]
    Left = 296
    Top = 128
    Width = 33
    Height = 81
    HelpContext = 428021
    Anchors = [akTop, akRight]
    Max = 32767
    TabOrder = 4
    OnClick = udRefreshClick
  end
  object edtRefreshIntervalSecs: TEdit [18]
    Left = 344
    Top = 154
    Width = 33
    Height = 23
    HelpContext = 428022
    Anchors = [akTop, akRight]
    TabOrder = 5
    Text = '5'
    OnChange = edtRefreshIntervalSecsChange
    OnKeyPress = edtRefreshIntervalSecsKeyPress
  end
  object cbxShowComplete: TCheckBox [19]
    Left = 298
    Top = 248
    Width = 12
    Height = 17
    HelpContext = 428023
    Anchors = [akTop, akRight]
    Caption = 'cbxShowComplete'
    TabOrder = 6
    OnClick = cbxShowCompleteClick
  end
  object cbxShowNotComplete: TCheckBox [20]
    Left = 298
    Top = 288
    Width = 12
    Height = 17
    HelpContext = 428024
    Anchors = [akTop, akRight]
    Caption = 'cbxShowComplete'
    TabOrder = 7
    OnClick = cbxShowNotCompleteClick
  end
  object cbxShowPriorButtons: TCheckBox [21]
    Left = 298
    Top = 328
    Width = 12
    Height = 17
    HelpContext = 428025
    Anchors = [akTop, akRight]
    Caption = 'cbxShowComplete'
    TabOrder = 8
  end
  object cbxTopDown: TCheckBox [22]
    Left = 456
    Top = 128
    Width = 12
    Height = 17
    HelpContext = 428026
    Anchors = [akTop, akRight]
    Caption = 'cbxShowComplete'
    TabOrder = 9
    OnClick = cbxTopDownClick
  end
  object cbxBottomUp: TCheckBox [23]
    Left = 456
    Top = 160
    Width = 12
    Height = 17
    HelpContext = 428027
    Anchors = [akTop, akRight]
    Caption = 'cbxShowComplete'
    TabOrder = 10
    OnClick = cbxBottomUpClick
  end
  object btnRefNumber: TDNMSpeedButton [24]
    Left = 467
    Top = 249
    Width = 87
    Height = 27
    HelpContext = 428028
    Anchors = [akTop, akRight]
    Caption = 'Ref Number'
    Default = True
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
    ModalResult = 1
    NumGlyphs = 2
    ParentFont = False
    TabOrder = 11
    OnClick = btnRefNumberClick
  end
  object pnlBottom: TDNMPanel [25]
    Left = 0
    Top = 380
    Width = 596
    Height = 50
    HelpContext = 428029
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      596
      50)
    object btnOK: TDNMSpeedButton
      Left = 191
      Top = 9
      Width = 87
      Height = 27
      HelpContext = 428030
      Anchors = [akTop]
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
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 319
      Top = 9
      Width = 87
      Height = 27
      HelpContext = 428031
      Anchors = [akTop]
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
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object cbSteps: TCheckListBox [26]
    Left = 32
    Top = 113
    Width = 209
    Height = 225
    HelpContext = 428019
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 24
    ParentFont = False
    TabOrder = 2
  end
  object pnlTop: TDNMPanel [27]
    Left = 0
    Top = 0
    Width = 596
    Height = 57
    HelpContext = 428015
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object pnlTitle: TDNMPanel
      Left = 97
      Top = 6
      Width = 394
      Height = 45
      HelpContext = 428016
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
        Width = 390
        Height = 41
        HelpContext = 428017
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
          Width = 390
          Height = 41
          HelpContext = 428018
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Process List Configuration'
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
  object cbxShowAllSteps: TCheckBox [28]
    Left = 35
    Top = 345
    Width = 12
    Height = 17
    HelpContext = 428020
    Anchors = [akLeft, akBottom]
    Caption = 'Show All'
    TabOrder = 3
    OnClick = cbxShowAllStepsClick
  end
  inherited ApplicationEvents1: TApplicationEvents
    Left = 45
    Top = 56
  end
  inherited MyConnection: TERPConnection
    Left = 77
    Top = 55
  end
  inherited popCustomiseGrid: TAdvPopupMenu
    Left = 109
    Top = 56
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102008400840010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000FFFF000000000000FFFF000000000000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000000000FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      000000FFFF000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF000000000000FFFF000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF0000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000000FF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00E00FFDFF00000000E00FF8FF00000000
      E00FF8FF00000000F00FF87F00000000F00FF81F00000000F80FF80F00000000
      F007F00F00000000F007E00F00000000F007E00F00000000F00FE00F00000000
      F01FF01F00000000F81FF00F00000000FE1FF00F00000000FF1FF00700000000
      FF1FF00700000000FFBFF0070000000000000000000000000000000000000000
      000000000000}
  end
  object qrySteps: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblProcessStep ORDER BY Description')
    Left = 480
    Top = 16
  end
  object qrySeqNum: TERPQuery
    SQL.Strings = (
      'SELECT * FROM tblSeqNumbers WHERE SeqName = :SeqName')
    Left = 512
    Top = 16
    ParamData = <
      item
        DataType = ftString
        Name = 'SeqName'
        Value = ''
      end>
  end
end
