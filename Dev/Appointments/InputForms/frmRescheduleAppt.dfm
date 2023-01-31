inherited fmRescheduleAppt: TfmRescheduleAppt
  Left = 538
  Top = 150
  HelpContext = 207000
  Caption = 'Reschedule Appointments'
  ClientHeight = 301
  ClientWidth = 415
  Color = 14609623
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 15
  inherited imgGridWatermark: TImage
    HelpContext = 207001
  end
  object Panel3: TPanel [1]
    Left = 27
    Top = 130
    Width = 361
    Height = 35
    HelpContext = 207002
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Caption = 'Panel3'
    Color = clWhite
    TabOrder = 1
    object rgSunday: TRadioGroup
      Left = 2
      Top = 2
      Width = 357
      Height = 31
      HelpContext = 207003
      Align = alClient
      Caption = 'If Day is Sunday'
      Color = clWhite
      Columns = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
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
    end
  end
  object Panel4: TPanel [2]
    Left = 27
    Top = 196
    Width = 361
    Height = 35
    HelpContext = 207004
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Caption = 'Panel3'
    Color = clWhite
    TabOrder = 2
    object rgHoliday: TRadioGroup
      Left = 2
      Top = 2
      Width = 357
      Height = 31
      HelpContext = 207005
      Align = alClient
      Caption = 'If Day is Holiday'
      Color = clWhite
      Columns = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
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
    end
  end
  object bbOK: TDNMSpeedButton [3]
    Left = 163
    Top = 254
    Width = 87
    Height = 27
    HelpContext = 207006
    Anchors = [akLeft, akTop, akRight]
    Caption = '&OK'
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
    NumGlyphs = 2
    TabOrder = 3
    OnClick = bbOKClick
  end
  object Panel2: TPanel [4]
    Left = 27
    Top = 65
    Width = 361
    Height = 35
    HelpContext = 207007
    Anchors = [akLeft, akTop, akRight]
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Caption = 'Panel2'
    Color = clWhite
    TabOrder = 0
    object rgSaturday: TRadioGroup
      Left = 2
      Top = 2
      Width = 357
      Height = 31
      HelpContext = 207008
      Align = alClient
      Caption = 'If Day is Saturday'
      Color = clWhite
      Columns = 4
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
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
    end
  end
  object pnlTitle: TDNMPanel [5]
    Left = 16
    Top = 6
    Width = 384
    Height = 45
    HelpContext = 207009
    BevelInner = bvRaised
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    object TitleShader: TShader
      Left = 2
      Top = 2
      Width = 380
      Height = 41
      HelpContext = 207010
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
        Width = 380
        Height = 41
        HelpContext = 207011
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Reschedule Appointments'
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
  inherited ApplicationEvents1: TApplicationEvents
    Left = 248
    Top = 335
  end
  inherited dlgReportSelect: TSelectionDialog
    Left = 184
    Top = 335
  end
  inherited MyConnection: TERPConnection
    Left = 280
    Top = 334
  end
  inherited DataState: TDataState
    Left = 152
    Top = 335
  end
end
