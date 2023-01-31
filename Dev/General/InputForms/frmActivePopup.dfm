inherited frmActiveWindows: TfrmActiveWindows
  Left = 247
  Top = 235
  Width = 322
  Height = 170
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'Active Windows'
  Color = clWindow
  Constraints.MinHeight = 40
  Constraints.MinWidth = 50
  DefaultMonitor = dmMainForm
  FormStyle = fsStayOnTop
  PixelsPerInch = 96
  TextHeight = 13
  HelpContext = 225000
  object lbActiveWindows: TListBox
    Left = 0
    Top = 0
    Width = 314
    Height = 143
    Align = alClient
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 14
    ParentFont = False
    TabOrder = 0
    OnClick = lbActiveWindowsClick
    HelpContext = 225001
  end
end
