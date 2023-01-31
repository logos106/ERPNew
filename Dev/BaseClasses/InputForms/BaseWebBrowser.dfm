inherited BaseWebBrowserGUI: TBaseWebBrowserGUI
  Left = 134
  Top = 288
  HelpContext = 39000
  Caption = 'DVA'
  ClientHeight = 530
  ClientWidth = 950
  ExplicitLeft = 134
  ExplicitTop = 288
  ExplicitWidth = 958
  ExplicitHeight = 557
  PixelsPerInch = 96
  TextHeight = 13
  inherited lblSkingroupMsg: TLabel
    Top = 530
    Width = 950
    ExplicitTop = 530
    ExplicitWidth = 950
    HelpContext = 39002
  end
  object WebBrowser: TWebBrowser [4]
    Left = 0
    Top = 0
    Width = 950
    Height = 530
    HelpContext = 39001
    Align = alClient
    TabOrder = 0
    OnNavigateError = WebBrowserNavigateError
    ControlData = {
      4C0000002F620000C73600000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
