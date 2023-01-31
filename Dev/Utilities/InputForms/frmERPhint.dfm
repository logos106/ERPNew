inherited fmERPHint: TfmERPHint
  Left = 442
  Top = 699
  HelpContext = 782001
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'fmERPHint'
  ClientHeight = 148
  ClientWidth = 984
  Color = 5373951
  Position = poDefault
  ExplicitLeft = 442
  ExplicitTop = 699
  ExplicitWidth = 1000
  ExplicitHeight = 187
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 148
    Width = 984
    HelpContext = 782002
    ExplicitTop = 148
    ExplicitWidth = 476
  end
  object lblTraining: TGradientLabel [3]
    Left = 0
    Top = 0
    Width = 984
    Height = 148
    HelpContext = 782003
    Align = alClient
    Alignment = taCenter
    AutoSize = False
    Caption = 'Chart Template List'
    Color = clCream
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Layout = tlCenter
    WordWrap = True
    ColorTo = clInfoBk
    EllipsType = etNone
    GradientType = gtFullVertical
    GradientDirection = gdLeftToRight
    Indent = 0
    LineWidth = 2
    Orientation = goHorizontal
    TransparentText = False
    VAlignment = vaTop
    Version = '1.1.1.0'
    ExplicitWidth = 476
    ExplicitHeight = 183
  end
  object Timer1: TTimer
    Interval = 250
    OnTimer = Timer1Timer
    Left = 88
    Top = 80
  end
end
