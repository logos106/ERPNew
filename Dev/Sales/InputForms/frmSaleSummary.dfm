inherited fmSaleSummary: TfmSaleSummary
  BorderStyle = bsDialog
  Caption = 'Sales Summary'
  ClientHeight = 563
  ClientWidth = 409
  ExplicitWidth = 425
  ExplicitHeight = 602
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1666002
  inherited lblSkingroupMsg: TLabel
    Top = 523
    Width = 409
    ExplicitTop = 494
    ExplicitWidth = 409
    HelpContext = 1666003
  end
  object DNMPanel1: TDNMPanel [4]
    Left = 0
    Top = 0
    Width = 409
    Height = 71
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    DesignSize = (
      409
      71)
    HelpContext = 1666004
    object pnlHeader: TPanel
      Left = 46
      Top = 12
      Width = 318
      Height = 47
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -35
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      HelpContext = 1666005
      object TitleShader: TShader
        Left = 1
        Top = 1
        Width = 316
        Height = 45
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
        HelpContext = 1666006
        object TitleLabel: TLabel
          Left = 0
          Top = 0
          Width = 316
          Height = 45
          Align = alClient
          Alignment = taCenter
          AutoSize = False
          Caption = 'Sales Summary'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -35
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          Transparent = True
          Layout = tlCenter
          ExplicitTop = 7
          ExplicitWidth = 327
          ExplicitHeight = 47
          HelpContext = 1666007
        end
      end
    end
  end
  object DNMPanel2: TDNMPanel [5]
    Left = 0
    Top = 523
    Width = 409
    Height = 40
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      409
      40)
    HelpContext = 1666008
    object cmdClose: TDNMSpeedButton
      Left = 161
      Top = 7
      Width = 87
      Height = 27
      Hint = '"Close The List"'
      Anchors = [akBottom]
      Caption = '&Close'
      DisableTransparent = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'MS Sans Serif'
      HotTrackFont.Style = []
      ModalResult = 1
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      TabStop = False
      AutoDisableParentOnclick = True
      OnClick = cmdCloseClick
      HelpContext = 1666009
    end
  end
  object pnlMain: TDNMPanel [6]
    Left = 0
    Top = 71
    Width = 409
    Height = 452
    Align = alClient
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    HelpContext = 1666010
    object shp1: TShape
      AlignWithMargins = True
      Left = 0
      Top = 115
      Width = 409
      Height = 1
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alTop
      Pen.Color = clGray
      ExplicitLeft = -9
      ExplicitTop = 94
      ExplicitWidth = 407
      HelpContext = 1666011
    end
    object shp2: TShape
      AlignWithMargins = True
      Left = 0
      Top = 186
      Width = 409
      Height = 1
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alTop
      Pen.Color = clGray
      ExplicitLeft = 2
      ExplicitTop = 158
      ExplicitWidth = 407
      HelpContext = 1666012
    end
    object shp3: TShape
      AlignWithMargins = True
      Left = 0
      Top = 257
      Width = 409
      Height = 1
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alTop
      Pen.Color = clGray
      ExplicitLeft = 2
      ExplicitTop = 219
      ExplicitWidth = 407
      HelpContext = 1666013
    end
    object pnl_2: TDNMPanel
      Left = 0
      Top = 0
      Width = 409
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
      Transparent = False
      HelpContext = 1666014
      object lbl_2_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 23
        HelpContext = 1666015
      end
      object lbl_2_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666016
      end
      object lbl_2_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666017
      end
    end
    object pnl_4: TDNMPanel
      Left = 0
      Top = 23
      Width = 409
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 1
      Transparent = False
      HelpContext = 1666018
      object lbl_4_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666019
      end
      object lbl_4_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666020
      end
      object lbl_4_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666021
      end
    end
    object pnl_6: TDNMPanel
      Left = 0
      Top = 46
      Width = 409
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 2
      Transparent = False
      HelpContext = 1666022
      object lbl_6_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666023
      end
      object lbl_6_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666024
      end
      object lbl_6_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666025
      end
    end
    object pnl_8: TDNMPanel
      Left = 0
      Top = 69
      Width = 409
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 3
      Transparent = False
      HelpContext = 1666026
      object lbl_8_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666027
      end
      object lbl_8_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666028
      end
      object lbl_8_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666029
      end
    end
    object pnl_10: TDNMPanel
      Left = 0
      Top = 92
      Width = 409
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 4
      Transparent = False
      HelpContext = 1666030
      object lbl_10_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666031
      end
      object lbl_10_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666032
      end
      object lbl_10_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = True
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666033
      end
    end
    object pnl_12: TDNMPanel
      Left = 0
      Top = 117
      Width = 409
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 5
      Transparent = False
      HelpContext = 1666034
      object lbl_12_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666035
      end
      object lbl_12_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666036
      end
      object lbl_12_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666037
      end
    end
    object pnl_14: TDNMPanel
      Left = 0
      Top = 140
      Width = 409
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 6
      Transparent = False
      HelpContext = 1666038
      object lbl_14_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666039
      end
      object lbl_14_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666040
      end
      object lbl_14_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666041
      end
    end
    object pnl_16: TDNMPanel
      Left = 0
      Top = 163
      Width = 409
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 7
      Transparent = False
      HelpContext = 1666042
      object lbl_16_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666043
      end
      object lbl_16_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666044
      end
      object lbl_16_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666045
      end
    end
    object pnl_18: TDNMPanel
      Left = 0
      Top = 188
      Width = 409
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 8
      Transparent = False
      HelpContext = 1666046
      object lbl_18_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666047
      end
      object lbl_18_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666048
      end
      object lbl_18_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666049
      end
    end
    object pnl_20: TDNMPanel
      Left = 0
      Top = 211
      Width = 409
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 9
      Transparent = False
      HelpContext = 1666050
      object lbl_20_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666051
      end
      object lbl_20_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666052
      end
      object lbl_20_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666053
      end
    end
    object pnl_22: TDNMPanel
      Left = 0
      Top = 234
      Width = 409
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 10
      Transparent = False
      HelpContext = 1666054
      object lbl_22_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666055
      end
      object lbl_22_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666056
      end
      object lbl_22_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666057
      end
    end
    object pnl_24: TDNMPanel
      Left = 0
      Top = 259
      Width = 409
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 11
      Transparent = False
      HelpContext = 1666058
      object lbl_24_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666059
      end
      object lbl_24_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666060
      end
      object lbl_24_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666061
      end
    end
    object pnl_26: TDNMPanel
      Left = 0
      Top = 282
      Width = 409
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 12
      Transparent = False
      HelpContext = 1666062
      object lbl_26_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666063
      end
      object lbl_26_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666064
      end
      object lbl_26_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666065
      end
    end
    object pnl_28: TDNMPanel
      Left = 0
      Top = 305
      Width = 409
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 13
      Transparent = False
      HelpContext = 1666066
      object lbl_28_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666067
      end
      object lbl_28_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666068
      end
      object lbl_28_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666069
      end
    end
    object pnl_30: TDNMPanel
      Left = 0
      Top = 328
      Width = 409
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 14
      Transparent = False
      HelpContext = 1666070
      object lbl_30_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666071
      end
      object lbl_30_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666072
      end
      object lbl_30_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666073
      end
    end
    object pnl_32: TDNMPanel
      Left = 0
      Top = 351
      Width = 409
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 15
      Transparent = False
      HelpContext = 1666074
      object lbl_32_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666075
      end
      object lbl_32_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666076
      end
      object lbl_32_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666077
      end
    end
    object pnl_34: TDNMPanel
      Left = 0
      Top = 376
      Width = 409
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 16
      Transparent = False
      HelpContext = 1666078
      object lbl_34_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666079
      end
      object lbl_34_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666080
      end
      object lbl_34_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666081
      end
    end
    object pnl_36: TDNMPanel
      Left = 0
      Top = 399
      Width = 409
      Height = 23
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 17
      Transparent = False
      HelpContext = 1666082
      object lbl_36_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666083
      end
      object lbl_36_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666084
      end
      object lbl_36_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 22
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666085
      end
    end
    object pnl_38: TDNMPanel
      Left = 0
      Top = 422
      Width = 409
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 18
      Transparent = False
      HelpContext = 1666086
      object lbl_38_del: TLabel
        AlignWithMargins = True
        Left = 280
        Top = 0
        Width = 15
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taCenter
        AutoSize = False
        Caption = ' : '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitHeight = 15
        HelpContext = 1666087
      end
      object lbl_38_caption: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 280
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 1
        Align = alLeft
        Alignment = taRightJustify
        AutoSize = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = False
        Layout = tlCenter
        ExplicitLeft = -87
        ExplicitHeight = 23
        HelpContext = 1666088
      end
      object lbl_38_data: TEdit
        AlignWithMargins = True
        Left = 295
        Top = 0
        Width = 104
        Height = 24
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 10
        Margins.Bottom = 1
        Align = alClient
        Alignment = taRightJustify
        AutoSize = False
        BevelInner = bvNone
        BevelOuter = bvNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        HelpContext = 1666089
      end
    end
  end
  object dsMain: TDataSource
    DataSet = qryMain
    Left = 94
    Top = 215
  end
  object qryMain: TERPQuery
    SQL.Strings = (
      
        'Select  1 as Category, 2 as seqno , "Entered By" as Description ' +
        ', 1 as FieldType, EnteredBy as StringValue ,  Null        as Dat' +
        'eValue , null         as timeValue , null         as CurrencyVal' +
        'ue, Null        as FloatValue   from tblsales where saleId = '#39'26' +
        #39'  union all'
      
        'Select  1 as Category, 4 as seqno , "Entered At" as Description ' +
        ', 1 as FieldType, EnteredAt as StringValue ,  Null        as Dat' +
        'eValue , null         as timeValue , null         as CurrencyVal' +
        'ue, Null        as FloatValue     from tblsales where saleId = '#39 +
        '26'#39'  union all'
      
        'Select * from (Select  1 as Category, 6 as seqno , "Printed By" ' +
        'as Description , 1 as FieldType, E.Employeename as StringValue ,' +
        '  PD.PrintDate        as DateValue , null         as timeValue ,' +
        ' null         as CurrencyValue, Null        as FloatValue      f' +
        'rom tblsales S inner join tblprintdocs PD on PD.docname ='#39'TInvoi' +
        'ce'#39' and PD.docid = S.saleId inner join tblemployees E on E.Emplo' +
        'yeeID = PD.PrintedBy where saleId = '#39'26'#39'  Order by DateValue des' +
        'c limit 1) as Details  union all'
      
        'Select * from (Select  1 as Category, 8 as seqno , "Printed On" ' +
        'as Description , 2 as FieldType, null       as StringValue ,  PD' +
        '.PrintDate as DateValue , null         as timeValue , null      ' +
        '   as CurrencyValue, Null        as FloatValue   from tblsales S' +
        ' inner join tblprintdocs PD on PD.docname ='#39'TInvoice'#39' and PD.doc' +
        'id = S.saleId where saleId = '#39'26'#39'  Order by DateValue desc limit' +
        ' 1) as Details  union all'
      
        'Select * from (Select  1 as Category, 10 as seqno , "Printed At"' +
        ' as Description, 3 as FieldType, null       as StringValue ,  nu' +
        'll        as DateValue , PD.PrintDate  as timeValue , null      ' +
        '   as CurrencyValue, Null        as FloatValue  from tblsales S ' +
        'inner join tblprintdocs PD on PD.docname ='#39'TInvoice'#39' and PD.doci' +
        'd = S.saleId where saleId = '#39'26'#39' Order by DateValue desc limit 1' +
        ') as Details  union all'
      
        'Select 2 as Category, 12 as seqno , "Ordered "      as Descripti' +
        'on , 5 as FieldType, null       as StringValue ,  null        as' +
        ' DateValue , null         as timeValue , Null         as Currenc' +
        'yValue, Sum(SL.Qtysold) as FloatValue   from tblsaleslines SL wh' +
        'ere SL.saleId = '#39'26'#39'  union all'
      
        'Select 2 as Category, 14 as seqno , "Shipped "      as Descripti' +
        'on , 5 as FieldType, null       as StringValue ,  null        as' +
        ' DateValue , null         as timeValue , Null         as Currenc' +
        'yValue, Sum(SL.Shipped) as FloatValue   from tblsaleslines SL wh' +
        'ere SL.saleId = '#39'26'#39'  union all'
      
        'Select 2 as Category, 16 as seqno , "Backordered "  as Descripti' +
        'on , 5 as FieldType, null       as StringValue ,  null        as' +
        ' DateValue , null         as timeValue , Null         as Currenc' +
        'yValue, Sum(SL.BackOrder) as FloatValue   from tblsaleslines SL ' +
        'where SL.saleId = '#39'26'#39'  union all'
      
        'Select 2 as Category, 18 as seqno , "Estimate "      as Descript' +
        'ion , 4 as FieldType, null       as StringValue ,  null        a' +
        's DateValue , null         as timeValue , Sum(SL.QtySold * SL.li' +
        'nepriceinc)  as CurrencyValue, Null        as FloatValue   from ' +
        'tblsaleslines SL where SL.saleId = '#39'26'#39'  union all'
      
        'Select 2 as Category, 20 as seqno , "Cost "          as Descript' +
        'ion , 4 as FieldType, null       as StringValue ,  null        a' +
        's DateValue , null         as timeValue , Sum(SL.LineCost * SL.S' +
        'hipped* (1+SL.LineTaxRate))  as CurrencyValue, Null        as Fl' +
        'oatValue   from tblsaleslines SL where SL.saleId = '#39'26'#39'  union a' +
        'll'
      
        'Select 2 as Category, 22 as seqno , "Margin "        as Descript' +
        'ion , 4 as FieldType, null       as StringValue ,  null        a' +
        's DateValue , null         as timeValue , (if(S.IsQuote="T",S.To' +
        'talQuoteAmount, S.totalAmountinc) - Sum(SL.LineCost * SL.Shipped' +
        '* (1+SL.LineTaxRate)))/if(S.IsQuote="T",S.TotalQuoteAmount, S.to' +
        'talAmountinc)  as CurrencyValue, Null        as FloatValue   fro' +
        'm tblsaleslines SL  inner join tblsales S on S.saleId = SL.saleI' +
        'd   where SL.saleId = '#39'26'#39' Union all'
      
        'Select 3 as Category, 24 as Seqno, "Total Product Discount "  De' +
        'scription, 4 as FieldType, null       as StringValue ,  null    ' +
        '    as DateValue , null         as timeValue , 0-S.TotalDiscount' +
        '  as CurrencyValue, Null        as FloatValue   from tblsales S ' +
        'where saleid = '#39'26'#39'  union all '
      
        'Select 3 as Category, 26 as Seqno, '#39'Payment Discount'#39' Descriptio' +
        'n, 4 as FieldType, null       as StringValue ,  null        as D' +
        'ateValue , null         as timeValue , (Sum(ifnull(TotalLineamou' +
        'ntinc,0)))  as CurrencyValue, Null        as FloatValue   from t' +
        'blsaleslines SL where saleid = '#39'26'#39'  and productname = '#39'Payment ' +
        'Discount'#39' union all'
      
        'Select 3 as Category, 28 as Seqno, '#39'Early Payment Discount'#39' Desc' +
        'ription, 4 as FieldType, null       as StringValue ,  null      ' +
        '  as DateValue , null         as timeValue ,  (Sum(ifnull(TotalL' +
        'ineamountinc,0)))  as CurrencyValue, Null        as FloatValue  ' +
        ' from tblsaleslines SL where saleid = '#39'26'#39'  and productname = '#39'E' +
        'arly Payment Discount'#39' union all'
      
        'Select 3 as Category, 30 as Seqno, '#39'Total Sale Discount'#39' Descrip' +
        'tion, 4 as FieldType, null       as StringValue ,  null        a' +
        's DateValue , null         as timeValue , (Sum(ifnull(TotalLinea' +
        'mountinc,0)))  as CurrencyValue, Null        as FloatValue   fro' +
        'm tblsaleslines SL where saleid = '#39'26'#39'  and productname = '#39'Total' +
        ' Sale Discount'#39' union all'
      
        'Select 3 as Category, 32 as Seqno, "Sales Total(Before Discount/' +
        'Markup)" as Description,  4 as FieldType, null       as StringVa' +
        'lue ,  null        as DateValue , null         as timeValue , To' +
        'talamountinc - S.totalmarkup -(0- S.TotalDiscount + ifnull((sele' +
        'ct (Sum(ifnull(TotalLineamountinc,0)))  from tblsaleslines SL wh' +
        'ere Sl.saleid = S.SaleID  and (productname = '#39'Payment Discount'#39' ' +
        ' or productname = '#39'Early Payment Discount'#39' or productname = '#39'Tot' +
        'al Sale Discount'#39' )),0))  as CurrencyValue, Null        as Float' +
        'Value   from tblsales S  where saleid = '#39'26'#39'   union all'
      
        'Select 3 as Category, 34 as Seqno, "Total Product Markup "  Desc' +
        'ription,  4 as FieldType, null       as StringValue ,  null     ' +
        '   as DateValue , null         as timeValue , S.totalmarkup  as ' +
        'CurrencyValue, Null        as FloatValue   from tblsales S where' +
        ' saleid = '#39'26'#39' union all'
      
        'Select 3 as Category, 36 as Seqno, "Total Discount" as Descripti' +
        'on, 4 as FieldType, null       as StringValue ,  null        as ' +
        'DateValue , null         as timeValue , 0- S.TotalDiscount + ifn' +
        'ull((select (Sum(ifnull(TotalLineamountinc,0)))  from tblsalesli' +
        'nes SL where Sl.saleid = S.SaleID  and (productname = '#39'Payment D' +
        'iscount'#39'  or productname = '#39'Early Payment Discount'#39' or productna' +
        'me = '#39'Total Sale Discount'#39' )),0)   as CurrencyValue, Null       ' +
        ' as FloatValue   from tblsales S  where saleid = '#39'26'#39'   union al' +
        'l'
      
        'Select 3 as Category, 38 as Seqno , "Sales Total(After Discount/' +
        'Markup)" as Description , 4 as FieldType, null       as StringVa' +
        'lue ,  null        as DateValue , null         as timeValue , S.' +
        'TotalAmountInc  as CurrencyValue, Null        as FloatValue   fr' +
        'om tblsales S where saleId = '#39'26'#39
      'Order by Category , Seqno')
    FilterOptions = [foCaseInsensitive, foNoPartialCompare]
    OnCalcFields = qryMainCalcFields
    Left = 91
    Top = 248
    object qryMainCategory: TLargeintField
      FieldName = 'Category'
    end
    object qryMainseqno: TLargeintField
      FieldName = 'seqno'
    end
    object qryMainDescription: TWideStringField
      FieldName = 'Description'
      Size = 35
    end
    object qryMainFieldType: TLargeintField
      FieldName = 'FieldType'
    end
    object qryMainStringValue: TWideStringField
      FieldName = 'StringValue'
      Size = 255
    end
    object qryMainDateValue: TDateTimeField
      FieldName = 'DateValue'
    end
    object qryMaintimeValue: TDateTimeField
      FieldName = 'timeValue'
    end
    object qryMainCurrencyValue: TFloatField
      FieldName = 'CurrencyValue'
    end
    object qryMainFloatValue: TFloatField
      FieldName = 'FloatValue'
    end
    object qryMainValue: TWideStringField
      FieldKind = fkCalculated
      FieldName = 'Value'
      Size = 255
      Calculated = True
    end
  end
end
