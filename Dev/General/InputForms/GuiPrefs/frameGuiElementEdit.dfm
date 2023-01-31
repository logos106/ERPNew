object frGuiElementEdit: TfrGuiElementEdit
  Left = 0
  Top = 0
  Width = 451
  Height = 304
  Align = alClient
  TabOrder = 0
  object lblMsg: TLabel
    Left = 0
    Top = 284
    Width = 451
    Height = 20
    Align = alBottom
    Alignment = taCenter
    AutoSize = False
    Caption = 'lblMsg'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -16
    Font.Name = 'Arial Narrow'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
    WordWrap = True
    ExplicitWidth = 42
  end
  object tmrProcessMessage: TTimer
    OnTimer = tmrProcessMessageTimer
    Left = 1
    Top = 3
  end
end
