inherited fmBOMSchedulewhenReadytoScheduleOptions: TfmBOMSchedulewhenReadytoScheduleOptions
  Left = 1241
  Top = 181
  HelpContext = 1375002
  Caption = 'Options'
  ClientHeight = 315
  ClientWidth = 348
  Position = poScreenCenter
  ExplicitLeft = 1241
  ExplicitTop = 181
  ExplicitWidth = 356
  ExplicitHeight = 342
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 266
    Width = 348
    HelpContext = 1375003
    ExplicitTop = 188
    ExplicitWidth = 304
  end
  object pnlTop: TPanel [3]
    Left = 0
    Top = 0
    Width = 348
    Height = 49
    HelpContext = 1375004
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      348
      49)
    object pnlHeader: TPanel
      Left = 27
      Top = 6
      Width = 293
      Height = 37
      HelpContext = 1375005
      Anchors = [akLeft, akTop, akRight, akBottom]
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
        Width = 291
        Height = 35
        HelpContext = 1375006
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
          Width = 291
          Height = 35
          HelpContext = 1375007
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Options'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -24
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitLeft = -3
          ExplicitWidth = 548
          ExplicitHeight = 47
        end
      end
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 266
    Width = 348
    Height = 49
    HelpContext = 1375008
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      348
      49)
    object btnCompleted: TDNMSpeedButton
      Left = 86
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 1375009
      Anchors = [akTop, akRight]
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
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
    end
    object btnClose: TDNMSpeedButton
      Left = 219
      Top = 11
      Width = 87
      Height = 27
      HelpContext = 1375010
      Anchors = [akTop, akRight]
      Cancel = True
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
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      TabStop = False
    end
  end
  object Panel3: TPanel [5]
    AlignWithMargins = True
    Left = 3
    Top = 120
    Width = 342
    Height = 143
    HelpContext = 1375011
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 2
    object Label1: TLabel
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 334
      Height = 15
      HelpContext = 1375012
      Align = alTop
      Caption = 'Auto Select Options : Ok to Schedule When '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      ExplicitWidth = 246
    end
    object chkOktoScheduleWhenProcessesnotScheduled: TCheckBox
      AlignWithMargins = True
      Left = 41
      Top = 86
      Width = 297
      Height = 17
      HelpContext = 1375013
      Margins.Left = 40
      Margins.Top = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Processes are not Scheduled'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
    end
    object chkOktoScheduleWhenGoodsReceived: TCheckBox
      AlignWithMargins = True
      Left = 41
      Top = 57
      Width = 297
      Height = 17
      HelpContext = 1375014
      Margins.Left = 40
      Margins.Top = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Goods Received'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
    end
    object chkOktoScheduleWhenSubBOMsDone: TCheckBox
      AlignWithMargins = True
      Left = 41
      Top = 28
      Width = 297
      Height = 17
      HelpContext = 1375015
      Margins.Left = 40
      Margins.Top = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Sub BOMs Done'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object chkOktoScheduleWhenStockAvailable: TCheckBox
      AlignWithMargins = True
      Left = 41
      Top = 115
      Width = 297
      Height = 17
      HelpContext = 1375016
      Margins.Left = 40
      Margins.Top = 6
      Margins.Bottom = 6
      Align = alTop
      Caption = 'Stock Available'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
  end
  object pnlEnableSingleclickSelection: TPanel [6]
    AlignWithMargins = True
    Left = 3
    Top = 52
    Width = 342
    Height = 62
    HelpContext = 1375017
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 3
    object lblEnableSingleclickSelection: TLabel
      AlignWithMargins = True
      Left = 31
      Top = 28
      Width = 310
      Height = 30
      HelpContext = 1375018
      Margins.Left = 30
      Margins.Top = 0
      Margins.Right = 0
      Align = alClient
      Caption = 
        '(Double-click will Select the Process By Default . Also Right-cl' +
        'ick for Options to choose Process(es))'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      WordWrap = True
      ExplicitHeight = 28
    end
    object chkEnableSingleclickSelection: TCheckBox
      AlignWithMargins = True
      Left = 4
      Top = 11
      Width = 334
      Height = 17
      HelpContext = 1375019
      Margins.Top = 10
      Margins.Bottom = 0
      Align = alTop
      Caption = '  Enable Single-Click to Choose the Process'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      WordWrap = True
    end
  end
end
