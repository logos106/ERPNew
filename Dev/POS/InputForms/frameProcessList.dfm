object frProcessList: TfrProcessList
  Left = 0
  Top = 0
  Width = 685
  Height = 303
  HelpContext = 600000
  VertScrollBar.Tracking = True
  Color = clWindow
  ParentColor = False
  TabOrder = 0
  OnResize = FrameResize
  object Timer: TTimer
    Enabled = False
    OnTimer = TimerTimer
    Left = 72
    Top = 32
  end
end
