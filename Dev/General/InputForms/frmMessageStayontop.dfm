inherited fmMessageStayontop: TfmMessageStayontop
  BorderStyle = bsNone
  Caption = 'fmMessageStayontop'
  ClientHeight = 270
  ClientWidth = 631
  Position = poMainFormCenter
  ExplicitWidth = 639
  ExplicitHeight = 297
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1347002
  inherited lblSkingroupMsg: TLabel
    Top = 270
    Width = 631
    HelpContext = 1347003
  end
  object Panel1: TPanel [3]
    Left = 0
    Top = 0
    Width = 631
    Height = 270
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alClient
    Color = clRed
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 248
    ExplicitTop = 40
    ExplicitWidth = 185
    ExplicitHeight = 41
    HelpContext = 1347004
    object pnlMain: TDNMPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 625
      Height = 264
      HelpContext = 1347005
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 3
      Color = 16777175
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      ExplicitLeft = 4
      ExplicitTop = 4
      ExplicitWidth = 623
      ExplicitHeight = 262
      object lblMessage: TLabel
        AlignWithMargins = True
        Left = 6
        Top = 6
        Width = 613
        Height = 231
        HelpContext = 1347006
        Align = alClient
        Alignment = taCenter
        Caption = 'Msg'
        Color = clFuchsia
        Font.Charset = ANSI_CHARSET
        Font.Color = clRed
        Font.Height = -29
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        OnDblClick = lblMessageDblClick
        ExplicitWidth = 54
        ExplicitHeight = 33
      end
      object lbltimer: TLabel
        AlignWithMargins = True
        Left = 6
        Top = 243
        Width = 613
        Height = 15
        HelpContext = 1347007
        Align = alBottom
        Alignment = taCenter
        Color = clMoneyGreen
        Font.Charset = ANSI_CHARSET
        Font.Color = 8421631
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        Transparent = True
        Layout = tlCenter
        WordWrap = True
        ExplicitWidth = 3
      end
    end
  end
  object MsgTimer: TTimer
    Enabled = False
    Interval = 500
    OnTimer = MsgTimerTimer
    Left = 104
    Top = 56
  end
end
