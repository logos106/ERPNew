inherited fmProjectInstallationRoster: TfmProjectInstallationRoster
  Left = 239
  Top = 237
  HelpContext = 1298002
  Caption = 'Managers Roster'
  ClientWidth = 1015
  OnResize = FormResize
  ExplicitLeft = 239
  ExplicitTop = 237
  ExplicitWidth = 1031
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 435
    Width = 1015
    HelpContext = 1298003
    ExplicitTop = 435
    ExplicitWidth = 1015
  end
  inherited shapehint: TShape
    Left = 13
    ExplicitLeft = 13
  end
  inherited shapehintextra1: TShape
    Left = 58
    ExplicitLeft = 58
  end
  object lblMsg: TLabel [5]
    Left = 0
    Top = 435
    Width = 1015
    Height = 15
    HelpContext = 1298004
    Align = alBottom
    Alignment = taCenter
    Caption = 'lblMsg'
    Visible = False
    ExplicitWidth = 37
  end
  object report2n3: TSplitter [6]
    Left = 828
    Top = 52
    Width = 2
    Height = 383
    HelpContext = 1298005
    Align = alRight
    ExplicitLeft = 642
    ExplicitTop = 1
    ExplicitHeight = 254
  end
  object DNMPanel3: TDNMPanel [7]
    Left = 0
    Top = 0
    Width = 1015
    Height = 52
    HelpContext = 1298006
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      1015
      52)
    object pnlTitle: TDNMPanel
      Left = 17
      Top = 6
      Width = 262
      Height = 39
      HelpContext = 1298007
      Anchors = []
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
        Width = 258
        Height = 35
        HelpContext = 1298008
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
          Width = 258
          Height = 35
          HelpContext = 1298009
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Managers Roster'
          Color = clBtnFace
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -29
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitWidth = 234
        end
      end
    end
    object pnlClass: TDNMPanel
      Left = 864
      Top = 1
      Width = 150
      Height = 50
      HelpContext = 1298010
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object shpClass: TShape
        Left = 1
        Top = 0
        Width = 130
        Height = 29
        HelpContext = 1298011
        Brush.Style = bsClear
        Pen.Color = 9079551
      end
      object chkClasses: TCheckBox
        AlignWithMargins = True
        Left = 4
        Top = 2
        Width = 145
        Height = 26
        HelpContext = 1298012
        Margins.Top = 1
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        Caption = 'All Departments?'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = chkClassesClick
      end
      object cboClass: TwwDBLookupCombo
        Left = 6
        Top = 23
        Width = 139
        Height = 23
        HelpContext = 1298013
        DropDownAlignment = taLeftJustify
        LookupTable = qryClasses
        LookupField = 'ClassName'
        DropDownWidth = 25
        Enabled = False
        TabOrder = 1
        AutoDropDown = False
        ShowButton = True
        PreciseEditRegion = False
        AllowClearKey = False
        OnCloseUp = cboClassCloseUp
      end
    end
    object pnldate: TDNMPanel
      AlignWithMargins = True
      Left = 679
      Top = 16
      Width = 182
      Height = 32
      HelpContext = 1298014
      Margins.Top = 15
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      DesignSize = (
        182
        32)
      object shpdate: TShape
        Left = 1
        Top = 0
        Width = 130
        Height = 29
        HelpContext = 1298015
        Brush.Style = bsClear
        Pen.Color = 9079551
      end
      object btnPrevMonth: TDNMSpeedButton
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 25
        Height = 24
        HelpContext = 1298016
        Align = alLeft
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333FF3333333333333744333333333333F773333333333337
          44473333333333F777F3333333333744444333333333F7733733333333374444
          4433333333F77333733333333744444447333333F7733337F333333744444444
          433333F77333333733333744444444443333377FFFFFFF7FFFFF999999999999
          9999733777777777777333CCCCCCCCCC33333773FF333373F3333333CCCCCCCC
          C333333773FF3337F333333333CCCCCCC33333333773FF373F3333333333CCCC
          CC333333333773FF73F33333333333CCCCC3333333333773F7F3333333333333
          CCC333333333333777FF33333333333333CC3333333333333773}
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        NumGlyphs = 2
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        WordWrap = True
        OnClick = btnPrevMonthClick
      end
      object dtpMonth: TwwDBDateTimePicker
        Left = 51
        Top = 6
        Width = 84
        Height = 23
        HelpContext = 1298017
        Anchors = []
        CalendarAttributes.Font.Charset = DEFAULT_CHARSET
        CalendarAttributes.Font.Color = clWindowText
        CalendarAttributes.Font.Height = -11
        CalendarAttributes.Font.Name = 'MS Sans Serif'
        CalendarAttributes.Font.Style = []
        Epoch = 1950
        ShowButton = True
        TabOrder = 1
        DisplayFormat = 'mmmm yyyy'
        OnChange = dtpMonthChange
      end
      object btnNextMonth: TDNMSpeedButton
        AlignWithMargins = True
        Left = 153
        Top = 4
        Width = 25
        Height = 24
        HelpContext = 1298018
        Align = alRight
        DisableTransparent = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000120B0000120B00001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333447333333333333374447333333333333444447333333333334444447333
          3333337444444473333333344444444473333333444444444473999999999999
          99993333CCCCCCCCCC33333CCCCCCCCC3333333CCCCCCC33333333CCCCCC3333
          33333CCCCC33333333333CCC333333333333CC33333333333333}
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -12
        HotTrackFont.Name = 'Arial'
        HotTrackFont.Style = [fsBold]
        Layout = blGlyphRight
        NumGlyphs = 1
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        WordWrap = True
        OnClick = btnNextMonthClick
      end
    end
    object pnlRowHeight: TDNMPanel
      AlignWithMargins = True
      Left = 425
      Top = 16
      Width = 134
      Height = 32
      HelpContext = 1298019
      Margins.Top = 15
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      Visible = False
      object shpRowHeight: TShape
        Left = 1
        Top = 2
        Width = 130
        Height = 29
        HelpContext = 1298020
        Brush.Style = bsClear
        Pen.Color = 9079551
      end
      object Label2: TLabel
        AlignWithMargins = True
        Left = 35
        Top = 4
        Width = 64
        Height = 24
        HelpContext = 1298021
        Align = alClient
        Caption = 'Row Height'
        Transparent = True
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object btnDecRowHeight: TDNMSpeedButton
        AlignWithMargins = True
        Left = 105
        Top = 4
        Width = 25
        Height = 24
        Hint = 'Decrease'
        HelpContext = 1298022
        Align = alRight
        DisableTransparent = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
          333333777777777F33333330B00000003333337F7777777F3333333000000000
          333333777777777F333333330EEEEEE033333337FFFFFF7F3333333300000000
          333333377777777F3333333330BFBFB03333333373333373F33333330BFBFBFB
          03333337F33333F7F33333330FBFBF0F03333337F33337F7F33333330BFBFB0B
          03333337F3F3F7F7333333330F0F0F0033333337F7F7F773333333330B0B0B03
          3333333737F7F7F333333333300F0F03333333337737F7F33333333333300B03
          333333333377F7F33333333333330F03333333333337F7F33333333333330B03
          3333333333373733333333333333303333333333333373333333}
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnDecRowHeightClick
      end
      object btnIncRowHeight: TDNMSpeedButton
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 25
        Height = 24
        Hint = 'Increase'
        HelpContext = 1298023
        Align = alLeft
        DisableTransparent = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333033333
          33333333373F33333333333330B03333333333337F7F33333333333330F03333
          333333337F7FF3333333333330B00333333333337F773FF33333333330F0F003
          333333337F7F773F3333333330B0B0B0333333337F7F7F7F3333333300F0F0F0
          333333377F73737F33333330B0BFBFB03333337F7F33337F33333330F0FBFBF0
          3333337F7333337F33333330BFBFBFB033333373F3333373333333330BFBFB03
          33333337FFFFF7FF3333333300000000333333377777777F333333330EEEEEE0
          33333337FFFFFF7FF3333333000000000333333777777777F33333330000000B
          03333337777777F7F33333330000000003333337777777773333}
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnIncRowHeightClick
      end
    end
    object pnlResize: TDNMPanel
      AlignWithMargins = True
      Left = 565
      Top = 16
      Width = 108
      Height = 32
      HelpContext = 1298024
      Margins.Top = 15
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      Visible = False
      object shpResize: TShape
        Left = -4
        Top = -14
        Width = 104
        Height = 59
        HelpContext = 1298025
        Brush.Style = bsClear
        Pen.Color = 9079551
      end
      object Label3: TLabel
        AlignWithMargins = True
        Left = 35
        Top = 4
        Width = 38
        Height = 24
        HelpContext = 1298026
        Align = alClient
        Caption = 'Resize'
        Transparent = True
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object btnDecHeight: TDNMSpeedButton
        AlignWithMargins = True
        Left = 79
        Top = 4
        Width = 25
        Height = 24
        Hint = 'Decrease'
        HelpContext = 1298027
        Align = alRight
        DisableTransparent = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
          333333777777777F33333330B00000003333337F7777777F3333333000000000
          333333777777777F333333330EEEEEE033333337FFFFFF7F3333333300000000
          333333377777777F3333333330BFBFB03333333373333373F33333330BFBFBFB
          03333337F33333F7F33333330FBFBF0F03333337F33337F7F33333330BFBFB0B
          03333337F3F3F7F7333333330F0F0F0033333337F7F7F773333333330B0B0B03
          3333333737F7F7F333333333300F0F03333333337737F7F33333333333300B03
          333333333377F7F33333333333330F03333333333337F7F33333333333330B03
          3333333333373733333333333333303333333333333373333333}
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnDecHeightClick
      end
      object btnIncHeight: TDNMSpeedButton
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 25
        Height = 24
        Hint = 'Increase'
        HelpContext = 1298028
        Align = alLeft
        DisableTransparent = False
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333033333
          33333333373F33333333333330B03333333333337F7F33333333333330F03333
          333333337F7FF3333333333330B00333333333337F773FF33333333330F0F003
          333333337F7F773F3333333330B0B0B0333333337F7F7F7F3333333300F0F0F0
          333333377F73737F33333330B0BFBFB03333337F7F33337F33333330F0FBFBF0
          3333337F7333337F33333330BFBFBFB033333373F3333373333333330BFBFB03
          33333337FFFFF7FF3333333300000000333333377777777F333333330EEEEEE0
          33333337FFFFFF7FF3333333000000000333333777777777F33333330000000B
          03333337777777F7F33333330000000003333337777777773333}
        HotTrackFont.Charset = DEFAULT_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -11
        HotTrackFont.Name = 'MS Sans Serif'
        HotTrackFont.Style = []
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnIncHeightClick
      end
    end
    object pnlMonths: TDNMPanel
      AlignWithMargins = True
      Left = 292
      Top = 16
      Width = 127
      Height = 32
      HelpContext = 1298029
      Margins.Top = 15
      Align = alRight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      object shpMonths: TShape
        Left = -3
        Top = -2
        Width = 130
        Height = 29
        HelpContext = 1298030
        Brush.Style = bsClear
        Pen.Color = 9079551
      end
      object Label1: TLabel
        AlignWithMargins = True
        Left = 4
        Top = 4
        Width = 74
        Height = 24
        HelpContext = 1298031
        Align = alLeft
        Caption = 'No of Months'
        Layout = tlCenter
        ExplicitHeight = 15
      end
      object edtMonths: TSpinEdit
        Left = 86
        Top = 4
        Width = 36
        Height = 24
        HelpContext = 1298032
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        MaxValue = 6
        MinValue = 1
        ParentFont = False
        TabOrder = 0
        Value = 1
        OnChange = edtMonthsChange
      end
    end
  end
  object DNMPanel2: TDNMPanel [8]
    Left = 0
    Top = 450
    Width = 1015
    Height = 82
    HelpContext = 1298033
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      1015
      82)
    object btnSave: TDNMSpeedButton
      Left = 137
      Top = 43
      Width = 87
      Height = 27
      HelpContext = 1298034
      Anchors = []
      Caption = 'Save'
      Default = True
      DisableTransparent = False
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
      TabOrder = 0
      OnClick = btnSaveClick
    end
    object btnPrint: TDNMSpeedButton
      Left = 682
      Top = 43
      Width = 87
      Height = 27
      HelpContext = 1298035
      Anchors = []
      Caption = 'Prin&t'
      DisableTransparent = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
        0003377777777777777308888888888888807F33333333333337088888888888
        88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
        8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
        8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
        03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
        03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
        33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
        33333337FFFF7733333333300000033333333337777773333333}
      HotTrackFont.Charset = ANSI_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = [fsBold]
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnPrintClick
    end
    object btnCancel: TDNMSpeedButton
      Left = 791
      Top = 43
      Width = 87
      Height = 27
      HelpContext = 1298036
      Anchors = []
      Cancel = True
      Caption = '&Cancel'
      DisableTransparent = False
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
      TabOrder = 2
      OnClick = btnCancelClick
    end
    object btnDay: TDNMSpeedButton
      Left = 355
      Top = 43
      Width = 87
      Height = 27
      Hint = 'Open the Main Calendar in Day Mode'
      HelpContext = 1298037
      Anchors = [akBottom]
      Caption = 'Day'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnDayClick
    end
    object btnWeek: TDNMSpeedButton
      Left = 464
      Top = 43
      Width = 87
      Height = 27
      Hint = 'Open the Main Calendar in Week Mode'
      HelpContext = 1298038
      Anchors = [akBottom]
      Caption = 'Week'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = btnDayClick
    end
    object btnMonth: TDNMSpeedButton
      Left = 573
      Top = 43
      Width = 87
      Height = 27
      Hint = 'Open the Main Calendar in Month Mode'
      HelpContext = 1298039
      Anchors = [akBottom]
      Caption = 'Month'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = btnDayClick
    end
    object pnlhints: TPanel
      Left = 53
      Top = 4
      Width = 907
      Height = 29
      HelpContext = 1298040
      Anchors = []
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentColor = True
      ParentFont = False
      TabOrder = 6
      object Shader2: TShader
        AlignWithMargins = True
        Left = 1
        Top = 0
        Width = 127
        Height = 29
        HelpContext = 1298041
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        FromColor = 6467839
        ToColor = 6467839
        FromColorMirror = 6467839
        ToColorMirror = 6467839
        Steps = 10
        Direction = True
        Version = '1.4.0.0'
        object pnlAptcolor: TLabel
          AlignWithMargins = True
          Left = 2
          Top = 2
          Width = 123
          Height = 25
          HelpContext = 1298042
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Alignment = taCenter
          Caption = 'Appointment'
          Color = clGreen
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          Layout = tlCenter
          ExplicitWidth = 72
          ExplicitHeight = 15
        end
      end
      object Shader3: TShader
        AlignWithMargins = True
        Left = 775
        Top = 0
        Width = 127
        Height = 29
        HelpContext = 1298043
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alLeft
        BevelOuter = bvNone
        BorderWidth = 1
        Color = clWhite
        ParentBackground = False
        TabOrder = 1
        FromColor = 6467839
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = 6467839
        Steps = 10
        Direction = True
        Version = '1.4.0.0'
        object pnlWeekend: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 121
          Height = 23
          HelpContext = 1298044
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Alignment = taCenter
          Caption = 'Weekend'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          Layout = tlCenter
          ExplicitWidth = 54
          ExplicitHeight = 15
        end
      end
      object Shader4: TShader
        AlignWithMargins = True
        Left = 388
        Top = 0
        Width = 127
        Height = 29
        HelpContext = 1298045
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 2
        FromColor = 6467839
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = 6467839
        Steps = 10
        Direction = True
        Version = '1.4.0.0'
        object pnlLeave: TLabel
          AlignWithMargins = True
          Left = 2
          Top = 2
          Width = 123
          Height = 25
          HelpContext = 1298046
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Alignment = taCenter
          Caption = 'Not Available'
          Color = clPurple
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          Layout = tlCenter
          ExplicitWidth = 73
          ExplicitHeight = 15
        end
      end
      object Shader5: TShader
        AlignWithMargins = True
        Left = 259
        Top = 0
        Width = 127
        Height = 29
        HelpContext = 1298047
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 3
        FromColor = 6467839
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = 6467839
        Steps = 10
        Direction = True
        Version = '1.4.0.0'
        object pnlHoliday: TLabel
          AlignWithMargins = True
          Left = 2
          Top = 2
          Width = 123
          Height = 25
          HelpContext = 1298048
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Alignment = taCenter
          Caption = 'Public Holiday'
          Color = clGray
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          Layout = tlCenter
          ExplicitWidth = 79
          ExplicitHeight = 15
        end
      end
      object Shader6: TShader
        AlignWithMargins = True
        Left = 130
        Top = 0
        Width = 127
        Height = 29
        HelpContext = 1298049
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 4
        FromColor = 6467839
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = 6467839
        Steps = 10
        Direction = True
        Version = '1.4.0.0'
        object pnlGrpAptcolor: TLabel
          AlignWithMargins = True
          Left = 2
          Top = 2
          Width = 123
          Height = 25
          HelpContext = 1298050
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Alignment = taCenter
          Caption = 'Group Appointment'
          Color = 47360
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          Layout = tlCenter
          ExplicitWidth = 109
          ExplicitHeight = 15
        end
      end
      object Shader1: TShader
        AlignWithMargins = True
        Left = 517
        Top = 0
        Width = 127
        Height = 29
        HelpContext = 1298051
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 5
        FromColor = 6467839
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = 6467839
        Steps = 10
        Direction = True
        Version = '1.4.0.0'
        object pnlSelected: TLabel
          AlignWithMargins = True
          Left = 2
          Top = 2
          Width = 123
          Height = 25
          HelpContext = 1298052
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Alignment = taCenter
          Caption = 'Selected'
          Color = clYellow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          Layout = tlCenter
          ExplicitWidth = 50
          ExplicitHeight = 15
        end
      end
      object Shader7: TShader
        AlignWithMargins = True
        Left = 646
        Top = 0
        Width = 127
        Height = 29
        HelpContext = 1298053
        Margins.Left = 1
        Margins.Top = 0
        Margins.Right = 1
        Margins.Bottom = 0
        Align = alLeft
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 6
        FromColor = 6467839
        ToColor = clWhite
        FromColorMirror = clWhite
        ToColorMirror = 6467839
        Steps = 10
        Direction = True
        Version = '1.4.0.0'
        object pnltoday: TLabel
          AlignWithMargins = True
          Left = 2
          Top = 2
          Width = 123
          Height = 25
          HelpContext = 1298054
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          Alignment = taCenter
          Caption = 'Today'
          Color = 12698111
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          Transparent = False
          Layout = tlCenter
          ExplicitWidth = 33
          ExplicitHeight = 15
        end
      end
    end
    object btnRequery: TDNMSpeedButton
      Left = 246
      Top = 43
      Width = 87
      Height = 27
      HelpContext = 1298055
      Anchors = []
      Caption = 'Refresh'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
        333333333337FF3333333333330003333333333333777F333333333333080333
        3333333F33777FF33F3333B33B000B33B3333373F777773F7333333BBB0B0BBB
        33333337737F7F77F333333BBB0F0BBB33333337337373F73F3333BBB0F7F0BB
        B333337F3737F73F7F3333BB0FB7BF0BB3333F737F37F37F73FFBBBB0BF7FB0B
        BBB3773F7F37337F377333BB0FBFBF0BB333337F73F333737F3333BBB0FBF0BB
        B3333373F73FF7337333333BBB000BBB33333337FF777337F333333BBBBBBBBB
        3333333773FF3F773F3333B33BBBBB33B33333733773773373333333333B3333
        333333333337F33333333333333B333333333333333733333333}
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 7
      OnClick = btnRequeryClick
    end
  end
  object Scrollbox: TScrollBox [9]
    Left = 0
    Top = 52
    Width = 828
    Height = 383
    HelpContext = 1298056
    HorzScrollBar.Visible = False
    Align = alClient
    BorderStyle = bsNone
    TabOrder = 2
  end
  object Memo1: TMemo [10]
    Left = 830
    Top = 52
    Width = 185
    Height = 383
    HelpContext = 1298057
    Align = alRight
    TabOrder = 3
    WordWrap = False
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102003C01400110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  object qryClasses: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      'SELECT * FROM tblclass')
    Left = 154
    Top = 216
    object qryClassesClassID: TIntegerField
      FieldName = 'ClassID'
    end
    object qryClassesClassName: TWideStringField
      FieldName = 'ClassName'
      Size = 60
    end
  end
  object qryEmployees: TERPQuery
    Connection = MyConnection
    SQL.Strings = (
      
        'SELECT employeeId, employeeName FROM tblemployees where active =' +
        '"T" and onPMRoster ="T" order by DateStarted , employeeName')
    Left = 118
    Top = 216
    object qryEmployeesemployeeId: TIntegerField
      FieldName = 'employeeId'
    end
    object qryEmployeesemployeeName: TWideStringField
      FieldName = 'employeeName'
      Size = 255
    end
  end
end
