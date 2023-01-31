inherited fmBaseListtimerMsg: TfmBaseListtimerMsg
  Left = 514
  Top = 144
  BorderStyle = bsNone
  Caption = 'fmBaseListtimerMsg'
  ClientHeight = 234
  ClientWidth = 884
  TransparentColor = True
  TransparentColorValue = clWhite
  FormStyle = fsStayOnTop
  Position = poMainFormCenter
  ExplicitLeft = 514
  ExplicitTop = 144
  ExplicitWidth = 900
  ExplicitHeight = 273
  DesignSize = (
    884
    234)
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 1628002
  object Shape1: TShape [0]
    Left = 0
    Top = 0
    Width = 883
    Height = 234
    Anchors = [akLeft, akTop, akRight, akBottom]
    Brush.Style = bsClear
    ExplicitWidth = 919
    HelpContext = 1628003
  end
  inherited lblSkingroupMsg: TLabel
    Top = 198
    Width = 884
    ExplicitTop = 224
    ExplicitWidth = 975
    HelpContext = 1628004
  end
  object lblMsg: TLabel [5]
    AlignWithMargins = True
    Left = 6
    Top = 6
    Width = 872
    Height = 192
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Margins.Bottom = 0
    Align = alClient
    Alignment = taCenter
    Caption = 
      'Based on Report Tables Last Updated On   29th Septemper 2017 09:' +
      '00:00 am'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -43
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
    OnDblClick = lblMsgDblClick
    ExplicitWidth = 834
    ExplicitHeight = 98
    HelpContext = 1628005
  end
  object chkHideMsg: TCheckBox [6]
    AlignWithMargins = True
    Left = 6
    Top = 198
    Width = 872
    Height = 30
    Margins.Left = 6
    Margins.Top = 0
    Margins.Right = 6
    Margins.Bottom = 6
    Align = alBottom
    Caption = ' Do Not Show Again'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = chkHideMsgClick
    HelpContext = 1628006
  end
  object btnsynchreporttables: TDNMSpeedButton [7]
    Left = 681
    Top = 198
    Width = 192
    Height = 30
    Anchors = [akTop, akRight]
    Caption = 'btnsynchreporttables'
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
    ParentFont = False
    TabOrder = 1
    Visible = False
    AutoDisableParentOnclick = True
    OnClick = btnsynchreporttablesClick
    HelpContext = 1628007
  end
  object tmrReportTableMsg: TTimer
    Interval = 3000
    OnTimer = tmrReportTableMsgTimer
    Left = 200
    Top = 32
  end
end
