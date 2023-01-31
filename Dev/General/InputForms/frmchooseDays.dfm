inherited fmchooseDays: TfmchooseDays
  HelpContext = 1370002
  BorderStyle = bsNone
  Caption = 'Choose Days'
  ClientHeight = 320
  ClientWidth = 305
  Position = poOwnerFormCenter
  ExplicitWidth = 313
  ExplicitHeight = 347
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 320
    Width = 305
    ExplicitTop = 306
    ExplicitWidth = 305
    HelpContext = 1370017
  end
  object Shp: TShape [3]
    Left = 0
    Top = 0
    Width = 305
    Height = 319
    HelpContext = 1370003
    Anchors = [akLeft, akTop, akRight, akBottom]
    Brush.Style = bsClear
    Pen.Color = clNavy
    Pen.Width = 3
    ExplicitWidth = 299
    ExplicitHeight = 305
  end
  object DNMPanel3: TDNMPanel [4]
    AlignWithMargins = True
    Left = 6
    Top = 262
    Width = 293
    Height = 52
    HelpContext = 1370004
    Margins.Left = 6
    Margins.Top = 0
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      293
      52)
    object cmdClose: TDNMSpeedButton
      Left = 43
      Top = 12
      Width = 93
      Height = 29
      HelpContext = 1370005
      Anchors = [akBottom]
      Caption = 'Ok'
      Default = True
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 1
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
    end
    object cmdCancel: TDNMSpeedButton
      Left = 156
      Top = 12
      Width = 93
      Height = 29
      HelpContext = 1370006
      Anchors = [akBottom]
      Cancel = True
      Caption = 'Cancel'
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
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -12
      HotTrackFont.Name = 'Arial'
      HotTrackFont.Style = []
      ModalResult = 2
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 1
    end
  end
  object chkSunday: TCheckBox [5]
    AlignWithMargins = True
    Left = 44
    Top = 45
    Width = 255
    Height = 31
    HelpContext = 1370007
    Margins.Left = 44
    Margins.Top = 0
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Sunday'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object chkSaturday: TCheckBox [6]
    AlignWithMargins = True
    Left = 44
    Top = 231
    Width = 255
    Height = 31
    HelpContext = 1370008
    Margins.Left = 44
    Margins.Top = 0
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Saturday'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object chkFriday: TCheckBox [7]
    AlignWithMargins = True
    Left = 44
    Top = 200
    Width = 255
    Height = 31
    HelpContext = 1370009
    Margins.Left = 44
    Margins.Top = 0
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Friday'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object chkthursday: TCheckBox [8]
    AlignWithMargins = True
    Left = 44
    Top = 169
    Width = 255
    Height = 31
    HelpContext = 1370010
    Margins.Left = 44
    Margins.Top = 0
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Thursday'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object chkWednesday: TCheckBox [9]
    AlignWithMargins = True
    Left = 44
    Top = 138
    Width = 255
    Height = 31
    HelpContext = 1370011
    Margins.Left = 44
    Margins.Top = 0
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Wednesday'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object chktuesday: TCheckBox [10]
    AlignWithMargins = True
    Left = 44
    Top = 107
    Width = 255
    Height = 31
    HelpContext = 1370012
    Margins.Left = 44
    Margins.Top = 0
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Tuesday'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object chkMonday: TCheckBox [11]
    AlignWithMargins = True
    Left = 44
    Top = 76
    Width = 255
    Height = 31
    HelpContext = 1370013
    Margins.Left = 44
    Margins.Top = 0
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alTop
    Caption = 'Monday'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object pnlTitle: TDNMPanel [12]
    AlignWithMargins = True
    Left = 6
    Top = 6
    Width = 293
    Height = 39
    HelpContext = 1370014
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -29
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    Locked = True
    ParentFont = False
    TabOrder = 8
    object TitleShader: TShader
      Left = 1
      Top = 1
      Width = 291
      Height = 37
      HelpContext = 1370015
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
        Height = 37
        HelpContext = 1370016
        Align = alClient
        Alignment = taCenter
        AutoSize = False
        Caption = 'Choose Days'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        ExplicitTop = 6
        ExplicitWidth = 897
      end
    end
  end
  inherited tmrProcessMessage: TTimer
    Left = 217
    Top = 91
  end
  inherited tmrdelay: TTimer
    Left = 192
    Top = 88
  end
  inherited popSpelling: TPopupMenu
    Left = 144
    Top = 72
  end
end
