inherited frmSplashVideo: TfrmSplashVideo
  Left = 385
  Top = 242
  HelpContext = 1346002
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = []
  BorderStyle = bsNone
  ClientHeight = 567
  ClientWidth = 985
  Color = clWhite
  DefaultMonitor = dmDesktop
  Font.Height = -12
  Font.Name = 'Arial'
  FormStyle = fsStayOnTop
  OldCreateOrder = True
  Position = poScreenCenter
  ExplicitWidth = 985
  ExplicitHeight = 567
  PixelsPerInch = 96
  TextHeight = 15
  inherited lblSkingroupMsg: TLabel
    Top = 567
    Width = 985
    HelpContext = 1346003
    ExplicitTop = 573
    ExplicitWidth = 734
  end
  object Label1: TLabel [1]
    Left = 40
    Top = 504
    Width = 367
    Height = 19
    HelpContext = 1346004
    Caption = 'Copyright Madeurne Pty Ltd All Rights Reserved'
    Color = clSilver
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clSilver
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object Panel1: TPanel [5]
    Left = 0
    Top = 0
    Width = 985
    Height = 567
    HelpContext = 1346006
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 1
  end
  object MediaPlayer1: TMediaPlayer [6]
    Left = 5
    Top = 8
    Width = 29
    Height = 30
    HelpContext = 1346005
    VisibleButtons = [btPlay]
    AutoOpen = True
    DoubleBuffered = True
    Display = Panel1
    Visible = False
    ParentDoubleBuffered = False
    TabOrder = 0
  end
  inherited tmrProcessMessage: TTimer
    Left = 25
    Top = 11
  end
  inherited tmrdelay: TTimer
    Left = 152
    Top = 0
  end
  object Timer1: TTimer
    Interval = 100
    OnTimer = Timer1Timer
    Left = 29
    Top = 112
  end
end
