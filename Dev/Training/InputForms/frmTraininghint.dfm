inherited fmERPHint: TfmERPHint
  Left = 1659
  Top = 162
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'fmERPHint'
  ClientWidth = 476
  Color = 5373951
  Position = poDefault
  PixelsPerInch = 96
  TextHeight = 13
  object lblTraining: TGradientLabel
    Left = 0
    Top = 0
    Width = 476
    Height = 183
    HelpContext = 388022
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
    Indent = 0
    LineWidth = 2
    Orientation = goHorizontal
    TransparentText = False
    VAlignment = vaTop
  end
  object Timer1: TTimer
    Interval = 250
    OnTimer = Timer1Timer
    Left = 88
    Top = 80
  end
end
