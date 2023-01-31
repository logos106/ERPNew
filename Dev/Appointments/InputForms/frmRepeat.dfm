inherited RepeatFrm: TRepeatFrm
  Left = -1002
  Top = 220
  HelpContext = 469000
  Caption = 'Repeat'
  ClientHeight = 369
  ClientWidth = 710
  Font.Charset = DEFAULT_CHARSET
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ExplicitLeft = -1002
  ExplicitTop = 220
  ExplicitWidth = 726
  ExplicitHeight = 408
  DesignSize = (
    710
    369)
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 43
    Width = 710
    HelpContext = 469037
    ExplicitTop = 342
    ExplicitWidth = 710
  end
  inherited imgGridWatermark: TImage
    HelpContext = 469001
  end
  object pnlMain: TDNMPanel [5]
    Left = 0
    Top = 43
    Width = 710
    Height = 326
    HelpContext = 469038
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object Label1: TLabel
      Left = 513
      Top = 3
      Width = 58
      Height = 15
      HelpContext = 469002
      Caption = 'Base Date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblFinalDate: TLabel
      Left = 513
      Top = 236
      Width = 55
      Height = 15
      HelpContext = 469003
      Caption = 'Final Date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
    object lblMsg: TLabel
      Left = 1
      Top = 312
      Width = 708
      Height = 13
      HelpContext = 469039
      Align = alBottom
      Alignment = taCenter
      Caption = 'lblMsg'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
      Visible = False
      WordWrap = True
      ExplicitWidth = 37
    end
    object lbDates: TListBox
      Left = 512
      Top = 42
      Width = 189
      Height = 169
      HelpContext = 469007
      TabStop = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ItemHeight = 14
      ParentFont = False
      TabOrder = 0
    end
    object Panel1: TPanel
      Left = 8
      Top = 18
      Width = 497
      Height = 137
      HelpContext = 469008
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Caption = 'Panel1'
      Color = clWhite
      TabOrder = 1
      object rgFrequency: TRadioGroup
        Left = 5
        Top = 2
        Width = 489
        Height = 133
        HelpContext = 469009
        Caption = 'Frequency '
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Items.Strings = (
          'Day'
          'Weekly'
          'Monthly')
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        TabStop = True
        OnClick = rbGroupClick
      end
      object pnlDay: TPanel
        Left = 88
        Top = 16
        Width = 401
        Height = 33
        HelpContext = 469010
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = clWhite
        TabOrder = 1
        TabStop = True
        Visible = False
        object Label3: TLabel
          Left = 7
          Top = 8
          Width = 31
          Height = 15
          HelpContext = 469011
          Caption = 'Every'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label4: TLabel
          Left = 95
          Top = 8
          Width = 36
          Height = 15
          HelpContext = 469012
          Caption = 'Day(s)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object seDayDays: TSpinEdit
          Left = 48
          Top = 6
          Width = 41
          Height = 24
          HelpContext = 469013
          MaxValue = 365
          MinValue = 1
          TabOrder = 0
          Value = 1
          OnChange = seDayChange
        end
      end
      object pnlWeekDay: TPanel
        Left = 88
        Top = 56
        Width = 401
        Height = 33
        HelpContext = 469014
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = clWhite
        TabOrder = 2
        TabStop = True
        Visible = False
        object Label5: TLabel
          Left = 7
          Top = 8
          Width = 31
          Height = 15
          HelpContext = 469015
          Caption = 'Every'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label6: TLabel
          Left = 95
          Top = 8
          Width = 65
          Height = 15
          HelpContext = 469016
          Caption = 'Week(s) on'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object seWeekDays: TSpinEdit
          Left = 48
          Top = 6
          Width = 41
          Height = 24
          HelpContext = 469017
          MaxValue = 365
          MinValue = 1
          TabOrder = 0
          Value = 1
          OnChange = seDayChange
        end
        object cbWeekday: TComboBox
          Left = 164
          Top = 6
          Width = 97
          Height = 23
          HelpContext = 469018
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = 'Monday'
          OnChange = seDayChange
          Items.Strings = (
            'Sunday'
            'Monday'
            'Tuesday'
            'Wednesday'
            'Thursday'
            'Friday'
            'Saturday')
        end
      end
      object pnlMonth: TPanel
        Left = 88
        Top = 96
        Width = 401
        Height = 33
        HelpContext = 469019
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = clWhite
        TabOrder = 3
        TabStop = True
        Visible = False
        object Label7: TLabel
          Left = 7
          Top = 7
          Width = 31
          Height = 15
          HelpContext = 469020
          Caption = 'Every'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label8: TLabel
          Left = 95
          Top = 7
          Width = 64
          Height = 15
          HelpContext = 469021
          Caption = 'Month(s) at'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object Label9: TLabel
          Left = 361
          Top = 7
          Width = 36
          Height = 15
          HelpContext = 469022
          Caption = 'Day(s)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
        end
        object seMonthMonths: TSpinEdit
          Left = 48
          Top = 5
          Width = 41
          Height = 24
          HelpContext = 469023
          MaxValue = 12
          MinValue = 1
          TabOrder = 0
          Value = 1
          OnChange = seDayChange
        end
        object cbMonthBeginEnd: TComboBox
          Left = 164
          Top = 5
          Width = 145
          Height = 23
          HelpContext = 469024
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          ItemIndex = 0
          ParentFont = False
          TabOrder = 1
          Text = 'Begin of Month plus'
          OnChange = seDayChange
          Items.Strings = (
            'Begin of Month plus'
            'End of Month minus')
        end
        object seMonthDays: TSpinEdit
          Left = 315
          Top = -1
          Width = 41
          Height = 24
          HelpContext = 469025
          MaxValue = 27
          MinValue = 0
          TabOrder = 2
          Value = 1
          OnChange = seDayChange
        end
      end
    end
    object Panel2: TPanel
      Left = 8
      Top = 159
      Width = 396
      Height = 35
      HelpContext = 469026
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Caption = 'Panel2'
      Color = clWhite
      TabOrder = 2
      object rgSaturday: TRadioGroup
        Left = 5
        Top = 2
        Width = 385
        Height = 31
        HelpContext = 469027
        Caption = 'If Day is Saturday'
        Color = clWhite
        Columns = 4
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ItemIndex = 0
        Items.Strings = (
          'Post'
          'Drop'
          'Shift After'
          'Shift Before')
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        OnClick = rbGroupClick
      end
    end
    object Panel3: TPanel
      Left = 8
      Top = 196
      Width = 396
      Height = 35
      HelpContext = 469028
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Caption = 'Panel3'
      Color = clWhite
      TabOrder = 3
      object rgSunday: TRadioGroup
        Left = 5
        Top = 2
        Width = 385
        Height = 31
        HelpContext = 469029
        Caption = 'If Day is Sunday'
        Color = clWhite
        Columns = 4
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ItemIndex = 0
        Items.Strings = (
          'Post'
          'Drop'
          'Shift After'
          'Shift Before')
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        OnClick = rbGroupClick
      end
    end
    object Panel4: TPanel
      Left = 8
      Top = 233
      Width = 396
      Height = 35
      HelpContext = 469030
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Caption = 'Panel3'
      Color = clWhite
      TabOrder = 4
      object rgHoliday: TRadioGroup
        Left = 5
        Top = 2
        Width = 385
        Height = 31
        HelpContext = 469031
        Caption = 'If Day is Holiday'
        Color = clWhite
        Columns = 4
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ItemIndex = 0
        Items.Strings = (
          'Post'
          'Drop'
          'Shift After'
          'Shift Before')
        ParentColor = False
        ParentFont = False
        TabOrder = 0
        OnClick = rbGroupClick
      end
    end
    object dtBaseDate: TDateTimePicker
      Left = 512
      Top = 18
      Width = 189
      Height = 22
      HelpContext = 469005
      Date = 37497.417524456000000000
      Time = 37497.417524456000000000
      DateFormat = dfLong
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnChange = seDayChange
    end
    object dtFinalDate: TDateTimePicker
      Left = 512
      Top = 213
      Width = 189
      Height = 22
      HelpContext = 469006
      Date = 37497.417524456000000000
      Time = 37497.417524456000000000
      DateFormat = dfLong
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 6
      OnChange = seDayChange
    end
    object bbOK: TDNMSpeedButton
      Left = 143
      Top = 280
      Width = 87
      Height = 27
      HelpContext = 469033
      Caption = 'O&K'
      Default = True
      DisableTransparent = False
      Enabled = False
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 7
      AutoDisableParentOnclick = True
      OnClick = bbOKClick
    end
    object btnHoliday: TDNMSpeedButton
      Left = 311
      Top = 280
      Width = 87
      Height = 27
      HelpContext = 469032
      Caption = '&Holidays'
      Default = True
      DisableTransparent = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 8
      AutoDisableParentOnclick = True
      OnClick = btnHolidayClick
    end
    object bbCancel: TDNMSpeedButton
      Left = 479
      Top = 280
      Width = 87
      Height = 27
      HelpContext = 469004
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      Kind = bkCancel
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 9
      AutoDisableParentOnclick = True
    end
  end
  object pnlTitle: TDNMPanel [6]
    Left = 160
    Top = 1
    Width = 362
    Height = 36
    HelpContext = 469034
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
      Width = 358
      Height = 32
      HelpContext = 469035
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
        Width = 358
        Height = 32
        HelpContext = 469036
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Repeat'
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
  inherited MyConnection: TERPConnection
    Left = 112
  end
  inherited DataState: TDataState
    Left = 136
    Top = 0
  end
  inherited imgsort: TImageList
    Bitmap = {
      494C010102005400680010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
  inherited QryCustomField: TERPQuery
    Left = 82
    Top = 8
  end
  inherited mnuBusobjProperties: TAdvPopupMenu
    Left = 112
    Top = 8
  end
  object qry: TERPQuery
    Connection = MyConnection
    Left = 184
    Top = 8
  end
end
