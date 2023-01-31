object TestItemFrame: TTestItemFrame
  Left = 0
  Top = 0
  Width = 581
  Height = 54
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  ParentFont = False
  TabOrder = 0
  DesignSize = (
    581
    54)
  object lblCaption: TLabel
    Left = 16
    Top = 16
    Width = 441
    Height = 19
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Caption = 'This is the test step caption'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
  end
  object Bevel1: TBevel
    Left = 0
    Top = 50
    Width = 581
    Height = 4
    Align = alBottom
    Shape = bsBottomLine
    ExplicitTop = 60
  end
  object btnResult: TBitBtn
    Left = 477
    Top = 10
    Width = 89
    Height = 30
    Anchors = [akTop, akRight]
    Caption = 'btnResult'
    DoubleBuffered = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 0
    OnClick = btnResultClick
  end
end
