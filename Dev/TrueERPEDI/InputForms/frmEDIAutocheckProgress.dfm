inherited fmEDIAutocheckProgress: TfmEDIAutocheckProgress
  Left = 133
  Top = 213
  HelpContext = 1638002
  Caption = 'fmEDIAutocheckProgress'
  ClientHeight = 33
  ClientWidth = 295
  ExplicitWidth = 311
  ExplicitHeight = 72
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 33
    Width = 295
    HelpContext = 1638003
    ExplicitTop = 33
    ExplicitWidth = 295
  end
  object pnlRequerytmr: TPanel [4]
    Left = 0
    Top = 0
    Width = 295
    Height = 33
    HelpContext = 1638004
    Align = alClient
    BevelEdges = []
    BevelOuter = bvNone
    BorderWidth = 1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = True
    ParentFont = False
    TabOrder = 0
    DesignSize = (
      295
      33)
    object Shape1: TShape
      Left = 1
      Top = 0
      Width = 1
      Height = 30
      HelpContext = 1638005
      Brush.Style = bsClear
      Pen.Color = clSilver
      Pen.Style = psInsideFrame
    end
    object lblhint: TLabel
      AlignWithMargins = True
      Left = 2
      Top = 15
      Width = 178
      Height = 45
      HelpContext = 1638006
      Margins.Top = 0
      Margins.Right = 115
      Margins.Bottom = 0
      Anchors = [akLeft, akTop, akRight, akBottom]
      Caption = 
        'List was Synched at '#39'01-01-2018 10:00 AM.   Next Synch in  10 mi' +
        'nts'
      Color = 13487565
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlBottom
      WordWrap = True
    end
    object lblcheckPref: TLabel
      AlignWithMargins = True
      Left = 178
      Top = 16
      Width = 113
      Height = 15
      Cursor = crHandPoint
      HelpContext = 1638007
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Alignment = taCenter
      Anchors = [akRight, akBottom]
      Caption = '(Check Preferences)'
      Color = 13487565
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsUnderline]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      OnClick = lblcheckPrefClick
      ExplicitLeft = 99
      ExplicitTop = 14
    end
    object pbRequery: TAdvProgress
      AlignWithMargins = True
      Left = 4
      Top = 2
      Width = 287
      Height = 13
      HelpContext = 1638008
      Margins.Top = 1
      Margins.Bottom = 0
      Align = alTop
      BarColor = clNavy
      TabOrder = 0
      BkColor = clWindow
      Version = '1.2.0.0'
    end
  end
  object tmrCheckOrdersTrack: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = tmrCheckOrdersTrackTimer
    Left = 104
    Top = 3
  end
end
